AddCSLuaFile()

ENT.PrintName		= "SCP-173"
ENT.Author		    = "Kanade"

ENT.Type			= "anim"
ENT.Base			= "base_anim"

--ENT.Type			= "filter"
--ENT.Base			= "base_entity"

ENT.Spawnable		= true
ENT.AdminSpawnable	= true
ENT.RenderGroup = RENDERGROUP_OPAQUE
ENT.Owner = nil

function ENT:SetCurrentOwner(ply)
	self.Owner = ply
	self:SetNWEntity("173Owner", ply)
end

function ENT:GetCurrentOwner()
	return self.Owner
end

function ENT:OnTakeDamage(dmginfo)
	if self.Owner:IsPlayer() == true then
		self.Owner:TakeDamageInfo(dmginfo)
	else
		self:Remove()
	end
end

function ENT:Initialize()
	self.Entity:SetModel(SCP_173_MODEL)
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_FLY)
	self.Entity:SetSolid(SOLID_BBOX)
	self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
end

function ENT:IsPlayerLooking(ply)
    local dirToEnt = (self:WorldSpaceCenter() - ply:EyePos()):GetNormalized()
    local dot = ply:EyeAngles():Forward():Dot(dirToEnt)
    return dot > 0.8 -- ~36° cone
end

function ENT:IsPlayerVisible(ply, fromPos)
    local target = ply:EyePos()
    local filter = { self, self.Owner, ply:GetActiveWeapon() }

    local trace = util.TraceLine({
        start = fromPos,
        endpos = target,
        filter = filter,
		mask = MASK_VISIBLE
    })

    if trace.Entity == ply then return true end

    -- fallback hull check
    trace = util.TraceHull({
        start = fromPos,
        endpos = target,
        mins = Vector(-2, -2, -2),
        maxs = Vector(2, 2, 2),
        filter = filter,
		mask = MASK_VISIBLE
    })

    return trace.Entity == ply
end


ENT.BlinkTime = 0.2

function ENT:Think()
	if SERVER then
		self:NextThink(CurTime() + 0.05)

		-- Check if entity can move
		if not self:CanMove(self:GetPos()) then
			self:SetVelocity(Vector(0,0,0)) -- freeze if being looked at
			return true
		end

		-- Blinking logic
		for k, v in pairs(player.GetAll()) do
			local seen173 = (v.seen_173 or 0) > CurTime()
			local dist = v:GetPos():Distance(self:GetPos())

			if v:Alive()
			and not v:IsSpectator()
			and v.blinking_enabled
			and ((dist < 600) or seen173)
			and v.usedEyeDrops < CurTime()
			and v.nextBlink < CurTime() then
				local next_blink = math.Rand(4.5, 6.5)

				net.Start("br_blinking")
					net.WriteFloat(next_blink)
					net.WriteFloat(v.seen_173 or 0)
				net.Send(v)

				v.nextBlink = CurTime() + next_blink

				self.Owner:GetActiveWeapon():HorrorSound(v)
			end
		end
	else
		self:NextThink(CurTime() + 1000)
	end
end

-- Movement restriction
function ENT:CanMove(pos)
	local cpos = nil
	if pos == self:GetPos() then
		cpos = self:WorldSpaceCenter()
	else
		cpos = pos
	end

	if self.Owner:IsInLowLight() then
		return true
	end

	for k,v in pairs(ents.FindInSphere(pos, 1000)) do
		local timep = CurTime() - (v.nextBlink or 0)

		if not ((timep > 0.08) and (timep < 0.18)) then
			if v:IsPlayer()
			and v:Alive()
			and v:Team() != TEAM_SCP
			and not v:IsSpectator()
			and self:IsPlayerVisible(v, cpos)
			and self:IsPlayerLooking(v)
			and v.blinking_enabled then
				v.seen_173 = CurTime() + 10
				--self.Owner:PrintMessage(HUD_PRINTCENTER, v:Nick() .. " is looking " .. tostring(timep))

				return false -- player is looking, cannot move
			end
		end
	end

	return true -- safe to move
end

function ENT:TryToMoveTo(pos, ang)
	if self:CanMove(self:GetPos()) == true then
		self:SetPos(pos)
		
		if ang != nil then
			self:SetAngles(ang)
		end
	end
end

ENT.BlinkTime = 0.2

function ENT:Think()
	if SERVER then
		self:NextThink(CurTime() + 0.05)

		for k,v in pairs(player.GetAll()) do
			local seen173 = (v.seen_173 or 0) > CurTime()
			local dist = v:GetPos():Distance(self:GetPos())

			if v:Alive() and !v:IsSpectator() and v.blinking_enabled and ((dist < 600) or seen173) and v.usedEyeDrops < CurTime() and v.nextBlink < CurTime() then
				local next_blink = math.Rand(4.5, 6.5)

				net.Start("br_blinking")
					net.WriteFloat(next_blink)
					net.WriteFloat(v.seen_173)
				net.Send(v)

				v.nextBlink = CurTime() + next_blink

				v:AddSanity(-1)
			end
		end
	else
		self:NextThink(CurTime() + 0.2)
		SendLightLevelInfo()
	end
end
