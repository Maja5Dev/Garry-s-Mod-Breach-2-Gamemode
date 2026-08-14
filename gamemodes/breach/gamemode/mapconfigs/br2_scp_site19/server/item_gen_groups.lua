
MAPCONFIG.ITEM_GENERATION_GROUPS = {
-- LIGHT CONTAINMENT ZONE
	["LCZ_1"] = {
		{"keycard_level2", 3},
		{"battery9v", 3},
		{"item_radio", 1},
		{"eyedrops", 2},

		{"ammo_pistol16", 1},
		{"flashlight_normal", 2},
		{"coin", 4},
		{"doc_scp1048", 1, assign_random_code = "LCZ"},
		{"doc_object_classes", 1, assign_random_code = "LCZ"},
	},
	["LCZ_2"] = {
		{"keycard_level3", 2},
		{"ssri_pills", 1},
		{"item_nvg", 1},
		{"kanade_tfa_crowbar", 1},

		{"ammo_pistol16", 1},
		{"kanade_tfa_pipe", 1},
		{"eyedrops", 1},
		{"device_cameras", 1},
		{"syringe", 1},
		{"conf_folder", 1},
		{"antibiotics", 1},
		{"flashlight_tactical", 1},
		{"doc_strange", 1, assign_random_code = "LCZ"},
	},
	["LCZ_SCP012"] = {
		{"personal_medkit", 1},
		{"doc_scp012", 1, assign_random_code = "LCZ"},
	},
	["LCZ_SCP914"] = {
		{"doc_scp914", 1},
	},

	["LCZ_SCP173"] = {
		{"doc_scp173", 1, assign_random_code = "LCZ"},
	},
	["LCZ_SCP_500"] = {
		{"scp_500", 3},
		{"doc_scp500", 1, assign_random_code = "LCZ"},
	}, -- TODO

--HEAVY CONTAINMENT ZONE
	["HCZ"] = {
		{"keycard_level4", 1},
		{"item_gasmask", 2},
		{"personal_medkit", 1},
		{"item_radio", 1},
		{"ssri_pills", 1},
		{"battery9v", 3},
		{"item_nvg", 1},

		{"ammo_pistol16", 1},
		{"ammo_smg30", 1},
		{"ammo_rifle30", 1},
		{"ammo_shotgun10", 1},
		{"flashlight_normal", 1},
		{"coin", 2},
		{"kanade_tfa_axe", 1},
		{"kanade_tfa_chainsaw", 1},
		{"kanade_tfa_pipe", 1},
		{"conf_folder", 1},
		{"eyedrops", 1},
		{"scp_420", 1},
		{"drink_soda", 1},
		{"antibiotics", 1},
		{"item_c4", 1},
		{"syringe", 1},
	},
	["HCZ_049"] = {
		{"doc_scp049", 1, assign_random_code = "HCZ"},
		{"conf_folder", 1},
		{"antibiotics", 2},
		{"item_medkit", 2},
		{"ssri_pills", 1},
		{{"kanade_tfa_fnp45", "kanade_tfa_glock", "kanade_tfa_deagle"}, 1},
		{"ammo_pistol16", 2},
	},
	["HCZ_SCP682"] = {
		{"doc_scp682", 1, assign_random_code = "HCZ"},
		{{"kanade_tfa_fnp45", "kanade_tfa_glock", "kanade_tfa_deagle"}, 1},
		{"ammo_pistol16", 1},
	},
	["HCZ_SCP035"] = {
		{{"kanade_tfa_fnp45", "kanade_tfa_glock", "kanade_tfa_deagle"}, 1},
		{"item_c4", 1},
		{"item_medkit", 1},
		
		{"ammo_pistol16", 2},
		{"ammo_smg30", 2},
		{"conf_folder", 1},
	},
	["HCZ_SCP008"] = {
		{{"kanade_tfa_mp5k", "kanade_tfa_mp7", "kanade_tfa_p90", "kanade_tfa_ump45", "kanade_tfa_mp5a5"}, 1},
		{"personal_medkit", 1},
		{"conf_folder", 1},
		{"doc_scp008", 1},
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
	["EZ_HEADROOM"] = {
		{"scp_420", 2},
		{"drink_wine", 1},
		{"conf_folder", 1},
	},
	["EZ_MEDROOM"] = {
		{"item_medkit", 3},
		{"ssri_pills", 2},
		{"syringe", 2}
	},
	["EZ_OFFICES"] = {
		{"keycard_level4", 2},
		{"flashlight_tactical", 1},
		{"conf_folder", 3},
		{"ammo_pistol16", 1},
		{{"kanade_tfa_fnp45", "kanade_tfa_glock", "kanade_tfa_deagle"}, 1},
		{"item_radio", 1},
		{"coin", 3},
		{"doc_msp", 1},
	},
}

MAPCONFIG.OUTFIT_GENERATION_GROUPS = {
	["LCZ_OUTFITS"] = {
		{"class_d", 3},
		{"scientist", 3},
		{"janitor", 2},
		{"medic", 1},
		{"guard", 1},
	},

	["HCZ_OUTFITS"] = {
		{"guard", 2},
		{"hazmat", 2},
	},

	["EZ_OUTFITS"] = {
		{"guard", 2},
		{"scientist", 3},
		{"hazmat", 2},
	},
}
