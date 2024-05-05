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
function SWEP:MoveToNextPos(mv)
	if SERVER then
		local ent173 = self.Owner.entity173

		if self.NextMove > CurTime() or !IsValid(ent173) or self.NextPos == nil or (ent173:GetPos():Distance(self.NextPos) < 10) then return end
		if self.NextPos != nil and IsValid(self.Owner) and IsValid(ent173) then
			local canWeMove = self:CanWeMoveTo(self.NextPos)
			--self.Owner:PrintMessage(HUD_PRINTCENTER, tostring(canWeMove) .. " " .. tostring(CurTime()))
			if canWeMove == true then
				mv:SetOrigin(self.NextPos)
				if self.NextAng != nil then
					ent173:SetAngles(Angle(0, self.Owner:EyeAngles().y, 0))
				end
				if self.NextMoveSound == self.MoveSoundEvery then
					self.Owner:EmitSound("breach2/173sound"..math.random(1,3)..".ogg", 300,100,1)
					self.NextMoveSound = 0
				end

				local target = nil

				local all_targets = ents.FindInSphere(self.NextPos, 250)
				local all_possible_targets = {}
				for k,v in pairs(all_targets) do
					local rnd_target = table.Random(all_targets)
					table.ForceInsert(all_possible_targets, rnd_target)
					table.RemoveByValue(all_targets, rnd_target)
				end

				for k,v in pairs(all_possible_targets) do
					if v != self.Owner and v:IsPlayer() and v:Alive() and v:Team() != TEAM_SCP and !v:IsSpectator() and ent173:IsPlayerVisible(v, self.NextPos) then
						--self.Owner:PrintMessage(HUD_PRINTTALK, v:Nick() .. tostring(dist))
						local dist = self.NextPos:Distance(v:GetPos())
						if v.lastScare == nil then v.lastScare = CurTime() end
						if dist < 75 then
							if target == nil then
								target = v
							else
								v:SendLua('surface.PlaySound("horror/Horror'..math.random(1,2)..'.ogg")')
							end
						elseif v.lastScare < CurTime() then
							if dist < 125 then
								v:SendLua('surface.PlaySound("horror/Horror3.ogg")')
							else
								v:SendLua('surface.PlaySound("horror/Horror0.ogg")')
							end
						end

						v.lastScare = v.lastScare + 4
						--print(v:Nick() .. " - " .. tostring(dist))
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

				self.NextMove = CurTime() + 0.5
				return true
			end
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
			print(v)
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
				ply.entity173:EmitSound("breach2/173sound"..math.random(1,3)..".ogg", 300,100,1)
				self.NextTeleportSound  = CurTime() + 2
			end
		end
	end

	self.TeleportingMode = scp173mode
	--print("scp 173's teleporting mode set to ".. tostring(scp173mode))
end