
local br2_scp_logo1 = Material("breach2/scp_logo_1.png", "noclamp smooth")
local br2_scp_logo2 = Material("breach2/scp_logo_2.png", "noclamp smooth")

local br2_server1 = Material("breach2/br2_server_1.png", "noclamp smooth")
local br2_server2 = Material("breach2/br2_server_2.png", "noclamp smooth")

local br2_question = Material("breach2/br2_question.png", "noclamp smooth")
local br2_tutorial = Material("breach2/br2_tutorial.png", "noclamp smooth")
local br2_tutorial2 = Material("breach2/br2_tutorial_2.png", "noclamp smooth")
local br2_development = Material("breach2/br2_development.png", "noclamp smooth")

local br2_mtf_logo_1 = Material("breach2/mtf_epsilon11_1.png", "noclamp smooth")
local br2_mtf_logo_2 = Material("breach2/mtf_epsilon11_2.png", "noclamp smooth")

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
			text = "Breach 2: the successor to Breach",
			pos = {im1s, last_y},
			xalign = TEXT_ALIGN_LEFT,
			yalign = TEXT_ALIGN_TOP,
			font = "BR_INFO_1_FONT_2",
			color = Color(255,255,255,200),
        })
        last_y = last_y + ((info_menu_exit_size_o * 1.5) * size_mul) + im1s
        
        local info_table = {
            "Gamemode made by Kanade",
            --"Map originally made by Default_OS, heavily edited by Kanade",
            "Models, textures and sounds were made by the Undertow Games",
            --"The whole entrance zone was made by Kanade",
            "Playermodels were made by KERRY and maJor",
            --"NPCs were made by Cpt. Hazama, edited by Kanade",
            "Weapons are using the TFA Base made by The Forgotten Architect",
            "Some SCP:CB prop models were made by nasvaykid",
            "Music and some ambients were made by Creative Assembly",
            "Special thanks to:",
            " - Polish_User for a lot of gameplay ideas and bug-fixes",
            " - Dr.arielpro for quality checks and content ideas",
            true,
            {"This gamemode is currently only available to play on Kanade's servers", Color(89,183,255,175)},
            {"It will be published after its fully completed and bug-free", Color(89,183,255,175)},
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

    if SERVER_INFO.OFFICIAL == true then
        table.ForceInsert(info_table, {"This server is an official Breach 2 testing server", Color(255,215,0,200)})
    end
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
            "If you find a bug or a problem, try fixing it yourself before reporting",
            "Some bugs may be known and are being worked on, check the FAQ",
            "If the bug is not disappearing, please contact us"
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
            " - Yes, when its finished and bug-free",
            "Will <x> SCP be added?",
            " - I have a lot of ideas for SCPs and some of them will be added",
            "   If you really want a certain SCP to be added, send me an idea",
            "   on how it should work and possible resources (models, sounds)",
            "Will <something> be added in the future?",
            " - Like before, I have a lot of ideas and if you really want something, contact me"
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
            "If you want to contact anybody working on this project, join the discord server",
            "Click the link below and check the console/chat to copy"
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
        gui.OpenURL("https:--discordapp.com/invite/sqcjFbX")
        print("Discord link: ")
        print("https:--discordapp.com/invite/sqcjFbX")
        chat.AddText("https:--discordapp.com/invite/sqcjFbX")
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
                "This gamemode takes place in the SCP Universe, from the SCP wiki.",
                "It's based on the greatest SCP game: SCP: Containment Breach.",
                "If you have played any older version of this gamemode, SCP:CB or SCP:SL,",
                "you will generally know what to do and what not to do.",
                "But if you have never played any of these, don't worry, this gamemode isn't hard.",
                "",
                "The SCP Foundation is a secret organisation focused on containing anomalous objects.",
                "After capturing and containing these objects in a secure facility, they are researched.",
                "Humans that are used as guinea pigs in research are reffered to as Class D Personnel.",
                "Every corner of the facility is guarded by officers from the Security Department.",
                "Unfortunately, sometimes groups of interest attack the facility for various reasons.",
                "",
                "In this gamemode the action is happening in Site-19, a large research facility.",
                'There are multiple scenarios but the main one is called the "Containment Breach"',
                "In this scenario the Chaos Insurgency (a group of interest) are raiding the facility.",
                "The attack started with a spy giving SCP-079 access to the site's systems.",
                "Multiple SCP objects have been released and chaos have ensued.",
                --"Now the facility's future is in your hands, will you recontain the SCPs or escape?"
            }
        },
        {
            main = "Tutorial 2: Factions",
            texts = {
                "In Breach 2 there are four main factions.",
                "The first and the most important: SCP Foundation which includes:",
                " - Security Department Officers",
                " - Internal Security Department Agents",
                " - Researchers",
                " - Engineers",
                " - Janitors, Doctors",
                " - Mobile Task Forces",
                "The second faction is the Chaos Insurgency which includes:",
                " - Researcher spies",
                " - Security Department spies",
                " - Chaos Insurgency Soldiers",
                "The third one is just the Class D Personnel",
                "The fourth faction includes all SCP Objects",
                --"Currently most SCPs are AI controlled but in the future more will be playable",
                --"AI controlled SCPs: SCP-173, 106, 457, 575, 096, 939, 1025",
                --"Minor SCP objects: SCP-500, 012, 513, 714",
                --"Player controlled SCPs: SCP-049 (035, 106, 173 are planned additions)"
            }
        },
        {
            main = "Tutorial 3: Roles",
            texts = {
                "Now lets take a deeper look at the roles in all of these factions",
                "1. SD Officer",
                " Highly trained officers from the Security Department that keep order in the facility",
                " They are equipped with lethal weapons, radios and gasmasks",
                " Their mission is to kill any Class Ds and help site staff getting to evac shelters",
                "2. ISD Agent",
                " Agents from the Internal Security Department are always hunting down any traitors",
                " Their job is to find and capture spies from any group of interests inside the facility",
                "3. Researchers",
                " Researchers are an essential part of the foundation, they try to figure out anomalies",
                " When a breach happens, the best thing they can do is escape the facility",
                "4. Engineers",
                " They analyze, maintain and repair any on-site systems and machines",
                "5. Janitors / Doctors",
                " They just have to survive the containment breach and escape with the researchers",
                "6. Mobile Task Forces",
                " When a breach happens and facility descends into chaos, they try to fix the situation",
                " They are equipped with heavy weaponry, night vision googles, medkits, grenades etc",
            }
        },
        {
            main = "Tutorial 4: Mechanics 1",
            texts = {
                --"Breach 2 is a complex gamemode with a lot of mechanics and items",
                "There are many mechanics in Breach 2, here are the most important ones:",
                "1. Gas:",
                " There are some areas where gas may be leaking and without a gas mask is harmful",
                "2. Temperature:",
                " It is very cold outside the facility and if you want to escape, find a warm outfit",
                "3. Sanity:",
                " If you want to escape successfully, you will have to maintain your sanity",
                " Your sanity can go down in certain conditions, including:",
                "  - Being affected by SCP objects",
                "  - Being attacked",
                "  - Being AFK",
                " And also you can increase your sanity levels by:",
                "  - Taking SSRI pills",
                "4. Escaping:",
                " If you are a Class D, Researcher, Janitor or a Doctor, you might want to escape",
                " Grab a warm outfit and find Gate A or Gate B, then escape through an exit",
                " Also you can escape through the evac shelter if the security manages to do so"
                -- GAS, SANITY, TEMPERATURE, FOG, MTF SPAWN, ESCAPING, EVAC SHELTER, DOWNING N REVIVING, OUTFITS, ITEMS, TERMINALS
            } 
        },
        {
            main = "Tutorial 5: Mechanics 2",
            texts = {
                "5. Downing / Reviving",
                " There is a chance that someone with low hp will get downed if they get shot",
                " They will start bleeding and after checking their pulse, they can be revived",
                "6. Outfits",
                " There are places in the facility where you can change your outfit",
                " You can get a warmer one to escape this place or steal one to disguise as someone",
                "7. Terminals",
                " Site terminals are typically used to message staff or store information",
                " You can check the cameras using them and some of them have special options",
                "8. Support spawns",
                " If you die, you can still get back into the action using the support mechanics",
                " Somebody can only respawn once",
                " Class D personnel can respawn with low health and no items around the LCZ area",
                " SCP objects can spawn as zombies around the facility to harass other players",
                " Any foundation personnel can spawn in Mobile Task Force squads",
                " Any member of the Chaos Insurgency can spawn in groups as CI Soldiers",
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
                "In breach 2 there are many unique items, here is a simple list of them:",
                "1. Keycards",
                " Keycard are used to open any doors that require them",
                " There are 6 types of keycards of different clearances",
                "2. 9V Battery",
                " Using a 9v battery you can replace the batteries in other items",
                "3. Radio",
                " Using radios, players can communicate wirelessly",
                "4. Night Vision Googles",
                " NVGs are used to see better in dark areas",
                "5. Gasmask",
                " Gasmasks are used to breathe in areas where lethal gas is leaking",
                "6. SSRI Pills",
                " These pills are used to fix someone's sanity",
                "7. Medkit",
                "They contain bruise packs that heal 30HP, blood bags that heal 50HP",
                "Bandages that heal 15HP and stop player's bleeding,",
                "And ointments that heal 10HP and extinguish the player",
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
			text = "Gamemode tutorial",
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
            "Development of Breach 2 started in january of 2018",
            "This gamemode, like Breach is being developed only by Kanade",
            "Because of that the development is very slow and hard",
            true,
            {"Current goals of the gamemode:", Color(255,128,0,175)},
            " - Fix all bugs and errors",
            " - Make the UI scaling good on most resolutions",
            " - Add more content (mostly items, mechanics)",
            " - Make the gamemode more consistent",
            " - Develop the map (better rooms, lighting)",
            " - Add playable SCP-106 and SCP-035",
            " - More player settings and customizations",
            " - Add random and triggered events around the facility",
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





-- ##################################################################### OTHER INFO MENUS #####################################################################





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
            "Mobile Task Force teams will be sent into the facility",
            "They are equipped with military grade equipment and weapons",
            "Their job is to recontain all SCPs and bring order to the facility",
            "Every captured Class D or CI member is valuable to the SCP Foundation",
            "They also have to open the evacuation shelters for staff trapped inside",
            "Choose in which Mobile Task Force team you want to spawn in",
            "Cooperate and work with your teammates to achieve victory",
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
    local num_of_teams = 4
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
                    net.WriteInt(i, 4)
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

print("[Breach2] client/derma/menu_info.lua loaded!")