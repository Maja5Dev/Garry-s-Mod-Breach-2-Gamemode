
BR2_RANDOM_MUSIC = {
	low = {},
	medium = {},
	high = {},
}

function RESET_RANDOM_MUSIC()
	BR2_RANDOM_MUSIC = {
		low = {
			{"breach2/music/random_music_low_1.mp3", 294.08},
			{"breach2/music/random_music_low_2.mp3", 76.77},
			{"breach2/music/random_music_low_3.mp3", 154.02},
			{"breach2/music/random_music_low_4.mp3", 184.63},
			{"breach2/music/random_music_low_5.mp3", 110.59},

			{"breach2/music/random_music_low_6.mp3", 90.2},
			{"breach2/music/random_music_low_7.mp3", 108},
			{"breach2/music/random_music_low_8.mp3", 55},
			{"breach2/music/random_music_low_9.mp3", 167},
			{"breach2/music/random_music_low_10.mp3", 280},
		},
		medium = {
			{"breach2/music/random_music_medium_1.mp3", 172.17},
			{"breach2/music/random_music_medium_2.mp3", 161.68},
			{"breach2/music/random_music_medium_3.mp3", 184.65},
			{"breach2/music/random_music_medium_4.mp3", 73.02},
			{"breach2/music/random_music_medium_5.mp3", 270.01},

			{"breach2/music/random_music_medium_6.mp3", 39},
			{"breach2/music/random_music_medium_7.mp3", 62},
			{"breach2/music/random_music_medium_8.mp3", 300},
			{"breach2/music/random_music_medium_9.mp3", 255},
			{"breach2/music/random_music_medium_10.mp3", 63},
			{"breach2/music/random_music_medium_11.mp3", 250},
		},
		high = {
			{"breach2/music/random_music_high_1.mp3", 67.42},
			{"breach2/music/random_music_high_2.mp3", 239.71},
			{"breach2/music/random_music_high_3.mp3", 144.01},
			{"breach2/music/random_music_high_4.mp3", 144.01},

			{"breach2/music/random_music_high_5.mp3", 105.5},
			{"breach2/music/random_music_high_6.mp3", 264},
			{"breach2/music/random_music_high_7.mp3", 69.0},
			{"breach2/music/random_music_high_8.mp3", 145},
		},
	}

	next_rmusic = nil
end
RESET_RANDOM_MUSIC()



lastzone = nil

last_ambient_sound = 4
our_ambients = {}

local ambient_pos_min = 200
local ambient_pos_max = 800

function PlayFirstSounds(num)
	local first_sounds_table = nil
	if istable(br2_current_scenario.first_sounds_override) then
		first_sounds_table = br2_current_scenario.first_sounds_override
	elseif istable(MAPCONFIG.FirstSounds) == true then
		first_sounds_table = MAPCONFIG.FirstSounds
	end
	if istable(first_sounds_table) == true then
		if istable(first_sounds_table[num]) == true then
			surface.PlaySound(first_sounds_table[num][1])
			if istable(first_sounds_table[num + 1]) == true then
				timer.Create("PlayNextFirstSound", first_sounds_table[num][2], 1, function()
					PlayFirstSounds(num + 1)
				end)
			end
		end
	end
end

function PlayAmbientSound(snd, min, max)
	if min == nil then
		min = ambient_pos_min
	end
	if max == nil then
		max = ambient_pos_max
	end
	local client_pos = LocalPlayer():GetPos()
	local rnd_pos_x = client_pos.x
	if math.random(1,2) == 1 then
		rnd_pos_x = rnd_pos_x + math.random(min,max)
	else
		rnd_pos_x = rnd_pos_x - math.random(min,max)
	end
	local rnd_pos_y = client_pos.y
	if math.random(1,2) == 1 then
		rnd_pos_y = rnd_pos_y + math.random(min,max)
	else
		rnd_pos_y = rnd_pos_y - math.random(min,max)
	end
	local rnd_pos = Vector(rnd_pos_x, rnd_pos_y, client_pos.z)
	sound.Play(snd, rnd_pos, 100, 100, 1)
end

function CheckAmbient()
	if firstsounds_end > CurTime() then return end
	local client = LocalPlayer()
	if #our_ambients > 3 then
		if last_ambient_sound < CurTime() then
			local ambients_to_use = {}
			for k,v in pairs(our_ambients) do
				if v[2] < 1 then
					table.ForceInsert(ambients_to_use, v)
				else
					v[2] = v[2] - 1
				end
			end
			local rnd_ambient = table.Random(ambients_to_use)
			if rnd_ambient != nil then
				for k,v in pairs(our_ambients) do
					if rnd_ambient[1] == v[1] then
						v[2] = v[2] + 2
					end
				end
				--chat.AddText("ambient: " .. rnd_ambient[1])
				PlayAmbientSound(rnd_ambient[1])
				last_ambient_sound = CurTime() + math.random(6,12)
			end
		end
	end
end

/*
CreateClientConVar("br2_music_volume", "1", true, false)

cvars.AddChangeCallback("br2_music_volume", function(convar_name, value_old, value_new)
	
end)
*/

br2_registered_music = {}
br2_last_music = nil
br2_last_music_name = "def_name"
br2_next_music_volume_change = 0
br2_is_music_ending = false

function BR2_RESET_MUSIC_INFO()
	br2_music_info = {
		nextPlay = 0,
		volume = 1,
		length = 0,
		sound = nil,
	}
end
BR2_RESET_MUSIC_INFO()

function BR2_PLAY_MUSIC(file_name)
	local sound
	if !br2_registered_music[file_name] then
		sound = CreateSound(game.GetWorld(), file_name, nil)
		if sound then
			sound:SetSoundLevel(0)
			br2_registered_music[file_name] = {sound, nil}
		end
	else
		sound = br2_registered_music[file_name][1]
	end
	if sound then
		sound:Play()
	end
	--chat.AddText(file_name)
	br2_last_music = sound
	br2_last_music_name = file_name
	return sound
end

-- lua_run_cl music_problem_check()
function music_problem_check()
	print("######################################")
	
	print("/br2_last_music/")
	if br2_last_music != nil then
		print("	" .. tostring(br2_last_music) .. "")
		print("	IsValid:	" .. tostring(IsValid(br2_last_music)) .. "")
		print("	IsPlaying:	" .. tostring(br2_last_music:IsPlaying()) .. "")
		print("	GetVolume:	" .. tostring(br2_last_music:GetVolume()) .. "")
	else
		print("	br2_last_music is nil")
	end
	
	print("")
	print("/br2_last_music_name/")
	print("	" .. tostring(br2_last_music_name) .. "")
	
	print("")
	print("/br2_is_music_ending/")
	print("	" .. tostring(br2_is_music_ending) .. "")
	
	print("")
	print("/br2_music_info/")
	if istable(br2_music_info) then
		print("	nextPlay:	" .. tostring(br2_music_info.nextPlay) .. "")
		print("	nextPlay2:	" .. tostring(CurTime() - br2_music_info.nextPlay) .. "")
		print("	volume:		" .. tostring(br2_music_info.volume) .. "")
		print("	length:		" .. tostring(br2_music_info.length) .. "")
		print("	sound:		" .. tostring(br2_music_info.sound) .. "")
		print("	playUntil:	" .. tostring(br2_music_info.playUntil) .. "")
		if isfunction(br2_music_info.playUntil) then
			print("	playUntil():	" .. tostring(br2_music_info.playUntil()) .. "")
		end
	else
		print("	br2_music_info is nil or is not a table")
	end
end

function BR2_END_MUSIC()
	br2_last_music:ChangeVolume(0, 4)
	br2_is_music_ending = true
	--chat.AddText("ending music")
end

next_one_shot = 36
ALL_ONESHOT_AMBIENTS = {}

function RESET_ONESHOT_AMBIENTS()
	for i=1, 109 do
		table.ForceInsert(ALL_ONESHOT_AMBIENTS, "breach2/oneshots/EN_ONESHOTS_"..i..".ogg")
	end
end
RESET_ONESHOT_AMBIENTS()

local next_rmusic_check = 0
local next_rmusic = nil
local next_rmusic_end = 0

function HandleMusic()
	local client = LocalPlayer()
	if client and client.Alive != nil and !client:IsBot() and round_start then
		if client:Alive() == true and client:IsSpectator() == false then
			local our_music_zone = LocalPlayer():GetMusicZone()
			local get_zone = client:GetZone()

			-- ass23

			/*
			if br2_our_sanity < 3 then
				if br2_music_info.sound != "breach2/music/distance2.wav" then
					br2_music_info = {
						nextPlay = 0,
						volume = 1,
						length = 19.97,
						sound = "breach2/music/distance2.wav",
						playUntil = function() return br2_our_sanity < 3 end
					}
				end
			*/
			if next_rmusic_end > CurTime() then
			elseif our_music_zone != nil and (br2_music_info.sound != our_music_zone.sound or br2_music_info == nil) then
				br2_music_info = {
					nextPlay = 0,
					volume = our_music_zone.volume,
					length = our_music_zone.length,
					sound = our_music_zone.sound,
					playUntil = function()
						local cur_music_zone = LocalPlayer():GetMusicZone()
						return cur_music_zone == our_music_zone
					end
				}
			elseif get_zone != nil and get_zone.music != nil and br2_music_info.sound != get_zone.music.sound then
				br2_music_info = {
					nextPlay = 0,
					volume = get_zone.music.volume,
					length = get_zone.music.length,
					sound = get_zone.music.sound,
					playUntil = function()
						local cur_zone = LocalPlayer():GetZone()
						if cur_zone == nil or cur_zone.music == nil then return false end
						return (cur_zone.music.sound == get_zone.music.sound)
					end
				}
			end
			
			if br2_last_music != nil then
				if br2_last_music:GetVolume() < 0.01 then
					br2_last_music:Stop()
					br2_last_music = nil
					br2_is_music_ending = false
				end
			else
				br2_is_music_ending = false
			end
			
			if br2_last_music != nil and br2_is_music_ending == false and math.Round(br2_last_music:GetVolume(), 1) != math.Round(br2_music_info.volume, 1) and br2_next_music_volume_change < CurTime() then
				--print("adjusting volume")
				br2_last_music:ChangeVolume(br2_music_info.volume, 0)
				br2_next_music_volume_change = CurTime() + 1
			end
			
			if br2_is_music_ending == false and br2_music_info != nil and br2_music_info.sound != nil then
				if br2_last_music != nil and br2_last_music_name != br2_music_info.sound then
					--print("new song")
					BR2_END_MUSIC()
				else
					if (br2_last_music == nil or br2_last_music:IsPlaying() == false) or (br2_music_info.nextPlay < CurTime() and br2_is_music_ending) then
						--print("starting new one")
						BR2_PLAY_MUSIC(br2_music_info.sound)
						br2_music_info.nextPlay = CurTime() + br2_music_info.length
					elseif br2_music_info.nextPlay < CurTime() then
						BR2_END_MUSIC()
					end
					if isfunction(br2_music_info.playUntil) then
						if br2_music_info.playUntil() == false then
							BR2_END_MUSIC()
							BR2_RESET_MUSIC_INFO()
						end
					end
				end
			end
			
			if istable(lastzone) and lastzone.use_general_ambients == true then
				if next_one_shot < CurTime() then
					local rnd_oneshot = table.Random(ALL_ONESHOT_AMBIENTS)
					if rnd_oneshot == nil then
						RESET_ONESHOT_AMBIENTS()
						print("oneshot ambients reset")
						rnd_oneshot = table.Random(ALL_ONESHOT_AMBIENTS)
					end
					--chat.AddText("oneshot: " .. rnd_oneshot)
					PlayAmbientSound(rnd_oneshot)
					table.RemoveByValue(ALL_ONESHOT_AMBIENTS, rnd_oneshot)
					next_one_shot = CurTime() + math.random(5, 10)
				end
			end
			
			--AMBIENTS
			if get_zone != nil then
				CheckAmbient()
				if lastzone != get_zone then
					if lastzone != nil then
						if lastzone.name != get_zone.name then
							--chat.AddText(color_white, "In new zone: " .. get_zone.name)
							--if get_zone[5] != lastzone[5] then						
							--	RemoveSounds()
							--end
						end
					end
					lastzone = get_zone
					if istable(lastzone.ambients) == true then
						our_ambients = {}
						for k,v in pairs(lastzone.ambients) do
							table.ForceInsert(our_ambients, {v, 0})
						end
						--print("[Ambient] Adding zone ambient sounds")
						if lastzone.use_general_ambients == true then
							if istable(MAPCONFIG.GeneralAmbientSounds) == true then
								for k,v in pairs(MAPCONFIG.GeneralAmbientSounds) do
									table.ForceInsert(our_ambients, {v, 0})
								end
								--print("[Ambient] Adding general ambient sounds")
							end
						end
					end
					--print("zone update")
				end
				--CheckAmbient()
			end
			--CheckSounds()
		--else
			--RemoveSounds()
		end
	end
end
hook.Add("Tick", "BR2_HandleMusic", HandleMusic)

print("[Breach2] client/cl_music.lua loaded!")