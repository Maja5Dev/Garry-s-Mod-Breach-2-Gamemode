

net.Receive("br_mtf_teams_leave", function(len, ply)
	for k,v in pairs(BR2_MTF_TEAMS) do
		for k2,v2 in pairs(v) do
			if v2 == ply then
				table.RemoveByValue(v, ply)
				net.Start("br_mtf_teams_update")
					net.WriteTable(BR2_MTF_TEAMS)
				net.Send(ply)
				return
			end
		end
	end
end)

function br2_mtf_teams_check()
    for teamIndex, teamTable in pairs(BR2_MTF_TEAMS) do
        for i = #teamTable, 1, -1 do
            local pl = teamTable[i]
            if not IsValid(pl) or pl.br_downed == true or !pl:IsSpectator() then
                table.remove(teamTable, i)
				devprint("Removed invalid player from MTF team " .. teamIndex, pl)
            end
        end
    end
end


MTF_NEEDED_TO_SPAWN = 3

function MTF_GetEvacInfo()
	local evac_code = nil

	for k,v in pairs(MAPCONFIG.KEYPADS) do
		if v.evac_shelter then
			evac_code = v.code
			break
		end
	end

	return evac_code
end

function br2_mtf_teams_add(ply, num)
	if SafeFloatConVar("br2_time_mtf_spawn") > (CurTime() - br2_round_state_start) then
		ply:PrintMessage(HUD_PRINTTALK, "MTF Support Spawns will be available in " .. math.Round(SafeFloatConVar("br2_time_mtf_spawn") - (CurTime() - br2_round_state_start)) .. " seconds")
		return
	end

	local has_mtf_spawn = false
	for k,v in pairs(ply.br_support_spawns) do
		if v[1] == "mtf" and v[2] > 0 then
			has_mtf_spawn = true
			break
		end
	end

	if not has_mtf_spawn then
		ply:PrintMessage(HUD_PRINTTALK, "You do not have any MTF support spawns left")
		return
	end

	if (num == 1 or num == 2) and table.Count(BR2_MTF_TEAMS[num]) < MTF_NEEDED_TO_SPAWN and ply:IsSpectator() and ply.br_downed != true then
		local evac_code = MTF_GetEvacInfo()

		-- check for invalid players in teams
		br2_mtf_teams_check()

		-- remove from other teams
		for k,v in pairs(BR2_MTF_TEAMS) do
			for k2,pl in pairs(v) do
				if pl == ply then
					table.RemoveByValue(v, ply)
					break
				end
			end
		end

		-- add to the requested team
		if not table.HasValue(BR2_MTF_TEAMS[num], ply) then
			table.ForceInsert(BR2_MTF_TEAMS[num], ply)
		end

		-- if team is full, spawn them all, otherwise just update the team info
		if table.Count(BR2_MTF_TEAMS[num]) == MTF_NEEDED_TO_SPAWN then
			devprint("MTF Team " .. num .. " is ready to deploy")
			
			local all_mtfs = table.Copy(BR2_MTF_TEAMS[num])
			local existingMTFs = {}

			-- get spawn positions
			local all_possible_mtf_spawns = {}
			for mtf_spawn_group_k, mtf_spawn_group in pairs(MAPCONFIG.SPAWNS_MTF) do
				if mtf_spawn_group.available() then
					table.ForceInsert(all_possible_mtf_spawns, mtf_spawn_group)
				end
			end

			-- get existing mtfs, spawned before this
			for k2,v2 in pairs(player.GetAll()) do
				if v2:Alive() and !v2:IsSpectator() and (v2.br_role == "MTF Operative" or v2.br_team == TEAM_MTF) then
					table.ForceInsert(existingMTFs, v2)
				end
			end

			if table.Count(all_possible_mtf_spawns) == 0 then
				table.ForceInsert(all_possible_mtf_spawns, table.Random(MAPCONFIG.SPAWNS_MTF))
			end

			local mtf_spawn_tab = table.Random(all_possible_mtf_spawns)
			local mtf_spawns = table.Copy(mtf_spawn_tab.spawns)

			mtf_spawn_tab.func()

			-- Spawn them
			for plk, pl_mtf in pairs(all_mtfs) do
				-- decrease their spawn count
				for k,v in pairs(pl_mtf.br_support_spawns) do
					if v[1] == "mtf" and v[2] > 0 then
						v[2] = v[2] - 1
					end
				end

				pl_mtf.br_team = TEAM_MTF
				pl_mtf:SendLua("BR_ClearMenus()")

				pl_mtf.charid = BR_GetUniqueCharID()
				pl_mtf:SetNWInt("BR_CharID", pl_mtf.charid)

				assign_system.Assign_MTF_NTF(pl_mtf)
				pl_mtf.br_team = TEAM_MTF

				local spawn = table.Random(mtf_spawns)
				pl_mtf:SetPos(spawn)

				table.ForceInsert(pl_mtf.br_special_items, {class="flashlight_tactical"})

				if IsValid(pl_mtf.Body) then
					pl_mtf.Body.Info.Victim = nil
				end

				-- Assign a new notepad and send the info from start of the round
				notepad_system.AssignNewNotepad(pl_mtf, false)

				for k_info, info in pairs(BR2_MTF_STARTING_INFORMATION) do
					notepad_system.AddPlayerInfo(pl_mtf, info.br_showname, info.br_role, info.br_team, info.br_ci_agent, info.health, info.isscp, nil, nil)
				end

				local login, password = BR2_GenerateTerminalAuth(pl_mtf)
				notepad_system.AddAutomatedInfo(pl_mtf, "personal terminal account:\n - login: " .. login .. "\n - password: " .. password .. "\n")
				
				table.RemoveByValue(mtf_spawns, spawn)
			end

			-- Send info so they know eachother
			for k_mtf1,mtf1 in pairs(all_mtfs) do
				for k_mtf2,mtf2 in pairs(all_mtfs) do
					if mtf1 != mtf2 then
						notepad_system.AddPlayerInfo(mtf1, mtf2.br_showname, mtf2.br_role, mtf2.br_team, false, HEALTH_ALIVE, false, mtf2.charid, mtf2)
					end
				end

				for k2,v2 in pairs(existingMTFs) do
					notepad_system.AddPlayerInfo(mtf1, v2.br_showname, v2.br_role, v2.br_team, false, HEALTH_ALIVE, false, v2.charid, v2)
				end

				if evac_code != nil then
					notepad_system.AddAutomatedInfo(mtf1, "evacuation code:  " .. evac_code)
				end

				notepad_system.UpdateNotepad(mtf1)

				timer.Simple(0.5, function()
					net.Start("br_update_own_info")
						net.WriteString(mtf1.br_showname)
						net.WriteString(mtf1.br_role)
						net.WriteInt(mtf1.br_team or TEAM_MTF, 8)
						net.WriteBool(false)
						net.WriteBool(false)
					net.Send(mtf1)

					BroadcastPlayerInfo(mtf1)
				end)
			end
			
			if round_system.AlreadyAnnouncedMTF == false then
				BroadcastLua('surface.PlaySound("breach2/mtf/Announc.ogg")')
				round_system.AlreadyAnnouncedMTF = true
			end

			net.Start("br_mtf_team_ready")
				--net.WriteTable({scps_alive = 0})
				-- TEAM NAME
				-- TEAM MEMBER NAMES
				-- NUMBER OF SCPS ALIVE
			net.Send(BR2_MTF_TEAMS[num])
			
			BR2_MTF_TEAMS[num] = {}
		else
			net.Start("br_mtf_teams_update")
				net.WriteTable(BR2_MTF_TEAMS)
			net.Send(ply)
		end

		ply:PrintMessage(HUD_PRINTTALK, "You have joined MTF Team " .. num)
		return true
	end
	
	ply:PrintMessage(HUD_PRINTTALK, "For some reason you could not join this team")
	print("br2_mtf_teams_add failed for " .. ply:Nick() .. ", num: " .. tostring(num))
	print("Conditions: ", (num == 1 or num == 2), table.Count(BR2_MTF_TEAMS[num]) < MTF_NEEDED_TO_SPAWN, ply:IsSpectator(), ply.br_downed != true)
end

function br2_mtf_teams_remove(ply)
	br2_mtf_teams_check()

	for k,v in pairs(BR2_MTF_TEAMS) do
		for k2, pl in pairs(v) do
			if pl == ply then
				table.RemoveByValue(v, ply)
				break
			end
		end
	end
end

function br2_mtf_teams_reset()
	BR2_MTF_TEAMS = {
		{},
		{},
		{},
		{}
	}
end

br2_mtf_teams_reset()

net.Receive("br_mtf_teams_join", function(len, ply)
	local num = net.ReadInt(8)
	br2_mtf_teams_add(ply, num)
end)

net.Receive("br_mtf_teams_update", function(len, ply)
	--if ply.next_mtf_team_update < CurTime() then
		net.Start("br_mtf_teams_update")
			net.WriteTable(BR2_MTF_TEAMS)
		net.Send(ply)
	--	ply.next_mtf_team_update = CurTime() + 1
	--end
end)

local function teleportToSpawnpoint(ply)
	if istable(ply.br_spawn_groups) then
		local all_possible_spawns = {}

		for k,pos in pairs(ply.br_spawn_groups) do
			local pos_available = true

			for k2,pl in pairs(player.GetAll()) do
				local trace = util.TraceLine({
					start = pl:GetPos(),
					endpos = pos,
					mask = MASK_SOLID,
					filter = pl
				})

				if trace.HitPos == pos then
					pos_available = false
				end
			end
			
			if pos_available == true then
				table.ForceInsert(all_possible_spawns, pos)
			end
		end

		ply:SetPos(table.Random(all_possible_spawns))
	end
end

function default_support_spawn_human(ply)
	ply:SetHealth(20)

	ply.br_times_support_respawned = ply.br_times_support_respawned + 1
	for i=1, math.Clamp(ply.br_times_support_respawned, 0, 3) do
		ply.br_sanity = ply.br_sanity - 20
	end

	ply.charid = BR_GetUniqueCharID()
	ply:SetNWInt("BR_CharID", ply.charid)

	teleportToSpawnpoint(ply)

	notepad_system.AssignNewNotepad(ply, false)
	notepad_system.UpdateNotepad(ply)
end

net.Receive("br_support_spawn", function(len, ply)
	if ply:IsSpectator() and CurTime() - ply.DeathTime > 30 then
		local support_spawn = net.ReadString()

		for k,v in pairs(ply.br_support_spawns) do
			if v[1] == support_spawn then
				if v[2] > 0 then
					v[2] = v[2] - 1
					devprint(ply:Nick() .. " support spawned")
					ply:SendLua('surface.PlaySound("breach2/save3.ogg")')
					ply.support_spawning = true
					ply.br_times_support_respawned = ply.br_times_support_respawned + 1
					ply.retrievingNotes = false

					if support_spawn == "researcher" then
						ply.dont_assign_items = true
						assign_system.Assign_Researcher(ply)
						ply.br_team = TEAM_RESEARCHER
						default_support_spawn_human(ply)
						ply:Give("keycard_level1")
			
					elseif support_spawn == "class_d" then
						ply.dont_assign_items = true
						ply.retrievingNotes = false
						assign_system.Assign_ClassD(ply)
						ply.br_team = TEAM_CLASSD
						default_support_spawn_human(ply)

					elseif support_spawn == "scp_049_2" then
						ply.br_spawn_groups = table.Copy(MAPCONFIG)["SPAWNS_HCZ"]
						ply.dont_assign_items = true
						ply.retrievingNotes = false
						assign_system.Assign_SCP0492(ply)
						ply.br_team = TEAM_SCP
						teleportToSpawnpoint(ply)
						ply.charid = BR_GetUniqueCharID()
						ply:SetNWInt("BR_CharID", ply.charid)

					elseif support_spawn == "doctor" then
						ply.dont_assign_items = true
						ply.retrievingNotes = false
						assign_system.Assign_Doctor(ply)
						ply.br_team = TEAM_MINORSTAFF
						default_support_spawn_human(ply)

					elseif support_spawn == "janitor" then
						ply.dont_assign_items = true
						ply.retrievingNotes = false
						assign_system.Assign_Janitor(ply)
						ply.br_team = TEAM_MINORSTAFF
						default_support_spawn_human(ply)

					elseif support_spawn == "explorer" then
						ply.dont_assign_items = false
						ply.retrievingNotes = false
						assign_system.Assign_ClassD9341(ply)
						ply.br_team = TEAM_CLASSD
						default_support_spawn_human(ply)
						ply:Give("keycard_omni")
						ply:Give("item_nvg_military")
						ply:Give("kanade_tfa_mp5k")
						ply:Give("kanade_tfa_glock")
						ply:Give("kanade_tfa_rpg")
						ply:SetAmmo(120, "pistol")
						ply:SetAmmo(360, "smg1")
					end

					if support_spawn != "explorer" then
						ply:AddSanity(-10 * ply.br_times_support_respawned)
					end

					ply:AddRunStamina(-10000)
					ply:SetFOV(160, 0)
					ply:SetFOV(DEF_FOV, 2)
					ply.support_spawning = false

					hook.Call("BR2_SupportSpawned", GAMEMODE, ply)

					for k2,mtf_team in pairs(BR2_MTF_TEAMS) do
						for k3,mtf in pairs(mtf_team) do
							if mtf == ply then
								table.RemoveByValue(mtf_team, ply)
							end
						end
					end
				else
					return
				end

				return
			end
		end
	end
end)

print("[Breach2] server/networking/net_supports.lua loaded!")

