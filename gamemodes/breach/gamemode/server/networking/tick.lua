
local br_next_crate_update = 0
local br_crates_info = {}

local function create_net_crate_info()
	br_crates_info = {}
	for i,v in ipairs(MAPCONFIG.BUTTONS_2D.ITEM_CONTAINERS_CRATES.buttons) do
		if !v.locked then
			table.ForceInsert(br_crates_info, i)
		end
	end
end

function BR2NetworkingTick()
	local dev_mode = SafeBoolConVar("br2_debug_dev_mode")

	if br_next_crate_update < CurTime() then
		br_next_crate_update = CurTime() + 1

		create_net_crate_info()

		net.Start("br_send_crate_info")
			net.WriteTable(br_crates_info)
		net.Broadcast()
	end

	--CheckTimedNetVars()
	for k,v in pairs(player.GetAll()) do
		if IsValid(v) and v:Alive() and v:IsSpectator() == false then
			if istable(v.startedReviving) and (CurTime() - v.startedReviving[2]) > 9 then
				v.startedReviving = nil
				v:SetNWBool("br_is_reviving", false)
			end

			if v.br_uses_hunger_system and !dev_mode then
				if v.next_hunger < CurTime() then
					v.next_hunger = CurTime() + math.random(14,30)
					v.br_hunger = v.br_hunger - 1

					/*
					if v.br_hunger < 25 then
						v:SetHealth(v:Health() - 2)
					elseif v.br_hunger < 50 then
						v:SetHealth(v:Health() - 1)
					end
					*/

					if v.br_hunger == 49 then
						v:PrintMessage(HUD_PRINTTALK, "You are getting hungry...")
					elseif v.br_hunger == 24 then
						v:PrintMessage(HUD_PRINTTALK, "You are getting very hungry...")
					end
					if v:Health() < 1 then
						local fdmginfo = DamageInfo()
						fdmginfo:SetDamage(20)
						fdmginfo:SetAttacker(v)
						fdmginfo:SetDamageType(DMG_CLUB)
						v:TakeDamageInfo(fdmginfo)
					end
				end
				if v.next_thirst < CurTime() then
					v.next_thirst = CurTime() + math.random(10,18)
					v.br_thirst = v.br_thirst - 1
					if v.br_thirst < 25 then
						v:SetHealth(v:Health() - 2)
					elseif v.br_thirst < 50 then
						v:SetHealth(v:Health() - 1)
					end
					if v.br_thirst == 49 then
						v:PrintMessage(HUD_PRINTTALK, "You are getting thirsty...")
					elseif v.br_thirst == 24 then
						v:PrintMessage(HUD_PRINTTALK, "You are getting very thirsty...")
					end
					if v:Health() < 1 then
						local fdmginfo = DamageInfo()
						fdmginfo:SetDamage(20)
						fdmginfo:SetAttacker(v)
						fdmginfo:SetDamageType(DMG_ENERGYBEAM)
						v:TakeDamageInfo(fdmginfo)
					end
				end
			end
			if v.next_hunger_update < CurTime() then
				net.Start("br_update_hunger")
					net.WriteInt(v.br_hunger, 16)
					net.WriteInt(v.br_thirst, 16)
				net.Send(v)
				v.next_hunger_update = CurTime() + 1
			end

			v.nextBleed = v.nextBleed or 0
			if v.nextBleed < CurTime() then
				if v.br_isBleeding == true and v.br_downed == false then
					v:TakeDamage(1, v, v)
					if v:Health() < 20 then
						if math.random(1,4) == 3 then
							local fake_damage_info = DamageInfo()
							fake_damage_info:SetAttacker(v)
							fake_damage_info:SetInflictor(v)
							fake_damage_info:SetDamage(4)
							v:SetDowned(fake_damage_info)
						end
					end
					v:BleedEffect()
					v.nextBleed = CurTime() + 4
				end
				net.Start("br_update_bleeding")
					net.WriteBool(v.br_isBleeding)
				net.Send(v)
			end
			v.next_sanity_update = v.next_sanity_update or 0
			if v.next_sanity_update < CurTime() then
				net.Start("br_update_sanity")
				net.WriteInt(v:SanityLevel(), 4)
				net.WriteInt(v.br_sanity, 16)
				net.Send(v)
				v.next_sanity_update = CurTime() + 2
			end
			if v.br_role == "SCP-049" and istable(v.startedReviving) and IsValid(v.startedReviving[1]) then
				local dis = (v.startedReviving[1]:GetPos():Distance(v:GetPos()) > 70) or v:KeyDown(IN_ATTACK) or v:KeyDown(IN_ATTACK2)
				if (v.startedReviving[2] + 8.1) > CurTime() and !dis then
					v.startedReviving[1].nextReviveMove = v.startedReviving[1].nextReviveMove or 0
					if v.startedReviving[1].nextReviveMove < CurTime() then
						local phys_obj = v.startedReviving[1]:GetPhysicsObject()
						phys_obj:SetVelocity(Angle(0, v:EyeAngles().yaw, 0):Forward() * 200)
						local cure_sound = table.Random({
							"weapons/knife/knife_stab.wav",
							"weapons/knife/knife_hit1.wav"
						})
						v.startedReviving[1]:EmitSound(cure_sound, 100, 100, 0.7)
						v.startedReviving[1].nextReviveMove = CurTime() + 1
					end
				else
					v.startedReviving = nil
					v:SetNWBool("br_is_reviving", false)
				end
			end
			if istable(v.startedLockpicking) then
				--print(v.startedLockpicking[2] - CurTime())
				local ent_pos = Vector(0,0,0)
				if IsEntity(v.startedLockpicking[1]) then
					ent_pos = v.startedLockpicking[1]:GetPos()
				else
					ent_pos = v.startedLockpicking[1].pos
				end
				if (ent_pos:Distance(v:GetPos()) > 100) or v:KeyDown(IN_ATTACK) or v:KeyDown(IN_ATTACK2) then
					v.startedLockpicking = nil
					v:SendLua("StopLockpicking()")
					v:StopSound("breach2/lockpick.mp3")
				elseif v.startedLockpicking[2] + 9.1 < CurTime() then
					for k2,v2 in pairs(v.br_special_items) do
						if v2.class == "lockpick" then
							table.RemoveByValue(v.br_special_items, v2)
							if v.startedLockpicking[1] and IsEntity(v.startedLockpicking[1]) then
								v.startedLockpicking[1]:Fire("unlock", "", 0)
								v:PrintMessage(HUD_PRINTTALK, "You picked the lock of this door...")
							else
								v.startedLockpicking[1].locked = false
								v:PrintMessage(HUD_PRINTTALK, "You picked the lock of this crate...")
							end
							v.startedLockpicking = nil
						end
					end
				end
			end
			if v.br_downed == true then
				if v.next_health_update < CurTime() then
					v.next_health_update = CurTime() + 1
					if IsValid(v.Body) then
						if v.Body.RagdollHealth == nil then v.Body.RagdollHealth = 100 end
						v.Body.RagdollHealth = v.Body.RagdollHealth - 1
						if v.br_isInfected then
							v.Body.RagdollHealth = v.Body.RagdollHealth - 1
						end
						--print("v.Body.RagdollHealth: "..v.Body.RagdollHealth.."")
						if v.Body.RagdollHealth < 1 then
							v:Freeze(false)
							v:KillSilent()
							--v:Kill()
						end
						net.Start("br_update_health_state")
							net.WriteInt(v.Body.RagdollHealth, 8)
						net.Send(v)
					end
				end
				if v.next_revive_update < CurTime() then
					v.next_revive_update = CurTime() + 0.2
					for k2,v2 in pairs(player.GetAll()) do
						if v2.startedReviving and IsValid(v.Body) and v2.startedReviving[1] == v.Body and v2.br_role != "SCP-049" then
							local dis = (v.Body:GetPos():Distance(v2:GetPos()) > 70) or v2:KeyDown(IN_ATTACK) or v2:KeyDown(IN_ATTACK2)
							if (v2.startedReviving[2] + 8.1) > CurTime() and !dis then
								if v.Body.nextReviveMove < CurTime() then
									local phys_obj = v.Body:GetPhysicsObject()
									phys_obj:SetVelocity(Vector(0,0,200))
									v.Body.nextReviveMove = CurTime() + 1
								end
								net.Start("br_is_reviving")
									net.WriteFloat(CurTime() - v2.startedReviving[2])
								net.Send(v)
							else
								v2.startedReviving = nil
								v2:SetNWBool("br_is_reviving", false)
							end
						end
					end
				end
				for k2,v2 in pairs(player.GetAll()) do
					if IsValid(v.Body) and v2.startedCheckingPulse != nil and v2.startedCheckingPulse[1] == v.Body then
						local dis1 = (v.Body:GetPos():Distance(v2:GetPos()) > 70) or v2:KeyDown(IN_ATTACK) or v2:KeyDown(IN_ATTACK2)
						local dis2 = (v2.startedCheckingPulse[2] + 4.1) > CurTime()
						if dis1 == true or dis2 == false then
							v2.startedCheckingPulse = nil
						end
					end
				end
			end
		end
	end
end
hook.Add("Tick", "networking_tick", BR2NetworkingTick)

print("[Breach2] server/networking/tick.lua loaded!")
