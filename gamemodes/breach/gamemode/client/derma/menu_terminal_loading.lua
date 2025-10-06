
local next_loading_progress = 0
function BR_Access_Terminal_Loading(terminal)
	local login = access_terminal.panel_login:GetText()
	local password = access_terminal.panel_password:GetText()
	local pos_x, pos_y = access_terminal:GetPos()
	local width, height = access_terminal:GetSize()
	access_terminal:Remove()
	loading_terminal = vgui.Create("DFrame")
	loading_terminal:ShowCloseButton(false)
	loading_terminal:SetSizable(false)
	loading_terminal:SetDraggable(true)
	loading_terminal:SetSize(width, height)
	loading_terminal:SetPos(pos_x, pos_y)
	loading_terminal:SetDeleteOnClose(false)
	loading_terminal:SetTitle("")
	loading_terminal:MakePopup()
	loading_terminal.login = login
	loading_terminal.password = password
	loading_terminal.terminal = terminal
	local gap = 8
	local loading_progress = 0
	
	loading_terminal.endfunc = function(passed, info, loginInfo, eventlog)
		if passed then
			loading_terminal:Remove()

			if TERMINAL_INFOS[info.tab_set] then
				BR_Open_Terminal(TERMINAL_INFOS[info.tab_set], loginInfo, eventlog)
				terminal_frame.CurrentInfo = info
				terminal_frame.terminal = terminal
			end
		else
			-- error
			loading_terminal:Remove()
			BR_Access_Terminal(loading_terminal.terminal)
			pos_x, pos_y = loading_terminal:GetPos()
			width, height = loading_terminal:GetSize()
			access_terminal:SetPos(pos_x, pos_y)
			access_terminal:SetSize(width, height)
			access_terminal.panel_login:SetText(loading_terminal.login)
			access_terminal.panel_password:SetText("")
			access_terminal.bad_password_end = CurTime() + 4
		end
	end

	loading_terminal.Paint = function(self, w, h)
		if terminal == nil then return end

		draw.RoundedBox(0, 0, 0, w, h, Color(25,25,25,140))
		draw.RoundedBox(0, gap, gap, w-(gap*2), h-(gap*2), Color(4, 4, 4, 180))
		
		if input.IsKeyDown(KEY_ESCAPE) then
			loading_terminal:Remove()
			gui.HideGameUI()
		end
		
		draw.Text({
			text = "Loading...",
			pos = {w/2, 30},
			xalign = TEXT_ALIGN_CENTER,
			yalign = TEXT_ALIGN_TOP,
			font = "BR_ACCESS_TERMINAL_1",
			color = Color(255,255,255,255),
		})

		if next_loading_progress < CurTime() then
			next_loading_progress = CurTime() + 0.1
			loading_progress = loading_progress + 1

			if loading_progress > 10 then
				loading_progress = 0

				net.Start("br_open_terminal")
					net.WriteString(terminal.name)
					net.WriteString(login)
					net.WriteString(password)
				net.SendToServer()

				surface.PlaySound("breach2/Button.ogg")
				return
			end
		end

		local size_mul = ScrW()/1920
		local size = 90 * size_mul
		surface.SetDrawColor(Color(255,255,255,255))
		surface.SetDrawColor(Color(255,255,255,255))

		for i=1, math.Clamp(loading_progress, 0, 10) do
			surface.SetMaterial(mat_progress["mat_progress_circle_2_"..i..""])
			surface.DrawTexturedRect((w/2)-(size/2), h-size-gap-(40*size_mul), size, size)
		end
	end
end

print("[Breach2] client/derma/menu_terminal_loading.lua loaded!")
