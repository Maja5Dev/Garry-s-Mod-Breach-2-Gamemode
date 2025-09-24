
function IsRoundTimeProgress(progress)
	return game_state == GAMESTATE_ROUND and (br2_round_state_end - CurTime()) < (cvars.Number("br2_time_round", 1320) * (1 - progress))
end

round_system = {}
round_system.current_scenario = BREACH_SCENARIOS[1]
round_system.current_names = table.Copy(round_system.current_scenario.name_list)
round_system.commotion_sounds = {}
game_state = GAMESTATE_NOTSTARTED

round_system.ThreatLevel = function()
	local threat_level = 0
	for k,v in pairs(player.GetAll()) do
		if v:Alive() and v:IsSpectator() == false then
			if v.br_team == TEAM_RESEARCHER then
				threat_level = threat_level + 2
				
			elseif v.br_team == TEAM_CLASSD then
				threat_level = threat_level + 3

			elseif v.br_team == TEAM_CI then
				threat_level = threat_level + 8

			elseif v.br_team == TEAM_SCP then
				threat_level = threat_level + 12

			elseif v.br_team == TEAM_MTF then
				threat_level = threat_level - 4

			elseif v.br_team == TEAM_SECURITY then
				threat_level = threat_level - 2
			else
				threat_level = threat_level + 1
			end

			for _,wep in pairs(v:GetWeapons()) do
				if IsValid(wep) and isLethalWeapon(wep) then
					threat_level = threat_level + 1
				end
			end
		end
	end
	return threat_level
end

round_system.AlreadyAnnouncedMTF = false
round_system.Force_MTF_Spawn = function()
	round_system.Next_MTF_Spawn = CurTime() + math.random(40,320)
	local mtf_spawns = table.Random(table.Copy(MAPCONFIG.SPAWNS_MTF)).spawns
	
	print("Mobile Task Force FORCE Spawned")
	local all_mtfs = {}
	local existingMTFs = {}

	for k,v in pairs(player.GetAll()) do
		if v:Alive() and !v:IsSpectator() and (v.br_role == "MTF Operative" or v.br_team == TEAM_MTF) then
			table.ForceInsert(existingMTFs, v)
		end
	end

	for k,v in pairs(player.GetAll()) do
		if v:IsSpectator() then
			local spawn = table.Random(mtf_spawns)

			v.br_team = TEAM_MTF
			v.charid = BR_GetUniqueCharID()
			assign_system.Assign_MTF_NTF(v)
			v:SetPos(spawn)

			if IsValid(v.Body) then
				v.Body.Info.Victim = nil
			end

			notepad_system.AssignNewNotepad(v, false)

			for k_info,info in pairs(BR2_MTF_STARTING_INFORMATION) do
				notepad_system.AddPlayerInfo(v, info.br_showname, info.br_role, info.br_team, info.br_ci_agent, info.health, info.isscp, nil, nil)
			end

			local evac_code = MTF_GetEvacInfo()

			if evac_code != nil then
				notepad_system.AddAutomatedInfo(v, "evacuation code:  " .. evac_code)
			end

			table.ForceInsert(all_mtfs, v)
			table.RemoveByValue(mtf_spawns, spawn)
		end
	end

	for k,v in pairs(all_mtfs) do
		for k2,v2 in pairs(all_mtfs) do
			if v != v2 then
				notepad_system.AddPlayerInfo(v, v2.br_showname, v2.br_role, v2.br_team, false, HEALTH_ALIVE, false, v2.charid, v2)
			end
		end

		for k2,v2 in pairs(existingMTFs) do
			notepad_system.AddPlayerInfo(v, v2.br_showname, v2.br_role, v2.br_team, false, HEALTH_ALIVE, false, v2.charid, v2)
		end
		
		notepad_system.UpdateNotepad(v)
	end
	
	if round_system.AlreadyAnnouncedMTF == false then
		BroadcastLua('surface.PlaySound("breach2/mtf/Announc.ogg")')
		round_system.AlreadyAnnouncedMTF = true
	end
end

round_system.Next_MTF_Spawn = 0
round_system.MTF_Check = function()
	if round_system.Next_MTF_Spawn < CurTime() then
		local spectators = {}

		for k,v in pairs(player.GetAll()) do
			if v:IsSpectator() then
				table.ForceInsert(spectators, v)
			end
		end

		if #spectators > 2 then
			round_system.Force_MTF_Spawn()
		end
	end
end

round_system.GiveInformation = function()
	if istable(round_system.current_scenario) then
		if isstring(round_system.current_scenario.starting_information) then
			if isfunction(_G[round_system.current_scenario.starting_information]) then
				_G[round_system.current_scenario.starting_information]()
			end
		elseif isfunction(round_system.current_scenario.starting_information) then
			round_system.current_scenario.starting_information()
		end
	end
end

round_system.AssignPlayers = function()
	devprint("assigning players...")
	local assign_time = CurTime()
	local all_players = table.Copy(player.GetAll())

	local all_roles = {}
	for i=1, #all_players do
		local role = round_system.current_scenario.role_list.roles[i]

		if role.assign_function == nil or assign_system[role.assign_function] == nil then
			Error("Role " .. role.class .. "(" .. i .. ")" .. " has no assign_function!")
		end

		table.ForceInsert(all_roles, role)
	end

	local tab_players_roles = {}

	-- For debugging or giving someone a specific role
	for _,pl in pairs(all_players) do
		if pl.forcerole then
			local found = false

			for k,v in pairs(all_roles) do
				if pl.forcerole == k or pl.forcerole == v.class then
					role = v
					found = true
					table.ForceInsert(tab_players_roles, {pl, role})
					table.RemoveByValue(all_roles, role)
					table.RemoveByValue(all_players, pl)
					break
				end
			end

			if !found then
				ErrorNoHaltWithStack("havent found force role! (" .. tostring(pl.forcerole) .. ")")
				PrintTable(all_roles)
				print("")
			end
		end
	end

	for i=1, #all_players do
		local rnd_player = table.Random(all_players)
		local role = table.Random(all_roles)

		table.ForceInsert(tab_players_roles, {rnd_player, role})

		table.RemoveByValue(all_roles, role)
		table.RemoveByValue(all_players, rnd_player)
	end
	
	local map_config = {}
	if MAPCONFIG != nil then
		map_config = table.Copy(MAPCONFIG)
	end

	local researcher_num = 0

	local i = 1
	for k,v in pairs(round_system.current_scenario.role_list.roles) do
		if i > player.GetCount() then break end
		if v.class == "researcher" then
			researcher_num = researcher_num + 1
		end
		i = i + 1
	end

	local ci_spies_num = math.Round(researcher_num * (SafeIntConVar("br2_ci_percentage") / 100))
	local ci_spies_spawned = 0

	-- This system goes through random players and assigns them the first available role in the role table

	for i,pl_role in pairs(tab_players_roles) do
		local pl = pl_role[1]
		local role = pl_role[2]

		if istable(role) then
			/*
			if role.class == "scp_unkillable" then
				if math.random() < BR2_ASSIGN_CONFIG.SCP_SPAWN_AS_PLAYER_CHANCE then
					print("SCP NOT SPAWNING BECAUSE CHANCE FAILEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEED")
					role_num = role_num + 1
					role = round_system.current_scenario.role_list.roles[role_num] or round_system.current_scenario.role_list.roles[1]
				end
			end
			*/

			if role.class == "researcher" and round_system.current_scenario.enable_ci_researchers
				and ci_spies_spawned < ci_spies_num and math.random(1,100) < SafeIntConVar("br2_ci_chance")
			then
				ci_spies_spawned = ci_spies_spawned + 1
				role = BREACH_DEFAULT_ROLES.roles_ci_agent_res
			end

			pl.br_team = role.team
			assign_system[role.assign_function](pl)
			pl:SetTeam(TEAM_ALIVE)
			pl.charid = BR_GetUniqueCharID()
			pl.br_team = role.team

			for k2,v2 in pairs(BR2_SPECIAL_ITEMS) do
				v2.onstart(pl)
			end

			local spawned = false
			if isstring(pl.br_customspawn)then
				if istable(map_config[pl.br_customspawn]) then
					local rnd_spawn = table.Random(map_config[pl.br_customspawn])
					pl.br_spawn_groups = map_config[pl.br_customspawn]
					if isvector(rnd_spawn) == true then
						pl:SetPos(rnd_spawn)
						table.RemoveByValue(map_config[pl.br_customspawn], rnd_spawn)
						spawned = true
					end
				end
			end

			if spawned == false and istable(role.spawns) then
				for i=1, #role.spawns do
					if spawned == false then
						local rnd_spawn_group = table.Random(role.spawns)

						if isstring(rnd_spawn_group) and istable(map_config[rnd_spawn_group]) then
							local rnd_spawn = table.Random(map_config[rnd_spawn_group])
							pl.br_spawn_groups = map_config[rnd_spawn_group]

							if isvector(rnd_spawn) == true then
								pl:SetPos(rnd_spawn)
								table.RemoveByValue(map_config[rnd_spawn_group], rnd_spawn)
								spawned = true
							end
						end
					end
				end
			end
		end
	end
	
	--timer.Simple(1, round_system.GiveInformation)
	round_system.GiveInformation()
	
	assign_time = CurTime() - assign_time
	devprint("assigning took " .. assign_time .. " seconds...")
end

function PlayCommotionSound()
	if istable(round_system.commotion_sounds) then
		local rnd_sound = table.Random(round_system.commotion_sounds)

		if isstring(rnd_sound) == false then
			devprint("Couldnt find a commotion sound, removing the timer.")
			timer.Remove("PlayCommotionSounds")
			return
		end

		--lua_run_cl PlayAmbientSound("breach2/intro/Commotion/Commotion1.ogg", 600, 600)
		BroadcastLua('surface.PlaySound("' .. rnd_sound .. '")')
		--BroadcastLua('PlayAmbientSound("'..rnd_sound..'", 600, 600)')
		table.RemoveByValue(round_system.commotion_sounds, rnd_sound)
		
		timer.Create("PlayCommotionSounds", math.random(8,14), 1, PlayCommotionSound)
	end
end

round_system.HandleCommotionSounds = function()
	if istable(MAPCONFIG.CommotionSounds) then
		round_system.commotion_sounds = table.Copy(MAPCONFIG.CommotionSounds)
		local wait = 10
		if isnumber(MAPCONFIG.FirstSoundsLength) then
			wait = MAPCONFIG.FirstSoundsLength + 5
		end
		timer.Create("PlayCommotionSounds", wait, 1, PlayCommotionSound)
	end
end

round_system.AssignRandomCodes = function()
	local all_possible_codes = {}
	local all_possible_personal_codes = {}
	local all_ci_codes = {}

	for k,v in pairs(MAPCONFIG.KEYPADS) do
		if v.code_available_on_start then
			if v.code_personal_office then
				table.ForceInsert(all_possible_personal_codes, {v.name, v.code})
			else
				table.ForceInsert(all_possible_codes, {v.name, v.code})
			end

		elseif v.code_ci_only then
			table.ForceInsert(all_ci_codes, {v.name, v.code})
		end
	end

	local all_pl = table.Copy(player.GetAll())

	for k,v in pairs(all_pl) do
		if v.br_team == TEAM_CI then
			for k2,v2 in pairs(all_ci_codes) do
				notepad_system.AddAutomatedInfo(v, "Code: "..v2[2].." ("..v2[1]..")")
			end
		end
	end

	for i=1, #all_pl do
		local v = table.Random(all_pl)
		local bt = v.br_team

		if v.br_role == "Researcher" then
			local random_personal_code = table.Random(all_possible_personal_codes)
			if random_personal_code != nil then
				notepad_system.AddAutomatedInfo(v, "Personal office code: "..random_personal_code[2].." ("..random_personal_code[1]..")")
				table.RemoveByValue(all_possible_personal_codes, random_personal_code)
			end


		elseif (isfunction(v.code_available_for) and v.code_available_for(v))
			or bt == TEAM_RESEARCHER or bt == TEAM_SECURITY or bt == TEAM_CI
		then
			local random_code = table.Random(all_possible_codes)
			if random_code != nil then
				notepad_system.AddAutomatedInfo(v, "Code: "..random_code[2].." ("..random_code[1]..")")
				table.RemoveByValue(all_possible_codes, random_code)
			end
		end
		table.RemoveByValue(all_pl, v)
	end

	for k,v in pairs(player.GetAll()) do
		notepad_system.UpdateNotepad(v)
	end
end

function BR2_ChangeLightingStyle(cli)
	if cli then
		engine.LightStyle(0, cli)
	else
		engine.LightStyle(0, "d")
	end
	BroadcastLua('render.SetAmbientLight(0,0,0)')
	BroadcastLua('render.RedownloadAllLightmaps(true)')
end

--lua_run force_scenario = 2
--lua_run round_system.PreparingStart()
round_system.PreparingStart = function()
	local result = hook.Call("BR2_PreparingStart")
	if result == true then return end

	for k,v in pairs(player.GetAll()) do
		if !v:IsBot() then
			timer.Destroy("drinkuse"..v:SteamID64())
		end
		timer.Destroy("deletenotepad"..v:SteamID64())
		timer.Destroy("BR_UpdateOwnInfo"..v:SteamID64())
		v.Body = nil
	end
	uses_294 = nil

	round_system.logins = {}

	game_state = GAMESTATE_PREPARING
	game.CleanUpMap()
	br2_mtf_teams_reset()

	if isnumber(force_scenario) then
		round_system.current_scenario = BREACH_SCENARIOS[force_scenario]
	else
		round_system.current_scenario = BREACH_SCENARIOS[1]
	end

	BR_ROUND_END_VOTERS = {}

	RunConsoleCommand("sbox_godmode", "0")
	RunConsoleCommand("sbox_playershurtplayers", "1")

	if isfunction(round_system.current_scenario.preparing_start) then round_system.current_scenario.preparing_start() end

	create_all_possible_names()
	all_fake_corpses = {}

	if isfunction(Breach_Map_Organise) and round_system.current_scenario.disable_map_organisation != true then
		Breach_Map_Organise()
	end

	if istable(MAPCONFIG) then
		MAP_ResetGasZones()
		MAP_ResetGenerators()
	end

	SetGlobalBool("PrimaryGeneratorsOn", false)
	BR2_MTF_STARTING_INFORMATION = {}
	round_system.AssignPlayers()

	if round_system.current_scenario.disable_getting_codes == false then
		round_system.AssignRandomCodes()
	end

	if isfunction(round_system.current_scenario.after_assign) then
		round_system.current_scenario.after_assign()
	end

	timer.Remove("PlayCommotionSounds")
	timer.Remove("LockdownWait")
	timer.Remove("GasLeak1")
	timer.Remove("GasLeak2")
	timer.Remove("GasLeak3")
	timer.Create("LockdownWait", 5, 1, function()
		if isfunction(MAPCONFIG.Lockdown) == true then
			MAPCONFIG.Lockdown(true)
		end
	end)

	if round_system.current_scenario.disable_commotion_sounds != true then
		round_system.HandleCommotionSounds()
	end

	local send_scenario = {}
	send_scenario.name = round_system.current_scenario.name
	send_scenario.fake_corpses = round_system.current_scenario.fake_corpses
	send_scenario.disable_map_organisation = round_system.current_scenario.disable_map_organisation
	send_scenario.disable_commotion_sounds = round_system.current_scenario.disable_commotion_sounds
	send_scenario.friendly_fire_enabled = round_system.current_scenario.friendly_fire_enabled
	send_scenario.first_sounds_enabled = round_system.current_scenario.first_sounds_enabled
	send_scenario.first_sounds_override = round_system.current_scenario.first_sounds_override

	for k,v in pairs(player.GetAll()) do
		if v.first_info and v.mission_set then
			net.Start("br_round_prepstart")
				net.WriteTable(send_scenario)
				net.WriteString(v.first_info)
				net.WriteString(v.mission_set)
			net.Send(v)
		else
			net.Start("br_round_prepstart")
				net.WriteTable(send_scenario)
			net.Send(v)
		end
	end
end

round_system.RoundStart = function()
	local result = hook.Call("BR2_RoundStart")
	if result == true then return end

	game_state = GAMESTATE_ROUND
	round_system.Next_MTF_Spawn = CurTime() + math.random(70,120)
	round_system.AlreadyAnnouncedMTF = false

	if isfunction(round_system.current_scenario.round_start) then round_system.current_scenario.round_start() end
	--BR2_ChangeLightingStyle()

	HandleDiseases()

	net.Start("br_round_start")
	net.Broadcast(v)
end

round_system.PostRoundStart = function()
	local result = hook.Call("BR2_PostRoundStart")

	if result == true then return end

	game_state = GAMESTATE_POSTROUND
	if isfunction(round_system.current_scenario.postround_start) then round_system.current_scenario.postround_start() end

	PrintMessage(HUD_PRINTTALK, "The round is ending in "..GetConVar("br2_time_postround"):GetInt().." seconds")
	--PrintMessage(HUD_PRINTTALK, "BR2_PostRoundStart")
end

MAP_ANIMATED_BUTTONS = {}

round_system.RoundEnded = function()
	MAP_ANIMATED_BUTTONS = {}
	BroadcastLua('br2_blackscreen = CurTime() + 99999')

	local result = hook.Call("BR2_RoundEnded")
	if result == true then
		--TODO: NEW MAP
		return
	end

	game_state = GAMESTATE_ROUND_END
	if isfunction(round_system.current_scenario.round_end) then round_system.current_scenario.round_end() end
end

function Debug_NextRoundStage()
	if br2_round_state_end < CurTime() then
		if game_state == GAMESTATE_NOTSTARTED or game_state == GAMESTATE_ROUND_END then
			game_state = GAMESTATE_PREPARING
			
		elseif game_state == GAMESTATE_PREPARING then
			game_state = GAMESTATE_ROUND
			
		elseif game_state == GAMESTATE_ROUND then
			game_state = GAMESTATE_POSTROUND
			
		elseif game_state == GAMESTATE_POSTROUND then
			game_state = GAMESTATE_ROUND_END
		end
	end
	br2_round_state_end = 0
end

function WinCheck()
	if (CurTime() - br2_round_state_start) > 30 then
		local alive_players = 0
		local last_team  = nil
		local all_same_team = true

		for k,v in pairs(player.GetAll()) do
			if v:Alive() and !v:IsSpectator() and v.br_downed == false then
				alive_players = alive_players + 1
				if last_team == nil then
					last_team = v.br_team
					
				elseif last_team != v.br_team then
					all_same_team = false
				end
			end
		end

		if player.GetCount() == 1 and alive_players > 0 then
			return 0
		end

		if alive_players == 1 then
			return 1
		elseif all_same_team then
			return 2
		end
	end

	return 0
end

br2_round_state_start = 0
local next_round_info_update = 0
function HandleRounds()
	if isnumber(game_state) and isnumber(br2_round_state_end) then
		if next_round_info_update < CurTime() then
			net.Start("br_round_info")
				net.WriteInt(game_state, 8)
				net.WriteInt(br2_round_state_end, 16)
				net.WriteInt(br2_round_state_start, 16)
			net.Broadcast()
			next_round_info_update = CurTime() + 1
		end
	end

	--if game_state == GAMESTATE_ROUND then
	--	round_system.MTF_Check()
	--end

	if game_state == GAMESTATE_NOTSTARTED then
		br2_round_state_end = 0
		print("0 - game started")
	end

	local win_check = WinCheck()
	if !(game_state == GAMESTATE_ROUND and win_check > 0) then
		if br2_round_state_end > CurTime() then return end
	end

	if game_state == GAMESTATE_NOTSTARTED or game_state == GAMESTATE_ROUND_END then
		br2_round_state_end = CurTime() + GetBR2conVar("br2_time_preparing") or 25
		br2_round_state_start = CurTime()
		round_system.PreparingStart()
		print("1 - round preparing")
		
	elseif game_state == GAMESTATE_PREPARING then
		br2_round_state_end = CurTime() + GetBR2conVar("br2_time_round") or 1320
		br2_round_state_start = CurTime()
		round_system.RoundStart()
		print("2 - round started")
		
	elseif game_state == GAMESTATE_ROUND or (win_check > 0 and game_state != GAMESTATE_POSTROUND) then
		br2_round_state_end = CurTime() + GetBR2conVar("br2_time_postround") or 30
		br2_round_state_start = CurTime()
		round_system.PostRoundStart()
		print("3 - round ended, starting postround")
		
	elseif game_state == GAMESTATE_POSTROUND then
		br2_round_state_end = CurTime() + 0.5
		br2_round_state_start = CurTime()
		round_system.RoundEnded()
		print("4 - round limit check")
	end
end
hook.Add("Tick", "BR2_HandleRounds", HandleRounds)

function HandleDiseases()
	if math.random (1,100) > 50 then return end

	local possible_infecteds = {}
	
	for k,v in pairs(player.GetAll()) do
		if v:Alive() and !v:IsSpectator() and v.can_get_infected and math.random(1,4) == 2 then
			table.ForceInsert(possible_infecteds, v)
		end
	end

	if table.Count(possible_infecteds) > 0 then
		local patient_zero = table.Random(possible_infecteds)
		patient_zero.next_iup1 = CurTime() + math.random(20,45)
		patient_zero.br_isInfected = true
		patient_zero.br_asymptomatic = true
		devprint(patient_zero:Nick() .. " is the first infected")
	end
end

print("[Breach2] server/sv_round.lua loaded!")
