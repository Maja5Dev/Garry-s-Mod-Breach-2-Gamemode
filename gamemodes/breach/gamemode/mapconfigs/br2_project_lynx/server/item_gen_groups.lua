
MAPCONFIG.OUTFIT_GENERATION_GROUPS = {
	["RES"] = {
		{"scientist", 1}
	},
	["LCZ"] = {
		{"class_d", 4},
		{"scientist", 4},
		{"janitor", 4},
		{"medic", 4},
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
	["LCZ_EARLY"] = {
		{"keycard_level1", 1},
		{"coin", 1},
		{"item_gasmask", 1},
		{"kanade_tfa_pipe", 1},
		{"drink_bottle_water", 1},
	},
	["MEDICAL"] = {
		{"item_medkit", 1}
	},

	["LCZ_1"] = {
		{"keycard_level2", 1},
		{"battery9v", 1},
		{"lockpick", 1},
		{"coin", 1},
		{"crafting_toolbox", 1},
		{"device_cameras", 1},
		{"ssri_pills", 1},
	},
	["LCZ_2"] = {
		{"keycard_level3", 1},
		{"ssri_pills", 1},
		{"doc_gonzalez", 1},
		{"flashlight_normal", 1},
		{"doc_note682", 1},
		{"syringe", 1},
	},
	["LCZ_RANDOMITEMS"] = {
		{"keycard_level3", 1},
		{"item_gasmask", 1},
		{"battery9v", 1},
		{"kanade_tfa_crowbar", 1},
		{"doc_scp1048", 1},
		{"food_chips", 1},
		{"drink_orange_juice", 1},
	},

	["LCZ_BARRACKS"] = {
		{"kanade_tfa_glock", 1},
		{"ammo_pistol16", 2},
		{"flashlight_tactical", 1},
		{"conf_folder", 1},
		{"doc_strange", 1},
		{"item_nvg", 1},
		{"battery9v", 1},
		{"item_radio", 1},
	},
	
	["LCZ_GUNS"] = {
		{"kanade_tfa_m590", 1},
		{"kanade_tfa_beretta", 1},
		{"ammo_pistol16", 2},
		{"ammo_smg30", 2},
		{"ammo_rifle30", 2},
		{"ammo_shotgun10", 2},
	},
	["LCZ_CRATES"] = {
		{"item_nvg", 1},
		{"battery9v", 1},
		{"device_cameras", 1},
		{"ssri_pills", 1},
		{"item_radio", 1},
		{"item_medkit", 1},
		{"kanade_tfa_pipe", 1},
		{"kanade_tfa_crowbar", 1},
		{"food_chips", 1},
		{"antibiotics", 1},
		{"item_gasmask", 1},
		{"crafting_toolbox", 1},
	},
}

print("[Breach2] Server/ItemGenGroups mapconfig loaded!")