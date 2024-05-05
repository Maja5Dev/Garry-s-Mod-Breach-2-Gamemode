

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
		if SERVER_INFO.OFFICIAL == true then
			table.ForceInsert(text_tab, {"BR_TERMINAL_MAIN_TEXT", "This server is an official Breach 2 testing server", clr_big_text, true})
		end
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
		local clr_small_text = Color(238,190,0,255)
		local clr_highlight_text = Color(255,81,0,255)

		local i_showname = BR2_OURNOTEPAD.people[1].br_showname
		local i_role = BR2_OURNOTEPAD.people[1].br_role
		local i_ci_agent = BR2_OURNOTEPAD.people[1].br_ci_agent

		local text_tab = {
			{"BR_TERMINAL_MAIN_TEXT", "ConVar: ", clr_big_text, false},
			{"BR_TERMINAL_MAIN_TEXT", "br2_cameras_go_around", clr_highlight_text, true},
			{"BR_TERMINAL_MAIN_TEXT_SMALL", " Default value: 0", clr_big_text, true},
			{"BR_TERMINAL_MAIN_TEXT_SMALL", " Camera arrows can loop around", clr_big_text, true},
			{true, "BR_TERMINAL_MAIN_TEXT"},
			{"BR_TERMINAL_MAIN_TEXT", "Command: ", clr_big_text, false},
			{"BR_TERMINAL_MAIN_TEXT", "br2_reset_chat", clr_highlight_text, true},
			{"BR_TERMINAL_MAIN_TEXT_SMALL", " Cleans the chat", clr_big_text, true},
		}

		panel.Paint = function(self, w, h)
			DrawDefaultTerminalBackground(w, h)
			draw_easy_text({12, 8}, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, text_tab)
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

		local i_showname = BR2_OURNOTEPAD.people[1].br_showname
		local i_role = BR2_OURNOTEPAD.people[1].br_role
		local i_ci_agent = BR2_OURNOTEPAD.people[1].br_ci_agent

		local text_tab = {
			{"BR_TERMINAL_MAIN_TEXT", "F1 (gm_showhelp) ", clr_highlight_text, false},
			{"BR_TERMINAL_MAIN_TEXT", "Gamemode Information", clr_big_text, true},
			{"BR_TERMINAL_MAIN_TEXT", "F2 (gm_showteam) ", clr_highlight_text, false},
			{"BR_TERMINAL_MAIN_TEXT", "Server Information", clr_big_text, true},
			{"BR_TERMINAL_MAIN_TEXT", "F3 (gm_showspare1) ", clr_highlight_text, false},
			{"BR_TERMINAL_MAIN_TEXT", "Help/Contact Information", clr_big_text, true},
			{"BR_TERMINAL_MAIN_TEXT", "F4 (gm_showspare2) ", clr_highlight_text, false},
			{"BR_TERMINAL_MAIN_TEXT", "Tutorials", clr_big_text, true},
			{true, "BR_TERMINAL_MAIN_TEXT"},
			{"BR_TERMINAL_MAIN_TEXT", "Weapon Keybinds:", clr_big_text, true},
			{"BR_TERMINAL_MAIN_TEXT", "Mouse 1 (+attack) ", clr_small_text, false},
			{"BR_TERMINAL_MAIN_TEXT", "Primary attack", clr_big_text, true},
			{"BR_TERMINAL_MAIN_TEXT", "Mouse 2 (+attack2) ", clr_small_text, false},
			{"BR_TERMINAL_MAIN_TEXT", "Secondary attack", clr_big_text, true},
			{"BR_TERMINAL_MAIN_TEXT", "C (+menu_context) ", clr_small_text, false},
			{"BR_TERMINAL_MAIN_TEXT", "Weapon info / Attachments", clr_big_text, true},
			{"BR_TERMINAL_MAIN_TEXT", "E + R (+use, +reload) ", clr_small_text, false},
			{"BR_TERMINAL_MAIN_TEXT", "Change weapon's firing modes", clr_big_text, true},
		}

		panel.Paint = function(self, w, h)
			DrawDefaultTerminalBackground(w, h)
			draw_easy_text({12, 8}, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, text_tab)
		end

		BR_CURRENT_TERMINAL_PANEL = panel
	end
end}

local starting_panel_dangers = {"SCPS", function(button, panel)
	button.OnClick = function(button, panel)
		local size_mul = ScrH() / 1080
		local clr_big_text = Color(255,255,255,255)
		local clr_small_text = Color(238,190,0,255)
		local clr_highlight_text = Color(255,81,0,255)

		local i_showname = BR2_OURNOTEPAD.people[1].br_showname
		local i_role = BR2_OURNOTEPAD.people[1].br_role
		local i_ci_agent = BR2_OURNOTEPAD.people[1].br_ci_agent

		local text_tab = {
			{"BR_TERMINAL_MAIN_TEXT", "1. SCP-173 (Light Containment Zone)", clr_highlight_text, true},
			{"BR_TERMINAL_MAIN_TEXT_SMALL", "   SCP-173 is a very dangerous object, it snaps necks of humans when they loose eye contact with it", clr_big_text, true},
			{"BR_TERMINAL_MAIN_TEXT_SMALL", "   Best way to avoid being killed is to stick in groups of at least 3 people", clr_big_text, true},
			{"BR_TERMINAL_MAIN_TEXT", "2. SCP-106 (Inside the facility)", clr_highlight_text, true},
			{"BR_TERMINAL_MAIN_TEXT_SMALL", "   SCP-106 can move through solid materials and can appear all around the facility", clr_big_text, true},
			{"BR_TERMINAL_MAIN_TEXT_SMALL", "   It attacks humans by trying to capture them to its so called Pocket Dimension", clr_big_text, true},
			{"BR_TERMINAL_MAIN_TEXT_SMALL", "   Best way to avoid being killed is to always move and run from this SCP when spotted", clr_big_text, true},
			{"BR_TERMINAL_MAIN_TEXT", "3. SCP-457 (Heavy Containment Zone)", clr_highlight_text, true},
			{"BR_TERMINAL_MAIN_TEXT_SMALL", "   SCP-457 is a burning humanoid entity that attacks humans with its fire", clr_big_text, true},
			{"BR_TERMINAL_MAIN_TEXT_SMALL", "   Avoiding this SCP is usually hard but hiding from it is always a good idea", clr_big_text, true},
			{"BR_TERMINAL_MAIN_TEXT", "4. SCP-575 (Entrance Zone)", clr_highlight_text, true},
			{"BR_TERMINAL_MAIN_TEXT_SMALL", "   SCP-575 is an unknown form of matter which attacks humans on while in short range", clr_big_text, true},
			{"BR_TERMINAL_MAIN_TEXT_SMALL", "   The only possible way of avoiding this SCP is to flash the flashlight on it", clr_big_text, true},
			{"BR_TERMINAL_MAIN_TEXT", "5. SCP-049 (Light Containment Zone)", clr_highlight_text, true},
			{"BR_TERMINAL_MAIN_TEXT_SMALL", "   SCP-049 is a hostile humanoid that thinks all normal humans have a disease", clr_big_text, true},
			{"BR_TERMINAL_MAIN_TEXT_SMALL", "   He is always ready to kill any human he sees to remove the disease later", clr_big_text, true},
			{true, "BR_TERMINAL_MAIN_TEXT"}, -- break line
			{"BR_TERMINAL_MAIN_TEXT_SMALL", "These five are the main enemies of players in this gamemode", clr_big_text, true},
			{"BR_TERMINAL_MAIN_TEXT_SMALL", "However they are a small fraction of SCP objects present here", clr_big_text, true},
			{"BR_TERMINAL_MAIN_TEXT_SMALL", "Always stay vigilant and don't trust anything or anybody", clr_big_text, true},
		}

		panel.Paint = function(self, w, h)
			DrawDefaultTerminalBackground(w, h)
			draw_easy_text({12, 8}, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, text_tab)
		end

		BR_CURRENT_TERMINAL_PANEL = panel
	end
end}

local starting_panel_faq = {"FAQ", function(button, panel)
	button.OnClick = function(button, panel)
		local size_mul = ScrH() / 1080
		local clr_big_text = Color(255,255,255,255)
		local clr_small_text = Color(238,190,0,255)
		local clr_highlight_text = Color(255,81,0,255)

		local i_showname = BR2_OURNOTEPAD.people[1].br_showname
		local i_role = BR2_OURNOTEPAD.people[1].br_role
		local i_ci_agent = BR2_OURNOTEPAD.people[1].br_ci_agent

		local text_tab = {
			{"BR_TERMINAL_MAIN_TEXT", "This gamemode has a lot of mechanics, systems, events, items and map interactions", clr_big_text, true},
			{"BR_TERMINAL_MAIN_TEXT", "Which can be pretty overwhelming at times, here is a list of frequently asked questions:", clr_big_text, true},
			{true, "BR_TERMINAL_MAIN_TEXT"}, -- break line
			{"BR_TERMINAL_MAIN_TEXT", "1. How do I pickup items? / How do I start SCP-914? / How do I open terminals?", clr_highlight_text, true},
			{"BR_TERMINAL_MAIN_TEXT", " - When holding hands, use the secondary attack to open actions menu", clr_big_text, true},
			{"BR_TERMINAL_MAIN_TEXT", "2. Why did I randomly die in the LCZ?", clr_highlight_text, true},
			{"BR_TERMINAL_MAIN_TEXT", " - 99% it was SCP-173!", clr_big_text, true},
			{"BR_TERMINAL_MAIN_TEXT", "3. I can't open the checkpoints!", clr_highlight_text, true},
			{"BR_TERMINAL_MAIN_TEXT", " - LCZ has a lockdown system in the surveillance room", clr_big_text, true},
			{"BR_TERMINAL_MAIN_TEXT", " - Entrance Zone can be locked down when SCP-008 is opened", clr_big_text, true},
			{"BR_TERMINAL_MAIN_TEXT", "4. Im dying from the cold outside!", clr_highlight_text, true},
			{"BR_TERMINAL_MAIN_TEXT", " - Find a better outfit in the facility like a hazmat or a guard suit", clr_big_text, true},
			{"BR_TERMINAL_MAIN_TEXT", "5. Some models/textures are errors!", clr_highlight_text, true},
			{"BR_TERMINAL_MAIN_TEXT", " - Check if all addons were downloaded successfully and redownload the ones that didnt", clr_big_text, true},
			{"BR_TERMINAL_MAIN_TEXT", "6. My game is randomly crashing when playing", clr_highlight_text, true},
			{"BR_TERMINAL_MAIN_TEXT", " - Check if the sounds were downloaded properly / check the console for spamming errors", clr_big_text, true},
		}

		panel.Paint = function(self, w, h)
			DrawDefaultTerminalBackground(w, h)
			draw_easy_text({12, 8}, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, text_tab)
		end

		BR_CURRENT_TERMINAL_PANEL = panel
	end
end}

local role_first_texts = {
	isd_agent = {
        "You are an agent from the Internal Security Department INVESTIGATING staff members",
        "After an unexpected Chaos Insurgency attack the facility fell into chaos",
        "Some SCP objects broke containment and class ds are on the loose",
        "Your main focus will be set on finding any CI spies responsible for the breach",
    },
    sd_officer = {
        "You are a guard from the Security Department HAVING THE FACILITY'S STAFF IN CHECK",
        "After an unexpected Chaos Insurgency attack the facility fell into chaos",
        "Some SCP objects broke containment and class ds are on the loose",
        "Find staff members and bring them to safety until the MTF comes",
    },
    janitor = {
        "You are just a janitor, one of many minor staff members in this foundation",
        "After an unexpected Chaos Insurgency attack the facility fell into chaos",
        "Some SCP objects broke containment and class ds are on the loose",
        "Work with guards and other staff members to achieve your goals",
    },
    engineer = {
        "You are an Engineer, one of many minor staff members in this foundation",
        "After an unexpected Chaos Insurgency attack the facility fell into chaos",
        "Some SCP objects broke containment and class ds are on the loose",
        "Work with guards and other staff members to achieve your goals",
    },
    doctor = {
        "You are a medical doctor, one of many minor staff members in this foundation",
        "After an unexpected Chaos Insurgency attack the facility fell into chaos",
        "Some SCP objects broke containment and class ds are on the loose",
        "Work with guards and other staff members to achieve your goals",
	},
	classd = {
        "After an unexpected Chaos Insurgency attack the facility fell into chaos",
        "You don't know who you really are and you don't remember your past",
        "Researchers used you as a guinea pig to test anomalous SCP objects",
        "Stay vigilant, do not trust others because anybody can be your potential enemy",
    },
    researcher = {
        "You are a researcher analyzing strange anomalous SCP objects",
        "After an unexpected Chaos Insurgency attack the facility fell into chaos",
        "Some SCP objects broke containment and class ds are on the loose",
        "Work with guards and other staff members to achieve your goals",
    },
    ci_soldier = {
        "You are a soldier from the Chaos Insurgency involved in the containment breach",
        "Your group brought this facility into real chaos, now its time to finish the job",
        "SCP objects, class ds, guards and researchers are your enemies, kill them",
        "Teamwork with other CI members will be CRUCIAL to win this fight",
    },
    ci_spy = {
        "You are a spy from the Chaos Insurgency involved in the containment breach",
        "Your group brought this facility into real chaos, but for you its not safe",
        "SCP objects, class ds, guards and researchers are your enemies",
        "Steal any valuable information or SCP objects you find in this place",
        "Teamwork with other CI members will be CRUCIAL to win this fight",
	},


	-- DEATHMATCH
    dm_ci = {
		"You are a soldier from the Chaos Insurgency involved in the containment breach",
		"After a long fight with foundation's security, the facility is in your hands",
		"But the Mobile Task Forces were deployed and has entered the facility",
		"They are near the gates in the Entrance Zone, prepare yourselves",
		--"You can either go assault the Entrance Zone or defend the Heavy Containment Zone",
		"You can either go assault them or defend your positions and wait for them to attack",
		"Work with your teammates to achieve complete victory in capturing this facility"
    },
    dm_mtf = {
		"You are an operative in a Mobile Task Force group, fighting to retake this facility",
		"Spies from the Chaos Insurgency broke into our security systems starting the breach",
		"Multiple SCP objects broke free and plunged this facility into complete chaos",
		"These anomalous SCP objects and valuable information were stolen from us",
		"Our group of operatives is here to retake this facility from Chaos Insrugency",
		"Work with your teammates, kill any unathorized personnel and remember to stay vigilant"
    },
}

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

			for k,v in pairs(role_first_texts[next_first_panel_role]) do
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
	next_first_panel_role = str
	--BR_ForceOpen_Terminal(br_starting_panel, "info_terminal")
	--timer.Simple(0.5, function()
		BR_Open_Starting_Terminal(br_starting_panel)
	--end)
end

print("[Breach2] client/derma/menu_firstrole.lua loaded!")
