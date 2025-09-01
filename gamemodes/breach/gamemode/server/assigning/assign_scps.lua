
function assign_system.Assign_SCP049(ply)
	Pre_Assign(ply)
	ply:SetHealth(200)
	ply:SetMaxHealth(200)
	ply:SetArmor(0)
	ply:ApplyOutfit("scp_049")
	ply.cantChangeOutfit = true
	ply:Give("br_hands")
	ply.use049sounds = true
	ply.br_uses_hunger_system = false
	ply.canGetInfected = false
	ply.br_role = "SCP-049"
	ply.br_showname = "SCP-049"
	ply.br_customspawn = "SPAWNS_SCP_049"
	ply.Faction = "BR2_FACTION_SCP_049"

	ply.first_info = "scp_049"
	ply.mission_set = "scp_049"

	ply:SetNWString("CPTBase_NPCFaction", "BR2_FACTION_SCP_049")
	--if ply.support_spawning == false then
	--	ply.br_support_spawns = {{"scp_049_2", 1}}
	--end
	ply.br_support_team = SUPPORT_ROGUE
	Post_Assign(ply)
end


-- lua_run assign_system.Assign_SCP173(Entity(1))
function assign_system.Assign_SCP173(ply)
	Pre_Assign(ply)
	ply:SetHealth(20000)
	ply:SetMaxHealth(20000)
	ply:SetArmor(0)
	ply:ApplyOutfit("scp_173")
	ply.cantChangeOutfit = true
	ply:Give("weapon_scp_173")
	ply.use173behavior = true
	ply.br_uses_hunger_system = false
	ply.canGetInfected = false
	ply.br_usesSanity = false
	ply.br_usesTemperature = false
	ply.canStartBleeding = false
	ply.cantUseFlashlight = true
	ply.br_usesStamina = false
	ply.blinking_enabled = false
	ply.br_role = "SCP-173"
	ply.br_showname = "SCP-173"
	ply.br_customspawn = "SPAWNS_SCP_173"
	ply.Faction = "BR2_FACTION_SCP_173"

	ply.first_info = "scp_173"
	ply.mission_set = "scp_173"

	ply:SetNWString("CPTBase_NPCFaction", "BR2_FACTION_SCP_173")
	ply.br_support_team = SUPPORT_ROGUE

	ply:SetBloodColor(DONT_BLEED)

	Post_Assign(ply)
end

last_scp_assign = nil
function assign_system.Assign_SCP(ply)
	-- Alternate between SCP-049 and SCP-173 assignments for first SCP
	if last_scp_assign == nil then
		if math.random(1,2) == 1 then
			assign_system.Assign_SCP049(ply)
			last_scp_assign = "scp_049"
			print(ply, "was assigned SCP-049")
			return
		else
			assign_system.Assign_SCP173(ply)
			last_scp_assign = "scp_173"
			print(ply, "was assigned SCP-173")
			return
		end

	-- an SCP 049 was assigned, so assign SCP 173 next
	elseif last_scp_assign == "scp_049" then
		assign_system.Assign_SCP173(ply)
		last_scp_assign = "scp_173"
		print(ply, "was assigned SCP-173")
		return

	-- an SCP 173 was assigned, so assign SCP 049 next
	elseif last_scp_assign == "scp_173" then
		assign_system.Assign_SCP049(ply)
		last_scp_assign = "scp_049"
		print(ply, "was assigned SCP-049")
		return
	end
end
