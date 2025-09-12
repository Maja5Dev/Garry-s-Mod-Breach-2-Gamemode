
-- Workshop Items ( 1294932589 ) --

resource.AddWorkshop( '636790055' ) -- Viper's Operators Playermodels 'Remastered'
resource.AddWorkshop( '740748927' ) -- SCP Staff
resource.AddWorkshop( '925670022' ) -- SCP:CB Prop pack
resource.AddWorkshop( '1096295606' ) -- Emergency Medical Technician
resource.AddWorkshop( '470726908' ) -- CPTBase Redux
resource.AddWorkshop( '1769622426' ) -- Breach 2 Main Content
resource.AddWorkshop( '1769645400' ) -- Breach 2 Models Content
resource.AddWorkshop( '1769658985' ) -- Breach 2 Weapons Content 1
resource.AddWorkshop( '1769669658' ) -- Breach 2 Weapons Content 2
resource.AddWorkshop( '1770625922' ) -- Breach 2 Misc Content
resource.AddWorkshop( '1769636487' ) -- Breach 2 - Site 61 Content
resource.AddWorkshop( '3558703832' ) -- Breach 2 - Site 61
resource.AddWorkshop( '1422785065' ) -- SCP SNPCs
resource.AddWorkshop( '108024198' ) -- Food and Household items
resource.AddWorkshop( '2393452412' ) -- Improved Blood Textures
resource.AddWorkshop( '3558912930' ) -- Breach 2 TFA Additional Weapon Pack
resource.AddWorkshop( '3558913279' ) -- Breach 2 TFA Additional Weapon Pack (Content)
resource.AddWorkshop( '112806637' ) -- Gmod Legs 3
resource.AddWorkshop( '2840020970' ) -- TFA Base [ Reduxed ]
resource.AddWorkshop( '2841514992' ) -- [TFA] No More Room in Hell Melee SWEPs
resource.AddWorkshop( '1560118657' ) -- DrGBase | Nextbot Base
resource.AddWorkshop( '2454663404' ) -- SCP-096 SCP Ultimate Edition SNPCs [DRGBASE]
resource.AddWorkshop( '2456485899' ) -- SCP-999 NPC [DRGBASE]
resource.AddWorkshop( '2467124905' ) -- SCP-106 Ultimate Edition SNPC Pack [DRGBASE]
resource.AddWorkshop( '2473944610' ) -- SCPs SNPC COLLECTION [DRGBASE]
resource.AddWorkshop( '2462641819' ) -- SCP-1074,SCP-012 SCP NPC PACK [DRGBASE]
resource.AddWorkshop( '2479308133' ) -- SCP-457 SNPC [DRGBASE]
resource.AddWorkshop( '2478335876' ) -- SCPs NEXTBOTs COLLECTION PART2 [DRGBASE]
resource.AddWorkshop( '2539502855' ) -- SCP-610 "The Flesh That Hates" [REMASTERED] {DrGBase}
resource.AddWorkshop( '3422562362' ) -- SCP-106 Pocket Dimension [v2]
resource.AddWorkshop( '3430729756' ) -- DREAMS module (v1.1)
resource.AddWorkshop( '2455580712' ) -- SCP-049 Ultimate Edition SNPCs [DRGBASE]
resource.AddWorkshop( '2988173290' ) -- [DrGBase] SCP: Containment Breach NEXTBOTS

AddCSLuaFile("client/cl_light_level.lua") -- just contains functions
AddCSLuaFile("config/sv_assigning.lua") -- config for assigning, top priority
AddCSLuaFile("shared/sh_server_specific.lua") -- enums of server-related things, top priority
AddCSLuaFile("shared/sh_npcs.lua") -- enums of NPC-related things, top priority
AddCSLuaFile("shared/sh_enums.lua") -- just all the enums, top priority
AddCSLuaFile("config/sh_enums.lua") -- after shared/sh_enums.lua
AddCSLuaFile("config/sh_outfits.lua") -- contains just the table of outfits, top priority
AddCSLuaFile("shared/sh_documents.lua") -- table of documents, top priority
AddCSLuaFile("shared/sh_player_damage.lua") -- table containing missions, top priority

AddCSLuaFile("shared/sh_cvars.lua") -- used in sv_round.lua, sh_player_damage.lua, sv_player.lua, sv_sanity.lua, sv_networking.lua, sv_temperature.lua, sv_functions_organise.lua
AddCSLuaFile("config/sh_cvars.lua") -- after shared/sh_cvars.lua
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