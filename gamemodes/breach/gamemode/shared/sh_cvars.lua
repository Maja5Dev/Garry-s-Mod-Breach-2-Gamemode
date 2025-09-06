
local all_br2_cvars = {}

local function br2_add_cvar(name, value, helptext)
	--if !ConVarExists(name) then CreateConVar(name, value, {FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_NOTIFY}, helptext) end
	CreateConVar(name, value, {FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_NOTIFY}, helptext)
	table.ForceInsert(all_br2_cvars, {name, value})
end

br2_add_cvar("br2_time_preparing", "25", "Preparing time")
br2_add_cvar("br2_time_round", "1320", "Round time")
br2_add_cvar("br2_time_postround", "30", "Post-round time")
br2_add_cvar("br2_time_mtf_spawn", "400", "After x seconds MTF can spawn")
br2_add_cvar("br2_time_008_open", "200", "After x seconds 008 open automatically")
br2_add_cvar("br2_ci_percentage", "25", "Percentage of researchers that are CI out of all players")
br2_add_cvar("br2_ci_chance", "50", "Chance for a researcher designated to be a spy to actually spawn as one")

br2_add_cvar("br2_time_music_start_low", "150", "After x seconds low intensity music starts")
br2_add_cvar("br2_time_music_start_medium", "800", "After x seconds medium intensity music starts")
br2_add_cvar("br2_time_music_start_high", "1400", "After x seconds high intensity music starts")

br2_add_cvar("br2_enable_npcs", "1", "Enable npcs spawning")
br2_add_cvar("br2_enable_sprays", "0", "Enable sprays")
br2_add_cvar("br2_chance_to_get_downed", "50", "Chances to down a player, from 0 to 100")
br2_add_cvar("br2_chance_res_conffolder_spawn", "30", "Chance for a researcher to get a confidential folder on spawn")
br2_add_cvar("br2_down_players", "1", "Disable downing completely")
br2_add_cvar("br2_gun_damage", "1", "Multiplies damage dealt with guns")
br2_add_cvar("br2_debug_mode", "0", "Enable the debug mode")
br2_add_cvar("br2_debug_dev_mode", "0", "Enable the dev debug mode")
br2_add_cvar("br2_testing_mode", "0", "Enable the testing mode")
br2_add_cvar("br2_sanity_strength", "1", "Sanity strength")
br2_add_cvar("br2_sanity_speed", "3", "Sanity speed in seconds")
br2_add_cvar("br2_temperature_speed", "0.75", "Temperature speed in seconds")
br2_add_cvar("br2_temperature_high_enabled", "0", "Enable Warm/High temperatures")
br2_add_cvar("br2_npc_teleport_delay_global", "40", "Global delay between SCP NPCs can teleport")
br2_add_cvar("br2_npc_teleport_delay", "40", "Delay between individual SCP NPC's teleports")

concommand.Add("br2_reset_settings", function()
	for k,v in pairs(all_br2_cvars) do
		print(v[1] .. " set to " .. v[2])
		RunConsoleCommand(v[1], v[2])
	end
end)

function GetBR2conVar(name)
	local cvar = GetConVar(name)
	if cvar == nil then return nil end
	return cvar:GetInt()
end

function SafeBoolConVar(name)
	return cvars.Bool(name, false)
end

function SafeIntConVar(name)
	return cvars.Number(name, 1)
end

function SafeFloatConVar(name)
	return cvars.Number(name, 1)
end

print("[Breach2] shared/sh_cvars.lua loaded!")
