
function MakeFOG()
	if primary_lights_on or BR_WATCHING_CAMERAS then return false end
	
	if IsValid(horror_scp_ent) and horror_scp_ent.isEnding > 0 then
		render.FogStart(0)
		render.FogEnd(250)
		render.FogColor(255, 0, 0)
		render.FogMaxDensity(1)
		render.FogMode(MATERIAL_FOG_LINEAR)
		return true
	end

	local nvg = nil
	for k,v in pairs(LocalPlayer():GetWeapons()) do
		if istable(v.NVG) then
			if v.Enabled == true and (!isnumber(v.BatteryLevel) or v.BatteryLevel > 0) then
				nvg = v.NVG
				return nvg.fog()
			end
		end
	end

	render.FogStart(0)
	local sanity_fog = (FOG_LEVEL / 2) * (1 - (br2_our_sanity2 / 100))
	render.FogEnd(FOG_LEVEL - sanity_fog)
	render.FogColor(0, 0, 0)
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
