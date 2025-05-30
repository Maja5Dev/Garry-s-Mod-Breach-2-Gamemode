
function Pre_Assign(ply)
	ply:UnSpectatePlayer(false)
	ply:SetViewEntity(ply)
	ply:StripPlayer()
	ply:SetTeam(TEAM_ALIVE)
	ply:SetHealth(100)
	ply:SetMaxHealth(100)
	ply:SetArmor(0)
	ply:PlayerSetSpeeds(DEF_SLOWWALKSPEED, DEF_WALKSPEED, DEF_RUNSPEED)
	ply:SetJumpPower(DEF_JUMPPOWER)
	ply:SetSuppressPickupNotices(true)
	ply.DefaultJumpPower = DEF_JUMPPOWER
	ply:AllowFlashlight(false)
	ply.br_showname = GetRandomName()
	ply.br_hands = nil
	ply.br_customspawn = nil
	ply.br_special_items = {}
	ply.br_role = "Unknown"
	ply.br_ci_agent = false
	ply.br_downed = false
	ply.br_zombie = false

	ply.br_sanity = 100
	ply.br_hunger = 100
	ply.br_thirst = 100
	ply.br_temperature = 0
	ply.br_infection = 0
	ply.br_speed_boost = 0
	ply.br_isBleeding = false
	ply.br_isInfected = false
	ply.br_asymptomatic = false

	ply.br_uses_hunger_system = true
	ply.br_usesSanity = false
	ply.br_usesStamina = true
	ply.br_usesTemperature = false
	ply.canStartBleeding = true
	ply.canGetInfected = true
	ply.getsPossibleTraitors = false
	ply.canEscape = true
	ply.use049sounds = false
	ply.use173behavior = false
	ply.canContain173 = false
	ply.getsAllCIinfo = false

	ply.DefaultWeapons = {}
	ply:SetBloodColor(BLOOD_COLOR_RED)
	ply:SetCanZoom(false)
	ply:BR_SetColor(Color(255,255,255,255))
	ply:SetGravity(1)
	ply:SetLadderClimbSpeed(75)
	ply:SetFOV(DEF_FOV, 0)
	ply:SetNoTarget(false)
	ply:SetCrouchedWalkSpeed(0.5)
	ply:SetUnDuckSpeed(0.5)
	ply:SetDuckSpeed(0.3)
	ply:ResetHull()
	ply:SetNWBool("br_is_reviving", false)
	ply.retrievingNotes = false
	ply.flashlightEnabled = false
	ply.isTheOne = false
	ply.is_hiding_in_closet = nil
	ply.startedLockpicking = nil
	ply.lastSentCode = nil
	ply.viewing895 = false
	ply.cantUseFlashlight = false
	ply.cantChangeOutfit = false
	ply.isblinking = false
	ply.blinking_enabled = true

	ply.nextBreath = 0
	ply.NextCough = 0
	ply.nextDamageInGas = 0
	ply.next049Breath = 0
	ply.next_hsd = 0
	ply.next_iup1 = 0
	ply.next_iup2 = 0
	ply.nextTemperatureCheck = 0
	ply.nextTemperatureDamage = 0
	ply.next_hunger_update = CurTime() + 1
	ply.next_hunger = CurTime() + 30
	ply.next_thirst = CurTime() + 30
	ply.next_health_update = 0
	ply.next_revive_update = 0
	ply.next895dmg = 0
	ply.nextFlashlightUse = 0
	ply.nextJumpStaminaCheck =  0
	ply.nextRunStaminaCheck =  0
	ply.lastRunning = 0
	ply.seen_173 = 0

	if IsValid(ply.flashlight3d) then
		ply.flashlight3d:Remove()
	end

	if ply.support_spawning == false then
		ply.br_support_spawns = {}
		ply.br_support_team = SUPPORT_NONE
	end
	ply.br_times_support_respawned = 0

	br2_mtf_teams_remove(ply)

	ply:Reset_SNPC_Stuff()
end

function Post_Assign(ply)
	ply:SetupHands()
	net.Start("br_update_own_info")
		net.WriteString(ply.br_showname)
		net.WriteString(ply.br_role)
		net.WriteBool(ply.br_ci_agent)
		net.WriteBool(ply.br_zombie)
	net.Send(ply)
	ply.dont_assign_items = false
	ply.support_spawning = false
end
assign_system = {}

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
	ply:SetNWString("CPTBase_NPCFaction", "BR2_FACTION_SCP_173")
	ply.br_support_team = SUPPORT_ROGUE

	ply:SetBloodColor(DONT_BLEED)

	Post_Assign(ply)
end

last_scp_assign = nil
function assign_system.Assign_SCP(ply)
	assign_system.Assign_SCP049(ply)
	--assign_system.Assign_SCP173(ply)
end

function assign_system.Assign_ClassD(ply)
	Pre_Assign(ply)
	ply:ApplyOutfit("class_d")
	ply:Give("br_hands")
	--local doc = ply:Give("br2_doc_classd")
	ply.br_showname = "D-" ..math.random(1,9)..math.random(0,9)..math.random(0,9)..math.random(0,9) .. ""
	--if ply.br_showname == "D-9341" then
	--	ply.isTheOne = true
	--end
	/*
	if IsValid(doc) then
		doc:SetNWString("NW_Dcode", ply.br_showname)
	end
	*/
	ply.br_hunger = 90
	ply.br_thirst = 90
	ply.br_sanity = math.random(85, 100)
	ply.br_role = "Class D"
	ply.br_usesSanity = true
	ply.br_usesTemperature = true
	if ply.support_spawning == false then
		ply.br_support_spawns = {{"class_d", 1}, {"mtf", 1}}
		ply.first_info = "classd"
		ply.mission_set = "classd"
	end
	--ply:SetNWInt("br_support_team", SUPPORT_ROGUE)
	ply.br_support_team = SUPPORT_ROGUE
	ply.br_special_items = {
		{class = "document", name = "Class D Leaflet", type = "doc_leaflet", attributes = {doc_code = ply.br_showname}}
	}
	Post_Assign(ply)
	ply.DefaultWeapons = {"br_hands"}
	ply.canEscape = true
end

function assign_system.Assign_ClassD9341(ply)
	Pre_Assign(ply)
	ply:ApplyOutfit("class_d")
	ply:Give("br_hands")
	ply.br_showname = "D-9341"
	ply.isTheOne = true
	ply.br_role = "Class D"
	ply.br_usesSanity = true
	ply.br_usesTemperature = true
	ply.br_support_spawns = {}
	--ply:SetNWInt("br_support_team", SUPPORT_ROGUE)
	if ply.support_spawning == false then
		ply.br_support_team = SUPPORT_ROGUE
		ply.first_info = "classd"
		ply.mission_set = "classd"
	end
	Post_Assign(ply)
	ply.DefaultWeapons = {"br_hands"}
	ply.canEscape = true
end

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

function assign_system.Assign_SDofficer(ply)
	Pre_Assign(ply)
	ply:PlayerSetSpeeds(DEF_SLOWWALKSPEED * 0.87, DEF_WALKSPEED * 0.87, DEF_RUNSPEED * 0.87)
	ply:ApplyOutfit("guard")
	ply.cantChangeOutfit = true
	ply:AllowFlashlight(true)
	ply:Give("br_hands")

	if ply.dont_assign_items == false then
		ply:Give("keycard_level3")
		ply:Give(table.Random({"kanade_tfa_beretta", "kanade_tfa_glock"}))
		ply:Give(table.Random({"kanade_tfa_mp5k", "kanade_tfa_ump45", "kanade_tfa_mk18", "kanade_tfa_mp7", "kanade_tfa_m590"}))
		ply:Give(table.Random({"item_gasmask", "item_nvg", "item_radio"}))
		ply:SetAmmo(30, "pistol")
		ply:SetAmmo(90, "smg1")
		ply:SetAmmo(20, "buckshot")
	end

	ply.br_role = "SD Officer"
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
		ply:Give(table.Random({"kanade_tfa_beretta", "kanade_tfa_m1911", "kanade_tfa_glock"}))
		ply:Give(table.Random({"item_gasmask", "item_radio"}))
		ply:SetAmmo(30, "pistol")
	end

	ply.br_role = "SD Officer"
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

function assign_system.Assign_CIsoldier(ply)
	Pre_Assign(ply)
	ply:PlayerSetSpeeds(DEF_SLOWWALKSPEED * 0.83, DEF_WALKSPEED * 0.83, DEF_RUNSPEED * 0.83)
	ply:ApplyOutfit("ci_soldier")
	ply.cantChangeOutfit = true
	ply:AllowFlashlight(true)
	ply:Give("br_hands")

	if ply.dont_assign_items == false then
		ply:Give(table.Random({"kanade_tfa_m4a1", "kanade_tfa_m16a4", "kanade_tfa_ump45", "kanade_tfa_mp5k", "kanade_tfa_m590", "kanade_tfa_ak12"}))
		ply:Give("kanade_tfa_m1911")
		ply:SetAmmo(30, "pistol")
		ply:SetAmmo(90, "smg1")
		ply:SetAmmo(90, "ar2")
		ply:SetAmmo(45, "buckshot")
		ply:Give("keycard_omni")
		ply:Give("item_radio")
		ply:Give("item_nvg")
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

function assign_system.Assign_MTF_NTF(ply)
	Pre_Assign(ply)
	ply:PlayerSetSpeeds(DEF_SLOWWALKSPEED * 0.85, DEF_WALKSPEED * 0.85, DEF_RUNSPEED * 0.85)
	ply:ApplyOutfit("mtf")
	ply.cantChangeOutfit = true
	ply:AllowFlashlight(true)
	ply:Give("br_hands")

	if ply.dont_assign_items == false then
		ply:Give(table.Random({"kanade_tfa_m16a4", "kanade_tfa_m249", "kanade_tfa_m4a1", "kanade_tfa_ak12", "kanade_tfa_g36c", "kanade_tfa_m590"}))
		ply:Give(table.Random({"kanade_tfa_beretta", "kanade_tfa_glock", "kanade_tfa_m1911"}))
		ply:Give("kanade_tfa_stunbaton")
		ply:SetAmmo(60, "pistol")
		ply:SetAmmo(50, "SniperPenetratedRound")
		ply:SetAmmo(200, "ar2")
		ply:Give("keycard_level4")
		ply:Give("item_radio")
		ply:Give("item_nvg")
	end

	ply.br_role = "MTF Operative"
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
		ply:Give(table.Random({"kanade_tfa_beretta", "kanade_tfa_m1911"}))
		ply:Give(table.Random({"item_gasmask", "item_radio"}))
		ply:SetAmmo(30, "pistol")
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


-- DEATHMATCH ROLES

function assign_system.Assign_DM_MTF_NTF(ply)
	Pre_Assign(ply)
	ply:PlayerSetSpeeds(DEF_SLOWWALKSPEED * 0.85, DEF_WALKSPEED * 0.85, DEF_RUNSPEED * 0.85)
	ply:ApplyOutfit("mtf")
	ply.cantChangeOutfit = true
	ply:AllowFlashlight(true)
    ply:Give("br_hands")
    ply:Give("keycard_level4")
	ply.br_role = "MTF Operative"
	ply.br_usesTemperature = false
	ply.br_uses_hunger_system = false
	ply.br_support_spawns = {}
    ply.first_info = "dm_mtf"
    ply.mission_set = "dm_mtf"
	ply.br_support_team = SUPPORT_FOUNDATION
	Post_Assign(ply)
	ply.DefaultWeapons = {"br_hands"}
	ply.canEscape = false
end

function assign_system.Assign_DM_CIsoldier(ply)
	Pre_Assign(ply)
	ply:PlayerSetSpeeds(DEF_SLOWWALKSPEED * 0.85, DEF_WALKSPEED * 0.85, DEF_RUNSPEED * 0.85)
	ply:ApplyOutfit("ci_soldier")
	ply.cantChangeOutfit = true
	ply:AllowFlashlight(true)
	ply:Give("br_hands")
	ply:Give("keycard_omni")
	ply.br_role = "CI Soldier"
	ply.br_usesTemperature = false
    ply.br_uses_hunger_system = false
    ply.br_support_spawns = {}
    ply.first_info = "dm_ci"
    ply.mission_set = "dm_ci"
	ply.br_support_team = SUPPORT_CI
	Post_Assign(ply)
	ply.DefaultWeapons = {"br_hands"}
	ply.canEscape = false
end

print("[Breach2] server/sv_assign_players.lua loaded!")
