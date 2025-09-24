
SWEP.Base			= "br2_item_base"
SWEP.PrintName		= "Big Medkit"
SWEP.Spawnable		= true
SWEP.AdminSpawnable	= true
SWEP.Category		= "Breach 2"
SWEP.Slot			= 8
SWEP.SlotPos		= 0
SWEP.clevel			= 0

SWEP.ViewModelFOV 	= 54
SWEP.ViewModel		= "models/cultist/items/medkit/v_medkit.mdl"
SWEP.WorldModel		= "models/cultist/items/medkit/w_medkit.mdl"
SWEP.HoldType		= "slam"
SWEP.UseHands		= true
SWEP.Pickupable 	= true

SWEP.Contents = {
	bandage = {
		name = "Bandage",
		def_amount = 3,
		amount = 3,
		cl_effect = function(self)
			net.Start("br_use_medkit_item")
				net.WriteString("bandage")
			net.SendToServer()

			self.Contents.bandage.amount = self.Contents.bandage.amount - 1
			if self.Contents.bandage.amount < 1 then
				self.Contents.bandage = nil
				if table.Count(self.Contents) > 0 then
					self:CreateFrame()
				end
			end
		end,
		sv_effect = function(ply)
			ply:AddSanity(2)
			ply:SetHealth(math.Clamp(ply:Health() + 15, 0, ply:GetMaxHealth()))
			if ply.br_isBleeding == true then
				ply.br_isBleeding = false
			end
		end
	},
	bruise_pack = {
		name = "Bruise Pack",
		def_amount = 3,
		amount = 3,
		cl_effect = function(self)
			net.Start("br_use_medkit_item")
				net.WriteString("bruise_pack")
			net.SendToServer()

			self.Contents.bruise_pack.amount = self.Contents.bruise_pack.amount - 1
			if self.Contents.bruise_pack.amount < 1 then
				self.Contents.bruise_pack = nil
				if table.Count(self.Contents) > 0 then
					self:CreateFrame()
				end
			end
		end,
		sv_effect = function(ply)
			ply:AddSanity(5)
			ply:SetHealth(math.Clamp(ply:Health() + 30, 0, ply:GetMaxHealth()))
		end
	},
	ointment = {
		name = "Ointment",
		def_amount = 2,
		amount = 2,
		cl_effect = function(self)
			net.Start("br_use_medkit_item")
				net.WriteString("ointment")
			net.SendToServer()

			self.Contents.ointment.amount = self.Contents.ointment.amount - 1
			if self.Contents.ointment.amount < 1 then
				self.Contents.ointment = nil
				if table.Count(self.Contents) > 0 then
					self:CreateFrame()
				end
			end
		end,
		sv_effect = function(ply)
			ply:AddSanity(5)
			ply:SetHealth(math.Clamp(ply:Health() + 10, 0, ply:GetMaxHealth()))
			ply:Extinguish()
		end
	},
	blood_bag = {
		name = "Blood Bag",
		def_amount = 2,
		amount = 2,
		cl_effect = function(self)
			net.Start("br_use_medkit_item")
				net.WriteString("blood_bag")
			net.SendToServer()

			self.Contents.blood_bag.amount = self.Contents.blood_bag.amount - 1
			if self.Contents.blood_bag.amount < 1 then
				self.Contents.blood_bag = nil
				if table.Count(self.Contents) > 0 then
					self:CreateFrame()
				end
			end
		end,
		sv_effect = function(ply)
			ply:AddSanity(5)
			ply:SetHealth(math.Clamp(ply:Health() + 50, 0, ply:GetMaxHealth()))
		end
	},
}

function SWEP:CreateFrame()
	local font_structure = {
		font = "Tahoma",
		extended = false,
		size = 20,
		weight = 2000,
		blursize = 0,
		scanlines = 0,
		antialias = true,
		underline = false,
		italic = false,
		strikeout = false,
		symbol = false,
		rotary = false,
		shadow = true,
		additive = false,
		outline = false,
	}
	surface.CreateFont("BR_MEDKIT_TITLE", font_structure)
	font_structure.size = 26
	surface.CreateFont("BR_MEDKIT_CONTENT_NAME", font_structure)
	font_structure.size = 14
	surface.CreateFont("BR_MEDKIT_CONTENT_AMOUNT", font_structure)
	font_structure.size = 22
	surface.CreateFont("BR_MEDKIT_CONTENT_USE", font_structure)
	if IsValid(WeaponFrame) then
		WeaponFrame:Remove()
	end
	WeaponFrame = vgui.Create("DFrame")
	WeaponFrame:SetSize(300, 400)
	WeaponFrame:SetTitle("")
	WeaponFrame.Paint = function(self, w, h)
		if IsValid(self) == false then
			return
		end
		--draw.RoundedBox(0, 0, 0, w, h, Color(150, 150, 150, 50))
		draw.Text({
			text = "PERSONAL MEDKIT",
			pos = {4, 4},
			xalign = TEXT_ALIGN_LEFT,
			yalign = TEXT_ALIGN_TOP,
			font = "BR_MEDKIT_TITLE",
			color = Color(255,255,255,255),
		})
		if input.IsKeyDown(KEY_ESCAPE) then
			self:KillFocus()
			self:Remove()
			gui.HideGameUI()
			return
		end
	end
	local last_y = 24
	for k,v in pairs(self.Contents) do
		local panel = vgui.Create("DPanel", WeaponFrame)
		panel:SetSize(300 - 8, 50 - 8)
		panel:SetPos(4, 4 + last_y)
		panel.Paint = function(self, w, h)
			draw.RoundedBox(0, 0, 0, w, h, Color(100, 100, 100, 100))
			draw.Text({
				text = v.name,
				pos = {4, 2},
				xalign = TEXT_ALIGN_LEFT,
				yalign = TEXT_ALIGN_TOP,
				font = "BR_MEDKIT_CONTENT_NAME",
				color = Color(255,255,255,255),
			})
			draw.Text({
				text = tostring(v.amount) .. " uses left",
				pos = {4, h - 2},
				xalign = TEXT_ALIGN_LEFT,
				yalign = TEXT_ALIGN_BOTTOM,
				font = "BR_MEDKIT_CONTENT_AMOUNT",
				color = Color(255,255,255,255),
			})
		end
		local panel2 = vgui.Create("DButton", panel)
		panel2:SetPos(300 - 50 - 0, 0)
		panel2:SetSize(50 - 8, 50 - 8)
		panel2:SetText("")
		panel2.Paint = function(self, w, h)
			draw.RoundedBox(0, 0, 0, w, h, Color(200, 200, 200, 100))
			draw.Text({
				text = "USE",
				pos = {w / 2, h / 2},
				xalign = TEXT_ALIGN_CENTER,
				yalign = TEXT_ALIGN_CENTER,
				font = "BR_MEDKIT_CONTENT_USE",
				color = Color(255,255,255,255),
			})
		end
		panel2.DoClick = function()
			v.cl_effect(self)
			surface.PlaySound("breach2/items/pickitem2.ogg")
		end
		last_y = last_y + (50 - 8) + 6
	end
	WeaponFrame:SetSize(300, last_y + 4)
	WeaponFrame:Center()
	WeaponFrame:MakePopup()
end

function SWEP:Holster()
	if CLIENT then
		if IsValid(WeaponFrame) then
			WeaponFrame:Remove()
		end
	end
	return true
end

function SWEP:OnRemove()
	if CLIENT then
		if IsValid(WeaponFrame) then
			WeaponFrame:Remove()
		end
	end
end

function SWEP:Deploy()
	self:SetHoldType(self.HoldType)
end

SWEP.BoneAttachment = "ValveBiped.Bip01_R_Hand"
SWEP.WorldModelPositionOffset = Vector(3, -2.5, 0)
SWEP.WorldModelAngleOffset = Angle(0, 30, -10)

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
	if CLIENT and LocalPlayer().br_role != "SCP-049" then
		self:CreateFrame()
	end
end

function SWEP:DrawHUD()
	if !BR2_ShouldDrawWeaponInfo() then return end

	draw.Text({
		text = "Primary attack opens the Medkit",
		pos = { ScrW() / 2, ScrH() - 6},
		font = "BR2_ItemFont",
		color = Color(255,255,255,80),
		xalign = TEXT_ALIGN_CENTER,
		yalign = TEXT_ALIGN_BOTTOM,
	})
end

function SWEP:GetBetterOne()
	if br_914status == SCP914_ROUGH then
		return table.Random({"syringe", "syringe", "ssri_pills"})

	elseif br_914status == SCP914_COARSE then
		return "personal_medkit"

	elseif br_914status == SCP914_1_1 then
		-- increase one, decrease other one
		local non_zero = {}

		for k,v in pairs(self.Contents) do
			if v.amount > 0 then
				table.ForceInsert(non_zero, v)
			end
		end

		if !table.Empty(non_zero) then
			local rnd_non_zero_one = table.Random(non_zero)
			local copytab = table.Copy(self.Contents)
			table.RemoveByValue(copytab, rnd_non_zero_one)

			local rnd_other_one = table.Random(copytab)
			
			rnd_non_zero_one.amount = rnd_non_zero_one.amount - 1
			rnd_other_one.amount = rnd_other_one.amount + 1
		end

		return self

	elseif br_914status == SCP914_FINE then
		for k,v in pairs(self.Contents) do
			v.amount = v.def_amount
		end

		return self

	elseif br_914status == SCP914_VERY_FINE then
		return "scp_500"
	end

	return self
end
