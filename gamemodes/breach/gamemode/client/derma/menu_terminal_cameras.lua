
BR_CURRENT_CAMERA = nil
BR_CURRENT_TERMINAL_PANEL = nil

SCP_895_STATUS = 0
SCP_895_CLICKED = 0
SCP_895_TIME = 0

function CheckSCP895()
	for k,v in pairs(MAPCONFIG.CAMERAS) do
		for k2,v2 in pairs(v.cameras) do
			if v2.name == BR_CURRENT_CAMERA and v2.is_895 then
				if SCP_895_STATUS == 0 then
					SCP_895_STATUS = 1
					SCP_895_CLICKED = 0
					SCP_895_TIME = CurTime() + 2
				end
				return
			end
		end
	end
	SCP_895_STATUS = 0
end

function ResetSCP895()
	SCP_895_STATUS = 0
end

info_set_camera = {"CAMERAS", function(button, panel)
	button.OnClick = function(button, panel)
		for k,v in pairs(panel:GetChildren()) do
			v:Remove()
		end

		local size_mul = ScrH() / 1080
		local cameras_num = #ents.FindByClass("br2_camera")
		local all_cameras = 0

		for k,v in pairs(MAPCONFIG.CAMERAS) do
			all_cameras = all_cameras + table.Count(v.cameras)
		end

		local camera_software_installed = terminal_frame.CurrentInfo.devices["device_cameras"]

		local created_button = false
		panel.posx, panel.posy = panel:GetPos()
		panel.Paint = function(self, w, h)
			DrawDefaultTerminalBackground(w, h)

			local clr_big_text = Color(255,255,255,255)
			local texttab = {
				{"BR_TERMINAL_MAIN_TEXT", "SITE CAMERA SYSTEM", clr_big_text, true}
			}

			if camera_software_installed then
				table.Add(texttab, {
					{"BR_TERMINAL_MAIN_TEXT_SMALL", " Currently operational cameras: ", clr_big_text, false},
					{"BR_TERMINAL_MAIN_TEXT_SMALL", ""..cameras_num.."/"..all_cameras.."", Color(65,217,244), false},
				})

				local camera_w = 344 * size_mul
				local camera_h = 210 * size_mul
				surface.SetDrawColor(Color(255,255,255,255))
				surface.SetMaterial(br2_camera_logo_1)
				surface.DrawTexturedRect(w - camera_w - 16, 16, camera_w, camera_h)
				--surface.SetMaterial(br2_camera_logo_2)
				--surface.DrawTexturedRect(w - camera_w - 16, 16, camera_w, camera_h)

				draw.Text({
					text = "SCOM-CAMERAS",
					pos = {w - (camera_w / 2) - 16, camera_h + 20},
					xalign = TEXT_ALIGN_CENTER,
					yalign = TEXT_ALIGN_TOP,
					font = "BR_TERMINAL_CAMERA_NAME",
					color = Color(255,255,255,255)
				})

				surface.SetFont("BR_TERMINAL_CAMERA_NAME")
				local text_w, text_h = surface.GetTextSize("SCOM-CAMERAS")
				draw.Text({
					text = "version 2.0.0",
					pos = {w - (camera_w / 2) - 16, camera_h + 22 + text_h},
					xalign = TEXT_ALIGN_CENTER,
					yalign = TEXT_ALIGN_TOP,
					font = "BR_TERMINAL_CAMERA_NAME_SMALL",
					color = Color(65,217,244)
				})
			else
				table.Add(texttab, {
					{"BR_TERMINAL_MAIN_TEXT_SMALL", " Camera software not found, please install and restart the system", Color(255,0,0), false},
				})
			end

			local text_w, text_h = draw_easy_text({12, 8}, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, texttab)

			if camera_software_installed and created_button == false then
				terminal_create_button(panel, 16, text_h + ((terminal_option_h / 2) * size_mul) + (32 * size_mul), 600, terminal_option_h, "ACCESS THE CAMERAS", function(button)
					button.OnClick = function()
						terminal_frame:SetVisible(false)
						terminal_frame:KillFocus()
						BR_CURRENT_CAMERA = MAPCONFIG.CAMERAS[1].cameras[1].name

						net.Start("br_use_camera")
							net.WriteString(BR_CURRENT_CAMERA)
						net.SendToServer()

						BR_Access_Cameras()
					end
				end)

				created_button = true
			end
		end

		BR_CURRENT_TERMINAL_PANEL = panel
	end
end}

local br2_arrow_left = Material("breach2/arrow_left.png", "noclamp smooth")
local br2_arrow_right = Material("breach2/arrow_right.png", "noclamp smooth")

-- lua_run_cl BR_Access_Cameras()
function BR_Access_Cameras()
	--terminal_frame:SetVisible(false)
	local size_mul = ScrH() / 1080
	
	local go_around = CreateClientConVar("br2_cameras_go_around", "0", true, true):GetBool()

	CheckSCP895()

	local font_structure = {
		font = "Tahoma",
		extended = false,
		size = 40 * size_mul,
		weight = 1000,
		blursize = 1,
		scanlines = 2,
		antialias = true,
		underline = false,
		italic = false,
		strikeout = false,
		symbol = false,
		rotary = false,
		shadow = false,
		additive = true,
		outline = false,
	}
	surface.CreateFont("BR_CAMERAS_TOP", font_structure)
	font_structure.size = 35 * size_mul
	surface.CreateFont("BR_CAMERAS_MAIN", font_structure)
	font_structure.size = 60 * size_mul
	font_structure.scanlines = 0
	surface.CreateFont("BR_CAMERAS_CONNECTION", font_structure)
	
	cameras_frame = vgui.Create("DFrame")
	cameras_frame:ShowCloseButton(false)
	cameras_frame:SetSizable(false)
	cameras_frame:SetDraggable(false)
	cameras_frame:SetDeleteOnClose(true)
	cameras_frame:Dock(FILL)
	cameras_frame:SetTitle("")
	cameras_frame:MakePopup()
	
	local top_panel = vgui.Create("DPanel", cameras_frame)
	local top_panel_w = 550 * size_mul
	local top_panel_h = 40 * size_mul
	local top_panel_x = (ScrW() / 2) - (top_panel_w / 2)
	local top_panel_y = ScrH() - top_panel_h - 4
	top_panel:SetSize(top_panel_w, top_panel_h)
	top_panel:SetPos(top_panel_x, top_panel_y)
	top_panel.Paint = function(self, w, h)
		local camera_name = "unknown camera"
		if BR_CURRENT_CAMERA then
			camera_name = BR_CURRENT_CAMERA
		end
		draw.Text({
			text = string.upper(camera_name),
			pos = {w/2, h/2},
			xalign = TEXT_ALIGN_CENTER,
			yalign = TEXT_ALIGN_CENTER,
			font = "BR_CAMERAS_TOP",
			color = Color(255,255,255,180),
		})
	end
	
	local arrow_size = 32 * size_mul
	local arrow_left_button = vgui.Create("DButton", cameras_frame)
	arrow_left_button:SetPos(top_panel_x - top_panel_h, top_panel_y)
	arrow_left_button:SetSize(top_panel_h, top_panel_h)
	arrow_left_button:SetText("")
	arrow_left_button.Paint = function(self, w, h)
		surface.SetDrawColor(Color(255,255,255,120))
		surface.SetMaterial(br2_arrow_left)
		surface.DrawTexturedRect(w/2 - (arrow_size/2), h/2 - (arrow_size/2), arrow_size, arrow_size)
	end
	arrow_left_button.DoClick = function()
		surface.PlaySound("breach2/Button.ogg")
		if SCP_895_STATUS != 0 and SCP_895_TIME < CurTime() then
			return
		end
		for k,cgroup in pairs(MAPCONFIG.CAMERAS) do
			for i,v in ipairs(cgroup.cameras) do
				if v.name == BR_CURRENT_CAMERA then
					if cgroup.cameras[i - 1] != nil then
						BR_CURRENT_CAMERA = cgroup.cameras[i - 1].name
					else
						if go_around then
							BR_CURRENT_CAMERA = cgroup.cameras[#cgroup.cameras].name
						else
							return
						end
					end

					CheckSCP895()

					net.Start("br_use_camera")
						net.WriteString(BR_CURRENT_CAMERA)
					net.SendToServer()
					return
				end
			end
		end
	end

	local arrow_right_button = vgui.Create("DButton", cameras_frame)
	arrow_right_button:SetPos(top_panel_x + top_panel_w, top_panel_y)
	arrow_right_button:SetSize(top_panel_h, top_panel_h)
	arrow_right_button:SetText("")
	arrow_right_button.Paint = function(self, w, h)
		surface.SetDrawColor(Color(255,255,255,120))
		surface.SetMaterial(br2_arrow_right)
		surface.DrawTexturedRect(w/2 - (arrow_size/2), h/2 - (arrow_size/2), arrow_size, arrow_size)
	end
	arrow_right_button.DoClick = function()
		surface.PlaySound("breach2/Button.ogg")

		if SCP_895_STATUS != 0 and SCP_895_TIME < CurTime() then
			return
		end
		for k,cgroup in pairs(MAPCONFIG.CAMERAS) do
			for i,v in ipairs(cgroup.cameras) do
				if v.name == BR_CURRENT_CAMERA then
					if cgroup.cameras[i + 1] != nil then
						BR_CURRENT_CAMERA = cgroup.cameras[i + 1].name
					else
						if go_around then
							BR_CURRENT_CAMERA = cgroup.cameras[1].name
						else
							return
						end
					end

					CheckSCP895()

					net.Start("br_use_camera")
						net.WriteString(BR_CURRENT_CAMERA)
					net.SendToServer()
					return
				end
			end
		end
	end
	
	local exit_button = vgui.Create("DButton", cameras_frame)
	exit_button:SetPos(12, ScrH() - top_panel_h - 4)
	surface.SetFont("BR_CAMERAS_MAIN")
	local text_size_w, text_size_h = surface.GetTextSize("EXIT")
	local exit_button_w = ((text_size_w * 2) * size_mul) + 16
	local exit_button_h = top_panel_h

	exit_button:SetSize(exit_button_w, exit_button_h)
	exit_button:SetText("")
	exit_button.ntxt = "EXIT"
	exit_button.nclr = Color(255,255,255,180)
	CAMERAS_EXIT_BUTTON = exit_button
	exit_button.OnRemove = function()
		CAMERAS_EXIT_BUTTON:Remove()
		CAMERAS_EXIT_BUTTON = nil
	end
	exit_button.Paint = function(self, w, h)
		--draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 255))
		draw.Text({
			text = self.ntxt,
			pos = {4, h / 2},
			xalign = TEXT_ALIGN_LEFT,
			yalign = TEXT_ALIGN_CENTER,
			font = "BR_CAMERAS_MAIN",
			color = self.nclr,
		})

		surface.SetFont("BR_CAMERAS_MAIN")
		exit_button_w = surface.GetTextSize(self.ntxt) * 1.1
		self:SetSize(exit_button_w, exit_button_h)
	end
	exit_button.DoClick = function()
		surface.PlaySound("breach2/Button.ogg")

		SCP_895_CLICKED = SCP_895_CLICKED + 1
		if SCP_895_STATUS != 0 and SCP_895_TIME < CurTime() and SCP_895_CLICKED < math.random(4,6) then
			input.SetCursorPos(math.random(350, ScrW()), math.random(0, ScrH()))
			exit_button.ntxt = "ESCAPE"
			exit_button.nclr = Color(255,0,0,255)
			exit_button:SetPos(math.random(exit_button_w * 1.2, ScrW() - exit_button_w), math.random(exit_button_h * 1.2, ScrH() - exit_button_h))
			return
		end
		cameras_frame:Remove()
		terminal_frame:SetVisible(true)
		ResetSCP895()
	end
	
	for i,v in ipairs(MAPCONFIG.CAMERAS) do
		local group_button = vgui.Create("DButton", cameras_frame)
		group_button:SetPos(12, 4 + ((i - 1) * top_panel_h))
		surface.SetFont("BR_CAMERAS_MAIN")

		local text_size_w, text_size_h = surface.GetTextSize(v.name)
		group_button:SetSize(((text_size_w * 2) * size_mul) + 16, top_panel_h)
		group_button:SetText("")
		group_button.Paint = function(self, w, h)
			--draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 255))
			draw.Text({
				text = v.name,
				pos = {4, h / 2},
				xalign = TEXT_ALIGN_LEFT,
				yalign = TEXT_ALIGN_CENTER,
				font = "BR_CAMERAS_MAIN",
				color = Color(255,255,255,180),
			})
		end
		group_button.DoClick = function()
			surface.PlaySound("breach2/Button.ogg")
			if SCP_895_STATUS != 0 and SCP_895_TIME < CurTime() then
				return
			end
			BR_CURRENT_CAMERA = v.cameras[1].name
			net.Start("br_use_camera")
				net.WriteString(BR_CURRENT_CAMERA)
			net.SendToServer()
		end
	end

	cameras_frame.Paint = function(self, w, h)
		--DrawMaterialOverlay("effects/combine_binocoverlay", 0)
		if LocalPlayer():GetViewEntity():GetClass() != "br2_camera_view" then
			draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 255))
			draw.Text({
				text = "NO CONNECTION",
				pos = {ScrW() / 2, ScrH() / 2},
				xalign = TEXT_ALIGN_CENTER,
				yalign = TEXT_ALIGN_CENTER,
				font = "BR_CAMERAS_CONNECTION",
				color = Color(255,0,0,255),
			})
		end
		draw.Text({
			text = os.date("%H:%M:%S - %d/%m/%Y" , os.time()),
			pos = {ScrW() - 12, ScrH() - 4},
			xalign = TEXT_ALIGN_RIGHT,
			yalign = TEXT_ALIGN_BOTTOM,
			font = "BR_CAMERAS_MAIN",
			color = Color(255,255,255,180),
		})
	end
end

print("[Breach2] client/derma/menu_terminal_cameras.lua loaded!")
