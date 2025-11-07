AddCSLuaFile()

if CLIENT then
	SWEP.BounceWeaponIcon = false
end

SWEP.Author			= "Maya"
SWEP.Contact		= "Steam"

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel 		= "models/weapons/cstrike/c_pist_usp.mdl"
SWEP.WorldModel		= "models/weapons/w_pist_usp.mdl"
SWEP.WorldModel		= ""
SWEP.PrintName		= "Button Placer"
SWEP.Slot			= 8
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
		chat.AddText("Mode 2: Moving X")
		
	elseif self.Mode == 2 then
		self.Mode = 3
		chat.AddText("Mode 3: Moving Y")
		
	elseif self.Mode == 3 then
		self.Mode = 4
		chat.AddText("Mode 4: Moving Z")
		
	else
		self.Mode = 1
		chat.AddText("Mode 1: Setup")
	end
end

local clicked_t = false

if CLIENT then
	function SWEP:Think()
		if input.IsKeyDown(KEY_T) then
			if clicked_t == false then
				clicked_t = true
				self.Mode = 1
				chat.AddText("Mode 1: Setup")
			end
		else
			clicked_t = false
		end
	end
else
	function SWEP:Think()
	end
end

function SWEP:Initialize()
	self:SetHoldType(self.HoldType)
end

function SWEP:DrawHUD()
	local tr = self.Owner:GetAllEyeTrace()

	cam.Start3D()
		render.SetColorMaterial()
		render.DrawSphere(tr.HitPos, 1, 30, 30, Color(255, 255, 255, 100))
		if self.TerminalPos != nil then
			render.DrawSphere(self.TerminalPos, 1, 30, 30, Color(0, 255, 0, 255))
		end
	cam.End3D()

	/*
	
	local show_terminals = false
	local show_only_outfitters = false
	local show_names = false

	if show_terminals then
		cam.Start3D()
			render.SetColorMaterial()
			render.DrawSphere(tr.HitPos, 1, 30, 30, Color(255, 255, 255, 100))
			if self.TerminalPos != nil then
				render.DrawSphere(self.TerminalPos, 1, 30, 30, Color(0, 255, 0, 255))
			end
			if !show_only_outfitters then
				for k,v in pairs(MAPCONFIG.BUTTONS_2D.ITEM_CONTAINERS.buttons) do
					render.DrawSphere(v.pos, 5, 30, 30, Color(255, 0, 0, 255))
				end
			end
			for k,v in pairs(MAPCONFIG.BUTTONS_2D.OUTFITTERS.buttons) do
				render.DrawSphere(v.pos, 10, 30, 30, Color(0, 255, 0, 255))
			end
		cam.End3D()
		if show_names then
			for k,v in pairs(MAPCONFIG.BUTTONS_2D.ITEM_CONTAINERS.buttons) do
				local pos = v.pos:ToScreen()
				draw.Text({
					text = v.item_gen_group,
					font = "BR_Righteous",
					xalign = TEXT_ALIGN_CENTER,
					yalign = TEXT_ALIGN_CENTER,
					pos = {pos.x, pos.y},
				})
			end
		end
	else
		cam.Start3D()
			render.SetColorMaterial()
			render.DrawSphere(tr.HitPos, 1, 30, 30, Color(255, 255, 255, 100))
			if self.TerminalPos != nil then
				render.DrawSphere(self.TerminalPos, 1, 30, 30, Color(0, 255, 0, 255))
			end
			for k,v in pairs(MAPCONFIG.BUTTONS_2D.TERMINALS.buttons) do
				render.DrawSphere(v.pos, 10, 30, 30, Color(255, 0, 0, 255))
			end
		cam.End3D()
	end
	*/
end

function SWEP:PrimaryAttack()
	if SERVER or !IsFirstTimePredicted() or (self.NextChange > CurTime()) then return end
	self.NextChange = CurTime() + 0.01
	
	if self.Mode == 1 then
		self.TerminalPos = self.Owner:GetAllEyeTrace().HitPos
	elseif self.Mode == 2 then
		self.TerminalPos = self.TerminalPos - Vector(self.Power,0,0)
	elseif self.Mode == 3 then
		self.TerminalPos = self.TerminalPos - Vector(0,self.Power,0)
	elseif self.Mode == 4 then
		self.TerminalPos = self.TerminalPos - Vector(0,0,self.Power)
	end
end

function SWEP:SecondaryAttack()
	if SERVER or !IsFirstTimePredicted() or (self.NextChange > CurTime()) then return end
	self.NextChange = CurTime() + 0.01
	
	if self.Mode == 1 then
		local s = self.TerminalPos
		local s2 = "Vector("..math.Round(s.x)..","..math.Round(s.y)..","..math.Round(s.z)..")"
		print(s2)
		chat.AddText(s2)
	elseif self.Mode == 2 then
		self.TerminalPos = self.TerminalPos + Vector(self.Power,0,0)
	elseif self.Mode == 3 then
		self.TerminalPos = self.TerminalPos + Vector(0,self.Power,0)
	elseif self.Mode == 4 then
		self.TerminalPos = self.TerminalPos + Vector(0,0,self.Power)
	end
end

function SWEP:Deploy()
end
