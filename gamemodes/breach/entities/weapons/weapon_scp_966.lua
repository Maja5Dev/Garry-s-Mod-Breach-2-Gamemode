
SWEP.PrintName 		= "Hands"
SWEP.Author			= "Maya"
SWEP.ViewModel		= ""
SWEP.WorldModel		= ""
SWEP.ViewModelFOV	= 60
SWEP.ViewModelFlip	= false
SWEP.Slot			= 0
SWEP.SlotPos		= 0
SWEP.HoldType		= "revolver"
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

SWEP.Sounds966 = {
	{"breach2/scp/966/Echo1.ogg", 6.175},
	{"breach2/scp/966/Echo2.ogg", 8.139},
	{"breach2/scp/966/Echo2.ogg", 7.437},
	{"breach2/scp/966/Idle1.ogg", 2.483},
	{"breach2/scp/966/Idle2.ogg", 6.177},
	{"breach2/scp/966/Idle3.ogg", 7.036},
}

function SWEP:GetBetterOne()
	return nil
end

function SWEP:Deploy()
	self.Owner:DrawViewModel(false)
end

SWEP.Next966Sound = 2
function SWEP:Think()
	if self:GetHoldType() != self.HoldType then
		self:SetHoldType(self.HoldType)
	end
	if self.Next966Sound < CurTime() then
		local rsound = table.Random(self.Sounds966)
		self.Owner:EmitSound(rsound[1], 65, 100, 0.6)
		self.Next966Sound = CurTime() + rsound[2] + 2
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
