
function Buttons_Terminals_TestPos(pos)
	for k,v in pairs(MAPCONFIG.BUTTONS_2D.TERMINALS.buttons) do
		local dist = v.pos:Distance(pos)
		if dist < 25 then
			print(v, dist)
		end
	end
end

-- lua_run Buttons_Terminals_TestPos(Vector(1915,6156,-7112))
MAPCONFIG.BUTTONS_2D.TERMINALS = {
	mat = br_default_button_icons.scpu,
	on_open = function(button)
		BR_Access_Terminal(button)
	end,
	buttons = {
		{name = "lcz_scp1123_contchamber", pos = Vector(-2614,-1327,-9124), canSee = DefaultTerminalCanSee},
		{name = "lcz_lighttesting_room", pos = Vector(345,-1112,-9153), canSee = DefaultTerminalCanSee},
		{name = "lcz_office1", pos = Vector(-1748,-2753,-9174), canSee = DefaultTerminalCanSee},
		{name = "lcz_scp173_contchamber", pos = Vector(-2423,-3469,-8934), canSee = DefaultTerminalCanSee},
		{name = "lcz_surveillance_room", pos = Vector(-3234,-1763,-8996), canSee = DefaultTerminalCanSee},
		{name = "lcz_scp372_contchamber", pos = Vector(1854,-394,-9133), canSee = DefaultTerminalCanSee},
		{name = "lcz_scp500_contchamber", pos = Vector(655,-875,-9167), canSee = DefaultTerminalCanSee},
		{name = "lcz_scp012_contchamber", pos = Vector(-4211,-1135,-9374), canSee = DefaultTerminalCanSee},

		{name = "hcz_scp035_contchamber", pos = Vector(-1666,910,-9133), canSee = DefaultTerminalCanSee},
		{name = "hcz_scp966_contchamber", pos = Vector(-292,2949,-9167), canSee = DefaultTerminalCanSee},
		{name = "hcz_scp106_contchamber", pos = Vector(-6919,2265,-9407), canSee = DefaultTerminalCanSee},
		{name = "hcz_serverroom", pos = Vector(-2647,3916,-9133), canSee = DefaultTerminalCanSee},
		{name = "hcz_scp895_contchamber", pos = Vector(-3979,2925,-9126), canSee = DefaultTerminalCanSee},
		{name = "hcz_scp682_contchamber", pos = Vector(-1794,2296,-9384), canSee = DefaultTerminalCanSee},
		{name = "hcz_warhead_room_a", pos = Vector(398,2676,-8643), canSee = DefaultTerminalCanSee},
		{name = "hcz_warhead_room_b", pos = Vector(359,2676,-8643), canSee = DefaultTerminalCanSee},

		{name = "ez_office1", pos = Vector(-4432,4761,-9227), canSee = DefaultTerminalCanSee},
		{name = "ez_serverfarm", pos = Vector(-4016,5379,-9351), canSee = DefaultTerminalCanSee},
		{name = "ez_serverhub", pos = Vector(-4130,6147,-9402), canSee = DefaultTerminalCanSee},
		{name = "ez_medroom", pos = Vector(-337,5289,-9133), canSee = DefaultTerminalCanSee},
		{name = "ez_cafeteria", pos = Vector(-459,5827,-9293), canSee = DefaultTerminalCanSee},
		{name = "ez_conference_room1", pos = Vector(-2267,6862,-9167), canSee = DefaultTerminalCanSee},
		{name = "ez_conference_room2", pos = Vector(-705,6926,-9167), canSee = DefaultTerminalCanSee},
		{name = "ez_office2", pos = Vector(-26,6854,-9166), canSee = DefaultTerminalCanSee},
		{name = "ez_gateb_security_gateway", pos = Vector(319,6702,-9166), canSee = DefaultTerminalCanSee},
		{name = "ez_dr_l_office", pos = Vector(-2243,6370,-9167), canSee = DefaultTerminalCanSee},
		{name = "ez_dr_harp_office", pos = Vector(-1813,6435,-9167), canSee = DefaultTerminalCanSee},
		{name = "ez_dr_maynard_office", pos = Vector(-1393,6435,-9167), canSee = DefaultTerminalCanSee},
		{name = "ez_office3_2", pos = Vector(-3070,4906,-9047), canSee = DefaultTerminalCanSee},
		{name = "ez_office3_1", pos = Vector(-2896,5513,-9167), canSee = DefaultTerminalCanSee},
		{name = "ez_headoffice", pos = Vector(-2293,4743,-9097), canSee = DefaultTerminalCanSee},

		{name = "outside_office", pos = Vector(-2412,12521,-2052), canSee = DefaultTerminalCanSee},
	}
}

/*
MAPCONFIG.BUTTONS_2D.UMUSABLE_TERMINALS = {
	mat = br_default_button_icons.scpu,
	on_open = function(button)
		
	end,
	buttons = {
		{name = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", pos = YYYYYYYYYYYYYYYYYYYYYYYY, canSee = DefaultTerminalCanSee},
		{name = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", pos = YYYYYYYYYYYYYYYYYYYYYYYY, canSee = DefaultTerminalCanSee},
		{name = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", pos = YYYYYYYYYYYYYYYYYYYYYYYY, canSee = DefaultTerminalCanSee},
		{name = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", pos = YYYYYYYYYYYYYYYYYYYYYYYY, canSee = DefaultTerminalCanSee},
		{name = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", pos = YYYYYYYYYYYYYYYYYYYYYYYY, canSee = DefaultTerminalCanSee},
	}
}
*/

MAPCONFIG.BUTTONS_2D.BROKEN_TERMINALS = {
	mat = br_default_button_icons.scpu,
	on_open = function(button)
		BR_Access_BrokenTerminal(button)
	end,
	buttons = {
		/*
		{pos = YYYYYYYYYYYYYYYYYYYYYYYY, spraks = true, sounds = 1, canSee = DefaultTerminalCanSee},
		{pos = YYYYYYYYYYYYYYYYYYYYYYYY, spraks = true, sounds = 1, canSee = DefaultTerminalCanSee},
		{pos = YYYYYYYYYYYYYYYYYYYYYYYY, spraks = true, sounds = 1, canSee = DefaultTerminalCanSee},
		{pos = YYYYYYYYYYYYYYYYYYYYYYYY, spraks = true, sounds = 1, canSee = DefaultTerminalCanSee},
		{pos = YYYYYYYYYYYYYYYYYYYYYYYY, spraks = true, sounds = 1, canSee = DefaultTerminalCanSee},
		{pos = YYYYYYYYYYYYYYYYYYYYYYYY, spraks = true, sounds = 1, canSee = DefaultTerminalCanSee},
		{pos = YYYYYYYYYYYYYYYYYYYYYYYY, spraks = true, sounds = 1, canSee = DefaultTerminalCanSee},
		{pos = YYYYYYYYYYYYYYYYYYYYYYYY, spraks = true, sounds = 1, canSee = DefaultTerminalCanSee},
		*/
	}
}

print("[Breach2] Shared/Buttons/Terminals mapconfig loaded!")