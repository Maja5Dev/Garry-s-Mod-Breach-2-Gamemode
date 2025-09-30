
local function add_drink(class, name, model, thirst, hunger)
	special_item_system.AddItem({
		class = class,
		name = name,
		func = function(pl)
			table.ForceInsert(pl.br_special_items, {class = class})
			return true
		end,
		use = function(pl, item)
			if timer.Exists("drinkuse" .. pl:SteamID64()) then return false end

			if pl.br_thirst > 100 then
				pl:PrintMessage(HUD_PRINTTALK, "You are not thirsty")
				return false
			end

			local delay = 0.1
			if string.find(class, "soda") then
				pl:EmitSound("breach2/soda.wav")
				delay = 2.4
			end

			timer.Create("drinkuse" .. pl:SteamID64(), delay, 1, function()
				pl:AddThirst(-thirst)
				if hunger then
					pl:AddHunger(-hunger)
				end
				pl:EmitSound("breach2/drink.wav")

				if pl.br_thirst > 70 then
					pl:PrintMessage(HUD_PRINTTALK, "You drank the "..name..", your thirst is quenched")
				elseif pl.br_thirst > 35 then
					pl:PrintMessage(HUD_PRINTTALK, "You drank the "..name..", but your thirst hasn't been fully quenched")
				else
					pl:PrintMessage(HUD_PRINTTALK, "You drank the "..name..", you still feel thirsty")
				end

				pl:UpdateHungerThirst()
			end)

			return true
		end,
		onstart = function(pl)
		end,
		drop = function(pl)
			local res, item = br2_special_item_drop(pl, class, name, "prop_physics", model)
			return item
		end
	})
end

local function add_alcohol(class, name, model, thirst, hunger)
	table.ForceInsert(BR2_SPECIAL_ITEMS, {
		class = class,
		name = name,
		func = function(pl)
			table.ForceInsert(pl.br_special_items, {class = class})
			return true
		end,
		use = function(pl, item)
			if timer.Exists("drinkuse" .. pl:SteamID64()) then return end

			local delay = 0.1

			timer.Create("drinkuse" .. pl:SteamID64(), delay, 1, function()
				pl:AddThirst(-thirst)
				if hunger then
					pl:AddHunger(-hunger)
				end

				pl:AddSanity(30)
				pl:BR2_ShowNotification("You drank the "..name..", it tasted nice...")

				pl:StartCustomScreenEffects({
					colour = 1.7,
					blur1 = 0.2,
					blur2 = 0.8,
					blur3 = 0.01,
				}, 30)

				pl:EmitSound("breach2/drink.wav")

				pl:UpdateHungerThirst()
			end)

			return true
		end,
		onstart = function(pl)
		end,
		drop = function(pl)
			local res, item = br2_special_item_drop(pl, class, name, "prop_physics", model)
			return item
		end
	})
end

add_drink("drink_orange_juice", "Orange Juice", "models/foodnhouseholditems/juice.mdl", 30)
add_drink("drink_bottle_water", "Water Bottle", "models/props/cs_office/Water_bottle.mdl", 20)
add_drink("drink_soda", "Can of Soda", "models/props_junk/PopCan01a.mdl", 20)

add_alcohol("drink_wine", "Wine", "models/foodnhouseholditems/wine_white3.mdl", 60, -20)
