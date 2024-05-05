AddCSLuaFile()

if CLIENT then
	SWEP.BounceWeaponIcon = false
end

SWEP.Author			= "Kanade"
SWEP.Contact		= "Steam"

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel 		= "models/weapons/cstrike/c_pist_usp.mdl"
SWEP.WorldModel		= "models/weapons/w_pist_usp.mdl"
SWEP.WorldModel		= ""
SWEP.PrintName		= "Camera Placer"
SWEP.Slot			= 0
SWEP.SlotPos		= 1
SWEP.DrawAmmo		= false
SWEP.DrawCrosshair	= true
SWEP.HoldType		= "revolver"
SWEP.Spawnable		= false
SWEP.AdminSpawnable	= false
SWEP.Base			= "weapon_base"
SWEP.UseHands		= true

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Ammo			=  "none"
SWEP.Primary.Automatic		= false

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Ammo			=  "none"
SWEP.Secondary.Automatic	=  false

SWEP.Power = 1
SWEP.Pickupable = false

if SWEP.TerminalPos == nil then
	SWEP.TerminalPos = nil
	SWEP.Mode = 1
	SWEP.NextChange = 0
end

function SWEP:Reload()
	if SERVER or !IsFirstTimePredicted() or (self.NextChange > CurTime()) then return end
	self.NextChange = CurTime() + 0.25
	
	if self.Mode == 1 then
		self.Mode = 2
		chat.AddText("Mode 2: Adding")
	else
		self.Mode = 1
		chat.AddText("Mode 1: Setup")
	end
end

function SWEP:Initialize()
	self:SetHoldType(self.HoldType)
end

function SWEP:Holster()
	if IsValid(self.GhostCameraEnt) then
		self.GhostCameraEnt:Remove()
	end
	if IsValid(self.CameraEnt) then
		self.CameraEnt:Remove()
	end
	return true
end

function SWEP:DrawHUD()
	if !IsValid(self.GhostCameraEnt) then
		self.GhostCameraEnt = ClientsideModel("models/props/cs_assault/camera.mdl")
	end
	local tr = self.Owner:GetAllEyeTrace()
	self.GhostCameraEnt:SetPos(tr.HitPos)
	self.GhostCameraEnt:SetAngles(tr.HitNormal:Angle() + Angle(0, -90, 0))

	cam.Start3D()
		render.SetColorMaterial()

		for k,v in pairs(MAPCONFIG.CAMERAS) do
			for k2,v2 in pairs(v.cameras) do
				render.DrawSphere(v2.pos, 30, 30, 30, Color(255, 255, 255, 100))
				render.DrawSphere(v2.pos, 600, 30, 30, Color(255, 0, 0, 10))
			end
		end

		local ang = self.GhostCameraEnt:GetAngles() + Angle(0,90,0)
		local pos = self.GhostCameraEnt:GetPos() + (ang:Forward() * 27)
		render.DrawLine(pos, pos + ((ang + Angle(20,-62,0)):Forward() * 100), Color(255, 255, 255), false)
	cam.End3D()
end

function SWEP:PrimaryAttack()
	if SERVER or !IsFirstTimePredicted() or (self.NextChange > CurTime()) then return end
	self.NextChange = CurTime() + 0.01
	
	if self.Mode == 1 then
		if !IsValid(self.CameraEnt) then
			self.CameraEnt = ClientsideModel("models/props/cs_assault/camera.mdl")
		end
		local tr = self.Owner:GetAllEyeTrace()
		self.CameraEnt:SetPos(tr.HitPos)
		self.CameraEnt:SetAngles(tr.HitNormal:Angle() + Angle(0, -90, 0))
	elseif self.Mode == 2 then
		if IsValid(self.CameraEnt) then
			local pos = self.CameraEnt:GetPos()
			local ang = self.CameraEnt:GetAngles()
			print('{name = "xxxxxxxxx", pos = Vector('..math.Round(pos.x)..","..math.Round(pos.y)..","..math.Round(pos.z).."), ang = Angle("..math.Round(ang.x)..","..math.Round(ang.y)..","..math.Round(ang.z)..")},")
		end
	else
		--self.CameraEnt:SetAngles(tr.HitNormal:Angle() + Angle(0, -90, 0))
	end
end

function SWEP:SecondaryAttack()
	if SERVER or !IsFirstTimePredicted() or (self.NextChange > CurTime()) then return end
	self.NextChange = CurTime() + 0.01
	
	if self.Mode == 1 then
		self.TerminalPos = self.Owner:GetAllEyeTrace().HitPos
	elseif self.Mode == 2 then
		local s = self.TerminalPos
		print("Vector("..math.Round(s.x)..","..math.Round(s.y)..","..math.Round(s.z)..")")
	elseif self.Mode == 3 then
		self.TerminalPos = self.TerminalPos + Vector(self.Power,0,0)
	elseif self.Mode == 4 then
		self.TerminalPos = self.TerminalPos + Vector(0,self.Power,0)
	elseif self.Mode == 5 then
		self.TerminalPos = self.TerminalPos + Vector(0,0,self.Power)
	end
end

function SWEP:Deploy()
end
