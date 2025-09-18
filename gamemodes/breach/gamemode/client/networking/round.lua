
net.Receive("br_round_start", function(len)
	if IsValid(terminal_frame) then
		terminal_frame:Remove()
	end

	system.FlashWindow()

	br2_blackscreen = 0
end)

net.Receive("br_round_prepstart", function(len)
--READING NET INFO
	br2_current_scenario = net.ReadTable()
	local read_str1 = net.ReadString()
	br2_our_mission_set = net.ReadString()
	
--WINDOWS FLASH
	system.FlashWindow()

--CLEANING THE MAP
	game.CleanUpMap()

	BR2_OURINFO = {}
	round_start = CurTime()
	round_starting_end = CurTime() + GetConVar("br2_time_preparing"):GetFloat()

--SOUNDS
	if isnumber(MAPCONFIG.FirstSoundsLength) == true then
		firstsounds_end = CurTime() + MAPCONFIG.FirstSoundsLength + 5
	else
		firstsounds_end = CurTime() + 10
	end
	if br2_current_scenario.first_sounds_enabled == true then
		PlayFirstSounds(1)
	end
	RADIO4SOUNDS = table.Copy(RADIO4SOUNDSHC)
	RESET_ONESHOT_AMBIENTS()
	BR2_RESET_MUSIC_INFO()
	if br2_last_music != nil then
		br2_last_music:Stop()
		br2_last_music = nil
	end
	br2_last_music_name = "def_name"
	br2_is_music_ending = false

--RESET HUD
	RunConsoleCommand("cl_tfa_hud_hitmarker_enabled", 0)
	BR_ClearMenus()

	br2_last_death = -12
	br2_last_escape = -12

	lastseen_player = NULL
	lastseen_nick = ""
	lastseen_color = Color(0,0,0,0)
	lastseen_alpha = 0
	lastseen = 0

	primary_lights_on = false
	br2_generators_on = 0
	br2_generators_on_flash = false
	BR_INSANITY_ATTACK = 0

--RESET OTHER VARIABLES
	BR2_MTF_TEAMS = {
		{},
		{},
		{},
		{}
	}
	br2_notepad_own_notes = {}
	br2_lastPositions = {}
	br2_last_escape = 0
	sanity_alpha_delay = 0
	BR_OUR_TEMPERATURE = 0
	br2_our_sanity = 6
	br2_is_bleeding = false
	lastzone = nil
	br_round_end_votes = 0
	temprature_strongness = 0
	temprature_strongness = 0
	br_voted_for_round_end = false
	next_check_random_music = CurTime() + math.random(3, 10)
	br_next_blink = 0
	br_blink_time = 0

--REMOVE CLIENTSIDE ENTITIES
	if IsValid(horror_scp_ent) then
		horror_scp_ent:Remove()
	end


--AFTER ALL THINGS DONE
	if read_str1 != nil and istable(BR2_OURNOTEPAD) and istable(BR2_OURNOTEPAD.people) and !LocalPlayer():IsSpectator() then
		BR_OpenFirstRolePanel(read_str1)
	end
end)

net.Receive("br_round_info", function(len)
	local int1 = net.ReadInt(8)
	local int2 = net.ReadInt(16)
	local int3 = net.ReadInt(16)
	game_state = int1
	br2_round_state_end = int2
	br2_round_state_start = int3
end)

net.Receive("br_vote_round_end", function(len)
	br_voted_for_round_end = net.ReadBool()

	if br_voted_for_round_end then
		chat.AddText(Color(255,255,0,255), "Voted, next vote change in 15 seconds")
	else
		chat.AddText(Color(255,255,0,255), "Removed the vote, next vote change in 15 seconds")
	end
end)
