
MAPCONFIG.CAMERAS = {
	{
		name = "Research Zone",
		cameras = {
			{name = "rz_main_corridor", pos = Vector(8604,449,-984), ang = Angle(0,90,0)},
			{name = "rz_security_area", pos = Vector(8719,2039,-974), ang = Angle(0,0,0)},
			{name = "rz_lab_aqua", pos = Vector(8820,2687,-988), ang = Angle(0,90,0)},
			{name = "rz_lab_tech", pos = Vector(8072,1864,-987), ang = Angle(0,90,0)},
			{name = "rz_lab_bio", pos = Vector(7687,1755,-954), ang = Angle(0,180,0)},
			{name = "rz_lab_chem", pos = Vector(8634,712,-952), ang = Angle(0,0,0)},


		}
	},
	{
		name = "Light Containment Zone",
		cameras = {
			{name = "lcz_classd_cells", pos = Vector(7582,-2352,-683), ang = Angle(0,0,0)},
			{name = "lcz_cafeteria", pos = Vector(7035,-1639,-703), ang = Angle(0,180,0)},
			{name = "lcz_corridor", pos = Vector(8824,-843,-748), ang = Angle(0,90,0)},
			{name = "lcz_contchamber_scp914", pos = Vector(10149,-935,-722), ang = Angle(0,180,0)},
			{name = "lcz_contchamber_scp173", pos = Vector(8824,-843,-748), ang = Angle(0,90,0)},
			{name = "lcz_checkpoint", pos = Vector(6843,-693,-865), ang = Angle(0,180,0)},
		}
	},
	{
		name = "Heavy Containment Zone",
		cameras = {
			{name = "hcz_contchamber_scp008", pos = Vector(4235,2242,-796), ang = Angle(0,0,0)},
			{name = "hcz_contchamber_scp106", pos = Vector(2889,531,-729), ang = Angle(0,90,0)},
			{name = "hcz_contchamber_scp049", pos = Vector(2346,3153,-1309), ang = Angle(0,-90,0)},
			{name = "hcz_contchamber_scp079", pos = Vector(2288,-460,-854), ang = Angle(0,180,0)},
			{name = "hcz_connector", pos = Vector(3096,414,-825), ang = Angle(0,-90,0)},
			{name = "hcz_corridor_scp457", pos = Vector(3096,414,-825), ang = Angle(0,-90,0)},
			{name = "hcz_control_room", pos = Vector(3880,2789,-847), ang = Angle(9,0,0)},
			{name = "hcz_warhead_room", pos = Vector(2288,-460,-854), ang = Angle(0,180,0)},


			--{name = "HCZ_SCP_895", pos = XXXXXXXXXXXXXXXXXXXXXXX, ang = Angle(0,90,0), is_895 = true},
		}
	},
	{
		name = "Checkpoints",
		cameras = {
			{name = "checkpoint_lcz_to_hcz_east", pos = Vector(4905,-724,-807), ang = Angle(0,180,0)},
			{name = "checkpoint_lcz_to_hcz_west", pos = Vector(4896,1500,-805), ang = Angle(0,180,0)},
			{name = "checkpoint_hcz_to_ez", pos = Vector(783,-1940,-791), ang = Angle(0,180,0)},
		}
	},
	{
		name = "Entrance Zone",
		cameras = {
			{name = "ez_cafeteria", pos = Vector(-672,-1573,-848), ang = Angle(0,0,0)},
			{name = "ez_exit", pos = Vector(-856,-438,-801), ang = Angle(0,180,0)},
			{name = "ez_server_room", pos = Vector(-1557,-194,-856), ang = Angle(0,0,0)},
			{name = "ez_control_room", pos = Vector(-1557,-194,-856), ang = Angle(0,0,0)},
			{name = "ez_medical_center", pos = Vector(-1557,-194,-856), ang = Angle(0,0,0)},
			{name = "ez_office", pos = Vector(-1557,-194,-856), ang = Angle(0,0,0)},
		}
	}
}

print("[Breach2] Shared/Buttons/Cameras mapconfig loaded!")