SWEP.Author			= "Kanade"
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

SWEP.DLightLevel = 0
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
	fog = function()
		render.FogStart(0)
		render.FogEnd(2000)
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

SWEP.TeleportingMode = false

SWEP.MoveDelay = 0
function SWEP:Move(ply, mv)
	if self.TeleportingMode then
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

SWEP.NextDG = 0
function SWEP:DestroyGlass()
	if self.NextDG > CurTime() then return end
	
	local ent173 = self.Owner:GetNWEntity("entity173")
	if !IsValid(ent173) then return end
	if ent173:CanMove(self:GetPos()) == true then
		local ourpos = ent173:GetPos()
		local eyeangles = self.Owner:EyeAngles()
		local tr = self:ClearTrace({
			start = Vector(ourpos.x, ourpos.y, ourpos.z + 95),
			endpos = Vector(ourpos.x, ourpos.y, ourpos.z + 95) + eyeangles:Forward() * 100,
			mask = MASK_ALL
		})
		if IsValid(tr.Entity) then
			if tr.Entity:GetClass() == "func_breakable" then
				tr.Entity:TakeDamage(100, self.Owner, self.Owner)
			end
		end
		self.NextDG = CurTime() + 1.5
	else
		self.NextDG = CurTime() + 0.5
	end
end

function SWEP:SetNextPos()
	if self.TeleportingMode then
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

	for i=1, 10 do
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

function SWEP:Think()
	self:Check173()

	if CLIENT then
		if IsValid(self.Owner:GetNWEntity("entity173")) then
			self.entIsAttacking = self.Owner:GetNWEntity("entity173"):GetNWBool("IsAttacking")
		end
	else
		self.Owner:SetNoDraw(true)
		if IsValid(self.Owner.entity173) and !self.TeleportingMode then
			self.Owner.entity173:SetPos(self.Owner:GetPos())
		end
	end

	self:NextThink(CurTime() + 0.5)
end

function SWEP:Check173()
	if SERVER then
		if IsValid(self.Owner.entity173) == false then
			local try_ent = ents.Create("breach_173ent")
			if !IsValid(try_ent) then return end

			if istable(MAPCONFIG) and istable(MAPCONFIG.SPAWNS_SCP_173) then
				self.Owner:SetPos(table.Random(MAPCONFIG.SPAWNS_SCP_173))
			end

			self.Owner:SetEyeAngles(Angle(0, 90, 0))
			self.Owner.entity173 = try_ent
			self.Owner.entity173:SetCurrentOwner(self.Owner)
			self.Owner.entity173:SetModel(SCP_173_MODEL)
			self.Owner.entity173:SetPos(self.Owner:GetPos())
			self.Owner.entity173:SetAngles(Angle(0, 90, 0))
			self.Owner.entity173:Spawn()
			self.Owner:SetNWEntity("entity173", self.Owner.entity173)
		end
	end
end

function SWEP:AttackNearbyPlayers()
	if IsValid(self.Owner.entity173) then
		self.Owner.entity173:AttackNearbyPlayers()
	end
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
			mask = MASK_ALL
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

local clc_trh_size = 7
function SWEP:CalcViewInfo(ply, position, angles, fov)
	local view = {origin = pos, angles = angles, fov = fov, drawviewer = false}

	if self.TeleportingMode then
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
		mask = MASK_SOLID
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
		mask = MASK_SOLID
	})

	local tr_fr = util.TraceHull({
		start = tr_lf.HitPos,
		endpos = tr_lf.HitPos - Angle(0, view.angles.y, 0):Forward() * 45,
		filter = {self.Owner, ent173},
		mins = Vector(-clc_trh_size, -clc_trh_size, -clc_trh_size),
		maxs = Vector(clc_trh_size, clc_trh_size, clc_trh_size),
		mask = MASK_SOLID
	})

	view.origin = tr_up.HitPos
	view.origin.z = tr_up.HitPos.z - 5
	view.angles.yaw = view.angles.yaw + 2
	view.origin.x = tr_fr.HitPos.x
	view.origin.y = tr_fr.HitPos.y
	return view
end

function SWEP:TraceNextPos(ent173)
	if self.TeleportingMode then
		return
	end

	local view = self:CalcViewInfo()
	if view == nil then return end

	local ourpos = view.origin
	ourpos.z = ent173:GetPos().z
	local eyeangles = view.angles

	local smask = MASK_ALL
	local filters = {self.Owner, ent173}
	
	local tr_start = util.TraceLine({
		start = Vector(ourpos.x, ourpos.y, ourpos.z + 95),
		endpos = Vector(ourpos.x, ourpos.y, ourpos.z + 95) + eyeangles:Forward() * 450,
		filter = filters,
		mask = smask
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
