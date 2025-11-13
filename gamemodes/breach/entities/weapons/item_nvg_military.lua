
SWEP.Base			= "item_nvg_base"
SWEP.PrintName		= "Military NVG"

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

function SWEP:NVGSettings()
	return {
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
end

function SWEP:GetBetterOne()
	if br_914status == SCP914_ROUGH or br_914status == SCP914_COARSE then
		return "item_nvg"
	end

	return table.Random({"item_nvg2", "item_nvg3"})
end


if SERVER then
	util.AddNetworkString("br_send_nvg_zone_display")

	SWEP.next_player_update = 0

	function SWEP:GlobalThink()
		if self.BaseClass.GlobalThink then
			self.BaseClass.GlobalThink(self)
		end

		if self.Enabled and self.next_player_update < CurTime() then
			self:GetPlayersToDisplay()
			self.next_player_update = CurTime() + 4
		end
	end

	function SWEP:GetPlayersToDisplay()
		local tab = {}

		for k,v in pairs(player.GetAll()) do
			local zone = v:GetZone()

			if zone and zone.name then
				local zone_name = zone.name
				if tab[zone_name] == nil then
					tab[zone_name] = 0
				end

				tab[zone_name] = tab[zone_name] + 1
			end
		end

		net.Start("br_send_nvg_zone_display")
			net.WriteTable(tab)
		net.Send(self.Owner)
	end
end

if CLIENT then
	SWEP.PlayersToDisplay = {}

	net.Receive("br_send_nvg_zone_display", function(len)
		local tab = net.ReadTable()
		local wep = LocalPlayer():GetWeapon("item_nvg_military")

		if IsValid(wep) then
			wep.PlayersToDisplay = tab
		end
	end)

	function SWEP:CreateFonts()
		local size_mul = ScrH() / 1080

		local font_structure = {
			font = "Tahoma",
			extended = false,
			size = 35 * size_mul,
			weight = 1000,
			blursize = 1,
			scanlines = 2,
			antialias = true,
			underline = false,
			italic = false,
			strikeout = false,
			symbol = false,
			rotary = false,
			shadow = false,
			additive = true,
			outline = false,
		}
		surface.CreateFont("BR_NVGMILITARY_MAIN", font_structure)
		font_structure.size = 30 * size_mul
		surface.CreateFont("BR_NVGMILITARY_SMALL", font_structure)
	end

	function SWEP:Deploy()
		self.BaseClass.Deploy(self)

		self:CreateFonts()
	end

	function SWEP:GlobalDraw()
		self.BaseClass.GlobalDraw(self)

		if self.Enabled then
			surface.SetFont("BR_NVGMILITARY_MAIN")
			local textw, texth = surface.GetTextSize("Motion detected in areas:")
			local numw, numh = surface.GetTextSize("99")

			draw.Text({
				text = "Motion detected in areas:",
				pos = {ScrW() - 12, numh},
				xalign = TEXT_ALIGN_RIGHT,
				yalign = TEXT_ALIGN_CENTER,
				font = "BR_NVGMILITARY_MAIN",
				color = Color(255,255,255,180),
			})

			local i = 1
			for k,v in pairs(self.PlayersToDisplay) do
				draw.Text({
					text = k,
					pos = {ScrW() - numw, numh + (i * texth)},
					xalign = TEXT_ALIGN_RIGHT,
					yalign = TEXT_ALIGN_CENTER,
					font = "BR_NVGMILITARY_SMALL",
					color = Color(255,255,255,180),
				})

				draw.Text({
					text = v,
					pos = {ScrW() - 12, numh + (i * texth)},
					xalign = TEXT_ALIGN_RIGHT,
					yalign = TEXT_ALIGN_CENTER,
					font = "BR_NVGMILITARY_SMALL",
					color = Color(255,255,255,180),
				})

				i = i + 1
			end
		end
	end
end
