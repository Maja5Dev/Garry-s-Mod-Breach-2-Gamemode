
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
	mat = br_default_button_icons.scpu,
	on_open = function(button)
		
	end,
	buttons = {
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
		*/
	}
}

print("[Breach2] Shared/Buttons/Terminals mapconfig loaded!")