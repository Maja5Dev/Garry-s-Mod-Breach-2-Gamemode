
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
	mat = button_icons.scpu,
	on_open = function(button)
		BR_Access_Terminal(button)
	end,
	buttons = {
		{name = "lcz_classd_area_office", pos = Vector(7364,-1880,-778), canSee = DefaultTerminalCanSee},
		{name = "lcz_contchamber_scp914", pos = Vector(10375,-1477,-792), canSee = DefaultTerminalCanSee},
		{name = "lcz_contchamber_scp173", pos = Vector(6272,543,-792), canSee = DefaultTerminalCanSee},

		{name = "rz_techlab", pos = Vector(7809,1865,-1114), canSee = DefaultTerminalCanSee},
		{name = "rz_aqualab", pos = Vector(8827,3503,-1047), canSee = DefaultTerminalCanSee},
		{name = "rz_command_room", pos = Vector(10690,2441,-1183), canSee = DefaultTerminalCanSee},

		{name = "checkpoint_lcz_to_hcz_east", pos = Vector(3768,-927,-918), canSee = DefaultTerminalCanSee},
		{name = "checkpoint_lcz_to_hcz_west", pos = Vector(3768,1297,-919), canSee = DefaultTerminalCanSee},

		{name = "hcz_contchamber_scp682", pos = Vector(1916,-2711,-1063), canSee = DefaultTerminalCanSee},
		{name = "hcz_contchamber_scp079", pos = Vector(1427,-2622,-1048), canSee = DefaultTerminalCanSee},
		{name = "hcz_contchamber_scp096", pos = Vector(2841,-1357,-920), canSee = DefaultTerminalCanSee},
		{name = "hcz_contchamber_scp035", pos = Vector(2632,45,-920), canSee = DefaultTerminalCanSee},
		{name = "hcz_contchamber_scp457", pos = Vector(2647,2365,-920), canSee = DefaultTerminalCanSee},
		{name = "hcz_contchamber_scp049", pos = Vector(2364,3143,-1393), canSee = DefaultTerminalCanSee},
		{name = "hcz_contchamber_scp106", pos = Vector(2106,1454,-1177), canSee = DefaultTerminalCanSee},
		{name = "hcz_contchamber_scp939", pos = Vector(4563,2481,-1409), canSee = DefaultTerminalCanSee},
		{name = "ez_directors_office", pos = Vector(1362,-571,-917), canSee = DefaultTerminalCanSee},
		{name = "ez_office_1_2", pos = Vector(681,-329,-920), canSee = DefaultTerminalCanSee},


		/*
		{name = "XXXXX", pos = XXXXXXXXXXXXXXXXXXXXXXX, canSee = DefaultTerminalCanSee},
		{name = "XXXXX", pos = XXXXXXXXXXXXXXXXXXXXXXX, canSee = DefaultTerminalCanSee},
		{name = "XXXXX", pos = XXXXXXXXXXXXXXXXXXXXXXX, canSee = DefaultTerminalCanSee},
		{name = "XXXXX", pos = XXXXXXXXXXXXXXXXXXXXXXX, canSee = DefaultTerminalCanSee},
		{name = "XXXXX", pos = XXXXXXXXXXXXXXXXXXXXXXX, canSee = DefaultTerminalCanSee},
		{name = "XXXXX", pos = XXXXXXXXXXXXXXXXXXXXXXX, canSee = DefaultTerminalCanSee},
		{name = "XXXXX-YYY", pos = XXXXXXXXXXXXXXXXXXXXXXX, canSee = function() return CanSeeFrom(XXXXXXXXXXXXXXXXXXXXXXX) end},
		{name = "XXXXX-YYY", pos = XXXXXXXXXXXXXXXXXXXXXXX, canSee = function() return CanSeeFrom(XXXXXXXXXXXXXXXXXXXXXXX) end},
		{name = "XXXXX-YYY", pos = XXXXXXXXXXXXXXXXXXXXXXX, canSee = function() return CanSeeFrom(XXXXXXXXXXXXXXXXXXXXXXX) end},
		*/
	}
}

/*
MAPCONFIG.BUTTONS_2D.UMUSABLE_TERMINALS = {
	mat = button_icons.scpu,
	on_open = function(button)
		
	end,
	buttons = {
		{name = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", pos = YYYYYYYYYYYYYYYYYYYYYYYY, canSee = DefaultTerminalCanSee},
		{name = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", pos = YYYYYYYYYYYYYYYYYYYYYYYY, canSee = DefaultTerminalCanSee},
	}
}
*/

MAPCONFIG.BUTTONS_2D.BROKEN_TERMINALS = {
	mat = button_icons.scpu,
	on_open = function(button)
		BR_Access_BrokenTerminal(button)
	end,
	buttons = {
		/*
		{pos = YYYYYYYYYYYYYYYYYYYYYYYY, spraks = true, sounds = 1, canSee = DefaultTerminalCanSee},
		{pos = YYYYYYYYYYYYYYYYYYYYYYYY, spraks = true, sounds = 1, canSee = DefaultTerminalCanSee},
		*/
	}
}

print("[Breach2] Shared/Buttons/Terminals mapconfig loaded!")