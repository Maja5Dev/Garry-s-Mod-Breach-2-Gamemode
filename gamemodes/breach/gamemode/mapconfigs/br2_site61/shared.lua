
BR_MAP_NAME = "br2_site19_a6"

MAPCONFIG.EnableGamemodeMusic = true
MAPCONFIG.EnableAmbientSounds = true
MAPCONFIG.GeneralAmbientSounds = br_default_ambient_general
MAPCONFIG.CommotionSounds = BR_DEFAULT_CommotionSounds

MAPCONFIG.FirstSounds = {
	{"breach2/alarm/breach_alarm.ogg", 72},
}
MAPCONFIG.FirstSoundsLength = 72 -- length of all of FirstSounds in seconds

if SERVER then
	AddCSLuaFile("shared/buttons.lua")
	AddCSLuaFile("shared/zones.lua")
	AddCSLuaFile("shared/positions.lua")
end

if CLIENT then
	include("shared/buttons.lua")
	include("shared/zones.lua")
	include("shared/positions.lua")
else
	include("/shared/buttons.lua")
	include("/shared/zones.lua")
	include("/shared/positions.lua")
end

print("[Breach2] Shared mapconfig loaded!")
