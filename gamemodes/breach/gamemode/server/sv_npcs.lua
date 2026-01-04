
function BR_IsNPC(npc)
    return npc.Base == "drgbase_nextbot" or npc.Base == "npc_cpt_base"
    or string.find(npc:GetClass(), "npc_cpt_scp")
    or string.find(npc:GetClass(), "drg_")
    or string.find(npc:GetClass(), "dughoo_")
end

local function checkForPlayerSCP(npcclass)
	for k,v in pairs(player.GetAll()) do
		if v:Alive() and v:IsSpectator() == false then
            if (string.find(npcclass, "scp_173") or string.find(npcclass, "scp173")) and v.br_role == ROLE_SCP_173 then
                print("Not spawning SCP-173 because a player is SCP-173")
                return false
            end

            if (string.find(npcclass, "scp049") or string.find(npcclass, "scp_049"))
            and !(string.find(npcclass, "scp0492") or string.find(npcclass, "scp_049_2"))
            and v.br_role == ROLE_SCP_049
            then
                print("Not spawning SCP-049 because a player is SCP-049")
                return false
            end
		end
	end

    return true
end

npc_timer_num = 0
function BR_SpawnMapNPCTimer(npcclass, zone, in_time, lock_spawns)
    local player_check = checkForPlayerSCP(npcclass)
    if player_check == false then return false end

    local timer_name = "NPC_SPAWN_"..npcclass.."_"..npc_timer_num.."_TIMER"

	timer.Remove(timer_name)
	timer.Create(timer_name, in_time, 1, function()
		local npc = BR_SpawnMapNPC(npcclass, zone)

        if lock_spawns and IsValid(npc) and npc != false then
			npc.lockedNPCSpawns = zone
        end
	end)

    npc_timer_num = npc_timer_num + 1
end

function BR_SpawnMapNPC(npcclass, zone)
    if BR_DISABLE_NPCS[npcclass] then return false end

	print("Spawning " .. npcclass .. " in zone " .. tostring(zone))

	local all_players = {}

    local player_check = checkForPlayerSCP(npcclass)
    if player_check == false then return false end

	for k,v in pairs(ents.GetAll()) do
		if IsValid(v) and BR_IsNPC(v) then
			table.ForceInsert(all_players, v)
		end
	end

	local all_suitable_spawns = {}
	for pos_num,pos in ipairs(zone) do
		local pos_available = true
		local pos_points = 0
		for pl_num,pl in pairs(all_players) do
			local dist = pl:GetPos():Distance(pos)
			local trace = util.TraceLine({
				start = pl:GetPos(),
				endpos = pos,
				mask = MASK_SOLID,
				filter = pl
			})
			if dist < 700 and trace.Hit == false then
				pos_available = false
				break
			else
				pos_points = pos_points + dist
			end
		end
		if pos_available == true then
			table.ForceInsert(all_suitable_spawns, {pos, pos_points})
		end
	end
	/*
	local best_spawn = nil
	for k,v in pairs(all_suitable_spawns) do
		if best_spawn == nil or best_spawn[2] > v[2] then
			best_spawn = v
		end
	end
	*/
	local best_spawn = table.Random(all_suitable_spawns)

	if best_spawn != nil then
		local npc = ents.Create(npcclass)
		if IsValid(npc) then
			npc:SetPos(best_spawn[1])
			npc:Spawn()
			npc:Activate()
			return npc
		end
	end
	return false
end

local function CanOccupy(ent, pos)
    if not IsValid(ent) or not util.IsInWorld(pos) then return false end

    -- Trace the entity's own hull a tiny distance to see if it would collide at pos
    local tr = util.TraceEntity({
        start  = pos,
        endpos = pos + Vector(0, 0, 1),  -- small sweep to trigger hit detection
        mask   = MASK_NPCSOLID,
        filter = ent
    }, ent)

    if tr.Hit then return false end

    -- Optional: extra crowding check using an AABB around the OBB mins/maxs
    local mins, maxs = ent:OBBMins(), ent:OBBMaxs()
    for _, e in ipairs(ents.FindInBox(pos + mins, pos + maxs)) do
        if IsValid(e) and e != ent and (e:IsPlayer() or e:IsNPC() or e:GetSolid() != SOLID_NONE) then
            return false
        end
    end

    return true
end

-- Find ground at/near a point and return a slightly raised position
local function GroundedPos(ent, around)
    local tr = util.TraceLine({
        start  = around + Vector(0, 0, 64),
        endpos = around - Vector(0, 0, 2048),
        mask   = MASK_SOLID_BRUSHONLY,
        filter = ent
    })
    if tr.Hit then
        return tr.HitPos + Vector(0, 0, 2)
    end
end

-- Spiral search for a nearby free position the NPC can occupy
local function FindClearGroundPos(ent, origin, maxAttempts, step)
    maxAttempts = maxAttempts or 30
    step = step or 64

    -- Try origin first
    local cand = GroundedPos(ent, origin)
    if cand and CanOccupy(ent, cand) then return cand end

    -- Golden-angle spiral (nice coverage without repeats)
    local GA = 2.399963229728653
    for i = 1, maxAttempts do
        local radius = step * math.ceil(i / 6)
        local ang = i * GA
        local offset = Vector(math.cos(ang), math.sin(ang), 0) * radius
        local base = origin + offset

        cand = GroundedPos(ent, base)
        if cand and CanOccupy(ent, cand) then
            return cand
        end
    end
end

local function isVisible(pl, pos)
    local tr = util.TraceLine({
        start = pl:EyePos(),
        endpos = pos,
        mask = MASK_SOLID,
        filter = pl
    })
    return not tr.Hit
end

local nextTrack = 0
local nextNPCTeleport = 0
function TrackNPCs()
	if GetConVar("br2_enable_npcs"):GetBool() == false or
        round_system.current_scenario.disable_npc_spawning == true or
        !game_state == GAMESTATE_ROUND or
        CurTime() < nextNPCTeleport or
        CurTime() < nextTrack
    then return end

    nextTrack = CurTime() + 1

	local all_npcs = {}

	for k,ent in pairs(ents.GetAll()) do
		if IsValid(ent) and ent:Health() > 0 and ent.cannotTeleport != true and BR_IsNPC(ent) then
            local forbidden = false

            for forbiddenname, forbiddennamev in pairs(BR_NO_TELEPORT_NPCS) do
                if string.find(ent:GetClass(), forbiddenname) then
                    forbidden = true
                end
            end

            if !forbidden then
			    table.ForceInsert(all_npcs, ent)
            end
		end
	end

	for k,ent in pairs(all_npcs) do
        ent.nextNPCMove = ent.nextNPCMove or 0
        if CurTime() < ent.nextNPCMove then continue end

		-- Track if there are any players nearby, if not, move the npc closer to a position with players
		local player_nearby1 = false

		for _,pl in pairs(player.GetAll()) do
			if pl:Alive() and pl:IsSpectator() == false and pl:Team() != TEAM_SCP and
				(isVisible(pl, ent:GetPos()) or pl:GetPos():Distance(ent:GetPos()) < 900) then
				-- Player is nearby the NPC and can see it, so we don't need to move it
                --Entity(1):PrintMessage(HUD_PRINTTALK, tostring(ent) .. " is near " .. tostring(pl) .. ", not moving." .. CurTime() .. "")
                ent.nextNPCMove = CurTime() + 5
                player_nearby1 = true
			end
		end

        if player_nearby1 == true then continue end

		-- No players nearby, so we need to move the NPC
		local available_positions = {}

        local spawns = MAPCONFIG.RANDOM_NPC_SPAWNS

        if ent.lockedNPCSpawns then
            spawns = {MAPCONFIG[ent.lockedNPCSpawns]}
        end

		for _,pos_group in pairs(spawns) do
            for _,pos in pairs(pos_group) do
                if ent:GetPos():Distance(pos) > 700 then
                    local pos_available = true
                    local player_nearby = false

                    for _,npc2 in pairs(all_npcs) do
                        if npc2 != ent and npc2:GetPos():Distance(pos) < 400 then
                            pos_available = false
                            break
                        end
                    end

                    for _,pl in pairs(player.GetAll()) do
                        if pl:Alive() == true and pl:IsSpectator() == false and pl.br_team != TEAM_SCP then
                            local dist = pl:GetPos():Distance(pos)

                            if dist < 1000 then
                                player_nearby = true
                            end

                            if dist < 600 or isVisible(pl, pos) then
                                pos_available = false
                                break
                            end
                        end
                    end

                    if pos_available and player_nearby then
                        table.ForceInsert(available_positions, pos)
                    end
                end
            end
		end

		if #available_positions > 0 then
            ent.nextNPCMove = CurTime() + (GetBR2conVar("br2_npc_teleport_delay") or 45)  -- Cooldown before next move
            nextNPCTeleport = CurTime() + (GetBR2conVar("br2_npc_teleport_delay_global") or 45)  -- Global cooldown to avoid mass teleports

			local new_pos = table.Random(available_positions)
			local place = FindClearGroundPos(ent, new_pos, 30, 64)

            if place then
                ent:SetPos(place)
            else
                -- Fallback: try the raw spot and let DropToFloor help
                ent:SetPos(new_pos + Vector(0, 0, 8))
            end

			ent:DropToFloor()
			ent:SetAngles(Angle(0, math.random(0, 360), 0))
			--Entity(1):PrintMessage(HUD_PRINTTALK, "Moved " .. tostring(ent) .. " to a new position to be closer to players. (" .. tostring(new_pos) .. ")")
            print("Moved " .. tostring(ent) .. " to a new position to be closer to players. (" .. tostring(new_pos) .. ")")

            -- If this is a NextBot, clear any stuck state on its locomotion
            if ent.loco then
                ent.loco:ClearStuck()
            end
		end
	end
end
hook.Add("Tick", "MAP_NPC_TRACKER", TrackNPCs)

print("[Breach2] server/sv_npcs.lua loaded!")