
include("map_related/cameras.lua")
include("map_related/codes.lua")
include("map_related/generators.lua")
include("map_related/hiding_closets.lua")
include("map_related/items.lua")
include("map_related/keypads.lua")
include("map_related/outfitters.lua")
include("map_related/ragdolls.lua")
include("map_related/scp_914.lua")
include("map_related/terminals.lua")

function Breach_FixMapHDRBrightness()
	for k,v in pairs(ents.FindByClass("env_tonemap_controller")) do
		v:Fire("UseDefaultAutoExposure", "0", 0)
		v:Fire("SetAutoExposureMin", "0.5", 0)
		v:Fire("SetAutoExposureMax", "1", 0)
	end
end

print("[Breach2] server/sv_maprelated.lua loaded!")
