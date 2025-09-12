
MAPCONFIG.BUTTONS_2D.ITEM_CONTAINERS = {
	mat = br_default_button_icons.scpu,
	on_open = function(button)
		TryToOpenContainer(button)
	end,
	buttons = {
		
		--LCZ
		{pos = Vector(-2210,535,-8293), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_EARLIEST"}, -- EARLY_CLASSD-BOX
		{pos = Vector(-975,1003,-8156), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_FIRST_LOOT"}, -- FIRST OFFICE-1
		{pos = Vector(-975,1035,-8156), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_FIRST_LOOT"}, -- FIRST OFFICE-2
		{pos = Vector(-657,1968,-7902), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_FIRST_LOOT"}, -- FIRST OFFICE-3
		{pos = Vector(-1481,792,-8022), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_FIRST_LOOT"}, -- SCP_173-1
		{pos = Vector(-657,2000,-7902), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_DOC_173"}, -- SCP_173-2
		{pos = Vector(-1046,108,-8414), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_012_LOOT"}, -- SCP_012-1
		{pos = Vector(-1046,77,-8413), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_012_DOC"}, -- SCP_012-2
		{pos = Vector(-914,-633,-8162), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_FIRST_LOOT"}, -- CABINETS-CRATE
		{pos = Vector(-673,-639,-8157), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_FIRST_LOOT"}, -- CABINETS-1
		{pos = Vector(-591,-707,-8157), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_FIRST_LOOT"}, -- CABINETS-2
		{pos = Vector(624,1891,-8139), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_FIRST_LOOT"}, -- TERMINAL_ITEM_ROOM-1
		{pos = Vector(494,2138,-8146), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_FIRST_LOOT"}, -- TERMINAL_ITEM_ROOM-CRATE
		{pos = Vector(505,1993,-8139), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_FIRST_LOOT"}, -- TERMINAL_ITEM_ROOM-BOX
		{pos = Vector(752,2125,-8174), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_FIRST_LOOT"}, -- TERMINAL_ITEM_ROOM-2
		{pos = Vector(1489,1770,-8158), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_SECOND_LOOT"}, -- YELLOW_ITEM_ROOM-1
		{pos = Vector(1489,1942,-8157), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_SECOND_LOOT"}, -- YELLOW_ITEM_ROOM-2
		{pos = Vector(259,393,-8166), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_THIRD_LOOT"}, -- SCARE_ROOM-BOX
		{pos = Vector(244,484,-8135), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_THIRD_LOOT"}, -- SCARE_ROOM-CRATE
		{pos = Vector(243,526,-8160), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_WEAPON_LOOT"}, -- SCARE_ROOM-BIGCRATE
		{pos = Vector(1129,945,-8143), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_SECOND_LOOT"}, -- OFFICES-CRATE1
		{pos = Vector(958,812,-8159), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_THIRD_LOOT"}, -- OFFICES_1_1-CRATE
		{pos = Vector(1450,813,-8157), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_SECOND_LOOT"}, -- OFFICES_1_2-1
		{pos = Vector(1009,1499,-8159), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_FIRST_LOOT"}, -- OFFICES-CRATE2
		{pos = Vector(1499,1322,-8138), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_FIRST_LOOT"}, -- OFFICES-BOX
		{pos = Vector(1016,1321,-8157), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_SECOND_LOOT"}, -- OFFICES_2_1-1
		{pos = Vector(1513,1384,-8157), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_SECOND_LOOT"}, -- OFFICES_2_2-1
		{pos = Vector(1599,-64,-8157), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_SECOND_LOOT"}, -- VENT_ROOM-1
		{pos = Vector(1758,196,-8116), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_SECOND_LOOT"}, -- VENT_ROOM-CRATE
		{pos = Vector(2059,199,-8173), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_ADDITIONAL_LOOT"}, -- VENT_ROOM-2
		{pos = Vector(1088,-575,-8145), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_THIRD_LOOT"}, -- BIG_YELLOW_ROOM-CRATE
		{pos = Vector(1089,-657,-8156), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_THIRD_LOOT"}, -- BIG_YELLOW_ROOM-1
		{pos = Vector(496,-1097,-8145), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_ADDITIONAL_LOOT"}, -- 914-CRATE
		{pos = Vector(533,-1116,-8158), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_ADDITIONAL_LOOT"}, -- SCP_914-1
		--{pos = Vector(2460,-970,-8503), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_ADDITIONAL_LOOT"}, -- WATER_ROOM-CRATE
		--{pos = Vector(2394,-1062,-8170), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_SECOND_LOOT"}, -- WATER_ROOM-1
		{pos = Vector(1674,-1753,-8157), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_SECOND_LOOT"}, -- SCP_205-1
		{pos = Vector(1932,-1491,-8157), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_ADDITIONAL_LOOT"}, -- SCP_205-2
		{pos = Vector(-2024,-543,-8158), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_THIRD_LOOT"}, -- SCP_372-1
		{pos = Vector(-2517,-579,-8165), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_THIRD_LOOT"}, -- SCP_372-BOX
		{pos = Vector(-1952,-1103,-8179), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_SCP_372"}, -- SCP_372-CRATE
		{pos = Vector(2262,492,-8165), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_FIRST_LOOT"}, -- LONG_HALLWAY-BOX
		{pos = Vector(617,-2392,-8170), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_SECURITY_GATEWAY"}, -- SECURITY_GATEWAY-BOX
		{pos = Vector(441,-1421,-8134), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_ARMORY_LOOT"}, -- ARMORY-CRATE1
		{pos = Vector(712,-1684,-8159), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_ARMORY_LOOT"}, -- ARMORY-CRATE2
		{pos = Vector(-176,-1202,-8176), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_FIRST_LOOT"}, -- SKULL-1
		{pos = Vector(-553,-42,-8147), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_SECOND_LOOT"}, -- NEAR_CHECKPOINT_STORAGE_ROOM-CRATE
		{pos = Vector(237,97,-8165), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_ADDITIONAL_LOOT"}, -- SCARE_ROOM_HIDING-BOX
		{pos = Vector(1518,880,-8167), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_SCP_500"}, -- SCARE_ROOM_HIDING-BOX
		{pos = Vector(-338,2070,-8036), canSee = DefaultItemContainerCanSee, item_gen_group = "LCZ_FIRST_LOOT"}, -- 173CELL



		--HCZ
		{pos = Vector(-1160,1099,-7133), canSee = DefaultItemContainerCanSee, item_gen_group = "HCZ_SECOND"}, -- OLD_KINDA_ARMORY-CRATE-UP
		{pos = Vector(-1175,1098,-7109), canSee = DefaultItemContainerCanSee, item_gen_group = "HCZ_SECOND"}, -- OLD_KINDA_ARMORY-CRATE-DOWN
		{pos = Vector(-1078,1197,-7121), canSee = DefaultItemContainerCanSee, item_gen_group = "HCZ_SECOND"}, -- OLD_KINDA_ARMORY-CRATE-THIRD

		{pos = Vector(-2188,3126,-7141), canSee = DefaultItemContainerCanSee, item_gen_group = "HCZ_FIRST"}, -- SCP_457-BOX
		{pos = Vector(-2468,3125,-7152), canSee = DefaultItemContainerCanSee, item_gen_group = "HCZ_FIRST"}, -- SCP_457-1
		{pos = Vector(1554,1725,-7379), canSee = DefaultItemContainerCanSee, item_gen_group = "HCZ_TOXIC_ROOM"}, -- TOXIC_ROOM-CRATE
		{pos = Vector(1691,2824,-7134), canSee = DefaultItemContainerCanSee, item_gen_group = "HCZ_FIRST"}, -- NEAR_EZ_CHECKPOINT-1
		{pos = Vector(1258,538,-7124), canSee = DefaultItemContainerCanSee, item_gen_group = "HCZ_FIRST"}, -- NEAR_CHECKPOINT-CRATE
		{pos = Vector(368,643,-7141), canSee = DefaultItemContainerCanSee, item_gen_group = "HCZ_035"}, -- SCP_035-BOX
		{pos = Vector(331,638,-7156), canSee = DefaultItemContainerCanSee, item_gen_group = "HCZ_035"}, -- SCP_035-CRATE1
		{pos = Vector(297,647,-7156), canSee = DefaultItemContainerCanSee, item_gen_group = "HCZ_035"}, -- SCP_035-CRATE2
		{pos = Vector(9,4494,-7269), canSee = DefaultItemContainerCanSee, item_gen_group = "HCZ_FIRST"}, -- UNDER_GAS-BOX
		{pos = Vector(184,5043,-7134), canSee = DefaultItemContainerCanSee, item_gen_group = "HCZ_FIRST"}, -- NEAR_GAS-1
		{pos = Vector(-1496,3648,-7121), canSee = DefaultItemContainerCanSee, item_gen_group = "HCZ_FIRST"}, -- GREEN_ROOM-1
		{pos = Vector(-3038,3340,-7142), canSee = DefaultItemContainerCanSee, item_gen_group = "HCZ_SECOND"}, -- DEAD_SCIENTIST_ROOM-CRATE
		{pos = Vector(-3811,4209,-7141), canSee = DefaultItemContainerCanSee, item_gen_group = "HCZ_FIRST"}, -- NEAR_SCP_079-BOX
		{pos = Vector(-3843,4603,-7254), canSee = DefaultItemContainerCanSee, item_gen_group = "HCZ_FIRST"}, -- SCP_079-CRATE
		{pos = Vector(-2563,5380,-7397), canSee = DefaultItemContainerCanSee, item_gen_group = "HCZ_FIRST"}, -- SCP_682-CRATE
		{pos = Vector(-2604,5378,-7389), canSee = DefaultItemContainerCanSee, item_gen_group = "HCZ_SCP_682_DOC"}, -- SCP_682-1
		{pos = Vector(-2701,6795,-7406), canSee = DefaultItemContainerCanSee, item_gen_group = "HCZ_FIRST"}, -- SCP_106-BOX
		{pos = Vector(-2775,6795,-7379), canSee = DefaultItemContainerCanSee, item_gen_group = "HCZ_GUNS"}, -- SCP_106-BIGCRATE
		{pos = Vector(-2369,4446,-7128), canSee = DefaultItemContainerCanSee, item_gen_group = "HCZ_GUNS"}, -- STORAGE_ROOM-BIGCRATE
		{pos = Vector(-2488,4513,-7133), canSee = DefaultItemContainerCanSee, item_gen_group = "HCZ_SECOND"}, -- STORAGE_ROOM-1
		{pos = Vector(-2744,4513,-7133), canSee = DefaultItemContainerCanSee, item_gen_group = "HCZ_SECOND"}, -- STORAGE_ROOM-2
		{pos = Vector(-2895,4320,-7126), canSee = DefaultItemContainerCanSee, item_gen_group = "HCZ_SECOND"}, -- STORAGE_ROOM-BOX
		{pos = Vector(456,3907,-7121), canSee = DefaultItemContainerCanSee, item_gen_group = "HCZ_FIRST"}, -- SCP_096-BOX
		{pos = Vector(-3566,5310,-7133), canSee = DefaultItemContainerCanSee, item_gen_group = "HCZ_GUNS"}, -- HCZ-STORAGEROOM-WITH-OUTFITTER-1
		{pos = Vector(-1555,4633,-7145), canSee = DefaultItemContainerCanSee, item_gen_group = "HCZ_008"}, -- HCZ-008-1
		{pos = Vector(4211,-6794,-8581), canSee = DefaultItemContainerCanSee, item_gen_group = "HCZ_049"}, -- SCP_049-CLOSETROOM-BOX
		{pos = Vector(3930,-6325,-8559), canSee = DefaultItemContainerCanSee, item_gen_group = "HCZ_049"}, -- SCP_049-CASE
		{pos = Vector(5859,-960,-11544), canSee = DefaultItemContainerCanSee, item_gen_group = "HCZ_TUNNELS_LOOT"}, -- HCZ_TUNNELS-BIGCRATE
		{pos = Vector(3692,-363,-7155), canSee = DefaultItemContainerCanSee, item_gen_group = "HCZ_SECOND"}, -- HCZ_WARHEADROOM-BOX
		{pos = Vector(3840,-173,-7149), canSee = DefaultItemContainerCanSee, item_gen_group = "HCZ_SECOND"}, -- HCZ_WARHEADROOM-DRAWER_RIGHT
		{pos = Vector(3703,-703,-7149), canSee = DefaultItemContainerCanSee, item_gen_group = "HCZ_SECOND"}, -- HCZ_WARHEADROOM-DRAWER_LEFT



-- ENTRANCE ZONE
		{pos = Vector(1861,4113,-7151), canSee = DefaultItemContainerCanSee, item_gen_group = "EZ_OFFICES"}, -- OFFICE_1B-1 / CODE
		{pos = Vector(1936,4103,-7141), canSee = DefaultItemContainerCanSee, item_gen_group = "EZ_OFFICES"}, -- OFFICE_1A-BOX / CODE
		{pos = Vector(2060,3910,-7150), canSee = DefaultItemContainerCanSee, item_gen_group = "EZ_OFFICES"}, -- OFFICE_1A-1 / CODE
		{pos = Vector(2837,5272,-7118), canSee = DefaultItemContainerCanSee, item_gen_group = "EZ_SPECIAL"}, -- SHARED CONF ROOM-CRATE / KEYCARD
		{pos = Vector(4228,4606,-7272), canSee = DefaultItemContainerCanSee, item_gen_group = "EZ"}, -- CAFETERIA-BOX
		{pos = Vector(3029,4117,-7215), canSee = DefaultItemContainerCanSee, item_gen_group = "EZ"}, -- 2LEVEL_OFFICE1-1
		{pos = Vector(3147,4124,-7215), canSee = DefaultItemContainerCanSee, item_gen_group = "EZ"}, -- 2LEVEL_OFFICE1-2
		{pos = Vector(3343,4118,-7215), canSee = DefaultItemContainerCanSee, item_gen_group = "EZ"}, -- 2LEVEL_OFFICE1-3
		{pos = Vector(3388,6023,-7214), canSee = DefaultItemContainerCanSee, item_gen_group = "EZ"}, -- 2LEVEL_OFFICE2-1
		{pos = Vector(4447,6764,-7141), canSee = DefaultItemContainerCanSee, item_gen_group = "EZ"}, -- SECURITY_GATEWAY1-BOX
		{pos = Vector(4403,6765,-7133), canSee = DefaultItemContainerCanSee, item_gen_group = "EZ"}, -- SECURITY_GATEWAY1-1
		{pos = Vector(5344,7271,-7133), canSee = DefaultItemContainerCanSee, item_gen_group = "EZ_CONFROOM"}, -- CONFERENCE_ROOM-1
		{pos = Vector(5344,7303,-7133), canSee = DefaultItemContainerCanSee, item_gen_group = "EZ_CONFROOM"}, -- CONFERENCE_ROOM-2
		{pos = Vector(5344,7335,-7133), canSee = DefaultItemContainerCanSee, item_gen_group = "EZ_CONFROOM"}, -- CONFERENCE_ROOM-3
		{pos = Vector(5344,7367,-7133), canSee = DefaultItemContainerCanSee, item_gen_group = "EZ_CONFROOM"}, -- CONFERENCE_ROOM-4
		{pos = Vector(5344,7629,-7133), canSee = DefaultItemContainerCanSee, item_gen_group = "EZ_CONFROOM"}, -- CONFERENCE_ROOM-5
		{pos = Vector(5344,7661,-7133), canSee = DefaultItemContainerCanSee, item_gen_group = "EZ_CONFROOM"}, -- CONFERENCE_ROOM-6
		{pos = Vector(5344,7693,-7133), canSee = DefaultItemContainerCanSee, item_gen_group = "EZ_CONFROOM"}, -- CONFERENCE_ROOM-7
		{pos = Vector(5344,7725,-7133), canSee = DefaultItemContainerCanSee, item_gen_group = "EZ_CONFROOM"}, -- CONFERENCE_ROOM-8
		{pos = Vector(5062,7778,-6959), canSee = DefaultItemContainerCanSee, item_gen_group = "EZ_SPECIAL"}, -- ELECTRICAL_CENTER-CRATE
		{pos = Vector(5032,7418,-6972), canSee = DefaultItemContainerCanSee, item_gen_group = "EZ_SPECIAL"}, -- ELECTRICAL_CENTER-BIGCRATE
		{pos = Vector(2007,5552,-7141), canSee = DefaultItemContainerCanSee, item_gen_group = "EZ_OFFICES"},  -- OFFICE_2A-BOX / CODE
		{pos = Vector(1793,5577,-7102), canSee = DefaultItemContainerCanSee, item_gen_group = "EZ_2B_BOXES"},  -- OFFICE_2B-BOXES1 / CODE
		{pos = Vector(1805,5586,-7139), canSee = DefaultItemContainerCanSee, item_gen_group = "EZ_2B_BOXES"},  -- OFFICE_2B-BOXES2 / CODE
		{pos = Vector(1739,5590,-7127), canSee = DefaultItemContainerCanSee, item_gen_group = "EZ_2B_BOXES"},  -- OFFICE_2B-BOXES3 / CODE
		{pos = Vector(1869,5569,-7098), canSee = DefaultItemContainerCanSee, item_gen_group = "EZ_2B_BOXES"},  -- OFFICE_2B-BOXES4 / CODE
		{pos = Vector(3138,7022,-7150), canSee = DefaultItemContainerCanSee, item_gen_group = "EZ"}, -- BASIC_OFFICE_1-1
		{pos = Vector(3087,6735,-7152), canSee = DefaultItemContainerCanSee, item_gen_group = "EZ"}, -- BASIC_OFFICE_1-2
		{pos = Vector(4445,5924,-7147), canSee = DefaultItemContainerCanSee, item_gen_group = "EZ"}, -- BASIC_OFFICE_2-1
		{pos = Vector(4447,5823,-7152), canSee = DefaultItemContainerCanSee, item_gen_group = "EZ"}, -- BASIC_OFFICE_2-2
		{pos = Vector(4276,5903,-7153), canSee = DefaultItemContainerCanSee, item_gen_group = "EZ"}, -- BASIC_OFFICE_2-3
		{pos = Vector(4163,6170,-7119), canSee = DefaultItemContainerCanSee, item_gen_group = "EZ_SPECIAL"}, -- BASIC_OFFICE_2-CRATE
		{pos = Vector(1099,6093,-7249), canSee = DefaultItemContainerCanSee, item_gen_group = "EZ_SPECIAL"}, -- 2LEVEL_OFFICE2-CRATE
		{pos = Vector(1328,6040,-7284), canSee = DefaultItemContainerCanSee, item_gen_group = "EZ"}, -- 2LEVEL_OFFICE2-1
		{pos = Vector(1443,6219,-7273), canSee = DefaultItemContainerCanSee, item_gen_group = "EZ"}, -- 2LEVEL_OFFICE2-BOX
		{pos = Vector(1917,6158,-7112), canSee = DefaultItemContainerCanSee, item_gen_group = "EZ"}, -- DARK_ROOM / KEYCARD
		{pos = Vector(5414,5251,-7389), canSee = DefaultItemContainerCanSee, item_gen_group = "EZ"}, -- SERVER_HUB-1
		{pos = Vector(5812,4740,-7397), canSee = DefaultItemContainerCanSee, item_gen_group = "EZ"}, -- SERVER_HUB-BOX / KEYCARD / HIDDEN
		{pos = Vector(5818,5750,-7140), canSee = DefaultItemContainerCanSee, item_gen_group = "EZ"}, -- SECURITY_GATEWAY2-CRATE
		{pos = Vector(5795,6008,-7134), canSee = DefaultItemContainerCanSee, item_gen_group = "EZ"}, -- SECURITY_GATEWAY2-1
		{pos = Vector(5304,6362,-7082), canSee = DefaultItemContainerCanSee, item_gen_group = "EZ_HEADOFFICE"}, -- HEAD_OFFICE-BOX
		{pos = Vector(5190,6288,-7087), canSee = DefaultItemContainerCanSee, item_gen_group = "EZ_HEADOFFICE"}, -- HEAD_OFFICE-1
		{pos = Vector(1373,5028,-7111), canSee = DefaultItemContainerCanSee, item_gen_group = "EZ"}, -- MEDBAY-CRATE
		{pos = Vector(1518,5271,-7115), canSee = DefaultItemContainerCanSee, item_gen_group = "EZ_MEDBAY"}, -- MEDBAY-FIRSTAID_STATION
		{pos = Vector(6983,4683,-6992), canSee = DefaultItemContainerCanSee, item_gen_group = "EZ"}, -- GATEB
		{pos = Vector(4852,5174,-7111), canSee = DefaultItemContainerCanSee, item_gen_group = "EZ_EVAC_SHELTER_WEAPONS"},
		{pos = Vector(4862,5191,-7124), canSee = DefaultItemContainerCanSee, item_gen_group = "EZ_EVAC_SHELTER_ITEMS"},
		{pos = Vector(4839,5159,-7123), canSee = DefaultItemContainerCanSee, item_gen_group = "EZ_EVAC_SHELTER_AMMO"},
		{pos = Vector(4698,7686,-6990), canSee = DefaultItemContainerCanSee, item_gen_group = "EZ_DOC_MSP"},
		{pos = Vector(2197,6226,-7116), canSee = DefaultItemContainerCanSee, item_gen_group = "EZ"},


		--{pos = XXXXXXXXXXXXXXXXXXXXXXXXXX, canSee = DefaultItemContainerCanSee, item_gen_group = "EZ"},
		--{pos = XXXXXXXXXXXXXXXXXXXXXXXXXX, canSee = DefaultItemContainerCanSee, item_gen_group = "EZ"},
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
			--chat.AddText(Color(255, 255, 255), "You cannot change your outfit")
			chat.AddText(Color(255, 255, 255), "You couldn't find anything useful...")
			return
		end
		net.Start("br_use_outfitter")
			net.WriteVector(button.pos)
		net.SendToServer()
	end,
	buttons = {
		{pos = Vector(-777,-707,-8142), canSee = DefaultOutfitterCanSee, item_gen_group = "LCZ"},
		{pos = Vector(960,-1089,-8156), canSee = DefaultOutfitterCanSee, item_gen_group = "LCZ"},
		{pos = Vector(465,256,-8142), canSee = DefaultOutfitterCanSee, item_gen_group = "LCZ"},
		{pos = Vector(-330,-1207,-8158), canSee = DefaultOutfitterCanSee, item_gen_group = "LCZ"},
		{pos = Vector(959,912,-8157), canSee = DefaultOutfitterCanSee, item_gen_group = "LCZ"},
		{pos = Vector(504,-1682,-8157), canSee = DefaultOutfitterCanSee, item_gen_group = "LCZ_ARMORY"},

		{pos = Vector(-3520,5473,-7133), canSee = DefaultOutfitterCanSee, item_gen_group = "HCZ"},
		{pos = Vector(1521,512,-7133), canSee = DefaultOutfitterCanSee, item_gen_group = "HCZ"},
		{pos = Vector(-2636,5378,-7389), canSee = DefaultOutfitterCanSee, item_gen_group = "HCZ"},
		{pos = Vector(-3960,4894,-7273), canSee = DefaultOutfitterCanSee, item_gen_group = "HCZ"},
		{pos = Vector(3872,-173,-7150), canSee = DefaultOutfitterCanSee, item_gen_group = "HCZ"},

		{pos = Vector(5109,6417,-7069), canSee = DefaultOutfitterCanSee, item_gen_group = "EZ_HOFFICE"},
		{pos = Vector(5352,5251,-7389), canSee = DefaultOutfitterCanSee, item_gen_group = "EZ"},
		{pos = Vector(2904,6648,-7133), canSee = DefaultOutfitterCanSee, item_gen_group = "EZ"},
		{pos = Vector(1104,6608,-7249), canSee = DefaultOutfitterCanSee, item_gen_group = "EZ"},
		{pos = Vector(3003,3942,-7197), canSee = DefaultOutfitterCanSee, item_gen_group = "EZ"},
	}
}
