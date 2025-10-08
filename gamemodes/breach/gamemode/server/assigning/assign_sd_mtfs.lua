
function assign_system.Assign_SDofficer(ply)
	Pre_Assign(ply)
	ply:PlayerSetSpeeds(DEF_SLOWWALKSPEED * 0.87, DEF_WALKSPEED * 0.87, DEF_RUNSPEED * 0.87)
	ply:ApplyOutfit("guard")
	ply.cantChangeOutfit = true

	ply:AllowFlashlight(true)

	ply:Give("br_hands")

	if ply.dont_assign_items == false then
		ply:Give("keycard_level3")
		ply:Give("kanade_tfa_stunbaton")

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

	ply.br_role = ROLE_SD_OFFICER
	ply.br_usesSanity = true
	ply.br_usesTemperature = true

	if ply.support_spawning == false then
		ply.br_support_spawns = {{"mtf", 1}}
		ply.first_info = "sd_officer"
		ply.mission_set = "guard"
	end

	--ply:SetNWInt("br_support_team", SUPPORT_FOUNDATION)
	ply.br_support_team = SUPPORT_FOUNDATION
	Post_Assign(ply)
	ply.DefaultWeapons = {"br_hands"}
	ply.canEscape = false
end

function assign_system.Assign_SDofficerLight(ply)
	Pre_Assign(ply)
	ply:PlayerSetSpeeds(DEF_SLOWWALKSPEED * 0.87, DEF_WALKSPEED * 0.87, DEF_RUNSPEED * 0.87)
	ply:ApplyOutfit("guard")
	ply.cantChangeOutfit = true

	ply:AllowFlashlight(true)

	ply:Give("br_hands")

	if ply.dont_assign_items == false then
		ply:Give("keycard_level3")
		ply:Give("kanade_tfa_stunbaton")

		for k,v in pairs(BR2_WEAPON_SETS.sd_officer.additional) do
			ply:Give(v)
		end

		local random_side = table.Random(BR2_WEAPON_SETS.sd_officer_light.side)
		ply:Give(random_side[1])
		ply:SetAmmo(random_side[3], random_side[2])
	end

	ply.br_role = ROLE_SD_OFFICER
	ply.br_usesSanity = true
	ply.br_usesTemperature = true

	if ply.support_spawning == false then
		ply.br_support_spawns = {{"mtf", 1}}
		ply.first_info = "sd_officer"
		ply.mission_set = "guard"
	end

	--ply:SetNWInt("br_support_team", SUPPORT_FOUNDATION)
	ply.br_support_team = SUPPORT_FOUNDATION
	Post_Assign(ply)
	ply.DefaultWeapons = {"br_hands"}
	ply.canEscape = false
end

function assign_system.Assign_MTF_NTF(ply)
	Pre_Assign(ply)

	ply:PlayerSetSpeeds(DEF_SLOWWALKSPEED * 0.85, DEF_WALKSPEED * 0.85, DEF_RUNSPEED * 0.85)
	ply:ApplyOutfit("mtf")
	ply.cantChangeOutfit = true

	ply:AllowFlashlight(true)

	ply:Give("br_hands")

	if ply.dont_assign_items == false then
		ply:Give("keycard_level4")
		ply:Give("kanade_tfa_stunbaton")

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

	ply.br_role = ROLE_MTF_OPERATIVE
	ply.br_usesTemperature = true
	ply.br_uses_hunger_system = false
	ply.canContain173 = true

	if ply.support_spawning == false then
		ply.br_support_spawns = {{"mtf", 1}}
	end

	--ply:SetNWInt("br_support_team", SUPPORT_FOUNDATION)
	ply.br_support_team = SUPPORT_FOUNDATION

	Post_Assign(ply)
	
	ply.DefaultWeapons = {"br_hands"}
	ply.canEscape = false
end
