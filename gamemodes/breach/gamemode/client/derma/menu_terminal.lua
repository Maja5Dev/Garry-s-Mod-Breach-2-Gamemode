
function draw_easy_text(spos, align_x, align_y, tab)
	local texttab = table.Copy(tab)

	local wpos_x = spos[1]
	local wpos_y = spos[2]

	local ptext = {
		text = "",
		pos = {wpos_x, wpos_y},
		xalign = align_x,
		yalign = align_y,
		font = "DermaLarge",
		color = Color(255, 255, 255, 255)
	}

	for k,v in pairs(texttab) do
		if v[1] == true then
			surface.SetFont(v[2])
			local cpos_x, cpos_y = surface.GetTextSize("ok")
			wpos_y = wpos_y + cpos_y
		else
			ptext.text = v[2]
			ptext.color = v[3]
			ptext.font = v[1]
			surface.SetFont(v[1])
			local cpos_x, cpos_y = surface.GetTextSize(v[2])
			if istable(v[5]) then
				wpos_x = wpos_x + v[5][1]
				wpos_y = wpos_y + v[5][2]
			end
			ptext.pos = {wpos_x, wpos_y}
			draw.Text(ptext)
			if v[4] != nil then
				if v[4] == true then
					wpos_y = wpos_y + cpos_y
					wpos_x = spos[1]
				else
					wpos_x = wpos_x + cpos_x
				end
			end
		end
	end
	return wpos_x, wpos_y
end

terminal_all_buttons = {}
terminal_option_w = 320
terminal_option_h = 79

function terminal_create_button(parent, pos_x, pos_y, size_w, size_h, button_text, func_after_creation)
	local size_mul = ScrH() / 1080
	local terminal_button = vgui.Create("DButton", parent)
	terminal_button:SetText("")
	terminal_button:SetPos(pos_x, pos_y)
	terminal_button:SetSize(size_w*size_mul, size_h*size_mul)
	terminal_button.original_x, terminal_button.original_y = terminal_button:GetPos()
	terminal_button.real_x = terminal_button.original_x + parent.posx
	terminal_button.real_y = terminal_button.original_y + parent.posy
	terminal_button.original_w, terminal_button.original_h = terminal_button:GetSize()
	terminal_button.isHovered = false
	terminal_button.ClickFix = false
	terminal_button.OnClick = nil
	terminal_button.Paint = function(self, w, h)
		local cur_x, cur_y = input.GetCursorPos()
		local dis_x = math.abs(cur_x - (self.real_x+(w/2)))
		local dis_y = math.abs(cur_y - (self.real_y+(h/2)))
		local font_to_use = "BR_TERMINAL_BUTTON"
		if self.isHovered then
			font_to_use = "BR_TERMINAL_BUTTON_HOVER"
			self:SetPos(self.original_x + 4, self.original_y + 4)
			self:SetSize(self.original_w - 8, self.original_h - 8)
			if dis_x > (w / 2 + 8) or dis_y > (h / 2 + 8) then
				self.isHovered = false
			end
			if terminal_button.OnClick != nil then
				if input.IsMouseDown(MOUSE_LEFT) then
					if terminal_button.ClickFix == false then
						terminal_button.OnClick(terminal_button, terminal_text_panel)
						surface.PlaySound("breach2/Button.ogg")
						terminal_button.ClickFix = true
					end
				else
					terminal_button.ClickFix = false
				end
			end
		else
			self:SetPos(self.original_x, self.original_y)
			self:SetSize(self.original_w, self.original_h)
			if dis_x < (w/2) and dis_y < (h/2) then
				self.isHovered = true
				--surface.PlaySound("breach2/ui/hover.wav")
			end
		end
		draw.RoundedBox(0, 0, 0, w, h, Color(255, 255, 255, 255))
		draw.RoundedBox(0, 5, 5, w - 10, h - 10, Color(30, 30, 30, 255))
		draw.Text({
			text = button_text,
			pos = {w/2, h/2},
			xalign = TEXT_ALIGN_CENTER,
			yalign = TEXT_ALIGN_CENTER,
			font = font_to_use,
			color = Color(255,255,255,255),
		})
	end
	func_after_creation(terminal_button, terminal_text_panel)
	if parent == terminal_options_panel then
		table.ForceInsert(terminal_all_buttons, terminal_button)
	end
	return terminal_button
end

br2_scp_logo1 = Material("breach2/scp_logo_1.png", "noclamp smooth")
br2_scp_logo2 = Material("breach2/scp_logo_2.png", "noclamp smooth")

br2_scp_text1 = Material("breach2/scp_text_1.png", "noclamp smooth")
br2_scp_text2 = Material("breach2/scp_text_2.png", "noclamp smooth")

br2_mtf_epsilon11_1 = Material("breach2/mtf_epsilon11_1.png", "noclamp smooth")
br2_mtf_epsilon11_2 = Material("breach2/mtf_epsilon11_2.png", "noclamp smooth")

br2_camera_logo_1 = Material("breach2/camera1.png", "noclamp smooth")
br2_camera_logo_2 = Material("breach2/camera2.png", "noclamp smooth")

br2_warning_1 = Material("breach2/warning.png", "noclamp smooth")
br2_warning_2 = Material("breach2/warning_red.png", "noclamp smooth")

function DrawDefaultTerminalBackground(w, h)
	draw.RoundedBox(0, 0, 0, w, h, Color(34, 34, 34, 255))
	draw.Text({
		text = os.date("%H:%M:%S - %d/%m/%Y" , os.time()),
		pos = {w-12, h-8},
		xalign = TEXT_ALIGN_RIGHT,
		yalign = TEXT_ALIGN_BOTTOM,
		font = "BR_TERMINAL_DATE_TEXT",
		color = Color(120, 120, 120, 255)
	})
	local txt2 = string.upper(terminal_frame.terminal.name)
	if txt2 != "" then
		draw.Text({
			text = "TERMINAL: "..txt2,
			pos = {12, h-8},
			xalign = TEXT_ALIGN_LEFT,
			yalign = TEXT_ALIGN_BOTTOM,
			font = "BR_TERMINAL_DATE_TEXT",
			color = Color(120, 120, 120, 255)
		})
	end
end

br2_devices_info = {
	["device_cameras"] = {
		name = "WCR [CAMERAS]",
		name2 = "Wireless Camera Receiver",
	}
}

function create_terminal_fonts()
	local size_mul = ScrH() / 1080
	
	local font_structure = {
		font = "Tahoma",
		extended = false,
		size = 56 * size_mul,
		weight = 1000,
		blursize = 0,
		scanlines = 0,
		antialias = true,
		underline = false,
		italic = false,
		strikeout = false,
		symbol = false,
		rotary = false,
		shadow = false,
		additive = false,
		outline = false,
	}
	surface.CreateFont("BR_TERMINAL_BUTTON", font_structure)
	
	font_structure.size = font_structure.size * 0.9
	surface.CreateFont("BR_TERMINAL_BUTTON_HOVER", font_structure)
	
	font_structure.size = 54 * size_mul
	surface.CreateFont("BR_ACCESS_TERMINAL_1", font_structure)
	
	font_structure.size = 42 * size_mul
	surface.CreateFont("BR_ACCESS_TERMINAL_2", font_structure)
	
	font_structure.italic = true
	surface.CreateFont("BR_ACCESS_TERMINAL_2_IT", font_structure)
	
	font_structure.size = 40 * size_mul
	font_structure.italic = false
	surface.CreateFont("BR_ACCESS_TERMINAL_3", font_structure)
	
	font_structure.size = 24 * size_mul
	surface.CreateFont("BR_ACCESS_TERMINAL_4", font_structure)
	
	font_structure.size = 36 * size_mul
	surface.CreateFont("BR_TERMINAL_MAIN_TEXT", font_structure)
	
	font_structure.size = font_structure.size * 0.9
	surface.CreateFont("BR_TERMINAL_MAIN_TEXT_SMALL", font_structure)
	
	font_structure.size = 30 * size_mul
	surface.CreateFont("BR_TERMINAL_DATE_TEXT", font_structure)
	
	font_structure.size = 58 * size_mul
	font_structure.font = "Lorimer No 2 Stencil"
	surface.CreateFont("BR_TERMINAL_INFO_BIG", font_structure)
	
	font_structure.size = 42 * size_mul
	surface.CreateFont("BR_TERMINAL_INFO_MEDIUM", font_structure)
	
	font_structure.size = 400 * size_mul
	font_structure.font = "Lorimer No 2 Stencil"
	surface.CreateFont("BR_TERMINAL_LOGO", font_structure)
	
	font_structure.size = 40 * size_mul
	surface.CreateFont("BR_TERMINAL_LOGO_SMALL", font_structure)
	
	font_structure.size = 60 * size_mul
	font_structure.font = "Tahoma"
	surface.CreateFont("BR_TERMINAL_MTF_NAME", font_structure)
	font_structure.size = 50 * size_mul
	surface.CreateFont("BR_TERMINAL_CAMERA_NAME", font_structure)
	font_structure.size = 40 * size_mul
	surface.CreateFont("BR_TERMINAL_CAMERA_NAME_SMALL", font_structure)
end

function BR_ForceOpen_Terminal(info, name)
	create_terminal_fonts()
	BR_Open_Terminal(info)
	terminal_frame.CurrentInfo = info
	terminal_frame.terminal = {name	= name}
end

function BR_Access_BrokenTerminal(terminal)
	net.Start("br_open_brokenterminal")
		net.WriteVector(terminal.pos)
	net.SendToServer()
end

--lua_run_cl BR_Open_Terminal(br_terminal_mtf)
function BR_Open_Terminal(options, loginInfo)
	local client = LocalPlayer()
	local scrw = ScrW()
	local scrh = ScrH()
	local size_mul = scrh / 1080

	terminal_frame = vgui.Create("DFrame")
	terminal_frame:ShowCloseButton(false)
	terminal_frame:SetSizable(false)
	terminal_frame:SetDraggable(false)
	terminal_frame:SetDeleteOnClose(true)
	terminal_frame:Dock(FILL)
	terminal_frame:SetTitle("")
	terminal_frame:MakePopup()
	terminal_frame.Paint = function(self, w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(255, 255, 255, 255))
		if input.IsKeyDown(KEY_ESCAPE) then
			terminal_frame:Remove()
		end
	end
	terminal_frame.OnRemove = function()
		--surface.PlaySound("breach2/ui/recorder_off.ogg")
	end
	
	terminal_frame.options = options

	terminal_logo_panel = vgui.Create("DPanel", terminal_frame)
	terminal_logo_panel:SetPos(0, 0)
	terminal_logo_panel:SetSize(498 * size_mul, 190 * size_mul)
	terminal_logo_panel.Paint = function(self, w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(25, 25, 25, 255))
		draw.Text({
			text = "SECURE CONTAIN PROTECT",
			pos = {w/2, h-8},
			xalign = TEXT_ALIGN_CENTER,
			yalign = TEXT_ALIGN_BOTTOM,
			font = "BR_TERMINAL_LOGO_SMALL",
			color = Color(255,255,255,255),
		})
		surface.SetDrawColor(Color(255,255,255,255))
		local logo_size = 134 * size_mul
		surface.SetMaterial(br2_scp_logo2)
		surface.DrawTexturedRect(w - logo_size - 4, 4, logo_size, logo_size)
		surface.SetMaterial(br2_scp_logo1)
		surface.DrawTexturedRect(w - logo_size - 4, 4, logo_size, logo_size)
		surface.SetMaterial(br2_scp_text1)
		surface.DrawTexturedRect(0, 0, 498 * size_mul, 190 * size_mul)
	end
	
	terminal_info_panel = vgui.Create("DPanel", terminal_frame)
	terminal_info_panel:SetPos(519*size_mul, 0)
	terminal_info_panel:SetSize(1401*size_mul, 190*size_mul)
	terminal_info_panel.Paint = function(self, w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(37, 37, 37, 255))

		draw.Text({
			text = "S-COM SOFTWARE",
			pos = {16, h*0.25},
			xalign = TEXT_ALIGN_LEFT,
			yalign = TEXT_ALIGN_CENTER,
			font = "BR_TERMINAL_INFO_BIG",
			color = Color(255,255,255,255),
		})

		draw.Text({
			text = "version: 2.0.0",
			pos = {16, h*0.65},
			xalign = TEXT_ALIGN_LEFT,
			yalign = TEXT_ALIGN_CENTER,
			font = "BR_TERMINAL_INFO_BIG",
			color = Color(255,255,255,255),
		})

		draw.Text({
			text = "Logged in as:",
			pos = {w - 16, 16},
			xalign = TEXT_ALIGN_RIGHT,
			yalign = TEXT_ALIGN_TOP,
			font = "BR_TERMINAL_INFO_MEDIUM",
			color = Color(255,255,255,255),
		})

		draw.Text({
			text = loginInfo.nick,
			pos = {w - 16, 42 * size_mul + 12},
			xalign = TEXT_ALIGN_RIGHT,
			yalign = TEXT_ALIGN_TOP,
			font = "BR_TERMINAL_INFO_MEDIUM",
			color = Color(255,255,255,255),
		})
	end
	
	terminal_text_panel = vgui.Create("DPanel", terminal_frame)
	terminal_text_panel:SetPos(372 * size_mul, 211 * size_mul)
	terminal_text_panel:SetSize(1548 * size_mul, 870 * size_mul)
	terminal_text_panel.Paint = function(self, w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(34, 34, 34, 255))
	end
	
	terminal_options_panel = vgui.Create("DPanel", terminal_frame)
	terminal_options_panel:SetPos(0, 211 * size_mul)
	terminal_options_panel:SetSize(351 * size_mul, 870 * size_mul)
	terminal_options_panel.posx, terminal_options_panel.posy = terminal_options_panel:GetPos()
	terminal_options_panel.CreatedPanels = {}
	terminal_options_panel.Paint = function(self, w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(37, 37, 34, 255))
	end
	
	terminal_all_buttons = {}
	
	for i,v in ipairs(options) do
		terminal_create_button(terminal_options_panel, ((351 * size_mul) - (terminal_option_w * size_mul)) / 2, 16 + ((i - 1) * ((terminal_option_h * size_mul) + 16)), terminal_option_w, terminal_option_h, v[1], function(button, panel)
		--terminal_create_button(terminal_options_panel, 16, 16 + ((i - 1) * ((terminal_option_h * size_mul) + 16)), terminal_option_w, terminal_option_h, v[1], function(button, panel)
			v[2](button, panel)
		end)
	end
	
	terminal_create_button(terminal_options_panel, ((351 * size_mul) - (terminal_option_w * size_mul)) / 2, (870 * size_mul) - (terminal_option_h * size_mul) - 8, terminal_option_w, terminal_option_h, "EXIT", function(button)
		button.OnClick = function()
			terminal_frame:Close()
		end
	end)
	
	if #terminal_all_buttons > 0 then
		if terminal_all_buttons[1].OnClick then
			terminal_all_buttons[1].OnClick(terminal_all_buttons[1], terminal_text_panel)
		end
	end
end

print("[Breach2] client/derma/menu_terminal.lua loaded!")
