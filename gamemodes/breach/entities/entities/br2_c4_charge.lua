AddCSLuaFile()

ENT.Type = "anim"

ENT.PlantDistance 	= 80
ENT.isArmed 		= false
ENT.Activated		= false
ENT.Timer 			= 30
ENT.UsePhysics 		= false

function ENT:Initialize()
	self:SetModel("models/weapons/w_c4_planted.mdl")
	if self.UsePhysics == false then
		self.Entity:SetMoveType(MOVETYPE_NONE)
		self.Entity:SetSolid(SOLID_BBOX)
		self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
	else
		self.Entity:PhysicsInit(SOLID_VPHYSICS)
		self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
		self.Entity:SetSolid(SOLID_VPHYSICS)
		--self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
		local phys = self.Entity:GetPhysicsObject()
		if IsValid(phys) then phys:Wake() end
	end
	if SERVER then
		self:SetUseType(SIMPLE_USE)
		self:SetHealth(255)
	end
end

ENT.nextBeep = 0
function ENT:Think()
	if SERVER then
		if self.Activated then
			if self.nextBeep < CurTime() then
				sound.Play("weapons/c4/c4_beep1.wav", self:GetPos(), 75, 100, 1)
				self.nextBeep = CurTime() + 1
			end
			if self.nextExplode < CurTime() then
				C4BombExplode(self, 500, 200)
				self:Remove()
				return
			end
		end
	end
end

function ENT:OnTakeDamage(dmginfo)
	if SERVER then
		self:SetHealth(self:Health() - dmginfo:GetDamage())
		if self:Health() < 1 then
			C4BombExplode(self, 500, 200)
			self:Remove()
		end
	end
end