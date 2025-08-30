
MAPCONFIG.ZONES = {}

MAPCONFIG.SPECIAL_MUSIC_ZONES = {
	{pos1 = Vector(465,-1144,-8222), pos2 = Vector(903,-520,-8065), sound = "breach2/music/914.ogg", length = 29.05, volume = 0.8}, -- 914
	{pos1 = Vector(1592,-901,-8229), pos2 = Vector(2314,-1787,-8026), sound = "breach2/music/205.ogg", length = 40.5, volume = 0.8}, -- 205
	{pos1 = Vector(3400,-7035,-8653), pos2 = Vector(4969,-5453,-8394), sound = "breach2/music/Room049.ogg", length = 39.6, volume = 0.5}, -- 049 TUNNELS
	{pos1 = Vector(3637,261,-7459), pos2 = Vector(4658,-1082,-6809), sound = "breach2/music/Room049.ogg", length = 39.6, volume = 0.5}, -- WARHEADS
	{pos1 = Vector(5370,366,-11672), pos2 = Vector(7569,-2400,-11324), sound = "breach2/music/Room3Storage.ogg", length = 16, volume = 0.8}, -- HCZ TUNNELS
	{pos1 = Vector(-912,2139,-16175), pos2 = Vector(2016,-899,-14578), sound = "breach2/music/PD.ogg", length = 27.03, volume = 1}, -- PD
	--{pos1 = Vector(14907,-15883,-2283), pos2 = Vector(10162,-10690,99), sound = "breach2/music/1499.ogg", length = 50, volume = 0.7}, -- 1499
	{pos1 = Vector(-1003,-397,-8475), pos2 = Vector(-1592,235,-8317), sound = "breach2/music/012.ogg", length = 25.5, volume = 0.7}, -- 012
	{pos1 = Vector(5220,5307,-7424), pos2 = Vector(6099,4679,-7206), sound = "breach2/895.ogg", length = 20.75, volume = 0.5}, -- 895

}

MAPCONFIG.ESCAPE_ZONES = {
	{pos1 = Vector(-6526,3309,-1615), pos2 = Vector(-7232,1660,-667)},
	{pos1 = Vector(2618,-394,237), pos2 = Vector(2137,-1307,515)},
}

--  name                       	First Position          	Second Position         	Color                music       fog     NVGmul		ambient       use general ambient
MAPCONFIG.ZONES.LCZ = {
	{
		name 						= "Light Containment Zone",
		pos1 						= Vector(-3999,-2473,-8672),
		pos2 						= Vector(3302,3060,-7732),
		music 						= nil,
		ambients 					= br_default_ambient_lcz,
		fog_enabled 				= true,
		use_general_ambients 		= true,
		color 						= Color(0,255,0,50),
		sanity 						= 1,
		examine_info 				= "You are in the Light Containment Zone",
		zone_temp 					= ZONE_TEMP_NORMAL,
		scp_106_can_tp 				= true,
	},
}

MAPCONFIG.ZONES.HCZ = {
	{
		name 						= "Heavy Containment Zone",
		pos1 						= Vector(2588,35,-7692),
		pos2 						= Vector(-2679,3159,-6960),
		--music 						= {sound = "breach2/music/HeavyContainment.ogg", length = 47.2, volume = 0.5},
		music						= nil,
		ambients 					= br_default_ambient_hcz,
		fog_enabled 				= true,
		use_general_ambients 		= true,
		color 						= Color(0,0,255,50),
		sanity 						= 0,
		examine_info 				= "You are in the Heavy Containment Zone",
		zone_temp 					= ZONE_TEMP_WARM,
		scp_106_can_tp 				= true,
	},
	{
		name 						= "Heavy Containment Zone",
		pos1 						= Vector(259,3171,-7902),
		pos2 						= Vector(-4141,7105,-6824),
		--music 						= {sound = "breach2/music/HeavyContainment.ogg", length = 47.2, volume = 0.5},
		music						= nil,
		ambients 					= br_default_ambient_hcz,
		fog_enabled 				= true,
		use_general_ambients 		= true,
		color 						= Color(0,0,255,50),
		sanity 						= 0,
		examine_info 				= "You are in the Heavy Containment Zone",
		zone_temp 					= ZONE_TEMP_WARM,
		scp_106_can_tp 				= true,
	},
	{
		name 						= "SCP-049's Tunnels",
		pos1 						= Vector(3400,-7035,-8653),
		pos2 						= Vector(4969,-5453,-8394),
		--music 						= {sound = "breach2/music/Room049.ogg", length = 39.6, volume = 1},
		music 						= nil,
		ambients 					= br_default_ambient_hcz,
		fog_enabled 				= true,
		use_general_ambients 		= true,
		color 						= Color(0,0,255,50),
		sanity 						= -1,
		examine_info 				= "You are in SCP-049's Tunnels",
		zone_temp 					= ZONE_TEMP_HOT,
		scp_106_can_tp 				= true,
	},
	{
		name 						= "HCZ Tunnels",
		pos1 						= Vector(5370,366,-11672),
		pos2 						= Vector(7569,-2400,-11324),
		music 						= {sound = "breach2/music/Room3Storage.ogg", length = 16, volume = 1},
		ambients 					= br_default_ambient_hcz,
		fog_enabled 				= true,
		use_general_ambients 		= true,
		color 						= Color(0,0,255,50),
		sanity 						= -1,
		examine_info 				= "You are in the Heavy Containment Zone Tunnel system",
		zone_temp 					= ZONE_TEMP_HOT,
		scp_106_can_tp 				= true,
	},
	{
		name 						= "HCZ Warheads",
		pos1 						= Vector(3637,261,-7459),
		pos2 						= Vector(4658,-1082,-6809),
		music 						= {sound = "breach2/music/Room049.ogg", length = 39.6, volume = 1},
		ambients 					= br_default_ambient_hcz,
		fog_enabled 				= true,
		use_general_ambients 		= true,
		color 						= Color(0,0,255,50),
		sanity 						= -1,
		examine_info 				= "You are in the Heavy Containment Zone Warhead Control Room",
		zone_temp 					= ZONE_TEMP_COLD,
		scp_106_can_tp 				= true,
	},
}

MAPCONFIG.ZONES.ENTRANCEZONE = {
	{
		name 						= "Entrance Zone",
		pos1 						= Vector(304,3222,-7365),
		pos2 						= Vector(7605,8873,-6812),
		--music 						= {sound = "breach2/music/suspended.ogg", length = 81.60, volume = 1},
		music						= nil,
		ambients 					= br_default_ambient_ez,
		fog_enabled 				= true,
		use_general_ambients 		= true,
		color 						= Color(200,200,0,50),
		sanity 						= 1,
		examine_info 				= "You are in the Entrance Zone",
		zone_temp 					= ZONE_TEMP_NORMAL,
		scp_106_can_tp 				= true,
	},
}

MAPCONFIG.ZONES.POCKETDIMENSION = {
	{
		name 						= "Pocket Dimension",
		pos1 						= Vector(-912,2139,-16175),
		pos2 						= Vector(2016,-899,-14578),
		music 						= {sound = "breach2/music/PD.ogg", length = 27.03, volume = 1},
		ambients 					= {},
		fog_enabled 				= true,
		use_general_ambients 		= false,
		color 						= Color(0,150,0,50),
		sanity 						= -1,
		examine_info 				= "You are in the Pocket Dimension",
		zone_temp 					= ZONE_TEMP_COLD,
		scp_106_can_tp 				= true,
	},
}
MAPCONFIG.ZONES.OUTSIDE = {
	{
		name 						= "Outside",
		pos1 						= Vector(4797,-2801,-1771),
		pos2 						= Vector(-7418,5765,1983),
		--music 						= {sound = "breach2/music/withinsight.ogg", length = 60.44, volume = 0.5},
		music						= nil,
		ambients 					= nil,
		fog_enabled 				= true,
		use_general_ambients 		= false,
		color 						= Color(255,0,255,50),
		sanity 						= 1,
		examine_info 				= "You are outside of the facility",
		zone_temp 					= ZONE_TEMP_VERYCOLD,
		scp_106_can_tp 				= false,
	},
} 
MAPCONFIG.ZONES.FOREST = {
	{
		name 						= "Forest",
		pos1 						= Vector(12061,-15943,-3792),
		pos2 						= Vector(15048,-13022,-2633),
		music 						= nil,
		ambients 					= {},
		fog_enabled 				= true,
		use_general_ambients 		= false,
		color 						= Color(70,150,0,50),
		sanity 						= -1,
		examine_info 				= "You are in a forest",
		zone_temp 					= ZONE_TEMP_COLD,
		scp_106_can_tp 				= false,
	},
}
/*
MAPCONFIG.ZONES.SCP_1499 = {
	{
		name 						= "SCP-1499",
		pos1 						= Vector(14907,-15883,-2283),
		pos2 						= Vector(10162,-10690,99),
		music 						= {sound = "breach2/music/1499.ogg", length = 50, volume = 1},
		ambients 					= nil,
		fog_enabled 				= true,
		use_general_ambients 		= false,
		color 						= Color(150,0,0,50),
		sanity 						= -1,
		examine_info 				= "You are in an unknown world",
		zone_temp 					= ZONE_TEMP_NORMAL,
		scp_106_can_tp 				= false,
	},
}
*/
