
SWEP.Base			= "br2_item_base"
SWEP.PrintName		= "Military NVG"
SWEP.Spawnable		= true
SWEP.AdminSpawnable	= true
SWEP.Category		= "Breach 2"
SWEP.Slot			= 7
SWEP.SlotPos		= 0
SWEP.clevel			= 0
SWEP.Pickupable 	= true

SWEP.BatteryLevel = math.random(40,100)
SWEP.BatterySpeed = 6

SWEP.ViewModel		= "models/cultist/items/nightvision/v_night_vision.mdl"
SWEP.WorldModel		= "models/cultist/items/nightvision/w_nvg_forface.mdl"
SWEP.UseHands = true
SWEP.HoldType		= "normal"

SWEP.BoneAttachment = "ValveBiped.Bip01_R_Hand"
SWEP.WorldModelPositionOffset = Vector(5, 0, -3)
SWEP.WorldModelAngleOffset = Angle(0, 180, 0)

function SWEP:SaveVariablesTo(ent)
	ent.BatteryLevel = self.BatteryLevel
end

SWEP.NextBatteryCheck = 0
function SWEP:Think()
	if self.IsEnabling and self.NextON < CurTime() then
		self:NV_ON()
	end

	if SERVER then
		if self.NextBatteryCheck < CurTime() then
			if self.Enabled then
				self.BatteryLevel = self.BatteryLevel - 1
				if self.BatteryLevel < 1 then self.BatteryLevel = 0 end
			end
			self.NextBatteryCheck = CurTime() + self.BatterySpeed
			net.Start("br_updatebattery")
				net.WriteInt(self.BatteryLevel, 8)
				net.WriteInt(self.Slot, 8)
			net.Send(self.Owner)
		end
		return
	end
end

function SWEP:Deploy()
	self:SetHoldType(self.HoldType)
	self.Owner:DrawViewModel(!self.Enabled)

	if IsFirstTimePredicted() then
		if CLIENT then
			surface.PlaySound("breach2/items/pickitem2.ogg")
		end
		self.Weapon:SendWeaponAnim(ACT_VM_DEPLOY)
	end

	self.NextBatteryCheck = 0
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

SWEP.Enabled = false
SWEP.DefaultNVG = {
	contrast = 2,
	colour = 0.2,
	brightness = -0.2,

	clr_r = 1,
	clr_g = 1,
	clr_b = 1,

	add_r = 0.2,
	add_g = 0.2,
	add_b = 0.2,

	vignette_alpha = 255,
	draw_nvg = true,
	effect = function(nvg, tab)
		--         Darken, Multiply, SizeX, SizeY, Passes, ColorMultiply, Red, Green, Blue
		DrawBloom(0,      1,        1,     1,     1,      1,            1,   1,     1)

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
		render.FogEnd((FOG_LEVEL * fog_mul) * 2)
		render.FogColor(25, 25, 25)
		render.FogMaxDensity(1)
		render.FogMode(MATERIAL_FOG_LINEAR)
		return true
	end
}
SWEP.NVG = table.Copy(SWEP.DefaultNVG)

SWEP.NextON = 0
SWEP.IsEnabling = false
function SWEP:NV_ON()
	self.Enabled = true
	self.IsEnabling = false
	self.NextON = 0
	self.Owner:DrawViewModel(false)

	if CLIENT then
		if self.BatteryLevel < 1 then
			surface.PlaySound("breach2/items/nvg_off.wav")
		else
			surface.PlaySound("breach2/items/nvg_on.wav")
		end
	end
end

function SWEP:NV_OFF()
	self.Enabled = false
	self.Owner:DrawViewModel(true)
	self.IsEnabling = false

	if CLIENT then
		if self.BatteryLevel < 1 then
			surface.PlaySound("breach2/items/nvg_off.wav")
		else
			surface.PlaySound("breach2/items/nvg_ins_off.wav")
		end
	end
end

SWEP.NextChange = 0
function SWEP:PrimaryAttack()
	if !IsFirstTimePredicted() then return end

	if self.NextChange < CurTime() then
		if self.Enabled == false then
			self.NextON = CurTime() + 1.2
			self.IsEnabling = true

			self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
		else
			self:NV_OFF()
			self:SendWeaponAnim(ACT_VM_SECONDARYATTACK)
		end

		self.NextChange = CurTime() + 1.5
	end
end

function SWEP:Holster(wep)
	if !IsFirstTimePredicted() then return end

	return !self.IsEnabling
end

SWEP.DLightLevel = 0
SWEP.NextSettingsChange = 0
function SWEP:SecondaryAttack()
	if CLIENT then
		if self.NextSettingsChange < CurTime() then

			if IsValid(nvg_settings_menu) then
				nvg_settings_menu:Remove()
			end

			local size_mul = math.Clamp(ScrH() / 1080, 0.1, 1)

			local info_menu_exit_size_o = 32
			local info_menu_exit_size = info_menu_exit_size_o * size_mul

			local font_info = {
				font = "Tahoma",
				extended = false,
				size = (info_menu_exit_size_o * 0.75) * size_mul,
				weight = 1000,
				blursize = 0,
				scanlines = 0,
				antialias = true,
				underline = false,
				italic = false,
				strikeout = false,
				symbol = false,
				rotary = false,
				shadow = false,
				additive = false,
				outline = false,
			}
		
			font_info.size = (info_menu_exit_size_o * 0.75) * size_mul
			surface.CreateFont("BR_NVG_SETTINGS_1", font_info)

			font_info.size = (info_menu_exit_size_o * 1) * size_mul
			surface.CreateFont("BR_NVG_SETTINGS_2", font_info)
		
			local all_nvg_setting_panels = {}

			local nvg_settings = {
				/*
				{"Reset", "func", function()
					self.NVG = table.Copy(self.DefaultNVG)
					for k,v in pairs(all_nvg_setting_panels) do
						if v.settings[2] == "slider" then
							v.num_slider:SetValue(v.settings[3][4])
						end
					end
				end},
				*/
				{"Contrast", "slider", {self.NVG.contrast, 0.5, 5, 2}, function(value) self.NVG.contrast = value end},
				--{"Color", "slider", {self.NVG.colour, 0, 5, 0.2}, function(value) self.NVG.colour = value self.NVG.colour = value end},
				{"Red", "slider", {self.NVG.add_r, 0, 2, 0.2}, function(value) self.NVG.add_r = value end},
				{"Green", "slider", {self.NVG.add_g, 0, 2, 0.2}, function(value) self.NVG.add_g = value end},
				{"Blue", "slider", {self.NVG.add_b, 0, 2, 0.2}, function(value) self.NVG.add_b = value end},
				{"Brightness", "slider", {self.NVG.brightness, -1, 0, -0.2}, function(value) self.NVG.brightness = value end},
				{"Light", "slider", {self.DLightLevel, 0, 5, 0}, function(value) self.DLightLevel = value end},
			}

			local im1s = 8 * size_mul

			local nvg_w = 400
			local nvg_h = 200


			local nvg_settings_panel_size = 40 * size_mul

			nvg_settings_menu = vgui.Create("DFrame")
			nvg_settings_menu:SetDeleteOnClose(false)
			nvg_settings_menu:SetSizable(false)
			nvg_settings_menu:SetDraggable(true)
			nvg_settings_menu:SetTitle("")
			nvg_settings_menu:ShowCloseButton(false)
			nvg_settings_menu:MakePopup()
			nvg_settings_menu.Paint = function(self, w, h)
				if !IsValid(self) then
					nvg_settings_menu:Remove()
					return
				end
				draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 150))
				draw.RoundedBox(0, 0, 0, w, info_menu_exit_size, Color(0, 0, 0, 200))

				draw.Text({
					text = "NVG Settings",
					pos = {im1s, (info_menu_exit_size_o / 2) * size_mul},
					xalign = TEXT_ALIGN_LEFT,
					yalign = TEXT_ALIGN_CENTER,
					font = "BR_NVG_SETTINGS_1",
					color = Color(255,255,255,200),
				})

				if input.IsKeyDown(KEY_ESCAPE) then
					gui.HideGameUI()
					nvg_settings_menu:Close()
					gui.HideGameUI()
				end
			end

			local last_y = info_menu_exit_size + im1s

			for k,v in pairs(nvg_settings) do
				local size_w = nvg_w - (im1s * 2)
				local size_h = nvg_settings_panel_size

				local name_w = 120 * size_mul

				local sl_w = 12
				local sl_h = 22

				local nvg_settings_panel = vgui.Create("DPanel", nvg_settings_menu)
				nvg_settings_panel:SetPos(im1s, last_y)
				nvg_settings_panel:SetSize(size_w, size_h)
				nvg_settings_panel.Paint = function(self, w, h)
					draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 150))

					draw.Text({
						text = v[1],
						pos = {im1s, h / 2},
						xalign = TEXT_ALIGN_LEFT,
						yalign = TEXT_ALIGN_CENTER,
						font = "BR_NVG_SETTINGS_1",
						color = Color(255,255,255,200),
					})
				end

				if v[2] == "slider" then
					local num_slider = vgui.Create("DNumSlider", nvg_settings_panel)
					nvg_settings_panel.num_slider = num_slider
					num_slider:SetPos(name_w, 0)
					num_slider:SetSize(size_w - name_w, size_h)
					num_slider:SetText("Maximum props")
					num_slider:SetMin(v[3][2])
					num_slider:SetMax(v[3][3])
					num_slider:SetDecimals(0)
					num_slider:SetValue(v[3][1])

					local perc = (v[3][4] - v[3][2]) / (v[3][3] - v[3][2])
					local knob2_pos = ((size_w - name_w) - sl_w) * perc
					num_slider.Slider.Paint = function(self, w, h)
						surface.SetDrawColor(Color(255, 255, 255, 100))
						surface.DrawRect(8, h / 2 - 1, w - 15, 4)
						draw.RoundedBox(0, knob2_pos, 9 * size_mul, sl_w, sl_h, Color(150, 150, 150, 175))
					end

					num_slider.Slider.Knob:SetSize(sl_w, sl_h)
					num_slider.Slider.Knob.Paint = function(self, w, h)
						draw.RoundedBox(0, 0, 0, w, h, Color(255, 255, 255, 255))
						--surface.SetDrawColor(Color(255, 255, 255, 100))
						--surface.DrawRect(8, h / 2 - 1, w - 15, 5)
					end

					num_slider.PerformLayout = function(self)
						self.Scratch:SetVisible(false)
						self.Label:SetVisible(false)
						self.TextArea:SetVisible(false)
					
						self.Slider:StretchToParent(0, 0, 0, 0)
						self.Slider:SetSlideX(self.Scratch:GetFraction())
					end

					num_slider.Scratch.OnValueChanged = function()
						--num_slider:ValueChanged(num_slider.Scratch:GetFloatValue())
						v[4](num_slider.Scratch:GetFloatValue())
					end
				elseif v[2] == "func" then
					local button = vgui.Create("DButton", nvg_settings_panel)
					button:SetPos(name_w, 0)
					button:SetSize(size_w - name_w, size_h)
					button:SetText("")
					button.Paint = function(self, w, h)
						draw.RoundedBox(0, 0, 0, w, h, Color(255, 255, 255, 150))
					end
					button.DoClick = function()
						v[3]()
					end
				end

				nvg_settings_panel.settings = v
				table.ForceInsert(all_nvg_setting_panels, nvg_settings_panel)

				last_y = last_y + nvg_settings_panel_size + im1s
			end
			nvg_settings_menu:SetSize(nvg_w, last_y)
			nvg_settings_menu:Center()

			nvg_settings_exit = vgui.Create("DImageButton", nvg_settings_menu)
			nvg_settings_exit:SetSize(info_menu_exit_size, info_menu_exit_size)
			nvg_settings_exit:SetPos(nvg_w - info_menu_exit_size, 0)
			nvg_settings_exit:SetText("")
			nvg_settings_exit:SetColor(Color(255,255,255,200))
			nvg_settings_exit:SetImage("breach2/br2_xmark.png")
			nvg_settings_exit.DoClick = function()
				nvg_settings_menu:Remove()
			end

			local nvg_reset_w = 80 * size_mul

			nvg_settings_reset = vgui.Create("DImageButton", nvg_settings_menu)
			nvg_settings_reset:SetSize(nvg_reset_w, info_menu_exit_size)
			nvg_settings_reset:SetPos(nvg_w - info_menu_exit_size - nvg_reset_w - (32 * size_mul), 0)
			nvg_settings_reset:SetText("")
			nvg_settings_reset.Paint = function(self, w, h)
				draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 150))
				draw.Text({
					text = "Reset",
					pos = {w / 2, h / 2},
					xalign = TEXT_ALIGN_CENTER,
					yalign = TEXT_ALIGN_CENTER,
					font = "BR_NVG_SETTINGS_1",
					color = Color(255,255,255,220),
				})
			end
			nvg_settings_reset.DoClick = function()
				self.NVG = table.Copy(self.DefaultNVG)
				for k,v in pairs(all_nvg_setting_panels) do
					if v.settings[2] == "slider" then
						v.num_slider:SetValue(v.settings[3][4])
					end
				end
			end

			self.NextSettingsChange = CurTime() + 1
		end
	end
end

SWEP.Dlight = nil
function SWEP:DrawHUD()
	/*
	if self.DLightLevel > 0.1 and self.Enabled then
		self.Dlight = DynamicLight(LocalPlayer():EntIndex())
		self.Dlight.pos = LocalPlayer():GetShootPos()
		self.Dlight.r = 255
		self.Dlight.g = 255
		self.Dlight.b = 255
		self.Dlight.brightness = self.DLightLevel
		self.Dlight.Decay = 1000
		self.Dlight.Size = 512
		self.Dlight.DieTime = CurTime() + 1
	else
		if self.Dlight then
			self.Dlight = nil
		end
	end
	*/

	draw.Text({
		text = tostring(self.BatteryLevel).."%",
		pos = {4, 4},
		font = "BR2_ItemFont",
		color = Color(255,255,255,80),
		xalign = TEXT_ALIGN_LEFT,
		yalign = TEXT_ALIGN_TOP,
	})

	if !BR2_ShouldDrawWeaponInfo() then return end
	if self.Enabled == false then
		draw.Text({
			text = "Primary attack puts on the NVG, secondary opens settings",
			pos = {ScrW() / 2, ScrH() - 6},
			font = "BR2_ItemFont",
			color = Color(255,255,255,80),
			xalign = TEXT_ALIGN_CENTER,
			yalign = TEXT_ALIGN_BOTTOM,
		})
	end
end

function SWEP:GetBetterOne()
	if br_914status == SCP914_ROUGH or br_914status == SCP914_COARSE then
		return "item_nvg"
	end

	return table.Random({"item_nvg2", "item_nvg3"})
end
