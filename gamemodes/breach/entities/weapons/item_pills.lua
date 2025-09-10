
SWEP.Base			= "br2_item_base"
SWEP.PrintName		= "SSRI Pills"
SWEP.Spawnable		= true
SWEP.AdminSpawnable	= true
SWEP.Category		= "Breach 2"
SWEP.Slot			= 8
SWEP.SlotPos		= 0
SWEP.clevel			= 0
SWEP.Pickupable 	= true

--SWEP.ViewModel		= "models/props_lab/jar01b.mdl"
--SWEP.WorldModel		= "models/props_lab/jar01b.mdl"
SWEP.ViewModel		= "models/cultist/items/painpills/v_painpills.mdl"
SWEP.WorldModel		= "models/cultist/items/painpills/w_painpills.mdl"
SWEP.UseHands 		= true

SWEP.HoldType		= "pistol"

SWEP.BoneAttachment = "ValveBiped.Bip01_R_Hand"
SWEP.WorldModelPositionOffset = Vector(3, -4, -1)
SWEP.WorldModelAngleOffset = Angle(0, 0, 180)

function SWEP:Deploy()
	self:SetHoldType(self.HoldType)
	--self.Owner:DrawViewModel(false)
	if CLIENT and IsFirstTimePredicted() then
		surface.PlaySound("breach2/pills_deploy_"..math.random(1,3)..".wav")
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
	if SERVER then
		self.Owner:AddSanity(100)
		self.Owner:StripWeapon(self:GetClass())
		self.Owner.nextHorrorSCP = CurTime() + 45
	end
	if CLIENT and IsFirstTimePredicted() then
		if IsValid(horror_scp_ent) and horror_scp_ent.isEnding == 0 then
			horror_scp_ent:Remove()
			surface.PlaySound("breach2/horror/shadowhand_snuff.mp3")
		end
		surface.PlaySound("breach2/pills_use.wav")
		RunConsoleCommand("lastinv")
	end
end

function SWEP:DrawHUD()
	if !BR2_ShouldDrawWeaponInfo() then return end
	draw.Text({
		text = "Click Primary attack to take the pills",
		pos = { ScrW() / 2, ScrH() - 6},
		font = "BR2_ItemFont",
		color = Color(255,255,255,80),
		xalign = TEXT_ALIGN_CENTER,
		yalign = TEXT_ALIGN_BOTTOM,
	})
end

function SWEP:GetBetterOne()
	if br_914status == 1 or br_914status == 2 or br_914status == 5 then
		return nil
	elseif br_914status == 3 or br_914status == 4 then
		return "item_pills"
	end
	return nil
end
