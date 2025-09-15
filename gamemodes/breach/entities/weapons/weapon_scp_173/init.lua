
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function SWEP:CanWeMoveTo(pos)
	local ent173 = self.Owner.entity173
	if IsValid(ent173) then
		return (ent173:CanMove(pos) and ent173:CanMove(self:GetPos()))
	end
end

SWEP.NextMove = 0
SWEP.NextMoveSound = 1
SWEP.MoveSoundEvery = 3

local horror_sound_path = "breach2/horror/"
br_first_seen_173_sounds = {
	{horror_sound_path.."Horror5.ogg", 3.9},
	{horror_sound_path.."Horror6.ogg", 5.21},
	{horror_sound_path.."Horror8.ogg", 6.4},
}

br_far_seen_sounds = {
	{horror_sound_path.."Horror0.ogg", 7.67},
	{horror_sound_path.."Horror3.ogg", 7.06},
	{horror_sound_path.."Horror4.ogg", 7.1},
	{horror_sound_path.."Horror10.ogg", 6},
	{horror_sound_path.."Horror5.ogg", 3.9},
}

br_close_seen_sounds = {
	{horror_sound_path.."Horror1.ogg", 7.04},
	{horror_sound_path.."Horror2.ogg", 8.56},
	{horror_sound_path.."Horror9.ogg", 3.5},
	{horror_sound_path.."Horror14.ogg", 6.4},
}

function SWEP:HorrorSound(ply)
	ply.nextScare = ply.nextScare or 0

	if ply.nextScare < CurTime() then
		local rnd_sound = nil
		local dist = self.NextPos:Distance(ply:GetPos())

		if dist < 220 then
			rnd_sound = table.Random(br_close_seen_sounds)
			ply:SendLua('surface.PlaySound("'..rnd_sound[1]..'")')

		elseif dist < FOG_LEVEL then
			if ply.firstSeen173 then
				rnd_sound = table.Random(br_far_seen_sounds)
				ply:SendLua('surface.PlaySound("'..rnd_sound[1]..'")')

			else -- first time seeing 173
				rnd_sound = table.Random(br_first_seen_173_sounds)
				ply:SendLua('surface.PlaySound("'..rnd_sound[1]..'")')
				ply.firstSeen173 = true
			end
		end

		--ply:PrintMessage(HUD_PRINTTALK, "scare" .. CurTime() .. "")

		ply.nextScare = CurTime() + rnd_sound[2] + 1
		ply:AddSanity(-2)
		ply:StartCustomScreenEffects({blur1 = 0.2, blur2 = 0.8, blur3 = 0.008}, rnd_sound[2] * 0.5)
	end
end

function SWEP:MoveToNextPos(mv)
	local ent173 = self.Owner.entity173

	if self.NextMove > CurTime() or !IsValid(ent173) or self.NextPos == nil or (ent173:GetPos():Distance(self.NextPos) < 10) then return end

	if self.NextPos != nil and IsValid(self.Owner) then
		if self:CanWeMoveTo(self.NextPos) == true then
			mv:SetOrigin(self.NextPos)

			if self.NextAng != nil then
				ent173:SetAngles(Angle(0, self.Owner:EyeAngles().y, 0))
			end

			if self.NextMoveSound == self.MoveSoundEvery then
				self.Owner:EmitSound("breach2/173sound"..math.random(1,3)..".ogg", 300, 100, 1)
				self.NextMoveSound = 0
			end

			local target = nil

			local all_targets = player.GetAll()
			local all_possible_targets = {}
			
			for k,v in pairs(all_targets) do
				local rnd_target = table.Random(all_targets)
				table.ForceInsert(all_possible_targets, rnd_target)
				table.RemoveByValue(all_targets, rnd_target)
			end

			for k,v in pairs(all_possible_targets) do
				if v != self.Owner and v:IsPlayer() and v:Alive() and v:Team() != TEAM_SCP and !v:IsSpectator() and ent173:IsPlayerVisible(v, self.NextPos) then
					v.nextScare = v.nextScare or 0

					local dist = self.NextPos:Distance(v:GetPos())
					--self.Owner:PrintMessage(HUD_PRINTTALK, v:Nick() .. tostring(dist))

					if dist < 120 and target == nil then
						target = v

					else
						self:HorrorSound(v)
					end
				end
			end

			self.NextMoveSound = self.NextMoveSound + 1

			if target and IsValid(target) then
				mv:SetOrigin(target:GetPos() - target:EyeAngles():Forward() * 15)
				ent173:SetAngles(Angle(0, target:EyeAngles().y, 0))
				target:TakeDamage(5000, self.Owner, self.Entity)
				self.Owner:EmitSound(self.SnapSound, 75, 100, 1)

				self.NextMove = CurTime() + 1

				return true
			end

			self.NextMove = CurTime() + 0.7
			return true
		end
	end

	return false
end

function SWEP:HandleUse()
	/*
	if IsValid(self.Owner.entity173) then
		if self.Owner.entity173:CanMove(self:GetPos()) == false then
			return
		end
	end
	*/

	local tr_front = self:FrontTraceLine()
	if tr_front != nil then
		for k,v in pairs(ents.FindInSphere(tr_front.HitPos, 50)) do
			if v:GetClass() == "func_button" or v:GetClass() == "func_rot_button" then
				if ShouldPlayerUse(self.Owner, v) == true then
					self.Owner.usingBlock = true
					v:Use(self.Owner, self.Owner, USE_TOGGLE, 1)
				end
				return
			end
		end
	end
end

SWEP.NextTeleportSound = 0

function SWEP:HandleTeleport(ply, scp173mode)
	if scp173mode then
		ply:SetWalkSpeed(300)
		ply:SetRunSpeed(300)
	else
		if !self:CanWeMoveTo(ply:GetPos()) then
			--ply:PrintMessage(HUD_PRINTTALK, "Cannot move to this position")
			return
		end

		ply:SetWalkSpeed(1)
		ply:SetRunSpeed(1)
		
		if IsValid(ply.entity173) then
			ply.entity173:SetAngles(Angle(0, ply:EyeAngles().yaw, 0))

			if self.NextTeleportSound < CurTime() then
				ply.entity173:EmitSound("breach2/173sound"..math.random(1,3)..".ogg", 300, 100, 1)
				self.NextTeleportSound  = CurTime() + 2
			end
		end
	end

	self.TeleportingMode = scp173mode
	--print("scp 173's teleporting mode set to ".. tostring(scp173mode))
end