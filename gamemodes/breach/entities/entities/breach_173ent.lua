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
ENT.IsAttacking = false
ENT.CurrentTargets = {}
ENT.Attacks = 0
ENT.SnapSound = Sound("snap.wav")

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

function ENT:AttackPlayer()
	self.Attacks = self.Attacks + 1
	for i,v in ipairs(self.CurrentTargets) do
		if v[1]:IsPlayer() and (v[1]:Alive() == false or v[1]:IsSpectator() or v[1].br_team == TEAM_SCP or self:IsPlayerVisible(v[1], self:GetPos()) == false) then
			table.RemoveByValue(self.CurrentTargets, v)
		else
			self.CurrentTargets[i] = {v[1], v[1]:GetPos():Distance(self:GetPos())}
		end
	end
	if self.CurrentTargets[1] and self.CurrentTargets[1][1]:IsPlayer() then
		local pl = self.CurrentTargets[1][1]
		if self:CanMove(pl:GetPos() - pl:EyeAngles():Forward() * 10) == false then
			return
		end
		self:SetAngles(Angle(0,pl:EyeAngles().y,0))
		self:SetPos(pl:GetPos() - pl:EyeAngles():Forward() * 10)
		pl:TakeDamage(5000, self.Owner, self.Entity)

		pl:EmitSound(self.SnapSound, 75, 100, 1)
		self.Owner:SetPos(self:GetPos())
	else
		self.Attacks = 10
	end
	--PrintTable(self.CurrentTargets)
end

function ENT:IsPlayerLooking(ply)
	return (ply:GetAimVector():Dot((self:GetPos() - ply:GetPos() + Vector(70)):GetNormalized()) > 0.39)
end

function ENT:IsPlayerVisible(ply, fromPos)
	local ent173_ang = self:GetAngles()
	local pl_pos = ply:GetPos()
	local pl_posc = ply:WorldSpaceCenter()
	 
	local traces = {
		{
			start = fromPos,
			endpos = pl_posc,
		},
		{
			start = fromPos,
			endpos = pl_pos,
		},
		{
			start = Vector(fromPos.x,fromPos.y,fromPos.z + 45),
			endpos = Vector(pl_posc.x,pl_posc.y,pl_posc.z + 30),
		},
		{
			start = Vector(fromPos.x,fromPos.y,fromPos.z - 45),
			endpos = Vector(pl_pos.x,pl_pos.y,pl_pos.z + 10),
		},
		{
			start = fromPos + ent173_ang:Right() * 25,
			endpos = pl_posc,
		},
		{
			start = fromPos - ent173_ang:Right() * 25,
			endpos = pl_posc,
		},
	}

	for k,v in pairs(traces) do
		v.filter = {self, self.Owner}
		if util.TraceLine(v).Entity == ply then return true end
	end
	return false
end

function ENT:CanMove(pos)
	local cpos = nil
	if pos == self:GetPos() then
		cpos = self:WorldSpaceCenter()
	else
		cpos = pos
	end
	local timep = CurTime() - self.LastBlink
	if !((timep > 0.08) and (timep < 0.18)) then
		for k,v in pairs(ents.FindInSphere(pos, 1100)) do
			--print("VisibleVec: " .. tostring(v:VisibleVec(pos)))
			if v:IsPlayer() and v:Alive()
			and v:Team() != TEAM_SCP and !v:IsSpectator()
			and self:IsPlayerVisible(v, cpos)
			--and v:VisibleVec(pos)
			and self:IsPlayerLooking(v)
			and v.blinking_enabled then
				v.seen_173 = CurTime() + 10
				--print(v:Nick() .. " is looking - " .. CurTime())
				--self.Owner:PrintMessage(HUD_PRINTCENTER, "CANNOT MOVE " .. tostring(CurTime()))
				return false
			end
		end
	end
	--self.Owner:PrintMessage(HUD_PRINTCENTER, "CANMOVE " .. tostring(CurTime()))
	return true
end

function ENT:StopAttacking()
	self.IsAttacking = false
	self:SetNWBool("IsAttacking", false)
	--self:NextThink(CurTime() + 3)
	--print("attacking has ended")
end

function ENT:TryToMoveTo(pos, ang)
	if self:CanMove(self:GetPos()) == true then
		self:SetPos(pos)
		if ang != nil then
			self:SetAngles(ang)
		end
		--self:EmitSound("173sound"..math.random(1,3)..".ogg", 300,100,1)
	end
end

ENT.LastBlink = 0
ENT.BlinkTime = 0.2

ENT.NextBlinkUpdate = 0

function ENT:Think()
	if SERVER then
		self:NextThink(CurTime() + 0.01)

		if self.NextBlinkUpdate < CurTime() then
			self.NextBlinkUpdate = CurTime() + math.Rand(4.5, 6.5)

			self.LastBlink = CurTime() + 1
			local sstr = 'br_next_blink = ' .. self.LastBlink .. ''
			for k,v in pairs(player.GetAll()) do
				if v:Alive() and !v:IsSpectator() then
					local dist = v:GetPos():Distance(self:GetPos())

					local seen173 = (v.seen_173 or 0) > CurTime()
					if v.blinking_enabled and ((dist < 600) or seen173) then
						--print(v, dist, seen173)
						v:SendLua(sstr)
					end
				end
			end
		end
	else
		self:NextThink(CurTime() + 1000)
	end
end

function ENT:AttackNearbyPlayers()
	self.IsAttacking = false
	self:SetNWBool("IsAttacking", false)
	self.CurrentTargets = {}
	self.Attacks = 0
	self.Tries = 0
	for k,v in pairs(ents.FindInSphere(self:GetPos(), 400)) do
		if v:IsPlayer() and v:Alive() and !v:IsSpectator() and v:Team() != TEAM_SCP and self:IsPlayerVisible(v, self:WorldSpaceCenter()) then
			table.ForceInsert(self.CurrentTargets, {v, 0})
			self.IsAttacking = true
			self:SetNWBool("IsAttacking", true)
		end
	end
	--if self.IsAttacking == true then
	--	self:AttackPlayer()
	--end
end

