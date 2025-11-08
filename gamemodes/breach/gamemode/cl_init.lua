

include("shared.lua")

include("shared/hands/hands.lua") -- register very early
include("client/cl_util.lua") -- just contains functions
include("client/cl_debug.lua") -- just contains functions
include("client/cl_light_level.lua") -- just contains functions
include("config/internal/sh_weapons.lua") -- config for weapons, top priority
include("config/internal/sh_sounds.lua") -- needs to be before cl_music.lua and map files
include("shared/sh_maprelated.lua")
include("client/cl_maprelated.lua")
include("mapconfigs/"..game.GetMap().."/cl_init.lua")
include("mapconfigs/"..game.GetMap().."/shared.lua")

include("client/cl_fonts.lua") -- need to be loaded before any UI files
include("client/cl_sanity.lua") -- functions that are ran by the server, any priority but should be before networking
include("client/cl_footsteps.lua")
include("client/cl_calcview.lua")
include("shared/sh_attachment_models.lua")
include("client/cl_attachment_models.lua")
include("config/internal/cl_items.lua") -- used in br_hands swep, menu_items.lua, only tables
include("config/internal/cl_roles.lua") -- used in menu_notepad.lua, hud_scoreboard.lua, only tables
include("config/internal/sh_scps.lua") -- enums of SCP-related things, top priority

include("client/cl_music.lua") -- music and sound related things, doesnt need to be loaded super quickly because functions are used only after-round

include("client/networking/init.lua") -- should be after sanity

/* DERMA MENUS */
include("config/internal/sh_missions.lua")-- these need to be before derma
include("config/internal/cl_firstrole.lua") -- these need to be before derma
include("config/internal/cl_starttexts.lua") -- these need to be before derma
include("client/derma/init.lua") -- loads many files

/* HUD */
include("config/internal/cl_screeneffects.lua") -- load before hud
include("client/cl_chat.lua") -- all chat stuff, any load order
include("client/hud/init.lua") -- loads many files

include("client/cl_player.lua") -- player related overrides, low priority
include("client/cl_tfa_fixes.lua") -- very low priority
include("client/cl_binds.lua") -- quite a lot of things, any load order
include("client/cl_fog.lua")

include("client/cl_tick.lua") -- lowest load order
include("config/internal/sh_scp294.lua") -- needs to be before cl_item_spawnmenu.lua
include("client/cl_item_spawnmenu.lua")
include("client/cl_decontamination.lua")

br2_last_death = -12
br2_last_escape = -12
BR_WATCHING_CAMERAS = false
starting_time = CurTime()

if BR2_OURNOTEPAD == nil then
	BR2_OURNOTEPAD = {}
	BR2_OURINFO = {}
end

game_state = GAMESTATE_NOTSTARTED
br2_round_state_end = 0
body_health = 0
last_health_check = 0
last_revive_check = 0
last_revive_time = 0
last_body = NULL
last_got_stunned = 0
BR2_HANDS_ACTIVE = false

surface.CreateFont("CSKillIcons", {
	font = "csd",
	size = 75,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	shadow = false,
	additive = true
})

sanity_alpha_delay = 0

primary_lights_on = false

print("[Breach2] cl_init.lua loaded!")