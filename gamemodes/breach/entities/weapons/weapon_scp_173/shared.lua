SWEP.Author			= "Maya"
SWEP.Contact		= "Look at this gamemode in workshop and search for creators"

SWEP.ViewModelFOV	= 62
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/vinrax/props/keycard.mdl"
SWEP.WorldModel		= "models/vinrax/props/keycard.mdl"
SWEP.PrintName		= "SCP-173"
SWEP.Slot			= 0
SWEP.SlotPos		= 0
SWEP.DrawAmmo		= false
SWEP.DrawCrosshair	= false
SWEP.HoldType		= "normal"
SWEP.Spawnable		= false
SWEP.AdminSpawnable	= false

SWEP.Primary.Ammo			= "none"
SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false

SWEP.SpecialDelay			= 30
SWEP.Secondary.Ammo			= "none"
SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= 0
SWEP.Secondary.Automatic	= false

SWEP.Pickupable = false
SWEP.AttackDelay			= 0.25
SWEP.ISSCP					= true
SWEP.CColor					= Color(255,255,255,120)
SWEP.SnapSound				= Sound("breach2/scp/173/NeckSnap1.ogg")
SWEP.teams					= {1}

SWEP.NextPos				= nil
SWEP.NextAng				= nil
SWEP.MaxTargets				= 3

SWEP.Enabled = true
SWEP.DefaultNVG = {
	contrast = 2,
	colour = 1,
	brightness = 0,
	clr_r = 0.05,
	clr_g = 1,
	clr_b = 0.05,
	add_r = 0,
	add_g = 0.05,
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
	fog = function(fog_mul)
		render.FogStart(0)
		render.FogEnd((FOG_LEVEL * fog_mul) * 3)
		render.FogColor(0, 1, 0)
		render.FogMaxDensity(1)
		render.FogMode(MATERIAL_FOG_LINEAR)
		return true
	end
}
SWEP.NVG = table.Copy(SWEP.DefaultNVG)

function SWEP:Deploy()
	local ourSpeed = 1
	self.Owner:DrawViewModel(false)
	self.Owner:SetJumpPower(1)
	self.Owner:SetWalkSpeed(ourSpeed)
	self.Owner:SetRunSpeed(ourSpeed)
	self.Owner:SetMaxSpeed(ourSpeed)
	self.Owner:SetNoDraw(true)
	self.NextPos = nil
	self.NextAng = nil
	self.Targets = {}
	self.MoveDelay = 0
end

function SWEP:DrawWorldModel()
end
function SWEP:PrimaryAttack()
end
function SWEP:SecondaryAttack()
end
function SWEP:Holster()
	return true
end
function SWEP:Reload() end

SWEP.FreeRoamMode = false

SWEP.MoveDelay = 0
function SWEP:Move(ply, mv)
	if self.FreeRoamMode then
		return false
	end

	local buttons = mv:GetButtons()
	if mv:KeyDown(IN_FORWARD) then
		if SERVER then
			self:SetNextPos()
			self:MoveToNextPos(mv)
		end
	end
	
	if mv:KeyDown(IN_ATTACK) then
		if SERVER then self:DestroyGlass() end
	end

	if mv:KeyDown(IN_BACK) then
		self:ResetNextPos()
	end

	return true
end

function SWEP:SetNextPos()
	if self.FreeRoamMode then
		return
	end

	--if SERVER then
		local ent173 = self.Owner:GetNWEntity("entity173")
		if !IsValid(ent173) then return end
		local nextpostab = self:TraceNextPos(ent173)

		for k,v in pairs(nextpostab.hits) do
			if v.Hit == true then return end
		end

		self.NextPos = nextpostab.start.HitPos
		self.NextAng = Angle(0,self.Owner:EyeAngles().y,0)
		--self:SetNWVector("NextPos", self.NextPos)
	--end
end

function SWEP:ResetNextPos()
	self.NextPos = self.Owner:GetPos()
end

function SWEP:ClearTrace(tr_structure)
	local new_tr = nil
	local ent173 = self.Owner:GetNWEntity("entity173")
	local filerEnts = {self.Owner}

	if IsValid(ent173) then
		table.ForceInsert(filerEnts, ent173)
	end

	for i = 1, 10 do
		new_tr = util.TraceLine({
			start = tr_structure.start,
			endpos = tr_structure.endpos,
			mask = tr_structure.mask,
			filter = filerEnts
		})

		local ent = new_tr.Entity

		if IsValid(ent) == false or new_tr.Hit == false or new_tr.HitNonWorld == false or new_tr.HitSky == true then
			return new_tr
		end

		if ent:IsPlayer() == true then
			if ent:Alive() == false or ent:Team() == TEAM_SPECTATOR or ent:Team() == TEAM_SCP then
				table.ForceInsert(filerEnts, ent)
			end
		else
			return new_tr
		end
	end
	
	return new_tr
end

function SWEP:FrontTraceLine()
	local ent173 = self.Owner:GetNWEntity("entity173")

	if IsValid(ent173) then
		local ourpos = ent173:GetPos()
		local eyeangles = self.Owner:EyeAngles()

		local tr_front = util.TraceLine({
			start = Vector(ourpos.x, ourpos.y, ourpos.z + 95),
			endpos = Vector(ourpos.x, ourpos.y, ourpos.z + 95) + eyeangles:Forward() * 70,
			filter = {self, self.Owner, ent173},
			mask = MASK_PLAYERSOLID_BRUSHONLY
		})

		return tr_front
	end

	return nil
end


SWEP.ViewLeftSide = false

function SWEP:Tick()
	if self.Owner:KeyDown(IN_MOVELEFT) then
		self.ViewLeftSide = true

	elseif self.Owner:KeyDown(IN_MOVERIGHT) then
		self.ViewLeftSide = false
	end
end

local movement_mask = CONTENTS_SOLID + CONTENTS_OPAQUE + CONTENTS_MOVEABLE + CONTENTS_MONSTER + CONTENTS_DEBRIS

local clc_trh_size = 7
function SWEP:CalcViewInfo(ply, position, angles, fov)
	local view = {origin = pos, angles = angles, fov = fov, drawviewer = false}

	if self.FreeRoamMode then
		return view
	end

	view = {origin = pos, angles = self.Owner:EyeAngles(), fov = 90, drawviewer = false}

	local ent173 = self.Owner:GetNWEntity("entity173")
	if !IsValid(ent173) then return end

	local ply_pos = ent173:GetPos() + Vector(0, 0, 10)
	local ply_eyepos = self.Owner:EyePos()

	local tr_up = util.TraceHull({
		start = ply_pos,
		endpos = ply_pos + Angle(-90, 0, 0):Forward() * 85,
		filter = {self.Owner, ent173},
		mins = Vector(-clc_trh_size, -clc_trh_size, -clc_trh_size),
		maxs = Vector(clc_trh_size, clc_trh_size, clc_trh_size),
		mask = movement_mask
	})

	local right_pos = 0
	if self.ViewLeftSide then
		right_pos = ply_eyepos - view.angles:Right() * 25
	else
		right_pos = ply_eyepos + view.angles:Right() * 25
	end

	local tr_lf = util.TraceHull({
		start = ply_eyepos,
		endpos = right_pos,
		filter = {self.Owner, ent173},
		mins = Vector(-clc_trh_size, -clc_trh_size, -clc_trh_size),
		maxs = Vector(clc_trh_size, clc_trh_size, clc_trh_size),
		mask = movement_mask
	})

	local tr_fr = util.TraceHull({
		start = tr_lf.HitPos,
		endpos = tr_lf.HitPos - Angle(0, view.angles.y, 0):Forward() * 45,
		filter = {self.Owner, ent173},
		mins = Vector(-clc_trh_size, -clc_trh_size, -clc_trh_size),
		maxs = Vector(clc_trh_size, clc_trh_size, clc_trh_size),
		mask = movement_mask
	})

	view.origin = tr_up.HitPos
	view.origin.z = math.Clamp(tr_up.HitPos.z, (self.Owner:GetPos() + Vector(0,0,80)).z, 100000)
	--view.origin.z = tr_up.HitPos.z - 5
	view.angles.yaw = view.angles.yaw + 2
	view.origin.x = tr_fr.HitPos.x
	view.origin.y = tr_fr.HitPos.y
	return view
end

function SWEP:TraceNextPos(ent173)
	if self.FreeRoamMode then return end

	local view = self:CalcViewInfo()
	if view == nil then return end

	local ourpos = view.origin
	ourpos.z = ent173:GetPos().z
	local eyeangles = view.angles

	local filters = {self.Owner, ent173}
	
	local tr_start = util.TraceHull({
		start = Vector(ourpos.x, ourpos.y, ourpos.z + 95),
		endpos = Vector(ourpos.x, ourpos.y, ourpos.z + 95) + eyeangles:Forward() * 300,
		filter = filters,
		mins = Vector(-4, -4, -4),
		maxs = Vector(4, 4, 4),
		mask = movement_mask
	})

	local tr = util.TraceLine({
		start = tr_start.HitPos,
		endpos = tr_start.HitPos - Angle(-90,0,0):Forward() * 2000,
		filter = filters
	})

	local hittab = {}
	local size1 = 20
	local size2 = 100
	local emask = MASK_ALL
	local angle_up = Angle(-90,0,0):Forward() * size2 + Angle(0, eyeangles.y, 0):Forward() * 10
	local angle_up2 = Angle(-90,0,0):Forward() * 50 + Angle(0, eyeangles.y, 0):Forward() * 20
	hittab.tr1 = util.TraceLine({start = tr.HitPos, 	endpos = tr.HitPos + Angle(-10, eyeangles.y - 90, 0):Forward() * size1, 	mask = emask})
	hittab.tr2 = util.TraceLine({start = tr.HitPos, 	endpos = tr.HitPos + Angle(-10, eyeangles.y + 90, 0):Forward() * size1, 	mask = emask})
	hittab.tr1_up1 = util.TraceLine({start = hittab.tr1.HitPos, 	endpos = hittab.tr1.HitPos + angle_up, 		mask = emask})
	hittab.tr2_up1 = util.TraceLine({start = hittab.tr2.HitPos, 	endpos = hittab.tr2.HitPos + angle_up, 		mask = emask})
	hittab.tr1_up2 = util.TraceLine({start = hittab.tr1.HitPos, 	endpos = hittab.tr1.HitPos + angle_up2, 	mask = emask})
	hittab.tr2_up2 = util.TraceLine({start = hittab.tr2.HitPos, 	endpos = hittab.tr2.HitPos + angle_up2, 	mask = emask})

	return {start = tr, hits = hittab}
end
