
local player_scoreboard_groups = {
	scps = {
		sort = 6,
		check = function(pl) return pl.br_team == TEAM_SCP end,
		color = Color(232, 18, 39, 220),
		text = "SCPs"
	},
	mtf = {
		sort = 5,
		check = function(pl) return pl.br_team == TEAM_MTF end,
		color = Color(0, 0, 60, 220),
		text = "Mobile Task Force"
	},
	security = {
		sort = 4,
		check = function(pl) return pl.br_team == TEAM_SECURITY end,
		color = Color(29, 90, 198, 220),
		text = "Security"
	},
	foundation = {
		sort = 3,
		check = function(pl) return pl:IsFromFoundation() and pl.br_team != TEAM_SCP and pl.br_team != TEAM_SECURITY and pl.br_team != TEAM_MTF and pl.br_team != TEAM_CLASSD end,
		color = Color(120, 120, 120, 220),
		text = "Foundation Staff"
	},
	classds = {
		sort = 2,
		check = function(pl) return pl.br_team == TEAM_CLASSD end,
		color = Color(201, 87, 16, 220),
		text = "Class Ds"
	},
	unknown = {
		sort = 1,
		check = function(pl) return !pl:Alive() or pl:IsSpectator() or pl.br_role == "CI Soldier" end,
		color = Color(50, 50, 50, 220),
		text = "Unknown"
	},
}

function BR_ShowScoreboard()
	if IsValid(BR_Scoreboard) then
		BR_Scoreboard:Remove()
	end
	
	info_menu_pop()

	local size_mul = math.Clamp(ScrH() / 1080, 0.1, 1)
	
	local font_structure = {
		font = "Lorimer No 2 Stencil",
		extended = false,
		size = 100 * size_mul,
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

	surface.CreateFont("BR_Scoreboard_Missions", {
		font = "Patrick Hand SC",
		extended = false,
		size = 50 * size_mul,
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
	
	surface.CreateFont("BR_Scoreboard_Logo", font_structure)

	font_structure.size = 32 * size_mul
	surface.CreateFont("BR_Scoreboard_Creator", font_structure)

	font_structure.size = 28 * size_mul
	font_structure.font = "Tahoma"
	surface.CreateFont("BR_Scoreboard_Names", font_structure)

	font_structure.size = 32 * size_mul
	surface.CreateFont("BR_Scoreboard_Bottom", font_structure)

	font_structure.size = 32 * size_mul
	surface.CreateFont("BR_Scoreboard_Players", font_structure)

	font_structure.size = 38 * size_mul
	surface.CreateFont("BR_Scoreboard_Hostname", font_structure)
	
	local ply = LocalPlayer()
	local gap = math.Round(4 * size_mul)
	
	playerlist = table.Copy(player.GetAll())
	
	pl_size = 38 * size_mul
	local total_size = (#playerlist) * (pl_size + (gap * 2)) + (gap * 2)
	local sb_w = ScrW() / 2
	local sb_x = ScrW() / 2
	local sb_y = ScrH() / 2
	
	BR_Scoreboard = vgui.Create("DFrame")
	BR_Scoreboard:SetSize(sb_w, 0)
	BR_Scoreboard:SetPos(sb_x, sb_y)
	BR_Scoreboard:SetTitle("")
	BR_Scoreboard:SetVisible(true)
	BR_Scoreboard:SetDraggable(true)
	BR_Scoreboard:SetDeleteOnClose(true)
	BR_Scoreboard:SetDraggable(false)
	BR_Scoreboard:ShowCloseButton(false)
	BR_Scoreboard:Center()
	BR_Scoreboard:MakePopup()
	BR_Scoreboard.Paint = function(self, w, h)
		--draw.RoundedBox(0, 0, 0, w, h, Color(50, 50, 50, 100))
	end
	
	local last_y = 0
	
	local panel_color = Color(50, 50, 50, 200)
	local text_color_white = Color(220,220,220,200)
	local text_color_black = Color(35,35,35,200)
	local SB_Panel_Top = vgui.Create("DPanel", BR_Scoreboard)
	SB_Panel_Top:SetSize(sb_w - (gap * 4), (128 * size_mul))
	last_y = (128 * size_mul) + (gap * 2)
	SB_Panel_Top:SetPos((gap * 2), (gap * 2))
	SB_Panel_Top.Paint = function(self, w, h)
		draw.RoundedBox(0, 0, 0, w, h, panel_color)
		draw.Text({
			text = "BREACH II",
			pos = {gap * 2, 0},
			xalign = TEXT_ALIGN_LEFT,
			yalign = TEXT_ALIGN_TOP,
			font = "BR_Scoreboard_Logo",
			color = text_color_white,
		})
		draw.Text({
			text = "made by Maya",
			pos = {gap * 4, h - (gap * 2)},
			xalign = TEXT_ALIGN_LEFT,
			yalign = TEXT_ALIGN_BOTTOM,
			font = "BR_Scoreboard_Creator",
			color = text_color_white,
		})
		draw.Text({
			text = GetHostName(),
			pos = {w - (gap * 4), (gap * 2)},
			xalign = TEXT_ALIGN_RIGHT,
			yalign = TEXT_ALIGN_TOP,
			font = "BR_Scoreboard_Hostname",
			color = text_color_white,
		})
		draw.Text({
			text = ""..#player.GetAll().."/"..game.MaxPlayers().." Players",
			pos = {w - (gap * 4), h - (gap * 2)},
			xalign = TEXT_ALIGN_RIGHT,
			yalign = TEXT_ALIGN_BOTTOM,
			font = "BR_Scoreboard_Players",
			color = text_color_white,
		})
	end
	
	local SB_Panel_Middle = vgui.Create("DScrollPanel", BR_Scoreboard)
	local max_size = math.Clamp(total_size, 0, total_size - (#playerlist - 16) * (pl_size + (gap * 2)))
	SB_Panel_Middle:SetSize(sb_w - (gap * 4), max_size)
	SB_Panel_Middle:SetPos((gap * 2), last_y + (gap * 2))
	last_y = last_y + max_size + (gap * 2)
	SB_Panel_Middle.Paint = function(self, w, h)
		--draw.RoundedBox(0, 0, 0, w, h, Color(255, 50, 50, 100))
	end

	for k,v in pairs(player.GetAll()) do
		local found = false

		for group_name, group in pairs(player_scoreboard_groups) do
			if group.check(v) then
				v.scoreboardGroup = group_name
			v.scoreboardGroupSort = group.sort
				found = true
				break
			end
		end

		if !found then
			v.scoreboardGroup = "unknown"
			v.scoreboardGroupSort = 1
		end
	end

	table.sort(playerlist, function(a, b) return a.scoreboardGroupSort > b.scoreboardGroupSort end)
	
	for i,v in ipairs(playerlist) do
		local SB_Panel_Player = vgui.Create("DPanel", SB_Panel_Middle)
		SB_Panel_Player:SetSize(sb_w - (gap * 8), pl_size)
		SB_Panel_Player:SetPos((gap * 2), (gap * 2) + ((i-1) * (pl_size + (gap * 2))))

		local avatar_panel = vgui.Create("DButton", SB_Panel_Player)
		avatar_panel:SetSize(pl_size, pl_size)
		avatar_panel:SetPos(0, 0)
		avatar_panel.DoClick = function()
			if IsValid(v) and !v:IsBot() then
				v:ShowProfile()
			end
		end
		avatar_panel:SetMouseInputEnabled(IsValid(v) and !v:IsBot())

		local avatarimage = vgui.Create("AvatarImage", avatar_panel)
		avatarimage:Dock(FILL)
		avatarimage:SetPlayer(v, 64)
		avatarimage:SetMouseInputEnabled(false)

		local oppositecolor = text_color_white
		local playercolor = player_scoreboard_groups[v.scoreboardGroup].color

		if (playercolor.r + playercolor.g + playercolor.b) > 500 then
			oppositecolor = text_color_black
		end

		SB_Panel_Player.Paint = function(self, w, h)
			if IsValid(v) == false then
				BR_Scoreboard:Remove()
				BR_ShowScoreboard()
				return
			end

			draw.RoundedBox(0, 0, 0, w, h, playercolor)

			-- country code
			local flagwidth = 0
			if !v:IsBot() then
				local countrycode = v:GetNWString("CountryCode", nil)

				if isstring(countrycode) and string.len(countrycode) > 0 then
					local flag_mat = Material("flags16/" .. countrycode .. ".png", "smooth")

					if flag_mat and flag_mat:IsError() == false then
						surface.SetMaterial(flag_mat)
						surface.SetDrawColor(255, 255, 255, 255)
						local flag_h = pl_size / 2
						local flag_w = flag_h * (16 / 11)
						surface.DrawTexturedRect(pl_size + gap + 4, h / 2 - (pl_size / 4), flag_w, flag_h)
						flagwidth = flag_w + 6
					end
				end
			end

			local nick = v:Nick()
			if string.len(nick) > 13 then
				nick = string.sub(nick, 1, 13) .. ".."
			end

			-- name
			draw.Text({
				text = nick,
				pos = {flagwidth + pl_size + gap * 2, h/2},
				xalign = TEXT_ALIGN_LEFT,
				yalign = TEXT_ALIGN_CENTER,
				font = "BR_Scoreboard_Names",
				color = oppositecolor,
			})

			-- role
			draw.Text({
				text = player_scoreboard_groups[v.scoreboardGroup].text,
				pos = {w/2, h/2},
				xalign = TEXT_ALIGN_CENTER,
				yalign = TEXT_ALIGN_CENTER,
				font = "BR_Scoreboard_Names",
				color = oppositecolor,
			})

			-- Ping
			local connection = tostring(v:Ping())
			if v:IsBot() then
				connection = "BOT"
			end

			draw.Text({
				text = connection,
				pos = {w - (gap * 2) - 4, h/2},
				xalign = TEXT_ALIGN_RIGHT,
				yalign = TEXT_ALIGN_CENTER,
				font = "BR_Scoreboard_Names",
				color = oppositecolor,
			})
			
			-- group
			local group = string.SetChar(v:GetUserGroup(), 1, string.upper(v:GetUserGroup()[1]))
			if group != "User" then
				surface.SetFont("BR_Scoreboard_Names")
				
				draw.Text({
					text = group,
					pos = {w - select(1, surface.GetTextSize("BOT")) - 24, h/2},
					xalign = TEXT_ALIGN_RIGHT,
					yalign = TEXT_ALIGN_CENTER,
					font = "BR_Scoreboard_Names",
					color = oppositecolor,
				})
			end
		end
	end
	
	local SB_Panel_Bottom = vgui.Create("DPanel", BR_Scoreboard)
	SB_Panel_Bottom:SetSize(sb_w - (gap * 4), 46 * size_mul)
	SB_Panel_Bottom:SetPos((gap * 2), last_y + (gap * 2))
	last_y = last_y + (48 * size_mul) + (gap * 2)
	SB_Panel_Bottom.Paint = function(self, w, h)
		draw.RoundedBox(0, 0, 0, w, h, panel_color)

		draw.Text({
			text = "Version: " .. GM_VERSION .. " " .. GM_VERSION_GROUP,
			pos = {gap * 2, h / 2},
			xalign = TEXT_ALIGN_LEFT,
			yalign = TEXT_ALIGN_CENTER,
			font = "BR_Scoreboard_Bottom",
			color = text_color_white,
		})

		draw.Text({
			text = os.date("%H:%M:%S - %d/%m/%Y" , os.time()),
			pos = {w - (gap * 2), h / 2},
			xalign = TEXT_ALIGN_RIGHT,
			yalign = TEXT_ALIGN_CENTER,
			font = "BR_Scoreboard_Bottom",
			color = text_color_white,
		})
	end

	if LocalPlayer().br_role != "SCP-173" then
		surface.SetFont("BR_Scoreboard_Names")
		local button_size = select(1, surface.GetTextSize("Open Notepad")) * 1.3


		local button = vgui.Create("DButton", SB_Panel_Bottom)
		button:SetSize(button_size, 34 * size_mul)
		button:SetText("Open Notepad")
		button:SetTextColor(Color(255,255,255,200))
		button:SetFont("BR_SB_Option_Selection")
		button:Center()

		button.DoClick = function(self)
			BR_ShowNotepad(BR2_OURNOTEPAD)
		end

		button.Paint = function(self, w, h)
			draw.RoundedBox(0, 2, 0, w, h, Color(25,25,25,255))
		end
	end
	
	BR_Scoreboard:SetSize(sb_w, last_y + (gap * 2))
	BR_Scoreboard:SetPos(ScrW() / 2, ScrH() / 2)
	BR_Scoreboard:Center()
end

function BR_ShowScoreboardMissions()
	if istable(BREACH_MISSIONS) then
		for k,v in pairs(BREACH_MISSIONS) do
			if v.class == br2_our_mission_set then
				if IsValid(BR_Scoreboard_Missions) then
					BR_Scoreboard_Missions:Remove()
				end

				local clr_big_text = Color(255,255,255,255)
				local clr_small_text = Color(238,190,0,255)
				local clr_highlight_text = Color(255,81,0,255)

				local size_mul = math.Clamp(ScrH() / 1080, 0.1, 2)
				local fontsize = draw.GetFontHeight("BR_Scoreboard_Missions") * 0.7
				local max_mission_text_w = 0
				
				surface.SetFont("BR_Scoreboard_Missions")

				for k2,v2 in pairs(v.missions) do
					max_mission_text_w = math.max(max_mission_text_w, select(1, 32 + surface.GetTextSize(" - " .. v2.name)))
				end

				BR_Scoreboard_Missions = vgui.Create("DPanel")
				BR_Scoreboard_Missions:SetSize(max_mission_text_w, (fontsize * (#v.missions + 1) + 24 * 2))
				BR_Scoreboard_Missions.Paint = function(self, w, h)
					--draw.RoundedBox(0, 0, 0, w, h, Color(100,50,50,50))

					draw.Text({
						text = "Your missions:",
						pos = {16, 12},
						xalign = TEXT_ALIGN_LEFT,
						yalign = TEXT_ALIGN_TOP,
						font = "BR_Scoreboard_Missions",
						color = clr_big_text,
					})

					local y = 16 + fontsize
					for k2,v2 in pairs(v.missions) do
						draw.Text({
							text = " - " .. v2.name,
							pos = {16, y},
							xalign = TEXT_ALIGN_LEFT,
							yalign = TEXT_ALIGN_TOP,
							font = "BR_Scoreboard_Missions",
							color = clr_small_text,
						})
						y = y + fontsize
					end
				end

				return
			end
		end
	end
end

function GM:ScoreboardShow()
	if !BR2_ShouldDrawAnyHud() or are_we_downed() then return end

	if (game_state == GAMESTATE_PREPARING or game_state == GAMESTATE_ROUND) and !LocalPlayer():IsSpectator() and LocalPlayer():Alive() then
		if #BR_SCOREBOARD_OPTIONS > 0 then
			BR_ShowScoreboard()
			BR_ShowScoreboardMissions()
		end
	else
		BR_ShowScoreboard()
		BR_SupportSpawnButtons()
	end
end

function GM:ScoreboardHide()
	if IsValid(BR_SupportSpawns) then
		BR_SupportSpawns:Remove()
	end
	if IsValid(BR_Scoreboard) and BR_Scoreboard.IsNotepad == nil then
		BR_Scoreboard:Remove()
	end
	if IsValid(BR_Scoreboard_Missions) then
		BR_Scoreboard_Missions:Remove()
	end
end

print("[Breach2] client/hud/hud_scoreboard.lua loaded!")