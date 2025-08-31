
function assign_system.Assign_ContSpec(ply)
	Pre_Assign(ply)
	ply:ApplyOutfit("hazmat")
	ply:AllowFlashlight(true)
	ply:Give("br_hands")
	ply:Give("keycard_level2")
	ply.br_role = "Containment Specialist"
	ply.br_usesSanity = true
	ply.br_usesTemperature = true
	if ply.support_spawning == false then
		ply.br_support_spawns = {{"cont_spec", 1}, {"mtf", 1}}
	end
	ply.br_support_team = SUPPORT_FOUNDATION
	Post_Assign(ply)
	ply.DefaultWeapons = {"br_hands"}
	ply.canEscape = true
end

function assign_system.Assign_Researcher(ply)
	Pre_Assign(ply)
	ply:ApplyOutfit("scientist")
	ply:Give("br_hands")

	if ply.br_showname == "Gordon Freeman" then
		ply:Give("kanade_tfa_crowbar")
	end
	
	if ply.dont_assign_items == false then
		local rnd = math.random(1,100)
		if rnd < 15 then
			ply:Give("keycard_level2")
		elseif rnd < 60 then
			ply:Give("keycard_level1")
		end
	end

	ply.br_role = "Researcher"
	ply.br_usesSanity = true
	ply.br_usesTemperature = true
	if ply.support_spawning == false then
		ply.br_support_spawns = {{"researcher", 2}, {"mtf", 1}}
		ply.first_info = "researcher"
		ply.mission_set = "staff"
	end
	--ply:SetNWInt("br_support_team", SUPPORT_FOUNDATION)
	ply.br_support_team = SUPPORT_FOUNDATION
	Post_Assign(ply)
	ply.DefaultWeapons = {"br_hands"}
	ply.canEscape = true
end

function assign_system.Assign_MinorStaff(ply)
	local rnd = math.random(1,3)
	if rnd == 1 then
		assign_system.Assign_Doctor(ply)
	elseif rnd == 2 then
		assign_system.Assign_Janitor(ply)
	elseif rnd == 3 then
		assign_system.Assign_Engineer(ply)
	end
end

function assign_system.Assign_Engineer(ply)
	Pre_Assign(ply)
	ply:ApplyOutfit("engineer")
	ply:Give("br_hands")

	if ply.dont_assign_items == false then
		ply:Give("keycard_level1")
	end

	ply.br_role = "Engineer"
	ply.br_usesSanity = true
	ply.br_usesTemperature = true

	if ply.support_spawning == false then
		ply.br_support_spawns = {{"engineer", 2}, {"mtf", 1}}
		ply.first_info = "engineer"
		ply.mission_set = "staff"
	end

	ply.br_support_team = SUPPORT_FOUNDATION
	Post_Assign(ply)
	ply.DefaultWeapons = {"br_hands"}
	ply.canEscape = true
end

function assign_system.Assign_Janitor(ply)
	Pre_Assign(ply)
	ply:ApplyOutfit("janitor")
	ply:Give("br_hands")

	if ply.dont_assign_items == false then
		ply:Give("keycard_level1")
		local wep_rnd = math.random(1,100)
		if wep_rnd < 10 then
			ply:Give("kanade_tfa_crowbar")
		end
		if wep_rnd < 35 then
			ply:Give("item_gasmask")
		end
	end

	ply.br_role = "Janitor"
	ply.br_usesSanity = true
	ply.br_usesTemperature = true

	if ply.support_spawning == false then
		ply.br_support_spawns = {{"janitor", 2}, {"mtf", 1}}
		ply.first_info = "janitor"
		ply.mission_set = "staff"
	end

	--ply:SetNWInt("br_support_team", SUPPORT_FOUNDATION)
	ply.br_support_team = SUPPORT_FOUNDATION
	Post_Assign(ply)
	ply.DefaultWeapons = {"br_hands"}
	ply.canEscape = true
end

function assign_system.Assign_Doctor(ply)
	Pre_Assign(ply)
	ply:ApplyOutfit("medic")
	ply:Give("br_hands")

	if ply.dont_assign_items == false then
		ply:Give("keycard_level1")
		local wep_rnd = math.random(1,100)
		if wep_rnd < 70 then
			ply:Give("item_medkit")
		end
	end

	ply.br_role = "Doctor"
	ply.br_usesSanity = true
	ply.br_usesTemperature = true

	if ply.support_spawning == false then
		ply.br_support_spawns = {{"doctor", 2}, {"mtf", 1}}
		ply.first_info = "doctor"
		ply.mission_set = "staff"
	end

	--ply:SetNWInt("br_support_team", SUPPORT_FOUNDATION)
	ply.br_support_team = SUPPORT_FOUNDATION
	Post_Assign(ply)
	ply.DefaultWeapons = {"br_hands"}
	ply.canEscape = true
end

function assign_system.Assign_ISDagent(ply)
	Pre_Assign(ply)
	ply:ApplyOutfit("guard")
	ply.cantChangeOutfit = true
	ply:AllowFlashlight(true)
	ply:Give("br_hands")

	if ply.dont_assign_items == false then
		local wep_rnd = math.random(1,100)
		if wep_rnd < 31 then
			ply:Give("kanade_tfa_beretta")
		end
		ply:Give("item_radio")
		ply:Give("keycard_level3")
	end

	ply.br_role = "ISD Agent"
	ply.br_usesSanity = true
	ply.br_usesTemperature = true
	ply.getsPossibleTraitors = true

	if ply.support_spawning == false then
		ply.br_support_spawns = {{"mtf", 1}}
		ply.first_info = "isd_agent"
		ply.mission_set = "isd_agent"
	end

	--ply:SetNWInt("br_support_team", SUPPORT_FOUNDATION)
	ply.br_support_team = SUPPORT_CI
	Post_Assign(ply)
	ply.DefaultWeapons = {"br_hands"}
	ply.canEscape = false
end
