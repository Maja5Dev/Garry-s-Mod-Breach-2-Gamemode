
local evac_shelter_delay = 0

local special_terminal_settings = {
	hcz_storage_room = {
		class = "1",
		name = "Open/Close Storage Room 2b",
		type = "button",
		button_size = 720,
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
		server = {
			func = function(pl)
				BR2_SPECIAL_BUTTONS["spec_button_ez_server_room"]:Use(pl, pl, 3, 1)
			end
		}
	},
	evac_shelter = {
		class = "6",
		name = "Send the elevator",
		type = "button",
		button_size = 600,
		server = {
			func = function(pl)
				if evac_shelter_delay < CurTime() then
					BR2_SPECIAL_BUTTONS["spec_button_ez_evac_shelter_1"]:Use(pl, pl, 3, 1)
					print("USED THE EVAC SHELTER")
					evac_shelter_delay = CurTime() + 12.5
				end
			end
		}
	},
}

for i=1, 4 do
	special_terminal_settings["hcz_generator_"..i] = {
		class = tostring(i + 1),
		name = "Restart Generator "..i.."",
		type = "button",
		button_size = 600,
		server = {
			func = function(pl)
				BR2_SPECIAL_BUTTONS["spec_button_generator_"..i]:Use(pl, pl, 1, 1)
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
		BR_Access_Terminal(button)
	end,
	buttons = {
	-- LCZ

		--CAFETERIA
		{name = "lcz_storage_area_3c-1a", pos = Vector(-2195,987,-8253), canSee = DefaultTerminalCanSee},
		{name = "lcz_storage_area_3c-1b", pos = Vector(-2195,950,-8253), canSee = DefaultTerminalCanSee},

		-- OFFICES
		{name = "lcz_office_1-1", pos = Vector(-959,908,-8143), canSee = DefaultTerminalCanSee},
		{name = "lcz_office_1-2a", pos = Vector(-1012,1165,-8124), canSee = function() return CanSeeFrom(Vector(-1012,1151,-8125)) end},
		{name = "lcz_office_1-2b", pos = Vector(-972,1165,-8124), canSee = function() return CanSeeFrom(Vector(-971,1151,-8125)) end},
		{name = "lcz_office_1-3", pos = Vector(-1034,1224,-8142), canSee = DefaultTerminalCanSee},
		{name = "lcz_office_1-4", pos = Vector(-1034,1375,-8142), canSee = DefaultTerminalCanSee},
		{name = "lcz_office_1-5", pos = Vector(-1213,1373,-8142), canSee = DefaultTerminalCanSee},
		{name = "lcz_office_1_6", pos = Vector(-1213,1220,-8143), canSee = DefaultTerminalCanSee},
		{name = "lcz_office_1_7", pos = Vector(-1213,1056,-8142), canSee = DefaultTerminalCanSee},
		{name = "lcz_office_1-8", pos = Vector(-1249,1056,-8142), canSee = DefaultTerminalCanSee},
		{name = "lcz_office_1-9", pos = Vector(-1249,1373,-8142), canSee = DefaultTerminalCanSee},
		
		-- STORAGE ROOMS
		{name = "lcz_storage_room_1-1", pos = Vector(1027,-559,-8141), canSee = DefaultTerminalCanSee},
		{name = "lcz_storage_room_2-1", pos = Vector(743,2156,-8142), canSee = DefaultTerminalCanSee},
		{name = "lcz_storage_room_2-2a", pos = Vector(763,2001,-8139), canSee = DefaultTerminalCanSee, special_functions = {special_terminal_settings.hcz_generator_4}},
		{name = "lcz_storage_room_2-2b", pos = Vector(763,1980,-8139), canSee = DefaultTerminalCanSee},
		{name = "lcz_storage_room_2-2c", pos = Vector(744,2051,-8112), canSee = DefaultTerminalCanSee},
		{name = "lcz_storage_room_2-2d", pos = Vector(744,2028,-8112), canSee = DefaultTerminalCanSee},
		{name = "lcz_storage_room_3-1", pos = Vector(880,-1614,-8142), canSee = DefaultTerminalCanSee},
		
		-- CONTAINMENT ROOMS
		{name = "lcz_cont_room_1-1a", pos = Vector(-1980,-513,-8124), canSee = function() return CanSeeFrom(Vector(-1981,-529,-8124)) end},
		{name = "lcz_cont_room_1_1b", pos = Vector(-1940,-513,-8124), canSee = function() return CanSeeFrom(Vector(-1940,-528,-8124)) end},
		{name = "lcz_cont_room_2_1a", pos = Vector(494,212,-8123), canSee = function() return CanSeeFrom(Vector(478,212,-8124)) end},
		{name = "lcz_cont_room_2_1b", pos = Vector(494,172,-8123), canSee = function() return CanSeeFrom(Vector(480,173,-8124)) end},
		{name = "lcz_cont_room_3_1a", pos = Vector(1886,-1517,-8123), canSee = function() return CanSeeFrom(Vector(1941,-1504,-8123)) end},
		{name = "lcz_cont_room_3_1b", pos = Vector(1846,-1517,-8123), canSee = function() return CanSeeFrom(Vector(1900,-1504,-8123)) end},
		{name = "lcz_cont_room_4-1", pos = Vector(860,798,-8142), canSee = DefaultTerminalCanSee},
		{name = "lcz_cont_room_5-1a", pos = Vector(1890,829,-8123), canSee = DefaultTerminalCanSee},
		{name = "lcz_cont_room_5-1b", pos = Vector(-2666,5155,-7355), canSee = DefaultTerminalCanSee},
		{name = "lcz_cont_room_5-2a", pos = Vector(-2720,5405,-7356), canSee = function() return CanSeeFrom(Vector(-2735,5388,-7357)) end},
		{name = "lcz_cont_room_5-2b", pos = Vector(-2681,5405,-7356), canSee = function() return CanSeeFrom(Vector(-2697,5392,-7356)) end},

		-- CHECKPOINTS
		{name = "lcz_checkpoint_1-1a", pos = Vector(-430,430,-8124), canSee = DefaultTerminalCanSee},
		{name = "lcz_checkpoint_1-1b", pos = Vector(-430,466,-8124), canSee = DefaultTerminalCanSee},
		{name = "lcz_checkpoint_2-1a", pos = Vector(-429,430,-8123), canSee = DefaultTerminalCanSee},
		{name = "lcz_checkpoint_2-1b", pos = Vector(-429,466,-8123), canSee = DefaultTerminalCanSee},

	--HCZ
		-- OFFICES
		{name = "hcz_office_4-1", pos = Vector(-226,4969,-7243), canSee = DefaultTerminalCanSee, special_functions = {special_terminal_settings.hcz_generator_2}},


		-- STORAGE ROOMS
		{name = "hcz_storage_room_1-1a", pos = Vector(-1189,3442,-7100), canSee = function() return CanSeeFrom(Vector(-1233,3464,-7105)) end},
		{name = "hcz_storage_room_1-1b", pos = Vector(-1229,3442,-7100), canSee = function() return CanSeeFrom(Vector(-1233,3464,-7105)) end},
		{name = "hcz_storage_room_1-2a", pos = Vector(-1458,3442,-7100), canSee = function() return CanSeeFrom(Vector(-1454,3458,-7101)) end},
		{name = "hcz_storage_room_1-2b", pos = Vector(-1498,3442,-7100), canSee = function() return CanSeeFrom(Vector(-1454,3458,-7101)) end},
		{name = "hcz_storage_room_2-1a", pos = Vector(838,2296,-7099), canSee = DefaultTerminalCanSee},
		{name = "hcz_storage_room_2-1b", pos = Vector(874,2296,-7099), canSee = DefaultTerminalCanSee},

		{name = "hcz_electrical_room_1-1a", pos = Vector(5087,7500,-6947), canSee = DefaultTerminalCanSee},
		{name = "hcz_electrical_room_1-1b", pos = Vector(5087,7464,-6947), canSee = DefaultTerminalCanSee},


		-- CONTAINMENT ROOMS
		{name = "hcz_cont_room_1-1a", pos = Vector(605,923,-7100), canSee = DefaultTerminalCanSee},
		{name = "hcz_cont_room_1-1b", pos = Vector(605,887,-7100), canSee = DefaultTerminalCanSee},
		{name = "hcz_cont_room_2-1a", pos = Vector(838,2301,-7100), canSee = DefaultTerminalCanSee},
		{name = "hcz_cont_room_2-1b", pos = Vector(874,2301,-7100), canSee = DefaultTerminalCanSee},
		{name = "hcz_cont_room_3-1a", pos = Vector(-2526,2724,-7100), canSee = DefaultTerminalCanSee},
		{name = "hcz_cont_room_3-1b", pos = Vector(-2561,2724,-7100), canSee = DefaultTerminalCanSee},
		{name = "hcz_cont_room_3-2a", pos = Vector(-2659,3156,-7100), canSee = DefaultTerminalCanSee},
		{name = "hcz_cont_room_3-2b", pos = Vector(-2623,3156,-7100), canSee = DefaultTerminalCanSee},
		{name = "hcz_cont_room_4-1a", pos = Vector(-3004,3722,-7108), canSee = DefaultTerminalCanSee, special_functions = {special_terminal_settings.hcz_storage_room}},
		{name = "hcz_cont_room_4-1b", pos = Vector(-3004,3686,-7108), canSee = DefaultTerminalCanSee, special_functions = {special_terminal_settings.hcz_generator_1}},
		{name = "hcz_cont_room_5-1a", pos = Vector(-2629,5155,-7355), canSee = DefaultTerminalCanSee},
		{name = "hcz_cont_room_5-1b", pos = Vector(-2629,5155,-7355), canSee = DefaultTerminalCanSee},
		{name = "hcz_cont_room_6-1", pos = Vector(-4070,4760,-7261), canSee = DefaultTerminalCanSee}, -- SCP_079_MAIN
		{name = "hcz_cont_room_6-2a", pos = Vector(-3586,4903,-7243), canSee = DefaultTerminalCanSee}, -- SCP_079
		{name = "hcz_cont_room_6-2b", pos = Vector(-3586,4867,-7243), canSee = DefaultTerminalCanSee}, -- SCP_079
		{name = "hcz_cont_room_6-3a", pos = Vector(-3623,4782,-7244), canSee = DefaultTerminalCanSee}, -- SCP_079
		{name = "hcz_cont_room_6-3b", pos = Vector(-3623,4759,-7244), canSee = DefaultTerminalCanSee}, -- SCP_079
		{name = "hcz_cont_room_7-1", pos = Vector(-2572,6849,-7374), canSee = DefaultTerminalCanSee}, -- SCP_106
		{name = "hcz_cont_room_8-1a", pos = Vector(-1323,4669,-7100), canSee = DefaultTerminalCanSee}, -- SCP_035_1
		{name = "hcz_cont_room_8-1b", pos = Vector(-1286,4669,-7100), canSee = DefaultTerminalCanSee}, -- SCP_035_1
		{name = "hcz_cont_room_9-1", pos = Vector(433,3875,-7094), canSee = DefaultTerminalCanSee}, -- SCP_035_1

		-- CHECKPOINTS
		{name = "hcz_checkpoint_1-1a", pos = Vector(1854,829,-7100), canSee = DefaultTerminalCanSee},
		{name = "hcz_checkpoint_1-1b", pos = Vector(1890,829,-7100), canSee = DefaultTerminalCanSee},


	--EZ
		-- CHECKPOINTS
		{name = "ez_checkpoint_1-1", pos = Vector(641,5119,-7115), canSee = DefaultTerminalCanSee},
		{name = "ez_checkpoint_1-2a", pos = Vector(682,4905,-7099), canSee = DefaultTerminalCanSee},
		{name = "ez_checkpoint_1-2a", pos = Vector(647,4905,-7099), canSee = DefaultTerminalCanSee},
		{name = "ez_checkpoint_2-1", pos = Vector(1481,3545,-7115), canSee = DefaultTerminalCanSee},
		{name = "ez_checkpoint_2-2a", pos = Vector(1645,3586,-7100), canSee = DefaultTerminalCanSee},
		{name = "ez_checkpoint_2-2a", pos = Vector(1645,3550,-7100), canSee = DefaultTerminalCanSee},


		{name = "ez_office_1B-1", pos = Vector(1888,4034,-7117), canSee = DefaultTerminalCanSee},
		{name = "ez_office_1B-2", pos = Vector(1675,4005,-7117), canSee = DefaultTerminalCanSee},
		{name = "ez_office_1A-1", pos = Vector(2179,4120,-7117), canSee = DefaultTerminalCanSee},
		{name = "ez_office_1A-2", pos = Vector(2103,4005,-7117), canSee = DefaultTerminalCanSee},
		{name = "ez_shared_conf_room-1", pos = Vector(2864,4711,-7116), canSee = DefaultTerminalCanSee},
		{name = "ez_office_3-1", pos = Vector(2987,4076,-7181), canSee = DefaultTerminalCanSee},
		{name = "ez_office_3-2", pos = Vector(3168,4142,-7181), canSee = DefaultTerminalCanSee},
		{name = "ez_office_3-3", pos = Vector(3386,4078,-7182), canSee = DefaultTerminalCanSee},
		{name = "ez_cafeteria-1", pos = Vector(4314,4653,-7244), canSee = DefaultTerminalCanSee},
		{name = "ez_evac_shelter_1-1", pos = Vector(4688,5299,-7117), canSee = DefaultTerminalCanSee, is_evac_shelter = true, special_functions = {special_terminal_settings.evac_shelter}, auth = {"admin", true}},
		{name = "ez_head_office-2", pos = Vector(5320,6433,-7056), canSee = DefaultTerminalCanSee},
		{name = "ez_head_office-1", pos = Vector(5149,6315,-7053), canSee = DefaultTerminalCanSee},
		{name = "ez_security_gateway_1-1", pos = Vector(4520,6915,-7120), canSee = DefaultTerminalCanSee},
		{name = "ez_security_gateway_2-1", pos = Vector(5945,5891,-7120), canSee = DefaultTerminalCanSee},
		{name = "ez_conf_room_1-1", pos = Vector(5437,7517,-7117), canSee = DefaultTerminalCanSee},
		{name = "ez_conf_room_1-2", pos = Vector(5433,7437,-7117), canSee = DefaultTerminalCanSee},
		{name = "ez_electrical_center-1a", pos = Vector(5119,8189,-6844), canSee = DefaultTerminalCanSee},
		{name = "ez_electrical_center-1b", pos = Vector(5119,8153,-6844), canSee = DefaultTerminalCanSee},
		{name = "ez_medical_bay_1-1", pos = Vector(1364,5119,-7117), canSee = DefaultTerminalCanSee},
		{name = "ez_medical_bay_1-2", pos = Vector(1580,5280,-7099), canSee = function() return CanSeeFrom(Vector(1584,5259,-7111)) end},
		{name = "ez_medical_bay_1-2", pos = Vector(1620,5280,-7099), canSee = function() return CanSeeFrom(Vector(1584,5259,-7111)) end},
		{name = "ez_office_4-1", pos = Vector(4743,6160,-7117), canSee = DefaultTerminalCanSee},
		{name = "ez_office_4-2", pos = Vector(4462,6045,-7117), canSee = DefaultTerminalCanSee},
		{name = "ez_office_4-3", pos = Vector(4462,5854,-7118), canSee = DefaultTerminalCanSee},
		{name = "ez_office_4-4", pos = Vector(4295,5918,-7118), canSee = DefaultTerminalCanSee},
		{name = "ez_office_4-5", pos = Vector(4295,6119,-7117), canSee = DefaultTerminalCanSee},
		{name = "ez_office_4-6", pos = Vector(4317,5745,-7118), canSee = DefaultTerminalCanSee},
		{name = "ez_office_2B-1", pos = Vector(1701,5774,-7117), canSee = DefaultTerminalCanSee},
		{name = "ez_office_2A-1", pos = Vector(2017,5675,-7117), canSee = DefaultTerminalCanSee},
		{name = "ez_office_2A-2", pos = Vector(2245,5679,-7117), canSee = DefaultTerminalCanSee},
		{name = "ez_office_5-1", pos = Vector(3006,6674,-7118), canSee = DefaultTerminalCanSee},
		{name = "ez_office_5-2", pos = Vector(3047,6682,-7118), canSee = DefaultTerminalCanSee},
		{name = "ez_office_5-3", pos = Vector(3196,7016,-7118), canSee = DefaultTerminalCanSee},
		{name = "ez_office_5-4a", pos = Vector(2878,7058,-7100), canSee = function() return CanSeeFrom(Vector(2894,7074,-7101)) end},
		{name = "ez_office_5-4b", pos = Vector(2878,7099,-7100), canSee = function() return CanSeeFrom(Vector(2894,7074,-7101)) end, special_functions = {special_terminal_settings.hcz_generator_3}},
		{name = "ez_office_5-5", pos = Vector(3151,7098,-7118), canSee = DefaultTerminalCanSee},
		{name = "ez_server_hub-1", pos = Vector(5374,4857,-7374), canSee = DefaultTerminalCanSee},
		{name = "ez_office_6-1", pos = Vector(1427,6021,-7250), canSee = DefaultTerminalCanSee},
		{name = "ez_office_6-2", pos = Vector(1344,6021,-7250), canSee = DefaultTerminalCanSee},
		{name = "ez_office_6-3", pos = Vector(1263,6021,-7250), canSee = DefaultTerminalCanSee},
		{name = "ez_office_6-4", pos = Vector(1353,6233,-7249), canSee = DefaultTerminalCanSee},
		{name = "ez_office_6-5", pos = Vector(1401,6704,-7249), canSee = DefaultTerminalCanSee},
		{name = "ez_office_6-6", pos = Vector(1427,6490,-7250), canSee = DefaultTerminalCanSee},
		{name = "ez_office_6-7_1", pos = Vector(1077,6652,-7232), canSee = function() return CanSeeFrom(Vector(1095,6661,-7237)) end},
		{name = "ez_office_6-7_2", pos = Vector(1077,6692,-7232), canSee = function() return CanSeeFrom(Vector(1095,6661,-7237)) end},
		{name = "ez_office_7-1", pos = Vector(3404,5997,-7182), canSee = DefaultTerminalCanSee},
		{name = "ez_office_7-2", pos = Vector(3226,5996,-7181), canSee = DefaultTerminalCanSee},
		{name = "ez_office_7-3", pos = Vector(3102,5996,-7182), canSee = DefaultTerminalCanSee},
		{name = "ez_storage_room_3e-1", pos = Vector(2232,6234,-7118), canSee = DefaultTerminalCanSee},
		{name = "ez_serverfarm-server_main", pos = Vector(4693,4253,-7263), canSee = DefaultTerminalCanSee, special_functions = {special_terminal_settings.ez_servers}},


		--{name = "ez_office_7-XXXXXXXXXXXXXX", pos = YYYYYYYYYYYYYYYY, canSee = DefaultTerminalCanSee},
		--{name = "ez_office_7-XXXXXXXXXXXXXX", pos = YYYYYYYYYYYYYYYY, canSee = DefaultTerminalCanSee},
		--{name = "ez_office_7-XXXXXXXXXXXXXX", pos = YYYYYYYYYYYYYYYY, canSee = DefaultTerminalCanSee},




		--{name = "ez_office_1_1", pos = XXXXXXXXXXXXXXXXXXX, canSee = DefaultTerminalCanSee},
		--{name = "ez_office_1_1", pos = XXXXXXXXXXXXXXXXXXX, canSee = DefaultTerminalCanSee},
		--{name = "ez_office_1_1", pos = XXXXXXXXXXXXXXXXXXX, canSee = DefaultTerminalCanSee},
		--{name = "ez_office_1_1", pos = XXXXXXXXXXXXXXXXXXX, canSee = DefaultTerminalCanSee},

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
