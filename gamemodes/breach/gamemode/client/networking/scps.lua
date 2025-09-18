
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

net.Receive("scp_012_seen", function(len)
	scp_012_enabled = true
	scp_012_next = CurTime() + 0.2
	scp_012_pos = net.ReadVector()
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

net.Receive("br_blinking", function(len)
	br_blink_time = net.ReadFloat()
	br_next_blink = CurTime() + br_blink_time
end)

net.Receive("br_scp173_mode", function(len)
	local toggle = net.ReadBool()
	LocalPlayer():GetActiveWeapon():ToggleFreeRoam(toggle)
end)
