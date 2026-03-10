
local br2_mtf_logo_1 = Material("breach2/mtf_epsilon11_1.png", "noclamp smooth")
local br2_mtf_logo_2 = Material("breach2/mtf_epsilon11_2.png", "noclamp smooth")

function Open_MTF_SpawnMenu()
    if IsValid(info_menu_1_frame) then
        info_menu_1_frame:Remove()
    end
    surface.PlaySound("breach2/Button.ogg")

    local size_mul = math.Clamp(ScrH() / 1080, 0.1, 1)

    local info_menu_1_w = 1000 * size_mul
    local info_menu_1_h = 704 * size_mul

    local info_menu_exit_size_o = 32
    local info_menu_exit_size = info_menu_exit_size_o * size_mul

    local info_menu_1_logo_size = 128 * size_mul

    local im1s = 8 * size_mul

    local font_info = {
        font = "Tahoma",
        extended = false,
        size = (info_menu_exit_size_o * 0.75) * size_mul,
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

    surface.CreateFont("BR_INFO_1_FONT_1", font_info)

    font_info.size = (info_menu_exit_size_o * 1.5) * size_mul
    surface.CreateFont("BR_INFO_1_FONT_2", font_info)
    
    font_info.size = (info_menu_exit_size_o) * size_mul
    surface.CreateFont("BR_INFO_1_FONT_3", font_info)

    font_info.size = 21 * size_mul
    surface.CreateFont("BR_INFO_1_FONT_4", font_info)

    info_menu_1_frame = vgui.Create("DFrame")
    info_menu_1_frame:SetDeleteOnClose(false)
    info_menu_1_frame:SetSizable(false)
    info_menu_1_frame:SetDraggable(true)
    info_menu_1_frame:SetTitle("")
    info_menu_1_frame:SetSize(info_menu_1_w, info_menu_1_h)
    info_menu_1_frame:Center()
    info_menu_1_frame:ShowCloseButton(false)
    info_menu_1_frame:MakePopup()
    info_menu_1_frame.Paint = function(self, w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 150))
        draw.RoundedBox(0, 0, 0, w, info_menu_exit_size, Color(0, 0, 0, 200))

		draw.Text({
			text = "Support Spawning: Mobile Task Forces",
			pos = {im1s, (info_menu_exit_size_o / 2) * size_mul},
			xalign = TEXT_ALIGN_LEFT,
			yalign = TEXT_ALIGN_CENTER,
			font = "BR_INFO_1_FONT_1",
			color = Color(255,255,255,200),
        })
        local last_y = info_menu_exit_size
        
		draw.Text({
			text = "Mobile Task Forces",
			pos = {im1s, last_y},
			xalign = TEXT_ALIGN_LEFT,
			yalign = TEXT_ALIGN_TOP,
			font = "BR_INFO_1_FONT_2",
			color = Color(255,33,58,200),
        })
        last_y = last_y + ((info_menu_exit_size_o * 1.5) * size_mul) + im1s
        
        local info_table = {
            "Mobile Task Force teams will be sent into the facility.",
            "They are equipped with military grade equipment and weapons.",
            "Their job is to recontain all SCPs and bring order to the facility.",
            "Every captured Class D or CI member is valuable to the SCP Foundation.",
            "They also have to open the evacuation shelters for staff trapped inside.",
            "Choose in which Mobile Task Force team you want to spawn in.",
            "Cooperate and work with your teammates to achieve victory.",
        }

        for k,v in pairs(info_table) do
            if isstring(v) then
                draw.Text({
                    text = v,
                    pos = {im1s, last_y},
                    xalign = TEXT_ALIGN_LEFT,
                    yalign = TEXT_ALIGN_TOP,
                    font = "BR_INFO_1_FONT_3",
                    color = Color(255,255,255,150),
                })
            elseif istable(v) then
                draw.Text({
                    text = v[1],
                    pos = {im1s, last_y},
                    xalign = TEXT_ALIGN_LEFT,
                    yalign = TEXT_ALIGN_TOP,
                    font = "BR_INFO_1_FONT_3",
                    color = v[2],
                })
            end
            last_y = last_y + (info_menu_exit_size_o) * size_mul
        end

        if input.IsKeyDown(KEY_ESCAPE) then
            gui.HideGameUI()
            info_menu_1_frame:Close()
            if IsValid(info_menus_panel) then
                info_menus_panel:Remove()
            end
            gui.HideGameUI()
        end
        
        surface.SetDrawColor(Color(255,255,255,125))
		surface.SetMaterial(br2_mtf_logo_1)
        surface.DrawTexturedRect(w - info_menu_1_logo_size - im1s, info_menu_exit_size + im1s, info_menu_1_logo_size, info_menu_1_logo_size)
        surface.SetMaterial(br2_mtf_logo_2)
		surface.DrawTexturedRect(w - info_menu_1_logo_size - im1s, info_menu_exit_size + im1s, info_menu_1_logo_size, info_menu_1_logo_size)
    end

    local last_y = 312 * size_mul
    local num_of_teams = 2
    local ggap = (16 * (num_of_teams + 1)) * size_mul
    local team_panels_w = ((info_menu_1_w - ggap) / num_of_teams)

    for i=1, num_of_teams do
        local gap8 = (8 * size_mul)
        local gap16 = (16 * size_mul)
        local gap32 = (32 * size_mul)

        local team_panel = vgui.Create("DPanel", info_menu_1_frame)
        local tp_w = team_panels_w
        local tp_h = info_menu_1_h - last_y - gap32
        local tp_x = ((16 * i) * size_mul) + ((i-1) * (team_panels_w))
        local tp_y = last_y + gap16


        local team_panel_pw = tp_w - gap16
        local team_panel_ph = (tp_h - (6 * gap8)) / 5

        team_panel:SetPos(tp_x, tp_y)
        team_panel:SetSize(tp_w, tp_h)
        team_panel.Paint = function(self, w, h)
            draw.RoundedBox(0, 0, 0, w, h, Color(50, 50, 50, 200))

            for num,ply in pairs(BR2_MTF_TEAMS[i]) do
                local pos_x = gap8
                local pos_y = gap8 + (gap8 + team_panel_ph) * num
                draw.RoundedBox(0, pos_x, pos_y, team_panel_pw, team_panel_ph, Color(25, 25, 25, 200))
                local nick = "Unknown"
                if IsValid(ply) and ply.Nick then
                    nick = ply:Nick()
                end
                draw.Text({
                    text = nick,
                    pos = {pos_x + (team_panel_pw / 2), pos_y + (team_panel_ph / 2)},
                    xalign = TEXT_ALIGN_CENTER,
                    yalign = TEXT_ALIGN_CENTER,
                    font = "BR_INFO_1_FONT_3",
                    color = Color(255,255,255,200),
                })
            end

        end

        local team_panel_join = vgui.Create("DButton", team_panel)
        team_panel_join:SetSize(team_panel_pw, team_panel_ph)
        team_panel_join:SetPos(gap8, gap8)
        team_panel_join:SetText("")
        team_panel_join.team_num_found = nil
        team_panel_join.Think = function(self)
            self.team_num_found = nil
            for i2,v in ipairs(BR2_MTF_TEAMS) do
                for k,pl in pairs(v) do
                    if pl == LocalPlayer() then
                        self.team_num_found = i2
                    end
                end
            end
        end

        team_panel_join.Paint = function(self, w, h)
            local text = "Join Team "..i..""
            local color = Color(255,33,58,100)

            if isnumber(self.team_num_found) and self.team_num_found == i then
                text = "Leave Team "..i..""
                color = Color(33,188,255,100)
                
            elseif #BR2_MTF_TEAMS[i] > 3 then
                text = "Team "..i.." Full"
                color = Color(0,0,0,255)
            end

            draw.RoundedBox(0, 0, 0, w, h, color)
            draw.Text({
                text = text,
                pos = {w / 2, h / 2},
                xalign = TEXT_ALIGN_CENTER,
                yalign = TEXT_ALIGN_CENTER,
                font = "BR_INFO_1_FONT_3",
                color = Color(255,255,255,200),
            })
        end

        team_panel_join.DoClick = function(self)
            surface.PlaySound("breach2/Button.ogg")

            if isnumber(team_panel_join.team_num_found) and team_panel_join.team_num_found == i then
                net.Start("br_mtf_teams_leave")
                net.SendToServer()

            elseif #BR2_MTF_TEAMS[i] < 4 then
                net.Start("br_mtf_teams_join")
                    net.WriteInt(i, 8)
                net.SendToServer()
            end
        end
    end

    info_menu_1_frame.nextUpdate = info_menu_1_frame.nextUpdate or 0
    info_menu_1_frame.Think = function(self)
        if self.nextUpdate < CurTime() then
            --print("trying to update the mtf team info")

            net.Start("br_mtf_teams_update")
            net.SendToServer()

            -- create_player_panels()

            self.nextUpdate = CurTime() + 1
        end
    end

    info_menu_1_exit = vgui.Create("DImageButton", info_menu_1_frame)
    info_menu_1_exit:SetSize(info_menu_exit_size, info_menu_exit_size)
    info_menu_1_exit:SetPos(info_menu_1_w - info_menu_exit_size, 0)
    info_menu_1_exit:SetText("")
    info_menu_1_exit:SetColor(Color(255,255,255,200))
    info_menu_1_exit:SetImage("breach2/br2_xmark.png")
    info_menu_1_exit.DoClick = function()
        info_menu_1_frame:Remove()
    end
end

function BR_OpenMTFMenu()
    local size_w = 180
    local size_h = 190

    br_our_mtf_frame = vgui.Create("DFrame")
    br_our_mtf_frame:SetTitle("")
    br_our_mtf_frame:ShowCloseButton(false)
    br_our_mtf_frame:SetDraggable(false)
    br_our_mtf_frame:SetPos(ScrW() - size_w, ScrH() - size_h)
    br_our_mtf_frame:SetSize(size_w, size_h)
    br_our_mtf_frame.nextUpdate = 0
    br_our_mtf_frame.Think = function(self)
        if !IsValid(info_menu_1_frame) and br_our_mtf_frame.nextUpdate < CurTime() then
            net.Start("br_mtf_teams_update")
            net.SendToServer()
            br_our_mtf_frame.nextUpdate = CurTime() + 1
        end
    end

    --our_team = {Entity(1), Entity(2), Entity(3), Entity(4)}
    br_our_mtf_frame.Paint = function(self, w, h)
        for i,v in ipairs(BR2_MTF_TEAMS) do
            for k,pl in pairs(v) do
                if pl == LocalPlayer() then
                    found_ourselves = true
                    our_team = v
                    br_our_team_num = i
                end
            end
        end
        
        draw.RoundedBox(0, 0, 0, w, h, Color(25, 25, 25, 200))
        draw.Text({
            text = "MTF Team "..br_our_team_num.."",
            pos = {w / 2, 32},
            xalign = TEXT_ALIGN_CENTER,
            yalign = TEXT_ALIGN_CENTER,
            font = "BR_INFO_1_FONT_3",
            color = Color(255,33,58,150),
        })
        for i,ply in ipairs(our_team) do
            if IsValid(ply) then
                draw.Text({
                    text = ply:Nick() or "Unknown",
                    pos = {w / 2, 32 + i * 32},
                    xalign = TEXT_ALIGN_CENTER,
                    yalign = TEXT_ALIGN_CENTER,
                    font = "BR_INFO_1_FONT_3",
                    color = Color(255,255,255,200),
                })
            end
        end
    end
end
