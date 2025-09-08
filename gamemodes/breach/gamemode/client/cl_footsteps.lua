
function HandleFootstepsCL()
	for k,v in pairs(player.GetAll()) do
		local vel = math.Round(v:GetVelocity():Length())

		if !v:IsSpectator() and v:Alive() and v:GetMoveType() != MOVETYPE_NOCLIP and vel > 25 and v:IsOnGround() and v.br_role != "SCP-173" then
			if v.nextstep == nil then v.nextstep = 0 end
			if v.nextstep > CurTime() then return true end

			local fvel = math.Clamp(1 - (vel / 100) / 3, 0.22, 2)
			v.nextstep = CurTime() + fvel
			
			local tr = util.TraceLine({
				start = v:GetPos(),
				endpos = v:GetPos() + Angle(90,0,0):Forward() * 10000
			})
		
			local volume = 1
			local running = false
			local sound = ""
			volume = volume * ((vel / 100) / 3)
			
			if vel < 80 then
				volume = volume * 0.7

			elseif vel > 150 then
				volume = volume * 1.3
				running = true
			end
			
			local soundLevel = 80
			
			if LocalPlayer():IsInPD() then
				EmitSound("breach2/steps/StepPD"..math.random(1,3)..".mp3", v:GetPos(), v:EntIndex(), CHAN_AUTO, math.Clamp(volume, 0, 1), soundLevel)
				return
			end
			
			if tr.MatType == MAT_DIRT or tr.MatType == MAT_GRASS then
			--if tr.MatType == MAT_GRASS then
				volume = volume * 0.35
				sound = "breach2/steps/StepForest"..math.random(1,3)..".mp3"
			else
				--if v.UsingArmor != nil and string.find(v.UsingArmor, "mtf", 1, true) then
				--	sound = "steps/HeavyStep"..math.random(1,3)..".ogg"
				--else
					if tr.MatType == MAT_METAL then
						if running == true then
							volume = volume * 0.55
							sound = "breach2/steps/RunMetal"..math.random(1,8)..".mp3"
						else
							volume = volume * 0.7
							sound = "breach2/steps/StepMetal"..math.random(1,8)..".mp3"
						end
					else
						if running == true then
							volume = volume * 0.55
							sound = "breach2/steps/Run"..math.random(1,8)..".mp3"
						else
							volume = volume * 0.7
							sound = "breach2/steps/Step"..math.random(1,8)..".mp3"
						end
					end
				--end
			end
			
			local outfit_volume = v:GetOutfit().footstep_volume
			volume = volume * outfit_volume
			EmitSound(sound, v:GetPos(), v:EntIndex(), CHAN_AUTO, math.Clamp(volume, 0, 1), soundLevel)
		end
	end
end

print("[Breach2] client/cl_footsteps.lua loaded!")
