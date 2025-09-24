
include("config/sv_workshop_addons.lua") -- Load addons for the clients to download on the server

AddCSLuaFile("client/cl_light_level.lua") -- just contains functions
AddCSLuaFile("config/sv_assigning.lua") -- config for assigning, top priority
AddCSLuaFile("config/sh_weapons.lua") -- config for weapons, top priority
AddCSLuaFile("config/sh_server_specific.lua") -- enums of server-related things, top priority
AddCSLuaFile("config/sh_scps.lua") -- enums of SCP-related things, top priority
AddCSLuaFile("shared/sh_enums.lua") -- just all the enums, top priority
AddCSLuaFile("config/sh_enums.lua") -- after shared/sh_enums.lua
AddCSLuaFile("config/sh_outfits.lua") -- contains just the table of outfits, top priority
AddCSLuaFile("shared/sh_documents.lua") -- table of documents, top priority
AddCSLuaFile("shared/sh_player_damage.lua") -- table containing missions, top priority
AddCSLuaFile("config/cl_items.lua") -- used in br_hands swep, menu_items.lua, only tables
AddCSLuaFile("config/cl_roles.lua") -- used in menu_notepad.lua, hud_scoreboard.lua, only tables

AddCSLuaFile("shared/sh_cvars.lua") -- used in sv_round.lua, sh_player_damage.lua, sv_player.lua, sv_sanity.lua, sv_networking.lua, sv_temperature.lua, sv_functions_organise.lua
AddCSLuaFile("config/sh_cvars.lua") -- after shared/sh_cvars.lua
AddCSLuaFile("shared/sh_util.lua") -- things used in sv_round.lua, sv_sanity.lua, sv_player_meta.lua and br_hands.lua
AddCSLuaFile("shared/sh_player_meta.lua") -- low priority
AddCSLuaFile("shared.lua")

AddCSLuaFile("config/sh_sounds.lua") -- needs to be before cl_music.lua and map files
AddCSLuaFile("shared/sh_maprelated.lua")
AddCSLuaFile("client/cl_maprelated.lua")

AddCSLuaFile("mapconfigs/"..game.GetMap().."/cl_init.lua")
AddCSLuaFile("mapconfigs/"..game.GetMap().."/shared.lua")

AddCSLuaFile("client/cl_fonts.lua") -- need to be loaded before any UI files
AddCSLuaFile("client/cl_sanity.lua") -- functions that are ran by the server, any priority but should be before networking
AddCSLuaFile("client/cl_footsteps.lua")
AddCSLuaFile("client/cl_calcview.lua")

AddCSLuaFile("client/cl_music.lua") -- music and sound related things, doesnt need to be loaded super quickly because functions are used only after-round

/* CLIENT NETWORKING */
AddCSLuaFile("client/networking/health.lua")
AddCSLuaFile("client/networking/info.lua")
AddCSLuaFile("client/networking/items.lua")
AddCSLuaFile("client/networking/player_actions.lua")
AddCSLuaFile("client/networking/player.lua")
AddCSLuaFile("client/networking/round.lua")
AddCSLuaFile("client/networking/scps.lua")
AddCSLuaFile("client/networking/sounds.lua")
AddCSLuaFile("client/networking/support_spawns.lua")
AddCSLuaFile("client/networking/terminal.lua")
AddCSLuaFile("client/networking/updates.lua")
AddCSLuaFile("client/networking/init.lua")

/* OTHER HUD */
AddCSLuaFile("client/cl_chat.lua") -- all chat stuff, any load order

/* HUD */
AddCSLuaFile("client/hud/hud_blinking.lua")
AddCSLuaFile("client/hud/hud_buttons.lua")
AddCSLuaFile("client/hud/hud_scp_actions.lua")
AddCSLuaFile("client/hud/hud_debug.lua")
AddCSLuaFile("client/hud/hud_healing.lua")
AddCSLuaFile("client/hud/hud_hiding.lua")
AddCSLuaFile("client/hud/hud_progress.lua")
AddCSLuaFile("client/hud/hud_scoreboard.lua")
AddCSLuaFile("client/hud/hud_spectator.lua")
AddCSLuaFile("client/hud/hud_sprint.lua")
AddCSLuaFile("client/hud/hud_targetid.lua")
AddCSLuaFile("client/hud/hud_temperature.lua")
AddCSLuaFile("client/hud/hud_voice.lua")
AddCSLuaFile("client/hud/hud_wepswitch.lua")
AddCSLuaFile("client/hud/hud_overlay.lua")
AddCSLuaFile("client/hud/hud_notification.lua")
AddCSLuaFile("config/cl_screeneffects.lua")
AddCSLuaFile("client/hud/hud_screen_effects.lua")
AddCSLuaFile("client/hud/init.lua")

/* DERMA */
AddCSLuaFile("config/sh_missions.lua") -- these need to be before menu_firstrole
AddCSLuaFile("config/cl_starttexts.lua") -- these need to be before menu_firstrole
AddCSLuaFile("config/cl_firstrole.lua") -- these need to be before menu_firstrole

AddCSLuaFile("client/derma/menu_firstrole.lua")
AddCSLuaFile("client/derma/menu_identify.lua")
AddCSLuaFile("client/derma/menu_info.lua")
AddCSLuaFile("client/derma/menu_items.lua")
AddCSLuaFile("client/derma/menu_notepad.lua")
AddCSLuaFile("client/derma/menu_support_spawns.lua")
AddCSLuaFile("client/derma/menu_terminal_infosets.lua")
AddCSLuaFile("client/derma/menu_terminal_access.lua")
AddCSLuaFile("client/derma/menu_terminal_cameras.lua")
AddCSLuaFile("client/derma/menu_terminal_loading.lua")
AddCSLuaFile("client/derma/menu_terminal_starting.lua")
AddCSLuaFile("client/derma/menu_terminal.lua")
AddCSLuaFile("client/derma/init.lua")

AddCSLuaFile("client/cl_player.lua") -- player related overrides, low priority
AddCSLuaFile("client/cl_tfa_fixes.lua") -- very low priority
AddCSLuaFile("client/cl_binds.lua")
AddCSLuaFile("client/cl_fog.lua")

AddCSLuaFile("client/cl_tick.lua")

AddCSLuaFile("cl_init.lua")



-- SERVER
include("shared.lua")

include("config/sv_names.lua") -- config for names
include("config/sh_weapons.lua") -- config for weapons, top priority
include("config/sv_weapon_sets.lua") -- config for weapon sets
include("config/sh_scps.lua") -- enums of SCP-related things, top priority
include("config/sh_sounds.lua") -- needs to be before cl_music.lua and map files

include("server/sv_names.lua") -- has to be before sv_scenarios, top priority
include("server/sv_scenarios.lua") -- table of scenarios, top priority
include("server/sv_items.lua") -- table of items, top priority
include("server/sv_notepad_system.lua") -- notepad_system table, top priority
include("server/sv_misc.lua") -- misc functions, top priority
include("server/sv_logins.lua") -- top priority

include("server/player_related/init.lua") -- loads many files, functions assigned to player_meta, high priority

include("server/sv_round.lua") -- round_system things, pretty high priority
include("server/sv_corpses.lua") -- corpse functions used in player.lua and player_meta.lua, high priority
include("server/assigning/sv_assigning.lua") -- assigning functions, high priority

include("shared/sh_maprelated.lua")
include("server/sv_maprelated.lua") -- load before map configs

include("config/sv_npcs.lua") -- load before sv_npcs
include("server/sv_npcs.lua") -- load after map

include("mapconfigs/"..game.GetMap().."/init.lua")
include("mapconfigs/"..game.GetMap().."/shared.lua")

include("server/sv_player_speeds.lua") -- player speed calculating, low priority
include("server/sv_sanity.lua") -- sanity functions, low priority
include("server/sv_afk.lua") -- afk functions, low priority
include("server/sv_temperature.lua") -- temperature related functions, low priority
include("server/sv_stamina.lua") -- stamina functions, very low priority

include("server/networking/init.lua") -- loads many different networking related files, very low priority
include("server/overrides/init.lua") -- loads many files, gmod base gamemode overrides, very low priority
include("server/sv_player_tick.lua") -- player tick, very low priority
include("server/sv_debugging.lua") -- debugging stuff, very low priority

for i=1, 4 do
    util.PrecacheSound("player/ap_footsteps/ladder"..i..".wav")
end

/*
local function br2_init()
	local map = game.GetMap()
	include("mapconfigs/" .. map .. ".lua")
end
hook.Add("Initialize", "br2hook_init", init)
*/

print("[Breach2] init.lua loaded!")