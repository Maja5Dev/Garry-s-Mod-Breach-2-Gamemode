
MAPCONFIG.BUTTONS_2D.HIDING_CLOSETS = {
	mat = br_default_button_icons.scu_hiding,
	on_open = function(button)
		TryToHideInCloset(button)
	end,
	buttons = {
		{
			pos = Vector(-6052,9741,-262),
			outside_func = function(ply)
				ply:SetPos(Vector(-6028, 9763, -312))
				ply:SetEyeAngles(Angle(0, 45, 0))
			end,
			inside_func = function(ply, ent)
				ply:SetPos(Vector(-6071, 9724, -270))
				ent:SetAngles(Angle(0, 45, 0))
			end,
			peeking_pos = Vector(-6052,9741,-262),
			canSee = DefaultItemContainerCanSee
		}, -- LCZ_CLASSD_CAFETERIA-FREEZER


		{
			pos = XXXXXXXXXXXXXXXXXXXXXXX,
			outside_func = function(ply)
				ply:SetPos(XXXXXXXXXXXXXXXXXXXXXXX)
				ply:SetEyeAngles(Angle(0,90,0))
			end,
			inside_func = function(ply, ent)
				ply:SetPos(XXXXXXXXXXXXXXXXXXXXXXX)
				ent:SetAngles(Angle(0,90,0))
			end,
			peeking_pos = XXXXXXXXXXXXXXXXXXXXXXX,
			canSee = DefaultItemContainerCanSee
		}, -- YYYYYYYYYYYYYYYYYYYYY
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
		/*
		{name = "LCZ_Radio", pos = Vector(8979,-2866,195), canSee = DefaultItemContainerCanSee,
		func_cl = function() surface.PlaySound("radio/buzz.ogg") end,
		func_sv = function(ply)
			if br_next_radio_play < CurTime() then
				local radio_pos = Vector(8979,-2866,195)
				if math.random(5,18) == 15 then
					sound.Play("radio/soulja.mp3", radio_pos, 60, 100, 1)
					br_next_radio_play = CurTime() + 220
				else
					sound.Play("radio/radio_whole.mp3", radio_pos, 60, 100, 1)
					br_next_radio_play = CurTime() + 240
				end
			end
		end},
		*/
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
			class = "bottle_water",
			name = "Water Bottle"
		},
		*/
	}
}

print("[Breach2] Shared/Buttons/Others mapconfig loaded!")
