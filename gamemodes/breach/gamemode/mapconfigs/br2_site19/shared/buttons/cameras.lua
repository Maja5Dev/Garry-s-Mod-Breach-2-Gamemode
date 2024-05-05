
MAPCONFIG.CAMERAS = {
	{
		name = "Light Containment Zone",
		cameras = {
			{name = "LCZ_PRISON_B", pos = Vector(7840,-6192,338), ang = Angle(0,90,0)},
			{name = "LCZ_PRISON_A", pos = Vector(6112,-5519,239), ang = Angle(0,-90,0)},
			{name = "LCZ_CAFETERIA", pos = Vector(7696,-5819,360), ang = Angle(0,90,0)},
			{name = "LCZ_OFFICE_1", pos = Vector(6954,-4400,232), ang = Angle(0,-90,0)},
			{name = "LCZ_OFFICE_2", pos = Vector(9266,-3816,91), ang = Angle(0,180,0)},
			{name = "LCZ_SCP_012", pos = Vector(7744,-4483,-80), ang = Angle(0,-90,0)},
			{name = "LCZ_SCP_173", pos = Vector(6760,-3488,317), ang = Angle(0,180,0)},
			{name = "LCZ_CORRIDOR_1", pos = Vector(8615,-4855,193), ang = Angle(0,-45,0)},
			{name = "LCZ_CORRIDOR_2", pos = Vector(7794,-2768,161), ang = Angle(0,180,0)},
			{name = "LCZ_CORRIDOR_3", pos = Vector(9553,-1102,188), ang = Angle(0,-90,0)},
			{name = "LCZ_PLAZA", pos = Vector(8944,-2953,257), ang = Angle(0,90,0)},


		}
	},
	{
		name = "Heavy Containment Zone",
		cameras = {
			{name = "HCZ_CORRIDOR_1", pos = Vector(4064,52,127), ang = Angle(0,-90,0)},
			{name = "HCZ_CORRIDOR_2", pos = Vector(3823,6053,140), ang = Angle(0,180,0)},
			{name = "HCZ_CONNECTOR_1", pos = Vector(8243,664,108), ang = Angle(0,90,0)},
			{name = "HCZ_CONNECTOR_2", pos = Vector(5993,-288,111), ang = Angle(0,0,0)},
			{name = "HCZ_CONNECTOR_3", pos = Vector(8403,2503,119), ang = Angle(0,180,0)},
			{name = "HCZ_TEMPORARY_CELLS", pos = Vector(5531,1600,135), ang = Angle(0,0,0)},
			{name = "HCZ_STORAGE_AREA", pos = Vector(3336,2047,134), ang = Angle(0,-90,0)},
			{name = "HCZ_SCP_457", pos = Vector(6071,2272,134), ang = Angle(0,0,0)},
			{name = "HCZ_SCP_049", pos = Vector(8336,-269,136), ang = Angle(0,180,0)},
			{name = "HCZ_SCP_079", pos = Vector(4064,3189,134), ang = Angle(0,-90,0)},
			{name = "HCZ_SCP_895", pos = Vector(5568,1044,-330), ang = Angle(0,90,0), is_895 = true},
		}
	},
	{
		name = "Checkpoints",
		cameras = {
			{name = "LCZ_TO_HCZ_CHECKPOINT_1", pos = Vector(5210,-2144,196), ang = Angle(0,180,0)},
			{name = "LCZ_TO_HCZ_CHECKPOINT_2", pos = Vector(6960,-1833,159), ang = Angle(0,90,0)},
			{name = "LCZ_TO_HCZ_CHECKPOINT_3", pos = Vector(8240,-1774,162), ang = Angle(0,90,0)},

			{name = "HCZ_TO_EZ_CHECKPOINT_2", pos = Vector(2512,2448,164), ang = Angle(0,180,0)},
			{name = "HCZ_TO_EZ_CHECKPOINT_1", pos = Vector(1922,1159,164), ang = Angle(0,180,0)},
			{name = "HCZ_TO_EZ_CHECKPOINT_3", pos = Vector(1851,3728,164), ang = Angle(0,180,0)},
			{name = "HCZ_TO_EZ_CHECKPOINT_4", pos = Vector(752,5318,164), ang = Angle(0,-90,0)},
		}
	},
	/*
	{
		name = "Entrance Zone",
		cameras = {
		}
	},
	*/
}

print("[Breach2] Shared/Buttons/Cameras mapconfig loaded!")