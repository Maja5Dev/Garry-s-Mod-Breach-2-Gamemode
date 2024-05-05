
YYYYYYYYYYYYYYYYYYYY = Vector(0,0,0)

function FindKeyPadByName(name)
	for i,v in ipairs(MAPCONFIG.KEYPADS) do
		if v.name == name then
			return i
		end
	end
end

MAPCONFIG.KEYPADS = {
--LCZ_CLASSD_AREA
	{
		name = "LCZ_CLASSD_CELLS_CHILLZONE",
		pos = Vector(7866.9301757813, -2500, -794),
		level = 1,
		sounds = true
	},
	{
		name = "LCZ_CLASSD_ADMIN_PATHWAY",
		pos = Vector(7960, -1192.9100341797, -917),
		level = 1,
		sounds = true
	},
	{
		name = "LCZ_CENTRAL_CLASSD_RECEPTION",
		pos = Vector(8013.9301757813, -1124, -920),
		level = 1,
		sounds = true
	},
	{
		name = "LCZ_CLASSD_CONTROLROOM",
		pos = Vector(7866.9301757813, -1564, -776),
		level = 2,
		sounds = true
	},
	{
		name = "LCZ_CLASSD_OFFICE",
		pos = Vector(7741, -1797.9100341797, -776),
		level = 2,
		sounds = true
	},
	{
		name = "LCZ_CLASSD_CELLS_EXIT_2",
		pos = Vector(7869.9301757813, -1124, -920),
		level = 4,
		sounds = true
	},
	{
		name = "LCZ_CLASSD_CELLS_EXIT_1",
		pos = Vector(7866.9301757813, -1564, -920),
		level = 4,
		sounds = true
	},
	{
		name = "LCZ_SCP1123",
		pos = Vector(9149.9404296875, -715, -920),
		level = 3,
		sounds = true
	},
	{
		name = "LCZ_SCP1123_CONTCHAMBER",
		pos = Vector(9090, -544.90997314453, -919),
		level = 3,
		sounds = true
	},
	{
		name = "LCZ_CENTRAL_INTERROGATIONROOM_1",
		pos = Vector(9149.9296875, -891, -920),
		level = 3,
		sounds = true
	},
	{
		name = "LCZ_CENTRAL_INTERROGATIONROOM_2",
		pos = Vector(9240, -1056.9100341797, -920),
		level = 3,
		sounds = true
	},
	{
		name = "LCZ_CENTRAL_INTERROGATIONROOM_3",
		pos = Vector(9386, -1173.0799560547, -917),
		level = 0,
		code = 1234,
		personal_office = false,
		code_can_be_obtained_by_radio = false,
		sounds = true
	},
	{
		name = "LCZ_CENTRAL_OFFICES_1",
		pos = Vector(8832.009765625, -352.91000366211, -1048),
		level = 3,
		sounds = true
	},
	{
		name = "LCZ_CENTRAL_OFFICES_2",
		pos = Vector(8832.009765625, -667.90997314453, -1048),
		level = 3,
		sounds = true
	},
	{
		name = "LCZ_SCP914_DOOR",
		pos = Vector(9939.3203125, -1140.1800537109, -923.5),
		level = 2,
		sounds = true
	},

	{
		name = "LCZ_SCP914_1",
		pos = Vector(9762.5, -1307, -879),
		level = 10,
		sounds = false
	},
	{
		name = "LCZ_SCP914_2",
		pos = Vector(9762.5, -1307, -893.5),
		level = 10,
		sounds = false
	},

	{
		name = "LCZ_SCP914_CONTROLROOM",
		pos = Vector(10202, -800.90997314453, -920),
		level = 3,
		sounds = true
	},
	{
		name = "LCZ_CAFETERIA",
		pos = Vector(7070, -2240.9099121094, -917),
		level = 1,
		sounds = true
	},
	{
		name = "LCZ_CLASSD_CELLS_SHOWERS",
		pos = Vector(8660, -2240.9099121094, -917),
		level = 2,
		sounds = true
	},
	{
		name = "LCZ_SCP173_1",
		pos = Vector(7205.9301757813, -700, -920),
		level = 1,
		sounds = true
	},
	{
		name = "LCZ_SCP173_JANITORROOM",
		pos = Vector(7400.009765625, -561.90997314453, -920),
		level = 1,
		sounds = true
	},
	{
		name = "LCZ_SCP173_CONTROLROOM_1",
		pos = Vector(6952, -369.91000366211, -920),
		level = 3,
		sounds = true
	},
	{
		name = "LCZ_SCP173_CONTROLROOM_2",
		pos = Vector(6501.9301757813, -308, -792),
		level = 3,
		sounds = true
	},
	{
		name = "LCZ_SCP173_OBSERVATORY",
		pos = Vector(6337.9301757813, 148, -792),
		level = 3,
		sounds = true
	},
	{
		name = "LCZ_SCP173_2",
		pos = Vector(7045.9301757813, -308, -920),
		level = 2,
		sounds = true
	},
	{
		name = "LCZ_ICHECKPOINT",
		pos = Vector(6430, -891.90997314453, -920),
		level = 2,
		sounds = true
	},
	{
		name = "LCZ_SCPROOM_1",
		pos = Vector(7216, -888, -920),
		level = 2,
		sounds = true
	},
	{
		name = "LCZ_SCPROOM_2",
		pos = Vector(5909.9599609375, -908, -920),
		level = 1,
		sounds = true
	},
	{
		name = "LCZ_SCPROOM_2_CONTCHAMBERS",
		pos = {
			Vector(5817.4599609375, -1190.6300048828, -885.38000488281),
			Vector(6007.4702148438, -990.84002685547, -885.38000488281)
		},
		level = 0,
		code = 1234,
		code_can_be_obtained_by_radio = false,
		personal_office = false,
		sounds = true
	},
	{
		name = "LCZ_SCPROOM_3",
		pos = Vector(5344, 310.08999633789, -920),
		level = 1,
		sounds = true
	},
	{
		name = "LCZ_SCPROOM_3_CONTCHAMBERS",
		pos = {
			Vector(5386.2099609375, 419.05999755859, -914.46002197266),
			Vector(5711.2001953125, 419.05999755859, -914.46002197266),
			Vector(5992.8100585938, 209.92999267578, -914.46002197266),
			Vector(5667.7900390625, 209.92999267578, -914.46002197266)
		},
		level = 0,
		code = 1234,
		code_can_be_obtained_by_radio = false,
		personal_office = false,
		sounds = true
	},
	{
		name = "LCZ_CHECKPOINT_2",
		pos = Vector(4560, 1420, -919),
		level = 3,
		sounds = true
	},
	{
		name = "LCZ_CHECKPOINT_1",
		pos = Vector(4560, -804, -919),
		level = 3,
		sounds = true
	},
	{
		name = "LCZ_CENTRAL_STORAGEROOM",
		pos = Vector(7869.9301757813, -484, -920),
		level = 1,
		sounds = true
	},
--LCZ_RESEARCH_AREA
	{
		name = "LCZ_RESEARCHAREA_CHECKPOINT",
		pos = {
			Vector(8479, -340, -1043.5),
			Vector(8506, -315.5, -1043.5)
		},
		--pos = Vector(8479, -340, -1043.5),
		level = 0,
		code = 1234,
		code_can_be_obtained_by_radio = true,
		personal_office = false,
		sounds = true
	},
	{
		name = "LCZ_RESEARCHAREA_LOCKERSROOM",
		pos = Vector(8612.009765625, 280.08999633789, -1048),
		level = 1,
		sounds = true
	},
	{
		name = "LCZ_RESEARCHAREA_SMALLARMORY",
		pos = Vector(8412.009765625, 280.08999633789, -1048),
		level = 3,
		sounds = true
	},
	{
		name = "LCZ_RESEARCHAREA_SHOOTINGRANGE",
		pos = Vector(9410.9404296875, 712, -1048),
		level = 2,
		sounds = true
	},
	{
		name = "LCZ_RESEARCHAREA_CELLS",
		pos = Vector(9744.9296875, 512, -1048),
		level = 1,
		sounds = true
	},
	{
		name = "LCZ_RESEARCHAREA_SCPROOM_1",
		pos = Vector(9984, 614.09002685547, -1048),
		level = 1,
		sounds = true
	},
	{
		name = "LCZ_RESEARCHAREA_SCPROOM_1_SCP131",
		pos = Vector(10067.400390625, 706.53997802734, -1013.3800048828),
		level = 0,
		code = 1234,
		code_can_be_obtained_by_radio = false,
		personal_office = false,
		sounds = true
	},
	{
		name = "LCZ_RESEARCHAREA_SCPROOM_1_SCP999",
		pos = Vector(10267.200195313, 516.53002929688, -1013.3800048828),
		level = 0,
		code = 1234,
		code_can_be_obtained_by_radio = false,
		personal_office = false,
		sounds = true
	},
	{
		name = "LCZ_RESEARCHAREA_BARRACKS_CONTROLROOM",
		pos = Vector(9030.9296875, 1632, -1048),
		level = 2,
		sounds = true
	},
	{
		name = "LCZ_RESEARCHAREA_BARRACKS",
		pos = Vector(8615.009765625, 1582.0899658203, -1048.25),
		level = 1,
		sounds = true
	},
	{
		name = "LCZ_RESEARCHAREA_BIOLAB_1",
		pos = Vector(8408, 1581.0899658203, -1048),
		level = 2,
		sounds = true
	},
	{
		name = "LCZ_RESEARCHAREA_BIOLAB_2",
		pos = Vector(7453.9301757813, 1398, -1048),
		level = 2,
		sounds = true
	},
	{
		name = "LCZ_RESEARCHAREA_BIOLAB_3",
		pos = Vector(7316.9301757813, 1398, -1048),
		level = 2,
		sounds = true
	},
	{
		name = "LCZ_RESEARCHAREA_VIDEOROOM",
		pos = Vector(8412.009765625, 897.09002685547, -1048),
		level = 1,
		sounds = true
	},
	{
		name = "LCZ_RESEARCHAREA_CHEMLAB",
		pos = Vector(8612.009765625, 897.09002685547, -1048),
		level = 2,
		sounds = true
	},
	{
		name = "LCZ_RESEARCHAREA_TECHLAB",
		pos = Vector(8348, 2145.0900878906, -1048),
		level = 2,
		sounds = true
	},
	{
		name = "LCZ_RESEARCHAREA_AQUALAB_1",
		pos = Vector(8509.9296875, 2371, -1048),
		level = 2,
		sounds = true
	},
	{
		name = "LCZ_RESEARCHAREA_AQUALAB_BIGDOORS",
		pos = Vector(8659, 3478.5, -1184),
		level = 0,
		code = 1234,
		code_can_be_obtained_by_radio = false,
		personal_office = false,
		sounds = true
	},
	{
		name = "LCZ_RESEARCHAREA_AQUALAB_2",
		pos = Vector(8248.9296875, 3476, -1181),
		level = 3,
		sounds = true
	},
	{
		name = "LCZ_RESEARCHAREA_SECURITYAREA_ENTRANCE",
		pos = Vector(9514.5, 2056, -1041),
		level = 4,
		sounds = true
	},
	{
		name = "LCZ_RESEARCHAREA_SECURITYAREA_2",
		pos = Vector(9862.009765625, 2041, -1166.0100097656),
		level = 4,
		sounds = true
	},
	{
		name = "LCZ_RESEARCHAREA_SECURITYAREA_3",
		pos = {
			Vector(10371, 2062.2600097656, -1177.9100341797),
			Vector(10251, 2028.5, -1178),
			Vector(10373, 2026.5, -1178)
		},
		level = 0,
		code = 1234,
		code_can_be_obtained_by_radio = true,
		personal_office = false,
		sounds = true
	},
	{
		name = "LCZ_RESEARCHAREA_SECURITYAREA_BARRACKS",
		pos = Vector(10767.900390625, 1745, -1181),
		level = 3,
		sounds = true
	},
	{
		name = "LCZ_RESEARCHAREA_SECURITYAREA_CHECKPOINT",
		pos = Vector(10407, 1930.0899658203, -1181.25),
		level = 4,
		sounds = true
	},
	{
		name = "LCZ_RESEARCHAREA_SECURITYAREA_COMMAND_ROOM",
		pos = Vector(10727, 2357, -1176.0100097656),
		level = 5,
		sounds = true
	},
	{
		name = "LCZ_CLASSD_CELSS_BELOWAREA_1",
		pos = Vector(7866.9301757813, -2500, -920),
		level = 1,
		sounds = true
	},
	{
		name = "LCZ_CLASSD_CELSS_BELOWAREA_GASROOM",
		pos = Vector(7947, -2771.9099121094, -920),
		level = 2,
		sounds = true
	},
	{
		name = "LCZ_CLASSD_CELSS_BELOWAREA_KEYPADCELLS",
		pos = Vector(7791, -2771.9099121094, -920),
		level = 2,
		sounds = true
	},
	{
		name = "LCZ_CLASSD_CELSS_BELOWAREA_KEYPADCELL_1",
		pos = Vector(7693.919921875, -2699, -920),
		level = 2,
		sounds = true
	},
	{
		name = "LCZ_CLASSD_CELSS_BELOWAREA_KEYPADCELL_2",
		pos = Vector(7698.080078125, -2849, -920),
		level = 2,
		sounds = true
	},



--HCZ
	{
		name = "HCZ_SCP513",
		pos = Vector(3292, -1285.8100585938, -917),
		level = 3,
		sounds = true
	},
	{
		name = "HCZ_SCP682-1",
		pos = Vector(3221.919921875, -2276, -917),
		level = 3,
		sounds = true
	},
	{
		name = "HCZ_SCP682",
		pos = Vector(2728.0100097656, -2383, -1047.5),
		level = 0,
		code = 1234,
		code_can_be_obtained_by_radio = false,
		personal_office = false,
		sounds = true
	},
	{
		name = "HCZ_SCP682-3",
		pos = Vector(2420.919921875, -2737, -1060),
		level = 4,
		sounds = true
	},
	{
		name = "HCZ_SCP682-4",
		pos = Vector(2322, -2573.0900878906, -1060),
		level = 4,
		sounds = true
	},
	{
		name = "HCZ_SCP682-5",
		pos = Vector(2355, -3077.080078125, -1204),
		level = 4,
		sounds = true
	},
	{
		name = "HCZ_CONSTRUCTION_ROOM",
		pos = Vector(3221.9299316406, -2865, -920),
		level = 4,
		sounds = true
	},
	{
		name = "HCZ_CONTCHAMBER_SCP079",
		pos = {
			Vector(1590, -3014.0100097656, -1046.5),
			Vector(1606, -3070.0100097656, -1046.5),
			Vector(1160, -2930, -1046.5),
			Vector(1160, -2874, -1046.5)
		},
		level = 0,
		code = 1234,
		code_can_be_obtained_by_radio = true,
		personal_office = false,
		sounds = true
	},
	{
		name = "HCZ_CONTCHAMBER_SCP079_2",
		pos = Vector(1263, -2905.9099121094, -1047),
		level = 4,
		sounds = true
	},
	{
		name = "HCZ_WARHEADROOM_1",
		pos = Vector(2012.9200439453, -1436, -917),
		level = 4,
		sounds = true
	},
	{
		name = "HCZ_WARHEADROOM_2",
		pos = Vector(2012.9200439453, -908.29998779297, -917),
		level = 4,
		sounds = true
	},
	{
		name = "HCZ_WARHEADROOM_3",
		pos = Vector(2236.919921875, -452, -919),
		level = 0,
		code = 1234,
		code_can_be_obtained_by_radio = true,
		personal_office = false,
		sounds = true
	},
	{
		name = "HCZ_CONTCHAMBER_SCP096_1",
		pos = Vector(2495, -1438.0799560547, -917),
		level = 3,
		sounds = true
	},
	{
		name = "HCZ_CONTCHAMBER_SCP096_2",
		pos = Vector(2495, -990.08001708984, -917),
		level = 3,
		sounds = true
	},
	{
		name = "HCZ_CONTCHAMBER_SCP035_1",
		pos = Vector(2419.9799804688, -540, -920),
		level = 4,
		sounds = true
	},
	{
		name = "HCZ_CONTCHAMBER_SCP035_2",
		pos = Vector(2381.9899902344, -356.80999755859, -920),
		level = 4,
		sounds = true
	},
	{
		name = "HCZ_CONTCHAMBER_SCP035_3",
		pos = Vector(2707.919921875, -404, -916),
		level = 4,
		sounds = true
	},
	{
		name = "HCZ_CONTCHAMBER_SCP035_STORAGE",
		pos = Vector(2814, 6.0799999237061, -916),
		level = 4,
		sounds = true
	},
	{
		name = "HCZ_CONTCHAMBER_SCP008_1",
		pos = Vector(3696, 2529.919921875, -920),
		level = 4,
		sounds = true
	},
	{
		name = "HCZ_CONTCHAMBER_SCP457_1",
		pos = Vector(2916, 2529.919921875, -920),
		level = 3,
		sounds = true
	},
	{
		name = "HCZ_CONTCHAMBER_SCP457_2",
		pos = Vector(2830.919921875, 2391, -917),
		level = 3,
		sounds = true
	},
	{
		name = "HCZ_ELEVATOR_TO_CONT_AREA_6-1",
		pos = Vector(3544, 2841, -849.58001708984),
		level = 3,
		sounds = true
	},
	{
		name = "HCZ_ELEVATOR_TO_CONT_AREA_6-2",
		pos = Vector(3544, 2841, -1409),
		level = 3,
		sounds = true
	},
	{
		name = "HCZ_ELEVATOR_TO_CONT_AREA_6-3",
		pos = Vector(3628, 2821, -1409),
		level = 3,
		sounds = true
	},
	{
		name = "HCZ_ELEVATOR_TO_CONT_AREA_6-4",
		pos = Vector(3628, 2821, -919.5),
		level = 3,
		sounds = true
	},
	{
		name = "HCZ_CONTCHAMBER_SCP049-1",
		pos = Vector(2832, 2929.919921875, -1409),
		level = 3,
		sounds = true
	},
	{
		name = "HCZ_CONTCHAMBER_SCP049",
		pos = Vector(2565.8999023438, 3075.7299804688, -1388.9100341797),
		level = 0,
		code = 1234,
		code_can_be_obtained_by_radio = false,
		personal_office = false,
		sounds = true
	},
	{
		name = "HCZ_CONTCHAMBER_SCP106-1",
		pos = Vector(2230.919921875, 404, -919.45001220703),
		level = 3,
		sounds = true
	},
	{
		name = "HCZ_CONTCHAMBER_SCP106-2",
		pos = Vector(2230.919921875, 572, -919.45001220703),
		level = 4,
		sounds = true
	},
	{
		name = "HCZ_CONTCHAMBER_SCP106_CONTROLROOM",
		pos = Vector(2313, 1622.0899658203, -1176),
		level = 4,
		sounds = true
	},
	{
		name = "HCZ_CONTCHAMBER_SCP106-3",
		pos = Vector(1942.9200439453, 1164, -1175.4499511719),
		level = 1,
		sounds = true
	},
	{
		name = "HCZ_CONTCHAMBER_SCP106",
		pos = Vector(2319.0100097656, 924.80999755859, -1238),
		level = 0,
		code = 1234,
		code_can_be_obtained_by_radio = false,
		personal_office = false,
		sounds = true
	},
	{
		name = "HCZ_SCP006",
		pos = Vector(3536, 305.92001342773, -920),
		level = 100,
		sounds = true
	},
	{
		name = "HCZ_CONTROLROOM",
		pos = Vector(3856, 2929.9099121094, -920),
		level = 5,
		sounds = true
	},
	{
		name = "HCZ_CONTCHAMBER_SCP939-1",
		pos = Vector(3856, 2929.919921875, -1409),
		level = 3,
		sounds = true
	},
	{
		name = "HCZ_CONTCHAMBER_SCP939",
		pos = Vector(4012, 2844, -1407),
		level = 0,
		code = 1234,
		code_can_be_obtained_by_radio = false,
		personal_office = false,
		sounds = true
	},
	{
		name = "HCZ_CONTCHAMBER_SCP939_CONTROLROOM",
		pos = Vector(4055, 2507.919921875, -1409),
		level = 3,
		sounds = true
	},
	{
		name = "EZ_CHECKPOINT",
		pos = Vector(439, -2020, -919),
		level = 3,
		sounds = true
	},
	{
		name = "EZ_CRISIS_ROOM",
		pos = Vector(-226, -1766.9100341797, -920),
		level = 5,
		sounds = true
	},
	{
		name = "EZ_GATE",
		pos = Vector(-786.98999023438, -430, -915.5),
		level = 5,
		sounds = true
	},
	{
		name = "EZ_OFFICES",
		pos = Vector(190, -594.90997314453, -920),
		level = 3,
		sounds = true
	},
	{
		name = "EZ_DIRECTORS_OFFICE",
		pos = Vector(840, -594.90997314453, -920),
		level = 0,
		code = 1234,
		code_can_be_obtained_by_radio = true,
		personal_office = false,
		sounds = true
	},
	{
		name = "XXXXXXXXXXXXXXXXXXXXXX",
		pos = YYYYYYYYYYYYYYYYYYYY,
		level = 1,
		sounds = true
	},
	{
		name = "XXXXXXXXXXXXXXXXXXXXXX",
		pos = YYYYYYYYYYYYYYYYYYYY,
		level = 1,
		sounds = true
	},
	{
		name = "XXXXXXXXXXXXXXXXXXXXXX",
		pos = YYYYYYYYYYYYYYYYYYYY,
		level = 1,
		sounds = true
	},
	{
		name = "XXXXXXXXXXXXXXXXXXXXXX",
		pos = YYYYYYYYYYYYYYYYYYYY,
		level = 1,
		sounds = true
	},
	{
		name = "XXXXXXXXXXXXXXXXXXXXXX",
		pos = YYYYYYYYYYYYYYYYYYYY,
		level = 1,
		sounds = true
	},
	{
		name = "XXXXXXXXXXXXXXXXXXXXXX",
		pos = YYYYYYYYYYYYYYYYYYYY,
		level = 1,
		sounds = true
	},
	{
		name = "XXXXXXXXXXXXXXXXXXXXXX",
		pos = YYYYYYYYYYYYYYYYYYYY,
		level = 1,
		sounds = true
	},
	{
		name = "XXXXXXXXXXXXXXXXXXXXXX",
		pos = YYYYYYYYYYYYYYYYYYYY,
		level = 1,
		sounds = true
	},
}

print("[Breach2] Server/Keypads mapconfig loaded!")