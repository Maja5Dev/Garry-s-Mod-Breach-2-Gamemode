
local player_meta = FindMetaTable("Player")

function player_meta:PlayerSetSpeeds(slow_walkking, walking, running)
	self.speed_slow_walking = slow_walkking
	self.speed_walking = walking
	self.speed_running = running
	self:SetWalkSpeed(walking)
	self:SetRunSpeed(running)
end

local next_speed_handling = 0
function HandlePlayerSpeeds()
	if next_speed_handling > CurTime() then return end
	for k,v in pairs(player.GetAll()) do
		if v:Alive() and v:IsSpectator() == false and v:IsFrozen() == false and v.br_downed == false then
			local new_walk_speed = v.speed_walking
			local new_run_speed = v.speed_running
			local new_jump_power = v.DefaultJumpPower
			
			--print("")
			--print(new_walk_speed, new_run_speed, new_jump_power)
			
			if v.br_isBleeding == true then
				new_walk_speed = new_walk_speed * 0.9
				new_run_speed = new_run_speed * 0.9
			end

			if v.br_usesSanity and v.br_sanity < 20 then
				new_walk_speed = new_walk_speed * 1.05
				new_run_speed = new_run_speed * 1.05
			end

			local outfit = v:GetOutfit()
			if outfit.disable_movement or v.is_hiding_in_closet then
				v:SetWalkSpeed(1)
				v:SetRunSpeed(1)
				v:SetJumpPower(1)
				return
			end
			new_walk_speed = new_walk_speed * outfit.walk_speed
			new_run_speed = new_run_speed * outfit.run_speed
			new_jump_power = new_jump_power * outfit.jump_power
			
			if v.br_speed_boost > CurTime() then
				new_walk_speed = new_walk_speed * 1.15
				new_run_speed = new_run_speed * 1.15
				v:AddRunStamina(100)
				--print(v:Nick(), v.br_run_stamina)

			elseif v.br_used_syringe == true then
				v.br_used_syringe = false
				--v.CrippledStamina = CurTime()
				v:AddRunStamina(-1500)
				v:AddJumpStamina(-200)
				v:SetFOV(DEF_FOV, 1)
				v:SendLua('surface.PlaySound("breach2/D9341/breath0.ogg")')
			end

			if v.br_sanity < 10 then
				new_run_speed = new_run_speed * 1.1
				v:AddRunStamina(5)
			end

			-- do not include in if v.br_usesStamina then
			v.nextJumpChange = v.nextJumpChange or 0
			if v.br_jump_stamina then
				if v.nextJumpChange > CurTime() then
					new_jump_power = 0
				else
					if v.br_jump_stamina < 20 then
						v.nextJumpChange = CurTime() + 3
					end
				end
			end

			if v.br_role == ROLE_SCP_049_2 then
				new_run_speed = new_run_speed * 0.85
			end
			
			if v.br_usesStamina then
				v.nextNormalRun = v.nextNormalRun or 0
				v.CrippledStamina = v.CrippledStamina or 0

				if v.br_run_stamina and v.speed_walking and v.speed_running and v.br_jump_stamina then
					if v.nextNormalRun > CurTime() then
						if v.nextBreath < CurTime() then
							if v.CrippledStamina + 2 < CurTime() then
								v:SendLua('surface.PlaySound("breach2/D9341/breath0.ogg")')
								v:SendLua('RunConsoleCommand("-speed")')
							end
							v.nextBreath = CurTime() + 6
						end
						new_run_speed = new_walk_speed
						
					elseif v.br_run_stamina < 50 then
						v.nextNormalRun = CurTime() + 4
					end
				end
			end

			if v.br_uses_hunger_system then
				if v.br_hunger < 25 then
					new_walk_speed = new_walk_speed * 0.8
					new_run_speed = new_run_speed * 0.55
					new_jump_power = new_jump_power * 0.7
				elseif v.br_hunger < 50 then
					new_walk_speed = new_walk_speed * 0.85
					new_run_speed = new_run_speed * 0.7
					new_jump_power = new_jump_power * 0.8
				elseif v.br_hunger < 75 then
					new_walk_speed = new_walk_speed * 0.95
					new_run_speed = new_run_speed * 0.85
					new_jump_power = new_jump_power * 0.9
				end
			end

			if !v.br_asymptomatic then
				if v.br_infection > 70 then
					new_walk_speed = new_walk_speed * 0.85
					new_run_speed = new_run_speed * 0.85
					new_jump_power = new_jump_power * 0.85
				elseif v.br_infection > 45 then
					new_walk_speed = new_walk_speed * 0.92
					new_run_speed = new_run_speed * 0.92
					new_jump_power = new_jump_power * 0.92
				end
			end
			
			if game_state == GAMESTATE_PREPARING then
				new_walk_speed = 2
				new_run_speed = 2
				new_jump_power = 2
			end

			new_walk_speed = math.floor(new_walk_speed)
			new_run_speed = math.floor(new_run_speed)
			new_jump_power = math.floor(new_jump_power)

			if new_run_speed < new_walk_speed then
				new_run_speed = new_walk_speed
			end

			--v:PrintMessage(HUD_PRINTCENTER, new_walk_speed .. "    " .. new_run_speed .. "    " .. new_jump_power)

			v:SetWalkSpeed(new_walk_speed)
			v:SetRunSpeed(new_run_speed)
			v:SetJumpPower(new_jump_power)
		end
	end
	next_speed_handling = CurTime() + 0.1
end
hook.Add("Tick", "BR2_PlayerSpeeds", HandlePlayerSpeeds)

print("[Breach2] server/sv_player_speeds.lua loaded!")
