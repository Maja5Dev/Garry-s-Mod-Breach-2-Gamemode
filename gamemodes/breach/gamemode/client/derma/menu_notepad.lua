
local chaos_color = Color(30, 100, 30)
local scp_color = Color(255, 0, 0)

local scoreboard_role_colors = {}
scoreboard_role_colors["Janitor"] = Color(130, 62, 230)
scoreboard_role_colors["Doctor"] = Color(130, 62, 230)
scoreboard_role_colors["Researcher"] = Color(25, 140, 180)
scoreboard_role_colors["SD Officer"] = Color(30, 30, 200)
scoreboard_role_colors["Containment Specialist"] = Color(132, 25, 120)
scoreboard_role_colors["ISD Agent"] = Color(24, 33, 150)
scoreboard_role_colors["CI Soldier"] = chaos_color
scoreboard_role_colors["Class D"] = Color(201, 87, 16)
scoreboard_role_colors["MTF Operative"] = Color(0, 0, 60)

br2_notepad_own_notes = {}

local function save_own_notes()
	if IsValid(panel_contents) and istable(panel_contents.text_entries) and BR_Scoreboard.own_notepad == true then
		for i,v in ipairs(panel_contents.text_entries) do
			if IsValid(v) then
				br2_notepad_own_notes[i] = v:GetText()
			end
		end
	end
end

local mat_xmark = Material("breach2/br2_xmark.png")
local mat_qmark = Material("breach2/br2_qmark.png")
local mat_checkmark = Material("breach2/br2_checkmark.png")

local change_health_panel = NULL

local current_page = 1
local notepad_pages = {
	{
		name = "Known players",
		func = function(notepad_info)
			local size_mul = math.Clamp(ScrH() / 1080, 0.1, 1)

			local our_name = vgui.Create("DLabel", panel_contents)
			our_name:SetText("No role")
			--our_name:Dock(TOP)
			our_name:SetPos(2, 0)
			our_name:SetSize(1000, 44)
			our_name:SetFont('BR_Scoreboard2')
			our_name:SetContentAlignment(7)
			local our_showname = nil
			our_name:SetColor(Color(65, 65, 65, 255))
			--our_name:SizeToContents()
			our_name.Paint = function(self, w, h)
				--draw.RoundedBox(0, 0, 0, w, h, Color(100, 255, 0, 50))
			end
			/*
			local player_list = vgui.Create("DListView", panel_contents)
			player_list:SetMultiSelect(false)
			player_list:SetHideHeaders(true)
			player_list:AddColumn("Name")
			player_list:AddColumn("Role")
			player_list:Dock(FILL)
			player_list:SetDataHeight(ScreenScale(13))
			*/
			
			if istable(notepad_info.people) then
				local people_copy = table.Copy(notepad_info.people)
				local known_people_sorted = {}
				local known_people_sorted_ci = {}

				for k,v in pairs(people_copy) do
					if v.br_showname == notepad_info.people[1].br_showname then continue end
					local tab = known_people_sorted
					local tab_name = v.br_role

					if v.br_ci_agent then
						tab = known_people_sorted_ci
					end

					if tab[tab_name] == nil then
						local color_to_use = Color(80, 80, 80,255)

						if v.scp then
							color_to_use = Color(255,0,0,200)
						end

						if scoreboard_role_colors[v.br_role] then
							color_to_use = scoreboard_role_colors[v.br_role]
						end

						tab[tab_name] = {clr = color_to_use, list = {}}
					end
					table.ForceInsert(tab[tab_name].list, v)
				end

				local our_known_people = {}
				
				for k,v in pairs(known_people_sorted_ci) do
					for k2,v2 in pairs(v.list) do
						v2.clr = v.clr
						table.ForceInsert(our_known_people, v2)
					end
				end
				
				for k,v in pairs(known_people_sorted) do
					for k2,v2 in pairs(v.list) do
						v2.clr = v.clr
						table.ForceInsert(our_known_people, v2)
					end
				end
				
				our_showname = (notepad_info.people[1].br_showname .." ("..notepad_info.people[1].br_role..")")
				our_name:SetText(our_showname)
				
				local pc_w, pc_h = panel_contents:GetSize()
				local playerlist_panel = vgui.Create("DScrollPanel", panel_contents)
				local playerlist_size = 44 * size_mul
				playerlist_panel:SetSize(pc_w, pc_h - playerlist_size)
				playerlist_panel:SetPos(0, playerlist_size)
				playerlist_panel.Paint = function(self, w, h)
					draw.RoundedBox(0, 0, 0, w, h, Color(125, 0, 0, 0))
				end
				
				local player_panel_h = 38 * size_mul
				local last_y = 2
				local use_dark = true
				for i,v in ipairs(our_known_people) do
					local showrole = v.br_role

					if v.br_ci_agent == true then
						showrole = showrole .. " (CI)"
					end

					local player_panel = vgui.Create("DPanel", playerlist_panel)
					player_panel:SetSize(pc_w, player_panel_h)
					player_panel:SetPos(0, last_y)
					player_panel.text1 = v.br_showname
					player_panel.text2 = showrole
					player_panel.role_color = Color(64, 64, 64, 220)

					if v.scp then
						player_panel.role_color = scp_color
					elseif v.br_ci_agent == true then
						player_panel.role_color = chaos_color
					elseif scoreboard_role_colors[v.br_role] then
						player_panel.role_color = scoreboard_role_colors[v.br_role]
					end

					player_panel.role_color = Color(player_panel.role_color.r, player_panel.role_color.g, player_panel.role_color.b, 220)
					player_panel.use_dark = use_dark
					player_panel.Paint = function(self, w, h)
						if self.use_dark then
							draw.RoundedBox(0, 0, 0, w, h, Color(50, 50, 50, 25))
						end
						draw.Text({
							text = self.text1,
							pos = {4, h / 2},
							xalign = TEXT_ALIGN_LEFT,
							yalign = TEXT_ALIGN_CENTER,
							font = "BR_Scoreboard3",
							color = Color(65, 65, 65, 255),
						})
						draw.Text({
							text = self.text2,
							pos = {w / 2, h / 2},
							xalign = TEXT_ALIGN_LEFT,
							yalign = TEXT_ALIGN_CENTER,
							font = "BR_Scoreboard3",
							color = player_panel.role_color,
						})
					end

					local health_panel = vgui.Create("DButton", player_panel)
					health_panel:SetSize(player_panel_h, player_panel_h)
					health_panel:SetPos(pc_w - (player_panel_h * 2), 0)
					health_panel:SetText("")
					local function change_hl()
						health_panel.hl1 = {mat_qmark, HEALTH_MISSING}
						health_panel.hl2 = {mat_checkmark, HEALTH_ALIVE}
						health_panel.hl3 = {mat_xmark, HEALTH_DEAD}
						if v.health == HEALTH_ALIVE then
							health_panel.hl1 = {mat_checkmark, HEALTH_ALIVE}
							health_panel.hl2 = {mat_qmark, HEALTH_MISSING}
							health_panel.hl3 = {mat_xmark, HEALTH_DEAD}
						elseif v.health == HEALTH_DEAD then
							health_panel.hl1 = {mat_xmark, HEALTH_DEAD}
							health_panel.hl2 = {mat_qmark, HEALTH_MISSING}
							health_panel.hl3 = {mat_checkmark, HEALTH_ALIVE}
						end
						health_panel.Paint = function(self, w, h)
							draw.RoundedBox(0, 0, 0, w, h, Color(50, 50, 50, 50))
							surface.SetDrawColor(Color(0,0,0,220))
							surface.SetMaterial(health_panel.hl1[1])
							surface.DrawTexturedRect(0, 0, w, h)
						end
					end
					change_hl()

					if BR_Scoreboard.own_notepad == true then
						health_panel.DoClick = function(self)
							if IsValid(change_health_panel) then
								change_health_panel:Remove()
							end
							change_health_panel = vgui.Create("DPanel", player_panel)
							change_health_panel:SetSize(player_panel_h * 3, player_panel_h)
							local parent_pos_x, parent_pos_y = self:GetPos()
							change_health_panel:SetPos(parent_pos_x - (player_panel_h * 2), parent_pos_y)
							change_health_panel.nextDeletion = CurTime() + 2
							change_health_panel.Paint = function(self, w, h)
								--draw.RoundedBox(0, 0, 0, w, h, Color(50, 50, 50, 50))
								if self.nextDeletion < CurTime() then
									self:Remove()
								end
							end

							local button_1 = vgui.Create("DButton", change_health_panel)
							button_1:SetPos(0, 0)
							button_1:SetSize(player_panel_h, player_panel_h)
							button_1:SetText("")
							button_1.Paint = function(self, w, h)
								draw.RoundedBox(0, 0, 0, w, h, Color(50, 50, 50, 50))
								surface.SetDrawColor(Color(0,0,0,220))
								surface.SetMaterial(health_panel.hl2[1])
								surface.DrawTexturedRect(0, 0, w, h)
							end
							button_1.DoClick = function(self)
								local found_pl = false
								for k_np,v_np in pairs(BR2_OURNOTEPAD.people) do
									if v_np.br_showname == v.br_showname and found_pl == false then
										v_np.health = health_panel.hl2[2]
										v.health = health_panel.hl2[2]
										change_hl()
										found_pl = true
									end
								end
								change_health_panel:Remove()
							end

							local button_2 = vgui.Create("DButton", change_health_panel)
							button_2:SetPos(player_panel_h, 0)
							button_2:SetSize(player_panel_h, player_panel_h)
							button_2:SetText("")
							button_2.Paint = function(self, w, h)
								draw.RoundedBox(0, 0, 0, w, h, Color(50, 50, 50, 50))
								surface.SetDrawColor(Color(0,0,0,220))
								surface.SetMaterial(health_panel.hl3[1])
								surface.DrawTexturedRect(0, 0, w, h)
							end
							button_2.DoClick = function(self)
								local found_pl = false
								for k_np,v_np in pairs(BR2_OURNOTEPAD.people) do
									if v_np.br_showname == v.br_showname and found_pl == false then
										v_np.health = health_panel.hl3[2]
										v.health = health_panel.hl3[2]
										change_hl()
										found_pl = true
									end
								end
								change_health_panel:Remove()
							end
						end
					end
					
					last_y = last_y + player_panel_h + 2
					use_dark = !use_dark
				end
				/*
				for k,v in pairs(our_known_people) do
					if v.br_showname != nil and v.br_role != nil and v.br_ci_agent != nil then
						local showrole = v.br_role
						if v.br_ci_agent == true then
							showrole = showrole .. " (CI)"
						end
						local line = player_list:AddLine(v.br_showname, showrole)
						for k2,column in pairs(line["Columns"]) do
							column:SetFont("BR_Scoreboard3")
							if k2 == 2 and v.br_ci_agent == true then
								column:SetTextColor(chaos_color)
							else
								if v.clr and k2 == 2 then
									v.clr.a = 200
									column:SetTextColor(v.clr)
								else
									column:SetTextColor(Color(0,0,0,200))
								end
							end
						end
					end
				end
				*/
			end
			/*
			function player_list:Paint(w,h)
				--draw.RoundedBox(0, 0, 0, w, h, Color(255, 100, 100, 50))
			end
			player_list.OnRowSelected = function(lst, index, pnl)
				print("Selected " .. pnl:GetColumnText(1) .. " (" .. pnl:GetColumnText(2) .. ") at index " .. index)
			end
			*/
		end
	},
	/*
	{
		name = "Documents",
		func = function(notepad_info)
			
			local max_w, max_h = panel_contents:GetParent():GetSize()
			
			local doc_w = 581
			local doc_h = 819
			
			local size_mul = math.Clamp(doc_h, 1, max_h) / doc_h
			
			local doc_panel = vgui.Create("DPanel", panel_contents:GetParent())
			panel_contents.doc_panel = doc_panel
			doc_panel:SetPos((max_w / 2) - ((doc_w * size_mul) / 2), max_h - (doc_h * size_mul) - (40 * size_mul))
			doc_panel:SetSize(doc_w * size_mul, doc_h * size_mul)
			--doc_panel:Center()
			doc_panel.Paint = function(self, w, h)
				surface.SetDrawColor(Color(255,255,255,255))
				--surface.SetMaterial(BR2_DOCUMENTS["scp_173"])
				surface.DrawTexturedRect(0, 0, w, h)
			end
			
		end,
		on_remove = function()
			if IsValid(panel_contents.doc_panel) then
				panel_contents.doc_panel:Remove()
			end
		end
	},
	*/
	{
		name = "Automated Information",
		func = function(notepad_info)
			local all_texts = {}
			local text_combined = ""

			if istable(notepad_info) and istable(notepad_info.automated_info) then
				for k,v in pairs(notepad_info.automated_info) do
					table.ForceInsert(all_texts, v)
					text_combined = text_combined .. v .. "\n"
				end
			else
				table.ForceInsert(all_texts, "No information")
			end

			local auto_info_panel = vgui.Create("DTextEntry", panel_contents)
			auto_info_panel:SetEditable(true)
			auto_info_panel:SetMultiline(true)
			auto_info_panel:SetFont("BR_SB_RICHTEXT")
			auto_info_panel:SetTextColor(Color(65, 65, 65, 255))
			auto_info_panel:SetPaintBackground(false)
			auto_info_panel:SetTabbingDisabled(false)
			auto_info_panel:SetText(text_combined)
			auto_info_panel:Dock(FILL)
			panel_contents.auto_info_panel = auto_info_panel

			auto_info_panel.OnChange = function()
				auto_info_panel:SetText(text_combined)
			end

			/*
			auto_info_panel.Paint = function(self, w, h)
				local last_y = 16
				for k,v in pairs(all_texts) do
					draw.Text({
						text = v,
						pos = {4, last_y},
						xalign = TEXT_ALIGN_LEFT,
						yalign = TEXT_ALIGN_CENTER,
						font = "BR_SB_RICHTEXT",
						color = Color(64, 64, 64, 220),
					})
					last_y = last_y + 34
				end
			end
			*/

		end,
		on_remove = function()
			if IsValid(panel_contents.auto_info_panel) then
				panel_contents.auto_info_panel:Remove()
			end
		end
	},
	{
		name = "Own stuff",
		func = function(notepad_info)
			local c_w, c_h = panel_contents:GetSize()
			/*
			local richtext = vgui.Create("RichText", panel_contents)
			richtext:SetSize(c_w - 8, c_h - 8)
			richtext:SetPos(4, 4)
			richtext.PerformLayout = function()
				richtext:SetFontInternal("BR_SB_RICHTEXT")
				richtext:SetFGColor(Color(255, 255, 255))
			end
			
			richtext:InsertColorChange(64, 64, 64, 220)
			richtext:AppendText("This is your own page, you can write your own stuff here")
			*/
			local current_text_entry = 1
			local function entries_go_next(textentry)
				for te_i,te_v in ipairs(panel_contents.text_entries) do
					if te_v:HasFocus() then
						current_text_entry = te_i
					end
				end
				current_text_entry = current_text_entry + 1
				if current_text_entry > table.Count(panel_contents.text_entries) then
					current_text_entry = 1
				end
				textentry:KillFocus()
				panel_contents.text_entries[current_text_entry]:RequestFocus()
				return current_text_entry
			end
			
			local function entries_go_prev(textentry)
				for te_i,te_v in ipairs(panel_contents.text_entries) do
					if te_v:HasFocus() then
						current_text_entry = te_i
					end
				end
				current_text_entry = current_text_entry - 1
				if current_text_entry < 1 then
					current_text_entry = table.Count(panel_contents.text_entries)
				end
				textentry:KillFocus()
				panel_contents.text_entries[current_text_entry]:RequestFocus()
			end
			
			local max_text_size = 50
			
			local last_change = 0

			panel_contents.text_entries = {}
			for i=1, 14 do
				local textentry = vgui.Create("DTextEntry", panel_contents)
				function textentry:Init()
					self:SetHistoryEnabled(false)
					self.History = {}
					self.HistoryPos = 0
					
					self:SetPaintBorderEnabled(false)
					self:SetPaintBackgroundEnabled(false)
					
					self:SetDrawBorder(false)
					self:SetPaintBackground(false)
					self:SetEnterAllowed(false)
					self:SetUpdateOnType(false)
					self:SetNumeric(false)
					self:SetAllowNonAsciiCharacters(false)
					
					self:SetTextColor(Color(65, 65, 65, 255))

					self:SetTall(20)
					self.m_bLoseFocusOnClickAway = true
					self:SetCursor("beam")
					self:SetFont("BR_SB_RICHTEXT")
				end
				textentry:Init()
				textentry:SetPos(4, 8 + ((i - 1) * 32))
				textentry:SetSize(c_w - 12, 32)
				textentry:SetText("")

				
				textentry.OnKeyCodeTyped = function(self, key)
					if key == KEY_BACKSPACE and #self:GetText() == 0 then
						entries_go_prev(textentry)
					elseif key == KEY_ENTER or key == KEY_DOWN then
						entries_go_next(textentry)
					elseif key == KEY_UP then
						entries_go_prev(textentry)
					end
					if string.len(self:GetText()) > max_text_size then
						return true
					end
				end
				textentry.Think = function(self)
					if string.len(self:GetText()) > max_text_size then
						self:SetText(string.sub(self:GetText(), 1, max_text_size))
					end
				end
				
				textentry.CheckNextLine = function(self, stringValue)
					if string.len(self:GetText()) >= max_text_size then
						local next_textentry = panel_contents.text_entries[i+1]
						if next_textentry != nil and string.len(next_textentry:GetText()) < max_text_size then
							self:KillFocus()
							local new_text = next_textentry:GetText() .. stringValue
							next_textentry:SetValue(new_text)
							next_textentry:RequestFocus()
							next_textentry:SetCaretPos(#new_text)
							--print("requesting focus to " .. i+1)
							--next_textentry.CheckNextLine(next_textentry, stringValue)
						end
					end
				end
				textentry.AllowInput = function(self, stringValue)
					if string.len(stringValue) > 1 or (CurTime() - last_change) < 0.01 then return true end
					last_change = CurTime()
					self.CheckNextLine(self, stringValue)
					return false
				end
				
				if BR_Scoreboard.own_notepad then
					if br2_notepad_own_notes[i] then
						textentry:SetText(br2_notepad_own_notes[i])
					end
					textentry:SetEditable(true)
				else
					if istable(notepad_info.own_notes) then
						if isstring(notepad_info.own_notes[i]) then
							textentry:SetText(notepad_info.own_notes[i])
						else
							textentry:SetText("")
						end
					end
					textentry:SetEditable(false)
				end

				/*
				textentry.Paint = function(self, w, h)
					if self:HasFocus() then
						draw.RoundedBox(0, 0, 0, w, h, Color(10, 10, 10, 40))
					else
						draw.RoundedBox(0, 0, 0, w, h, Color(10, 10, 10, 18))
					end
					draw.Text({
						text = self:GetText(),
						pos = {4, h/2},
						xalign = TEXT_ALIGN_LEFT,
						yalign = TEXT_ALIGN_CENTER,
						font = "BR_SB_RICHTEXT",
						color = Color(64, 64, 64, 220),
					})
				end
				*/
				table.ForceInsert(panel_contents.text_entries, textentry)
			end
			panel_contents.text_entries[current_text_entry]:RequestFocus()
		end,
		on_remove = function()
			save_own_notes()
		end
	},
}

local br2_arrow_left = Material("breach2/arrow_left.png", "noclamp smooth")
local br2_arrow_right = Material("breach2/arrow_right.png", "noclamp smooth")
local br2_arrow_down = Material("breach2/arrow_down.png", "noclamp smooth")

function BR_ShowNotepad(notepad_info)
	if IsValid(BR_Scoreboard) then
		BR_Scoreboard:Remove()
	end

	if IsValid(BR_Scoreboard_Missions) then
		BR_Scoreboard_Missions:Remove()
	end
	if IsValid(ScoreboardOptions_Panel) then
		ScoreboardOptions_Panel:Remove()
	end
    if IsValid(info_menus_panel) then
        info_menus_panel:Remove()
    end

	surface.PlaySound("breach2/UI/Pickups/PICKUP_Map_01.ogg")

	local size_mul = math.Clamp(ScrH() / 1440, 0.1, 1)
	--print("size_mul: " .. size_mul)

	local font_size_mul = 1

	if ScrW() < 1500 then
		font_size_mul = 0.8
	end
	--print("font_size_mul: " .. font_size_mul)

	current_page = 1
	surface.CreateFont("BR_SB_RICHTEXT", {
		font = "Neucha",
		extended = false,
		size = 36 * font_size_mul,
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
	})
	surface.CreateFont("BR_Scoreboard1", {
		font = "DS-Digital",
		extended = false,
		size = 45 * font_size_mul,
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
	})
	surface.CreateFont("BR_Scoreboard2", {
		font = "Patrick Hand SC",
		extended = false,
		--size = ScreenScale(18.35), -- 55
		size = 40 * font_size_mul,
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
	})
	--Caveat | ScreenScale(12)
	--Just Another Hand
	--Shadows Into Light | ScreenScale(16)
	surface.CreateFont("BR_Scoreboard3", {
		font = "Caveat",
		extended = false,
		--size = ScreenScale(12), -- 36
		size = 36 * font_size_mul,
		weight = 4000,
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
	})
	
	local scrw = ScrW()
	local scrh = ScrH()

	BR_Scoreboard = vgui.Create("DFrame")
	BR_Scoreboard:SetSize(scrw, scrh)
	BR_Scoreboard:Dock(FILL)
	BR_Scoreboard:SetDeleteOnClose(true)
	BR_Scoreboard:SetSizable(false)
	BR_Scoreboard:SetDraggable(false)
	BR_Scoreboard:SetTitle("")
	BR_Scoreboard:Center()
	BR_Scoreboard:MakePopup()
	BR_Scoreboard:ShowCloseButton(false)
	BR_Scoreboard.startTime = SysTime() - 2
	BR_Scoreboard.IsNotepad = true
	BR_Scoreboard.Paint = function(self, w, h)
		if IsValid(BR_SupportSpawns) then
			--draw.RoundedBox(0, 0, 0, w, h, Color(255, 0, 255, 50))
			--Derma_DrawBackgroundBlur(self, self.startTime)
			if input.IsKeyDown(KEY_ESCAPE) then
				BR_Scoreboard:Remove()
				BR_SupportSpawns:Remove()
			end
		end
	end
	BR_Scoreboard.OnRemove = function()
		save_own_notes()
	end
	
	if notepad_info == BR2_OURNOTEPAD then
		BR_Scoreboard.own_notepad = true
	else
		BR_Scoreboard.own_notepad = false
	end

	local panel_top = vgui.Create("DPanel", BR_Scoreboard)
	panel_top:SetPos(0, 0)
	panel_top:SetSize(scrw1, 45)
	panel_top.Paint = function(self, w, h)
		--draw.RoundedBox(0, 0, 0, w, h, Color(255, 255, 255, 50))
		/*
		draw.Text({
			text = #player.GetAll() .. "/" .. game.MaxPlayers(),
			pos = { 5, 0 },
			xalign = TEXT_ALIGN_LEFT,
			yalign = TEXT_ALIGN_TOP,
			font = "BR_Scoreboard1",
			color = color_white,
		})
		*/
	end


	local img_size_mul = 1440 / 2048
	local img_size = (2048 * img_size_mul) * size_mul
	local c_top = ((382 * img_size_mul) / img_size) * size_mul
	local c_left = ((310 * img_size_mul) / img_size) * size_mul
	local c_height = ((1590 * img_size_mul) / img_size) * size_mul
	local c_width = ((1406 * img_size_mul) / img_size) * size_mul

	local notepad_size = img_size
	local notepad_x = (scrw / 2) - (img_size / 2)
	local notepad_y = (scrh / 2) - (img_size / 2)

	local panel_notebook = vgui.Create("DPanel", BR_Scoreboard)
	panel_notebook:SetSize(notepad_size, notepad_size)
	panel_notebook:SetPos(notepad_x, notepad_y)
	panel_notebook.Paint = function(self, w, h)
		--draw.RoundedBox(0, 0, 0, w, h, Color(255, 255, 255, 50))
	end

	local scoreboardbg = vgui.Create("DImage", panel_notebook)
	scoreboardbg:Dock(FILL)
	scoreboardbg:SetImage("breach2/br2_document2")
	local sprite_light = 255
	scoreboardbg:SetImageColor(Color(sprite_light,sprite_light,sprite_light,255))
	
	local contents_x = notepad_size * c_left + 2
	local contents_y = notepad_size * c_top
	local contents_w = notepad_size * c_width - 2
	local contents_h = notepad_size * c_height
	
	panel_contents = vgui.Create("DPanel", panel_notebook)
	panel_contents:SetSize(contents_w, contents_h)
	panel_contents:SetPos(contents_x, contents_y)
	panel_contents.clear_contents = function()
		if isfunction(notepad_pages[current_page].on_remove) then
			notepad_pages[current_page].on_remove(notepad_info)
		end
		for k,v in pairs(panel_contents:GetChildren()) do
			v:Remove()
		end
	end
	panel_contents.Paint = function(self, w, h)
		--draw.RoundedBox(0, 0, 0, w, h, Color(255, 0, 0, 50))
	end
	panel_contents.go_prev = function()
		panel_contents.clear_contents()
		current_page = current_page - 1
		if current_page < 1 then current_page = table.Count(notepad_pages) end
		notepad_pages[current_page].func(notepad_info)
		surface.PlaySound("breach2/UI/turn_page.wav")
	end
	panel_contents.go_next = function()
		panel_contents.clear_contents()
		current_page = current_page + 1
		if current_page > table.Count(notepad_pages) then current_page = 1 end
		notepad_pages[current_page].func(notepad_info)
		surface.PlaySound("breach2/UI/turn_page.wav")
	end
	panel_contents.nextThink = 0
	panel_contents.Think = function(self)
		if self.nextThink > CurTime() then return end
		if input.IsKeyDown(KEY_RIGHT) then
			self.go_next()
			self.nextThink = CurTime() + 0.3
		end
		if input.IsKeyDown(KEY_LEFT) then
			self.go_prev()
			self.nextThink = CurTime() + 0.3
		end
	end
	
	
	local arrow_size = 32
	
	local button_prev = vgui.Create("DButton", panel_notebook)
	button_prev:SetText("")
	button_prev:SetSize(arrow_size, arrow_size)
	button_prev:SetPos(80 * size_mul, notepad_size - arrow_size - 24)
	button_prev.Paint = function(self, w, h)
		surface.SetDrawColor(Color(255,255,255,100))
		surface.SetMaterial(br2_arrow_left)
		surface.DrawTexturedRect(w/2 - (arrow_size/2), h/2 - (arrow_size/2), arrow_size, arrow_size)
	end
	button_prev.DoClick = function()
		panel_contents.go_prev()
	end
	
	local button_next = vgui.Create("DButton", panel_notebook)
	button_next:SetText("")
	button_next:SetSize(arrow_size, arrow_size)
	button_next:SetPos(notepad_size - arrow_size - (80 * size_mul), notepad_size - arrow_size - 24)
	button_next.Paint = function(self, w, h)
		surface.SetDrawColor(Color(255,255,255,100))
		surface.SetMaterial(br2_arrow_right)
		surface.DrawTexturedRect(w/2 - (arrow_size/2), h/2 - (arrow_size/2), arrow_size, arrow_size)
	end
	button_next.DoClick = function()
		panel_contents.go_next()
	end
	
	local button_exit = vgui.Create("DButton", panel_notebook)
	button_exit:SetText("")
	button_exit:SetSize(arrow_size, arrow_size)
	button_exit:SetPos(notepad_size - arrow_size - (80 * size_mul), 24)
	button_exit.Paint = function(self, w, h)
		surface.SetDrawColor(Color(255,255,255,100))
		surface.SetMaterial(br2_arrow_down)
		surface.DrawTexturedRect(w/2 - (arrow_size/2), h/2 - (arrow_size/2), arrow_size, arrow_size)
	end
	button_exit.DoClick = function()
		BR_Scoreboard:Remove()
		surface.PlaySound("breach2/UI/Pickups/PICKUP_Map_03.ogg")
	end
	
	notepad_pages[current_page].func(notepad_info)
	--panel_contents.clear_contents()
end

print("[Breach2] client/derma/menu_healing.lua loaded!")
