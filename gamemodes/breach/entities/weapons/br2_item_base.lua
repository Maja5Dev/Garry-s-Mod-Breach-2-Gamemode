
SWEP.PrintName 		= "Breach 2 Item base"
SWEP.Author			= "CayonKanade"
SWEP.ViewModel		= ""
SWEP.WorldModel		= ""
SWEP.ViewModelFOV	= 60
SWEP.ViewModelFlip	= false
SWEP.Slot			= 0
SWEP.SlotPos		= 0
SWEP.HoldType		= "normal"
SWEP.DrawAmmo		= false
SWEP.DrawCrosshair	= false

SWEP.Type 			= "Melee"
SWEP.Category		= "Breach 2"
SWEP.clevel			= 0

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Ammo			=  "none"
SWEP.Primary.Automatic		= false

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Ammo			=  "none"
SWEP.Secondary.Automatic	=  false

function SWEP:GetBetterOne()
	return self:GetClass()
end

function SWEP:Deploy()
	self.Owner:DrawViewModel(false)
end

function SWEP:Think()
	if self:GetHoldType() != self.HoldType then
		self:SetHoldType(self.HoldType)
	end
end

function SWEP:PrimaryAttack()
end

function SWEP:SecondaryAttack()
end

function SWEP:Reload()
end

function SWEP:OnRemove()
end

function SWEP:Holster()
	return true
end
