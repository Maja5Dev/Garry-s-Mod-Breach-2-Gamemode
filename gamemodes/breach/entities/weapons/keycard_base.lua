
SWEP.PrintName 		= "Keycard Base"
SWEP.Author			= "Maya"
--SWEP.ViewModel		= "models/mishka/models/keycard.mdl"
--SWEP.WorldModel		= "models/mishka/models/keycard.mdl"
SWEP.ViewModel = "models/cultist/items/keycards/v_keycard.mdl"
SWEP.WorldModel = "models/cultist/items/keycards/w_keycard.mdl"
SWEP.Slot			= 4
SWEP.SlotPos		= 0
SWEP.Category		= "Breach 2"
SWEP.HoldType		= "pistol"
SWEP.Pickupable 	= true
SWEP.UseHands		= true

SWEP.clevel			= 1
SWEP.ForceSkin 		= 0

SWEP.BoneAttachment = "ValveBiped.Bip01_R_Hand"
SWEP.WorldModelPositionOffset = Vector(7, -1.5, -2.9)
SWEP.WorldModelAngleOffset = Angle(-20, 180, 190)

function SWEP:GetBetterOne()
	local r = math.random(1,100)
	if br_914status == SCP914_1_1 then
		if r < 50 then
			return "keycard_level2"
		else
			return "keycard_level1"
		end
	elseif br_914status == SCP914_FINE then
		if r < 20 then
			return "keycard_level3"
		elseif r < 40 then
			return "keycard_level2"
		else
			return "keycard_level1"
		end
	end
	return "keycard_level1"
end

function SWEP:Deploy()
	self:SetHoldType(self.HoldType)
	self.NextAnimChange = CurTime() + 1.25

	if IsFirstTimePredicted() then
		if CLIENT then
			surface.PlaySound("breach2/items/pickitem2.ogg")
		end
		self:PlaySequence("draw")
	end
end

function SWEP:PreDrawViewModel(vm, wep, ply)
	vm:SetSkin(self.ForceSkin)
end

/*
function SWEP:CalcViewModelView(vm, oldpos, oldang, pos, ang)
	if !IsValid(self.Owner) then return end
	local angs = self.Owner:EyeAngles()
	ang.pitch = -ang.pitch
	return pos + angs:Forward() * 14 + angs:Right() * -3.5 + angs:Up() * -6, ang + Angle(0, 180, -230)
end
*/

function SWEP:DrawWorldModel()
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
	self:SetSkin(self.ForceSkin)
end

SWEP.NextAnimChange = 0
SWEP.IdlePlaying = false
SWEP.ClickedUse = false
function SWEP:UseFunc()
	self:PlaySequence("insert")
	self.IdlePlaying = false
	self.NextAnimChange = CurTime() + 0.5
end

function SWEP:Think()
	self.ov_initialized = self.ov_initialized or false
	if self.ov_initialized == false then
		self:SetHoldType(self.HoldType)
		self.ov_initialized = true
	end

	if IsFirstTimePredicted() then
		if self.NextAnimChange < CurTime() then
			if self.IdlePlaying == false then
				self:PlaySequence("idle")
				self.IdlePlaying = true
				self.NextAnimChange = CurTime() + 1.25
			end
		end


		if self.Owner:KeyDown(IN_USE) then
			if self.ClickedUse == false then
				self.ClickedUse = true
				self:UseFunc()
			end
		else
			self.ClickedUse = false
		end
	end
end

function SWEP:PrimaryAttack()
	--RunConsoleCommand("+use")
end

function SWEP:SecondaryAttack()
	--RunConsoleCommand("+use")
end

function SWEP:Reload()
end
