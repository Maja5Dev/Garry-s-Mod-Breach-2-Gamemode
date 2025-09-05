
-- groups of roles to use in role assignment on round start
BREACH_DEFAULT_ROLES = {
	roles_classds = {
		class = "classd",
		team = TEAM_CLASSD,
		spawns = {"SPAWNS_CLASSD_CELLS"},
		assign_function = "Assign_ClassD"
	},
	roles_classd_9341 = {
		class = "classd_9341",
		team = TEAM_CLASSD,
		spawns = {"SPAWNS_CLASSD_CELLS"},
		assign_function = "Assign_ClassD9341"
	},
	roles_minor_staff = {
		class = "minor_staff",
		team = TEAM_MINORSTAFF,
		spawns = {"SPAWNS_LCZ"},
		assign_function = "Assign_MinorStaff"
	},
	roles_researchers = {
		class = "researcher",
		team = TEAM_RESEARCHER,
		spawns = {"SPAWNS_LCZ"},
		assign_function = "Assign_Researcher"
	},
	/*
	roles_cont_spec = {
		team = TEAM_SECURITY,
		spawns = {"SPAWNS_LCZ", "SPAWNS_HCZ"},
		assign_function = "Assign_ContSpec"
	},
	*/
	roles_security = {
		class = "sd_officer",
		team = TEAM_SECURITY,
		spawns = {"SPAWNS_SECURITY"},
		assign_function = "Assign_SDofficer"
	},
	/*
	roles_security_hcz_pistol = {
		team = TEAM_SECURITY,
		spawns = {"SPAWNS_HCZ"},
		assign_function = "Assign_SDofficerLight"
	},
	roles_security_hcz = {
		team = TEAM_SECURITY,
		spawns = {"SPAWNS_HCZ"},
		assign_function = "Assign_SDofficer"
	},
	roles_security_ez = {
		team = TEAM_SECURITY,
		spawns = {"SPAWNS_ENTRANCEZONE_EARLY"}, 
		assign_function = "Assign_SDofficer"
	},
	roles_isecurity = {
		team = TEAM_SECURITY,
		spawns = {"SPAWNS_HCZ"},
		assign_function = "Assign_ISDagent"
	},
	*/
	/*
	roles_scps_unkillable = {
		class = "scp_unkillable",
		team = TEAM_SCP,
		spawns = {"SPAWNS_SCP_OTHERS"},
		assign_function = "Assign_SCP_Unkillable"
	},
	roles_scps_killable = {
		class = "scp_killable",
		team = TEAM_SCP,
		spawns = {"SPAWNS_SCP_OTHERS"},
		assign_function = "Assign_SCP_Killable"
	},
	*/
	roles_scps = {
		class = "scp",
		team = TEAM_SCP,
		spawns = {"SPAWNS_SCP_OTHERS"},
		assign_function = "Assign_SCP"
	},
	roles_ci_soldiers = {
		class = "ci_soldier",
		team = TEAM_CI,
		spawns = {"SPAWNS_CISOLDIERSEARLY"},
		assign_function = "Assign_CIsoldier"
	},
	roles_ci_agent_res = {
		class = "ci_agent",
		team = TEAM_CI,
		spawns = {"SPAWNS_LCZ"},
		assign_function = "Assign_Researcher_CI"
	},
	/*
	roles_ci_agent_sec = {
		team = TEAM_CI,
		spawns = {"SPAWNS_HCZ"},
		assign_function = "Assign_SDofficer_CI"
	},
	*/

	--ADDITIONAL
	roles_mtf = {
		class = "mtf",
		team = TEAM_MTF,
		spawns = {"SPAWNS_MTF"},
		assign_function = "Assign_MTF_NTF"
	},
	roles_minor_janitor = {
		class = "janitor",
		team = TEAM_MINORSTAFF,
		spawns = {"SPAWNS_LCZ"},
		assign_function = "Assign_Janitor"
	},
	roles_minor_doctor = {
		class = "doctor",
		team = TEAM_MINORSTAFF,
		spawns = {"SPAWNS_LCZ"},
		assign_function = "Assign_Doctor"
	},
	roles_minor_engineer = {
		class = "engineer",
		team = TEAM_MINORSTAFF,
		spawns = {"SPAWNS_LCZ"},
		assign_function = "Assign_Engineer"
	},
}

BREACH_DEATHMATCH_ROLES = {
	roles_mtf = {
		class = "mtf",
		team = TEAM_MTF,
		spawns = {"SPAWNS_ENTRANCEZONE_GATEB"},
		assign_function = "Assign_DM_MTF_NTF"
	},
	roles_ci_soldiers = {
		class = "ci_soldier",
		team = TEAM_CI,
		--spawns = {"SPAWNS_HCZ_LATE"},
		spawns = {"SPAWNS_ENTRANCEZONE_NEAR_GATES"},
		assign_function = "Assign_DM_CIsoldier"
	},
}

BREACH_DEATHMATCH_ROLELIST = {}
for i=1, 20 do
	local tab = {roles = {}, victory_conditions = {}}
	if i > 1 then
		if i > 4 then
			tab.victory_conditions = {"one_player", "all_same_team"}
		else
			tab.victory_conditions = {"one_player"}
		end
	end
	
	for num=1, i do
		if num % 2 == 1 then
			table.ForceInsert(tab.roles, BREACH_DEATHMATCH_ROLES.roles_mtf)
		else
			table.ForceInsert(tab.roles, BREACH_DEATHMATCH_ROLES.roles_ci_soldiers)
		end
	end
	table.ForceInsert(BREACH_DEATHMATCH_ROLELIST, tab)
end

BREACH_DEFAULT_ROLELIST = {
	roles = {
		BREACH_DEFAULT_ROLES.roles_classds,
		BREACH_DEFAULT_ROLES.roles_researchers,
		BREACH_DEFAULT_ROLES.roles_security,
		BREACH_DEFAULT_ROLES.roles_ci_agent_res,
		BREACH_DEFAULT_ROLES.roles_ci_soldiers,
		BREACH_DEFAULT_ROLES.roles_classds,
		BREACH_DEFAULT_ROLES.roles_scps,
		BREACH_DEFAULT_ROLES.roles_minor_staff,
		BREACH_DEFAULT_ROLES.roles_researchers,
		BREACH_DEFAULT_ROLES.roles_security,
		BREACH_DEFAULT_ROLES.roles_classds,
		BREACH_DEFAULT_ROLES.roles_scps,
		BREACH_DEFAULT_ROLES.roles_ci_agent_res,
		BREACH_DEFAULT_ROLES.roles_classds,
		BREACH_DEFAULT_ROLES.roles_minor_staff,
		BREACH_DEFAULT_ROLES.roles_researchers,
		BREACH_DEFAULT_ROLES.roles_classds,
		BREACH_DEFAULT_ROLES.roles_security,
		BREACH_DEFAULT_ROLES.roles_ci_soldiers,
		BREACH_DEFAULT_ROLES.roles_minor_staff,
		BREACH_DEFAULT_ROLES.roles_classds,
		BREACH_DEFAULT_ROLES.roles_researchers,
		BREACH_DEFAULT_ROLES.roles_security,
		BREACH_DEFAULT_ROLES.roles_ci_soldiers,
		BREACH_DEFAULT_ROLES.roles_classds,
		BREACH_DEFAULT_ROLES.roles_ci_agent_res,
		BREACH_DEFAULT_ROLES.roles_security,
		BREACH_DEFAULT_ROLES.roles_classds,
		BREACH_DEFAULT_ROLES.roles_researchers,
	},
	victory_conditions = {"one_player", "all_same_team"},
}

BR2_MTF_STARTING_INFORMATION = {}

function BREACH_DEFAULT_STARTING_INFORMATION()
	local players = GetAlivePlayers()
	
	--Clear all notepads
	notepad_system.ClearAllNotepads()

	for k,v in pairs(players) do
		notepad_system.AssignNewNotepad(v, false)

		--MTF INFO
		if !(v.br_team == TEAM_CI and v.br_ci_agent == false) then
			table.ForceInsert(BR2_MTF_STARTING_INFORMATION, {v.br_showname, v.br_role, false, HEALTH_MISSING, true, v.charid, v})
		end 
	end
	
	local all_ci_spies = {}
	local all_non_spies = {}

	for k,v in pairs(players) do
		if v.br_team == TEAM_CI then
			if v.br_ci_agent == true then
				table.ForceInsert(all_ci_spies, v)
			end

		elseif v:IsFromFoundationHighStaff() then
			table.ForceInsert(all_non_spies, v)
		end

		if v.br_team == TEAM_CI then
			for k2,pl in pairs(players) do
				if v != pl and pl.br_team == TEAM_CI and pl.br_ci_agent == false then
					notepad_system.AddPlayerInfo(pl, v.br_showname, v.br_role, v.br_ci_agent, HEALTH_MISSING, false, v.charid, v)
				end
			end
		end

		if v:IsFromFoundation() then
			local login, password = BR2_GenerateTerminalAuth(v)
			notepad_system.AddAutomatedInfo(v, "personal terminal account:\n - login: " .. login .. "\n - password: " .. password .. "\n")
		end
	end

	for k,v in pairs(all_fake_corpses) do
		if v.br_ci_agent == true then
			table.ForceInsert(all_ci_spies, v)
		else
			table.ForceInsert(all_non_spies, v)
			table.ForceInsert(BR2_MTF_STARTING_INFORMATION, {v.br_showname, v.br_role, false, HEALTH_MISSING, true, v.charid, v})
		end
	end

	local possible_ci_spies = {}
	for i=1, math.Clamp(#all_ci_spies, 0, 3) do
		local rnd_spy = table.Random(all_ci_spies)
		table.ForceInsert(possible_ci_spies, rnd_spy)
		table.RemoveByValue(all_ci_spies, rnd_spy)
	end

	if #possible_ci_spies > 0 then
		for i=1, math.Clamp(#all_non_spies, 0, 3) do
			local rnd_non_spy = table.Random(all_non_spies)
			table.ForceInsert(possible_ci_spies, rnd_non_spy)
			table.RemoveByValue(all_non_spies, rnd_non_spy)
		end
	end

	--Main Information
	for k,v in pairs(players) do
		-- high staff gets info
		if v:IsFromFoundationHighStaff() then
			if v.getsPossibleTraitors == true then
				notepad_system.AddAutomatedInfo(v, "Possible spies")
				for k2,pspy in pairs(possible_ci_spies) do
					if pspy != v then
						notepad_system.AddAutomatedInfo(v, " - "..pspy.br_showname)
					end
				end
			end
			
			-- corpses info
			if istable(all_fake_corpses) then
				for _,corpse in pairs(all_fake_corpses) do
					notepad_system.AddPlayerInfo(v, corpse.br_showname, corpse.br_role, false, HEALTH_MISSING, false, nil, nil)
				end
			end
			
			for k2,pl in pairs(players) do
				if v != pl then
					local isciagent = false
					if v.br_team == TEAM_CI then
						isciagent = pl.br_ci_agent
					end

					if pl.br_team == TEAM_SCP then
						--notepad_system.AddPlayerInfo(v, pl.br_showname, pl.br_role, isciagent, HEALTH_MISSING, true, pl.charid)

					elseif pl:IsFromFoundation() == true then
						notepad_system.AddPlayerInfo(v, pl.br_showname, pl.br_role, isciagent, HEALTH_MISSING, false, pl.charid, pl)
					end
				end
			end
		elseif v:IsFromFoundation() then
			-- corpses info
			if istable(all_fake_corpses) then
				for _,corpse in pairs(all_fake_corpses) do
					notepad_system.AddPlayerInfo(v, corpse.br_showname, corpse.br_role, false, HEALTH_MISSING, false, nil, nil)
				end
			end
			
			-- class d gets info
			for k2,pl in pairs(players) do
				if v != pl and pl:IsFromFoundation() and pl.br_team != TEAM_SCP then
					local isciagent = false

					if v.br_team == TEAM_CI then
						isciagent = pl.br_ci_agent
					end

					notepad_system.AddPlayerInfo(v, pl.br_showname, pl.br_role, isciagent, HEALTH_MISSING, false, pl.charid, pl)
				end
			end
		end
	end
	
	for k,v in pairs(players) do
		notepad_system.UpdateNotepad(v)
	end
end

local deathmatch_classes = {
    {
        name = "Breacher",
        primary = {"kanade_tfa_m590"},
        secondary = {"kanade_tfa_beretta"},
        items = {"item_radio", "item_gasmask", "kanade_tfa_crowbar"},
        special_items = {"personal_medkit", "flashlight"},
        ammo = {{40, "Buckshot"}, {120, "Pistol"}}
    },
    {
        name = "Sniper",
        primary = {"kanade_tfa_m40a1"},
        secondary = {"kanade_tfa_glock"},
        items = {"item_radio", "item_nvg_military"},
        special_items = {"personal_medkit", "flashlight"},
        ammo = {{40, "SniperPenetratedRound"}, {136, "Pistol"}}
    },
    {
        name = "Recon",
        primary = {"kanade_tfa_mp7", "kanade_tfa_mk18", "kanade_tfa_mp5k"},
        secondary = {"kanade_tfa_glock"},
        items = {"item_radio", "item_gasmask"},
        special_items = {"personal_medkit", "flashlight", "device_cameras"},
        ammo = {{140, "SMG1"}, {136, "Pistol"}}
    },
    {
        name = "Medic",
        primary = {"kanade_tfa_sterling", "kanade_tfa_ump45"},
        secondary = {"kanade_tfa_beretta"},
        items = {"item_radio", "item_gasmask", "item_medkit"},
        special_items = {"personal_medkit", "flashlight"},
        ammo = {{150, "SMG1"}, {120, "Pistol"}}
    },
    {
        name = "Rifleman",
        primary = {"kanade_tfa_ak12", "kanade_tfa_m16a4"},
        secondary = {"kanade_tfa_m1911"},
        items = {"item_radio", "item_nvg_military"},
        special_items = {"personal_medkit", "flashlight"},
        ammo = {{120, "AR2"}, {56, "Pistol"}}
    },
    {
        name = "Assault",
        primary = {"kanade_tfa_g36c", "kanade_tfa_m4a1"},
        secondary = {"kanade_tfa_glock"},
        items = {"item_radio", "item_gasmask"},
        special_items = {"personal_medkit", "flashlight", "syringe"},
        ammo = {{150, "AR2"}, {136, "Pistol"}}
    },
    {
        name = "Support",
        primary = {"kanade_tfa_m249"},
        secondary = {"kanade_tfa_m1911"},
        items = {"item_radio", "item_gasmask", "item_c4"},
        special_items = {"personal_medkit", "flashlight", "ammo_shotgun30", "ammo_sniper40", "ammo_rifle60", "ammo_rifle60", "ammo_pistol64", "ammo_pistol64", "ammo_smg60", "ammo_smg60"},
        ammo = {{200, "AR2"}, {56, "Pistol"}}
    },
}

-- first scenario in this table will always be the default one
BREACH_SCENARIOS = {
	{
		name = "Chaos Insurgency Attack",
		roles = BREACH_DEFAULT_ROLES,
		role_list = BREACH_DEFAULT_ROLELIST,
		starting_information = "BREACH_DEFAULT_STARTING_INFORMATION",
		name_list = BREACH_NAMES,
		fake_corpses = true,
		scp_008_no_auto_closing = false,
		disable_map_organisation = false,
		disable_commotion_sounds = false,
		disable_getting_codes = false,
		disable_npc_spawning = false,

		--first_sounds_enabled = true,
		first_sounds_enabled = false,
		
		friendly_fire_enabled = true,
		downing_enabled = true,
		bleeding_enabled = true,
		only_entrance_zone = false
	},
	{
		name = "Deathmatch",
		roles = BREACH_DEATHMATCH_ROLES,
		role_list = BREACH_DEATHMATCH_ROLELIST,
		starting_information = function()
			local players = GetAlivePlayers()
			notepad_system.ClearAllNotepads()

			for k,v in pairs(players) do
				notepad_system.AssignNewNotepad(v, false)
			end

			for k,v in pairs(players) do
				for k2,pl in pairs(players) do
					if v != pl and v.br_team == pl.br_team then
						notepad_system.AddPlayerInfo(pl, v.br_showname, v.br_role, v.br_ci_agent, HEALTH_MISSING, false, v.charid, v)
					end
				end
			end

			for k,v in pairs(players) do
				notepad_system.UpdateNotepad(v)
			end
		end,
		after_assign = function()
			local spawn_teams = {{}, {}}
			local all_deathmatch_classes = table.Copy(deathmatch_classes)
			for k,v in pairs(GetAlivePlayers()) do
				if v.br_team == TEAM_CI then
					table.ForceInsert(spawn_teams[1], v)
				elseif v.br_team == TEAM_MTF then
					table.ForceInsert(spawn_teams[2], v)
				end
			end

			for k,class in pairs(spawn_teams) do
				for pl_k,pl in pairs(class) do
					local rnd_class = table.Random(all_deathmatch_classes)

					if rnd_class == nil then
						all_deathmatch_classes = table.Copy(deathmatch_classes)
						rnd_class = table.Random(all_deathmatch_classes)
					end
					
					pl:Give(table.Random(rnd_class.primary))
					pl:Give(table.Random(rnd_class.secondary))
					for wep_k,wep in pairs(rnd_class.items) do
						pl:Give(wep)
					end

					for ammo_k,ammo in pairs(rnd_class.ammo) do
						pl:SetAmmo(ammo[1], ammo[2])
					end

					pl.br_special_items = {}
					pl.sp_medkit_uses = 4

					for item_k,item in pairs(rnd_class.special_items) do
						table.ForceInsert(pl.br_special_items, {class = item})
					end
					table.RemoveByValue(all_deathmatch_classes, rnd_class)
				end
			end
		end,
		name_list = BREACH_NAMES,
		fake_corpses = false,
		scp_008_no_auto_closing = true,
		disable_map_organisation = false,
		disable_commotion_sounds = false,
		disable_getting_codes = true,
		disable_npc_spawning = true,
		first_sounds_enabled = true,
		first_sounds_override = {{"breach2/mtf/Announc.ogg", 25.5}},
		friendly_fire_enabled = false,
		downing_enabled = true,
		bleeding_enabled = false,
		only_entrance_zone = true
	},
	-- O5 IN SITE
	-- BEFORE THE BREACH
	-- AFTER THE BREACH
	-- 008 BREACH
}

print("[Breach2] server/sv_scenarios.lua loaded!")