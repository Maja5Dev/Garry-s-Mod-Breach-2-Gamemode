
BR2_FLASHLIGHT_TYPES = {
	{
		name = "Regular Flashlight",
		class = "flashlight_cheap",
		level = 1,
		sound_on = "breach2/flashlight2.wav",
		sound_off = "breach2/flashlight2.wav",
		upgrade = function(ent)
			if br_914status == SCP914_ROUGH or br_914status == SCP914_COARSE then
				return "item_battery_9v"

			elseif br_914status == SCP914_1_1 then
				return "br2_item_flashlight_cheap"

			elseif br_914status == SCP914_FINE then
				return "br2_item_flashlight_normal"

			elseif br_914status == SCP914_VERY_FINE then
				return "br2_item_flashlight_tactical"
			end

			return ent
		end,
		on_use = function(pl)
			pl.flashlight3d:SetKeyValue("enableshadows", 1)
			pl.flashlight3d:SetKeyValue("farz", 400)
			pl.flashlight3d:SetKeyValue("nearz", 8)
			pl.flashlight3d:SetKeyValue("lightfov", 50)
			pl.flashlight3d:SetKeyValue("lightcolor", "180, 180, 80")
			pl.flashlight3d:SetColor(Color(255, 255, 255))
	
			pl.flashlight3d:Fire("SpotlightTexture", "br2_flashlight/flashlight2")
		end
	},
	{
		name = "Heavy Duty Flashlight",
		class = "flashlight_normal",
		level = 2,
		sound_on = "breach2/flashlight3.wav",
		sound_off = "breach2/flashlight3.wav",
		upgrade = function(ent)
			if br_914status == SCP914_ROUGH then
				return "item_battery_9v"
				
			elseif br_914status == SCP914_1_1 then
				return "br2_item_flashlight_normal"

			elseif br_914status == SCP914_FINE then
				return "br2_item_flashlight_tactical"

			elseif br_914status == SCP914_VERY_FINE or br_914status == SCP914_COARSE then
				return "br2_item_flashlight_cheap"
			end

			return ent
		end,
		on_use = function(pl)
			pl.flashlight3d:SetKeyValue("enableshadows", 1)
			pl.flashlight3d:SetKeyValue("farz", 650)
			pl.flashlight3d:SetKeyValue("nearz", 8)
			pl.flashlight3d:SetKeyValue("lightfov", 75)
			pl.flashlight3d:SetKeyValue("lightcolor", "200, 200, 150")
			pl.flashlight3d:SetColor(Color(255, 255, 255))
	
			pl.flashlight3d:Fire("SpotlightTexture", "br2_flashlight/flashlight2")
		end
	},
	{
		name = "Tactical Flashlight",
		class = "flashlight_tactical",
		level = 3,
		sound_on = "breach2/flashlight4_on.wav",
		sound_off = "breach2/flashlight4_off.wav",
		upgrade = function(ent)
			if br_914status == SCP914_ROUGH then
				return "item_battery_9v"

			elseif br_914status == SCP914_1_1 or br_914status == SCP914_FINE then
				return "br2_item_flashlight_tactical"

			elseif br_914status == SCP914_VERY_FINE or br_914status == SCP914_COARSE then
				return "br2_item_flashlight_cheap"
			end
			
			return nil
		end,
		on_use = function(pl)
			pl.flashlight3d:SetKeyValue("enableshadows", 1)
			pl.flashlight3d:SetKeyValue("farz", 2048)
			pl.flashlight3d:SetKeyValue("nearz", 8)
			pl.flashlight3d:SetKeyValue("lightfov", 90)
			pl.flashlight3d:SetKeyValue("lightcolor", "255, 255, 255")
			pl.flashlight3d:SetColor(Color(255, 255, 255))
			
			pl.flashlight3d:Fire("SpotlightTexture", "br2_flashlight/flashlight3")
		end
	},
}

local function add_flashlight(fl_info)
	local fltab = {
		class = fl_info.class,
		name = fl_info.name,

		func = function(pl)
			if !pl:CanUseFlashlight() then
				table.ForceInsert(pl.br_special_items, {class = fl_info.class})
				pl:AllowFlashlight(true)
				return true
			end

			pl:PrintMessage(HUD_PRINTTALK, "You already have a flashlight!")

			return false
		end,
		use = function(pl)
			pl:ForceUseFlashlight(fl_info)
		end,
		drop = function(pl)
			local res, item = br2_special_item_drop(pl, fl_info.class, fl_info.name, "prop_physics", "models/weapons/tfa_nmrih/w_item_maglite.mdl")
			--if res == true then
				if IsValid(pl.flashlight3d) then
					pl.flashlight3d:Remove()
				end
				pl:AllowFlashlight("false")
			--end

			return item
		end,
		scp_1162 = function(pl, ent)
			ent.PrintName = fl_info.name
			ent.SI_Class = fl_info.class
			ForceSetPrintName(ent, ent.PrintName)
		end
	}
    
	-- Spawn normal flashlight for players with a role that needs a flashlight
	if fl_info.class == "flashlight_normal" then
		fltab.onstart = function(pl)
			if pl:CanUseFlashlight() then
				table.ForceInsert(pl.br_special_items, {class = fl_info.class})
			end
		end
	else
		fltab.onstart = nil
	end

    special_item_system.AddItem(fltab)
end

for k,v in pairs(BR2_FLASHLIGHT_TYPES) do
	--add_flashlight(v.class, v.name, v.class2)
	add_flashlight(v)
end
