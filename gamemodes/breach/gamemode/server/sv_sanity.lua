
local player_meta = FindMetaTable("Player")

util.AddNetworkString("br_horror_173")
util.AddNetworkString("br_horror_173_end")

net.Receive("br_horror_173", function(len, ply)
	if ply:Alive() and ply:IsSpectator() == false and ply:SanityLevel() < 2 then
		ply:AddSanity(-10)
	end
end)

net.Receive("br_horror_173_end", function(len, ply)
	if ply:Alive() and ply:IsSpectator() == false and ply:SanityLevel() < 2 then
		ply:TakeDamage(10, ply, ply)
	end
end)

local function HandleSanity()
	if SafeBoolConVar("br2_debug_dev_mode") then return end
	for k,v in pairs(player.GetAll()) do
		if v:Alive() and v:IsSpectator() == false and v.br_usesSanity then
			v.nextSanityCheck = v.nextSanityCheck or 0

			if v.nextSanityCheck < CurTime() and game_state == GAMESTATE_ROUND then
				v.nextSanityCheck = CurTime() + SafeIntConVar("br2_sanity_speed")
				--print(v:Nick() .. "'s Sanity: " .. v.br_sanity .. "")
				local zone = v:GetZone()
				local sanity_amount = 0

				if zone != nil and zone.sanity then
					sanity_amount = sanity_amount + zone.sanity
				else
					sanity_amount = sanity_amount - 1
				end

				for _,wep in pairs(v:GetWeapons()) do
					if IsValid(wep) and isLethalWeapon(wep) then
						sanity_amount = sanity_amount + 0.5
					end
				end

				/*
				if IsRoundTimeProgress(0.5) then
					sanity_amount = sanity_amount - 1
				end
				*/

				if v:Health() < 25 then
					sanity_amount = sanity_amount - 1	
				end

				local afk_time = v:AfkTime()
				if afk_time > 45 then
					sanity_amount = sanity_amount - 2
				end

				--v:PrintMessage(HUD_PRINTCENTER, v.br_sanity .. " / " .. sanity_amount)
				v:AddSanity(sanity_amount)
			end

			if v:SanityLevel() < 4 then -- Sanity level 3, 2 or 1, not really insane yet
				v.nextHorrorFootstep = v.nextHorrorFootstep or (CurTime() + math.Rand(1, 7))
				if v.nextHorrorFootstep < CurTime() then
					if v:GetVelocity():Length() < 25 then
						v.nextHorrorFootstep = CurTime() + math.Rand(2, 11)
					else
						v.nextHorrorFootstep = CurTime() + math.Rand(1, 7)
					end
					v:Horror_Footsteps()
				end
			end

			if v:SanityLevel() < 3 then -- Sanity level 2 or 1, on the verge of breaking
				v.nextHorrorBlood = v.nextHorrorBlood or (CurTime() + math.Rand(2, 11))
				if v.nextHorrorBlood < CurTime() then
					v.nextHorrorBlood = CurTime() + math.Rand(2,4)
					v:SendLua('HorrorCL_Blood()')
				end

				local afk_time = v:AfkTime()
				v.nextHorrorDamage = v.nextHorrorDamage or 0
				if v.nextHorrorDamage < CurTime() and afk_time > 60 then
					v.nextHorrorDamage = CurTime() + 3

					if v:Health() < 2 then
						local fdmginfo = DamageInfo()
						fdmginfo:SetDamage(20)
						fdmginfo:SetAttacker(v)
						fdmginfo:SetDamageType(DMG_PARALYZE)
						v:TakeDamageInfo(fdmginfo)
					else
						v:SetHealth(v:Health() - 1)
					end
				end
			end

			if v:SanityLevel() < 2 then -- Sanity level one is insanity
				v.nextHorrorSCPS = v.nextHorrorSCPS or (CurTime() + math.Rand(13, 35))
				if v.nextHorrorSCPS < CurTime() then
					v.nextHorrorSCPS = CurTime() + math.Rand(10,20)
					v:SendLua('HorrorCL_SCPSound()')
				end

				v.nextHorrorInsanityAmbient = v.nextHorrorInsanityAmbient or (CurTime() + math.Rand(12, 40))
				if v.nextHorrorInsanityAmbient < CurTime() then
					v.nextHorrorInsanityAmbient = CurTime() + math.Rand(12, 120)
					v.nextHorrorInsanityAttack = v.nextHorrorInsanityAttack + 16
					v:SendLua('HorrorCL_InsanityAttack()')
				end

				v.nextHorrorInsanityAttack = v.nextHorrorInsanityAttack or (CurTime() + math.Rand(6, 120))
				if v.nextHorrorInsanityAttack < CurTime() then
					v.nextHorrorInsanityAttack = CurTime() + math.Rand(6, 120)
					v.nextHorrorInsanityAmbient = v.nextHorrorInsanityAmbient + 8
					v:SendLua('HorrorCL_InsanityAmbient()')
				end
				
				/*
				v.nextHorrorSCP = v.nextHorrorSCP or (CurTime() + math.random(8,28))
				if v.nextHorrorSCP < CurTime() then
					v.nextHorrorSCP = CurTime() + 30
					v:SendLua('HorrorCL_SCP()')
				end
				*/
			end
		end
	end
end
hook.Add("Tick", "BR2_HandleSanity", HandleSanity)

function player_meta:HorrorDoors()
	if self:Alive() == true and self:IsSpectator() == false then
		local tab_ents = ents.FindInSphere(self:GetPos(), 200)
		local tab = {}

		for k,v in pairs(tab_ents) do
			if v:GetClass() == "func_button" then
				print("e: " .. tostring(v))
				/*
				local tr = util.TraceLine({
					start = self:EyePos(),
					endpos = v:GetPos(),
				})
				if tr.Entity == v then
					table.ForceInsert(tab, v)
				end
				*/
				table.ForceInsert(tab, v)
			end
		end

		if #tab > 0 then
			local button = table.Random(tab)
			if IsValid(button) == true then
				button:Use(self, self, USE_ON, 1)
				net.Start("br_playsound")
					net.WriteString("horror/horror7.ogg")
					net.WriteVector(button:GetPos())
				net.Send(self)
				print("opened?")
			end
		end

		--print("horror_doors")
		--PrintTable(tab)
	end
end

function player_meta:Horror_1()
	for k,v in pairs(ents.FindInSphere(self:GetPos() + Vector(0,0,50), 300)) do
		if v.br_info == nil then
			local ent = NULL
			
			if v:GetClass() == "func_door" and IsValid(v:GetChildren()[1]) and v:GetChildren()[1]:GetModel() == "models/novux/sitegard/prop/br_hcz_door.mdl" then
				ent = v:GetChildren()[1]
			elseif v:GetClass() == "func_button" then
				ent = v
			end
			
			if IsValid(ent) and ((ent.lastUse == nil) or ((CurTime() - ent.lastUse) > 4)) then
				self:SendLua('surface.PlaySound("breach2/horror/Horror7.ogg")')
				--local pos = ent:GetPos()
				--self:SendLua('sound.Play("breach2/horror/Horror7.ogg", Vector('..pos.x..', '..pos.y..', '..pos.z..'), 100, 100, 1)')
				ent:Use(self, self, USE_TOGGLE, 1)
				ent.lastUse = CurTime()
				return
			end
		end
	end
end

function player_meta:Horror_Footsteps()
	local pos = self:GetPos() - ((self:EyeAngles() + Angle(0, math.random(-40, 40), 0)):Forward() * 2000)
	self:SendLua('sound.Play("breach2/steps/Step"..math.random(1,8)..".mp3", Vector('..pos.x..', '..pos.y..', '..pos.z..'), 150, 100, 1)')
end

function player_meta:AddSanity(amount)
	self.br_sanity = math.Clamp(self.br_sanity + math.Round(amount * SafeFloatConVar("br2_sanity_strength")), 0, 100)
end

function player_meta:NiceSanity()
	local s = self.br_sanity
	if s < 16 then
		return "Insane" -- 1
	elseif s < 31 then
		return "On verge of breaking" -- 2
	elseif s < 51 then
		return "Very Anxious" -- 3
	elseif s < 76 then
		return "Stressed" -- 4
	elseif s < 96 then
		return "Sane" -- 5
	else
		return "Fully Sane" -- 6
	end
end

function player_meta:SanityLevel()
	local s = self.br_sanity
	if s < 16 then
		return 1
	elseif s < 31 then
		return 2
	elseif s < 51 then
		return 3
	elseif s < 76 then
		return 4
	elseif s < 96 then
		return 5
	else
		return 6
	end
end

print("[Breach2] server/sv_sanity.lua loaded!")
