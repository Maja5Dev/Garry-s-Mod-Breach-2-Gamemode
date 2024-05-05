local blurScreen = Material("pp/blurscreen")

local EMeta = FindMetaTable( "Entity" )

local WMeta = FindMetaTable( "Weapon" )



function WMeta:PlaySequence( seq_id, idle )



  if ( !idle ) then



    self.IdlePlaying = false



  end



  if ( !( self && self:IsValid() ) || !( self.Owner && self.Owner:IsValid() ) ) then return end



	local vm = self.Owner:GetViewModel()



  if ( !( vm && vm:IsValid() ) ) then return end



	if ( isstring( seq_id ) ) then



		seq_id = vm:LookupSequence( seq_id )



	end



  vm:SetCycle( 0 )

  vm:SetPlaybackRate( 1.0 )

	vm:SendViewModelMatchingSequence( seq_id )



end
















-- lua/weapons/weapon_flashlight.lua
-- Retrieved by https://github.com/lewez/glua-steal
SWEP.Spawnable = true
SWEP.UseHands = true
SWEP.AdminSpawnable = true

if CLIENT then
	SWEP.WepSelectIcon 	= surface.GetTextureID("vgui/entities/flash_light")
	SWEP.BounceWeaponIcon = false
end

SWEP.PrintName = "Фонарик"

SWEP.ViewModel			= "models/weapons/tfa_nmrih/v_item_maglite.mdl" --Viewmodel path
SWEP.ViewModelFOV = 50
//SWEP.RenderGroup = RENDERGROUP_BOTH

SWEP.WorldModel			= "models/weapons/w_flashlight_new12.mdl" --Viewmodel path
SWEP.HoldType = "slam"
SWEP.DefaultHoldType = "slam"
SWEP.Offset = { --Procedural world model animation, defaulted for CS:S purposes.
        Pos = {
        Up = -0.5,
        Right = 2,
        Forward = 5.5,
        },
        Ang = {
        Up = -1,
        Right = 5,
        Forward = 178
        },
		Scale = 1.2
}

SWEP.Primary.Sound = Sound("Weapon_Melee.CrowbarLight")
SWEP.Secondary.Sound = Sound("Weapon_Melee.CrowbarHeavy")

SWEP.MoveSpeed = 1.0
SWEP.IronSightsMoveSpeed  = SWEP.MoveSpeed

SWEP.InspectPos = Vector(8.418, 0, 15.241)
SWEP.InspectAng = Vector(-9.146, 9.145, 17.709)

SWEP.Primary.Blunt = true
SWEP.Primary.Damage = 25
SWEP.droppable				= true
SWEP.Primary.Reach = 40
SWEP.Primary.RPM = 90
SWEP.Primary.SoundDelay = 0
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.ClipSize	= -1
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.ClipSize	= 0
SWEP.Primary.Delay = 0.3
SWEP.Primary.Window = 0.2
SWEP.Primary.Automatic = false

SWEP.MoveSpeed = 1
SWEP.AllowViewAttachment = false

local matLight = Material( "sprites/light_ignorez" )
function SWEP:Initialize()
    self:SetHoldType( "slam" )
end
function SWEP:PrimaryAttack()
	if CLIENT then return end
	if !IsValid(self) || !IsValid(self.Owner) || !self.Owner:GetActiveWeapon() || self.Owner:GetActiveWeapon() != self then return end

	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
	self.Owner:EmitSound("slashers/effects/flashlight_toggle.wav", 75, 100, 0.6)

	if !IsValid(self.projectedLight) then
		self:BuildLight()
		return
	end

	self.Active = !self.Active
	if self.Active then
		self.projectedLight:Fire("TurnOn")
	else
		self.projectedLight:Fire("TurnOff")
	end
end

function SWEP:Reload()

end

function SWEP:PrimarySlash()

end

function SWEP:Holster()
	SafeRemoveEntity(self.projectedLight)
	self.Owner:SetNWEntity("FL_Flashlight", nil)
	self.Active = false

	return true
end

function SWEP:BuildLight()
	if CLIENT then return end
	if !IsValid(self) || !IsValid(self.Owner) || !self.Owner:GetActiveWeapon() || self.Owner:GetActiveWeapon() != self then return end

	self.projectedLight = ents.Create( "env_projectedtexture" )
	self.projectedLight:SetLagCompensated(true)
	self.projectedLight:SetPos( self.Owner:EyePos() )
	self.projectedLight:SetAngles( self.Owner:EyeAngles() )
	self.projectedLight:SetKeyValue( "enableshadows", 0 )
	self.projectedLight:SetKeyValue( "farz", 300 )
	self.projectedLight:SetKeyValue( "lightworld", 1 )
	self.projectedLight:SetKeyValue( "nearz", 1 )
	self.projectedLight:SetKeyValue( "lightfov", 100 )
	self.projectedLight:SetKeyValue( "lightcolor", "255 255 255 255" )
	self.projectedLight:Spawn()
    self.projectedLight:Input( "SpotlightTexture", NULL, NULL, "effects/flashlight001" )

	self.Owner:SetNWEntity("FL_Flashlight", self.projectedLight)

	self.Active = true
end

function SWEP:Think()
	if SERVER && IsValid(self.projectedLight) then
		self.projectedLight:SetPos( self.Owner:EyePos() + self.Owner:GetAimVector() * 20 );
		self.projectedLight:SetAngles( self.Owner:EyeAngles() );
		--print("wow")
	end
	if self.Owner:GetNWBool("IsInsideLocker") == true then  -- Фикс шкафчика
	    SafeRemoveEntity(self.projectedLight)
	    self.Owner:SetNWEntity("FL_Flashlight", nil)
		--print("Deactivated")
	    self.Active = false
		
	end
end

--[[
hook.Add("PlayerDeath", "TurnOffFlashlight", function() 
    if victim:GetActiveWeapon():GetClass() == "weapon_flashlight" then 
    victim:SetNWEntity("FL_Flashlight", false)
	
	end
end)]]
function SWEP:OnDrop() 
    self.Owner:SetNWEntity("FL_Flashlight", false)
	self.Active = false
    SafeRemoveEntity(self.projectedLight)
	return true
end

local function UpdateFlashlight()
	local pjs = LocalPlayer():GetNWEntity("FL_Flashlight")
	if IsValid( pjs ) then
		if IsValid(LocalPlayer():GetActiveWeapon()) and LocalPlayer():GetActiveWeapon():GetClass() == "weapon_flashlight" then
			local bid = LocalPlayer():GetViewModel():LookupAttachment( "Light" )
			local bp, ba = LocalPlayer():GetViewModel():GetBonePosition( bid )
			ba:RotateAroundAxis(ba:Up(), -90)
			pjs:SetPos( bp +ba:Forward() * -3.5 );
			pjs:SetAngles( ba );
			pjs:SetParent(LocalPlayer():GetViewModel(), LocalPlayer():GetViewModel():LookupAttachment("light"))
		end
	end
end

function SWEP:CalcViewModelView( ent, oldPos, oldAng, pos, ang )
	local pjs = LocalPlayer():GetNWEntity( 'FL_Flashlight' )
	if IsValid( pjs ) then
		local bid = LocalPlayer():GetViewModel():LookupAttachment("light")
		local bp = LocalPlayer():GetViewModel():GetAttachment(bid)
		local ang = bp.Ang
		local pos = bp.Pos
		--ba:RotateAroundAxis(ba:Up(), -90)
		pjs:SetPos( pos +ang:Forward() * -5 );
		pjs:SetAngles( ang );
	end
end

-- lua/weapons/weapon_flashlight.lua
-- Retrieved by https://github.com/lewez/glua-steal

SWEP.Spawnable = true
SWEP.UseHands = true

if ( CLIENT ) then

	SWEP.WepSelectIcon 	= surface.GetTextureID("vgui/entities/flash_light")
	SWEP.BounceWeaponIcon = false
	SWEP.InvIcon = Material( "nextoren/gui/icons/flashlight.png" )

end

if ( SERVER ) then

  SWEP.HoldType = "slam"

end

SWEP.PrintName = "Flashlight"
SWEP.ViewModel			= "models/cultist/items/flashlight/v_item_maglite.mdl"
SWEP.ViewModelFOV = 50
SWEP.WorldModel			= "models/cultist/items/flashlight/w_item_maglite.mdl"
SWEP.HoldType = "slam"
SWEP.DefaultHoldType = "slam"

SWEP.Pos = Vector( 3, 4, -1)
SWEP.Ang = Angle(0, 0, -25)

function SWEP:CreateWorldModel()

	if ( !self.WModel ) then
  	self.WModel = ClientsideModel(self.WorldModel, RENDERGROUP_OPAQUE)
  	self.WModel:SetNoDraw( true )
  	self.WModel:SetBodygroup(1, 1)
	end

  return self.WModel
end

function SWEP:DrawWorldModel()

	local pl = self:GetOwner()

	if ( pl && pl:IsValid() ) then

		local bone = self.Owner:LookupBone( "ValveBiped.Bip01_R_Hand" )

		if ( !bone ) then return end

	  local pos, ang = self.Owner:GetBonePosition( bone )

		local wm = self:CreateWorldModel()

	  if ( wm && wm:IsValid() ) then

	    ang:RotateAroundAxis(ang:Right(), self.Ang.p)
	    ang:RotateAroundAxis(ang:Forward(), self.Ang.y)
	    ang:RotateAroundAxis(ang:Up(), self.Ang.r)

	    wm:SetRenderOrigin(pos + ang:Right() * self.Pos.x + ang:Forward() * self.Pos.y + ang:Up() * self.Pos.z)
	    wm:SetRenderAngles(ang)
	    wm:DrawModel()

	  end

	else

		self:SetRenderOrigin( nil )
		self:SetRenderAngles( nil )
		self:DrawModel()
		self:SetModelScale( 1.1, 0 )

		if ( self.projectedLight ) then

			self.projectedLight:SetNearZ( 0 )
			self.projectedLight:Update()

		end

	end

end

SWEP.Primary.Blunt = true
SWEP.Primary.Damage = 25
SWEP.droppable				= true
SWEP.Primary.Reach = 40
SWEP.Primary.RPM = 90
SWEP.Primary.SoundDelay = 0
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.ClipSize	= -1
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.ClipSize	= 0
SWEP.Primary.Delay = 0.3
SWEP.Primary.Window = 0.2
SWEP.Primary.Automatic = false

SWEP.AllowViewAttachment = false

local matLight = Material( "sprites/light_ignorez" )

function SWEP:Initialize()

  self:SetHoldType( "slam" )

end

function SWEP:Deploy()

	self.HolsterDelay = nil
	self.b_IdleSequence = nil
	self.IdleDelay = CurTime() + .75
	self:PlaySequence( "DrawOn" )
	self:EmitSound( "weapons/m249/handling/m249_armmovement_02.wav", 75, math.random( 100, 120 ), 1, CHAN_WEAPON )
	self.Active = false

end

local function UpdateFlashlight()

	--[[[local pjs = LocalPlayer():GetNWEntity( "FL_Flashlight" )

	if ( pjs && pjs:IsValid() ) then

		if ( LocalPlayer():GetActiveWeapon() != NULL && LocalPlayer():GetActiveWeapon():GetClass() == "weapon_flashlight" ) then

			local bid = LocalPlayer():GetViewModel():LookupAttachment( "light" )
			local bp, ba = LocalPlayer():GetViewModel():GetBonePosition( bid )

			print( bid, bp, ba )
			pjs:SetPos( bp + ba:Forward() * 2 );
			pjs:SetAngles( ba );
			pjs:SetParent( LocalPlayer():GetViewModel(), LocalPlayer():GetViewModel():LookupAttachment( "light" ) )

		end

	end]]

end

function SWEP:Think()

	--[[if ( SERVER && self.projectedLight && self.projectedLight:IsValid() ) then

		self.projectedLight:SetPos( self.Owner:EyePos() + self.Owner:GetAimVector() * 10 );
		self.projectedLight:SetAngles( self.Owner:EyeAngles() );

	end]]

	if ( CLIENT && self.Active ) then

		if ( !self.att_ViewModel ) then

			self.att_ViewModel = self.Owner:GetViewModel()

		end

		local att = self.att_ViewModel:GetAttachment( 1 )

		if ( att ) then

			self.projectedLight:SetPos( att.Pos )
			self.projectedLight:SetAngles( att.Ang )

		end

		self.projectedLight:Update()

	end

	local speed = self.Owner:GetVelocity():LengthSqr()

	if ( speed > 1000 && speed < 22500 ) then

		self.IdleSequence = "walk"

	elseif ( speed >= 22500 ) then

		self.IdleSequence = "Sprint"

	else

		self.IdleSequence = "Idle"

	end

	if ( ( self.IdleDelay || 0 ) < CurTime() || self.b_IdleSequence && self.IdleSequence != self.Old_IdleSequence ) then

		self.IdleDelay = CurTime() + 2
		self:PlaySequence( self.IdleSequence )

		self.b_IdleSequence = true
		self.Old_IdleSequence = self.IdleSequence

	end

end

function SWEP:PrimaryAttack()

	--if !IsValid(self) || !IsValid(self.Owner) || !self.Owner:GetActiveWeapon() || self.Owner:GetActiveWeapon() != self then return end

	self:SetNextPrimaryFire( CurTime() + 1.5 )

	self.IdleDelay = CurTime() + 1
	self.b_IdleSequence = nil
	self:PlaySequence( "ToggleLight" )

	if ( SERVER ) then return end

	if ( !IsFirstTimePredicted() ) then return end

	timer.Simple( .25, function()

		if ( self.Active ) then

			self:EmitSound( "nextoren/weapons/items/flashlight/flashlight_off.wav", 75, 100, 0.6 )

		else

			self:EmitSound( "nextoren/weapons/items/flashlight/flashlight_on.wav", 90, 100, 0.6 )

		end

		if !IsValid(self.projectedLight) then

			self:BuildLight()

			return
		end

		self.Active = !self.Active

		if ( self.Active ) then

			self.projectedLight:SetNearZ( 1 )
			self.projectedLight:Update()

		else

			self.projectedLight:SetNearZ( 0 )
			self.projectedLight:Update()

		end

	end )

end

function SWEP:Holster()

	if ( !self.HolsterDelay ) then

		self.HolsterDelay = CurTime() + 1
		self:EmitSound( "weapons/m249/handling/m249_armmovement_01.wav", 75, math.random( 80, 100 ), 1, CHAN_WEAPON )
		self:PlaySequence( "Holster" )

	end

	if ( ( self.HolsterDelay || 0 ) < CurTime() ) then

		return true

	end

	self.IdleDelay = CurTime() + .5
	self.b_IdleSequence = nil

	if ( CLIENT ) then

		if ( self.projectedLight ) then

			self.projectedLight:SetNearZ( 0 )
			self.projectedLight:Update()

		end

	end

	self.Active = false

end


function SWEP:BuildLight()

	if ( SERVER ) then return end

	self.projectedLight = ProjectedTexture()
	self.projectedLight:SetEnableShadows( false )
	self.projectedLight:SetFarZ( 250 )
	self.projectedLight:SetFOV( 60 )
	self.projectedLight:SetColor( Color( 198, 198, 198, 180 ) )
	self.projectedLight:SetTexture( "nextoren/flashlight/flashlight001" )

	self.Owner:SetNWEntity( "FL_Flashlight", self.projectedLight )

	self.Active = true

end

function SWEP:OnDrop()

	if ( self.projectedLight ) then

		self.projectedLight:SetNearZ( 0 )
		self.projectedLight:Update()

	end

end


function SWEP:OnRemove()

	if ( self.projectedLight ) then

		self.projectedLight:SetNearZ( 0 )
		self.projectedLight:Update()
		self.projectedLight:Remove()

	end

	self.Active = false

	return true

end

function SWEP:CanSecondaryAttack()

  return false

end

function SWEP:CalcViewModelView( ent, oldPos, oldAng, pos, ang )

	UpdateFlashlight()

end


-- lua/weapons/weapon_flashlight.lua
-- Retrieved by https://github.com/lewez/glua-steal

SWEP.Spawnable = true
SWEP.UseHands = true

if ( CLIENT ) then

	SWEP.WepSelectIcon 	= surface.GetTextureID("vgui/entities/flash_light")
	SWEP.BounceWeaponIcon = false
	SWEP.InvIcon = Material( "nextoren/gui/icons/flashlight.png" )

end

if ( SERVER ) then

  SWEP.HoldType = "slam"

end

SWEP.PrintName = "Flashlight"
SWEP.ViewModel			= "models/cultist/items/flashlight/v_item_maglite.mdl"
SWEP.ViewModelFOV = 50
SWEP.WorldModel			= "models/cultist/items/flashlight/w_item_maglite.mdl"
SWEP.HoldType = "slam"
SWEP.DefaultHoldType = "slam"

SWEP.Pos = Vector( 3, 4, -1)
SWEP.Ang = Angle(0, 0, -25)

function SWEP:CreateWorldModel()

	if ( !self.WModel ) then
  	self.WModel = ClientsideModel(self.WorldModel, RENDERGROUP_OPAQUE)
  	self.WModel:SetNoDraw( true )
  	self.WModel:SetBodygroup(1, 1)
	end

  return self.WModel
end

function SWEP:DrawWorldModel()

	local pl = self:GetOwner()

	if ( pl && pl:IsValid() ) then

		local bone = self.Owner:LookupBone( "ValveBiped.Bip01_R_Hand" )

		if ( !bone ) then return end

	  local pos, ang = self.Owner:GetBonePosition( bone )

		local wm = self:CreateWorldModel()

	  if ( wm && wm:IsValid() ) then

	    ang:RotateAroundAxis(ang:Right(), self.Ang.p)
	    ang:RotateAroundAxis(ang:Forward(), self.Ang.y)
	    ang:RotateAroundAxis(ang:Up(), self.Ang.r)

	    wm:SetRenderOrigin(pos + ang:Right() * self.Pos.x + ang:Forward() * self.Pos.y + ang:Up() * self.Pos.z)
	    wm:SetRenderAngles(ang)
	    wm:DrawModel()

	  end

	else

		self:SetRenderOrigin( nil )
		self:SetRenderAngles( nil )
		self:DrawModel()
		self:SetModelScale( 1.1, 0 )

		if ( self.projectedLight ) then

			self.projectedLight:SetNearZ( 0 )
			self.projectedLight:Update()

		end

	end

end

SWEP.Primary.Blunt = true
SWEP.Primary.Damage = 25
SWEP.droppable				= true
SWEP.Primary.Reach = 40
SWEP.Primary.RPM = 90
SWEP.Primary.SoundDelay = 0
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.ClipSize	= -1
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.ClipSize	= 0
SWEP.Primary.Delay = 0.3
SWEP.Primary.Window = 0.2
SWEP.Primary.Automatic = false

SWEP.AllowViewAttachment = false

local matLight = Material( "sprites/light_ignorez" )

function SWEP:Initialize()

  self:SetHoldType( "slam" )

end

function SWEP:Deploy()

	self.HolsterDelay = nil
	self.b_IdleSequence = nil
	self.IdleDelay = CurTime() + .75
	self:PlaySequence( "DrawOn" )
	self:EmitSound( "weapons/m249/handling/m249_armmovement_02.wav", 75, math.random( 100, 120 ), 1, CHAN_WEAPON )
	self.Active = false

end

local function UpdateFlashlight()

	--[[[local pjs = LocalPlayer():GetNWEntity( "FL_Flashlight" )

	if ( pjs && pjs:IsValid() ) then

		if ( LocalPlayer():GetActiveWeapon() != NULL && LocalPlayer():GetActiveWeapon():GetClass() == "weapon_flashlight" ) then

			local bid = LocalPlayer():GetViewModel():LookupAttachment( "light" )
			local bp, ba = LocalPlayer():GetViewModel():GetBonePosition( bid )

			print( bid, bp, ba )
			pjs:SetPos( bp + ba:Forward() * 2 );
			pjs:SetAngles( ba );
			pjs:SetParent( LocalPlayer():GetViewModel(), LocalPlayer():GetViewModel():LookupAttachment( "light" ) )

		end

	end]]

end

function SWEP:Think()

	--[[if ( SERVER && self.projectedLight && self.projectedLight:IsValid() ) then

		self.projectedLight:SetPos( self.Owner:EyePos() + self.Owner:GetAimVector() * 10 );
		self.projectedLight:SetAngles( self.Owner:EyeAngles() );

	end]]

	if ( CLIENT && self.Active ) then

		if ( !self.att_ViewModel ) then

			self.att_ViewModel = self.Owner:GetViewModel()

		end

		local att = self.att_ViewModel:GetAttachment( 1 )

		if ( att ) then

			self.projectedLight:SetPos( att.Pos )
			self.projectedLight:SetAngles( att.Ang )

		end

		self.projectedLight:Update()

	end

	local speed = self.Owner:GetVelocity():LengthSqr()

	if ( speed > 1000 && speed < 22500 ) then

		self.IdleSequence = "walk"

	elseif ( speed >= 22500 ) then

		self.IdleSequence = "Sprint"

	else

		self.IdleSequence = "Idle"

	end

	if ( ( self.IdleDelay || 0 ) < CurTime() || self.b_IdleSequence && self.IdleSequence != self.Old_IdleSequence ) then

		self.IdleDelay = CurTime() + 2
		self:PlaySequence( self.IdleSequence )

		self.b_IdleSequence = true
		self.Old_IdleSequence = self.IdleSequence

	end

end

function SWEP:PrimaryAttack()

	--if !IsValid(self) || !IsValid(self.Owner) || !self.Owner:GetActiveWeapon() || self.Owner:GetActiveWeapon() != self then return end

	self:SetNextPrimaryFire( CurTime() + 1.5 )

	self.IdleDelay = CurTime() + 1
	self.b_IdleSequence = nil
	self:PlaySequence( "ToggleLight" )

	if ( SERVER ) then return end

	if ( !IsFirstTimePredicted() ) then return end

	timer.Simple( .25, function()

		if ( self.Active ) then

			self:EmitSound( "nextoren/weapons/items/flashlight/flashlight_off.wav", 75, 100, 0.6 )

		else

			self:EmitSound( "nextoren/weapons/items/flashlight/flashlight_on.wav", 90, 100, 0.6 )

		end

		if !IsValid(self.projectedLight) then

			self:BuildLight()

			return
		end

		self.Active = !self.Active

		if ( self.Active ) then

			self.projectedLight:SetNearZ( 1 )
			self.projectedLight:Update()

		else

			self.projectedLight:SetNearZ( 0 )
			self.projectedLight:Update()

		end

	end )

end

function SWEP:Holster()

	if ( !self.HolsterDelay ) then

		self.HolsterDelay = CurTime() + 1
		self:EmitSound( "weapons/m249/handling/m249_armmovement_01.wav", 75, math.random( 80, 100 ), 1, CHAN_WEAPON )
		self:PlaySequence( "Holster" )

	end

	if ( ( self.HolsterDelay || 0 ) < CurTime() ) then

		return true

	end

	self.IdleDelay = CurTime() + .5
	self.b_IdleSequence = nil

	if ( CLIENT ) then

		if ( self.projectedLight ) then

			self.projectedLight:SetNearZ( 0 )
			self.projectedLight:Update()

		end

	end

	self.Active = false

end


function SWEP:BuildLight()

	if ( SERVER ) then return end

	self.projectedLight = ProjectedTexture()
	self.projectedLight:SetEnableShadows( false )
	self.projectedLight:SetFarZ( 250 )
	self.projectedLight:SetFOV( 60 )
	self.projectedLight:SetColor( Color( 198, 198, 198, 180 ) )
	self.projectedLight:SetTexture( "nextoren/flashlight/flashlight001" )

	self.Owner:SetNWEntity( "FL_Flashlight", self.projectedLight )

	self.Active = true

end

function SWEP:OnDrop()

	if ( self.projectedLight ) then

		self.projectedLight:SetNearZ( 0 )
		self.projectedLight:Update()

	end

end


function SWEP:OnRemove()

	if ( self.projectedLight ) then

		self.projectedLight:SetNearZ( 0 )
		self.projectedLight:Update()
		self.projectedLight:Remove()

	end

	self.Active = false

	return true

end

function SWEP:CanSecondaryAttack()

  return false

end

function SWEP:CalcViewModelView( ent, oldPos, oldAng, pos, ang )

	UpdateFlashlight()

end


