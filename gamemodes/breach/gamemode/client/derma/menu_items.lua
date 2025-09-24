
function BR_OpenInventoryMenu(items)
	if table.Count(items) < 1 then
		chat.AddText(Color(255,255,255,255), "Your inventory is empty")
		return
	end
	if IsValid(BR_Looting_Menu) then
		BR_Looting_Menu:Remove()
	end
	
	local looting_menu_w = 400
	
	BR_Looting_Menu = vgui.Create("DFrame")
	BR_Looting_Menu:SetTitle("")
	BR_Looting_Menu:SetSize(looting_menu_w, math.Clamp((50 - 8) * table.Count(items) + 34, 1, 500))
	BR_Looting_Menu:Center()
	BR_Looting_Menu:MakePopup()
	BR_Looting_Menu.Paint = function(self, w, h)
		draw.Text({
			text = "INVENTORY [" .. table.Count(items) .. "/" .. LocalPlayer():MaxBackpackSpaces() .. "]",
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
	
	local scroller = vgui.Create("DScrollPanel", BR_Looting_Menu)
	scroller:Dock(FILL)
	scroller.Paint = function(self, w, h) end

	for k,v in pairs(items) do
		local panel = vgui.Create("DPanel", scroller)
		panel:SetSize(looting_menu_w - 8, 50 - 8)
		panel:Dock(TOP)
		panel.text1 = v.name or ""
		panel.text2 = ""
		if BR_ITEM_DESCRIPTIONS[v.class] then
			if BR_ITEM_DESCRIPTIONS[v.class].name then
				panel.text1 = BR_ITEM_DESCRIPTIONS[v.class].name
			end
			if BR_ITEM_DESCRIPTIONS[v.class].desc then
				panel.text2 = BR_ITEM_DESCRIPTIONS[v.class].desc
			end
		end

		if v.attributes and v.attributes["uses"] then
			panel.text1 = panel.text1 .. " [" .. v.attributes["uses"] .. " uses]"
		end

		panel.Paint = function(self, w, h)
			draw.RoundedBox(0, 0, 0, w, h, Color(100, 100, 100, 100))
			draw.Text({
				text = self.text1,
				pos = {4, 2},
				xalign = TEXT_ALIGN_LEFT,
				yalign = TEXT_ALIGN_TOP,
				font = "BR_HOLSTER_CONTENT_NAME",
				color = Color(255,255,255,255),
			})
			draw.Text({
				text = self.text2,
				pos = {4, h - 2},
				xalign = TEXT_ALIGN_LEFT,
				yalign = TEXT_ALIGN_BOTTOM,
				font = "BR_HOLSTER_CONTENT_AMOUNT",
				color = Color(255,255,255,255),
			})
		end


		local panel2 = vgui.Create("DButton", panel)
		if table.Count(items) > 10 then
			panel2:SetPos(looting_menu_w - 80 - 16, 0)
		else
			panel2:SetPos(looting_menu_w - 80, 0)
		end
		panel2:SetSize(80 - 8, 50 - 8)
		panel2:SetText("")
		panel2.Paint = function(self, w, h)
			draw.RoundedBox(0, 0, 0, w, h, Color(200, 200, 200, 100))
			draw.Text({
				text = "DROP",
				pos = {(w / 2) - 2, h / 2},
				xalign = TEXT_ALIGN_CENTER,
				yalign = TEXT_ALIGN_CENTER,
				font = "BR_HOLSTER_CONTENT_USE",
				color = Color(255,255,255,255),
			})
		end
		panel2.DoClick = function()
			--print("trying to drop " .. v.name)
			net.Start("br_drop_special_item")
				net.WriteTable(v)
			net.SendToServer()

			BR_Looting_Menu:Remove()
			
			local new_items = {}
			for k2,v2 in pairs(items) do
				if v2 != v then
					table.ForceInsert(new_items, v2)
				end
			end
			BR_Looting_Menu:Remove()
			if table.Count(new_items) > 0 then
				BR_OpenInventoryMenu(new_items)
			end
		end


		local panel3 = vgui.Create("DButton", panel)
		if table.Count(items) > 10 then
			panel3:SetPos(looting_menu_w - 80 - 60 - 16, 0)
		else
			panel3:SetPos(looting_menu_w - 80 - 60, 0)
		end
		panel3:SetSize(60 - 8, 50 - 8)
		panel3:SetText("")
		panel3.Paint = function(self, w, h)
			draw.RoundedBox(0, 0, 0, w, h, Color(200, 200, 200, 100))
			draw.Text({
				text = "USE",
				pos = {(w / 2) - 2, h / 2},
				xalign = TEXT_ALIGN_CENTER,
				yalign = TEXT_ALIGN_CENTER,
				font = "BR_HOLSTER_CONTENT_USE",
				color = Color(255,255,255,255),
			})
		end
		panel3.DoClick = function()
			net.Start("br_use_special_item")
				net.WriteTable(v)
			net.SendToServer()

			BR_Looting_Menu:Remove()
		end
	end
end

function BR_OpenLootingMenu(items, source)
	if table.Count(items) < 1 then
		chat.AddText(Color(255,255,255,255), "You couldn't find anything useful...")
		return
	end
	if IsValid(BR_Looting_Menu) then
		BR_Looting_Menu:Remove()
	end
	
	local looting_menu_w = 400
	
	BR_Looting_Menu = vgui.Create("DFrame")
	BR_Looting_Menu:SetTitle("")
	BR_Looting_Menu:SetSize(looting_menu_w, math.Clamp((50 - 8) * table.Count(items) + 34, 1, 500))
	BR_Looting_Menu:Center()
	BR_Looting_Menu:MakePopup()
	BR_Looting_Menu.Paint = function(self, w, h)
		draw.Text({
			text = "LOOTING",
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
	
	local scroller = vgui.Create("DScrollPanel", BR_Looting_Menu)
	scroller:Dock(FILL)
	scroller.Paint = function(self, w, h) end

	--PrintTable(items)
	for k,v in pairs(items) do
		local panel = vgui.Create("DPanel", scroller)
		panel:SetSize(looting_menu_w - 8, 50 - 8)
		panel:Dock(TOP)
		panel.text1 = v.name or ""
		panel.text2 = ""

		local item_info = BR_ITEM_DESCRIPTIONS[v.class]
		if istable(v.class) then
			item_info = BR_ITEM_DESCRIPTIONS[v.class.class]
		end

		if item_info then
			if item_info.name then
				panel.text1 = item_info.name
			end
			if item_info.desc then
				panel.text2 = item_info.desc
			end
		end

		for k2,v2 in pairs(BR2_DOCUMENTS) do
			if v2.class == v.class then
				panel.text1 = v2.name
				panel.text2 = BR_ITEM_DESCRIPTIONS["document"].desc
			end
		end

		panel.Paint = function(self, w, h)
			draw.RoundedBox(0, 0, 0, w, h, Color(100, 100, 100, 100))
			draw.Text({
				text = self.text1,
				pos = {4, 2},
				xalign = TEXT_ALIGN_LEFT,
				yalign = TEXT_ALIGN_TOP,
				font = "BR_HOLSTER_CONTENT_NAME",
				color = Color(255,255,255,255),
			})
			draw.Text({
				text = self.text2,
				pos = {4, h - 2},
				xalign = TEXT_ALIGN_LEFT,
				yalign = TEXT_ALIGN_BOTTOM,
				font = "BR_HOLSTER_CONTENT_AMOUNT",
				color = Color(255,255,255,255),
			})
		end

		local panel2 = vgui.Create("DButton", panel)
		if table.Count(items) > 10 then
			panel2:SetPos(looting_menu_w - 80 - 16, 0)
		else
			panel2:SetPos(looting_menu_w - 80, 0)
		end

		local item_disabled = false
		for k2,v2 in pairs(BR2_ROLES_LOOT_LIMITS) do
			if v2.role_name == LocalPlayer().br_role then
				item_disabled = v2.disallow(LocalPlayer(), v)
				break
			end
		end

		panel2:SetSize(80 - 8, 50 - 8)
		panel2:SetText("")
		panel2.Paint = function(self, w, h)
			draw.RoundedBox(0, 0, 0, w, h, Color(255, 255, 255, 100))
			local text = "TAKE"
			if item_disabled then
				text = "X"
			end
			draw.Text({
				text = text,
				pos = {(w / 2) - 2, h / 2},
				xalign = TEXT_ALIGN_CENTER,
				yalign = TEXT_ALIGN_CENTER,
				font = "BR_HOLSTER_CONTENT_USE",
				color = Color(255,255,255,255),
			})
		end
		
		panel2.DoClick = function()
			if !item_disabled then
				surface.PlaySound("breach2/items/pickitem2.ogg")
				--PrintTable(v)
				net.Start("br_take_loot")
					net.WriteTable(v)
					net.WriteTable(source)
				net.SendToServer()

				BR_Looting_Menu:Remove()
				
				local new_items = {}
				for k2,v2 in pairs(items) do
					if v2 != v then
						table.ForceInsert(new_items, v2)
					end
				end
				BR_Looting_Menu:Remove()
				if table.Count(new_items) > 0 then
					BR_OpenLootingMenu(new_items, source)
				end
			end
		end
	end
end

function BR_OpenOutfitterMenu(outfit_info)
	local outfits = {}
	for k,v in pairs(outfit_info) do
		for k2,v2 in pairs(BREACH_OUTFITS) do
			if v == v2.class then
				if istable(outfits[v2.class]) then
					outfits[v2.class][1] = outfits[v2.class][1] + 1
				else
					outfits[v2.class] = {1, table.Copy(v2)}
				end
			end
		end
	end

	local our_pos = 1
	local our_model = LocalPlayer():GetModel()
	for i,v in ipairs(BREACH_OUTFITS) do
		if isstring(v.model) then
			if v.model == our_model then
				our_pos = i
			end
		else
			for i2,v2 in ipairs(v.model) do
				if v2 == our_model then
					our_pos = i2
				end
			end
		end
	end

	if table.Count(outfits) < 1 then
		chat.AddText(Color(255,255,255,255), "You couldn't find anything useful...")
		return
	end
	
	if IsValid(BR_Looting_Menu) then
		BR_Looting_Menu:Remove()
	end
	
	local looting_menu_w = 240
	local looting_menu_h = 400
	
	BR_Looting_Menu = vgui.Create("DFrame")
	BR_Looting_Menu:SetTitle("")
	local whole_w = table.Count(outfits) * (looting_menu_w + 8) - 2
	BR_Looting_Menu:SetSize(math.Clamp(whole_w, 1, (looting_menu_w + 4) * 4) + 6, looting_menu_h)
	BR_Looting_Menu:Center()
	BR_Looting_Menu:MakePopup()
	BR_Looting_Menu.Paint = function(self, w, h)
		--draw.RoundedBox(0, 0, 0, w, h, Color(150, 150, 150, 50))
		draw.Text({
			text = "OUTFITS",
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
	
	local scroller = vgui.Create("DHorizontalScroller", BR_Looting_Menu)
	scroller:Dock(FILL)
	scroller:SetOverlap(-4)
	scroller.Paint = function(self, w, h) end

	local change_size_h = 40
	local last_x = 0
	for k,v in pairs(outfits) do
		local panel = vgui.Create("DPanel", scroller)
		panel:SetSize(looting_menu_w, looting_menu_h)
		--panel:SetPos(last_x, 0)
		--panel:Dock(LEFT)
		local outfit = v[2]
		local all_texts = {outfit.name}

		panel.Paint = function(self, w, h)
			draw.RoundedBox(0, 0, 0, w, h, Color(100, 100, 100, 100))
			for num_text,text in ipairs(all_texts) do
				draw.Text({
					text = text,
					pos = {w / 2, 8},
					--pos = {w / 2, looting_menu_w + change_size_h + ((num_text - 1) * 24) + 8},
					xalign = TEXT_ALIGN_CENTER,
					yalign = TEXT_ALIGN_TOP,
					font = "BR_HOLSTER_TITLE_ALT",
					color = Color(255,255,255,255),
				})
			end
		end
		
		local model_background = vgui.Create("DPanel", panel)
		model_background:SetSize(looting_menu_w, looting_menu_h - (change_size_h * 2) + 4) 
		model_background:Dock(TOP)
		model_background.Paint = function(self, w, h)
			--draw.RoundedBox(0, 0, 0, w, h, Color(255, 100, 100, 50))
			if v[1] > 1 then
				draw.Text({
					text = "x"..v[1].."",
					pos = {8, 4},
					xalign = TEXT_ALIGN_LEFT,
					yalign = TEXT_ALIGN_TOP,
					font = "BR_HOLSTER_TITLE",
					color = Color(255,255,255,255),
				})
			end
		end

		local model_panel = vgui.Create("DModelPanel", model_background)
		model_panel:Dock(FILL)
		model_panel:SetMouseInputEnabled(false)
		local model_to_use = outfit.model
		if isstring(model_to_use) then
			model_panel:SetModel(model_to_use)
		else
			model_panel:SetModel(model_to_use[math.Clamp(our_pos, 1, table.Count(model_to_use))])
		end
		model_panel:SetFOV(55)
		function model_panel:GetPlayerColor() return outfit.player_color end
		function model_panel:LayoutEntity(ent)
			ent:SetPos(Vector(0,0,0))
			return
		end

		local take_button = vgui.Create("DButton", panel)
		take_button:SetSize(looting_menu_w, change_size_h)
		--take_button:SetPos(0, looting_menu_h - (change_size_h * 2))
		take_button:Dock(BOTTOM)
		take_button:SetText("")
		take_button.Paint = function(self, w, h)
			draw.RoundedBox(0, 0, 0, w, h, Color(150, 150, 150, 100))
			draw.Text({
				text = "CHANGE OUTFIT",
				pos = {(w / 2) - 2, h / 2},
				xalign = TEXT_ALIGN_CENTER,
				yalign = TEXT_ALIGN_CENTER,
				font = "BR_HOLSTER_CONTENT_USE",
				color = Color(255,255,255,255),
			})
		end
		take_button.DoClick = function()
			net.Start("br_take_outfit")
				net.WriteString(outfit.class)
			net.SendToServer()
			BR_Looting_Menu:Remove()
		end

		scroller:AddPanel(panel)
	end
end

function BR2_ShouldDrawWeaponInfo()
	if IsValid(cameras_frame) then return false end
	
	local wep = LocalPlayer():GetActiveWeapon()
	if IsValid(wep) then
		if isnumber(wep.lastInfoDraw) then
			if (CurTime() - wep.lastInfoDraw) > 60 then
				return false
			end
		else
			wep.lastInfoDraw = CurTime()
		end
	end
	return true
end

local mat_keypad = Material("breach2/keypad_hud.jpg")
keypad_code = ""

function OpenKeyPad()
	local keypad_h = 462
	local keypad_w = 317
	
	local button_h = 53
	local button_w = 50
	
	local space = 0
	local new_key1 = false
	
	if IsValid(keypad_frame) then
		keypad_code = ""
		keypad_frame:SetVisible(true)
		keypad_frame:MakePopup()
		return
	else
		keypad_frame = vgui.Create("DFrame")
		keypad_frame:SetDeleteOnClose(false)
		keypad_frame:SetSizable(false)
		keypad_frame:SetDraggable(false)
		keypad_frame:SetTitle("")
		keypad_frame:SetSize(keypad_w, keypad_h + space)
		keypad_frame:Center()
		keypad_frame:ShowCloseButton(false)
		keypad_frame:MakePopup()
		keypad_frame.Paint = function(self, w, h)
			draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 150))
			if input.IsKeyDown(KEY_ESCAPE) then
				gui.HideGameUI()
				keypad_frame:Remove()
				gui.HideGameUI()
			end
		end
	end
	
	
	local function addtocode(num)
		if #keypad_code < 4 then
			keypad_code = keypad_code .. tostring(num)
		end
		surface.PlaySound("breach2/Button.ogg")
	end
	local function clearcode()
		keypad_code = ""
		surface.PlaySound("breach2/Button.ogg")
	end
	local function sendcode()
		if #keypad_code == 4 then
			if IsValid(keypad_frame) then keypad_frame:Remove() end
			net.Start("br_keypad")
				net.WriteString(keypad_code)
			net.SendToServer()
			keypad_code = ""
			--keypad_frame:Close()
			surface.PlaySound("breach2/Button.ogg")
		end
	end
	keypad_frame.OnKeyCodePressed = function(self, keyCode)
		if keyCode > 0 and keyCode < 12 then
			addtocode(keyCode-1)
		end
		if keyCode == KEY_ENTER then
			sendcode()
		end
	end
	
	
	local keypad_img = vgui.Create("DImage", keypad_frame)
	--keypad_img:Dock(FILL)
	keypad_img:SetPos(0, space)
	keypad_img:SetSize(keypad_w, keypad_h)
	keypad_img:SetMaterial(mat_keypad)
	keypad_img:SetMouseInputEnabled(true)
	
	local function button_draw(width,height)
		--draw.RoundedBox(0, 0, 0, width, height, Color(41, 128, 185, 20))
	end
	
	-- first
	local keypad_button_1 = vgui.Create("DButton", keypad_img) keypad_button_1:SetText("")
	keypad_button_1:SetPos(42, 233) keypad_button_1:SetSize(button_h, button_w)
	keypad_button_1.Paint = function(self, w, h) button_draw(w,h) end
	keypad_button_1.DoClick = function() addtocode(1) end
	
	local keypad_button_2 = vgui.Create("DButton", keypad_img) keypad_button_2:SetText("")
	keypad_button_2:SetPos(102, 233) keypad_button_2:SetSize(button_h, button_w)
	keypad_button_2.Paint = function(self, w, h) button_draw(w,h) end
	keypad_button_2.DoClick = function() addtocode(2) end
	
	local keypad_button_3 = vgui.Create("DButton", keypad_img) keypad_button_3:SetText("")
	keypad_button_3:SetPos(162, 233) keypad_button_3:SetSize(button_h, button_w)
	keypad_button_3.Paint = function(self, w, h) button_draw(w,h) end
	keypad_button_3.DoClick = function() addtocode(3) end
	
	local keypad_button_4 = vgui.Create("DButton", keypad_img) keypad_button_4:SetText("")
	keypad_button_4:SetPos(222, 233) keypad_button_4:SetSize(button_h, button_w)
	keypad_button_4.Paint = function(self, w, h) button_draw(w,h) end
	keypad_button_4.DoClick = function() addtocode(0) end
	
	-- second
	local keypad_button_5 = vgui.Create("DButton", keypad_img) keypad_button_5:SetText("")
	keypad_button_5:SetPos(42, 285) keypad_button_5:SetSize(button_h, button_w)
	keypad_button_5.Paint = function(self, w, h) button_draw(w,h) end
	keypad_button_5.DoClick = function() addtocode(4) end
	
	local keypad_button_6 = vgui.Create("DButton", keypad_img) keypad_button_6:SetText("")
	keypad_button_6:SetPos(102, 285) keypad_button_6:SetSize(button_h, button_w)
	keypad_button_6.Paint = function(self, w, h) button_draw(w,h) end
	keypad_button_6.DoClick = function() addtocode(5) end
	
	local keypad_button_7 = vgui.Create("DButton", keypad_img) keypad_button_7:SetText("")
	keypad_button_7:SetPos(162, 285) keypad_button_7:SetSize(button_h, button_w)
	keypad_button_7.Paint = function(self, w, h) button_draw(w,h) end
	keypad_button_7.DoClick = function() addtocode(6) end
	
	local keypad_button_8 = vgui.Create("DButton", keypad_img) keypad_button_8:SetText("")
	keypad_button_8:SetPos(222, 285) keypad_button_8:SetSize(button_h, button_w)
	keypad_button_8.Paint = function(self, w, h) button_draw(w,h) end
	keypad_button_8.DoClick = function() sendcode() end
	
	-- third
	local keypad_button_9 = vgui.Create("DButton", keypad_img) keypad_button_9:SetText("")
	keypad_button_9:SetPos(42, 337) keypad_button_9:SetSize(button_h, button_w)
	keypad_button_9.Paint = function(self, w, h) button_draw(w,h) end
	keypad_button_9.DoClick = function() addtocode(7) end
	
	local keypad_button_10 = vgui.Create("DButton", keypad_img) keypad_button_10:SetText("")
	keypad_button_10:SetPos(102, 337) keypad_button_10:SetSize(button_h, button_w)
	keypad_button_10.Paint = function(self, w, h) button_draw(w,h) end
	keypad_button_10.DoClick = function() addtocode(8) end
	
	local keypad_button_11 = vgui.Create("DButton", keypad_img) keypad_button_11:SetText("")
	keypad_button_11:SetPos(162, 337) keypad_button_11:SetSize(button_h, button_w)
	keypad_button_11.Paint = function(self, w, h) button_draw(w,h) end
	keypad_button_11.DoClick = function() addtocode(9) end
	
	local keypad_button_12 = vgui.Create("DButton", keypad_img) keypad_button_12:SetText("")
	keypad_button_12:SetPos(222, 337) keypad_button_12:SetSize(button_h, button_w)
	keypad_button_12.Paint = function(self, w, h) button_draw(w,h) end
	keypad_button_12.DoClick = function() clearcode() end
	
	local keypad_panel = vgui.Create("DPanel", keypad_img)
	keypad_panel:SetMouseInputEnabled(false)
	keypad_panel:Dock(FILL)
	keypad_panel.Paint = function(self, w, h)
		draw.Text({
			text = "ACCESS CODE:",
			pos = { w / 2, 80 },
			font = "BR_Keypad1",
			xalign = TEXT_ALIGN_CENTER,
			yalign = TEXT_ALIGN_CENTER,
		})
		
		draw.Text({
			text = keypad_code,
			pos = { w / 2, 130 },
			font = "BR_Keypad2",
			xalign = TEXT_ALIGN_CENTER,
			yalign = TEXT_ALIGN_CENTER,
		})
	end
	
end




local mat_294 = Material("breach2/294panel_upscaled.png")

function CloseSCP_294()
	if IsValid(frame_294) then
		frame_294:Remove()
	end
end

function OpenSCP_294()
	if IsValid(frame_294) then
		frame_294:Remove()
	end
	
	surface.CreateFont("BR_SCP249_FONT", {
		font = "Courier New",
		extended = false,
		size = 20,
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
		additive = true,
		outline = false,
	})

	local img_w = 1048
	local img_h = 654
	local img_x = (ScrW() / 2) - (img_w / 2)
	local img_y = (ScrH() / 2) - (img_h / 2)

	local keyboard_w = 360
	local keyboard_h = 149
	local keyboard_x = 225
	local keyboard_y = 339
	
	local bsize = 32
	local keyboard = "1234567890QWERTYUIOPASDFGHJKL[ZXCVBNM-]}"
	keyboard_294_text = ""
	local dispensing = false
	local next_interaction = 0

	frame_294 = vgui.Create("DFrame")
	frame_294:SetDeleteOnClose(false)
	frame_294:SetSizable(false)
	frame_294:SetDraggable(false)
	frame_294:SetTitle("")
	frame_294:SetSize(ScrW(), ScrH())
	frame_294:Center()
	frame_294:ShowCloseButton(false)
	frame_294:MakePopup()
	frame_294.Paint = function(self, w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 255))
		if (next_interaction > CurTime()) or dispensing then return end
		if input.IsKeyDown(KEY_ESCAPE) then
			gui.HideGameUI()
			frame_294:Remove()
			gui.HideGameUI()
		end
	end
	frame_294.OnRemove = function(self)
		net.Start("br_closed_294")
		net.SendToServer()
	end

	local frame_294_img = vgui.Create("DImage", frame_294)
	frame_294_img:SetSize(img_w, img_h)
	frame_294_img:SetPos(img_x, img_y)
	frame_294_img:SetMaterial(mat_294)
	frame_294_img:SetMouseInputEnabled(true)

	frame_294.Think = function()
		if dispensing and next_interaction < CurTime() then
			if keyboard_294_text == "OUT OF RANGE" then
				dispensing = false
				keyboard_294_text = ""
			else
				frame_294:Remove()
			end
		end
	end
	
	local function add_key(key)
		surface.PlaySound("breach2/Button.ogg")
		if (next_interaction > CurTime()) or dispensing then return end
		local len = string.len(keyboard_294_text)

		if key == "[" then
			next_interaction = CurTime() + 4.201
			dispensing = true

			net.Start("br_use_294")
				net.WriteString(string.lower(keyboard_294_text))
			net.SendToServer()

			return

		elseif key == "]" and len < 18 then
			keyboard_294_text = keyboard_294_text .. " "
			return

		elseif key == "}" then
			keyboard_294_text = string.sub(keyboard_294_text, 1, len - 1)
			return
		end

		if len < 18 then
			keyboard_294_text = keyboard_294_text .. key
		end
	end

	for row = 1,4 do
		for num = 1,10 do
			local x = keyboard_x + ((num - 1) * (bsize + 4.5))
			local y = keyboard_y + ((row - 1) * (bsize + 7))

			local butt = vgui.Create("DButton", frame_294_img)
			butt:SetText("")
			butt:SetPos(x, y)
			butt:SetSize(bsize, bsize)
			butt.Paint = function() end
			butt.DoClick = function()
				add_key(keyboard[((row - 1) * 10) + num])
			end
		end
	end
	
	local butt = vgui.Create("DButton", frame_294_img)
	butt:SetText("")
	butt:SetPos(222, 497)
	butt:SetSize(367, 31)
	butt.Paint = function() end
	butt.DoClick = function()
		surface.PlaySound("breach2/Button.ogg")
		if (next_interaction > CurTime()) or dispensing then return end
		if string.len(keyboard_294_text) < 10 then
			keyboard_294_text = keyboard_294_text .. " "
		end
	end
	
	-- setpos 3489.13 4738.7 -7280 ; setang 11.46 176.83 0

	local text_panel_w = 128
	local text_panel_h = 24
	local text_panel_x = 840
	local text_panel_y = 175
	
	local over_panel = vgui.Create("DImage", frame_294_img)
	over_panel:SetPos(text_panel_x, text_panel_y)
	over_panel:SetSize(text_panel_w, text_panel_h)
	over_panel.Paint = function(self, w, h)
		--draw.RoundedBox(0, 0, 0, w, h, Color(255, 0, 0, 150))
		draw.Text({
			text = keyboard_294_text,
			pos = {w / 2, h / 2},
			font = "BR_SCP249_FONT",
			xalign = TEXT_ALIGN_CENTER,
			yalign = TEXT_ALIGN_CENTER,
			color = Color(255,255,255,150)
		})
	end
end



function Open_Document(doc_info)
	if IsValid(frame_document) then
		frame_document:Remove()
	end

	local doc_material = 0
	local doc_w = 0
	local doc_h = 0

	local doc_code = nil
	local doc_code_pos = nil
	local doc_code_font = nil

	for k,v in pairs(BR2_DOCUMENTS) do
		if v.class == doc_info.type then
			doc_material = Material(v.img.src)
			doc_w = v.img.width
			doc_h = v.img.height
			if v.img.code_pos then
				doc_code_pos = v.img.code_pos
				doc_code_font = v.img.code_font
			end
			break
		end
	end

	if istable(doc_info.attributes) and isstring(doc_info.attributes.doc_code) then
		doc_code = doc_info.attributes.doc_code
	end

	if doc_material == 0 then return end

	surface.PlaySound("breach2/UI/Pickups/PICKUP_Map_01.ogg")

	local doc_x = (ScrW() / 2) - (doc_w / 2)
	local doc_y = (ScrH() / 2) - (doc_h / 2)

	local exit_button_size = 32

	frame_document = vgui.Create("DFrame")
	frame_document:SetDeleteOnClose(false)
	frame_document:SetSizable(false)
	frame_document:SetDraggable(false)
	frame_document:SetTitle("")
	frame_document:SetSize(ScrW(), ScrH())
	frame_document:Center()
	frame_document:ShowCloseButton(false)
	frame_document:MakePopup()
	frame_document.startTime = SysTime() - 2
	frame_document.Paint = function(self, w, h)
		--Derma_DrawBackgroundBlur(self, self.startTime)
		Derma_DrawBackgroundBlur(self, SysTime() - 0.4)

		draw.RoundedBox(0, doc_x - 8, doc_y - 8, doc_w + 16, doc_h + 16, Color(30, 30, 30, 175))

		if input.IsKeyDown(KEY_ESCAPE) then
			gui.HideGameUI()
			frame_document:Remove()
			gui.HideGameUI()
		end
	end

	local panel_document = vgui.Create("DImage", frame_document)
	panel_document:SetSize(doc_w, doc_h)
	panel_document:SetPos(doc_x, doc_y)
	panel_document:SetMaterial(doc_material)
	panel_document:SetMouseInputEnabled(true)

	local panel_over = vgui.Create("DPanel", panel_document)
	panel_over:Dock(FILL)
	panel_over.Paint = function(self, w, h)
		if doc_code and doc_code_pos then
			draw.Text({
				text = doc_code,
				pos = {doc_code_pos.x, doc_code_pos.y},
				font = doc_code_font,
				xalign = TEXT_ALIGN_CENTER,
				yalign = TEXT_ALIGN_CENTER,
				color = Color(0,0,0,220)
			})
		end
	end

    local exit_document = vgui.Create("DImageButton", frame_document)
    exit_document:SetSize(exit_button_size, exit_button_size)
    exit_document:SetPos(doc_x + doc_w + 16, doc_y - exit_button_size - 16)
    exit_document:SetText("")
    exit_document:SetColor(Color(255,255,255,175))
    exit_document:SetImage("breach2/br2_xmark.png")
	exit_document.DoClick = function()
		surface.PlaySound("breach2/UI/Pickups/PICKUP_Map_03.ogg")
		frame_document:Remove()
    end
end

print("[Breach2] client/derma/menu_items.lua loaded!")