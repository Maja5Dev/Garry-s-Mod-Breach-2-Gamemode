
SWEP.PrintName 		= "Hands"
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
SWEP.Pickupable 	= false
SWEP.clevel			= 0

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Ammo			=  "none"
SWEP.Primary.Automatic		= true

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Ammo			=  "none"
SWEP.Secondary.Automatic	=  false

function SWEP:GetBetterOne()
	return nil
end

function SWEP:Deploy()
	self.Owner:DrawViewModel(false)
end

SWEP.Next049Breath = 0
function SWEP:Think()
	if self:GetHoldType() != self.HoldType then
		self:SetHoldType(self.HoldType)
	end
	if self.Next049Breath < CurTime() then
		self.Owner:EmitSound("breach2/scp/049/0492Breath.ogg", 55, 80, 0.6)
		self.Next049Breath = CurTime() + 9
	end
end

SWEP.AttackDelay = 0.8
SWEP.NextAttackW = 0
function SWEP:PrimaryAttack()
	if CLIENT or !IsFirstTimePredicted() or self.NextAttackW > CurTime() then return end
	self.NextAttackW = CurTime() + self.AttackDelay
	local hullsize = 4
	local tr = util.TraceHull({
		start = self.Owner:GetShootPos(),
		endpos = self.Owner:GetShootPos() + (self.Owner:GetAimVector() * 80),
		filter = self.Owner,
		mins = Vector(-hullsize, -hullsize, -hullsize),
		maxs = Vector(hullsize, hullsize, hullsize),
		mask = MASK_SHOT_HULL
	})
	local ent = tr.Entity
	if IsValid(ent) and ent:IsPlayer() and ent:Alive() and !ent:IsSpectator() and ent.br_team != TEAM_SCP then
		ent:TakeDamage(20, self.Owner, self.Owner)
		self.Owner:EmitSound("breach2/scp/966/damage_966.ogg")
		return
	end
	self.Owner:EmitSound("npc/zombie/claw_miss1.wav")
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

SWEP.DefaultNVG = {
	contrast = 2,
	colour = 1,
	brightness = 0,
	clr_r = 0.1,
	clr_g = 1,
	clr_b = 0,
	add_r = 0,
	add_g = 0,
	add_b = 0,
	vignette_alpha = 200,
	draw_nvg = false,
	effect = function(nvg, tab)
		--         Darken, Multiply, SizeX, SizeY, Passes, ColorMultiply, Red, Green, Blue
		--DrawBloom(0,      1,        1,     1,     1,      1,            1,   1,     1)

		tab.contrast = nvg.contrast
		tab.colour = nvg.colour
		tab.brightness = nvg.brightness
		tab.clr_r = nvg.clr_r
		tab.clr_g = nvg.clr_g
		tab.clr_b = nvg.clr_b
		tab.add_r = nvg.add_r
		tab.add_g = nvg.add_g
		tab.add_b = nvg.add_b
		tab.vignette_alpha = nvg.vignette_alpha
	end,
	fog = function()
		render.FogStart(0)
		render.FogEnd(600)
		render.FogColor(0, 1, 0)
		render.FogMaxDensity(1)
		render.FogMode(MATERIAL_FOG_LINEAR)
		return true
	end
}
SWEP.NVG = table.Copy(SWEP.DefaultNVG)
