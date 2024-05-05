

function BR_OpenIdentifyingMenu(l_player, l_nick, l_time)
	if !istable(BR2_OURNOTEPAD) or !istable(BR2_OURNOTEPAD.people) then return end
	if IsValid(BR_Identifying_Menu) then
		BR_Identifying_Menu:Remove()
	end
	
	if (table.Count(BR2_OURNOTEPAD.people) - 1) < 1 then
		chat.AddText(Color(255,255,255,255), "Not enough information to identify...")
		return
	end
	
	BR_Identifying_Menu = vgui.Create("DFrame")
	BR_Identifying_Menu:SetTitle("")
	BR_Identifying_Menu:SetSize(400, 500)
	BR_Identifying_Menu:Center()
	BR_Identifying_Menu:MakePopup()
	BR_Identifying_Menu.TitleText = "IDENTIFY"
	if IsValid(l_player) then
		if l_player:GetClass() == "prop_ragdoll" then
			BR_Identifying_Menu.TitleText = "IDENTIFY THE BODY"
		elseif l_player:IsPlayer() then
			BR_Identifying_Menu.TitleText = "IDENTIFY THE PLAYER"
		end
	end
	BR_Identifying_Menu.Paint = function(self, w, h)
		--draw.RoundedBox(0, 0, 0, w, h, Color(150, 150, 150, 50))
		draw.Text({
			text = self.TitleText,
			pos = {4, 4},
			xalign = TEXT_ALIGN_LEFT,
			yalign = TEXT_ALIGN_TOP,
			font = "BR_HOLSTER_TITLE",
			color = Color(255,255,255,255),
		})
		if input.IsKeyDown(KEY_ESCAPE) then
			self:KillFocus()
			self:Remove()
			gui.HideGameUI()
			return
		end
	end
	
	local scroller = vgui.Create("DScrollPanel", BR_Identifying_Menu)
	scroller:Dock(FILL)
	scroller.Paint = function(self, w, h) end
	
	--local last_y = 24
	for k,v in pairs(BR2_OURNOTEPAD.people) do
		if v.br_showname == BR2_OURNOTEPAD.people[1].br_showname then continue end
		local panel = vgui.Create("DPanel", scroller)
		panel:SetSize(400 - 8, 50 - 8)
		panel:Dock(TOP)
		--panel:SetPos(4, 4 + last_y)
		panel.Paint = function(self, w, h)
			draw.RoundedBox(0, 0, 0, w, h, Color(100, 100, 100, 100))
			draw.Text({
				text = v.br_showname,
				pos = {4, 2},
				xalign = TEXT_ALIGN_LEFT,
				yalign = TEXT_ALIGN_TOP,
				font = "BR_HOLSTER_CONTENT_NAME",
				color = Color(255,255,255,255),
			})
			draw.Text({
				text = v.br_role,
				pos = {4, h - 2},
				xalign = TEXT_ALIGN_LEFT,
				yalign = TEXT_ALIGN_BOTTOM,
				font = "BR_HOLSTER_CONTENT_AMOUNT",
				color = Color(255,255,255,255),
			})
		end
		local panel2 = vgui.Create("DButton", panel)
		if table.Count(BR2_OURNOTEPAD.people) > 10 then
			panel2:SetPos(400 - 50 - 16, 0)
		else
			panel2:SetPos(400 - 50, 0)
		end
		panel2:SetSize(50 - 8, 50 - 8)
		panel2:SetText("")
		panel2.Paint = function(self, w, h)
			draw.RoundedBox(0, 0, 0, w, h, Color(255, 255, 255, 100))
			draw.Text({
				text = "ID",
				pos = {w / 2, h / 2},
				xalign = TEXT_ALIGN_CENTER,
				yalign = TEXT_ALIGN_CENTER,
				font = "BR_HOLSTER_CONTENT_USE",
				color = Color(255,255,255,255),
			})
		end
		panel2.DoClick = function()
			if IsValid(l_player) then
				l_player.br_showname 	= v.br_showname
				l_player.br_ci_agent 	= v.br_ci_agent
				l_player.br_role 		= v.br_role
				l_player.scp 			= v.scp
				
				if l_player:GetClass() == "prop_ragdoll" then
					l_player.health 	= HEALTH_DEAD
				elseif l_player:IsPlayer() then
					l_player.health 	= HEALTH_ALIVE
				end
			end
			BR_Identifying_Menu:Remove()
		end
		--last_y = last_y + (50 - 8) + 6
	end
	--BR_Identifying_Menu:SetSize(400, last_y + 4)
	--BR_Identifying_Menu:SetSize(400, 600)
	--BR_Identifying_Menu:Center()
	--BR_Identifying_Menu:MakePopup()
end

print("[Breach2] client/derma/menu_identify.lua loaded!")
