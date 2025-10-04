
local evac_shelter_delay = 0
local lcz_lockdown_delay = 0
local nuke_change_delay = 0

local function available_only_security(pl)
	if CLIENT then
		return (pl.br_team == TEAM_MTF or pl.br_team == TEAM_SECURITY or pl.br_role == "CI Soldier") or
			(istable(BR2_OURNOTEPAD) and istable(BR2_OURNOTEPAD.people) and table.Count(BR2_OURNOTEPAD.people) > 0 and
			(BR2_OURNOTEPAD.people[1].br_team == TEAM_MTF or BR2_OURNOTEPAD.people[1].br_team == TEAM_SECURITY or BR2_OURNOTEPAD.people[1].br_role == "CI Soldier"))
	end
	return (pl.br_team == TEAM_MTF or pl.br_team == TEAM_SECURITY or pl.br_role == "CI Soldier")
end

BR2_SPECIAL_TERMINAL_SETTINGS = {
	hcz_storage_room = {
		class = "1",
		name = "Open/Close Storage Room 2b",
		type = "button",
		button_size = 720,
		global = false,
		server = {
			func = function(pl)
				BR2_SPECIAL_BUTTONS["spec_button_hcz_storage_room"]:Use(pl, pl, 3, 1)
			end
		}
	},
	ez_servers = {
		class = "5",
		name = "Restart the servers",
		type = "button",
		button_size = 640,
		global = false,
		server = {
			func = function(pl)
				BR2_SPECIAL_BUTTONS["spec_button_ez_server_room"]:Use(pl, pl, 3, 1)
				round_system.AddEventLog("Servers have been restarted.", pl)
			end
		}
	},
	evac_shelter = {
		class = "6",
		name = "Send the elevator",
		type = "button",
		button_size = 600,
		global = false,
		server = {
			func = function(pl)
				if evac_shelter_delay < CurTime() then
					BR2_SPECIAL_BUTTONS["spec_button_ez_evac_shelter_1"]:Use(pl, pl, 3, 1)
					round_system.AddEventLog("Evacuation shelter requested.", pl)
					evac_shelter_delay = CurTime() + 12.5
				end
			end
		}
	},

	lcz_lockdown_enable = {
		class = "7",
		name = "Enable LCZ Lockdown",
		type = "button",
		button_size = 720,
		global = true,
		canUse = function(pl) return available_only_security(pl) end,
		server = {
			func = function(pl)
				local lcz_lockdown = ents.FindByName("checkpoint_lockdown")
				if !istable(lcz_lockdown) or #lcz_lockdown == 0 then
					error("checkpoint_lockdown ENTITY NOT FOUND")
				end

				local enabled = tonumber(lcz_lockdown[1]:GetKeyValues()["effects"]) == 0

				if enabled then
					pl:PrintMessage(HUD_PRINTTALK, "The lockdown is already enabled")
					return
				end

				if lcz_lockdown_delay < CurTime() then
					local lcz_lockdown_button = ents.FindByName("lockdown_lever_roomccont")

					if istable(lcz_lockdown_button) and #lcz_lockdown_button > 0 then
						if !enabled then
							lcz_lockdown_button[1]:Use(pl, pl, 3, 1)
							lcz_lockdown_delay = CurTime() + 12.5
							print("LCZ Lockdown enabled")
							round_system.AddEventLog("LCZ Lockdown enabled.", pl)
							-- TODO: Make a loud sound
						end
					else
						error("lockdown_lever_roomccont ENTITY NOT FOUND")
					end
				else
					pl:PrintMessage(HUD_PRINTTALK, "You need to wait " .. math.Round(lcz_lockdown_delay - CurTime(), 1) .. " more seconds to be able to change the LCZ lockdown")
				end
			end
		}
	},

	lcz_lockdown_disable = {
		class = "8",
		name = "Disable LCZ Lockdown",
		type = "button",
		button_size = 720,
		global = true,
		canUse = function(pl) return available_only_security(pl) end,
		/* not implemented
		available = function(pl)
			local lcz_lockdown = ents.FindByName("checkpoint_lockdown")
			return istable(lcz_lockdown) and tonumber(lcz_lockdown[1]:GetKeyValues()["effects"]) == 32
		end,
		*/
		server = {
			func = function(pl)
				local lcz_lockdown = ents.FindByName("checkpoint_lockdown")
				if !istable(lcz_lockdown) or #lcz_lockdown == 0 then
					error("checkpoint_lockdown ENTITY NOT FOUND")
				end

				local enabled = tonumber(lcz_lockdown[1]:GetKeyValues()["effects"]) == 0

				if !enabled then
					pl:PrintMessage(HUD_PRINTTALK, "The lockdown is already disabled")
					return
				end

				if lcz_lockdown_delay < CurTime() then
					local lcz_lockdown_button = ents.FindByName("lockdown_lever_roomccont")

					if istable(lcz_lockdown_button) and #lcz_lockdown_button > 0 then
						if enabled then
							lcz_lockdown_button[1]:Use(pl, pl, 3, 1)
							lcz_lockdown_delay = CurTime() + 12.5
							round_system.AddEventLog("LCZ Lockdown disabled.", pl)
							-- TODO: Make a loud sound
						end
					else
						error("lockdown_lever_roomccont ENTITY NOT FOUND")
					end
				else
					pl:PrintMessage(HUD_PRINTTALK, "You need to wait " .. math.Round(lcz_lockdown_delay - CurTime(), 1) .. " more seconds to be able to change the LCZ lockdown")
				end
			end
		}
	},

	omega_warhead_activate = {
		class = "9",
		name = "Activate Omega Warhead",
		type = "button",
		button_size = 720,
		canUse = function(pl)
			if CLIENT then
				return br2_nuke_activated != true
			else
				return timer.Exists("BR_NukeExplosion") != true
			end
		end,
		global = false,
		server = {
			func = function(pl)
				if timer.Exists("BR_NukeExplosion") then
					pl:PrintMessage(HUD_PRINTTALK, "The detonation sequence is already in progress.")
					return
				end

				if game_state != GAMESTATE_ROUND then
					return
				end

				-- check if remote detonation enabled
				local remote_detonation = ents.FindByName("omega_lever_room2nuke")
				if !istable(remote_detonation) or #remote_detonation == 0 then
					error("omega_lever_room2nuke ENTITY NOT FOUND")
				end

				local enabled = remote_detonation[1]:GetAngles().pitch > 0

				if enabled then
					pl:PrintMessage(HUD_PRINTTALK, "Remote detonation is off, cannot activate detonation.")
					return
				end

				if isnumber(br2_nuke_activated_for) and br2_nuke_activated_for < CurTime() then
					br2_nuke_activated_for = nil
					br2_nuke_activator = nil
				end

				if br2_nuke_activator != nil and br2_nuke_activator == pl then
					pl:PrintMessage(HUD_PRINTTALK, "A second operator must confirm activation from another terminal.")
					return
				end

				if br2_nuke_activated_for == nil then
					br2_nuke_activated_for = CurTime() + 10
					br2_nuke_activator = pl
					--round_system.AddEventLog("First confirmation of omega warhead detonation registered", pl)
					pl:PrintMessage(HUD_PRINTTALK, "First confirmation registered. A second operator must confirm activation from another terminal.")
					return
				end

				--round_system.AddEventLog("Second confirmation of omega warhead detonation registered", pl)

				if nuke_change_delay < CurTime() then
					nuke_change_delay = CurTime() + 30
					BR_ActivateNuke()
					local nuke_time = cvars.Number("br2_time_nuke", 90)
					pl:PrintMessage(HUD_PRINTTALK, "Secondary confirmation received. Detonation sequence initiated (T-"..nuke_time.." seconds).")
				else
					pl:PrintMessage(HUD_PRINTTALK, "Terminal locked. Please wait " .. math.Round(nuke_change_delay - CurTime(), 1) .. " seconds before retrying.")
				end
			end
		}
	},

	omega_warhead_deactivate = {
		class = "10",
		name = "Deactivate Omega Warhead",
		type = "button",
		button_size = 720,
		canUse = function(pl)
			if CLIENT then
				return br2_nuke_activated == true
			else
				return timer.Exists("BR_NukeExplosion") == true
			end
		end,
		global = false,
		server = {
			func = function(pl)
				if !timer.Exists("BR_NukeExplosion") then
					pl:PrintMessage(HUD_PRINTTALK, "The detonation sequence is not currently in progress.")
					return
				end

				if game_state != GAMESTATE_ROUND then
					return
				end

				-- check if remote detonation enabled
				local remote_detonation = ents.FindByName("omega_lever_room2nuke")
				if !istable(remote_detonation) or #remote_detonation == 0 then
					error("omega_lever_room2nuke ENTITY NOT FOUND")
				end

				local enabled = remote_detonation[1]:GetAngles().pitch > 0

				if enabled then
					pl:PrintMessage(HUD_PRINTTALK, "Remote detonation is off, cannot deactivate detonation.")
					return
				end

				if isnumber(br2_nuke_deactivated_for) and br2_nuke_deactivated_for < CurTime() then
					br2_nuke_deactivated_for = nil
					br2_nuke_deactivator = nil
				end

				if br2_nuke_deactivator != nil and br2_nuke_deactivator == pl then
					pl:PrintMessage(HUD_PRINTTALK, "A second operator must confirm deactivation from another terminal.")
					return
				end

				if br2_nuke_deactivated_for == nil then
					br2_nuke_deactivated_for = CurTime() + 10
					br2_nuke_deactivator = pl
					--round_system.AddEventLog("First confirmation of omega warhead detonation registered", pl)
					pl:PrintMessage(HUD_PRINTTALK, "First confirmation registered. A second operator must confirm deactivation from another terminal.")
					return
				end

				--round_system.AddEventLog("Second confirmation of omega warhead detonation registered", pl)

				if nuke_change_delay < CurTime() then
					nuke_change_delay = CurTime() + 30
					BR_DeactivateNuke()
					pl:PrintMessage(HUD_PRINTTALK, "Secondary confirmation received. Detonation sequence deactivated.")
				else
					pl:PrintMessage(HUD_PRINTTALK, "Terminal locked. Please wait " .. math.Round(nuke_change_delay - CurTime(), 1) .. " seconds before retrying.")
				end
			end
		}
	}
}

for i=1, 4 do
	BR2_SPECIAL_TERMINAL_SETTINGS["hcz_generator_"..i] = {
		class = tostring(i + 1),
		name = "Restart Generator "..i.."",
		type = "button",
		button_size = 600,
		global = false,
		server = {
			func = function(pl)
				BR2_SPECIAL_BUTTONS["spec_button_generator_"..i]:Use(pl, pl, 1, 1)
				round_system.AddEventLog("Auxillary generator "..i.." restarted.", pl)
			end
		}
	}
end

function Buttons_Terminals_TestPos(pos)
	for k,v in pairs(MAPCONFIG.BUTTONS_2D.TERMINALS.buttons) do
		local dist = v.pos:Distance(pos)
		if dist < 25 then
			print(v, dist)
		end
	end
end
-- lua_run Buttons_Terminals_TestPos(Vector(1915,6156,-7112))

MAPCONFIG.BUTTONS_2D.TERMINALS = {
	mat = br_default_button_icons.scpu,
	on_open = function(button)
		if table.HasValue(BR2_ROLES_DISALLOWED_TERMINAL_USE, LocalPlayer().br_role) then
			LocalPlayer():PrintMessage(HUD_PRINTTALK, "Your cannot use terminals.")
			return
		end

		BR_Access_Terminal(button)
	end,
	buttons = {
	-- LCZ
		--CAFETERIA
		{name = "lcz_storage_area_3c", pos = Vector(-2195,950,-8253), canSee = DefaultTerminalCanSee},

		-- OFFICES
		{name = "lcz_office_1", pos = Vector(-959,908,-8143), canSee = DefaultTerminalCanSee},
		
		-- STORAGE ROOMS
		{name = "lcz_storage_room_1", pos = Vector(1027,-559,-8141), canSee = DefaultTerminalCanSee},
		{name = "lcz_storage_room_2", pos = Vector(743,2156,-8142), canSee = DefaultTerminalCanSee, special_functions = {BR2_SPECIAL_TERMINAL_SETTINGS.hcz_generator_4}},
		{name = "lcz_storage_room_3", pos = Vector(880,-1614,-8142), canSee = DefaultTerminalCanSee},
		
		-- CONTAINMENT ROOMS
		{name = "lcz_cont_room_1", pos = Vector(-1980,-513,-8124), canSee = function() return CanSeeFrom(Vector(-1981,-529,-8124)) end},
		{name = "lcz_cont_room_2", pos = Vector(494,212,-8123), canSee = function() return CanSeeFrom(Vector(478,212,-8124)) end},
		{name = "lcz_cont_room_3", pos = Vector(1886,-1517,-8123), canSee = function() return CanSeeFrom(Vector(1941,-1504,-8123)) end},
		{name = "lcz_cont_room_4", pos = Vector(860,798,-8142), canSee = DefaultTerminalCanSee},

		-- CHECKPOINTS
		{name = "lcz_checkpoint_1", pos = Vector(-430,430,-8124), canSee = DefaultTerminalCanSee},
		{name = "lcz_checkpoint_2", pos = Vector(1854,829,-8124), canSee = DefaultTerminalCanSee},

		-- LOCKDOWN ROOM
		{name = "lcz_lockdown_control_room", pos = Vector(1584,21,-8142), canSee = DefaultTerminalCanSee, camerasEnabled = true},

	--HCZ
		-- OFFICES
		{name = "hcz_office_4", pos = Vector(-226,4969,-7243), canSee = DefaultTerminalCanSee},

		-- STORAGE ROOMS
		{name = "hcz_storage_room_1", pos = Vector(-1229,3442,-7100), canSee = function() return CanSeeFrom(Vector(-1233,3464,-7105)) end, special_functions = {BR2_SPECIAL_TERMINAL_SETTINGS.hcz_generator_3}},
		{name = "hcz_storage_room_2", pos = Vector(838,2296,-7099), canSee = DefaultTerminalCanSee},

		-- CONTAINMENT ROOMS
		{name = "hcz_cont_room_1", pos = Vector(605,923,-7100), canSee = DefaultTerminalCanSee}, -- SCP-035
		{name = "hcz_cont_room_3", pos = Vector(-2623,3156,-7100), canSee = DefaultTerminalCanSee}, -- SCP-457
		{name = "hcz_cont_room_4", pos = Vector(-3004,3686,-7108), canSee = DefaultTerminalCanSee, special_functions = {BR2_SPECIAL_TERMINAL_SETTINGS.hcz_storage_room}},
		{name = "hcz_cont_room_5", pos = Vector(-2720,5405,-7356), canSee = function() return CanSeeFrom(Vector(-2735,5388,-7357)) end}, -- SCP-682
		{name = "hcz_cont_room_6", pos = Vector(-4070,4760,-7261), canSee = DefaultTerminalCanSee, special_functions = {BR2_SPECIAL_TERMINAL_SETTINGS.hcz_generator_1}}, -- SCP_079_MAIN
		{name = "hcz_cont_room_7", pos = Vector(-2572,6849,-7374), canSee = DefaultTerminalCanSee}, -- SCP_106
		{name = "hcz_cont_room_8", pos = Vector(-1323,4669,-7100), canSee = DefaultTerminalCanSee}, -- SCP_035_1
		{name = "hcz_cont_room_9", pos = Vector(433,3875,-7094), canSee = DefaultTerminalCanSee}, -- SCP_035_1

		-- CHECKPOINTS
		{name = "hcz_checkpoint_1", pos = Vector(1854,829,-7100), canSee = DefaultTerminalCanSee},

		-- WARHEAD ROOM
		{name = "hcz_warhead_controlroom_1", pos = Vector(3733,-489,-7127), canSee = DefaultTerminalCanSee, special_functions = {BR2_SPECIAL_TERMINAL_SETTINGS.omega_warhead_activate, BR2_SPECIAL_TERMINAL_SETTINGS.omega_warhead_deactivate}},
		{name = "hcz_warhead_controlroom_2", pos = Vector(3693,-231,-7131), canSee = DefaultTerminalCanSee, special_functions = {BR2_SPECIAL_TERMINAL_SETTINGS.omega_warhead_activate, BR2_SPECIAL_TERMINAL_SETTINGS.omega_warhead_deactivate}},


	--EZ
		-- CHECKPOINTS
		{name = "ez_checkpoint_1", pos = Vector(641,5119,-7115), canSee = DefaultTerminalCanSee},
		{name = "ez_checkpoint_2", pos = Vector(1481,3545,-7115), canSee = DefaultTerminalCanSee},

		{name = "ez_office_1B", pos = Vector(1675,4005,-7117), canSee = DefaultTerminalCanSee},
		{name = "ez_office_1A", pos = Vector(2103,4005,-7117), canSee = DefaultTerminalCanSee},
		{name = "ez_shared_conf_room", pos = Vector(2864,4711,-7116), canSee = DefaultTerminalCanSee},
		{name = "ez_office_3", pos = Vector(3168,4142,-7181), canSee = DefaultTerminalCanSee},
		{name = "ez_cafeteria", pos = Vector(4314,4653,-7244), canSee = DefaultTerminalCanSee},
		{name = "ez_evac_shelter_1", pos = Vector(4688,5299,-7117), canSee = DefaultTerminalCanSee, is_evac_shelter = true, special_functions = {BR2_SPECIAL_TERMINAL_SETTINGS.evac_shelter}, auth = {"admin", true}, camerasEnabled = true},
		{name = "ez_head_office", pos = Vector(5149,6315,-7053), canSee = DefaultTerminalCanSee, special_functions = {BR2_SPECIAL_TERMINAL_SETTINGS.hcz_generator_2}, camerasEnabled = true},
		{name = "ez_security_gateway_1", pos = Vector(4520,6915,-7120), canSee = DefaultTerminalCanSee, camerasEnabled = true},
		{name = "ez_security_gateway_2", pos = Vector(5945,5891,-7120), canSee = DefaultTerminalCanSee, camerasEnabled = true},
		{name = "ez_conf_room_1", pos = Vector(5437,7517,-7117), canSee = DefaultTerminalCanSee},

		{name = "ez_electrical_center", pos = Vector(5087,7500,-6947), canSee = DefaultTerminalCanSee, camerasEnabled = true},

		{name = "ez_medical_bay_1", pos = Vector(1364,5119,-7117), canSee = DefaultTerminalCanSee},
		{name = "ez_office_4", pos = Vector(4743,6160,-7117), canSee = DefaultTerminalCanSee},
		{name = "ez_office_2B", pos = Vector(1701,5774,-7117), canSee = DefaultTerminalCanSee},
		{name = "ez_office_2A", pos = Vector(2017,5675,-7117), canSee = DefaultTerminalCanSee},
		{name = "ez_office_5", pos = Vector(3196,7016,-7118), canSee = DefaultTerminalCanSee},
		{name = "ez_server_hub", pos = Vector(5374,4857,-7374), canSee = DefaultTerminalCanSee, camerasEnabled = true},
		{name = "ez_office_6", pos = Vector(1401,6704,-7249), canSee = DefaultTerminalCanSee},
		{name = "ez_office_7", pos = Vector(3226,5996,-7181), canSee = DefaultTerminalCanSee},
		{name = "ez_storage_room_3e", pos = Vector(2232,6234,-7118), canSee = DefaultTerminalCanSee},
		{name = "ez_serverfarm-server_main", pos = Vector(4693,4253,-7263), canSee = DefaultTerminalCanSee, special_functions = {BR2_SPECIAL_TERMINAL_SETTINGS.ez_servers}, camerasEnabled = true},

	}
}
-- ulx strip ^ ; give breach_tool_terminalplacer
-- lua_run Entity(1):SetPos(xxxxxxxxxxxxxxxxxxxxxx)

MAPCONFIG.BUTTONS_2D.BROKEN_TERMINALS = {
	mat = br_default_button_icons.scpu,
	on_open = function(button)
		BR_Access_BrokenTerminal(button)
	end,
	buttons = {
		/*
		{pos = YYYYYYYYYYYYYYYYYYYYYYYY, spraks = true, sounds = 1, canSee = DefaultTerminalCanSee},
		{pos = YYYYYYYYYYYYYYYYYYYYYYYY, spraks = true, sounds = 1, canSee = DefaultTerminalCanSee},
		*/
	}
}
