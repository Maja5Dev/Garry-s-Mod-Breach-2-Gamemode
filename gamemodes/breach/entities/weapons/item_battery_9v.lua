
SWEP.Base			= "br2_item_base"
SWEP.PrintName		= "9V Battery"
SWEP.Spawnable		= true
SWEP.AdminSpawnable	= true
SWEP.Category		= "Breach 2"
SWEP.Slot			= 8
SWEP.SlotPos		= 0
SWEP.clevel			= 0
SWEP.ForceSkin 		= 1
SWEP.Pickupable 	= true

SWEP.ViewModel		= "models/mishka/models/battery.mdl"
SWEP.WorldModel		= "models/mishka/models/battery.mdl"
SWEP.HoldType		= "pistol"

SWEP.BoneAttachment = "ValveBiped.Bip01_R_Hand"
SWEP.WorldModelPositionOffset = Vector(3, -1, -1)
SWEP.WorldModelAngleOffset = Angle(0, 2, -90)

function SWEP:Deploy()
	self:SetHoldType(self.HoldType)
	self.Owner:DrawViewModel(false)
	if CLIENT and IsFirstTimePredicted() then
		surface.PlaySound("breach2/pickitem2.ogg")
	end
end

function SWEP:DrawWorldModel()
	if LocalPlayer() != self.Owner and (LocalPlayer():GetObserverMode() == OBS_MODE_IN_EYE) then return end
	if !IsValid(self.Owner) then
		self:DrawModel()
	else
		if !IsValid(self.WM) then
			self.WM = ClientsideModel(self.WorldModel)
			self.WM:SetNoDraw(true)
		end

		local boneid = self.Owner:LookupBone(self.BoneAttachment)
		if not boneid then return end

		local matrix = self.Owner:GetBoneMatrix(boneid)
		if not matrix then return end

		local newpos, newang = LocalToWorld(self.WorldModelPositionOffset, self.WorldModelAngleOffset, matrix:GetTranslation(), matrix:GetAngles())

		self.WM:SetPos(newpos)
		self.WM:SetAngles(newang)
		self.WM:SetupBones()
		if self.ForceSkin then
			self.WM:SetSkin(self.ForceSkin)
		end
		self.WM:DrawModel()
	end
end

function SWEP:PrimaryAttack()
	local tr_hull = util.TraceHull({
		start = self.Owner:GetShootPos(),
		endpos = self.Owner:GetShootPos() + (self.Owner:GetAimVector() * 100),
		filter = self.Owner,
		mins = Vector(-2, -2, -2), maxs = Vector(2, 2, 2),
		mask = MASK_SHOT_HULL
	})
	if SERVER then
		if tr_hull.Entity.BatteryLevel then
			tr_hull.Entity.BatteryLevel = 100
			self.Owner:StripWeapon(self:GetClass())
		end
	elseif IsFirstTimePredicted() then
		if tr_hull.Entity.BatteryLevel then
			chat.AddText(Color(255,255,255,255), "Trying to use battery on item...")
		end
	end
end

function SWEP:Initialize()
	self:SetSkin(self.ForceSkin)
end

function SWEP:DrawHUD()
	if !BR2_ShouldDrawWeaponInfo() then return end
	draw.Text({
		text = "You can use batteries on an item using primary attack",
		pos = { ScrW() / 2, ScrH() - 6},
		font = "BR2_ItemFont",
		color = Color(255,255,255,50),
		xalign = TEXT_ALIGN_CENTER,
		yalign = TEXT_ALIGN_BOTTOM,
	})
end

function SWEP:GetBetterOne()
	if br_914status == 1 or br_914status == 2 or br_914status == 5 then
		return nil
	elseif br_914status == 3 or br_914status == 4 then
		return "item_battery_9v"
	end
	return nil
end
