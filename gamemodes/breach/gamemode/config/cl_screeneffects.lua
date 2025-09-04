
BR_SCP_049_NVG = {
	contrast = 2,
	colour = 1,
	brightness = 0,
	clr_r = 1,
	clr_g = 0,
	clr_b = 0,
	add_r = 0.1,
	add_g = 0,
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
		render.FogEnd(FOG_LEVEL * 1.5)
		render.FogColor(0, 1, 0)
		render.FogMaxDensity(1)
		render.FogMode(MATERIAL_FOG_LINEAR)
		return true
	end
}

BR_INSANITY_NVG = {
	contrast = 2,
	colour = 0.5,
	brightness = -0.1,
	clr_r = 0.5,
	clr_g = 0.5,
	clr_b = 1,
	add_r = 0,
	add_g = 0,
	add_b = 0.1,
	vignette_alpha = 255,
	draw_nvg = false,
	effect = function(nvg, tab)
		DrawMotionBlur(0.2, 0.8, 0.01)

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
		render.FogEnd(FOG_LEVEL * 0.75)
		render.FogColor(0.5, 0.5, 1)
		render.FogMaxDensity(1)
		render.FogMode(MATERIAL_FOG_LINEAR)
		return true
	end
}

print("[Breach2] config/cl_screeneffects.lua loaded!")