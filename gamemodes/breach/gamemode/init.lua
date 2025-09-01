
AddCSLuaFile("shared/sh_server_specific.lua") -- enums of server-related things, top priority
AddCSLuaFile("shared/sh_npcs.lua") -- enums of NPC-related things, top priority
AddCSLuaFile("shared/sh_enums.lua") -- just all the enums, top priority
AddCSLuaFile("shared/sh_outfits.lua") -- contains just the table of outfits, top priority
AddCSLuaFile("shared/sh_documents.lua") -- table of documents, top priority
AddCSLuaFile("shared/sh_player_damage.lua") -- table containing missions, top priority
AddCSLuaFile("shared/sh_missions.lua") -- used in cl_menu.lua

AddCSLuaFile("shared/sh_cvars.lua") -- used in sv_round.lua, sh_player_damage.lua, sv_player.lua, sv_sanity.lua, sv_networking.lua, sv_temperature.lua, sv_functions_organise.lua
AddCSLuaFile("shared/sh_util.lua") -- things used in sv_round.lua, sv_sanity.lua, sv_player_meta.lua and br_hands.lua
AddCSLuaFile("shared/sh_player_meta.lua") -- low priority
AddCSLuaFile("shared.lua")

AddCSLuaFile("shared/sh_maprelated.lua")
AddCSLuaFile("client/cl_maprelated.lua")

AddCSLuaFile("mapconfigs/"..game.GetMap().."/cl_init.lua")
AddCSLuaFile("mapconfigs/"..game.GetMap().."/shared.lua")

AddCSLuaFile("client/cl_fonts.lua") -- need to be loaded before any UI files
AddCSLuaFile("client/cl_sanity.lua") -- functions that are ran by the server, any priority but should be before cl_networking.lua
AddCSLuaFile("client/cl_footsteps.lua")
AddCSLuaFile("client/cl_calcview.lua")

AddCSLuaFile("client/cl_music.lua") -- music and sound related things, doesnt need to be loaded super quickly because functions are used only after-round

/* OTHER HUD */
AddCSLuaFile("client/cl_chat.lua") -- all chat stuff, any load order

/* HUD */
AddCSLuaFile("client/hud/hud_blinking.lua")
AddCSLuaFile("client/hud/hud_buttons.lua")
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
AddCSLuaFile("client/hud/hud_screen_effects.lua")
AddCSLuaFile("client/hud/init.lua")

/* DERMA */
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
AddCSLuaFile("client/cl_networking.lua") -- quite a lot of things, low priority
AddCSLuaFile("client/cl_binds.lua")
AddCSLuaFile("client/cl_fog.lua")

AddCSLuaFile("client/cl_tick.lua")

AddCSLuaFile("cl_init.lua")




include("shared.lua")

include("config/sv_names.lua") -- config for names
include("config/sv_weapon_sets.lua") -- config for weapon sets

include("server/sv_names.lua") -- has to be before sv_scenarios, top priority
include("server/sv_scenarios.lua") -- table of scenarios, top priority
include("server/sv_items.lua") -- table of items, top priority
include("server/sv_notepad_system.lua") -- notepad_system table, top priority
include("server/sv_misc.lua") -- misc functions, top priority

include("server/player_related/init.lua") -- loads many files, functions assigned to player_meta, high priority

include("server/sv_round.lua") -- round_system things, pretty high priority
include("server/sv_corpses.lua") -- corpse functions used in player.lua and player_meta.lua, high priority
include("server/assigning/sv_assigning.lua") -- assigning functions, high priority

include("shared/sh_maprelated.lua")
include("server/sv_maprelated.lua") -- load before map configs

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