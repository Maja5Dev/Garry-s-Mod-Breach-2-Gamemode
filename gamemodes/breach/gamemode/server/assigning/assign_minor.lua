
function assign_system.Assign_ContSpec(ply)
	Pre_Assign(ply)
	ply:ApplyOutfit("hazmat")
	ply:Give("br_hands")
	
	ply:AllowFlashlight(true)

	if ply.dont_assign_items == false then
		ply:Give("keycard_level1")
	end
	
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
		ply:Give("keycard_level2")
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

local last_minorstaff_assign = nil
function assign_system.Assign_MinorStaff(ply)
	local rnd = math.random(1,2)
	local possible = {}

	if last_minorstaff_assign != "doctor" then
		table.ForceInsert(possible, "doctor")
	end
	if last_minorstaff_assign != "janitor" then
		table.ForceInsert(possible, "janitor")
	end
	if last_minorstaff_assign != "engineer" then
		table.ForceInsert(possible, "engineer")
	end
	if last_minorstaff_assign != "contspec" and rnd == 2 then
		table.ForceInsert(possible, "contspec")
	end

	local rnd_role = table.Random(possible)

	if rnd_role == "doctor" then
		assign_system.Assign_Doctor(ply)
		last_minorstaff_assign = "doctor"

	elseif rnd_role == "janitor" then
		assign_system.Assign_Janitor(ply)
		last_minorstaff_assign = "janitor"

	elseif rnd_role == "engineer" then
		assign_system.Assign_Engineer(ply)
		last_minorstaff_assign = "engineer"

	elseif rnd_role == "contspec" then
		assign_system.Assign_ContSpec(ply)
		last_minorstaff_assign = "contspec"
	end
end

function assign_system.Assign_Engineer(ply)
	Pre_Assign(ply)
	ply:ApplyOutfit("engineer")
	ply:Give("br_hands")

	ply:AllowFlashlight(true)

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

	ply:AllowFlashlight(true)

	if ply.dont_assign_items == false then
		ply:Give("keycard_level1")
		ply:Give("item_gasmask")
	end

	ply.br_role = "Janitor"
	ply.br_usesSanity = true
	ply.br_usesTemperature = true
	--ply.br_customspawn = "SPAWNS_HCZ"

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
		ply:Give("item_medkit")
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
