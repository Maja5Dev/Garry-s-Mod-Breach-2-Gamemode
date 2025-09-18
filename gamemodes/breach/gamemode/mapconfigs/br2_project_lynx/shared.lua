
BR_MAP_NAME = "br2_project_lynx"

MAPCONFIG.EnableGamemodeMusic = true
MAPCONFIG.EnableAmbientSounds = true
MAPCONFIG.GeneralAmbientSounds = BR_DEFAULT_AMBIENT_GENERAL
MAPCONFIG.CommotionSounds = BR_DEFAULT_COMMOTION_SOUNDS

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
