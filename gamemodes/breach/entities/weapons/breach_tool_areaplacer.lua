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
SWEP.PrintName		= "Area Placer"
SWEP.Slot			= 4
SWEP.SlotPos		= 4
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

if SWEP.FirstPos == nil then
	SWEP.FirstPos = nil
	SWEP.SecondPos = nil
	SWEP.Mode = 1
	SWEP.NextChange = 0
end

function SWEP:Reload()
	if not IsFirstTimePredicted() then return end
	if self.NextChange > CurTime() then return end
	self.NextChange = CurTime() + 0.25
	
	if self.Mode == 1 then
		self.Mode = 2
		if CLIENT then
			chat.AddText("Mode 2: Cleaning")
			print("Mode 2: Cleaning")
		end
	elseif self.Mode == 2 then
		self.Mode = 3
		if CLIENT then
			chat.AddText("Mode 3: Adding")
			print("Mode 3: Adding")
		end
	elseif self.Mode == 3 then
		self.Mode = 4
		if CLIENT then
			chat.AddText("Mode 4: Moving X")
			print("Mode 4: Moving X")
		end
	elseif self.Mode == 4 then
		self.Mode = 5
		if CLIENT then
			chat.AddText("Mode 5: Moving Y")
			print("Mode 5: Moving Y")
		end
	elseif self.Mode == 5 then
		self.Mode = 6
		if CLIENT then
			chat.AddText("Mode 6: Moving Z")
			print("Mode 6: Moving Z")
		end
	elseif self.Mode == 6 then
		self.Mode = 7
		if CLIENT then
			chat.AddText("Mode 7: SecMoving X")
			print("Mode 7: SecMoving X")
		end
	elseif self.Mode == 7 then
		self.Mode = 8
		if CLIENT then
			chat.AddText("Mode 8: SecMoving Y")
			print("Mode 8: SecMoving Y")
		end
	elseif self.Mode == 8 then
		self.Mode = 9
		if CLIENT then
			chat.AddText("Mode 9: SecMoving Z")
			print("Mode 9: SecMoving Z")
		end
	else
		self.Mode = 1
		if CLIENT then
			chat.AddText("Mode 1: Setup")
			print("Mode 1: Setup")
		end
	end
end

function SWEP:Deploy()
end

function SWEP:Initialize()
	self:SetHoldType(self.HoldType)
end

SWEP.SHOW_ZONES = true
SWEP.SHOW_SUB_AREAS = true

function SWEP:DrawHUD()
	local tr = self.Owner:GetAllEyeTrace()
	if CLIENT then
		if self.SHOW_ZONES == true then
			DebugDrawZones(self.SHOW_SUB_AREAS)
		end
		
		cam.Start3D()
			render.SetColorMaterial()
			
			local tr2 = util.TraceLine({
				start = LocalPlayer():GetPos(),
				endpos = LocalPlayer():GetPos() + Angle(90,0,0):Forward() * 10000
			})
			render.DrawSphere(tr2.HitPos, 1, 30, 30, Color(255, 0, 255, 100))
			
			render.DrawSphere(tr.HitPos, 1, 30, 30, Color(255, 255, 255, 100))
			if self.FirstPos != nil then
				render.DrawSphere(self.FirstPos, 1, 30, 30, Color(0, 255, 0, 255))
				render.DrawSphere(self.FirstPos, 10, 30, 30, Color(0, 255, 0, 10))
			end
			if self.SecondPos != nil then
				render.DrawSphere(self.SecondPos, 1, 30, 30, Color(0, 0, 255, 255))
				render.DrawSphere(self.SecondPos, 10, 30, 30, Color(0, 0, 255, 10))
			end
			if self.FirstPos != nil and self.SecondPos != nil then
				render.DrawBox(Vector(0,0,0), Angle(0,0,0), self.FirstPos, self.SecondPos, Color(200,0,0, 10), true)
			end
		cam.End3D()
	end
end

local clicked_t = false

function SWEP:Think()
	if SERVER then return end

	if input.IsKeyDown(KEY_T) then
		if clicked_t == false then
			clicked_t = true

			if self.SHOW_ZONES == false then
				self.SHOW_ZONES = true
				self.SHOW_SUB_AREAS = true
			else
				self.SHOW_ZONES = false
				self.SHOW_SUB_AREAS = true
			end
		end
	else
		clicked_t = false
	end

	if LocalPlayer():KeyDown(IN_ATTACK) then
		self:PrimaryAttack()
	elseif LocalPlayer():KeyDown(IN_ATTACK2) then
		self:SecondaryAttack()
	end
end

function SWEP:PrimaryAttack()
	if self.NextChange > CurTime() then return end
	self.NextChange = CurTime() + 0.01
	if self.Mode == 1 then
		if not IsFirstTimePredicted() then return end
		local tr = self.Owner:GetAllEyeTrace()
		print(tr.HitPos)
		self.FirstPos = tr.HitPos
		if self.FirstPos != nil and self.SecondPos != nil then
			PrintTable(ents.FindInBox(self.FirstPos, self.SecondPos))
		end
	elseif self.Mode == 2 then
		self.FirstPos = nil
		self.SecondPos = nil
		if CLIENT then chat.AddText("Cleaned") end
	elseif self.Mode == 3 then
		if CLIENT then
			local f = self.FirstPos
			local s = self.SecondPos
			local str = '{"room_", Vector('..math.Round(f.x)..","..math.Round(f.y)..","..math.Round(f.z).."), Vector("..math.Round(s.x)..","..math.Round(s.y)..","..math.Round(s.z)..")},"
			print(str)
			chat.AddText(str)
		end
	elseif self.Mode == 4 then
		self.FirstPos = self.FirstPos - Vector(self.Power,0,0)
	elseif self.Mode == 5 then
		self.FirstPos = self.FirstPos - Vector(0,self.Power,0)
	elseif self.Mode == 6 then
		self.FirstPos = self.FirstPos - Vector(0,0,self.Power)
		
	elseif self.Mode == 7 then
		self.SecondPos = self.SecondPos - Vector(self.Power,0,0)
	elseif self.Mode == 8 then
		self.SecondPos = self.SecondPos - Vector(0,self.Power,0)
	elseif self.Mode == 9 then
		self.SecondPos = self.SecondPos - Vector(0,0,self.Power)
	end
end

function SWEP:SecondaryAttack()
	if self.NextChange > CurTime() then return end
	self.NextChange = CurTime() + 0.01
	if not IsFirstTimePredicted() then return end
	if self.Mode == 1 then
		local tr = self.Owner:GetAllEyeTrace()
		print(tr.HitPos)
		self.SecondPos = tr.HitPos
	elseif self.Mode == 4 then
		self.FirstPos = self.FirstPos + Vector(self.Power,0,0)
	elseif self.Mode == 5 then
		self.FirstPos = self.FirstPos + Vector(0,self.Power,0)
	elseif self.Mode == 6 then
		self.FirstPos = self.FirstPos + Vector(0,0,self.Power)
		
	elseif self.Mode == 7 then
		self.SecondPos = self.SecondPos + Vector(self.Power,0,0)
	elseif self.Mode == 8 then
		self.SecondPos = self.SecondPos + Vector(0,self.Power,0)
	elseif self.Mode == 9 then
		self.SecondPos = self.SecondPos + Vector(0,0,self.Power)
	end
end


