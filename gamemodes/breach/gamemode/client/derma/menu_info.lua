
local br2_scp_logo1 = Material("breach2/scp_logo_1.png", "noclamp smooth")
local br2_scp_logo2 = Material("breach2/scp_logo_2.png", "noclamp smooth")

local br2_server1 = Material("breach2/br2_server_1.png", "noclamp smooth")
local br2_server2 = Material("breach2/br2_server_2.png", "noclamp smooth")

local br2_question = Material("breach2/br2_question.png", "noclamp smooth")
local br2_tutorial = Material("breach2/br2_tutorial.png", "noclamp smooth")
local br2_tutorial2 = Material("breach2/br2_tutorial_2.png", "noclamp smooth")
local br2_development = Material("breach2/br2_development.png", "noclamp smooth")

function info_menu_pop()
    local size_mul = math.Clamp(ScrH() / 1080, 0.1, 1)
    local info_menu_1_w = 1000 * size_mul
    local info_menu_1_h = 640 * size_mul
    local info_menus_w = 128 * size_mul
    local ims = 32 * size_mul

    local font_info = {
        font = "Tahoma",
        extended = false,
        size = 21 * size_mul,
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
    surface.CreateFont("BR_INFO_1_FONT_4", font_info)
    
    if IsValid(info_menus_panel) then
        info_menus_panel:Remove()
    end

    info_menus_panel = vgui.Create("DPanel")

    local menus_list = {
        {"Development", br2_development, function() OpenInfoMenu5() end, Color(255,35,16,200)},
        {"Tutorial", br2_tutorial2, function() OpenInfoMenu4() end, Color(22,222,52,200)},
        {"Help/Contact", br2_question, function() OpenInfoMenu3() end, Color(0,173,252,200)},
        {"Server", br2_server1, function() OpenInfoMenu2() end, Color(255,215,0,200)},
        {"Gamemode", br2_scp_logo1, function() OpenInfoMenu1() end, Color(255,255,255,200), br2_scp_logo2},
    }

    if !SERVER_INFO.ENABLED then
        table.remove(menus_list, 4) -- remove server info
    end

    for i,v in ipairs(menus_list) do
        local m_panel = vgui.Create("DButton", info_menus_panel)
        --m_panel:SetPos(0, ((i-1) * (info_menus_w + (ims * 2))))
        m_panel:SetText("")
        m_panel:SetMouseInputEnabled(true)
        m_panel:SetPos(ScrW() - (i * info_menus_w), 0)
        m_panel:SetSize(info_menus_w, info_menus_w + ims)
        m_panel.DoClick = function()
            v[3]()
            --surface.PlaySound("breach2/Button.ogg")
        end
        m_panel.Paint = function(self, w, h)
            draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 150))
            surface.SetDrawColor(Color(255,255,255,175))
            surface.SetDrawColor(v[4])
            surface.SetMaterial(v[2])
            surface.DrawTexturedRect(0, 0, info_menus_w, info_menus_w)
            if v[5] then
                surface.SetMaterial(v[5])
                surface.DrawTexturedRect(0, 0, info_menus_w, info_menus_w)
            end
            draw.Text({
                text = v[1],
                pos = {w / 2, info_menus_w + ims - (8 * size_mul)},
                xalign = TEXT_ALIGN_CENTER,
                yalign = TEXT_ALIGN_BOTTOM,
                font = "BR_INFO_1_FONT_4",
                color = Color(255,255,255,175),
                color = v[4],
            })
        end
    end

    info_menus_panel.Think = function()
        if !IsValid(info_menu_1_frame) and !IsValid(BR_Scoreboard) then
            info_menus_panel:Remove()
            return
        end
    end
    info_menus_panel.Paint = function(self, w, h)
        --draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 150))
    end

    --info_menus_panel:SetSize(info_menus_w, #menus_list * (info_menus_w + (ims * 2)) - ims)

    --local imp_final_w = info_menus_w * #menus_list
    --info_menus_panel:SetPos(ScrW() - imp_final_w, 0)
    --info_menus_panel:SetSize(imp_final_w, info_menus_w)
    info_menus_panel:Dock(FILL)
end

function OpenInfoMenu1()
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

    info_menu_pop()

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
			text = "Gamemode Information",
			pos = {im1s, (info_menu_exit_size_o / 2) * size_mul},
			xalign = TEXT_ALIGN_LEFT,
			yalign = TEXT_ALIGN_CENTER,
			font = "BR_INFO_1_FONT_1",
			color = Color(255,255,255,200),
        })
        local last_y = info_menu_exit_size
        
		draw.Text({
			text = "Breach 2: The Successor to Breach",
			pos = {im1s, last_y},
			xalign = TEXT_ALIGN_LEFT,
			yalign = TEXT_ALIGN_TOP,
			font = "BR_INFO_1_FONT_2",
			color = Color(255,255,255,200),
        })
        last_y = last_y + ((info_menu_exit_size_o * 1.5) * size_mul) + im1s
        
        local info_table = {
            "Gamemode developed by Maya",
            true,
            "Some models made by Водорода (Vodoroda)",
            --"Map originally made by Default_OS, heavily edited by Maya",
            "Models, textures and sounds made by Undertow Games",
            --"The whole entrance zone was made by Maya",
            "Playermodels made by KERRY and maJor",
            --"NPCs were made by Cpt. Hazama, edited by Maya",
            "Weapons use the TFA Base made by The Forgotten Architect",
            "Some SCP:CB prop models made by nasvaykid",
            "Music and some ambience made by Creative Assembly",
            true,
            "Special thanks to:",
            " - Polish_User for a lot of gameplay ideas and bug fixes",
            " - Dr.arielpro for quality checks, content ideas and testing",
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


		draw.Text({
            text = "Version group: "..GM_VERSION_GROUP,
			pos = {im1s, h - im1s},
			xalign = TEXT_ALIGN_LEFT,
			yalign = TEXT_ALIGN_BOTTOM,
			font = "BR_INFO_1_FONT_3",
			color = Color(255,255,255,150),
        })

		draw.Text({
            text = "Version: "..GM_VERSION,
			pos = {im1s, h - im1s - (info_menu_exit_size_o) * size_mul},
			xalign = TEXT_ALIGN_LEFT,
			yalign = TEXT_ALIGN_BOTTOM,
			font = "BR_INFO_1_FONT_3",
			color = Color(255,255,255,150),
        })

        surface.SetDrawColor(Color(255,255,255,125))
		surface.SetMaterial(br2_scp_logo2)
        surface.DrawTexturedRect(w - info_menu_1_logo_size - im1s, info_menu_exit_size + im1s, info_menu_1_logo_size, info_menu_1_logo_size)
        surface.SetMaterial(br2_scp_logo1)
		surface.DrawTexturedRect(w - info_menu_1_logo_size - im1s, info_menu_exit_size + im1s, info_menu_1_logo_size, info_menu_1_logo_size)

        if input.IsKeyDown(KEY_ESCAPE) then
            gui.HideGameUI()
            info_menu_1_frame:Close()
            if IsValid(info_menus_panel) then
                info_menus_panel:Remove()
            end
            gui.HideGameUI()
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

function OpenInfoMenu2()
    if IsValid(info_menu_1_frame) then
        info_menu_1_frame:Remove()
    end
    surface.PlaySound("breach2/Button.ogg")

    local size_mul = math.Clamp(ScrH() / 1080, 0.1, 1)

    local info_menu_1_w = 850 * size_mul
    local info_menu_1_h = 600 * size_mul

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

    info_menu_pop()

    local info_table = {
        "Current players: " .. table.Count(player.GetAll()) .. "/" .. game.MaxPlayers(),
        true,
    }

    table.ForceInsert(info_table, "Server owner: "..SERVER_INFO.OWNER)
    table.ForceInsert(info_table, "Server location: "..SERVER_INFO.LOCATION)
    table.ForceInsert(info_table, "Server language: "..SERVER_INFO.LANGUAGE)
    table.ForceInsert(info_table, true)
    table.ForceInsert(info_table, "Server Rules:")

    for k,v in pairs(SERVER_INFO.RULES) do
        table.ForceInsert(info_table, " - "..v)
    end

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
			text = "Server Information",
			pos = {im1s, (info_menu_exit_size_o / 2) * size_mul},
			xalign = TEXT_ALIGN_LEFT,
			yalign = TEXT_ALIGN_CENTER,
			font = "BR_INFO_1_FONT_1",
			color = Color(255,255,255,200),
        })
        local last_y = info_menu_exit_size
        
		draw.Text({
			text = "Breach 2 Testing Server",
			pos = {im1s, last_y},
			xalign = TEXT_ALIGN_LEFT,
			yalign = TEXT_ALIGN_TOP,
			font = "BR_INFO_1_FONT_2",
			color = Color(255,255,255,200),
        })
        last_y = last_y + ((info_menu_exit_size_o * 1.5) * size_mul) + im1s

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


		draw.Text({
            text = "Server theme: "..SERVER_INFO.THEME,
			pos = {im1s, h - im1s},
			xalign = TEXT_ALIGN_LEFT,
			yalign = TEXT_ALIGN_BOTTOM,
			font = "BR_INFO_1_FONT_3",
			color = Color(255,255,255,150),
        })

        draw.Text({
            text = "Server edition: 1",
            pos = {w - im1s, h - im1s},
            xalign = TEXT_ALIGN_RIGHT,
            yalign = TEXT_ALIGN_BOTTOM,
            font = "BR_INFO_1_FONT_3",
            color = Color(255,255,255,150),
        })

        surface.SetDrawColor(Color(255,255,255,175))
		surface.SetMaterial(br2_server1)
        surface.DrawTexturedRect(w - info_menu_1_logo_size - im1s, info_menu_exit_size + im1s, info_menu_1_logo_size, info_menu_1_logo_size)

        if input.IsKeyDown(KEY_ESCAPE) then
            gui.HideGameUI()
            info_menu_1_frame:Close()
            if IsValid(info_menus_panel) then
                info_menus_panel:Remove()
            end
            gui.HideGameUI()
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

function OpenInfoMenu3()
    if IsValid(info_menu_1_frame) then
        info_menu_1_frame:Remove()
    end
    surface.PlaySound("breach2/Button.ogg")

    local size_mul = math.Clamp(ScrH() / 1080, 0.1, 1)

    local info_menu_1_w = 1100 * size_mul
    local info_menu_1_h = 690 * size_mul

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

    font_info.size = (info_menu_exit_size_o * 1.3) * size_mul
    surface.CreateFont("BR_INFO_1_FONT_2", font_info)
    
    font_info.size = (info_menu_exit_size_o) * size_mul
    surface.CreateFont("BR_INFO_1_FONT_3", font_info)

    font_info.size = 21 * size_mul
    surface.CreateFont("BR_INFO_1_FONT_4", font_info)

    info_menu_pop()

    local last_y = 0

    info_menu_1_frame = vgui.Create("DFrame")
    info_menu_1_frame:SetDeleteOnClose(false)
    info_menu_1_frame:SetSizable(false)
    info_menu_1_frame:SetDraggable(true)
    info_menu_1_frame:SetTitle("")
    info_menu_1_frame:SetSize(info_menu_1_w, info_menu_1_h)
    info_menu_1_frame:Center()
    info_menu_1_frame:ShowCloseButton(false)
    info_menu_1_frame:MakePopup()
    info_menu_1_frame.last_y = 0
    info_menu_1_frame.Paint = function(self, w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 150))
        draw.RoundedBox(0, 0, 0, w, info_menu_exit_size, Color(0, 0, 0, 200))

        local function draw_multiple_texts(info_table)
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
        end

		draw.Text({
			text = "Help/Contact Information",
			pos = {im1s, (info_menu_exit_size_o / 2) * size_mul},
			xalign = TEXT_ALIGN_LEFT,
			yalign = TEXT_ALIGN_CENTER,
			font = "BR_INFO_1_FONT_1",
			color = Color(255,255,255,200),
        })
        last_y = info_menu_exit_size
        
    -- PROBLEMS / BUGS
		draw.Text({
			text = "Reporting Problems/Bugs",
			pos = {im1s, last_y},
			xalign = TEXT_ALIGN_LEFT,
			yalign = TEXT_ALIGN_TOP,
			font = "BR_INFO_1_FONT_2",
			color = Color(89,183,255,200),
        })
        last_y = last_y + ((info_menu_exit_size_o * 1.2) * size_mul) + im1s

        draw_multiple_texts({
            "If you find a bug or a problem, try to fix it yourself before reporting it",
            "Some bugs are already known and are being worked on, check the FAQ below",
            "If the bug does not go away, please contact us"
        })

        last_y = last_y + (16 * size_mul)

    -- FREQUENTLY ASKED QUESTIONS
		draw.Text({
			text = "Frequently Asked Questions (FAQ)",
			pos = {im1s, last_y},
			xalign = TEXT_ALIGN_LEFT,
			yalign = TEXT_ALIGN_TOP,
			font = "BR_INFO_1_FONT_2",
			color = Color(89,183,255,200),
        })
        last_y = last_y + ((info_menu_exit_size_o * 1.2) * size_mul) + im1s

        draw_multiple_texts({
            "Will the gamemode ever be released to the public?",
            " - Yes, when it's finished and bug-free",
            "Will <x> SCP be added?",
            " - I have a lot of ideas for SCPs and some of them will be added",
            "   If you really want a certain SCP to be added, send me an idea",
            "   on how it should work and possible resources (models, sounds)",
            "Will <something> be added in the future?",
            " - Like before, I have a lot of ideas, so if you really want something, contact me"
        })

        last_y = last_y + (16 * size_mul)

    -- CONTACT INFORMATION
		draw.Text({
			text = "Contact Information",
			pos = {im1s, last_y},
			xalign = TEXT_ALIGN_LEFT,
			yalign = TEXT_ALIGN_TOP,
			font = "BR_INFO_1_FONT_2",
			color = Color(89,183,255,200),
        })
        last_y = last_y + ((info_menu_exit_size_o * 1.2) * size_mul) + im1s

        draw_multiple_texts({
            "To contact anybody working on this project, join the Discord server",
            "Click the link below, the address is also printed to the chat and the console"
        })

        surface.SetDrawColor(Color(255,255,255,175))
		surface.SetMaterial(br2_question)
        surface.DrawTexturedRect(w - info_menu_1_logo_size - im1s, info_menu_exit_size + im1s, info_menu_1_logo_size, info_menu_1_logo_size)

        if input.IsKeyDown(KEY_ESCAPE) then
            gui.HideGameUI()
            info_menu_1_frame:Close()
            if IsValid(info_menus_panel) then
                info_menus_panel:Remove()
            end
            gui.HideGameUI()
        end
    end

    local info_menu_discord_link = vgui.Create("DButton", info_menu_1_frame)
    info_menu_discord_link:SetSize(324 * size_mul, (info_menu_exit_size_o) * size_mul)
    info_menu_discord_link:SetPos(im1s, 651.2 * size_mul)
    info_menu_discord_link:SetFont("BR_INFO_1_FONT_3")
    info_menu_discord_link:SetText("Link: discord.gg/sqcjFbX")
    info_menu_discord_link:SetTextColor(Color(200,200,200,200))
    info_menu_discord_link:SetContentAlignment(4)
    info_menu_discord_link.DoClick = function()
        gui.OpenURL("https://discord.gg/sqcjFbX")
        print("Discord link:")
        print("https://discord.gg/sqcjFbX")
        chat.AddText("https://discord.gg/sqcjFbX")
    end
    info_menu_discord_link:SetMouseInputEnabled(true)
    info_menu_discord_link.Paint = function() end

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

local br2_arrow_right = Material("breach2/arrow_right.png", "noclamp smooth")
local br2_arrow_left = Material("breach2/arrow_left.png", "noclamp smooth")

function OpenInfoMenu4()
    if IsValid(info_menu_1_frame) then
        info_menu_1_frame:Remove()
    end
    surface.PlaySound("breach2/Button.ogg")

    local size_mul = math.Clamp(ScrH() / 1080, 0.1, 1)

    local info_menu_1_w = 1150 * size_mul
    local info_menu_1_h = 764 * size_mul

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

    info_menu_pop()

    info_menu_1_frame = vgui.Create("DFrame")
    info_menu_1_frame:SetDeleteOnClose(false)
    info_menu_1_frame:SetSizable(false)
    info_menu_1_frame:SetDraggable(true)
    info_menu_1_frame:SetTitle("")
    info_menu_1_frame:SetSize(info_menu_1_w, info_menu_1_h)
    info_menu_1_frame:Center()
    info_menu_1_frame:ShowCloseButton(false)
    info_menu_1_frame:MakePopup()

    local current_info_table = 1

    local info_tables = {
        {
            main = "Tutorial 1: Basic Information",
            texts = {
                "This gamemode takes place in the SCP universe, from the SCP wiki.",
                "It is based on the greatest SCP game: SCP: Containment Breach.",
                "If you have played any older version of this gamemode, SCP:CB or SCP:SL,",
                "you will generally know what to do and what not to do.",
                "But if you have never played any of these, don't worry, this gamemode isn't hard.",
                "",
                "The SCP Foundation is a secret organisation focused on containing anomalous objects.",
                "After capturing and containing these objects in a secure facility, they are researched.",
                "Humans that are used as guinea pigs in research are referred to as Class D Personnel.",
                "Every corner of the facility is guarded by officers from the Security Department.",
                "Unfortunately, sometimes groups of interest attack the facility for various reasons.",
                "",
                "In this gamemode the action takes place in Site-19, a large research facility.",
                'There are multiple scenarios, but the main one is called the "Containment Breach".',
                "In this scenario the Chaos Insurgency (a group of interest) is raiding the facility.",
                "The attack started with a spy giving SCP-079 access to the site's systems.",
                "Multiple SCP objects have been released and chaos has ensued.",
                --"Now the facility's future is in your hands, will you recontain the SCPs or escape?"
            }
        },
        {
            main = "Tutorial 2: Factions",
            texts = {
                "In Breach 2 there are four main factions.",
                "The first and the most important is the SCP Foundation, which includes:",
                " - Security Department Officers",
                " - Internal Security Department Agents",
                " - Researchers",
                " - Engineers",
                " - Janitors and Doctors",
                " - Mobile Task Forces",
                "The second faction is the Chaos Insurgency, which includes:",
                " - Researcher spies",
                " - Security Department spies",
                " - Chaos Insurgency Soldiers",
                "The third faction is the Class D Personnel.",
                "The fourth faction includes all SCP objects.",
                --"Currently most SCPs are AI controlled but in the future more will be playable",
                --"AI controlled SCPs: SCP-173, 106, 457, 575, 096, 939, 1025",
                --"Minor SCP objects: SCP-500, 012, 513, 714",
                --"Player controlled SCPs: SCP-049 (035, 106, 173 are planned additions)"
            }
        },
        {
            main = "Tutorial 3: Roles",
            texts = {
                "Now let's take a deeper look at the roles in all of these factions.",
                "1. SD Officer",
                " Highly trained officers from the Security Department who keep order in the facility",
                " They are equipped with lethal weapons, radios and gasmasks",
                " Their mission is to kill any Class Ds and get site staff to the evacuation shelters",
                "2. ISD Agent",
                " Agents from the Internal Security Department are always hunting down traitors",
                " Their job is to find and capture spies from any group of interest inside the facility",
                "3. Researchers",
                " Researchers are an essential part of the Foundation, they study the anomalies",
                " When a breach happens, the best thing they can do is escape the facility",
                "4. Engineers",
                " They analyze, maintain and repair the on-site systems and machines",
                "5. Janitors and Doctors",
                " They just have to survive the containment breach and escape with the researchers",
                "6. Mobile Task Forces",
                " When a breach happens and the facility descends into chaos, they retake control",
                " They are equipped with heavy weaponry, night vision goggles, medkits, grenades etc.",
            }
        },
        {
            main = "Tutorial 4: Mechanics 1",
            texts = {
                --"Breach 2 is a complex gamemode with a lot of mechanics and items",
                "There are many mechanics in Breach 2, here are the most important ones:",
                "1. Gas",
                " Some areas leak gas that harms you unless you are wearing a gasmask",
                "2. Temperature",
                " It is very cold outside the facility, if you want to escape, find a warm outfit",
                "3. Sanity",
                " If you want to escape successfully, you will have to maintain your sanity",
                " Your sanity goes down in certain conditions, including:",
                "  - Being affected by SCP objects",
                "  - Being attacked",
                "  - Being AFK",
                " You can restore your sanity by:",
                "  - Taking SSRI pills",
                "4. Escaping",
                " If you are a Class D, Researcher, Janitor or Doctor, you might want to escape",
                " Grab a warm outfit, find Gate A or Gate B, then escape through an exit",
                " You can also escape through the evacuation shelter if security opens it"
                -- GAS, SANITY, TEMPERATURE, FOG, MTF SPAWN, ESCAPING, EVAC SHELTER, DOWNING N REVIVING, OUTFITS, ITEMS, TERMINALS
            } 
        },
        {
            main = "Tutorial 5: Mechanics 2",
            texts = {
                "5. Downing and Reviving",
                " Someone with low health has a chance to get downed instead of killed when shot",
                " They will start bleeding, and after checking their pulse, they can be revived",
                "6. Outfits",
                " There are places in the facility where you can change your outfit",
                " Take a warmer one to escape this place, or steal one to disguise yourself",
                "7. Terminals",
                " Site terminals are typically used to message staff or store information",
                " You can check the cameras with them, and some of them have special options",
                "8. Support Spawns",
                " If you die, you can still get back into the action through a support spawn",
                " Every player can only respawn once",
                " Class D Personnel respawn around the LCZ with low health and no items",
                " SCP objects respawn as zombies around the facility to harass other players",
                " Any Foundation personnel can respawn in a Mobile Task Force squad",
                " Any member of the Chaos Insurgency can respawn in a group of CI Soldiers",
                --" Depending on the player count, the amount of support spawns may vary",
                --" There are three types of support spawns:",
                --"  - Mobile Task Force (Soldiers)",
                --"  - Chaos Insurgency (Soldiers)",
                --"  - SCP objects (Zombies)"
            } 
        },
        {
            main = "Tutorial 6: Items",
            texts = {
                "In Breach 2 there are many unique items, here is a simple list of them:",
                "1. Keycards",
                " Keycards are used to open the doors that require them",
                " There are six clearance levels, from level 1 up to the omni keycard",
                "2. 9V Battery",
                " Use a 9V battery to replace the battery in another item",
                "3. Radio",
                " Radios let players communicate wirelessly over a shared channel",
                "4. Night Vision Goggles",
                " NVGs are used to see better in dark areas",
                "5. Gasmask",
                " Gasmasks let you breathe in areas where lethal gas is leaking",
                "6. SSRI Pills",
                " These pills restore your sanity",
                "7. Medkit",
                " Bruise packs heal 30 HP and blood bags heal 50 HP",
                " Bandages heal 15 HP and stop bleeding",
                " Ointments heal 10 HP and put out fire",
            }
        },
        -- TODO ADD MORE ITEMS
    }

    local arrow_size = 32 * size_mul

	local arrow_right_button = vgui.Create("DButton", info_menu_1_frame)
	arrow_right_button:SetPos(info_menu_1_w - arrow_size - (8 * size_mul), info_menu_1_h - arrow_size - (8 * size_mul))
	arrow_right_button:SetSize(arrow_size, arrow_size)
	arrow_right_button:SetText("")
	arrow_right_button.Paint = function(self, w, h)
		surface.SetDrawColor(Color(255,255,255,120))
		surface.SetMaterial(br2_arrow_right)
		surface.DrawTexturedRect(w/2 - (arrow_size/2), h/2 - (arrow_size/2), arrow_size, arrow_size)
    end
    arrow_right_button.DoClick = function()
        surface.PlaySound("breach2/Button.ogg")
        current_info_table = current_info_table + 1
        if current_info_table > #info_tables then
            current_info_table = 1
        end
    end
    
	local arrow_left_button = vgui.Create("DButton", info_menu_1_frame)
	arrow_left_button:SetPos(info_menu_1_w - (arrow_size * 2) - (16 * size_mul), info_menu_1_h - arrow_size - (8 * size_mul))
	arrow_left_button:SetSize(arrow_size, arrow_size)
	arrow_left_button:SetText("")
	arrow_left_button.Paint = function(self, w, h)
		surface.SetDrawColor(Color(255,255,255,120))
		surface.SetMaterial(br2_arrow_left)
		surface.DrawTexturedRect(w/2 - (arrow_size/2), h/2 - (arrow_size/2), arrow_size, arrow_size)
    end
    arrow_left_button.DoClick = function()
        surface.PlaySound("breach2/Button.ogg")
        current_info_table = current_info_table - 1
        if current_info_table < 1 then
            current_info_table = #info_tables
        end
	end

    info_menu_1_frame.Paint = function(self, w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 150))
        draw.RoundedBox(0, 0, 0, w, info_menu_exit_size, Color(0, 0, 0, 200))

		draw.Text({
			text = "Gamemode Tutorial",
			pos = {im1s, (info_menu_exit_size_o / 2) * size_mul},
			xalign = TEXT_ALIGN_LEFT,
			yalign = TEXT_ALIGN_CENTER,
			font = "BR_INFO_1_FONT_1",
			color = Color(255,255,255,200),
        })
        local last_y = info_menu_exit_size
        
		draw.Text({
			text = info_tables[current_info_table].main,
			pos = {im1s, last_y},
			xalign = TEXT_ALIGN_LEFT,
			yalign = TEXT_ALIGN_TOP,
			font = "BR_INFO_1_FONT_2",
			color = Color(22,222,52,200),
        })
        last_y = last_y + ((info_menu_exit_size_o * 1.5) * size_mul) + im1s

        for k,v in pairs(info_tables[current_info_table].texts) do
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


		draw.Text({
            text = "Version group: "..GM_VERSION_GROUP,
			pos = {im1s, h - im1s},
			xalign = TEXT_ALIGN_LEFT,
			yalign = TEXT_ALIGN_BOTTOM,
			font = "BR_INFO_1_FONT_3",
			color = Color(255,255,255,150),
        })

		draw.Text({
            text = "Version: "..GM_VERSION,
			pos = {im1s, h - im1s - (info_menu_exit_size_o) * size_mul},
			xalign = TEXT_ALIGN_LEFT,
			yalign = TEXT_ALIGN_BOTTOM,
			font = "BR_INFO_1_FONT_3",
			color = Color(255,255,255,150),
        })

        surface.SetDrawColor(Color(255,255,255,175))
		surface.SetMaterial(br2_tutorial)
        surface.DrawTexturedRect(w - info_menu_1_logo_size - im1s, info_menu_exit_size + im1s, info_menu_1_logo_size, info_menu_1_logo_size)

        if input.IsKeyDown(KEY_ESCAPE) then
            gui.HideGameUI()
            info_menu_1_frame:Close()
            if IsValid(info_menus_panel) then
                info_menus_panel:Remove()
            end
            gui.HideGameUI()
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

function OpenInfoMenu5()
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

    info_menu_pop()

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
			text = "Development Information",
			pos = {im1s, (info_menu_exit_size_o / 2) * size_mul},
			xalign = TEXT_ALIGN_LEFT,
			yalign = TEXT_ALIGN_CENTER,
			font = "BR_INFO_1_FONT_1",
			color = Color(255,255,255,200),
        })
        local last_y = info_menu_exit_size
        
		draw.Text({
			text = "Development of Breach 2",
			pos = {im1s, last_y},
			xalign = TEXT_ALIGN_LEFT,
			yalign = TEXT_ALIGN_TOP,
			font = "BR_INFO_1_FONT_2",
			color = Color(255,128,0,200),
        })
        last_y = last_y + ((info_menu_exit_size_o * 1.5) * size_mul) + im1s
        
        local info_table = {
            "Development of Breach 2 started in January 2018",
            "This gamemode, like Breach, is being developed only by Maya",
            "Because of that, the development is slow and difficult",
            true,
            {"Current goals of the gamemode:", Color(255,128,0,175)},
            " - Fix any bugs and errors",
            " - Make the UI scale well on most resolutions",
            " - Add more content",
            " - Make the gamemode more consistent",
            " - Add playable SCP-106 and SCP-035",
            " - More player settings and customizations",
            " - Add random and triggered events around the facility",
            " - Add random and scary horror elements",
            " - Make the gamemode easier for new players",
            " - Add more round scenarios (like round types in Breach 1)",
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


		draw.Text({
            text = "Version group: "..GM_VERSION_GROUP,
			pos = {im1s, h - im1s},
			xalign = TEXT_ALIGN_LEFT,
			yalign = TEXT_ALIGN_BOTTOM,
			font = "BR_INFO_1_FONT_3",
			color = Color(255,255,255,150),
        })

		draw.Text({
            text = "Version: "..GM_VERSION,
			pos = {im1s, h - im1s - (info_menu_exit_size_o) * size_mul},
			xalign = TEXT_ALIGN_LEFT,
			yalign = TEXT_ALIGN_BOTTOM,
			font = "BR_INFO_1_FONT_3",
			color = Color(255,255,255,150),
        })

        surface.SetDrawColor(Color(255,255,255,150))
		surface.SetMaterial(br2_development)
        surface.DrawTexturedRect(w - info_menu_1_logo_size - im1s, info_menu_exit_size + im1s, info_menu_1_logo_size, info_menu_1_logo_size)

        if input.IsKeyDown(KEY_ESCAPE) then
            gui.HideGameUI()
            info_menu_1_frame:Close()
            if IsValid(info_menus_panel) then
                info_menus_panel:Remove()
            end
            gui.HideGameUI()
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

print("[Breach2] client/derma/menu_info.lua loaded!")