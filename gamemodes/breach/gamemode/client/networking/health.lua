
net.Receive("br_end_reviving", function(len)
	local is_alive = net.ReadBool()
	if is_alive == false then
		last_body.Pulse = true
	end
end)

net.Receive("br_is_reviving", function(len)
	last_revive_check = CurTime()
	last_revive_time = net.ReadFloat()
end)

net.Receive("br_end_checking_pulse", function(len)
	local isAlive = net.ReadBool()
	local isValidPlayerCorpse = net.ReadBool()

	last_body.isValidPlayerCorpse = isValidPlayerCorpse
	
	if isAlive == true and isValidPlayerCorpse then
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
	surface.PlaySound("breach2/player/player_breathing_knockout01.wav")
	surface.PlaySound("breach2/D9341/Damage1.ogg")
	next_blood_sound = CurTime() + 4
end) 

local next_blood_sound = 0
net.Receive("br_update_health_state", function(len)
	body_health = net.ReadInt(8)
	last_health_check = CurTime()

	if next_blood_sound < CurTime() then
		next_blood_sound = CurTime() + 4
	end
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
end)
