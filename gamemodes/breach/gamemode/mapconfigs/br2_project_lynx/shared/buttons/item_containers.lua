
MAPCONFIG.BUTTONS_2D.ITEM_CONTAINERS = {
	mat = br_default_button_icons.scpu,
	on_open = function(button)
		TryToOpenContainer(button)
	end,
	buttons = {
		-- LCZ (NO KEYCARD REQUIRED)
		{pos = Vector(-4731,11684,-293), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_EARLY"}, -- LCZ_CLASSD_GYM-CRATE_1
		{pos = Vector(-4797,8488,-70), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_EARLY"}, -- LCZ_CLASSD_TO_LCZ_OFFICE-DRAWER_1
		{pos = Vector(-6182,9422,99), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_EARLY"}, -- LCZ_CLASSD_PRISON-1
		{pos = Vector(-3913,9655,87), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_EARLY"}, -- LCZ_CLASSD_INTERROGROOM-1
		{pos = Vector(-5979,9669,-284), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_EARLY"}, -- LCZ_CLASSD_CAFFETERIA-1
		{pos = Vector(-6023,7022,-62), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_EARLY"}, -- LCZ_RANDOM-DRAWER_1
		{pos = Vector(-6343,8484,-71), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_EARLY"}, -- LCZ_RESEARCHROOM-DRAWER_1
		{pos = Vector(-7127,8484,-62), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_EARLY"}, -- LCZ_RESEARCHROOM-DRAWER_2
		{pos = Vector(-7280,6828,-75), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_EARLY"}, -- LCZ_VIDEOROOM-CRATE_1
		{pos = Vector(-6678,6317,-57), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_EARLY"}, -- LCZ_MEDROOM-DRAWER_1
		{pos = Vector(-5078,6712,-69), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_EARLY"}, -- LCZ_PIZZAOFFICE-DRAWER_1
		{pos = Vector(-2892,5864,-56), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_EARLY"}, -- LCZ_LARGESTORAGE-CRATE_1
		{pos = Vector(-7232,6390,-35), canSee = DefaultItemContainerCanSee, item_gen_group = "MEDICAL"}, -- LCZ_MEDROOM-MEDDRAWER_1

		-- LCZ (LEVEL 1 ACCESS REQUIRED)
		{pos = Vector(-1872,6875,-26), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_1"}, -- LCZ_RANDOM-CRATE_2
		{pos = Vector(-1484,5116,-73), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_1"}, -- LCZ_INTERROG-CRATE_1
		{pos = Vector(-1663,5083,-58), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_1"}, -- LCZ_INTERROG-LOCKER_1
		{pos = Vector(-7126,4505,-69), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_1"}, -- LCZ_SCP205-DRAWER_1
		{pos = Vector(-5818,4289,-62), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_1"}, -- LCZ_SCP1074-DRAWER_1
		{pos = Vector(-5563,4504,-72), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_1"}, -- LCZ_SCP1074-DRAWER_2
		{pos = Vector(-5871,4851,-57), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_1"}, -- LCZ_SCP806-DRAWER_1
		{pos = Vector(-3902,8172,-70), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_1"}, -- LCZ_SCP1123-DRAWER_1
		{pos = Vector(-5135,10398,66), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_1"}, -- LCZ_CLASSD_TOWER-UP_1
		{pos = Vector(-5133,10405,-174), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_1"}, -- LCZ_CLASSD_TOWER-DOWN_1

		-- LCZ (LEVEL 2 ACCESS REQUIRED)
		{pos = Vector(-7201,4310,-33), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_2"}, -- LCZ_SCP205-CRATE_1
		{pos = Vector(-6670,5171,-66), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_2"}, -- LCZ_SCP1499-DRAWER_1
		{pos = Vector(-6427,5515,-62), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_2"}, -- LCZ_SCP1499-DRAWER_1
		{pos = Vector(-5668,5381,-35), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_2"}, -- LCZ_SCP806-CRATE_1
		{pos = Vector(-2614,7024,-65), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_2"}, -- LCZ_SCPSROOM-CRATE_1
		{pos = Vector(-4319,5713,-56), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_2"}, -- LCZ_SHOOTING_RANGE-LOCKER_1
		{pos = Vector(-3759,6925,-60), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_2"}, -- LCZ_DARKSTORATE-CRATE_1
		{pos = Vector(-3555,7256,-70), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_2"}, -- LCZ_DARKSTORATE-CRATE_2

		{pos = Vector(-5906,8257,102), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_RANDOMITEMS"}, -- LCZ_SCP173-LOCKER_1
		{pos = Vector(-5787,8574,102), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_RANDOMITEMS"}, -- LCZ_SCP173-LOCKER_2
		{pos = Vector(-5895,8516,97), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_RANDOMITEMS"}, -- LCZ_SCP173-CRATE_1
		{pos = Vector(-5660,8569,93), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_RANDOMITEMS"}, -- LCZ_SCP173-CRATE_2
		{pos = Vector(-5466,8565,86), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_RANDOMITEMS"}, -- LCZ_SCP173-DRAWER_1
		{pos = Vector(-5375,7700,92), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_RANDOMITEMS"}, -- LCZ_SCP173-CRATE_3
		{pos = Vector(-3988,8759,92), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_RANDOMITEMS"}, -- LCZ_SCP914-CRATE_1  NO KEYS
		{pos = Vector(-3456,8471,87), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_RANDOMITEMS"}, -- LCZ_SCP914-DRAWER_1  NO KEYS
		{pos = Vector(-3979,8851,97), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_RANDOMITEMS"}, -- LCZ_SCP914-DRAWER_2  NO KEYS

		-- LCZ (LEVEL 3 ACCESS REQUIRED)
		{pos = Vector(-6493,7417,-66), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_BARRACKS"}, -- LCZ_BARRACKS-CRATE_1
		{pos = Vector(-6380,7416,-66), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_BARRACKS"}, -- LCZ_BARRACKS-CRATE_2
		{pos = Vector(-6660,7324,-65), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_BARRACKS"}, -- LCZ_BARRACKS-CRATE_3
		{pos = Vector(-6419,5613,-563), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_BARRACKS"}, -- LCZ_BUNKER-CRATE_1
		{pos = Vector(-6110,5549,-577), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_BARRACKS"}, -- LCZ_BUNKER-CRATE_2
		{pos = Vector(-6110,5325,-577), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_BARRACKS"}, -- LCZ_BUNKER-CRATE_3
		{pos = Vector(-5821,5998,-545), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_BARRACKS"}, -- LCZ_BUNKER-CRATE_4

	}
}

MAPCONFIG.BUTTONS_2D.ITEM_CONTAINERS_CRATES = {
	mat = br_default_button_icons.scpu_locks,
	on_open = function(button)
		TryToOpenCrate(button)
	end,
	buttons = {
		-- LCZ
		{pos = Vector(-3563,6907,-49), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_CRATES"}, -- LCZ_DARKSTORAGEROOM-1
		{pos = Vector(-2852,6114,-49), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_CRATES"}, -- LCZ_RANDOM-CRATE_1
		{pos = Vector(-5485,6480,-49), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_CRATES"}, -- LCZ_PIZZAOFFICE-1
		{pos = Vector(-3755,5038,-57), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_GUNS"}, -- LCZ_SHOOTING_RANGE-1
		{pos = Vector(-4153,6417,-49), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_GUNS"}, -- LCZ_ARMORY-1
		{pos = Vector(-6340,7678,-58), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_GUNS"}, -- LCZ_BARRACKS-1
	}
}

MAPCONFIG.BUTTONS_2D.OUTFITTERS = {
	mat = br_default_button_icons.scpu,
	on_open = function(button)
		if button == nil or LocalPlayer():GetOutfit().can_change_outfits == false then
			chat.AddText(Color(255, 255, 255), "You couldn't find anything useful...")
			return
		end
		net.Start("br_use_outfitter")
			net.WriteVector(button.pos)
		net.SendToServer()
	end,
	buttons = {
		--LCZ
		{pos = Vector(-6610,7419,-65), canSee = DefaultItemContainerCanSee, item_gen_group = "RES"}, -- LCZ_BARRACKS-1
		

	}
}

print("[Breach2] Shared/Buttons/ItemContainers mapconfig loaded!")