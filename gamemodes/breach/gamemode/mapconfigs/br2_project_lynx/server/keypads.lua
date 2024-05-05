
YYYYYYYYYYYYYYYYYYYY = Vector(0,0,0)

function FindKeyPadByName(name)
	for i,v in ipairs(MAPCONFIG.KEYPADS) do
		if v.name == name then
			return i
		end
	end
end

MAPCONFIG.KEYPADS = {
	{
		name = "lcz_classd_uparea",
		ent_name = "lcz_classd_uparea",
		level = 1,
		sounds = true
	},
	{
		name = "lcz_classd_tower_up",
		ent_name = "lcz_classd_tower_up",
		level = 1,
		sounds = true
	},
	{
		name = "lcz_classd_tower_down",
		ent_name = "lcz_classd_tower_down",
		level = 1,
		sounds = true
	},
	{
		name = "lcz_scp173_door",
		ent_name = "lcz_scp173_door",
		level = 2,
		sounds = true
	},
	{
		name = "lcz_office1_storage",
		ent_name = "lcz_office1_storage",
		level = 2,
		sounds = true
	},
	{
		name = "lcz_scp1123",
		ent_name = "lcz_scp1123",
		level = 1,
		sounds = true
	},
	{
		name = "lcz_scp914_contchamberdoors",
		ent_name = "lcz_scp914_contchamberdoors",
		level = 3,
		sounds = true
	},
	{
		name = "lcz_scp914_controlroom",
		ent_name = "lcz_scp914_controlroom",
		level = 3,
		sounds = true
	},
	{
		name = "lcz_scps_room",
		ent_name = "lcz_scps_room",
		level = 2,
		sounds = true
	},
	{
		name = "lcz_dark_storage_room",
		ent_name = "lcz_dark_storage_room",
		level = 3,
		sounds = true
	},
	{
		name = "lcz_interrogation_room",
		ent_name = "lcz_interrogation_room",
		level = 1,
		sounds = true
	},
	{
		name = "lcz_crematorium",
		ent_name = "lcz_crematorium",
		level = 1,
		sounds = true
	},
	{
		name = "lcz_shootingrange_entrance",
		ent_name = "lcz_shootingrange_entrance",
		level = 2,
		sounds = true
	},
	{
		name = "lcz_shootingrange_office",
		ent_name = "lcz_shootingrange_office",
		level = 2,
		sounds = true
	},
	{
		name = "lcz_armory",
		ent_name = "lcz_armory",
		level = 4,
		sounds = true
	},
	{
		name = "lcz_scp066_scp999",
		ent_name = "lcz_scp066_scp999",
		level = 3,
		sounds = true
	},
	{
		name = "lcz_scp1074",
		ent_name = "lcz_scp1074",
		level = 1,
		sounds = true
	},
	{
		name = "lcz_scp205",
		ent_name = "lcz_scp205",
		level = 1,
		sounds = true
	},
	{
		name = "lcz_scp205_2",
		ent_name = "lcz_scp205_2",
		level = 2,
		sounds = true
	},
	{
		name = "lcz_scp1499",
		ent_name = "lcz_scp1499",
		level = 2,
		sounds = true
	},
	{
		name = "lcz_scp860_1",
		ent_name = "lcz_scp860_1",
		level = 1,
		sounds = true
	},
	{
		name = "lcz_scp860_2",
		ent_name = "lcz_scp860_2",
		level = 4,
		sounds = true
	},
	{
		name = "lcz_scp860_3",
		ent_name = "lcz_scp860_3",
		level = 2,
		sounds = true
	},
	{
		name = "lcz_scp860_4",
		ent_name = "lcz_scp860_4",
		level = 3,
		sounds = true
	},
	{
		name = "lcz_bunker",
		ent_name = "lcz_bunker",
		level = 3,
		sounds = true
	},
	{
		name = "lcz_bunker_2",
		ent_name = "lcz_bunker_2",
		level = 3,
		sounds = true
	},
	{
		name = "lcz_bunker_3",
		ent_name = "lcz_bunker_3",
		level = 3,
		sounds = true
	},
	{
		name = "lcz_bunker_4",
		ent_name = "lcz_bunker_4",
		level = 3,
		sounds = true
	},
	{
		name = "lcz_barracks",
		ent_name = "lcz_barracks",
		level = 3,
		sounds = true
	},
	{
		name = "lcz_barracks_office",
		ent_name = "lcz_barracks_office",
		level = 3,
		sounds = true
	},
	{
		name = "lcd_laboratory",
		ent_name = "lcd_laboratory",
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