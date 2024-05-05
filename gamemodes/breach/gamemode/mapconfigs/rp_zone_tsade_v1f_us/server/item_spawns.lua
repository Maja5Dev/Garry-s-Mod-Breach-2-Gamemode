

MAPCONFIG.RANDOM_ITEM_SPAWNS = {
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
			{Vector(203.630737, -1543.682617, -1061.529541), Angle(0.027, 27.406, 0.117)},
			{Vector(50.335560, -993.834229, -1061.637817), Angle(0.037, -116.860, 0)},
			{Vector(-450.284607, -1500.026733, -1061.535522), Angle(-0.028, 151.375, 0.098)},
			{Vector(-605.042236, -1543.724243, -1061.525024), Angle(0.131, -163.085, -0.176)},
			{Vector(-887.352356, -1268.918335, -1057.724365), Angle(0, 16.441, 0)},
			{Vector(203.967224, -1016.589111, -1061.521729), Angle(0.174, -165.164, -0.229)},
			{Vector(49.182110, -1480.517212, -1061.560669), Angle(0, -168.921, 0.246)},

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