
MAPCONFIG.BUTTONS_2D.ITEM_CONTAINERS = {
	mat = button_icons.scpu,
	on_open = function(button)
		TryToOpenContainer(button)
	end,
	buttons = {
	--LCZ
		{pos = Vector(7980,-653,-938), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ"}, -- LCZ_CENTRAL_CLASSD-SMALLBOX_1
		{pos = Vector(7939,-2994,-659), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_1"}, -- LCZ_CLASSD_CELLS-BIN_1
		{pos = Vector(8105,-1088,-932), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_1"}, -- LCZ_CENTRAL_CLASSD_RECEPTION-BIGDRAWER_1
		{pos = Vector(8163,-950,-930), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_1"}, -- LCZ_CENTRAL_CLASSD_RECEPTION-BOXDRAWER_1
		{pos = Vector(7701,-1880,-788), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_2"}, -- LCZ_CLASSD_OFFICE-BIGDRAWER_1
		{pos = Vector(7620,-1878,-785), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_2"}, -- LCZ_CLASSD_OFFICE-BOXDRAWER_1
		{pos = Vector(7430,-1872,-804), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_2"}, -- LCZ_CLASSD_OFFICE-SNDRAWER_1
		{pos = Vector(7569,-1723,-796), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_2"}, -- LCZ_CLASSD_OFFICE-MDRAWER_1
		{pos = Vector(6748,-2504,-915), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_CAF"}, -- LCZ_CAFETERIA-FRIDGE_1
		{pos = Vector(6682,-2504,-915), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_CAF"}, -- LCZ_CAFETERIA-FRIDGE_2
		{pos = Vector(7741,-348,-931), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_STOR"}, -- LCZ_CENTRAL_STORAGEROOM-BIGDRAWER_1
		{pos = Vector(8005,-292,-913), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_STOR"}, -- LCZ_CENTRAL_STORAGEROOM-BIGDRAWER_2
		{pos = Vector(7740,-177,-930), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_STOR"}, -- LCZ_CENTRAL_STORAGEROOM-BIGDRAWER_3
		{pos = Vector(7944,-121,-932), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_STOR"}, -- LCZ_CENTRAL_STORAGEROOM-BIGDRAWER_4
		{pos = Vector(7740,-6,-913), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_STOR"}, -- LCZ_CENTRAL_STORAGEROOM-BIGDRAWER_5
		{pos = Vector(7943,50,-913), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_STOR"}, -- LCZ_CENTRAL_STORAGEROOM-BIGDRAWER_6
		{pos = Vector(7740,50,-948), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_STOR"}, -- LCZ_CENTRAL_STORAGEROOM-BIGDRAWER_7
		{pos = Vector(9035,-654,-1065), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_3"}, -- LCZ_CENTRAL_OFFICES-DESKDRAWER_1
		{pos = Vector(9034,-334,-1065), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_3"}, -- LCZ_CENTRAL_OFFICES-DESKDRAWER_2
		{pos = Vector(7996,-646,-1058), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ"}, -- LCZ_CENTRAL_OFFICES-BOXDRAWER_1
		{pos = Vector(8126,-355,-1060), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ"}, -- LCZ_CENTRAL_OFFICES-BIGDRAWER_1
		{pos = Vector(8099,-632,-1076), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ"}, -- LCZ_CENTRAL_OFFICES-SNDRAWER_1
		{pos = Vector(9133,-1131,-913), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_3"}, -- LCZ_CENTRAL_INTERROGATIONROOM-BIGDRAWER_1
		{pos = Vector(9316,-928,-935), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_3"}, -- LCZ_CENTRAL_INTERROGATIONROOM-METALDRAWER_1
		{pos = Vector(9338,-1068,-944), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_3"}, -- LCZ_CENTRAL_INTERROGATIONROOM-SMETALDRAWER_1
		{pos = Vector(8935,-660,-934), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_3"}, -- LCZ_CENTRAL_SCP1123-METALDRAWER_1
		{pos = Vector(9213,-504,-948), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_3"}, -- LCZ_CENTRAL_SCP1123-SMETALDRAWER_1
		{pos = Vector(10369,-1166,-802), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_3"}, -- LCZ_SCP914-BOXDRAWER_1
		{pos = Vector(10242,-1474,-786), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_3"}, -- LCZ_SCP914-BIGDRAWER_1
		{pos = Vector(10362,-1407,-820), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_3"}, -- LCZ_SCP914-SNDRAWER_1
		{pos = Vector(7444,-671,-900), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_MECH"}, -- LCZ_SCP173_JANITORROOM-TOOLBOX_1
		{pos = Vector(6400,540,-784), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_3"}, -- LCZ_SCP173_OBSERVATORY-BIGDRAWER_1
		{pos = Vector(6284,448,-819), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_3"}, -- LCZ_SCP173_OBSERVATORY-SNDRAWER_1
		{pos = Vector(6403,205,-802), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_3"}, -- LCZ_SCP173_OBSERVATORY-BOXDRAWER_1
		{pos = Vector(6296,-469,-809), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_3"}, -- LCZ_SCP173_CONTROLROOM-DRAWER_1
		{pos = Vector(6360,-469,-809), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_3"}, -- LCZ_SCP173_CONTROLROOM-DRAWER_2
		{pos = Vector(4283,-1164,-931), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ"}, -- LCZ_CHECKPOINT_1-BIGDRAWER_1
		{pos = Vector(4429,618,-943), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_MECH"}, -- LCZ_NORTHWING_STORAGEAREA-MECHANIC_DRAWER_1
		{pos = Vector(4607,190,-934), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ"}, -- LCZ_NORTHWING_STORAGEAREA-BOXES_1
		{pos = Vector(5012,200,-951), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ"}, -- LCZ_NORTHWING_STORAGEAREA-BOX_1
		{pos = Vector(8529,-920,-942), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_MECH"}, -- LCZ_CENTRAL-MECHANIC_DRAWER_1
		{pos = Vector(4283,1060,-932), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ"}, -- LCZ_CHECKPOINT_2-BIGDRAWER_1
		{pos = Vector(8015,-2661,-929), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_2"}, -- LCZ_CLASSD_CELSS_BELOWAREA_GASROOM-BOXDRAWER_1
		
	--RZ
		{pos = Vector(8197,446,-1069), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_AMMO"}, -- RZ_STORAGEROOM_1-AMMOCRATE_1
		{pos = Vector(8278,44,-1061), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_GUN"}, -- RZ_STORAGEROOM_1-GUNCRRATE_1
		{pos = Vector(8826,754,-1075), canSee = DefaultItemContainerCanSee, item_gen_group = "RZ_2"}, -- RZ_CHEMLAB-DESKDRAWER_1
		{pos = Vector(8960,1022,-1073), canSee = DefaultItemContainerCanSee, item_gen_group = "RZ_2"}, -- RZ_CHEMLAB-DESKDRAWER_2
		{pos = Vector(7880,1877,-1140), canSee = DefaultItemContainerCanSee, item_gen_group = "RZ_2"}, -- RZ_TECHLAB-DESKDRAWER_1
		{pos = Vector(7821,1922,-1140), canSee = DefaultItemContainerCanSee, item_gen_group = "RZ_2"}, -- RZ_TECHLAB-DESKDRAWER_2
		{pos = Vector(8756,2777,-1209), canSee = DefaultItemContainerCanSee, item_gen_group = "RZ_2"}, -- RZ_AQUALAB-DESKDRAWER_1
		{pos = Vector(8846,3342,-1209), canSee = DefaultItemContainerCanSee, item_gen_group = "RZ_2"}, -- RZ_AQUALAB-DESKDRAWER_2
		{pos = Vector(8816,3571,-1075), canSee = DefaultItemContainerCanSee, item_gen_group = "RZ_3"}, -- RZ_AQUALAB_2-DESKDRAWER_3
		{pos = Vector(8771,3513,-1075), canSee = DefaultItemContainerCanSee, item_gen_group = "RZ_3"}, -- RZ_AQUALAB_2-DESKDRAWER_4
		{pos = Vector(9083,1723,-1075), canSee = DefaultItemContainerCanSee, item_gen_group = "RZ_2"}, -- RZ_BARRACKS-DESKDRAWER_1
		{pos = Vector(9083,1782,-1066), canSee = DefaultItemContainerCanSee, item_gen_group = "RZ_2"}, -- RZ_BARRACKS-DESKDRAWER_2
		{pos = Vector(10950,1957,-1204), canSee = DefaultItemContainerCanSee, item_gen_group = "RZ_4"}, -- RZ_SECURITYAREA-BOX_1
		{pos = Vector(10946,1912,-1204), canSee = DefaultItemContainerCanSee, item_gen_group = "RZ_4"}, -- RZ_SECURITYAREA-BOX_2
		{pos = Vector(10860,1650,-1206), canSee = DefaultItemContainerCanSee, item_gen_group = "RZ_BARRACK_WEAPONS"}, -- RZ_SECURITYAREA-WEAPON_BOX_1
		{pos = Vector(10861,1526,-1206), canSee = DefaultItemContainerCanSee, item_gen_group = "RZ_BARRACK_WEAPONS"}, -- RZ_SECURITYAREA-WEAPON_BOX_2
		{pos = Vector(10689,1527,-1206), canSee = DefaultItemContainerCanSee, item_gen_group = "RZ_BARRACK_WEAPONS"}, -- RZ_SECURITYAREA-WEAPON_BOX_3
		{pos = Vector(10689,1649,-1206), canSee = DefaultItemContainerCanSee, item_gen_group = "RZ_BARRACK_WEAPONS"}, -- RZ_SECURITYAREA-WEAPON_BOX_4
		--{pos = Vector(10826,2482,-1204), canSee = DefaultItemContainerCanSee, item_gen_group = "RZ_COMMAND_ROOM"}, -- ZZZZZZZZZZZZZZ
		--{pos = Vector(10713,2444,-1203), canSee = DefaultItemContainerCanSee, item_gen_group = "RZ_COMMAND_ROOM"}, -- ZZZZZZZZZZZZZZ
		{pos = Vector(9742,196,-1054), canSee = DefaultItemContainerCanSee, item_gen_group = "RZ_2"}, -- RZ_JANITORAREA-BOX_1
		
	--HCZ
		{pos = Vector(2845,76,-943), canSee = DefaultItemContainerCanSee, item_gen_group = "HCZ_SCP035"}, -- HCZ_SCP035_STORAGE-BOX
		{pos = Vector(2912,72,-951), canSee = DefaultItemContainerCanSee, item_gen_group = "HCZ_SCP035"}, -- HCZ_SCP035_STORAGE-CRATES
		{pos = Vector(2874,2616,-936), canSee = DefaultItemContainerCanSee, item_gen_group = "HCZ"}, -- HCZ_SCP457-BOXES
		{pos = Vector(2652,2848,-1415), canSee = DefaultItemContainerCanSee, item_gen_group = "HCZ"}, -- HCZ_SCP049-BOXES
		{pos = Vector(2492,2874,-1436), canSee = DefaultItemContainerCanSee, item_gen_group = "HCZ_SCP049"}, -- HCZ_SCP049-SUPPLIES
		{pos = Vector(3895,3036,-974), canSee = DefaultItemContainerCanSee, item_gen_group = "HCZ"}, -- HCZ_CONTROLROOM-BOXES
		
	--EZ
		{pos = Vector(683,-2380,-913), canSee = DefaultItemContainerCanSee, item_gen_group = "EZ"}, -- EZ_CHECKPOINT
		{pos = Vector(716,-147,-927), canSee = DefaultItemContainerCanSee, item_gen_group = "EZ"}, -- EZ_OFFICE-BOXES
		{pos = Vector(380,-377,-948), canSee = DefaultItemContainerCanSee, item_gen_group = "EZ"}, -- EZ_OFFICE-DRAWER
		{pos = XXXXXXXXXXXXXXXXXXXXXXX, canSee = DefaultItemContainerCanSee, item_gen_group = "BBBBBBBBBBBBBBB"}, -- ZZZZZZZZZZZZZZ
		{pos = XXXXXXXXXXXXXXXXXXXXXXX, canSee = DefaultItemContainerCanSee, item_gen_group = "BBBBBBBBBBBBBBB"}, -- ZZZZZZZZZZZZZZ
		{pos = XXXXXXXXXXXXXXXXXXXXXXX, canSee = DefaultItemContainerCanSee, item_gen_group = "BBBBBBBBBBBBBBB"}, -- ZZZZZZZZZZZZZZ
		{pos = XXXXXXXXXXXXXXXXXXXXXXX, canSee = DefaultItemContainerCanSee, item_gen_group = "BBBBBBBBBBBBBBB"}, -- ZZZZZZZZZZZZZZ
		{pos = XXXXXXXXXXXXXXXXXXXXXXX, canSee = DefaultItemContainerCanSee, item_gen_group = "BBBBBBBBBBBBBBB"}, -- ZZZZZZZZZZZZZZ
		{pos = XXXXXXXXXXXXXXXXXXXXXXX, canSee = DefaultItemContainerCanSee, item_gen_group = "BBBBBBBBBBBBBBB"}, -- ZZZZZZZZZZZZZZ
	}
}

MAPCONFIG.BUTTONS_2D.ITEM_CONTAINERS_CRATES = {
	mat = button_icons.scpu_locks,
	on_open = function(button)
		TryToOpenCrate(button)
	end,
	buttons = {
	--LCZ
		{pos = Vector(8705,-703,-1013), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_CRATES"}, -- LCZ_CENTRAL-CRATE_BM_1
		{pos = Vector(8379,442,-1055), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_CRATES"}, -- RZ_STORAGEROOM_1-CRATE_BM_1
		{pos = Vector(9182,749,-1013), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_CRATES"}, -- RZ_SHOOTING_RANGE-CRATE_BM_1
	--HCZ
		{pos = XXXXXXXXXXXXXXXXXXXXXXX, canSee = DefaultItemContainerCanSee, item_gen_group = "BBBBBBBBBBBBBBB"}, -- ZZZZZZZZZZZZZZ
	--EZ
		{pos = XXXXXXXXXXXXXXXXXXXXXXX, canSee = DefaultItemContainerCanSee, item_gen_group = "BBBBBBBBBBBBBBB"}, -- ZZZZZZZZZZZZZZ
	}
}

MAPCONFIG.BUTTONS_2D.OUTFITTERS = {
	mat = button_icons.scpu,
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
		{pos = Vector(9028,322,-1045), canSee = DefaultItemContainerCanSee, item_gen_group = "RES"}, -- RZ_LOCKER_ROOM-1
		{pos = Vector(8928,97,-1045), canSee = DefaultItemContainerCanSee, item_gen_group = "JANITOR"}, -- RZ_LOCKER_ROOM-2
		{pos = XXXXXXXXXXXXXXXXXXXXXXX, canSee = DefaultItemContainerCanSee, item_gen_group = "BBBBBBBBBBBBBBB"}, -- ZZZZZZZZZZZZZZ
		{pos = XXXXXXXXXXXXXXXXXXXXXXX, canSee = DefaultItemContainerCanSee, item_gen_group = "BBBBBBBBBBBBBBB"}, -- ZZZZZZZZZZZZZZ
		{pos = XXXXXXXXXXXXXXXXXXXXXXX, canSee = DefaultItemContainerCanSee, item_gen_group = "BBBBBBBBBBBBBBB"}, -- ZZZZZZZZZZZZZZ
	}
}

print("[Breach2] Shared/Buttons/ItemContainers mapconfig loaded!")