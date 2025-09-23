
function BR2_Update3DFlashlights(ply)
	if IsValid(ply.flashlight3d) then
		ply.flashlight3d:SetPos(ply:EyePos() + ply:EyeAngles():Forward() * 15)
		ply.flashlight3d:SetAngles(ply:EyeAngles())
	end
end
hook.Add("PlayerPostThink", "BR2_Hook_Update3DFlashlights", BR2_Update3DFlashlights)

hook.Add("Tick", "BR2_Misc", function()
	for k,v in pairs(player.GetAll()) do
		-- Spectator
		if v:IsSpectator() then
			local obv_target = v:GetObserverTarget()
			
			if v:GetObserverMode() != OBS_MODE_ROAMING and IsValid(obv_target) and obv_target.Alive != nil then
				if !obv_target:Alive() or (obv_target.IsSpectator and obv_target:IsSpectator()) then
					v:Spectate(OBS_MODE_ROAMING)
				else
					v:SetPos(obv_target:GetPos())
				end
			end

		elseif v:Alive() then
			if isnumber(v.charid) then
				v:SetNWInt("BR_CharID", v.charid)
			end

			-- Check escaping
			if v.canEscape == true and v:IsInEscapeZone() == true then
				v:SetSpectator()

				devprint(v:Nick(), "escaped")

				net.Start("cl_playerescaped")
					net.WriteInt(CurTime() - v.aliveTime, 16)
				net.Send(v)
			end

			if v.viewing895 then
				if v.next895dmg < CurTime() then
					local viewent = v:GetViewEntity()

					if !IsValid(viewent) or viewent:GetClass() != "br2_camera_view" then
						v.viewing895 = false
					end

					--print('895 damage - ' .. v:Nick())
					--v:AddSanity(-1)
					v.next895dmg = CurTime() + 0.5
				end
			end

			/*
			if v.use049sounds == true then
				if v.next049Breath < CurTime() then
					v:EmitSound("breach2/scp/049/0492Breath.ogg", 55, 80, 0.6)
					v.next049Breath = CurTime() + 9
				end
			end
			*/

			-- Closet effects
			if v.is_hiding_in_closet and v.next_hsd < CurTime() then
				v:AddSanity(-1)
				v.next_hsd = CurTime() + 2
			end

			-- Weapons
			local outfit = v:GetOutfit()
			local has_gasmask = false
			local has_hazmat = false

			if outfit != nil and outfit.has_gasmask == true then
				has_gasmask = true
			end

			for _,wep in pairs(v:GetWeapons()) do
				if wep.InfiniteStamina == true then
					v:AddRunStamina(1000)
				end

				if isfunction(wep.GlobalThink) then
					wep:GlobalThink()
				end

				if wep.GasMaskOn == true then
					has_gasmask = true
					has_hazmat = true
					if v.nextBreath < CurTime() then
						--v:SendLua('surface.PlaySound("breach2/D9341/breath'..math.random(0,4)..'gas.ogg")')
						--v.nextBreath = CurTime() + 4
						v:SendLua('surface.PlaySound("breach2/gasmask/gasmask_breathing_'..math.random(1,5)..'.mp3")')
						v.nextBreath = CurTime() + 3
					end
				end

				if wep:GetClass() == "item_c4" then
					if wep.Activated then
						if wep.nextBeep < CurTime() then
							v:EmitSound("weapons/c4/c4_beep1.wav")
							wep.nextBeep = CurTime() + 1
						end

						if wep.nextExplode < CurTime() then
							v:StripWeapon(wep:GetClass())
							v:SendLua('surface.PlaySound("breach2/explosion_near.wav")')
							C4BombExplode(wep, 500, 200, v)
							return
						end
					end
				end

				if isnumber(wep.BatteryLevel) and wep.UsesBattery != false then
					wep.NextBatteryCheck = wep.NextBatteryCheck or 0

					if wep.Enabled and wep.NextBatteryCheck < CurTime() then
						wep.BatteryLevel = wep.BatteryLevel - 1

						if wep.BatteryLevel < 1 then wep.BatteryLevel = 0 end

						wep.NextBatteryCheck = CurTime() + wep.BatterySpeed

						net.Start("br_updatebattery")
							net.WriteInt(wep.BatteryLevel, 8)
							net.WriteString(wep:GetClass())
						net.Send(wep.Owner)
					end
				end
			end

			/* GAS, COUGHING */
			local should_icough = true
			if v:IsInGasZone() and !v.disable_coughing then
				if !has_gasmask then
					if v.NextCough < CurTime() then
						should_icough = false
						v:EmitSound("breach2/D9341/Cough"..math.random(1,3)..".ogg")
						v.NextCough = CurTime() + 2
					end

					if v.nextDamageInGas < CurTime() then
						v:SetHealth(v:Health() - 1)
						if v:Health() < 1 then
							v:Kill()
						end
						v.nextDamageInGas = CurTime() + 0.2
					end
				end
			end

			/* PLAYER INFECTION */
			if v.br_isInfected and !v.br_downed and v.can_get_infected then
				if v.next_iup1 < CurTime() then
					v.next_iup1 = CurTime() + math.random(2,3)
					
					if !has_hazmat then
						v:InfectiousTouch()
					end

					v.br_infection = math.Clamp(v.br_infection + 1, 0, 100)
				end
				if !v.br_asymptomatic and v.next_iup2 < CurTime() then
					if v.br_infection < 10 then
						v.next_iup2 = CurTime() + math.random(15,25)
					elseif v.br_infection < 25 then
						v.next_iup2 = CurTime() + math.random(12,22)
					elseif v.br_infection < 50 then
						v.next_iup2 = CurTime() + math.random(9,19)
					elseif v.br_infection < 75 then
						v.next_iup2 = CurTime() + math.random(6,16)
					else
						v.next_iup2 = CurTime() + math.random(3,13)
					end

					if has_gasmask then
						v:EmitSound("breach2/D9341/Cough"..math.random(1,3).."_gasmask.ogg")
					else
						v:EmitSound("breach2/D9341/Cough"..math.random(1,3)..".ogg")
						if v.br_infection > 15 then
							v:InfectiousCough()
						end
					end
				end
			end
		end
	end
end)

print("[Breach2] server/sv_player_tick.lua loaded!")
