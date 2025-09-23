
MAPCONFIG.OUTFIT_GENERATION_GROUPS = {
	["LCZ"] = {
		{"class_d", 4},
		{"scientist", 4},
		{"janitor", 4},
		{"medic", 4},
	},
}

-- lua_run print_gen_groups()
function print_gen_groups()
	local tab = {}
	for k,v in pairs(MAPCONFIG.BUTTONS_2D.ITEM_CONTAINERS.buttons) do
		tab[v.item_gen_group] = 0
	end
	for k,v in pairs(MAPCONFIG.BUTTONS_2D.ITEM_CONTAINERS.buttons) do
		tab[v.item_gen_group] = tab[v.item_gen_group] + 1
	end
	PrintTable(tab)
end


MAPCONFIG.ITEM_GENERATION_GROUPS = {
	["LCZ_FIRST_LOOT"] = {
		{"keycard_level1", 2},
		{"keycard_master", 1},

		{"flashlight_cheap", 1},
		{"coin", 1},
		{"lockpick", 1},
		{"item_battery_9v", 1},
		{"antibiotics", 1},
		{"doc_scp1048", 1},
		{"drink_bottle_water", 1},
	},
	["LCZ_FIRST_LOOT_LATE"] = {
		{"keycard_level2", 2},

		{"flashlight_cheap", 1},
		{"flashlight_normal", 1},
		{"ssri_pills", 1},
		{"drink_bottle_water", 1},
		{"antibiotics", 1},
	},

	["LCZ_DOCS"] = {
		{"doc_note682", 1},
		{"doc_gonzalez", 1},
		{"doc_scp427", 1},
		{"doc_strange", 1},
	},
	["LCZ_BOXES"] = {
		{"ammo_pistol16", 2},
		{"ammo_smg30", 1},
		{"ammo_rifle30", 1},
		{"ammo_shotgun10", 1},

		{"item_medkit", 1},
		{"item_radio", 2},
		{"item_gasmask", 1},
		{"ssri_pills", 1},
	},
	["LCZ_FOOD"] = {
		{"food_cookies", 1},
		{"food_chips", 1},
		{"drink_orange_juice", 1},
		{"drink_bottle_water", 1},
	},
	["LCZ_REDSTA"] = {
		{"keycard_level1", 2},
		{"keycard_master", 1},
		{"coin", 1},
		{"doc_scp173", 1},
		{"item_battery_9v", 3},
	},
	["LCZ_SECONDARY_LOOT"] = {
		{"keycard_level2", 3},

		{"antibiotics", 1},
		{"ssri_pills", 1},
		{"item_radio", 1},
		{"coin", 2},
		{"lockpick", 2},
	},
	["LCZ_THIRD_LOOT"] = {
		{"keycard_level3", 3},

		{"item_medkit", 1},
		{"ammo_smg30", 2},
		{"ammo_pistol32", 2},
		{"syringe", 1},
		{"device_cameras", 1},
		{"crafting_toolbox", 1},
	},
	["LCZ_FOURTH_LOOT"] = {
		{"keycard_level3", 1},
		{"br2_item_flashlight_tactical", 1},
		{"item_medkit", 1},
		{"device_cameras", 1},
	},
	["INFO_BOXES"] = {
		--{"keycard_level4", 1},
		{"conf_folder", 5},
	},
	["MECHANIC_ITEMS"] = {
		{"device_cameras", 1},
		{"crafting_toolbox", 1},
	},
	["LCZ_CRATES"] = {
		{"item_nvg", 1},
		{"item_gasmask", 1},
		{"item_c4", 1},
		{"kanade_tfa_stunbaton", 1},
		{"kanade_tfa_pipe", 1},
		{"kanade_tfa_crowbar", 1},
		
		{"flashlight_normal", 2},
	},
	["LCZ_STA_1"] = {
		{"keycard_level1", 1},
		{"flashlight_cheap", 1},
		{"keycard_master", 1},
		{"keycard_playing", 1},
		{"antibiotics", 1},
	},
	["LCZ_GUNS"] = {
		{"kanade_tfa_mp5k", 1},
		{"kanade_tfa_m590", 1},
		{"kanade_tfa_ump45", 1},
		{"kanade_tfa_beretta", 1},
	},




	--CRATES
	["CRATE_AMMO"] = {
		{"ammo_smg60", 1},
		{"ammo_pistol32", 1},
		{"ammo_rifle60", 1},
		{"ammo_sniper10", 1},
		{"ammo_shotgun10", 1},
	},
	["CRATE_BM"] = {
		{"item_nvg2", 1},
		{"item_medkit", 1},
		{"item_gasmask", 1},
		{"kanade_tfa_pipe", 1},
		{"kanade_tfa_crowbar", 1},
	},
	["CRATE_BIG"] = {
		{"kanade_tfa_beretta", 1},
		{"kanade_tfa_m1911", 1},
		{"item_nvg_military", 1},
		{"item_radio", 1},
	},
	["CRATE_GUNS"] = {
		{"kanade_tfa_ak12", 1},
		{"kanade_tfa_glock", 1},
		{"kanade_tfa_m1014", 1},
		{"kanade_tfa_fnfal", 1},
	},
}

print("[Breach2] Server/ItemGenGroups mapconfig loaded!")