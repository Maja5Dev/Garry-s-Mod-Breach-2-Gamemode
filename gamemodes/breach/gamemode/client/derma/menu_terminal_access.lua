
function BR_Hack_Terminal(logins)
	if !IsValid(access_terminal) then
		return
	end

	local size_mul = ScrH() / 1080
	local font_size = 25 * size_mul

	size_mul = ScrH() / 1440

	terminal_hack_panel = vgui.Create("DFrame")
	terminal_hack_panel:ShowCloseButton(true)
	terminal_hack_panel:SetSizable(false)
	terminal_hack_panel:SetDraggable(true)
	terminal_hack_panel:Center()
	terminal_hack_panel:SetTitle("")
	terminal_hack_panel:MakePopup()
	terminal_hack_panel:SetSize(700 * size_mul, 600 * size_mul)
	terminal_hack_panel.Paint = function(self, w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(25,25,25,150))
	end

	local scroll_panel = vgui.Create("DScrollPanel", terminal_hack_panel)
	scroll_panel:Dock(FILL)

	for k,v in pairs(logins) do
		local info = scroll_panel:Add("DPanel")
		info:SetSize(700 * size_mul, 96 * size_mul)
		info:Dock(TOP)
		info.Paint = function(self, w, h)
			draw.RoundedBox(0, 0, 0, w, h, Color(255,255,255,200))
			draw.RoundedBox(0, 4, 4, w-8, h-8, Color(25, 25, 25, 255))

			draw.Text({
				text = "Login: " .. v.login,
				pos = {8, 10},
				xalign = TEXT_ALIGN_LEFT,
				yalign = TEXT_ALIGN_TOP,
				font = "BR_TERMINAL_HACKING",
				color = Color(255,255,255,235),
			})

			draw.Text({
				text = "Password: " .. v.password,
				pos = {8, h - 10},
				xalign = TEXT_ALIGN_LEFT,
				yalign = TEXT_ALIGN_BOTTOM,
				font = "BR_TERMINAL_HACKING",
				color = Color(255,255,255,235),
			})

			draw.Text({
				text = v.nick,
				pos = {w - 10 - (120 * size_mul), 10},
				xalign = TEXT_ALIGN_RIGHT,
				yalign = TEXT_ALIGN_TOP,
				font = "BR_TERMINAL_HACKING",
				color = Color(255,255,255,235),
			})
		end

		local use_button = vgui.Create("DButton", info)
		use_button:SetSize(120 * size_mul, 0)
		use_button:Dock(RIGHT)
		use_button:DockPadding(120 * size_mul, 0, 0, 0)
		use_button:SetText("")
		use_button.DoClick = function(self)
			if IsValid(access_terminal.panel_login) then
				access_terminal.panel_login:SetText(v.login)
				access_terminal.panel_password:SetText(v.password)
				surface.PlaySound("breach2/Button.ogg")
			end
		end
		use_button.Paint = function(self, w, h)
			draw.RoundedBox(0, 0, 0, w, h, Color(255,255,255,200))
			draw.RoundedBox(0, 4, 4, w-8, h-8, Color(35, 35, 35, 255))

			draw.Text({
				text = "USE",
				pos = {w/2, h/2},
				xalign = TEXT_ALIGN_CENTER,
				yalign = TEXT_ALIGN_CENTER,
				font = "BR_TERMINAL_HACKING",
				color = Color(255,255,255,235),
			})
		end

		info:DockMargin(0, 0, 0, 10)
	end
end

function BR_Access_Terminal(terminal)
	create_terminal_fonts()
	
	if IsValid(access_terminal) then
		return
	end

	local size_mul = ScrH() / 1080
	local size_w = math.Clamp(ScrW() / 3.5, 400, ScrW())
	local size_h = math.Clamp(ScrH() / 3.5, 225, ScrH())
	access_terminal = vgui.Create("DFrame")
	access_terminal:ShowCloseButton(false)
	access_terminal:SetSizable(false)
	access_terminal:SetDraggable(true)
	access_terminal:SetSize(size_w, size_h)
	access_terminal:SetPos(ScrW()/2 - (size_w/2), ScrH()/2 - (size_h/2))
	access_terminal:SetDeleteOnClose(false)
	access_terminal:SetTitle("")
	access_terminal:MakePopup()
	access_terminal.bad_password_end = 0
	local gap = 8
	access_terminal.Paint = function(self, w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(25,25,25,140))
		draw.RoundedBox(0, gap, gap, w-(gap*2), h-(gap*2), Color(4, 4, 4, 180))
		
		if input.IsKeyDown(KEY_ESCAPE) then
			self:Remove()
			gui.HideGameUI()
		elseif input.IsKeyDown(KEY_ENTER) then
			--if (#panel_2:GetText() > 0) and (#panel_3:GetText() > 0) then
				BR_Access_Terminal_Loading(terminal)
				surface.PlaySound("breach2/Button.ogg")
			--end
		end
		if access_terminal.bad_password_end > CurTime() then
			draw.Text({
				text = "ERR_BAD_PASSWORD",
				pos = {w/2, h/2},
				xalign = TEXT_ALIGN_CENTER,
				yalign = TEXT_ALIGN_TOP,
				font = "BR_ACCESS_TERMINAL_1",
				color = Color(255,0,0,255),
			})
		end
	end
	
	local panel_w = size_w - (gap * 4)
	local panel_h = (size_h / 3) - (gap * 2)
	
	local panel_1 = vgui.Create("DPanel", access_terminal)
	panel_1:SetSize(panel_w, panel_h)
	panel_1:SetPos(gap * 2, gap * 2)
	local last_y = panel_h + gap
	panel_1.Paint = function(self, w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(50,50,50,200))
		draw.Text({
			text = "S-COM SOFTWARE",
			pos = {8, 4},
			xalign = TEXT_ALIGN_LEFT,
			yalign = TEXT_ALIGN_TOP,
			font = "BR_ACCESS_TERMINAL_3",
			color = Color(240,240,240,255),
		})
		draw.Text({
			text = "UNAUTHORIZED ACCESS STRICTLY PROHIBITED",
			pos = {w/2, h - 4},
			xalign = TEXT_ALIGN_CENTER,
			yalign = TEXT_ALIGN_BOTTOM,
			font = "BR_ACCESS_TERMINAL_4",
			color = Color(230,0,0,255),
		})
		local size = 40 * size_mul
		surface.SetDrawColor(200,200,0,255)
		surface.SetMaterial(br2_warning_1)
		surface.DrawTexturedRect(w - size - 8, 4, size, size)
		/*
		draw.RoundedBox(0, 0, 0, w, h, Color(100,100,100,200))
		draw.Text({
			text = "Access the terminal",
			pos = {w/2, h/2},
			xalign = TEXT_ALIGN_CENTER,
			yalign = TEXT_ALIGN_CENTER,
			font = "BR_ACCESS_TERMINAL_1",
			color = Color(255,255,255,255),
		})
		*/
	end
	
	local panel_2 = vgui.Create("DTextEntry", access_terminal)
	panel_2:SetSize(panel_w, panel_h * 0.7)
	panel_2:SetPos(gap * 2, last_y + gap * 2)
	last_y = last_y + (panel_h * 0.7) + (gap * 2)
	panel_2.Paint = function(self, w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(50,50,50,180))
		local dtext = self:GetText()
		local dcolor = Color(255,255,255,140)
		local dfont = "BR_ACCESS_TERMINAL_2"
		if #dtext < 1 then
			dtext = "Input login here"
			dcolor = Color(255,255,255,20)
			dfont = "BR_ACCESS_TERMINAL_2_IT"
		end
		draw.Text({
			text = dtext,
			pos = {10, h/2},
			xalign = TEXT_ALIGN_LEFT,
			yalign = TEXT_ALIGN_CENTER,
			font = dfont,
			color = dcolor,
		})
	end
	
	local panel_3 = vgui.Create("DTextEntry", access_terminal)
	panel_3:SetSize(panel_w, panel_h * 0.7)
	panel_3:SetPos(gap*2, last_y + gap)
	last_y = last_y + (panel_h * 0.7) + (gap * 2)
	panel_3.Paint = function(self, w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(50,50,50,180))

		local dtext = self:GetText()
		local dcolor = Color(255,255,255,140)
		local dfont = "BR_ACCESS_TERMINAL_2"
		if #dtext < 1 then
			dtext = "Input password here"
			dcolor = Color(255,255,255,20)
			dfont = "BR_ACCESS_TERMINAL_2_IT"
		else
			dtext = ""
			for i=1, #self:GetText() do
				dtext = dtext .. "*"
			end
		end
		draw.Text({
			text = dtext,
			pos = {10, h/2},
			xalign = TEXT_ALIGN_LEFT,
			yalign = TEXT_ALIGN_CENTER,
			font = dfont,
			color = dcolor,
		})
	end

	local findLogin = nil
	local findPassword = nil
	if istable(BR2_OURNOTEPAD) and istable(BR2_OURNOTEPAD.automated_info) then
		for k,v in pairs(BR2_OURNOTEPAD.automated_info) do
			if string.find(v, "login: ") then
				findLogin, findPassword = string.match(v, "login:%s*(.-)\n%s*- password:%s*(.-)\n")
			end
		end
	end

	if findLogin and findPassword then
		local panel_4 = vgui.Create("DPanel", access_terminal)
		panel_4:SetSize(panel_w, panel_h * 0.7)
		panel_4:SetPos(gap*2, last_y + gap)
		last_y = last_y + (panel_h * 0.7) + (gap * 2)
		panel_4.Paint = function(self, w, h)
		end

		local button_use_id_card = vgui.Create("DButton", panel_4)
		button_use_id_card:SetSize(panel_w * 0.8, (panel_h * 0.7) * 0.8)
		button_use_id_card:SetText("")
		button_use_id_card:Center()

		button_use_id_card.Paint = function(self, w, h)
			draw.RoundedBox(0, 0, 0, w, h, Color(255,255,255,160))
			draw.RoundedBox(0, 4, 4, w-8, h-8, Color(0,0,0,255))

			draw.Text({
				text = "Use personal id card",
				pos = {w/2, h/2},
				xalign = TEXT_ALIGN_CENTER,
				yalign = TEXT_ALIGN_CENTER,
				font = "BR_ACCESS_TERMINAL_2_SMALL",
				color = Color(255,255,255,170),
			})
		end
		button_use_id_card.DoClick = function(self)
			panel_2:SetText(findLogin)
			panel_3:SetText(findPassword)
			surface.PlaySound("breach2/Button.ogg")
		end
	end

	if LocalPlayer().br_role == ROLE_CI_SOLDIER then
		local panel_5 = vgui.Create("DPanel", access_terminal)
		panel_5:SetSize(panel_w, panel_h * 0.7)
		panel_5:SetPos(gap*2, last_y + gap)
		last_y = last_y + (panel_h * 0.7) + (gap * 2)
		panel_5.Paint = function(self, w, h)
		end

		local button_use_id_card = vgui.Create("DButton", panel_5)
		button_use_id_card:SetSize(panel_w * 0.8, (panel_h * 0.7) * 0.8)
		button_use_id_card:SetText("")
		button_use_id_card:Center()

		button_use_id_card.Paint = function(self, w, h)
			draw.RoundedBox(0, 0, 0, w, h, Color(255,255,255,160))
			draw.RoundedBox(0, 4, 4, w-8, h-8, Color(0,0,0,255))

			draw.Text({
				text = "Hack into the terminal",
				pos = {w/2, h/2},
				xalign = TEXT_ALIGN_CENTER,
				yalign = TEXT_ALIGN_CENTER,
				font = "BR_ACCESS_TERMINAL_2_SMALL",
				color = Color(255,255,255,170),
			})
		end
		button_use_id_card.DoClick = function(self)
			net.Start("br_hack_terminal")
				net.WriteString(terminal.name)
			net.SendToServer()

			surface.PlaySound("breach2/Button.ogg")
		end
	end
	
	access_terminal:SetSize(size_w, last_y + gap)
	
	access_terminal.panel_login = panel_2
	access_terminal.panel_password = panel_3
end

print("[Breach2] client/derma/menu_terminal_access.lua loaded!")
