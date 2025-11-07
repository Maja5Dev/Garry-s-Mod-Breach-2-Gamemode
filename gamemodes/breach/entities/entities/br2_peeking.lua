AddCSLuaFile()

ENT.PrintName		= "Breach 2 Peeking"
ENT.Author		    = "Maya"
ENT.Type			= "anim"
ENT.Base			= "base_anim"
ENT.Spawnable		= false
ENT.AdminSpawnable	= false
ENT.RenderGroup 	= RENDERGROUP_OPAQUE

function ENT:Initialize()
	self.Entity:PhysicsInit(SOLID_NONE)
	self.Entity:SetMoveType(MOVETYPE_NONE)
	self.Entity:SetSolid(SOLID_NONE)
	self.Entity:SetCollisionGroup(COLLISION_GROUP_NONE)
end

function ENT:UpdateTransmitState()
	return TRANSMIT_ALWAYS
end
