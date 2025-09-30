
SWEP.Base			= "br2_item_base"
SWEP.PrintName		= "Gasmask"
SWEP.ViewModel		= "models/mishka/models/gasmask.mdl"
SWEP.WorldModel		= "models/mishka/models/gasmask.mdl"
SWEP.HoldType		= "normal"
SWEP.Slot			= 7
SWEP.SlotPos		= 0
SWEP.Spawnable		= true
SWEP.AdminSpawnable	= true
SWEP.Category		= "Breach 2"
SWEP.Pickupable 	= true

SWEP.BoneAttachment = "ValveBiped.Bip01_R_Hand"
SWEP.WorldModelPositionOffset = Vector(2, 0, 0)
SWEP.WorldModelAngleOffset = Angle(20, 180, 180)

function SWEP:Deploy()
	self.Owner:DrawViewModel(false)
	if CLIENT and IsFirstTimePredicted() then
		surface.PlaySound("breach2/items/pickitem2.ogg")
	end
end

function SWEP:DrawWorldModel()
	if LocalPlayer() != self.Owner and (LocalPlayer():GetObserverMode() == OBS_MODE_IN_EYE) then return end
	if self.Enabled == true then return end

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

function SWEP:Initialize()
	self:SetHoldType(self.HoldType)
end

SWEP.GasMaskOn = false
SWEP.NextChange = 0
function SWEP:PrimaryAttack()
	if self.NextChange < CurTime() then
		if !self.GasMaskOn and (self.Owner:CheckAttachmentSlot("eyes") or self.Owner:CheckAttachmentSlot("face")) then
			if CLIENT then
				self.Owner:PrintMessage(HUD_PRINTTALK, "You are already wearing something on your face!")
			end
			return
		end

		self.GasMaskOn = !self.GasMaskOn
		self.NextChange = CurTime() + 0.5

		if CLIENT and IsFirstTimePredicted() then
			surface.PlaySound("breach2/items/pickitem2.ogg")
		end

		if SERVER then
			if self.GasMaskOn then
				AttachGasmask(self.Owner)
			else
				RemoveGasmask(self.Owner)
			end
		end
	end
end

function SWEP:DrawHUD()
	if !BR2_ShouldDrawWeaponInfo() then return end

	if self.GasMaskOn == false then
		draw.Text({
			text = "Primary attack puts on the gasmask",
			pos = { ScrW() / 2, ScrH() - 6},
			font = "BR2_ItemFont",
			color = Color(255,255,255,80),
			xalign = TEXT_ALIGN_CENTER,
			yalign = TEXT_ALIGN_BOTTOM,
		})
	end
end

function SWEP:GetBetterOne()
	if br_914status == SCP914_VERY_FINE then
		return "item_gasmask2"
	end
	
	return self
end

if SERVER then
	function AttachGasmask(ply)
		ply:AddAttachmentModel({
			model = "models/mishka/models/gasmask.mdl",
			attachment = "eyes",
			offset = Vector(0, -1, -2),
			angOffset = Angle(260, 0, 180)
		})
	end

	function RemoveGasmask(ply)
		ply:RemoveAttachmentModel("models/mishka/models/gasmask.mdl")
	end
end

function HasGasmaskOn(ply)
	if not ply.attachmentModels then return false end

	local wep = ply:GetWeapon("item_gasmask")
	local wep2 = ply:GetWeapon("item_gasmask2")

	if (IsValid(wep) and wep.GasMaskOn == true) or (IsValid(wep2) and wep2.GasMaskOn == true) then
		for _, v in pairs(ply.attachmentModels) do
			if v.model == "models/mishka/models/gasmask.mdl" then
				return true
			end
		end
	end

	return false
end
