

local starting_panel_serverinfo = {"SERVER", function(button, panel)
	button.OnClick = function(button, panel)
		local size_mul = ScrH() / 1080
		local clr_big_text = Color(255,255,255,255)
		local clr_small_text = Color(238,190,0,255)
		local clr_highlight_text = Color(255,81,0,255)

		local i_showname = BR2_OURNOTEPAD.people[1].br_showname
		local i_role = BR2_OURNOTEPAD.people[1].br_role
		local i_ci_agent = BR2_OURNOTEPAD.people[1].br_ci_agent

		local text_tab = {
			{"BR_TERMINAL_MAIN_TEXT", "Server Owner: ", clr_big_text, false},
			{"BR_TERMINAL_MAIN_TEXT", SERVER_INFO.OWNER, clr_highlight_text, true},

			{"BR_TERMINAL_MAIN_TEXT", "Server Location: ", clr_big_text, false},
			{"BR_TERMINAL_MAIN_TEXT", SERVER_INFO.LOCATION, clr_highlight_text, true},
			
			{"BR_TERMINAL_MAIN_TEXT", "Server Language: ", clr_big_text, false},
			{"BR_TERMINAL_MAIN_TEXT", SERVER_INFO.LANGUAGE, clr_highlight_text, true},

			{"BR_TERMINAL_MAIN_TEXT", "Server Theme: ", clr_big_text, false},
			{"BR_TERMINAL_MAIN_TEXT", SERVER_INFO.THEME, clr_highlight_text, true},
		}

		table.ForceInsert(text_tab, {"BR_TERMINAL_MAIN_TEXT", "Server Rules: ", clr_big_text, true})
		for k,v in pairs(SERVER_INFO.RULES) do
			table.ForceInsert(text_tab, {"BR_TERMINAL_MAIN_TEXT", " - "..v, clr_small_text, true})
		end

		table.ForceInsert(text_tab, {true, "BR_TERMINAL_MAIN_TEXT"})
		table.ForceInsert(text_tab, {"BR_TERMINAL_MAIN_TEXT", "If you have any connection problems, check your status using net_graph 1 in console", clr_big_text, true})

		panel.Paint = function(self, w, h)
			DrawDefaultTerminalBackground(w, h)
			draw_easy_text({12, 8}, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, text_tab)
		end

		BR_CURRENT_TERMINAL_PANEL = panel
	end
end}

local starting_panel_convars = {"CONVARS", function(button, panel)
	button.OnClick = function(button, panel)
		local size_mul = ScrH() / 1080
		local clr_big_text = Color(255,255,255,255)
		local clr_highlight_text = Color(255,81,0,255)

		panel.Paint = function(self, w, h)
			DrawDefaultTerminalBackground(w, h)
			draw_easy_text({12, 8}, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, BR_CONVARS_TEXT_TAB)
		end

		BR_CURRENT_TERMINAL_PANEL = panel
	end
end}

local starting_panel_keybinds = {"KEYBINDS", function(button, panel)
	button.OnClick = function(button, panel)
		local size_mul = ScrH() / 1080
		local clr_big_text = Color(255,255,255,255)
		local clr_small_text = Color(238,190,0,255)
		local clr_highlight_text = Color(255,81,0,255)

		panel.Paint = function(self, w, h)
			DrawDefaultTerminalBackground(w, h)
			draw_easy_text({12, 8}, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, BR_KEYBINDS_TEXT_TAB)
		end

		BR_CURRENT_TERMINAL_PANEL = panel
	end
end}

local starting_panel_dangers = {"SCPS", function(button, panel)
	button.OnClick = function(button, panel)
		local size_mul = ScrH() / 1080
		local clr_big_text = Color(255,255,255,255)
		local clr_highlight_text = Color(255,81,0,255)

		panel.Paint = function(self, w, h)
			DrawDefaultTerminalBackground(w, h)
			draw_easy_text({12, 8}, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, BR_SCP_TEXT_TAB)
		end

		BR_CURRENT_TERMINAL_PANEL = panel
	end
end}

local starting_panel_faq = {"FAQ", function(button, panel)
	button.OnClick = function(button, panel)
		local size_mul = ScrH() / 1080
		local clr_big_text = Color(255,255,255,255)
		local clr_highlight_text = Color(255,81,0,255)

		panel.Paint = function(self, w, h)
			DrawDefaultTerminalBackground(w, h)
			draw_easy_text({12, 8}, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, BR_FAQ_TEXT_TAB)
		end

		BR_CURRENT_TERMINAL_PANEL = panel
	end
end}

local next_first_panel_role = "classd"

local br_starting_panel = {
	{"MISSION", function(button, panel)
		button.OnClick = function(button, panel)
			if LocalPlayer().GetZone == nil then
				print("NIL LocalPlayer().GetZone")
				return
			end

			local size_mul = ScrH() / 1080
			local clr_big_text = Color(255,255,255,255)
			local clr_small_text = Color(238,190,0,255)
			local clr_highlight_text = Color(255,81,0,255)

			local i_showname = BR2_OURNOTEPAD.people[1].br_showname
			local i_role = BR2_OURNOTEPAD.people[1].br_role
			local i_ci_agent = BR2_OURNOTEPAD.people[1].br_ci_agent

			local text_tab = {}

			for k,v in pairs(BR_ROLE_FIRST_TEXTS[next_first_panel_role]) do
				table.ForceInsert(text_tab, {"BR_TERMINAL_MAIN_TEXT", v, clr_big_text, true})
			end

			table.Add(text_tab, {
				{true, "BR_TERMINAL_MAIN_TEXT"}, -- break line
				{true, "BR_TERMINAL_MAIN_TEXT"}, -- break line
				{"BR_TERMINAL_MAIN_TEXT", "Your role: ", clr_big_text, false},
				{"BR_TERMINAL_MAIN_TEXT", i_role, clr_highlight_text, true},
				{"BR_TERMINAL_MAIN_TEXT", "Your name: ", clr_big_text, false},
				{"BR_TERMINAL_MAIN_TEXT", i_showname, clr_highlight_text, true},
				{"BR_TERMINAL_MAIN_TEXT", "Facility: ", clr_big_text, false},
				{"BR_TERMINAL_MAIN_TEXT", "Site-19", clr_highlight_text, true},
			})

			local our_area = LocalPlayer():GetZone()
			if our_area != nil then
				table.ForceInsert(text_tab, {"BR_TERMINAL_MAIN_TEXT", "Location: ", clr_big_text, false})
				table.ForceInsert(text_tab, {"BR_TERMINAL_MAIN_TEXT", our_area.name, clr_highlight_text, true})
			end

			if istable(BREACH_MISSIONS) then
				for k,v in pairs(BREACH_MISSIONS) do
					if v.class == br2_our_mission_set then
						--print("Found our mission set: " .. v.class)

						table.ForceInsert(text_tab, {true, "BR_TERMINAL_MAIN_TEXT"})
						table.ForceInsert(text_tab, {true, "BR_TERMINAL_MAIN_TEXT"})
						--table.ForceInsert(text_tab, {"BR_TERMINAL_MAIN_TEXT", string.upper(v.name), clr_big_text, true})
						table.ForceInsert(text_tab, {"BR_TERMINAL_MAIN_TEXT", "Your missions:", clr_big_text, true})
						
						for k2,v2 in pairs(v.missions) do
							table.ForceInsert(text_tab, {"BR_TERMINAL_MAIN_TEXT_SMALL", " - " .. v2.name, clr_small_text, true})
						end

						break
					end
				end
			end

			/*
			if #LocalPlayer():GetWeapons() > 2 then
				table.ForceInsert(text_tab, {true, "BR_TERMINAL_MAIN_TEXT"})
				table.ForceInsert(text_tab, {true, "BR_TERMINAL_MAIN_TEXT"})
				table.ForceInsert(text_tab, {"BR_TERMINAL_MAIN_TEXT", "Starting Equipment:", clr_big_text, true})
				for k,v in pairs(LocalPlayer():GetWeapons()) do
					if v.Pickupable then
						local wep_name = v.PrintName or ""
						if v.GetPrintName then
							wep_name = v:GetPrintName()
						end
						table.ForceInsert(text_tab, {"BR_TERMINAL_MAIN_TEXT_SMALL", " - "..wep_name, clr_small_text, true})
					end
				end
			end
			*/

			panel.Paint = function(self, w, h)
				DrawDefaultTerminalBackground(w, h)
				draw_easy_text({12, 8}, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, text_tab)
			end

			BR_CURRENT_TERMINAL_PANEL = panel
		end
	end},
	starting_panel_serverinfo,
	starting_panel_keybinds,
	starting_panel_convars,
	starting_panel_dangers,
	starting_panel_faq
}

function BR_OpenFirstRolePanel(str)
	local starting_panel = table.Copy(br_starting_panel)
	if !SERVER_INFO.ENABLED then
		table.remove(starting_panel, 2) -- remove server info
	end

	next_first_panel_role = str
	--BR_ForceOpen_Terminal(br_starting_panel, "info_terminal")
	--timer.Simple(0.5, function()
		BR_Open_Starting_Terminal(starting_panel)
	--end)
end

print("[Breach2] client/derma/menu_firstrole.lua loaded!")
