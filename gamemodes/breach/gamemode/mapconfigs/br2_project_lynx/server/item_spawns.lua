

MAPCONFIG.RANDOM_ITEM_SPAWNS = {
	-- LCZ PIZZAS
	{
		model = "models/foodnhouseholditems/pizzab.mdl",
		class = "prop_physics",
		num = 2,
		func = function(ent)
			ent.PrintName = "Pizza"
			ent.SI_Class = "food_pizza"
			ent:SetNWBool("isDropped", true)
		end,
		spawns = {
			{Vector(-5421, 6806, -50), Angle(0, -35, 0.2)},
			{Vector(-5133,6722-55), Angle(0,270,0)},
            /*
			{Vector(), Angle()},
			{Vector(), Angle()},
			{Vector(), Angle()},

			{XXXXXXXXXXXXXXXXX, YYYYYYYYYYYYYYYYYYYY},
			{XXXXXXXXXXXXXXXXX, YYYYYYYYYYYYYYYYYYYY},
			{XXXXXXXXXXXXXXXXX, YYYYYYYYYYYYYYYYYYYY},
			{XXXXXXXXXXXXXXXXX, YYYYYYYYYYYYYYYYYYYY},
			{XXXXXXXXXXXXXXXXX, YYYYYYYYYYYYYYYYYYYY},
			{XXXXXXXXXXXXXXXXX, YYYYYYYYYYYYYYYYYYYY},
            */
		}
	},


	-- EZ CAFETERIA PIZZAS
	{
		model = "models/foodnhouseholditems/pizzab.mdl",
		class = "prop_physics",
		num = 2,
		func = function(ent)
			ent.PrintName = "Pizza"
			ent.SI_Class = "food_pizza"
			ent:SetNWBool("isDropped", true)
		end,
		spawns = {
            /*
			{Vector(), Angle()},
			{Vector(), Angle()},
			{Vector(), Angle()},
			{Vector(), Angle()},

			{XXXXXXXXXXXXXXXXX, YYYYYYYYYYYYYYYYYYYY},
			{XXXXXXXXXXXXXXXXX, YYYYYYYYYYYYYYYYYYYY},
			{XXXXXXXXXXXXXXXXX, YYYYYYYYYYYYYYYYYYYY},
			{XXXXXXXXXXXXXXXXX, YYYYYYYYYYYYYYYYYYYY},
			{XXXXXXXXXXXXXXXXX, YYYYYYYYYYYYYYYYYYYY},
			{XXXXXXXXXXXXXXXXX, YYYYYYYYYYYYYYYYYYYY},
            */
		}
	},
}

print("[Breach2] Server/ItemSpawns mapconfig loaded!")