
function HorrorCL_Blood()
	if LocalPlayer():IsInPD() then return end

	local tr = util.TraceLine({
		start = LocalPlayer():GetPos() + Vector(0,0,50),
		endpos = Vector(math.random(-10000,10000), math.random(-10000,10000), math.random(-10000,10000)),
		mask = MASK_SOLID
	})

	if tr.Hit then
		util.Decal("Blood", tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal)
		if math.random(1,12) == 7 then
			sound.Play("ambient/creatures/flies"..math.random(1,5)..".wav", tr.HitPos, 100, 100,1)
		end
	end
	/*
	if br2_music_info and br2_music_info.sound != "breach2/music/distance2.wav" then
		--print("start playing sanity music")
		br2_music_info = {
			nextPlay = 0,
			volume = 1,
			length = 20,
			sound = "breach2/music/distance2.wav",
			playUntil = function() return br2_our_sanity < 3 end
		}
	end
	*/
end

function HorrorCL_SCPSound()
	if LocalPlayer():IsInPD() then return end

	local pos = LocalPlayer():GetPos() + Vector(math.random(-400,400), math.random(-400,400), 20)

	local horror_scp_sounds = {
		"breach2/173sound1.ogg",
		"breach2/173sound2.ogg",
		"breach2/173sound3.ogg",
		"breach2/items/keycarduse1.ogg",
		"breach2/items/keycarduse2.ogg",
		"breach2/Button2.ogg",
		"breach2/scp/173/NeckSnap1.ogg",
		"breach2/scp/173/NeckSnap2.ogg",
		"breach2/scp/106/Breathing.ogg",
		"breach2/scp/106/Corrosion1.ogg",
		"breach2/scp/106/Decay0.ogg",
		"breach2/scp/106/Laugh.ogg",
	}
	sound.Play(table.Random(horror_scp_sounds), pos, 100, 100,1)
	
	if IsValid(horror_scp_ent) == false and math.random(1,3) == 2 then
		local eyeang = LocalPlayer():EyeAngles()
		LocalPlayer():SetEyeAngles(Angle(eyeang.pitch, math.random(-179, 179), 0))
	end
end

local insanity_attack_sounds = {
	"breach2/horror/insanityambient.ogg"
}

-- More chill insanity ambient
function HorrorCL_InsanityAmbient()
	if math.random(1,2) == 1 then
		surface.PlaySound("breach2/horror/insanityambient.ogg")
		
	elseif math.random(1,2) == 1 then
		surface.PlaySound("breach2/horror/insane3.ogg")
	end
end

BR_INSANITY_ATTACK = 0
-- More aggressive insanity attack
function HorrorCL_InsanityAttack()
	surface.PlaySound(table.Random(insanity_attack_sounds))
	BR_INSANITY_ATTACK = CurTime() + 12
end

next_horror_breath = 0
function HorrorCL_Breath()
	if LocalPlayer():Alive() and !LocalPlayer():IsSpectator() and next_horror_breath < CurTime()
		and br2_our_sanity < 2 and BR_INSANITY_ATTACK < CurTime() and math.random(1,3) < 3
	then
		surface.PlaySound("breach2/horror/breath.wav")
		next_horror_breath = CurTime() + 5 + math.random(5, 13)
	end
end

function HorrorCL_SCP()
	if true then return end -- TODO: disabled
	if LocalPlayer():IsInPD() then return end
	
	local client = LocalPlayer()
	local ourpos = client:GetPos()

	if IsValid(horror_scp_ent) == false and #br2_lastPositions > 0 then
		local pos = br2_lastPositions[1][1]
		if pos:Distance(ourpos) > 400 then
			horror_scp_ent = ClientsideModel(SCP_173_MODEL)
			horror_scp_ent:SetPos(br2_lastPositions[1][1])
			horror_scp_ent:SetColor(Color(0,0,0,255))
			horror_scp_ent.isEnding = 0
			horror_scp_ent.creationTime = CurTime()
		end
	end
end

function NiceSanity()
	local s = br2_our_sanity
	if s == 1 then
		return "Insane", Color(255, 0, 0, 255)
	elseif s == 2 then
		return "On verge of breaking", Color(255, 100, 0, 255)
	elseif s == 3 then
		return "Very Anxious", Color(255, 150, 0, 255)
	elseif s == 4 then
		return "Stressed", Color(255, 255, 0, 255)
	elseif s == 5 then
		return "Sane", Color(150, 255, 0, 255)
	else
		return "Fully Sane", Color(0, 255, 0, 255)
	end
end

print("[Breach2] client/cl_sanity.lua loaded!")
