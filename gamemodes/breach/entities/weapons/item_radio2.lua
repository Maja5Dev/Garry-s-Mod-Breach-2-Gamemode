
SWEP.Base			= "br2_item_base"
SWEP.PrintName		= "Strange Radio"
--SWEP.ViewModel		= "models/mishka/models/radio.mdl"
--SWEP.WorldModel		= "models/mishka/models/radio.mdl"
SWEP.ViewModel		= "models/radio/c_radio.mdl"
SWEP.WorldModel		= "models/radio/w_radio.mdl"
SWEP.Slot			= 6
SWEP.SlotPos		= 1
SWEP.Spawnable		= true
SWEP.AdminSpawnable	= true
SWEP.Category		= "Breach 2"
SWEP.Pickupable 	= true

SWEP.Enabled = false
SWEP.NextChange = 0

SWEP.BoneAttachment = "ValveBiped.Bip01_R_Hand"
SWEP.WorldModelPositionOffset = Vector(6, -4, -2)
SWEP.WorldModelAngleOffset = Angle(90, -45, 90)

function SWEP:SaveVariablesTo(ent)
	ent.Code = self.Code
end

SWEP.LoopingSoundID = nil

function SWEP:Deploy()
	self.Owner:DrawViewModel(false)
	
	if CLIENT and IsFirstTimePredicted() then
		surface.PlaySound("breach2/items/pickitem2.ogg")

		self.CurrentCode = 1
		self.CurrentCodeNum = 1
	end

	if SERVER then
		self:StopLoopingStatic()

		self.LoopingSoundID = self:StartLoopingSound("radio/static_loop.wav")
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

function SWEP:StopLoopingStatic()
	if SERVER and isnumber(self.LoopingSoundID) then
		self:StopLoopingSound(self.LoopingSoundID)
	end
end

function SWEP:OnRemove()
	if SERVER then
		self:StopLoopingStatic()
	end
end

function SWEP:Holster()
	if SERVER then
		self:StopLoopingStatic()
	end

	return true
end


SWEP.Channel = 1
SWEP.CurrentCode = 1
SWEP.CurrentCodeNum = 1

SWEP.NextChannelChange = 0

function SWEP:Think()
	if CLIENT then
		if self.NextChannelChange < CurTime() then
			self.Channel = math.random(1,9)
			self.NextChannelChange = CurTime() + 0.05
		end
	end

	if SERVER then
		if self.Code == nil then return end
		
		self.NextBeep = self.NextBeep or (CurTime() + 2)
		self.NextStatic = self.NextStatic or 0

		if self.NextBeep < CurTime() then
			self.Owner:EmitSound("radio/buzz.ogg")

			if self.CurrentCodeNum >= tonumber(tostring(self.Code):sub(self.CurrentCode, self.CurrentCode)) then
				self.CurrentCodeNum = 1
				self.CurrentCode = self.CurrentCode + 1
				
				if self.CurrentCode > 4 then
					self.CurrentCode = 1
					self.NextBeep = CurTime() + 4
				else
					self.NextBeep = CurTime() + 2
				end
			else
				self.NextBeep = CurTime() + 0.5
				self.CurrentCodeNum = self.CurrentCodeNum + 1
			end
		end
	end
end

function SWEP:PrimaryAttack()
end

function SWEP:SecondaryAttack()
end

local ourMat = Material("breach2/RadioHUD.png")

function SWEP:DrawHUD()
	if LocalPlayer() != self.Owner then return end

	local rw = math.Clamp(ScrW(), 1, 1920) / 7.6
	local rh = (rw * 2) * 1.1
	surface.SetDrawColor(255, 255, 255, 255)
	surface.SetMaterial(ourMat)
	surface.DrawTexturedRect(ScrW() - rw, ScrH() - rh + 1, rw, rh)

	draw.Text({
		text = self.Channel,
		pos = {ScrW() - rw + 174, ScrH() - rh + 390},
		font = "BR2_RadioFont_1",
		color = Color(0,0,0,250),
		xalign = TEXT_ALIGN_RIGHT,
		yalign = TEXT_ALIGN_TOP,
	})

	draw.Text({
		text = "CHN",
		pos = {ScrW() - rw + 150, ScrH() - rh + 394},
		font = "BR2_RadioFont_2",
		color = Color(0,0,0,250),
		xalign = TEXT_ALIGN_RIGHT,
		yalign = TEXT_ALIGN_TOP,
	})
end

function SWEP:GetBetterOne()
	if br_914status == SCP914_ROUGH then
		return "battery9v"

	elseif br_914status == SCP914_COARSE then
		return "item_radio"
	end

	return self
end
