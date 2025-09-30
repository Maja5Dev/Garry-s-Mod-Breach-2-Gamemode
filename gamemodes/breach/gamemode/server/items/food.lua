
local function add_food(class, name, model, hunger, health)
	special_item_system.AddItem({
		class = class,
		name = name,
		func = function(pl)
			table.ForceInsert(pl.br_special_items, {class = class})
			return true
		end,
		use = function(pl, item)
			if istable(hunger) then
				-- For pizza becoming slices
				for i=1, hunger[2] do
					if #pl.br_special_items > 9 then
						br2_special_item_drop(pl, hunger[1], hunger[3], "prop_physics", hunger[4])
					else
						table.ForceInsert(pl.br_special_items, {class = hunger[1]})
					end
				end
			else
				if pl.br_thirst > 100 then
					pl:PrintMessage(HUD_PRINTTALK, "You are not hungry")
					return false
				end

				pl:AddHunger(-hunger)
				pl:AddHealth(health)

				if pl.br_hunger > 75 then
					pl:PrintMessage(HUD_PRINTTALK, "You ate the "..name..", you feel full")
				elseif pl.br_hunger > 60 then
					pl:PrintMessage(HUD_PRINTTALK, "You ate the "..name..", you feel satisfied")
				elseif pl.br_hunger > 35 then
					pl:PrintMessage(HUD_PRINTTALK, "You ate the "..name..", your feel less hungry")
				else
					pl:PrintMessage(HUD_PRINTTALK, "You ate the "..name..", your stomach still rumbles")
				end

				pl:EmitSound("breach2/eat.wav")

				pl:UpdateHungerThirst()
			end

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

add_food("food_cookies", "Cookies", "models/foodnhouseholditems/cookies.mdl", 10, 3)
add_food("food_sandwich", "Sandwich", "models/foodnhouseholditems/sandwich.mdl", 20, 5)
add_food("food_burger", "Burger", "models/foodnhouseholditems/mcdburgerbox.mdl", 30, 10)
add_food("food_icecream", "Ice Cream", "models/foodnhouseholditems/icecream1.mdl", 15, 2)
add_food("food_frenchfries", "French Fries", "models/foodnhouseholditems/mcdfrenchfries.mdl", 10, 4)
add_food("food_chips", "Chips", "models/foodnhouseholditems/chipslays.mdl", 10, 2)
add_food("food_pizzaslice", "Pizza Slice", "models/foodnhouseholditems/pizzaslice.mdl", 5, 7)
add_food("food_pizza", "Pizza", "models/foodnhouseholditems/pizzab.mdl", {"food_pizzaslice", 8, "Pizza Slice", "models/foodnhouseholditems/pizzaslice.mdl"}, 40)

