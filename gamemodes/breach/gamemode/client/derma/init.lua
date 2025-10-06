
include("menu_firstrole.lua")
include("menu_identify.lua")
include("menu_info.lua")
include("menu_items.lua")
include("menu_notepad.lua")
include("menu_support_spawns.lua")

include("menu_terminal_cameras.lua") -- needs to be before menu_terminal_infosets
include("menu_terminal_infosets.lua")

include("menu_terminal_access.lua")
include("menu_terminal_loading.lua")
include("menu_terminal_starting.lua")
include("menu_terminal.lua")

function BR_GetAllMenus()
	return {
		br_our_mtf_frame,
		info_menu_1_frame,
		info_menus_panel,
		cameras_frame,
		terminal_frame,
		access_terminal,
		loading_terminal,
		WeaponFrame,
		keypad_frame,
		BR_Looting_Menu,
		BR_Identifying_Menu,
		frame_294,
		frame_document,
		nvg_settings_menu,
		BR_SupportSpawns,
		BR_Scoreboard,
		BR_Scoreboard_Missions
	}
end

function BR_ClearMenus()
	for k,v in pairs(BR_GetAllMenus()) do
		if IsValid(v) then
			v:Remove()
		end
	end
end

function BR_AnyMenusOn()
	for k,v in pairs(BR_GetAllMenus()) do
		if IsValid(v) then
			return true
		end
	end
	return false
end
