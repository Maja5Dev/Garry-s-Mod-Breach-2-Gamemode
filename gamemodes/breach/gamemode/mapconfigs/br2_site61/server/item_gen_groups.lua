
MAPCONFIG.ITEM_GENERATION_GROUPS = {
	["LCZ_FIRST_LOOT"] = {
		{"keycard_level1", 4},
		{"keycard_playing", 1},
		{"keycard_master", 1},
		{"item_battery_9v", 3},
		{"item_radio", 1},
		{"eyedrops", 2},

		{"ammo_pistol16", 1},
		{"flashlight_normal", 2},
		{"coin", 4},
		{"doc_scp1048", 1},
	},
	["LCZ_SECOND_LOOT"] = {
		{"keycard_level2", 3},
		{"keycard_playing", 1},
		{"keycard_master", 1},
		{"item_battery_9v", 1},
		{"eyedrops", 1},

		{"ammo_pistol16", 1},
		{"flashlight_tactical", 1},
		{"coin", 2},
		{"device_cameras", 1},
	},
	["LCZ_THIRD_LOOT"] = {
		{"keycard_level3", 2},
		{"ssri_pills", 1},
		{"item_nvg", 1},
		{"kanade_tfa_crowbar", 1},

		{"ammo_pistol16", 1},
		{"device_cameras", 1},
		{"syringe", 1}
	},
	["LCZ_WEAPON_LOOT"] = {
		{"kanade_tfa_pipe", 1},
		--{"kanade_tfa_crowbar", 1},
		--{"kanade_tfa_axe", 1},
	},
	["LCZ_ARMORY_LOOT"] = {
		{"kanade_tfa_m1911", 1},
		{"item_medkit", 1},
		{"item_gasmask", 1},
		
		{"ammo_pistol16", 1},
		{"ammo_smg30", 1},
	},
	["LCZ_ADDITIONAL_LOOT"] = {
		{"item_gasmask", 1},
		{"item_nvg", 1},
		{"item_medkit", 1},
		{"item_radio", 1},
		{"ssri_pills", 1},
	},
	["LCZ_012_LOOT"] = {
		{"item_medkit", 1}
	},
	["LCZ_012_DOC"] = {
		{"doc_scp012", 1},
	},
	["LCZ_EARLIEST"] = {
		{"keycard_level1", 1},
	},
	["LCZ_DOC_173"] = {
		{"doc_scp173", 1},
	},
	["LCZ_SCP_500"] = {
		{"scp_500", 4},
	},
	["LCZ_SCP_372"] = {
		{"ammo_pistol16", 1},
	},

	["HCZ_049"] = {
		{"doc_scp049", 1},
	},
	["HCZ_SCP_682_DOC"] = {
		{"doc_scp682", 1},
	},
	["HCZ_FIRST"] = {
		{"keycard_level2", 2},
		{"keycard_level3", 2},
		{"item_gasmask", 1},
		{"item_medkit", 1},
		{"item_radio", 1},
		{"ssri_pills", 1},
		{"item_battery_9v", 3},

		{"ammo_pistol16", 1},
		{"ammo_rifle30", 1},
		{"flashlight_normal", 1},
		{"coin", 2},
	},
	["HCZ_SECOND"] = {
		{"keycard_level4", 2},
		{"item_nvg", 1},
		{"item_medkit", 1},
		{"kanade_tfa_axe", 1},

		{"ammo_smg30", 1},
		{"flashlight_tactical", 2},
		{"device_cameras", 1},
		{"syringe", 1}
	},
	["HCZ_GUNS"] = {
		{"kanade_tfa_m590", 1},
		{"kanade_tfa_ump45", 1},
		{"kanade_tfa_beretta", 1},
		{"ammo_pistol16", 1},
		{"ammo_smg30", 1},
		{"ammo_rifle30", 1},
		{"ammo_shotgun10", 1},
	},
	["HCZ_035"] = {
		{"kanade_tfa_mp5k", 1},
		{"kanade_tfa_beretta", 1},
		{"item_c4", 1},
		{"item_medkit", 1},
		
		{"ammo_pistol16", 1},
		{"ammo_smg30", 1},
	},
	["HCZ_TUNNELS_GUN"] = {
		{"kanade_tfa_m40a1", 1},

		{"ammo_sniper10", 1},
	},

	["EZ"] = {
		{"keycard_level4", 3},
		{"keycard_level3", 1},
		{"kanade_tfa_beretta", 1},
		{"item_c4", 1},
		{"item_medkit", 1},
		{"item_radio", 1},

		{"flashlight_normal", 2},
		{"ammo_pistol16", 1},
		{"coin", 3},
	},
	["EZ_SPECIAL"] = {
		{"kanade_tfa_m4a1", 1},
		{"kanade_tfa_mk18", 1},
		{"kanade_tfa_beretta", 1},
		{"kanade_tfa_ump45", 1},
		{"ammo_pistol16", 1},
		{"ammo_smg30", 1},
		{"ammo_rifle30", 1},
		{"ammo_shotgun10", 1},
	},
	["EZ_OFFICES"] = {
		{"keycard_level5", 1},

		{"flashlight_tactical", 1},
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
		{"class_d", 4},
		{"scientist", 3},
		{"janitor", 2},
		{"medic", 1},
	},
	["LCZ_ARMORY"] = {
		{"guard", 2},
	},
	["HCZ"] = {
		{"guard", 1},
		{"hazmat", 2},
	},
	["EZ"] = {
		{"guard", 2},
		{"scientist", 3},
		{"hazmat", 1},
	},
}
