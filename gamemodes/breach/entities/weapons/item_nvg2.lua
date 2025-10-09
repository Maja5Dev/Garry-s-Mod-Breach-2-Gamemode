
SWEP.Base			= "item_nvg_base"
SWEP.PrintName		= "Red NVG"

SWEP.UsesBattery = false
SWEP.BatteryLevel = nil
SWEP.BatterySpeed = nil

function SWEP:SaveVariablesTo(ent)
end

function SWEP:Think()
	if self.IsEnabling and self.NextON < CurTime() then
		self:NV_ON()
	end
end

function SWEP:GlobalDraw()
end

function SWEP:Deploy()
	self.BaseClass.Deploy(self)
	self.BatteryLevel = nil
end

SWEP.Enabled = false
SWEP.DefaultNVG = {
	contrast = 2.5,
	colour = 0,
	brightness = -0.2,
	clr_r = 1,
	clr_g = 0,
	clr_b = 0,
	add_r = 0.2,
	add_g = 0,
	add_b = 0,
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
		render.FogEnd((FOG_LEVEL * fog_mul) * 1.75)
		render.FogColor(2, 1, 1)
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

	if SERVER then
		self.Owner:EmitSound("breach2/items/nvg_on.wav")
	end
end

function SWEP:NV_OFF()
	self.Enabled = false
	self.Owner:DrawViewModel(true)
	self.IsEnabling = false

	if SERVER then
		self.Owner:EmitSound("breach2/items/nvg_ins_off.wav")
	end
end

function SWEP:NVGSettings()
	return {
		{"Contrast", "slider", {self.NVG.contrast, 0.5, 5, 2.5}, function(value) self.NVG.contrast = value end},
		{"Color", "slider", {self.NVG.add_r, 0.2, 2, 0.2}, function(value) self.NVG.add_r = value end},
		{"Brightness", "slider", {self.NVG.brightness, -1, 0, -0.2}, function(value) self.NVG.brightness = value end},
		{"Light", "slider", {self.DLightLevel, 0, 5, 0}, function(value) self.DLightLevel = value end},
	}
end

function SWEP:GetBetterOne()
	if br_914status == SCP914_ROUGH or br_914status == SCP914_COARSE then
		return "item_nvg"

	elseif br_914status == SCP914_FINE then
		return "item_nvg_military"

	elseif br_914status == SCP914_VERY_FINE then
		return "item_nvg3"
	end

	return self
end
