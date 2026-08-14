
MAPCONFIG.BUTTONS_2D.HIDING_CLOSETS = {
	mat = br_default_button_icons.scu_hiding,
	on_open = function(button)
		TryToHideInCloset(button)
	end,
	buttons = {
	}
}


MAP_SCP_294_Coins = 0

br_next_radio_play = 0

MAPCONFIG.BUTTONS_2D.SIMPLE = {
	mat = br_default_button_icons.scpu,
	on_open = function(button)
		SimpleButtonUse(button)
	end,
	buttons = {
		{name = "SCP-294-Keyboard", pos = Vector(-407,5923,-9283), canSee = DefaultItemContainerCanSee, func_cl = function()
		end, func_sv = function(ply)
			Breach_SCP294_Keyboard(ply)
		end},

		{name = "SCP-294-Coiner", pos = Vector(-407,5901,-9278), canSee = DefaultItemContainerCanSee, func_cl = function()
		end, func_sv = function(ply)
			Breach_SCP294_Coiner(ply, Vector(3427,4755,-7239))
		end},
	}
}

MAPCONFIG.BUTTONS_2D.SODAMACHINES = {
	mat = br_default_button_icons.scpu,
	on_open = function(button)
		SodaMachineUse(button)
	end,
	buttons = {
		/*
		-- 2nd O   8 clicks inside
		{
			pos = XXXXXXXXXXXXXXXXXXXXXXX,
			pos_out = XXXXXXXXXXXXXXXXXXXXXXX,
			ang_out = Angle(0.888, -179.828, -89.229),
			pos_inside = XXXXXXXXXXXXXXXXXXXXXXX,
			canSee = DefaultItemContainerCanSee,
			mdl = "models/props/cs_office/Water_bottle.mdl",
			class = "drink_bottle_water",
			name = "Water Bottle"
		},
		*/
	}
}

print("[Breach2] Shared/Buttons/Others mapconfig loaded!")
