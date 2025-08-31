
function assign_system.Assign_Researcher_CI(ply)
	Pre_Assign(ply)
	ply:ApplyOutfit("scientist")
	ply:Give("br_hands")

	if ply.dont_assign_items == false then
		local rnd = math.random(1,100)
		if rnd < 20 then
			ply:Give("keycard_level2")
		elseif rnd < 65 then
			ply:Give("keycard_level1")
		end
	end

	ply.br_role = "Researcher"
	ply.br_usesSanity = true
	ply.br_usesTemperature = true
	ply.br_ci_agent = true

	if ply.support_spawning == false then
		ply.br_support_spawns = {{"mtf", 1}}
		ply.first_info = "ci_spy"
		ply.mission_set = "chaos_spies"
	end

	--ply:SetNWInt("br_support_team", SUPPORT_CI)
	ply.br_support_team = SUPPORT_CI
	Post_Assign(ply)
	ply.DefaultWeapons = {"br_hands"}
	ply.canEscape = true
end

function assign_system.Assign_SDofficer_CI(ply)
	Pre_Assign(ply)
	ply:PlayerSetSpeeds(DEF_SLOWWALKSPEED * 0.87, DEF_WALKSPEED * 0.87, DEF_RUNSPEED * 0.87)
	ply:ApplyOutfit("guard")
	ply.cantChangeOutfit = true
	ply:AllowFlashlight(true)
	ply:Give("br_hands")
	
	if ply.dont_assign_items == false then
		ply:Give("keycard_level3")

		for k,v in pairs(BR2_WEAPON_SETS.sd_officer.additional) do
			ply:Give(v)
		end

		local random_side = table.Random(BR2_WEAPON_SETS.sd_officer.side)
		ply:Give(random_side[1])
		ply:SetAmmo(random_side[3], random_side[2])

		local random_main = table.Random(BR2_WEAPON_SETS.sd_officer.main)
		ply:Give(random_main[1])
		ply:SetAmmo(random_main[3], random_main[2])
	end

	ply.br_role = "SD Officer"
	ply.br_usesTemperature = true
	ply.br_ci_agent = true

	if ply.support_spawning == false then
		ply.br_support_spawns = {{"mtf", 1}}
		ply.first_info = "ci_spy"
		ply.mission_set = "chaos_spies"
	end

	--ply:SetNWInt("br_support_team", SUPPORT_CI)
	ply.br_support_team = SUPPORT_CI
	Post_Assign(ply)
	ply.DefaultWeapons = {"br_hands"}
	ply.canEscape = false
end

function assign_system.Assign_CIsoldier(ply)
	Pre_Assign(ply)
	ply:PlayerSetSpeeds(DEF_SLOWWALKSPEED * 0.83, DEF_WALKSPEED * 0.83, DEF_RUNSPEED * 0.83)
	ply:ApplyOutfit("ci_soldier")
	ply.cantChangeOutfit = true
	ply:AllowFlashlight(true)
	ply:Give("br_hands")

	if ply.dont_assign_items == false then
		ply:Give("keycard_omni")

		for k,v in pairs(BR2_WEAPON_SETS.mtf_soldier.additional) do
			ply:Give(v)
		end

		local random_side = table.Random(BR2_WEAPON_SETS.mtf_soldier.side)
		ply:Give(random_side[1])
		ply:SetAmmo(random_side[3], random_side[2])

		local random_main = table.Random(BR2_WEAPON_SETS.mtf_soldier.main)
		ply:Give(random_main[1])
		ply:SetAmmo(random_main[3], random_main[2])
	end

	ply.br_role = "CI Soldier"
	ply.br_usesTemperature = true
	ply.br_uses_hunger_system = false
	ply.getsAllCIinfo = true

	if ply.support_spawning == false then
		ply.br_support_spawns = {{"mtf", 1}}
		ply.first_info = "ci_soldier"
		ply.mission_set = "chaos_soldiers"
	end

	--ply:SetNWInt("br_support_team", SUPPORT_CI)
	ply.br_support_team = SUPPORT_CI
	Post_Assign(ply)
	ply.DefaultWeapons = {"br_hands"}
	ply.canEscape = false
end
