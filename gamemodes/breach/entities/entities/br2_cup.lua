AddCSLuaFile()

ENT.PrintName		= "Cup"
ENT.Author		    = "Kanade"
ENT.Type			= "anim"
ENT.Base			= "base_anim"
ENT.Spawnable		= false
ENT.AdminSpawnable	= false
ENT.RenderGroup 	= RENDERGROUP_OPAQUE

function ENT:Initialize()
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_NONE)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	self.Entity:SetCollisionGroup(COLLISION_GROUP_NONE)
	self.Entity:SetModel("models/mishka/models/plastic_cup.mdl")
end
