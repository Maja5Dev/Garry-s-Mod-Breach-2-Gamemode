
MAPCONFIG.ITEM_GENERATION_GROUPS = {
-- LIGHT CONTAINMENT ZONE
	["LCZ_FIRST_LOOT"] = {
		{"keycard_level1", 4}, {"keycard_playing", 1}, {"keycard_master", 1},
		{"item_battery_9v", 3},
		{"item_radio", 1},
		{"eyedrops", 2},

		{"ammo_pistol16", 1},
		{"flashlight_normal", 2},
		{"coin", 4},
		{"doc_scp1048", 1, assign_random_code = "LCZ"},
	},
	["LCZ_SECOND_LOOT"] = {
		{"keycard_level2", 3}, {"keycard_playing", 1}, {"keycard_master", 1},
		{"item_battery_9v", 1},
		{"eyedrops", 1},

		{"ammo_pistol16", 1},
		{"flashlight_tactical", 1},
		{"coin", 2},
		{"device_cameras", 1},
		{"antibiotics", 1},
		{"doc_strange", 1, assign_random_code = "LCZ"},
		{"doc_object_classes", 1, assign_random_code = "LCZ"},
	},
	["LCZ_THIRD_LOOT"] = {
		{"keycard_level3", 2},
		{"ssri_pills", 1},
		{"item_nvg", 1},
		{"kanade_tfa_crowbar", 1},

		{"ammo_pistol16", 1},
		{"device_cameras", 1},
		{"syringe", 1},
		{"conf_folder", 1},
		{"antibiotics", 1},
	},
	["LCZ_WEAPON_LOOT"] = {
		{"kanade_tfa_pipe", 1},
		--{"kanade_tfa_crowbar", 1},
		--{"kanade_tfa_axe", 1},
	},
	["LCZ_ARMORY_LOOT"] = {
		{"kanade_tfa_colt", 1},
		{"item_medkit", 1},
		{"item_gasmask", 1},
		{"ammo_pistol16", 1},
		{"kanade_tfa_stunbaton", 1},
	},
	["LCZ_ADDITIONAL_LOOT"] = {
		{"item_gasmask", 1},
		{"item_nvg", 1},
		{"personal_medkit", 1},
		{"item_radio", 1},
		{"ssri_pills", 1},
	},
	["LCZ_012_LOOT"] = {
		{"personal_medkit", 1}
	},
	["LCZ_012_DOC"] = {
		{"doc_scp012", 1, assign_random_code = "LCZ"},
	},
	["LCZ_EARLIEST"] = {
		{"keycard_level1", 1},
	},
	["LCZ_DOC_173"] = {
		{"doc_scp173", 1, assign_random_code = "LCZ"},
	},
	["LCZ_SCP_500"] = {
		{"scp_500", 3},
		{"doc_scp500", 1, assign_random_code = "LCZ"},
	},
	["LCZ_SCP_372"] = {
		{"ammo_pistol16", 1},
	},
	["LCZ_SECURITY_GATEWAY"] = {
		{"keycard_level1", 1},
	},


-- HEAVY CONTAINMENT ZONE
	["HCZ_049"] = {
		{"doc_scp049", 1, assign_random_code = "HCZ"},
		{"conf_folder", 1},
		{"antibiotics", 2},
		{"item_medkit", 2},
		{"ssri_pills", 1},
		{{"kanade_tfa_fnp45", "kanade_tfa_glock", "kanade_tfa_deagle"}, 1},
		{"ammo_pistol16", 2},
	},
	["HCZ_SCP_682_DOC"] = {
		{"doc_scp682", 1, assign_random_code = "HCZ"},
		{{"kanade_tfa_fnp45", "kanade_tfa_glock", "kanade_tfa_deagle"}, 1},
		{"ammo_pistol16", 1},
	},
	["HCZ_FIRST"] = {
		{"keycard_level4", 1},
		{"item_gasmask", 2},
		{"personal_medkit", 1},
		{"item_radio", 1},
		{"ssri_pills", 1},
		{"item_battery_9v", 3},

		{"ammo_pistol16", 1},
		{"ammo_smg30", 1},
		{"ammo_rifle30", 1},
		{"flashlight_normal", 1},
		{"coin", 2},
		{"kanade_tfa_pipe", 1},
		{"conf_folder", 1},
		{"eyedrops", 1},
		{"scp_420", 1},
		{"drink_soda", 1},
		{"antibiotics", 1},
	},
	["HCZ_SECOND"] = {
		{"keycard_level4", 2},
		{"item_gasmask", 1},
		{"item_radio", 1},
		{"item_nvg_military", 1},
		{"personal_medkit", 1},
		{"kanade_tfa_axe", 1},

		{{"kanade_tfa_fnp45", "kanade_tfa_glock", "kanade_tfa_deagle"}, 1},
		{"ammo_smg30", 1},
		{"flashlight_tactical", 2},
		{"device_cameras", 1},
		{"syringe", 1},
		{"item_c4", 1},
		{"kanade_tfa_stunbaton", 1},
		{"kanade_tfa_pipe", 1},
		{"ammo_pistol16", 1},
		{"ammo_rifle30", 1},
		{"ammo_shotgun10", 1},
		{"conf_folder", 1},
		{"eyedrops", 1},
		{"drink_wine", 1},
		{"antibiotics", 1},
	},
	["HCZ_GUNS"] = {
		{"kanade_tfa_m590", 1},
		{{"kanade_tfa_mp5k", "kanade_tfa_mp7", "kanade_tfa_p90", "kanade_tfa_ump45", "kanade_tfa_mp5a5"}, 1},
		{"kanade_tfa_beretta", 1},
		{"ammo_pistol16", 1},
		{"ammo_smg30", 1},
		{"ammo_rifle30", 1},
		{"ammo_shotgun10", 1},
	},
	["HCZ_035"] = {
		{{"kanade_tfa_mp5k", "kanade_tfa_mp7", "kanade_tfa_p90", "kanade_tfa_ump45", "kanade_tfa_mp5a5"}, 1},
		{{"kanade_tfa_fnp45", "kanade_tfa_glock", "kanade_tfa_deagle"}, 1},
		{"item_c4", 1},
		{"item_medkit", 1},
		
		{"ammo_pistol16", 2},
		{"ammo_smg30", 2},
		{"conf_folder", 1},
	},
	["HCZ_TUNNELS_LOOT"] = {
		{{"kanade_tfa_mp5k", "kanade_tfa_mp7", "kanade_tfa_p90", "kanade_tfa_ump45", "kanade_tfa_mp5a5"}, 1},
		{"ammo_smg60", 1},
		{"item_medkit", 1},
		{"ssri_pills", 1},
		{"keycard_level3", 1},
	},
	["HCZ_TOXIC_ROOM"] = {
		{{"kanade_tfa_mp5k", "kanade_tfa_mp7", "kanade_tfa_p90", "kanade_tfa_ump45", "kanade_tfa_mp5a5"}, 1},
		{"ammo_smg60", 1},
		{"item_medkit", 1},
		{"keycard_level3", 1},
	},
	["HCZ_008"] = {
		{"personal_medkit", 1},
		{"conf_folder", 1},
	},

-- ENTRANCE ZONE
	["EZ"] = {
		{"keycard_level4", 3},
		{{"kanade_tfa_fnp45", "kanade_tfa_glock", "kanade_tfa_deagle"}, 1},
		{"item_c4", 1},
		{"item_medkit", 1},
		{"item_radio", 1},

		{"flashlight_normal", 2},
		{"ammo_pistol16", 1},
		{"coin", 3},
		{"conf_folder", 2},
	},
	["EZ_SPECIAL"] = {
		{"kanade_tfa_m4a1", 1},
		{"kanade_tfa_mk18", 1},
		{"kanade_tfa_beretta", 1},
		{{"kanade_tfa_mp5k", "kanade_tfa_mp7", "kanade_tfa_p90", "kanade_tfa_ump45", "kanade_tfa_mp5a5"}, 1},
		{"ammo_pistol16", 2},
		{"ammo_smg30", 2},
		{"ammo_rifle30", 2},
		{"ammo_shotgun10", 2},
	},
	["EZ_CONFROOM"] = {
		{"conf_folder", 1},
		{"coin", 2},
		{"ssri_pills", 1},
		{"item_medkit", 1},
		{"kanade_tfa_deagle", 1},
		{"ammo_pistol16", 1},
	},
	["EZ_HEADOFFICE"] = {
		{"scp_420", 2},
		{"drink_wine", 1},
		{"conf_folder", 1},
	},
	["EZ_OFFICES"] = {
		{"keycard_level5", 2},
		{"flashlight_tactical", 1},
		{"conf_folder", 3},
		{"ammo_pistol16", 1},
		{{"kanade_tfa_fnp45", "kanade_tfa_glock", "kanade_tfa_deagle"}, 1},
		{"item_radio", 1},
		{"coin", 3},
	},
	["EZ_MEDBAY"] = {
		{"item_medkit", 3},
		{"ssri_pills", 2},
		{"syringe", 2}
	},
	["EZ_DOC_MSP"] = {
		{"doc_msp", 1},
	},
}

MAPCONFIG.OUTFIT_GENERATION_GROUPS = {
	["LCZ"] = {
		{"class_d", 3},
		{"scientist", 3},
		{"janitor", 2},
		{"medic", 1},
	},
	["LCZ_ARMORY"] = {
		{"guard", 2},
	},

	["HCZ"] = {
		{"guard", 2},
		{"hazmat", 2},
	},

	["EZ"] = {
		{"guard", 2},
		{"scientist", 3},
		{"hazmat", 1},
	},
	["EZ_HOFFICE"] = {
		{"hazmat", 1},
	},
}
