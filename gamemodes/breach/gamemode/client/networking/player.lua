
net.Receive("cl_playerdeath", function(len)
	if br2_last_music then br2_last_music:Stop() end
	br2_notepad_own_notes = {}

	local font_structure = {
		font = "Tahoma",
		extended = false,
		size = 128,
		weight = 1000,
		blursize = 0,
		scanlines = 0,
		antialias = true,
		underline = false,
		italic = false,
		strikeout = false,
		symbol = false,
		rotary = false,
		shadow = false,
		additive = false,
		outline = false,
	}

	font_structure.size = 128 * (ScrH() / 1080)
	surface.CreateFont("BR_DEATH_SCREEN_1", font_structure)

	font_structure.size = 64 * (ScrH() / 1080)
	surface.CreateFont("BR_DEATH_SCREEN_2", font_structure)

	timer.Simple(0.08, function()
		surface.PlaySound("breach2/D9341/Damage1.ogg")
		surface.PlaySound("breach2/music/death_"..math.random(1,6)..".ogg")
	end)

	br2_last_death = CurTime()
	br2_survive_time = net.ReadInt(16)
	br2_support_spawns = net.ReadTable()
end)

net.Receive("cl_playerescaped", function(len)
	if br2_last_music then br2_last_music:Stop() end
	--RunConsoleCommand("stopsound")

	local font_structure = {
		font = "Tahoma",
		extended = false,
		size = 128,
		weight = 1000,
		blursize = 0,
		scanlines = 0,
		antialias = true,
		underline = false,
		italic = false,
		strikeout = false,
		symbol = false,
		rotary = false,
		shadow = false,
		additive = false,
		outline = false,
	}

	font_structure.size = 128 * (ScrH() / 1080)
	surface.CreateFont("BR_DEATH_SCREEN_1", font_structure)

	font_structure.size = 64 * (ScrH() / 1080)
	surface.CreateFont("BR_DEATH_SCREEN_2", font_structure)

	timer.Simple(0.08, function()
		surface.PlaySound("breach2/EndingSound.ogg")
	end)
	
	br2_last_escape = CurTime()
	br2_last_death = CurTime()
	br2_survive_time = net.ReadInt(16)
end)
