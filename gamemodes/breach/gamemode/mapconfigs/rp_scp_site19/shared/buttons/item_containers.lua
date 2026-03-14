
MAPCONFIG.BUTTONS_2D.ITEM_CONTAINERS = {
	mat = br_default_button_icons.scpu,
	on_open = function(button)
		TryToOpenContainer(button)
	end,
	buttons = {
	-- LCZ
		{pos = Vector(-2320,-3465,-8942), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_1"}, -- LCZ_SCP173-1
		{pos = Vector(-1490,-2660,-9182), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_1"}, -- LCZ_EARLY-1
		{pos = Vector(-1688,-3156,-9197), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_1"}, -- LCZ_EARLY-2
		{pos = Vector(-2354,-1941,-9294), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_1"}, -- LCZ_EARLY-3
		{pos = Vector(-2218,-1445,-9181), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_1"}, -- LCZ_EARLY-4
		{pos = Vector(-2338,-1526,-9182), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_1"}, -- LCZ_EARLY-5
		{pos = Vector(-2593,-1237,-9173), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_1"}, -- LCZ_1123

		{pos = Vector(-3553,-1926,-9038), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_2"}, -- LCZ_SURVEILLANCE_ROOM
		{pos = Vector(1834,-355,-9173), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_2"}, -- LCZ_SCP_372
		{pos = Vector(671,-853,-9197), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_2"}, -- LCZ_SMALL_SCPS_ROOM
		{pos = Vector(265,-1131,-9173), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_2"}, -- LCZ_LIGHT_ROOM
		{pos = Vector(-4445,-1228,-9422), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_2"}, -- LCZ_SCP_012

		{pos = Vector(-4444,-1197,-9422), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_SCP012"}, -- LCZ_SCP_012-2
		{pos = Vector(-3168,-429,-9188), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_SCP914"}, -- LCZ_SCP914
		{pos = Vector(-2320,-3690,-8942), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_SCP173"}, -- LCZ_SCP173-2

	-- HCZ
		{pos = Vector(-1800,1018,-9182), canSee = DefaultItemContainerCanSee, item_gen_group = "HCZ"}, -- HCZ_SCP_035
		{pos = Vector(-1887,648,-9194), canSee = DefaultItemContainerCanSee, item_gen_group = "HCZ_SCP035"}, -- HCZ_SCP_035-KEYCARDROOM-1
		{pos = Vector(-1961,665,-9189), canSee = DefaultItemContainerCanSee, item_gen_group = "HCZ_SCP035"}, -- HCZ_SCP_035-KEYCARDROOM-2
		{pos = Vector(-4000,2899,-9197), canSee = DefaultItemContainerCanSee, item_gen_group = "HCZ"}, -- HCZ_SCP895
		{pos = Vector(-6890,2248,-9437), canSee = DefaultItemContainerCanSee, item_gen_group = "HCZ"}, -- HCZ_SCP106
		{pos = Vector(-1662,2290,-9438), canSee = DefaultItemContainerCanSee, item_gen_group = "HCZ_SCP682"}, -- HCZ_SCP682
		{pos = Vector(369,2116,-9204), canSee = DefaultItemContainerCanSee, item_gen_group = "HCZ"}, -- HCZ_STORAGEROOM
		{pos = Vector(-1800,1050,-9181), canSee = DefaultItemContainerCanSee, item_gen_group = "HCZ"}, -- HCZ_SCP008
		{pos = Vector(-1887,648,-9194), canSee = DefaultItemContainerCanSee, item_gen_group = "HCZ_SCP008"}, -- HCZ_SCP008-KEYCARDROOM-1
		{pos = Vector(-1961,663,-9189), canSee = DefaultItemContainerCanSee, item_gen_group = "HCZ_SCP008"}, -- HCZ_SCP008-KEYCARDROOM-2

	-- 049
		{pos = Vector(-2829,2104,-11194), canSee = DefaultItemContainerCanSee, item_gen_group = "HCZ_049"}, -- HCZ_049-1
		{pos = Vector(-2810,2023,-11194), canSee = DefaultItemContainerCanSee, item_gen_group = "HCZ_049"}, -- HCZ_049-2

	-- EZ
		{pos = Vector(-4228,4715,-9257), canSee = DefaultItemContainerCanSee, item_gen_group = "EZ"}, -- EZ_OFFICE_NEAR_GATE-1
		{pos = Vector(-4451,4900,-9257), canSee = DefaultItemContainerCanSee, item_gen_group = "EZ"}, -- EZ_OFFICE_NEAR_GATE-2
		{pos = Vector(-3875,6227,-9422), canSee = DefaultItemContainerCanSee, item_gen_group = "EZ"}, -- EZ_SERVERROOM
		{pos = Vector(-2600,5532,-9182), canSee = DefaultItemContainerCanSee, item_gen_group = "EZ"}, -- EZ_VERTICALROOM-1
		{pos = Vector(-2851,4970,-9062), canSee = DefaultItemContainerCanSee, item_gen_group = "EZ"}, -- EZ_VERTICALROOM-2
		{pos = Vector(-2124,4804,-9121), canSee = DefaultItemContainerCanSee, item_gen_group = "EZ_HEADROOM"}, -- EZ_HEADROOM
		{pos = Vector(-2289,6327,-9197), canSee = DefaultItemContainerCanSee, item_gen_group = "EZ_OFFICES"}, -- EZ_DR_L
		{pos = Vector(-1356,6414,-9197), canSee = DefaultItemContainerCanSee, item_gen_group = "EZ_OFFICES"}, -- EZ_DR_MAYNARD
		{pos = Vector(-1777,6414,-9198), canSee = DefaultItemContainerCanSee, item_gen_group = "EZ_OFFICES"}, -- EZ_DR_HARP
		{pos = Vector(-2060,6770,-9182), canSee = DefaultItemContainerCanSee, item_gen_group = "EZ"}, -- EZ_CONF_ROOM
		{pos = Vector(-690,6955,-9197), canSee = DefaultItemContainerCanSee, item_gen_group = "EZ"}, -- EZ_OPEN_CONF_ROOM
		{pos = Vector(-374,5269,-9173), canSee = DefaultItemContainerCanSee, item_gen_group = "EZ_MEDROOM"}, -- EZ_MEDROOM
		{pos = Vector(-4640,6998,-8908), canSee = DefaultItemContainerCanSee, item_gen_group = "EZ"}, -- EZ_ELECTRICAL_ROOM
		{pos = Vector(-4236,6745,-8873), canSee = DefaultItemContainerCanSee, item_gen_group = "EZ"}, -- EZ_ELECTRICAL_OFFICE
	}
}

MAPCONFIG.BUTTONS_2D.ITEM_CONTAINERS_CRATES = {
	mat = br_default_button_icons.scpu_locks,
	on_open = function(button)
		TryToOpenCrate(button)
	end,
	buttons = {
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
		{pos = Vector(-2167,-1525,-9182), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_OUTFITS"}, -- ZZZZZZZZZZZZZZ
		{pos = Vector(-4444,-1288,-9422), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_OUTFITS"}, -- ZZZZZZZZZZZZZZ

		{pos = XXXXXXXXXXXXXXXXXXXXXXX, canSee = DefaultItemContainerCanSee, item_gen_group = "BBBBBBBBBBBBBBB"}, -- ZZZZZZZZZZZZZZ
		{pos = XXXXXXXXXXXXXXXXXXXXXXX, canSee = DefaultItemContainerCanSee, item_gen_group = "BBBBBBBBBBBBBBB"}, -- ZZZZZZZZZZZZZZ
		{pos = XXXXXXXXXXXXXXXXXXXXXXX, canSee = DefaultItemContainerCanSee, item_gen_group = "BBBBBBBBBBBBBBB"}, -- ZZZZZZZZZZZZZZ

		{pos = Vector(-2851,4910,-9062), canSee = DefaultItemContainerCanSee, item_gen_group = "EZ_OUTFITS"}, -- ZZZZZZZZZZZZZZ
		{pos = Vector(-3876,6288,-9422), canSee = DefaultItemContainerCanSee, item_gen_group = "EZ_OUTFITS"}, -- ZZZZZZZZZZZZZZ
	}
}

print("[Breach2] Shared/Buttons/ItemContainers mapconfig loaded!")