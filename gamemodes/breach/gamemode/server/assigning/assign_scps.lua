
-- lua_run assign_system.Assign_SCP035(Entity(1))

function assign_system.Assign_SCP035(ply)
	Pre_Assign(ply)
	ply.cantChangeOutfit = true
	ply:Give("br_hands")
	ply.br_role = "SCP-035"
	ply.Faction = "BR2_FACTION_SCP_035"
	ply:AddFlags(FL_NOTARGET)
	ply:SetHealth(240)
	ply:SetMaxHealth(240)
	ply.br_usesSanity = false

	ply.first_info = "scp_035"
	ply.mission_set = "scp_035"

	ply.br_customspawn = "SPAWNS_SCP_035"

	local rnd = math.random(1, 5)
	if rnd == 1 then
		ply:ApplyOutfit("class_d")
		ply.br_showname = "D-" ..math.random(1,9)..math.random(0,9)..math.random(0,9)..math.random(0,9) .. ""
		ply.br_special_items = {
			{class = "document", name = "Class D Leaflet", type = "doc_leaflet", attributes = {doc_code = ply.br_showname}}
		}

	elseif rnd == 2 then
		ply:ApplyOutfit("scientist")
		ply:Give("keycard_level2")
		if ply.br_showname == "Gordon Freeman" then
			ply:Give("kanade_tfa_crowbar")
		end
		
	elseif rnd == 3 then
		ply:ApplyOutfit("janitor")
		ply:Give("keycard_level1")
		ply:Give("item_gasmask")
		ply:AllowFlashlight(true)
		
	elseif rnd == 4 then
		ply:ApplyOutfit("engineer")
		ply:Give("keycard_level1")
		ply:AllowFlashlight(true)
		
	elseif rnd == 5 then
		ply:ApplyOutfit("medic")
		ply:Give("keycard_level1")
		ply:Give("item_medkit")
	end

	ply:SetNWString("CPTBase_NPCFaction", "BR2_FACTION_SCP_035")
	if ply.support_spawning == false then
		ply.br_support_spawns = {{"scp_049_2", 1}, {"mtf", 1}}
	end
	ply.br_support_team = SUPPORT_ROGUE
	Post_Assign(ply)

	ply:AddAttachmentModel({
		model = "models/scp_035_real/scp_035_real.mdl",
		--bone = "ValveBiped.Bip01_Head1",
        attachment = "eyes",
        offset = Vector(0, 1.6, -1.3),
        angOffset = Angle(6, 0, 0)
	})
end


function assign_system.Assign_SCP049(ply)
	ply.br_role = "SCP-049"
	Pre_Assign(ply)
	ply:SetHealth(1300)
	ply:SetMaxHealth(1300)
	ply:SetArmor(0)
	ply:ApplyOutfit("scp_049")
	ply.cantChangeOutfit = true
	ply:Give("br_hands")
	ply:Give("keycard_level4")
	ply.use049sounds = true
	ply.br_uses_hunger_system = false
	ply.br_usesSanity = false
	ply.can_get_infected = false
	ply.br_role = "SCP-049"
	ply.br_showname = "SCP-049"
	ply.br_customspawn = "SPAWNS_SCP_049"
	ply.Faction = "BR2_FACTION_SCP_049"
	ply:AddFlags(FL_NOTARGET)
	ply.br_usesStamina = false

	ply.first_info = "scp_049"
	ply.mission_set = "scp_049"

	ply:SetNWString("CPTBase_NPCFaction", "BR2_FACTION_SCP_049")
	if ply.support_spawning == false then
		ply.br_support_spawns = {{"scp_049_2", 1}, {"mtf", 1}}
	end
	ply.br_support_team = SUPPORT_ROGUE
	Post_Assign(ply)
	ply.br_role = "SCP-049"
end


-- lua_run assign_system.Assign_SCP173(Entity(1))
function assign_system.Assign_SCP173(ply)
	Pre_Assign(ply)
	ply:SetHealth(8000)
	ply:SetMaxHealth(8000)
	ply:SetArmor(0)
	ply:ApplyOutfit("scp_173")
	ply.cantChangeOutfit = true
	ply:Give("weapon_scp_173")
	ply.use173behavior = true
	ply.br_uses_hunger_system = false
	ply.can_get_infected = false
	ply.br_usesSanity = false
	ply.br_usesTemperature = false
	ply.canStartBleeding = false
	ply.cantUseFlashlight = true
	ply.br_usesStamina = false
	ply.blinking_enabled = false
	ply.disable_coughing = true
	ply.br_role = "SCP-173"
	ply.br_showname = "SCP-173"
	ply.br_customspawn = "SPAWNS_SCP_173"
	ply.Faction = "BR2_FACTION_SCP_173"
	ply:AddFlags(FL_NOTARGET)
	ply:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)
	ply:SetCustomCollisionCheck(true)

	ply.first_info = "scp_173"
	ply.mission_set = "scp_173"

	ply:SetNWString("CPTBase_NPCFaction", "BR2_FACTION_SCP_173")
	if ply.support_spawning == false then
		ply.br_support_spawns = {{"scp_049_2", 1}, {"mtf", 1}}
	end
	ply.br_support_team = SUPPORT_ROGUE

	ply:SetBloodColor(DONT_BLEED)

	Post_Assign(ply)
end

local function FindClearSpawnPos(origin, ragdoll, ply, healer, radius, step, max_attempts)
    step = step or 15
    radius = radius or 80
    max_attempts = max_attempts or math.floor(360 / step)

	origin = healer:GetPos()

    for i = 0, max_attempts - 1 do
        local dir = Angle(0, i * step, 0):Forward()
        local endpos = origin + dir * radius

        local tr = util.TraceLine({
            start = origin,
            endpos = endpos,
            filter = {ply, healer}
        })

        local tr_hull = util.TraceHull({
            start = tr.HitPos,
            endpos = tr.HitPos + Vector(0, 0, 30), -- upward clearance
            mins = ply:OBBMins(),
            maxs = ply:OBBMaxs(),
            filter = ply
        })

        if tr_hull.Hit == false then
            return tr.HitPos
        end
    end

    return origin -- fallback
end

local function shared0492assign(ply)
	ply.br_team = TEAM_SCP
	ply.use173behavior = true
	ply.br_uses_hunger_system = false
	ply.can_get_infected = false
	ply.br_usesSanity = false
	ply.br_usesTemperature = false
	ply.canStartBleeding = false
	ply.cantUseFlashlight = true
	ply.br_usesStamina = false
	ply.disable_coughing = true
	ply.cantChangeOutfit = true

	ply.br_role = "SCP-049-2"
	ply.br_showname = "SCP-049-2"

	ply.Faction = "BR2_FACTION_SCP_049"
	ply:AddFlags(FL_NOTARGET)
end

local player_meta = FindMetaTable("Player")
function player_meta:UnDownPlayerAsZombie(healer)
	if self.Body == nil then
		error("Body in UnDownPlayerAsZombie is nil " .. self.br_team .. " " .. self.br_role)
	end

	self.DefaultWeapons = {"weapon_scp_049_2"}
	self.br_special_items = table.Copy(self.Body.Info.Loot)
	self.Body.Info.Loot = {}

	local rag_pos = self.Body:GetPos()
	local lpi = self.lastPlayerInfo

	if not lpi and self.backupLastPlayerInfo then
		lpi = self.backupLastPlayerInfo
	end

	if lpi then
		lpi.PlayerTeam = TEAM_ALIVE
		lpi.BreachRole = "SCP-049-2"
		lpi.PlayerHealth = 200
		lpi.PlayerMaxHealth = 200
		lpi.PlayerWalkSpeed = 100
		lpi.PlayerRunSpeed = 180
		lpi.PlayerJumpPower = 170
		lpi.BreachCIAgent = false
		lpi.BreachIsBleeding = false
		self:ApplyPlayerInfo(lpi)
	end

	net.Start("br_update_own_info")
		net.WriteString(self.br_showname)
		net.WriteString(lpi.BreachRole)
		net.WriteInt(TEAM_ALIVE, 8)
		net.WriteBool(false)
		net.WriteBool(true)
	net.Send(self)

	self:Freeze(false)
	self:SetMoveType(MOVETYPE_WALK)
	self:SetNoDraw(false)
	self:UnSpectate()
	self:Spawn()

	shared0492assign(self)

	local spawn_pos = FindClearSpawnPos(rag_pos, self.Body, self, healer, 80, 10, 120)
	self:SetPos(spawn_pos)
	
	if IsValid(self.Body) then
		self.Body:Remove()
	end
	self.br_downed = false
	self.lastPlayerInfo = nil

	ply.br_support_spawns = {{"scp_049_2", 1}}
	ply:UpdateSupportSpawns()
end

function assign_system.Assign_SCP0492(ply)
	Pre_Assign(ply)
	ply:SetHealth(400)
	ply:SetMaxHealth(400)
	ply:SetArmor(0)
	ply:ApplyOutfit("scp_0492")
	ply:Give("weapon_scp_049_2")

	shared0492assign(ply)

	ply.br_customspawn = "SPAWNS_HCZ"

	ply:SetNWString("CPTBase_NPCFaction", "BR2_FACTION_SCP_049")
	ply.br_support_team = SUPPORT_ROGUE

	Post_Assign(ply)
end


last_scp_assign = nil
function assign_system.Assign_SCP(ply)
	-- Alternate between SCP-049 and SCP-173 assignments for first SCP
	if last_scp_assign == nil then
		if math.random(1,2) == 1 then
			assign_system.Assign_SCP049(ply)
			last_scp_assign = "scp_049"
			return
		else
			assign_system.Assign_SCP173(ply)
			last_scp_assign = "scp_173"
			return
		end

	-- an SCP 049 was assigned, so assign SCP 173 next
	elseif last_scp_assign == "scp_049" then
		assign_system.Assign_SCP173(ply)
		last_scp_assign = "scp_173"
		return

	-- an SCP 173 was assigned, so assign SCP 049 next
	elseif last_scp_assign == "scp_173" then
		assign_system.Assign_SCP049(ply)
		last_scp_assign = "scp_049"
		return
	end
end


-- so far only 2 SCPs so we use this simple thing
function assign_system.Assign_SCP_Unkillable(ply)
	assign_system.Assign_SCP173(ply)
end

function assign_system.Assign_SCP_Killable(ply)
	assign_system.Assign_SCP049(ply)
end
