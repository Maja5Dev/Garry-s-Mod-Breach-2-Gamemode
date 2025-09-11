
MAPCONFIG.OUTFIT_GENERATION_GROUPS = {
	["LCZ"] = {
		{"class_d", 4},
		{"scientist", 4},
		{"janitor", 4},
		{"medic", 4},
	},
	["RES"] = {
		{"scientist", 2}
	},
	["JANITOR"] = {
		{"janitor", 2}
	}
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
	["LCZ_CRATES"] = {
		{"item_nvg", 1},
		{"item_medkit", 1},
		{"item_gasmask", 1},
		{"kanade_tfa_pipe", 1},
		{"kanade_tfa_crowbar", 1},
	},

	--LIGHT CONTAINMENT ZONE
	["LCZ"] = {
		{"keycard_level1", 2},
		--{"keycard_master", 1},
		--{"keycard_playing", 1},
		{"coin", 1},
		{"lockpick", 1},
		{"item_battery_9v", 1},
		{"doc_scp1048", 1},
		{"drink_bottle_water", 1},
	},
	["LCZ_1"] = {
		{"keycard_level2", 1},
		{"antibiotics", 1},
		{"food_chips", 1},
		{"drink_orange_juice", 1},
	},
	["LCZ_STOR"] = {
		{"keycard_level2", 1},
		{"doc_gonzalez", 1},
		{"item_battery_9v", 1},
		{"coin", 1},
	},
	["LCZ_2"] = {
		{"keycard_level3", 2},
		{"flashlight_cheap", 1},
		{"ssri_pills", 1},
		{"drink_bottle_water", 1},
		{"antibiotics", 1},
	},
	["LCZ_3"] = {
		{"drink_bottle_water", 1},
		{"conf_folder", 1},
		{"doc_note682", 1},
		{"device_cameras", 1},
	},
	
	--RESEARCH ZONE
	["RZ_1"] = {
		{"keycard_level1", 2},
		{"flashlight_cheap", 1},
		{"lockpick", 1},
		{"food_cookies", 1},
		{"coin", 2},
	},
	["RZ_2"] = {
		{"keycard_level2", 2},
		{"flashlight_normal", 1},
		{"antibiotics", 1},
		{"ssri_pills", 1},
		{"drink_bottle_water", 1},
	},
	["RZ_3"] = {
		{"keycard_level3", 2},
		{"antibiotics", 1},
		{"item_battery_9v", 1},
		{"conf_folder", 1},
		{"syringe", 1},
	},
	["RZ_4"] = {
		{"item_radio", 1},
		{"conf_folder", 1},
		{"doc_scp427", 1},
		{"doc_strange", 1},
		{"coin", 1},
		{"flashlight_tactical", 1},
	},
	
	["RZ_BARRACK_WEAPONS"] = {
		{"kanade_tfa_mp5k", 1},
		{"kanade_tfa_m590", 1},
		{"kanade_tfa_ump45", 1},
		{"kanade_tfa_beretta", 1},
	},
	["LCZ_AMMO"] = {
		{"ammo_pistol16", 2},
		{"ammo_smg30", 2},
		{"ammo_rifle30", 2},
		{"ammo_shotgun10", 2},
	},
	["LCZ_MECH"] = {
		{"device_cameras", 1},
		{"crafting_toolbox", 1},
	},
	["LCZ_GUN"] = {
		{"kanade_tfa_glock", 1},
	},
}

print("[Breach2] Server/ItemGenGroups mapconfig loaded!")