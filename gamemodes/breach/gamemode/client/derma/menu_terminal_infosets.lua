
local info_set_devices = {"DEVICES", function(button, panel)
	button.OnClick = function(button2, panel)
		for k,v in pairs(panel:GetChildren()) do
			v:Remove()
		end
		panel.posx, panel.posy = panel:GetPos()
		panel.Paint = function(self, w, h)
			DrawDefaultTerminalBackground(w, h)
			local size_mul = ScrH() / 1080
			local clr_big_text = Color(255,255,255,255)
			local texttab = {
				{"BR_TERMINAL_MAIN_TEXT", "TERMINAL DEVICES", clr_big_text, true}
			}

			local any_device_working = false
			for k,v in pairs(terminal_frame.CurrentInfo.devices) do
				if v == true then
					any_device_working = true
				end
			end
			if any_device_working then
				table.ForceInsert(texttab, {"BR_TERMINAL_MAIN_TEXT_SMALL", " Currently working devices:", clr_big_text, true})
				for k,v in pairs(terminal_frame.CurrentInfo.devices) do
					if br2_devices_info[k] then
						table.ForceInsert(texttab, {"BR_TERMINAL_MAIN_TEXT_SMALL", " - "..br2_devices_info[k].name2, Color(25, 139, 209), false})
					end
				end
			else
				table.ForceInsert(texttab, {"BR_TERMINAL_MAIN_TEXT_SMALL", " Currently there are no working devices", Color(255, 0, 0), true})
			end

			local text_w, text_h = draw_easy_text({12, 8}, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, texttab)
		end

		BR_CURRENT_TERMINAL_PANEL = panel
		BR_CURRENT_TERMINAL_PANEL.devices_pop = function(tab)
			local size_mul = ScrH() / 1080
			for i,v in ipairs(tab) do
				local panel_w, panel_h = panel:GetSize()
				
				--terminal_create_button(parent, pos_x, pos_y, size_w, size_h, button_text, func_after_creation)
				--print(panel, size_mul, panel_h, terminal_option_h, br2_devices_info, br2_devices_info[v], button3)
				--print(br2_devices_info[v].name)

				if !IsValid(panel) then error("device terminal panel is invalid") end
				if !istable(br2_devices_info) then error("br2_devices_info is invalid") end
				if !istable(br2_devices_info) then error("devices button3 is invalid") end
				if !istable(br2_devices_info[v.class]) then error("br2_devices_info[v.class] of class "..v.class.." is invalid") end

				terminal_create_button(panel, 16 * size_mul, panel_h - (64 * size_mul) - terminal_option_h, 700, terminal_option_h, "INSTALL: " .. br2_devices_info[v.class].name, function(button3)
					button3.OnClick = function()
						net.Start("br_install_device")
							net.WriteString(v.class)
							net.WriteString(terminal_frame.terminal.name)
						net.SendToServer()
					end
				end)

				/*
				local size_w = 400 * size_mul
				local size_h = 100 * size_mul
				local gap = math.Round(6 * size_mul)

				local p1 = vgui.Create("DPanel", panel)
				p1:SetPos(24 * size_mul, panel_h - (48 * size_mul) - (i * (size_h + gap)))
				p1:SetSize(size_w, size_h)
				p1.Paint = function(self, w, h)
					draw.RoundedBox(0, 0, 0, w, h, Color(255, 255, 255, 255))
				end
				local p1_w, p1_h = p1:GetSize()
				
				local p2 = vgui.Create("DPanel", p1)
				p2:SetPos(gap, gap)
				p2:SetSize(p1_w - (gap * 2), p1_h - (gap * 2))
				p2.Paint = function(self, w, h)
					draw.RoundedBox(0, 0, 0, w, h, Color(34, 34, 34, 255))
				end
				*/
			end
		end

		net.Start("br_get_owned_devices")
		net.SendToServer()
	end
end}

local info_set_system = {"SYSTEM", function(button, panel)
	button.OnClick = function(button2, panel)
		for k,v in pairs(panel:GetChildren()) do
			v:Remove()
		end
		
		panel.posx, panel.posy = panel:GetPos()

		if terminal_frame.terminal.special_functions then
			for k,v in pairs(terminal_frame.terminal.special_functions) do
				if isfunction(v.canUse) and !v.canUse(LocalPlayer()) then
					table.RemoveByValue(terminal_frame.terminal.special_functions, v)
				end
			end
		end

		local spec_functions = terminal_frame.terminal.special_functions or {}

		for k,v in pairs(BR2_SPECIAL_TERMINAL_SETTINGS) do
			local already_in = false

			for k2,v2 in pairs(spec_functions) do
				if v2.name == v.name then
					already_in = true
					break
				end
			end

			if !already_in and isfunction(v.canUse) and v.canUse(LocalPlayer()) then
				table.ForceInsert(spec_functions, v)
			end
		end

		panel.Paint = function(self, w, h)
			DrawDefaultTerminalBackground(w, h)
			local size_mul = ScrH() / 1080
			local clr_big_text = Color(255,255,255,255)
			local texttab = {
				{"BR_TERMINAL_MAIN_TEXT", "TERMINAL SYSTEM FUNCTIONS/SETTINGS", clr_big_text, true}
			}

			if spec_functions == nil or #spec_functions == 0 then
				table.ForceInsert(texttab, {"BR_TERMINAL_MAIN_TEXT_SMALL", " Currently there are no functions or settings in this terminal", Color(255, 0, 0), true})
			end
			

			local text_w, text_h = draw_easy_text({12, 8}, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, texttab)
		end

		if istable(spec_functions) then
			local size_mul = ScrH() / 1080
			local scaled_option_h = terminal_option_h * size_mul

			for i,v in ipairs(spec_functions) do
				local panel_w, panel_h = panel:GetSize()
				
				terminal_create_button(
					panel,
					16 * size_mul,
					(panel_h - (64 * size_mul) - ((scaled_option_h) * (i - 1)) - scaled_option_h) - (i*16 * size_mul),
					v.button_size,
					terminal_option_h,
					v.name,
					function(button3)
						button3.OnClick = function()
							net.Start("br_use_terminal_function")
								net.WriteString(v.class)
							net.SendToServer()
						end
					end
				)
			end
		end

		--net.Start("br_get_terminal_settings")
		--net.SendToServer()
	end
end}

local info_set_information = {"INFO", function(button, panel)
	button.OnClick = function(button, panel)
		for k,v in pairs(panel:GetChildren()) do
			v:Remove()
		end

		local created_button = false
		panel.posx, panel.posy = panel:GetPos()
		panel.Paint = function(self, w, h)
			DrawDefaultTerminalBackground(w, h)
		end

		BR_CURRENT_TERMINAL_PANEL = panel
	end
end}

TERMINAL_INFOS = {
	TERMINAL_INFO_GENERIC = {
		{"STATUS", function(button, panel)
			button.OnClick = function(button, panel)
				for k,v in pairs(panel:GetChildren()) do
					v:Remove()
				end

				panel.Paint = function(self, w, h)
					DrawDefaultTerminalBackground(w, h)
					local size_mul = ScrH() / 1080
					local clr_big_text = Color(255,255,255,255)
					local texttab = {
						{"BR_TERMINAL_MAIN_TEXT", "SITE STATUS AND NOTIFICATIONS", clr_big_text, true}
					}
					local redcolor = Color(255,0,0)
					table.Add(texttab, {
						{"BR_TERMINAL_MAIN_TEXT_SMALL", " The Site is currently experiencing containment breaches of:", redcolor, true},
						{"BR_TERMINAL_MAIN_TEXT_SMALL", " SCP-173, SCP-106, SCP-096, SCP-939, SCP-575, SCP-457, SCP-049, SCP-035", redcolor, true},
						{true, "BR_TERMINAL_MAIN_TEXT"}, -- break line
						{"BR_TERMINAL_MAIN_TEXT_SMALL", " A Site Lockdown has been initiated", redcolor, true},
						{"BR_TERMINAL_MAIN_TEXT_SMALL", " All personnnel are advised to stay in the evacuation shelters", redcolor, true},
						{"BR_TERMINAL_MAIN_TEXT_SMALL", " Await further instructions from security personnel", redcolor, true},
					})
					local text_w, text_h = draw_easy_text({12, 8}, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, texttab)
				end

				BR_CURRENT_TERMINAL_PANEL = panel
			end
		end},
		/*
		{"INFO", function(button, panel)
			button.OnClick = function(button, panel)
				for k,v in pairs(panel:GetChildren()) do
					v:Remove()
				end
				
				local size_mul = ScrH() / 1080
				panel.Paint = function(self, w, h)
					DrawDefaultTerminalBackground(w, h)
					draw.Text({
						text = "SITE INFORMATION SYSTEM",
						pos = {12, 8},
						xalign = TEXT_ALIGN_LEFT,
						yalign = TEXT_ALIGN_TOP,
						font = "BR_TERMINAL_MAIN_TEXT",
						color = Color(255,255,255)
					})
				end
				
				local panel_w, panel_h = panel:GetSize()
				
				local gap = math.Round(6 * size_mul)
				local p1 = vgui.Create("DPanel", panel)
				p1:SetPos(32 * size_mul, (32 * 2) * size_mul)
				p1:SetSize(512 * size_mul, panel_h - ((32 * 4) * size_mul))
				p1.Paint = function(self, w, h)
					draw.RoundedBox(0, 0, 0, w, h, Color(255, 255, 255, 255))
				end
				local p1_w, p1_h = p1:GetSize()
				
				local p2 = vgui.Create("DPanel", p1)
				p2:SetPos(gap, gap)
				p2:SetSize(p1_w - (gap * 2), p1_h - (gap * 2))
				p2.Paint = function(self, w, h)
					draw.RoundedBox(0, 0, 0, w, h, Color(34, 34, 34, 255))
				end

				BR_CURRENT_TERMINAL_PANEL = panel
			end
		end},
		*/
		info_set_camera,
		info_set_devices,
		info_set_system
	}
}

--lua_run_cl BR_ForceOpen_Terminal(br_terminal_mtf, "mobile_task_force_terminal_1")
br_terminal_mtf = {
	{"BRIEFING", function(button, panel)
		button.OnClick = function(button, panel)
			panel.Paint = function(self, w, h)
				DrawDefaultTerminalBackground(w, h)
				local size_mul = ScrH() / 1080
				local clr_big_text = Color(255,255,255,255)
				local clr_small_text = Color(238, 190, 0, 255)
				local clr_highlight_text = Color(255,81,0,255)

				draw_easy_text({12, 8}, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, {
					{"BR_TERMINAL_MAIN_TEXT", "Mobile Task Force", clr_big_text, false},
					{"BR_TERMINAL_MAIN_TEXT", " Unit Epsilon-11-A", clr_highlight_text, true},
					{"BR_TERMINAL_MAIN_TEXT_SMALL", " Cedric Allen (Team Leader)", clr_small_text, true},
					{"BR_TERMINAL_MAIN_TEXT_SMALL", " Bryson Pilcher", clr_small_text, true},
					{"BR_TERMINAL_MAIN_TEXT_SMALL", " Xander Bright", clr_small_text, true},
					{"BR_TERMINAL_MAIN_TEXT_SMALL", " Raphael Felton", clr_small_text, true},
					{"BR_TERMINAL_MAIN_TEXT", "Mission:", clr_big_text, true},
					{"BR_TERMINAL_MAIN_TEXT_SMALL", " Recontain remaining 6 SCP Objects", clr_small_text, true},
					{"BR_TERMINAL_MAIN_TEXT_SMALL", " Rescue all personnel", clr_small_text, true},
					{"BR_TERMINAL_MAIN_TEXT_SMALL", " Terminate rogue Class D Personnel", clr_small_text, true},
					{"BR_TERMINAL_MAIN_TEXT_SMALL", " Turn on the main generators", clr_small_text, true},
					{"BR_TERMINAL_MAIN_TEXT", "Location: ", clr_big_text, false},
					{"BR_TERMINAL_MAIN_TEXT", "Site-19", clr_highlight_text, true},
					{true, "BR_TERMINAL_MAIN_TEXT"}, -- break line
					{"BR_TERMINAL_MAIN_TEXT", "Multiple Keter and Euclid level containment breaches have", clr_big_text, true},
					{"BR_TERMINAL_MAIN_TEXT", "been reported, lockdown procedures were initiated.", clr_big_text, true},
					{true, "BR_TERMINAL_MAIN_TEXT"}, -- break line
					{"BR_TERMINAL_MAIN_TEXT", "All communication with the facility has been severed to", clr_big_text, true},
					{"BR_TERMINAL_MAIN_TEXT", "prevent memetic contamination.", clr_big_text, true},
				})
				local mtf_logo_size = 327 * size_mul
				surface.SetDrawColor(Color(255,255,255,255))
				surface.SetMaterial(br2_mtf_epsilon11_2)
				surface.DrawTexturedRect(w-mtf_logo_size-16, 16, mtf_logo_size, mtf_logo_size)
				surface.SetMaterial(br2_mtf_epsilon11_1)
				surface.DrawTexturedRect(w-mtf_logo_size-16, 16, mtf_logo_size, mtf_logo_size)
				draw.Text({
					text = "EPSILON-11",
					pos = {w-(mtf_logo_size/2)-16, mtf_logo_size+20},
					xalign = TEXT_ALIGN_CENTER,
					yalign = TEXT_ALIGN_TOP,
					font = "BR_TERMINAL_MTF_NAME",
					color = Color(255, 255, 255, 255)
				})
			end

			BR_CURRENT_TERMINAL_PANEL = panel
		end
	end},
	{"EQUIPMENT", function(button, panel)
		button.OnClick = function(button, panel)
			panel.Paint = function(self, w, h)
				draw.RoundedBox(0, 0, 0, w, h, Color(34, 34, 34, 255))
			end

			BR_CURRENT_TERMINAL_PANEL = panel
		end
	end},
	{"OVERVIEW", function(button, panel)
		button.OnClick = function(button, panel)
			panel.Paint = function(self, w, h)
				draw.RoundedBox(0, 0, 0, w, h, Color(34, 34, 34, 255))
			end

			BR_CURRENT_TERMINAL_PANEL = panel
		end
	end},
}

print("[Breach2] client/derma/menu_terminal_infosets.lua loaded!")
