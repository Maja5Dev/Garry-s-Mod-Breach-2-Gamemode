SWEP.Base = "tfa_melee_base"
DEFINE_BASECLASS(SWEP.Base)

SWEP.PrintName 		= "Zombie Hands"
SWEP.Spawnable		= true
SWEP.AdminSpawnable	= true
SWEP.Category 		= "Breach 2"
SWEP.Slot			= 0
SWEP.SlotPos		= 0
SWEP.HoldType 		= "knife"
SWEP.ViewModel 		= "models/cultist/scp/scp_049_2_hands.mdl"
SWEP.WorldModel 	= ""
SWEP.ViewModelFOV 	= 50
SWEP.UseHands 		= true
SWEP.Pickupable 	= false

SWEP.SoundMiss 			= "npc/zombie/claw_miss1.wav"
SWEP.SoundWallHit		= "npc/zombie/claw_strike1.wav"
SWEP.SoundFleshSmall	= "npc/zombie/claw_strike2.wav"
SWEP.SoundFleshLarge	= "npc/zombie/claw_strike3.wav"

/*
SWEP.NextAttack = 0
SWEP.Attacking = false
function SWEP:Think()
    if self.Attacking and self.NextAttack < CurTime() then

    end
end

function SWEP:SecondaryAttack()
	self:SetHoldType("knife")
    if !IsFirstTimePredicted() or self.NextAttack > CurTime() then return end
    
	self.Owner:GetViewModel():SetPlaybackRate(self.Secondary.AnimSpeed)
	self:SendWeaponAnim(ACT_VM_SECONDARYATTACK)
    self.Owner:DoAnimationEvent(ACT_GMOD_GESTURE_RANGE_ZOMBIE)
    
    self.Attacking = true
    self.NextAttack = CurTime() + 2

	self:SetNextPrimaryFire(CurTime() + self.Secondary.AttackDelay)
	self:SetNextSecondaryFire(CurTime() + self.Secondary.AttackDelay)
end
*/


SWEP.InspectPos = Vector(0, 0, 0)
SWEP.InspectAng = Vector(0, 0, 0)

SWEP.Primary.Directional = true
SWEP.Primary.Attacks = {
	{
		["act"] = ACT_VM_PRIMARYATTACK, -- Animation; ACT_VM_THINGY, ideally something unique per-sequence
		["len"] = 50, -- Trace distance
		["dir"] = Vector(15, 0, 0), -- Trace arc cast
		["dmg"] = 20, --Damage
		["dmgtype"] = DMG_CRUSH, --DMG_SLASH,DMG_CRUSH, etc.
		["delay"] = 0.3, --Delay
		["spr"] = false, --Allow attack while sprinting?
		["snd"] = "", -- Sound ID
		["snd_delay"] = 0.22,
		["viewpunch"] = Angle(5, 10, 0), --viewpunch angle
		["end"] = 0.8, --time before next attack
		["hull"] = 10, --Hullsize
		["direction"] = "L", --Swing dir,
		["hitflesh"] = Sound("Weapon_Crowbar.Melee_Hit"),
		["hitworld"] = Sound("Weapon_Crowbar.Melee_Hit"),
		["combotime"] = 0
	},
	{
		["act"] = ACT_VM_PRIMARYATTACK, -- Animation; ACT_VM_THINGY, ideally something unique per-sequence
		["len"] = 50, -- Trace distance
		["dir"] = Vector(-15, 0, 0), -- Trace arc cast
		["dmg"] = 20, --Damage
		["dmgtype"] = DMG_CRUSH, --DMG_SLASH,DMG_CRUSH, etc.
		["delay"] = 0.3, --Delay
		["spr"] = false, --Allow attack while sprinting?
		["snd"] = "", -- Sound ID
		["snd_delay"] = 0.22,
		["viewpunch"] = Angle(5, -10, 0), --viewpunch angle
		["end"] = 0.8, --time before next attack
		["hull"] = 10, --Hullsize
		["direction"] = "R", --Swing dir,
		["hitflesh"] = Sound("Weapon_Crowbar.Melee_Hit"),
		["hitworld"] = Sound("Weapon_Crowbar.Melee_Hit"),
		["combotime"] = 0
	}
}

SWEP.Offset = {
	Pos = {
		Up = 0,
		Right = 0,
		Forward = 0
	},
	Ang = {
		Up = 0,
		Right = 0,
		Forward = 0
	},
	Scale = 1
}

local last_attack = 1

local att = {}
local lvec, ply, targ
lvec = Vector()
function SWEP:PunchAttack()
	if not self:VMIV() then return end
	if CurTime() <= self:GetNextPrimaryFire() then return end
	if not TFA.Enum.ReadyStatus[self:GetStatus()] then return end
	table.Empty(att)
	local founddir = false
	
	if last_attack == 1 then last_attack = 2 else last_attack = 1 end
	local use_attack = last_attack

	local our_anim = "Attack_Quick"
	if use_attack == 2 then our_anim = "Attack_Quick2" end
	--if IsFirstTimePredicted() or SERVER then self:SendViewModelSeq(our_anim) end
	self:SendViewModelSeq(our_anim)
	
	if self.Primary.Directional then
		ply = self:GetOwner()
		lvec.x = 0
		lvec.y = 0

		if ply:KeyDown(IN_MOVERIGHT) then lvec.y = lvec.y - 1 end
		if ply:KeyDown(IN_MOVELEFT) then lvec.y = lvec.y + 1 end
		if ply:KeyDown(IN_FORWARD) or ply:KeyDown(IN_JUMP) then lvec.x = lvec.x + 1 end
		if ply:KeyDown(IN_BACK) or ply:KeyDown(IN_DUCK) then lvec.x = lvec.x - 1 end
		
		lvec.z = 0
		if lvec.y > 0.3 then targ = "L"
		elseif lvec.y < -0.3 then targ = "R"
		elseif lvec.x > 0.5 then targ = "F"
		elseif lvec.x < -0.1 then targ = "B"
		else targ = ""
		end

		for k, v in pairs(self.Primary.Attacks) do
			if (not self:GetSprinting() or v.spr) and v.direction and string.find(v.direction, targ) then
				if string.find(v.direction, targ) then
					founddir = true
				end
				table.insert(att, #att + 1, k)
			end
		end
	end

	if not self.Primary.Directional or #att <= 0 or not founddir then
		for k, v in pairs(self.Primary.Attacks) do
			if (not self:GetSprinting() or v.spr) and v.dmg then
				table.insert(att, #att + 1, k)
			end
		end
	end
	
	if #att <= 0 then return end
	attack = self.Primary.Attacks[use_attack]
	ind = att[use_attack]
	self:PlaySwing(attack.act)
	
	self:SetVP(true)
	self:SetVPPitch(attack.viewpunch.p)
	self:SetVPYaw(attack.viewpunch.y)
	self:SetVPRoll(attack.viewpunch.r)
	self:SetVPTime(CurTime() + attack.snd_delay / self:GetAnimationRate(attack.act))
	self:GetOwner():ViewPunch(-Angle(attack.viewpunch.p / 2, attack.viewpunch.y / 2, attack.viewpunch.r / 2))

	self.up_hat = false
	self:SetStatus(TFA.Enum.STATUS_SHOOTING)
	self:SetMelAttackID(use_attack)
	self:SetStatusEnd(CurTime() + attack.delay / self:GetAnimationRate(attack.act))
	self:SetNextPrimaryFire(CurTime() + attack["end"] / self:GetAnimationRate(attack.act))
	self:GetOwner():SetAnimation(PLAYER_ATTACK1)
	self:SetComboCount(self:GetComboCount() + 1)
	
end

function SWEP:SmackEffect(trace, dmg)
	local vSrc = trace.StartPos
	local bFirstTimePredicted = IsFirstTimePredicted()
	local bHitWater = bit.band(util.PointContents(vSrc), MASK_WATER) ~= 0
	local bEndNotWater = bit.band(util.PointContents(trace.HitPos), MASK_WATER) == 0
	
	local trSplash = bHitWater and bEndNotWater and util.TraceLine({
		start = trace.HitPos,
		endpos = vSrc,
		mask = MASK_WATER
	}) or not (bHitWater or bEndNotWater) and util.TraceLine({
		start = vSrc,
		endpos = trace.HitPos,
		mask = MASK_WATER
	})
	
	if (trSplash and bFirstTimePredicted) then
		local data = EffectData()
		data:SetOrigin(trSplash.HitPos)
		data:SetScale(1)
		if (bit.band(util.PointContents(trSplash.HitPos), CONTENTS_SLIME) ~= 0) then
			data:SetFlags(1)
		end
		util.Effect("watersplash", data)
	end
	
	local dam, force, dt = dmg:GetBaseDamage(), dmg:GetDamageForce(), dmg:GetDamageType()
	dmg:SetDamage(dam)
	dmg:SetDamageForce(force)
end

SWEP.AttackDelay = 0.8
SWEP.NextAttack = 0

SWEP.NextZombieSound = 0

function SWEP:Think()
	if SERVER and self.Owner:KeyDown(IN_ATTACK) then
		if self.PushingMode then
			self:Push()
		end
	end

	if self:GetHoldType() != self.HoldType then
		self:SetHoldType(self.HoldType)
	end

	if SERVER and self.NextZombieSound < CurTime() then
		self.NextZombieSound = CurTime() + 8.89
		self.Owner:StopSound("breach2/scp/049/0492Breath.ogg")
		self.Owner:EmitSound("breach2/scp/049/0492Breath.ogg")
	end
end
 
SWEP.Primary.Automatic = true
function SWEP:PrimaryAttack()
    self:PunchAttack()
end

function SWEP:SecondaryAttack()
end

SWEP.Enabled = true
SWEP.DefaultNVG = {
	contrast = 1.8,
	colour = 1,
	brightness = 0,
	clr_r = 1.1,
	clr_g = 0,
	clr_b = 0,
	add_r = 0.1,
	add_g = 0,
	add_b = 0,
	vignette_alpha = 230,
	draw_nvg = false,
	effect = function(nvg, tab)
		--         Darken, Multiply, SizeX, SizeY, Passes, ColorMultiply, Red, Green, Blue
		--DrawBloom(0,      1,        1,     1,     1,      1,            1,   1,     1)
		DrawSharpen(1.2, 1.2)

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
		render.FogEnd(FOG_LEVEL * 0.7)
		render.FogColor(0, 1, 0)
		render.FogMaxDensity(1)
		render.FogMode(MATERIAL_FOG_LINEAR)
		return true
	end
}
SWEP.NVG = table.Copy(SWEP.DefaultNVG)
