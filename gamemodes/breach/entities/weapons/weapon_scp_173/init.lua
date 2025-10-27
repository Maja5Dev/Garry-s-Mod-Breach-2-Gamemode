
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

function SWEP:HorrorSound(ply)
	ply.nextScare = ply.nextScare or 0

	if ply.nextScare < CurTime() then
		local rnd_sound = nil
		local dist = self.Owner:GetPos():Distance(ply:GetPos())

		if dist < 220 then
			rnd_sound = table.Random(BR2_CLOSE_SEEN_SOUNDS)
			ply:SendLua('surface.PlaySound("'..rnd_sound[1]..'")')

		elseif dist < FOG_LEVEL then
			if ply.firstSeen173 then
				rnd_sound = table.Random(BR2_SCP173_FAR_SEEN_SOUNDS)
				ply:SendLua('surface.PlaySound("'..rnd_sound[1]..'")')

			else -- first time seeing 173
				rnd_sound = table.Random(BR2_SCP173_FIRST_SEEN_SOUNDS)
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

					if dist < 110 and target == nil then
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

-- When the player wants to teleport to where they are standing in free roam mode
function SWEP:HandleTeleportFromFreeRoam()
	if self.FreeRoamMode then
		local tr = util.TraceLine({
			start = self.Owner:GetPos(),
			endpos = self.Owner:GetPos() - Vector(0, 0, 5),
			mask = MASK_SOLID_BRUSHONLY -- Only hit world geometry / brushes
		})

		if !self:CanWeMoveTo(self.Owner:GetPos()) or !tr.HitWorld then
			self.Owner:BR2_ShowNotification("Cannot move to that position")
			return
		end

		self.FreeRoamMode = false

		self.Owner:SetWalkSpeed(1)
		self.Owner:SetRunSpeed(1)
		self.Owner:RemoveFlags(FL_DONTTOUCH)
		
		if IsValid(self.Owner.entity173) then
			self.Owner.entity173:SetAngles(Angle(0, self.Owner:EyeAngles().yaw, 0))

			if self.NextTeleportSound < CurTime() then
				self.Owner.entity173:EmitSound("breach2/173sound"..math.random(1,3)..".ogg", 300, 100, 1)
				self.NextTeleportSound  = CurTime() + 2
			end
		end

		net.Start("br_scp173_mode")
			net.WriteBool(self.FreeRoamMode)
		net.Send(self.Owner)
	end
end

-- When the player toggles the free roam mode
function SWEP:HandleMovementModeToggle()
	if !self.FreeRoamMode then
		self.Owner:SetWalkSpeed(300)
		self.Owner:SetRunSpeed(300)
		self.Owner:AddFlags(FL_DONTTOUCH)
		self.FreeRoamMode = true
		self.Owner:SetCustomCollisionCheck(true)
	else
		self.FreeRoamMode = false

		self.Owner:SetWalkSpeed(1)
		self.Owner:SetRunSpeed(1)
		self.Owner:RemoveFlags(FL_DONTTOUCH)

		self.Owner:SetPos(self.Owner.entity173:GetPos())
	end

	net.Start("br_scp173_mode")
		net.WriteBool(self.FreeRoamMode)
	net.Send(self.Owner)
end

SWEP.NextDG = 0
function SWEP:DestroyGlass()
	if self.NextDG > CurTime() then return end
	
	local ent173 = self.Owner:GetNWEntity("entity173")
	if !IsValid(ent173) then return end

	if ent173:CanMove(self:GetPos()) then
		local ourpos = ent173:GetPos()

		local tr = self:ClearTrace({
			start = Vector(ourpos.x, ourpos.y, ourpos.z + 95),
			endpos = Vector(ourpos.x, ourpos.y, ourpos.z + 95) + self.Owner:EyeAngles():Forward() * 130,
			mask = MASK_ALL
		})

		if IsValid(tr.Entity) then
			if tr.Entity:GetClass() == "func_breakable" then
				tr.Entity:TakeDamage(100, self.Owner, self.Owner)
			end
		end

		self.NextDG = CurTime() + 1.5
	else
		self.NextDG = CurTime() + 0.2
	end
end

function SWEP:Check173()
	if self.Owner:Alive() and !self.Owner:IsSpectator() and IsValid(self.Owner.entity173) == false then
		self.Owner:SetPos(table.Random(MAPCONFIG.SPAWNS_SCP_173))
		self.Owner:SetEyeAngles(Angle(0, 90, 0))

		self.Owner.entity173 = ents.Create("breach_173ent")
		self.Owner.entity173:SetPos(self.Owner:GetPos())
		self.Owner.entity173:SetModel(SCP_173_MODEL)
		self.Owner.entity173:SetAngles(self.Owner:GetAngles())
		self.Owner.entity173:SetOwner(self.Owner)
		self.Owner.entity173:SetModelScale(1, 0)
		self.Owner.entity173:SetSolid(SOLID_BBOX)
		self.Owner.entity173:Spawn()
		self.Owner.entity173:SetModel(SCP_173_MODEL)
		self.Owner.entity173:SetNotSolid(false)
		self.Owner:SetNWEntity("entity173", self.Owner.entity173)
		
		/*
		local try_ent = ents.Create("breach_173ent")
		self.Owner.entity173 = try_ent
		self.Owner.entity173:SetCurrentOwner(self.Owner)
		self.Owner.entity173:SetModel(SCP_173_MODEL)
		--self.Owner.entity173:SetPos(self.Owner:GetPos())
		self.Owner.entity173:SetAngles(Angle(0, 90, 0))
		self.Owner.entity173:Spawn()
		self.Owner.entity173:Activate()
		self.Owner:SetNWEntity("entity173", self.Owner.entity173)

		local spawnPos = self.Owner:GetPos()
		local ent = self.Owner.entity173  -- already created

		local mins = ent:OBBMins()
		local bottomOffset = -mins.z            -- distance from origin to bottom
		ent:SetPos(spawnPos + Vector(0,0,bottomOffset + 2))  -- +2 to avoid clipping
		*/
	end
end

function SWEP:Think()
	self:Check173()

	self.Owner:SetNoDraw(true)
	if self.Owner:Alive() and !self.Owner:IsSpectator() and IsValid(self.Owner.entity173) and !self.FreeRoamMode then
		self.Owner.entity173:SetPos(self.Owner:GetPos())
	end

	self:NextThink(CurTime() + 0.3)
end
