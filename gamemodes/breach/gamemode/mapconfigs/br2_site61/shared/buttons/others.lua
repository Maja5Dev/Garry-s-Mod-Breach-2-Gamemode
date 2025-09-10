
MAPCONFIG.BUTTONS_2D.HIDING_CLOSETS = {
	mat = br_default_button_icons.scu_hiding,
	on_open = function(button)
		TryToHideInCloset(button)
	end,
	buttons = {
        /*
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
        */
	}
}

MAP_SCP_294_Coins = 0

MAPCONFIG.BUTTONS_2D.SIMPLE = {
	mat = br_default_button_icons.scpu,
	on_open = function(button)
		SimpleButtonUse(button)
	end,
	buttons = {
		{name = "SCP-294-Keyboard", pos = Vector(3427,4736,-7242), canSee = DefaultItemContainerCanSee, func_cl = function()
		end, func_sv = function(ply)
			if MAP_SCP_294_Coins == 2 then
				ply:SendLua("OpenSCP_294()")
			elseif MAP_SCP_294_Coins == 1 then
				ply:PrintMessage(HUD_PRINTTALK, "You need to insert one more coin")
			else
				ply:PrintMessage(HUD_PRINTTALK, "You need to insert two coins")
			end
		end},

		{name = "SCP-294-Coiner", pos = Vector(3427,4755,-7239), canSee = DefaultItemContainerCanSee, func_cl = function()
		end, func_sv = function(ply)
			if MAP_SCP_294_Coins == 2 then
				ply:PrintMessage(HUD_PRINTTALK, "Coins are already in")
			else
				for k,v in pairs(ply.br_special_items) do
					if v.class == "coin" then
						ply:PrintMessage(HUD_PRINTTALK, "Inserted a coin in")
						sound.Play("ambient/office/coinslot1.wav", Vector(3427,4755,-7239), 75, 100, 1)
						MAP_SCP_294_Coins = MAP_SCP_294_Coins + 1
						table.RemoveByValue(ply.br_special_items, v)
						return
					end
				end
				ply:PrintMessage(HUD_PRINTTALK, "You don't have any coins!")
			end
		end},

		{name = "SCP-1162", pos = Vector(903,882,-8143), canSee = DefaultItemContainerCanSee, func_cl = function() surface.PlaySound("breach2/pickitem2.ogg") end,  func_sv = function(ply)
			local weps = {}
			for k,v in pairs(ply:GetWeapons()) do
				if v.Pickupable == true or v.droppable == true then
					table.ForceInsert(weps, v)
				end
			end
			if table.Count(weps) == 0 then
				ply:TakeDamage(20, ply, ply)
			else
				local rnd_wep = table.Random(weps)
				local rnd_classes = {"keycard_master", "keycard_playing", "item_battery_9v", "item_pills", "item_radio", "keycard_level1", "keycard_level2", "item_gasmask"}
				--for k,v in pairs(BR2_SPECIAL_ITEMS) do
				--	if v.scp_1162_class then table.ForceInsert(rnd_classes, {v.scp_1162_class, v.scp_1162}) end
				--end
				
				local rnd_class = table.Random(rnd_classes)
				local ent = nil
				if istable(rnd_class) then
					ent = ents.Create(rnd_class[1])
				else
					ent = ents.Create(rnd_class)
				end
				if IsValid(ent) then
					ent:SetPos(Vector(893,882,-8144))
					ent:SetNWBool("isDropped", true)
					ent:Spawn()
					if istable(rnd_class) then
						rnd_class[2](ply, ent)
					end
					ply:StripWeapon(rnd_wep:GetClass())
				end
			end
		end},
	}
}

MAPCONFIG.BUTTONS_2D.SODAMACHINES = {
	mat = br_default_button_icons.scpu,
	on_open = function(button)
		SodaMachineUse(button)
	end,
	buttons = {
		-- 2nd O   8 clicks inside
		{
			pos = Vector(2603,5649,-7120),
			pos_out = Vector(2603.902832, 5670.911621, -7150.751465),
			ang_out = Angle(0.888, -179.828, -89.229),
			pos_inside = Vector(2609,5672,-7124),
			canSee = DefaultItemContainerCanSee,
			mdl = "models/props/cs_office/Water_bottle.mdl",
			class = "drink_bottle_water",
			name = "Water Bottle"
		},
		{
			pos = Vector(-159,-84,-8144),
			pos_out = Vector(-173.84223937988, -97.615051269531, -8174.0278320313),
			ang_out = Angle(-58.825607299805, 134.92375183105, 89.877410888672),
			pos_inside = Vector(-181,-93,-8148),
			canSee = DefaultItemContainerCanSee,
			mdl = "models/props/cs_office/Water_bottle.mdl",
			class = "drink_bottle_water",
			name = "Water Bottle"
		},
		{
			pos = Vector(1844,6858,-7119),
			pos_out = Vector(1822.7325439453, 6858.8002929688, -7150.1079101563),
			ang_out = Angle(-57.745758056641, 90.007453918457, 90.113433837891),
			pos_inside = Vector(1821,6864,-7124),
			canSee = DefaultItemContainerCanSee,
			mdl = "models/props/cs_office/Water_bottle.mdl",
			class = "drink_bottle_water",
			name = "Water Bottle"
		},
		{
			pos = Vector(3425,5015,-7249),
			pos_out = Vector(3424.176270, 4993.185547, -7278.706055),
			ang_out = Angle(-57.571, -0.910, -90.099),
			pos_inside = Vector(3419,4992,-7253),
			canSee = DefaultItemContainerCanSee,
			mdl = "models/props/cs_office/Water_bottle.mdl",
			class = "drink_bottle_water",
			name = "Water Bottle"
		},
		{
			pos = Vector(5081,4199,-7119),
			pos_out = Vector(5080.18359375, 4177.736328125, -7150.0385742188),
			ang_out = Angle(-1.6739629507065, -0.027127660810947, -89.983245849609),
			pos_inside = Vector(5074,4176,-7124),
			canSee = DefaultItemContainerCanSee,
			mdl = "models/props/cs_office/Water_bottle.mdl",
			class = "drink_bottle_water",
			name = "Water Bottle"
		},
		{
			pos = Vector(3868,4927,-7236),
			pos_out = Vector(3841.672119, 4928.115723, -7270.536621),
			ang_out = Angle(-11.846, 94.118, 86.647),
			pos_inside = Vector(3842,4936,-7242),
			canSee = DefaultItemContainerCanSee,
			mdl = "models/props_junk/PopCan01a.mdl",
			class = "drink_soda",
			name = "Can of Soda"
		}
	}
}
