
YYYYYYYYYYYYYYYYYYYY = Vector(0,0,0)

function FindKeyPadByName(name)
	for i,v in ipairs(MAPCONFIG.KEYPADS) do
		if v.name == name then
			return i
		end
	end
end

MAPCONFIG.KEYPADS = {
	-- HCZ
	{
		name = "hcz_storage_room_code",
		pos = Vector(-3049.1201171875, 3943.9299316406, -7114.75),
		level = 0,
		code = 1234,
		code_available_on_start = true,
		code_can_be_obtained_by_radio = true,
		code_personal_office = false,
		sounds = true
	},
	{
		name = "hcz_double_stairs_code",
		pos = Vector(-2208.1201171875, 4767.9399414063, -7114.75),
		level = 0,
		code = 1234,
		code_available_on_start = true,
		code_can_be_obtained_by_radio = true,
		code_personal_office = false,
		sounds = true
	},
	{
		name = "hcz_035_backroom",
		pos = Vector(408, 704, -7114.75),
		level = 0,
		code = 1234,
		code_available_on_start = true,
		code_can_be_obtained_by_radio = true,
		code_available_for = function(ply)
			return ply.br_role == "SD Officer" or ply.br_team == TEAM_CI
		end,
		code_personal_office = false,
		sounds = true
	},
	{
		name = "hcz_049_doors",
		pos = Vector(4169, 1704, -8555),
		level = 0,
		code = 1234,
		code_available_on_start = true,
		code_can_be_obtained_by_radio = true,
		code_personal_office = false,
		sounds = true
	},

	-- Entrance Zone
	{
		name = "ez_office1a",
		pos = Vector(2056, 4144, -7115),
		level = 0,
		code = 1234,
		code_available_on_start = true,
		code_personal_office = true,
		personal_office = true,
		sounds = true
	},
	{
		name = "ez_office1b",
		pos = Vector(1756, 4144, -7115),
		level = 0,
		code = 1234,
		code_available_on_start = true,
		code_personal_office = true,
		personal_office = true,
		sounds = true
	},
	{
		name = "ez_office2b",
		pos = Vector(1826, 5798, -7115),
		level = 0,
		code = 1234,
		code_available_on_start = true,
		code_personal_office = true,
		personal_office = true,
		sounds = true
	},
	{
		name = "ez_actual_evac_shelter",
		ent_name = "mbutton_code_ez-evac",
		pos = Vector(4677.009765625, 5423, -7115),
		level = 0,
		code = 1234,
		code_available_on_start = false,
		code_can_be_obtained_by_radio = true,
		code_personal_office = false,
		evac_shelter = true,
		sounds = true
	},

	-- Outside
	{
		name = "outside_escape_gatea_code",
		ent_name = "outside_escape_gatea_code",
		pos = Vector(1554.62, 1209.99, 581.22),
		code = 1234,
		code_available_on_start = false,
		code_personal_office = false,
		code_ci_only = true,
		evac_shelter = false,
		sounds = true
	},
}
