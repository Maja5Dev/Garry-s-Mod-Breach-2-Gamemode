
function BR_Open_Starting_Terminal(options)
	create_terminal_fonts()

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
	end
	terminal_frame.OnRemove = function()
		surface.PlaySound("breach2/heartbeat.ogg")
		reset_our_last_zone()
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
		local timeu = round_starting_end - CurTime()
		if timeu < 0 then
			terminal_frame:Remove()
			br2_blackscreen = 0
			--surface.PlaySound("breach2/heartbeat.ogg")
			return
		end

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
			text = "GAME STARTING IN "..math.Round(timeu).."s",
			pos = {w - 16, h * 0.25},
			xalign = TEXT_ALIGN_RIGHT,
			yalign = TEXT_ALIGN_CENTER,
			font = "BR_TERMINAL_INFO_BIG",
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
			v[2](button, panel)
		end)
	end
	
	if #terminal_all_buttons > 0 then
		if terminal_all_buttons[1].OnClick then
			terminal_all_buttons[1].OnClick(terminal_all_buttons[1], terminal_text_panel)
		end
	end

	terminal_frame.CurrentInfo = options
	terminal_frame.terminal = {name	= ""}
end

print("[Breach2] client/derma/menu_terminal_starting.lua loaded!")
