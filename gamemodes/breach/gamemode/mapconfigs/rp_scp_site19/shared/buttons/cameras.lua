
MAPCONFIG.CAMERAS = {
	{
		name = "Light Containment Zone",
		cameras = {
			{name = "LCZ_OFFICE_1", pos = Vector(-1410,-3281,-8978), ang = Angle(0,90,0)},
			{name = "LCZ_SCP_173", pos = Vector(-2455,-3803,-8864), ang = Angle(0,90,0)},
			{name = "LCZ_CORRIDOR_1", pos = Vector(-1930,-2110,-9117), ang = Angle(0,90,0)},
			{name = "LCZ_SCP_012", pos = Vector(-4050,-1220,-9310), ang = Angle(0,180,0)},
			{name = "LCZ_SCP_914", pos = Vector(-3080,-465,-9041), ang = Angle(0,0,0)},
			{name = "LCZ_ELECTRICAL_ROOM", pos = Vector(-3639,-1820,-8930), ang = Angle(0,0,0)},
		}
	},
	{
		name = "Heavy Containment Zone",
		cameras = {
			{name = "HCZ_SCP_895", pos = Vector(-4280,2208,-9504), ang = Angle(0,-90,0), is_895 = true},
			{name = "HCZ_WARHEAD_CONTROL", pos = Vector(556,2800,-8599), ang = Angle(0,180,0)},
			{name = "HCZ_SCP_079", pos = Vector(1920,2608,-9243), ang = Angle(0,-90,0)},
			{name = "HCZ_SCP_966", pos = Vector(-400,2940,-9089), ang = Angle(0,-90,0)},
			{name = "HCZ_CORRIDOR_1", pos = Vector(-4470,3746,-9109), ang = Angle(0,-90,0)},
			{name = "HCZ_CORRIDOR_2", pos = Vector(-1930,3174,-9109), ang = Angle(0,90,0)},
			{name = "HCZ_SCP_513", pos = Vector(-1955,1437,-9099), ang = Angle(0,180,0)},
			{name = "HCZ_SCP_106", pos = Vector(-6703,2020,-9011), ang = Angle(0,0,0)},
			{name = "HCZ_CORRIDOR_3", pos = Vector(-1720,1637,-9016), ang = Angle(0,-90,0)},
			{name = "HCZ_SCP_049", pos = Vector(-3400,2304,-11093), ang = Angle(0,-90,0)},
		}
	},
	{
		name = "Checkpoints",
		cameras = {
			{name = "LCZ_TO_HCZ_CHECKPOINT_A", pos = Vector(-250,-18,-9030), ang = Angle(0,90,0)},
			{name = "LCZ_TO_HCZ_CHECKPOINT_B", pos = Vector(-4090,-17,-9036), ang = Angle(0,90,0)},
			{name = "HCZ_TO_EZ_CHECKPOINT_A", pos = Vector(-890,3824,-9080), ang = Angle(0,90,0)},
			{name = "HCZ_TO_EZ_CHECKPOINT_B", pos = Vector(-4090,3820,-9080), ang = Angle(0,90,0)},
		}
	},
	{
		name = "Entrance Zone",
		cameras = {
			{name = "EZ_SERVER_FARM", pos = Vector(-3964,5595,-9108), ang = Angle(0,180,0)},
			{name = "EZ_SERVER_HUB", pos = Vector(-3845,5761,-9252), ang = Angle(0,90,0)},
			{name = "EZ_OFFICE_1", pos = Vector(-3845,5761,-9252), ang = Angle(0,90,0)},
			{name = "EZ_CAFETERIA", pos = Vector(-383,6330,-9114), ang = Angle(0,180,0)},
			{name = "EZ_GATE_B", pos = Vector(666,7240,-8982), ang = Angle(0,0,0)},
			{name = "EZ_GATE_A", pos = Vector(-3305,7952,-9008), ang = Angle(0,90,0)},
		}
	},
}

print("[Breach2] Shared/Buttons/Cameras mapconfig loaded!")