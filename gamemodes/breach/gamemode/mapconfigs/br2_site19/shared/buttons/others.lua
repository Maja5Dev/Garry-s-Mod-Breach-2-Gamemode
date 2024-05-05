
MAPCONFIG.BUTTONS_2D.HIDING_CLOSETS = {
	mat = button_icons.scu_hiding,
	on_open = function(button)
		TryToHideInCloset(button)
	end,
	buttons = {
		{
			pos = Vector(7513,-5099,169),
			outside_func = function(ply)
				ply:SetPos(Vector(7514, -5056, 144))
				ply:SetEyeAngles(Angle(0,90,0))
			end,
			inside_func = function(ply, ent)
				ply:SetPos(Vector(7513, -5117, 180))
				ent:SetAngles(Angle(0,90,0))
			end,
			peeking_pos = Vector(7513,-5097,162),
			canSee = DefaultItemContainerCanSee
		}, -- LCZ_CAFETERIA


		{
			pos = Vector(2105,1326,42),
			outside_func = function(ply)
				ply:SetPos(Vector(2103, 1304, 24))
				ply:SetEyeAngles(Angle(0,-90,0))
			end,
			inside_func = function(ply, ent)
				ply:SetPos(Vector(2102, 1348, 63))
				ent:SetAngles(Angle(0,-90,0))
			end,
			peeking_pos = Vector(2105,1325,64),
			canSee = DefaultItemContainerCanSee
		}, -- HCZ_STORAGE_ROOM
		

		{
			pos = Vector(2456,1325,38),
			outside_func = function(ply)
				ply:SetPos(Vector(2455, 1296, 24))
				ply:SetEyeAngles(Angle(0,-90,0))
			end,
			inside_func = function(ply, ent)
				ply:SetPos(Vector(2454, 1343, 60))
				ent:SetAngles(Angle(0,-90,0))
			end,
			peeking_pos = Vector(2456,1325,56),
			canSee = DefaultItemContainerCanSee
		}, -- HCZ_OFFICE		


		{
			pos = Vector(1952,1598,39),
			outside_func = function(ply)
				ply:SetPos(Vector(1952, 1578, 34))
				ply:SetEyeAngles(Angle(0,-90,0))
			end,
			inside_func = function(ply, ent)
				ply:SetPos(Vector(1952, 1619, 61))
				ent:SetAngles(Angle(0,-90,0))
			end,
			peeking_pos = Vector(1952,1598,60),
			canSee = DefaultItemContainerCanSee
		}, -- HCZ_OFFICE

		{
			pos = Vector(2221,5214,-217),
			outside_func = function(ply)
				ply:SetPos(Vector(2218, 5185, -240))
				ply:SetEyeAngles(Angle(0,-90,0))
			end,
			inside_func = function(ply, ent)
				ply:SetPos(Vector(2219, 5226, -188))
				ent:SetAngles(Angle(0,-90,0))
			end,
			peeking_pos = Vector(2221,5214,-197),
			canSee = DefaultItemContainerCanSee
		}, -- HCZ_SCP_106

		{
			pos = Vector(5304,-1109,39),
			outside_func = function(ply)
				ply:SetPos(Vector(5306, -1087, 14))
				ply:SetEyeAngles(Angle(0,90,0))
			end,
			inside_func = function(ply, ent)
				ply:SetPos(Vector(5303, -1125, 80.283554))
				ent:SetAngles(Angle(0,90,0))
			end,
			peeking_pos = Vector(5304,-1110,61),
			canSee = DefaultItemContainerCanSee
		}, -- HCZ_SCP_035

		{
			pos = Vector(2942,2004,39),
			outside_func = function(ply)
				ply:SetPos(Vector(2916, 2003, 24))
				ply:SetEyeAngles(Angle(0,-180,0))
			end,
			inside_func = function(ply, ent)
				ply:SetPos(Vector(2954, 1999, 49))
				ent:SetAngles(Angle(0,-180,0))
			end,
			peeking_pos = Vector(2942,2004,60),
			canSee = DefaultItemContainerCanSee
		}, -- HCZ_SOUTH_EAST_CORRIDOR

		{
			pos = Vector(6818,2590,38),
			outside_func = function(ply)
				ply:SetPos(Vector(6821, 2566, 16))
				ply:SetEyeAngles(Angle(0,-90,0))
			end,
			inside_func = function(ply, ent)
				ply:SetPos(Vector(6817, 2609, 22))
				ent:SetAngles(Angle(0,-90,0))
			end,
			peeking_pos = Vector(6818,2590,62),
			canSee = DefaultItemContainerCanSee
		}, -- HCZ_SCP_457
	}
}


MAP_SCP_294_Coins = 0

br_next_radio_play = 0

MAPCONFIG.BUTTONS_2D.SIMPLE = {
	mat = button_icons.scpu,
	on_open = function(button)
		SimpleButtonUse(button)
	end,
	buttons = {
		{name = "SCP-1162", pos = Vector(6971,-2634,47), canSee = DefaultItemContainerCanSee, func_cl = function() surface.PlaySound("breach2/pickitem2.ogg") end,  func_sv = function(ply)
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
				local rnd_classes = {"keycard_master", "keycard_playing", "item_battery_9v", "item_radio", "keycard_level1", "keycard_level2", "item_gasmask"}
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
					ent:SetPos(Vector(6979,-2634,47))
					ent:SetNWBool("isDropped", true)
					ent:Spawn()
					if istable(rnd_class) then
						rnd_class[2](ply, ent)
					end
					ply:StripWeapon(rnd_wep:GetClass())
				end
			end
		end},
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
	}
}

MAPCONFIG.BUTTONS_2D.SODAMACHINES = {
	mat = button_icons.scpu,
	on_open = function(button)
		SodaMachineUse(button)
	end,
	buttons = {
		/*
		-- 2nd O   8 clicks inside
		{
			pos = Vector(7140,-2903,-10979),
			pos_out = Vector(2603.902832, 5670.911621, -7150.751465),
			ang_out = Angle(0.888, -179.828, -89.229),
			pos_inside = Vector(7120,-2917,-10981),
			canSee = DefaultItemContainerCanSee,
			mdl = "models/props/cs_office/Water_bottle.mdl",
			class = "bottle_water",
			name = "Water Bottle"
		},
		*/
	}
}

print("[Breach2] Shared/Buttons/Others mapconfig loaded!")
