
local next_lcz_check = 0
local is_in_lcz = false

function MakeFOG()
	if LocalPlayer():IsSpectator() then return false end

	if next_lcz_check < CurTime() then
		is_in_lcz = LocalPlayer():IsInLCZ()
		next_lcz_check = CurTime() + 1
	end

	-- LCZ decontamination fog override
	if is_in_lcz and decontamination_status == 2 then
		render.FogStart(0)
		render.FogEnd(450)
		render.FogColor(10, 50, 10)
		render.FogMaxDensity(1)
		render.FogMode(MATERIAL_FOG_LINEAR)
		return true	
	end

	if primary_lights_on or BR_WATCHING_CAMERAS then return false end
	
	if IsValid(horror_scp_ent) and horror_scp_ent.isEnding > 0 then
		render.FogStart(0)
		render.FogEnd(250)
		render.FogColor(255, 0, 0)
		render.FogMaxDensity(1)
		render.FogMode(MATERIAL_FOG_LINEAR)
		return true
	end

	local fog_color = Color(0,0,0)
	local fog_mul = 1

	local zone = LocalPlayer():GetZone()
	if zone then
		if !zone.fog_enabled then
			return true
		else
			if zone.fog_mul then
				fog_mul = zone.fog_mul
			end
			if zone.fog_color then
				fog_color = zone.fog_color
			end
		end
	end

	if br_our_custom_screen_effects and br_our_custom_screen_effects_for > CurTime() then
		if br_our_custom_screen_effects.fog_mul then
			fog_mul = fog_mul * br_our_custom_screen_effects.fog_mul
		end

		if br_our_custom_screen_effects.fog_color then
			fog_color = Color(
				(fog_color.r + br_our_custom_screen_effects.fog_color.r) / 2,
				(fog_color.g + br_our_custom_screen_effects.fog_color.g) / 2,
				(fog_color.b + br_our_custom_screen_effects.fog_color.b) / 2
			)
		end
	end

	local nvg = nil
	for k,v in pairs(LocalPlayer():GetWeapons()) do
		if istable(v.NVG) then
			if v.Enabled == true and (!isnumber(v.BatteryLevel) or v.BatteryLevel > 0) then
				nvg = v.NVG
				return nvg.fog(fog_mul)
			end
		end
	end

	render.FogStart(0)
	local sanity_fog = (FOG_LEVEL / 2) * (1 - (br2_our_sanity2 / 100))
	render.FogEnd((FOG_LEVEL * fog_mul) - sanity_fog)
	render.FogColor(fog_color.r, fog_color.g, fog_color.b)
	render.FogMaxDensity(1)
	render.FogMode(MATERIAL_FOG_LINEAR)
	return true
end

hook.Add("SetupWorldFog", "force_fog", function()
	return MakeFOG()
end)

hook.Add("SetupSkyboxFog", "force_fog_skybox", function()
	return MakeFOG()
end)

print("[Breach2] client/cl_fog.lua loaded!")
