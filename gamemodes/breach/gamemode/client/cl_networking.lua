
firstsounds_end = 0
br2_our_sanity = 6
br2_is_bleeding = false

function GotTeleportedToPD()
	surface.PlaySound("breach2/scp/106/Decay0.ogg")
	got_teleported_to_pd = CurTime()
	
	br2_music_info = {
		nextPlay = 0,
		volume = 1,
		length = 27.03,
		sound = "breach2/music/PD.ogg",
		playUntil = function() return LocalPlayer():IsInPD() end
	}
end

scp_012_pos = Vector(0,0,0)
scp_012_enabled = false
scp_012_next = 0
hook.Add("HUDPaint", "scp_012_seen_hook", function()
	if scp_012_enabled and scp_012_next > CurTime() then
		if scp_012_next > CurTime() then
			local ang = (scp_012_pos - LocalPlayer():GetShootPos()):Angle()
			local eyeang = EyeAngles()
			ang:Normalize()
			local yaw_d = math.abs(ang.yaw - eyeang.yaw)
			local pitch_d = math.abs(ang.pitch - eyeang.pitch)
			local add_pitch = 0
			local add_yaw = 0
			if yaw_d < 90 then
				if pitch_d < 40 and pitch_d > 1 then
					add_pitch = -0.25
					if (ang.pitch > eyeang.pitch) then
						add_pitch = 0.25
					end
				end
				if yaw_d > 1 then
					add_yaw = - 0.5
					if (ang.yaw > eyeang.yaw) then
						add_yaw = 0.5
					end
				end
			end
			LocalPlayer():SetEyeAngles(eyeang + Angle(add_pitch, add_yaw, 0))
		else
			scp_012_enabled = false
		end
	end
end)

lockpicking_timestamp = 0

function StartLockpicking()
	lockpicking_timestamp = CurTime() + 9
	InitiateProgressCircle(9)
	chat.AddText(Color(255,255,255,255), "Started lockpicking...")
end

function StopLockpicking()
	lockpicking_timestamp = 0
	progress_circle_end = nil
	progress_circle_time = nil
	progress_circle_status = 0
	chat.AddText(Color(255,255,255,255), "Stopped lockpicking...")
end

br_crates_info = {}

net.Receive("br_send_crate_info", function(len)
	br_crates_info = net.ReadTable()
end)

net.Receive("br_vote_round_end", function(len)
	br_voted_for_round_end = net.ReadBool()
	if br_voted_for_round_end then
		chat.AddText(Color(255,255,0,255), "Voted, next vote change in 15 seconds")
	else
		chat.AddText(Color(255,255,0,255), "Removed the vote, next vote change in 15 seconds")
	end
end)

net.Receive("scp_012_seen", function(len)
	scp_012_enabled = true
	scp_012_next = CurTime() + 0.2
	scp_012_pos = net.ReadVector()
end)

function BR2_CL_GENERATORS_ON()
	surface.PlaySound("breach2/intro/Light2.ogg")
	br2_generators_on = CurTime() + 1
	br2_generators_on_flash = true
	primary_lights_on = true
end

net.Receive("br_enable_primary_lights", function(len)
	BR2_CL_GENERATORS_ON()
end)

net.Receive("br_disable_primary_lights", function(len)
	primary_lights_on = false
end)

net.Receive("br_use_document", function(len)
	local doc_info = net.ReadTable()
	Open_Document(doc_info)
end)

net.Receive("br_force_print_name", function(len)
	local ent_got = net.ReadEntity()
	local str_got = net.ReadString()
	if IsValid(ent_got) then
		ent_got.PrintName = str_got
		ent_got.ForceHalo = true
	end
end)

--UNUSED
net.Receive("br_force_print_name2", function(len)
	local ents_got = net.ReadTable()
	local str_got = net.ReadString()
	print("br_force_print_name2")
	--PrintTable(ents_got)

	for k,v in pairs(ents.GetAll()) do
		for k2,v2 in pairs(ents_got) do
			if v:GetPos():Distance(v2) < 10 then
				print("found ent: ", v)
				v.PrintName = str_got
			end
		end
	end
end)

net.Receive("br_use_outfitter", function(len)
	local tab_got = net.ReadTable()
	BR_OpenOutfitterMenu(tab_got)
	surface.PlaySound("breach2/pickitem2.ogg")
end)

function SimpleButtonUse(button)
	button.func_cl()
	net.Start("br_use_button_simple")
		net.WriteVector(button.pos)
	net.SendToServer()
end

local next_simple_button_use = 0
function SodaMachineUse(button)
	if next_simple_button_use > CurTime() then return end
	net.Start("br_use_soda_machine")
		net.WriteVector(button.pos)
	net.SendToServer()
	next_simple_button_use = CurTime() + 1
end

BR_OUR_TEMPERATURE = 0
net.Receive("br_update_temperature", function(len)
	BR_OUR_TEMPERATURE = net.ReadInt(16)
end)

BR_OUR_STAMINA = 0
BR_OUR_INFECTION = 0
net.Receive("br_update_misc", function(len)
	BR_OUR_STAMINA = net.ReadInt(16)
	BR_OUR_INFECTION = net.ReadInt(16)
end)

net.Receive("br_get_body_notepad", function(len)
	local tab = net.ReadTable()
	BR_ShowNotepad(tab)
end)

net.Receive("br_retrieve_own_notes", function(len)
	net.Start("br_retrieve_own_notes")
		net.WriteTable(br2_notepad_own_notes or {})
	net.SendToServer()
end)

net.Receive("br_update_own_info", function(len)
	local client = LocalPlayer()

	client.br_showname = net.ReadString()
	client.br_role = net.ReadString()
	client.br_team = net.ReadInt(8)
	client.br_ci_agent = net.ReadBool()
	client.br_zombie = net.ReadBool()

	client.ShouldDisableLegs = false
	if client.br_role == "SCP-173" then
		client.ShouldDisableLegs = true
	end
end)

net.Receive("br_get_special_items", function(len)
	local tab = net.ReadTable()
	BR_OpenInventoryMenu(tab)
end)

net.Receive("br_get_owned_devices", function(len)
	local tab = net.ReadTable()

	if table.Count(tab) > 0 then
		BR_CURRENT_TERMINAL_PANEL.devices_pop(tab)
	end
end)

net.Receive("br_get_terminal_settings", function(len)
	local tab = net.ReadTable()

	if table.Count(tab) > 0 then
		BR_CURRENT_TERMINAL_PANEL.settings_pop(tab)
	end
end)

net.Receive("br_install_device", function(len)
	BR_Access_Terminal(terminal_frame.terminal)
	BR_Access_Terminal_Loading(terminal_frame.terminal)
	terminal_frame:Remove()
end)

net.Receive("br_use_294", function(len)
	local res = net.ReadInt(16)

	if res == SCP294_RESULT_OUTOFRANGE then
		keyboard_294_text = "OUT OF RANGE"
		surface.PlaySound("breach2/294/outofrange.ogg")

	-- normal, nothing came out
	elseif res == SCP294_RESULT_NOTHING then
		keyboard_294_text = "DISPENSING..."
		surface.PlaySound("breach2/294/dispense0.ogg")

	-- normal fluid
	elseif res == SCP294_RESULT_NORMAL then
		keyboard_294_text = "DISPENSING..."
		surface.PlaySound("breach2/294/dispense1.ogg")

	-- struggling, fluid
	elseif res == SCP294_RESULT_STRUGGLING then
		keyboard_294_text = "DISPENSING..."
		surface.PlaySound("breach2/294/dispense2.ogg")

	-- some insanity happened, fluid
	elseif res == SCP294_RESULT_INSANE then
		keyboard_294_text = "DISPENSING..."
		surface.PlaySound("breach2/294/dispense3.ogg")
	end
end)

net.Receive("br_get_loot_info", function(len)
	local loot_info = net.ReadTable()
	local source_got = net.ReadTable()
	BR_OpenLootingMenu(loot_info, source_got)
end)

net.Receive("br_update_bleeding", function(len)
	br2_is_bleeding = net.ReadBool()
end)

br2_our_sanity2 = 100

net.Receive("br_update_sanity", function(len)
	br2_our_sanity = net.ReadInt(8)
	br2_our_sanity2 = net.ReadInt(16)
end)

net.Receive("br_update_hunger", function(len)
	br_our_hunger = net.ReadInt(16)
	br_our_thirst = net.ReadInt(16)
	--print("hunger update", br_our_hunger, br_our_thirst)
end)

br2_support_spawns = {}

net.Receive("cl_playerdeath", function(len)
	if br2_last_music then br2_last_music:Stop() end
	--RunConsoleCommand("stopsound")
	print("DEAD")
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

net.Receive("br_pregame_spawns", function(len)
	br2_last_death = CurTime() - 20
	br2_survive_time = 0
	br2_support_spawns = net.ReadTable()
end)

net.Receive("br_update_support_spawns", function(len)
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

br2_round_state_start = 0
net.Receive("br_round_info", function(len)
	local int1 = net.ReadInt(8)
	local int2 = net.ReadInt(16)
	local int3 = net.ReadInt(16)
	game_state = int1
	br2_round_state_end = int2
	br2_round_state_start = int3
end)

net.Receive("br_playsound", function(len)
	--print("playing sound")
	local str = net.ReadString()
	local vec = net.ReadVector()
	sound.Play("breach2/" .. str, vec)
end)

net.Receive("br_keypad", function(len)
	OpenKeyPad()
end)

net.Receive("br_open_terminal", function(len)
	local passed = net.ReadBool()
	local infoGot = net.ReadTable()
	local loginInfo = net.ReadTable()
	loading_terminal.endfunc(passed, infoGot, loginInfo)
end)

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

/*
function AddPlayerInfo(info_got)
	for k,v in pairs(BR2_OURINFO.PLAYERS) do
		if v.br_showname != nil then
			if v.br_showname == info_got.br_showname then
				v.br_role = info_got.br_role

				return
			end
		end
	end
	table.ForceInsert(BR2_OURINFO.PLAYERS, info_got)
end
*/

net.Receive("br_updatebattery", function(len)
	local int_got = net.ReadInt(8)
	local int2_got = net.ReadInt(8)
	local wep = LocalPlayer():GetActiveWeapon()
	for k,v in pairs(LocalPlayer():GetWeapons()) do
		if v.Slot == int2_got then
			wep.BatteryLevel = int_got
		end
	end
	/*
	if IsValid(wep) then
		--print(wep.BatteryLevel)
		wep.BatteryLevel = int_got
		if wep.BatteryLevel < 1 and isfunction(wep.RemoveSounds) then
			wep:RemoveSounds()
		end
	end
	*/
end)

BR2_MTF_TEAMS = {
	{},
	{},
}

br_our_team_num = 0

net.Receive("br_mtf_team_ready", function(len)
	print("OUR TEAM IS READY")
	system.FlashWindow()
	/*
	if IsValid(br_our_mtf_frame) then
		br_our_mtf_frame:Remove()
	end
	if IsValid(info_menu_1_frame) then
		info_menu_1_frame:Remove()
	end

	BR_ForceOpen_Terminal(br_terminal_mtf, "mobile_task_force_terminal_1")
	return
	*/
end)

net.Receive("br_mtf_teams_update", function(len)
	BR2_MTF_TEAMS = net.ReadTable()
	--print("BR2_MTF_TEAMS")
	--PrintTable(BR2_MTF_TEAMS)

	local found_ourselves = false
	local our_team = nil
	for i,v in ipairs(BR2_MTF_TEAMS) do
		for k,pl in pairs(v) do
			if pl == LocalPlayer() then
				found_ourselves = true
				our_team = v
				br_our_team_num = i
			end
		end
	end

	if istable(our_team) and #our_team > 1 then
		return
	end

	if found_ourselves == false then
		if IsValid(br_our_mtf_frame) then
			br_our_mtf_frame:Remove()
		end
	else
		if !IsValid(br_our_mtf_frame) then
			local size_w = 180
			local size_h = 190
		
			br_our_mtf_frame = vgui.Create("DFrame")
			br_our_mtf_frame:SetTitle("")
			br_our_mtf_frame:ShowCloseButton(false)
			br_our_mtf_frame:SetDraggable(false)
			br_our_mtf_frame:SetPos(ScrW() - size_w, ScrH() - size_h)
			br_our_mtf_frame:SetSize(size_w, size_h)
			br_our_mtf_frame.nextUpdate = 0
			br_our_mtf_frame.Think = function(self)
				if !IsValid(info_menu_1_frame) and br_our_mtf_frame.nextUpdate < CurTime() then
					net.Start("br_mtf_teams_update")
					net.SendToServer()
					br_our_mtf_frame.nextUpdate = CurTime() + 1
				end
			end

			--our_team = {Entity(1), Entity(2), Entity(3), Entity(4)}
			br_our_mtf_frame.Paint = function(self, w, h)
				for i,v in ipairs(BR2_MTF_TEAMS) do
					for k,pl in pairs(v) do
						if pl == LocalPlayer() then
							found_ourselves = true
							our_team = v
							br_our_team_num = i
						end
					end
				end
				
				draw.RoundedBox(0, 0, 0, w, h, Color(25, 25, 25, 200))
				draw.Text({
					text = "MTF Team "..br_our_team_num.."",
					pos = {w / 2, 32},
					xalign = TEXT_ALIGN_CENTER,
					yalign = TEXT_ALIGN_CENTER,
					font = "BR_INFO_1_FONT_3",
					color = Color(255,33,58,150),
				})
				for i,ply in ipairs(our_team) do
					if IsValid(ply) then
						draw.Text({
							text = ply:Nick() or "Unknown",
							pos = {w / 2, 32 + i * 32},
							xalign = TEXT_ALIGN_CENTER,
							yalign = TEXT_ALIGN_CENTER,
							font = "BR_INFO_1_FONT_3",
							color = Color(255,255,255,200),
						})
					end
				end
			end
		end
	end
end)

net.Receive("br_updatecode_radio", function(len)
	local code = net.ReadString()
	local wep = LocalPlayer():GetActiveWeapon()
	if IsValid(wep) then
		wep.Code = code
		--print("got the code")
	end
end)

net.Receive("br_end_reviving", function(len)
	local is_alive = net.ReadBool()
	if is_alive == false then
		last_body.Pulse = true
	end
end)

net.Receive("br_is_reviving", function(len)
	--print("is_reviving")
	last_revive_check = CurTime()
	last_revive_time = net.ReadFloat()
	--print(last_revive_time)
end)

net.Receive("br_end_checking_pulse", function(len)
	local isAlive = net.ReadBool()
	--print("checking pulse end ("..tostring(isAlive)..")")
	if isAlive == true then
		last_body.Pulse = CurTime()
	else
		last_body.Pulse = true
	end
end)


net.Receive("br_check_pulse", function(len)
	local isAlive = net.ReadBool()
	if isAlive == true then
		last_body.Pulse = CurTime()
	else
		last_body.Pulse = true
	end
	--last_body = NULL
end)

net.Receive("br_player_downed", function(len)
	surface.PlaySound("breach2/player_breathing_knockout01.wav")
	surface.PlaySound("breach2/D9341/Damage1.ogg")
	next_blood_sound = CurTime() + 4
end) 

local next_blood_sound = 0
net.Receive("br_update_health_state", function(len)
	body_health = net.ReadInt(8)
	--print("our health: "..body_health.."")
	last_health_check = CurTime()
	if next_blood_sound < CurTime() then
		surface.PlaySound("breach2/D9341/BloodDrip"..math.random(0,3)..".ogg")
		next_blood_sound = CurTime() + 4
	end
end)

function BR_AssignNotepadPlayers()
	for _,pl in pairs(player.GetAll()) do
		if pl != LocalPlayer() then
			pl.br_showname = nil
			pl.br_ci_agent = nil
			pl.br_role = nil
			pl.health = nil
			pl.scp = nil
		end
	end

	if LocalPlayer().Alive and LocalPlayer():Alive() and !LocalPlayer():IsSpectator() then
		for _,pl in pairs(player.GetAll()) do
			if BR2_OURNOTEPAD.people == nil then
				--print(pl:Nick() .. " ERRRROOOORR RRR R")
				--PrintTable(BR2_OURNOTEPAD)
				BR2_OURNOTEPAD = {}
				BR2_OURNOTEPAD.people = {}
			end

			for k,v in pairs(BR2_OURNOTEPAD.people) do
				if pl:GetNWInt("BR_CharID") == v.charid then
					--print("found " .. pl:Nick() .. " " .. v.charid)
					pl.br_showname = v.br_showname
					pl.br_ci_agent = v.br_ci_agent
					pl.br_role = v.br_role
					pl.br_team = v.br_team
					pl.health = v.health
					pl.scp = v.scp
				end
			end
		end
	else
		print(LocalPlayer(), LocalPlayer().br_role, LocalPlayer().br_team, LocalPlayer():Alive(), LocalPlayer():IsSpectator())
		error("tried to update notepad of dead localplayer")
	end
end

net.Receive("br_send_notepad", function(len)
	local got_tab = net.ReadTable()
	BR2_OURNOTEPAD = got_tab

	for k,v in pairs(player.GetAll()) do
		if v != LocalPlayer() then
			v.br_info = nil
			v.br_showname = nil
			v.br_role = nil
			v.br_team = nil
		end
	end

	if BR2_OURNOTEPAD.people and table.Count(BR2_OURNOTEPAD.people) > 0 then
		--LocalPlayer().br_showname = BR2_OURNOTEPAD.people[1].br_showname
		--LocalPlayer().br_ci_agent = BR2_OURNOTEPAD.people[1].br_ci_agent
		--LocalPlayer().br_role = BR2_OURNOTEPAD.people[1].br_role
		
		/*
		for _,pl in pairs(player.GetAll()) do
			for k,v in pairs(BR2_OURNOTEPAD.people) do
				print(pl:Nick(), pl:GetNWInt("BR_CharID"), v.ent)
				if pl:GetNWInt("BR_CharID") == v.ent then
					print(pl:Nick() .. " found")
					pl.br_showname = v.br_showname
					pl.br_ci_agent = v.br_ci_agent
					pl.br_role = v.br_role
					pl.health = v.health
					pl.scp = v.scp
				end
			end
		end
		*/
		timer.Simple(0.1, BR_AssignNotepadPlayers)
		--BR_AssignNotepadPlayers()
	--else
		--print("RECEIVED NO PEOPLE IN NOTEPAD")
	end
	--print("updated notepad")
end)

net.Receive("br_send_info", function(len)
	local info_got = net.ReadTable()
	local steamid64_got = net.ReadString()

	local ply_got = player.GetBySteamID64(steamid64_got)

	if IsValid(ply_got) and istable(info_got) then
		ply_got.br_showname = info_got.br_showname
		ply_got.br_role = info_got.br_role
		ply_got.br_team = info_got.br_team
		ply_got.br_ci_agent = info_got.br_ci_agent
		ply_got.br_info = info_got
	else
		print("info_got")
		if istable(info_got) then
			PrintTable(info_got)
		end
		error("Got info on a player but its invalid " .. tostring(ply_got) .. " " .. tostring(info_got))
	end
end)

/*
--lua_run_cl AskServerForInfo(Entity(2))
function AskServerForInfo(target_ply)
	if IsValid(target_ply) then
		if target_ply:IsPlayer() then
			if target_ply != LocalPlayer() then
				net.Start("br_send_info")
					net.WriteEntity(target_ply)
				net.SendToServer()
			end
		end
	end
end
*/

net.Receive("br_check_someones_notepad", function(len)
	local notepad = net.ReadTable()
	BR_ShowNotepad(notepad)
end)

function EndPickpocketingNotepad()
	if !IsValid(targeted_player) then return end

	net.Start("br_check_someones_notepad")
		net.WriteEntity(targeted_player)
	net.SendToServer()
end

--TODO
function EndLootingBody()
	if !IsValid(examined_player) then return end

	net.Start("br_get_loot_info")
		net.WriteEntity(examined_player)
	net.SendToServer()
end

--TODO
function EndExaminingSomeone()
	if !IsValid(examined_player) then return end

	--chat.AddText(Color(255,255,255,255), "Examining...")
	if examined_player:GetClass() == "prop_ragdoll" then
		if examined_player.Pulse then
			if examined_player.Pulse == true then
				chat.AddText(Color(255,0,0,255), " - He is dead")
				local dmg_info = examined_player:GetNWString("ExamineDmgInfo", nil)
				if dmg_info != nil then
					chat.AddText(Color(255,0,0,255), dmg_info)
				end
				local death_time = examined_player:GetNWInt("DeathTime", nil)
				if death_time != nil then
					chat.AddText(Color(255,255,255,255), " - He died " .. string.ToMinutesSeconds(CurTime() - death_time) .. " minutes ago")
				end
				return
			elseif isnumber(examined_player.Pulse) then
				chat.AddText(Color(255,255,255,255), " - He is probably alive")
				return
			end
		end
		chat.AddText(Color(255,255,255,255), " - Looks dead but i am not sure...")
		return
	end
--PERSONAL INFOS
	if examined_player.br_showname != nil then
		chat.AddText(Color(255,255,255,255), " - You remember that their name was " .. examined_player.br_showname)
	else
		chat.AddText(Color(255,255,255,255), " - You don't really know a lot about this person")
	end
--ARMOR
	if examined_player:Armor() > 0 then
		chat.AddText(Color(56, 205,255), " - He seems to be wearing some kind of armor")
	end
--WEAPONS
	local has_wep = false
	for k,v in pairs(examined_player:GetWeapons()) do
		if IsValid(v) and isLethalWeapon(v) then
			has_wep = true
		end
	end
	if has_wep then
		chat.AddText(Color(56, 205,255), " - He seems to be carrying lethal weapons")
	end
--WATER LEVEL
	local water = examined_player:WaterLevel()
	if water == 1 then
		chat.AddText(Color(255,255,255), " - He is slightly submerged")
	elseif water == 2 then
		chat.AddText(Color(255,255,255), " - He is submerged")
	elseif water == 3 then
		chat.AddText(Color(255, 255,255), " - He is completely submerged")
	end
--FIRE
	if examined_player:IsOnFire() then
		chat.AddText(Color(255,0,0), " - He is on fire!")
	end
end

net.Receive("br_hack_terminal", function(len)
	local logins = net.ReadTable()
	BR_Hack_Terminal(logins)
end)

net.Receive("br_custom_screen_effects", function(len)
	local duration = net.ReadFloat()
	local tab = net.ReadTable()
	
	br_our_custom_screen_effects = tab
	br_our_custom_screen_effects_for = CurTime() + duration
end)

net.Receive("br_blinking", function(len)
	br_blink_time = net.ReadFloat()
	br_next_blink = CurTime() + br_blink_time
end)

print("[Breach2] client/cl_networking.lua loaded!")