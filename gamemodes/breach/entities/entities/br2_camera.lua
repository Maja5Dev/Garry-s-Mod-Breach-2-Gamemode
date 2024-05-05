AddCSLuaFile()

ENT.PrintName		= "Breach 2 Camera"
ENT.Author		    = "Kanade"
ENT.Type			= "anim"
ENT.Base			= "base_anim"
ENT.Spawnable		= false
ENT.AdminSpawnable	= false
ENT.RenderGroup 	= RENDERGROUP_OPAQUE

function ENT:OnTakeDamage(dmginfo)
	if SERVER then
		self:SetHealth(self:Health() - dmginfo:GetDamage())
		if self:Health() < 1 then
			local effect = EffectData()
			effect:SetStart(self:GetPos())
			effect:SetOrigin(self:GetPos())
			effect:SetScale(200)
			effect:SetRadius(200)
			effect:SetMagnitude(1)
			
			util.Effect("Explosion", effect, true, true)
			util.Effect("HelicopterMegaBomb", effect, true, true)
			print(self, " exploded!")
			print(effect, IsValid(effect))
			for k,v in pairs(player.GetAll()) do
				if v:GetViewEntity() == self then
					v:SetViewEntity(v)
				end
			end
			self:Remove()
		end
	end
end

function ENT:Initialize()
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_NONE)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	self.Entity:SetCollisionGroup(COLLISION_GROUP_NONE)
	if SERVER then
		self.Entity:SetHealth(400)
		self.camera_view_ent = ents.Create("br2_camera_view")
		if IsValid(self.camera_view_ent) then
			self.camera_view_ent:SetModel("models/hunter/blocks/cube025x025x025.mdl")
			self.camera_view_ent:SetPos(self.Entity:GetPos())
			self.camera_view_ent:Spawn()
			self.camera_view_ent:SetParent(self.Entity)
			self.camera_view_ent:SetNoDraw(true)
		end
	end
end

ENT.NextCameraSound = 0
function ENT:Think()
	if CLIENT then
		if self.NextCameraSound < CurTime() then
			self.NextCameraSound = CurTime() + 5.05
			self:EmitSound("breach2/Camera.ogg", 60, 100, 1)
		end
	else
		if IsValid(self.camera_view_ent) then
			local ang = self.Entity:GetAngles() + Angle(18,30,0)
			local pos = self.Entity:GetPos() - (ang:Right() * 20) + (ang:Forward() * 30)
			self.camera_view_ent:SetPos(pos)
			self.camera_view_ent:SetAngles(ang)
		end
	end
end

function ENT:UpdateTransmitState()
	return TRANSMIT_ALWAYS
end
