
br_round_end_votes = 0

function BR_SupportSpawnButtons()
    local size_mul = math.Clamp(ScrH() / 1080, 0.1, 1)

    local supsp_w = 256 * size_mul
    --local supsp_h = 512 * size_mul
    local supsp_h = ScrH() - (32 * size_mul)

    local panel_color = Color(50, 50, 50, 200)

	BR_SupportSpawns = vgui.Create("DFrame")
    BR_SupportSpawns:SetSize(supsp_w, supsp_h)
    BR_SupportSpawns:SetPos(16 * size_mul, 16 * size_mul)
	BR_SupportSpawns:SetDeleteOnClose(true)
	BR_SupportSpawns:SetSizable(false)
	BR_SupportSpawns:SetDraggable(false)
	BR_SupportSpawns:SetTitle("")
	--BR_SupportSpawns:MakePopup()
	BR_SupportSpawns:ShowCloseButton(false)
	BR_SupportSpawns.startTime = SysTime() - 2
	BR_SupportSpawns.Paint = function(self, w, h)
		--draw.RoundedBox(0, 0, 0, w, h, Color(50, 50, 50, 25))
    end
    
    local button_w = 320 * size_mul
    local button_h = 40 * size_mul

    local font_info = {
        font = "Tahoma",
        extended = false,
        size = 24 * size_mul,
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

    surface.CreateFont("BR_SUPSP_1_FONT_1", font_info)

    local function sendtoserver(name)
        net.Start("br_support_spawn")
            net.WriteString(name)
        net.SendToServer()
    end

    local supsp_tab1 = {
        explorer = {"Spawn as an explorer", function(name) sendtoserver(name) end},
        class_d = {"Spawn as a Class D", function(name) sendtoserver(name) end},
        researcher = {"Spawn as a Researcher", function(name) sendtoserver(name) end},
        scp_049_2 = {"Spawn as a SCP-049-2", function(name) sendtoserver(name) end},
        doctor = {"Spawn as a Doctor", function(name) sendtoserver(name) end},
        janitor = {"Spawn as a Janitor", function(name) sendtoserver(name) end},
        engineer = {"Spawn as an Engineer", function(name) sendtoserver(name) end},
        mtf = {1, function() Open_MTF_SpawnMenu() end},
        ci_soldier = {"Spawn in a CI Group", function(name) sendtoserver(name) end},
        cont_spec = {"Spawn as a ContSpec", function(name) sendtoserver(name) end}
    }

    if game_state == GAMESTATE_ROUND then
        local vote_button = vgui.Create("DButton", BR_SupportSpawns)
        vote_button:SetSize(button_w, button_h)
        vote_button:SetPos(0, supsp_h - button_h)
        vote_button:SetText("")
        vote_button.Paint = function(self, w, h)
            draw.RoundedBox(0, 0, 0, w, h, panel_color)
            local votes_needed = math.Round(#player.GetAll() * 0.75)
            local text = ""

            if br_voted_for_round_end then
                text = "Remove your vote ("..br_round_end_votes.."/"..votes_needed..")"
            else
                text = "Vote round end ("..br_round_end_votes.."/"..votes_needed..")"
            end

            draw.Text({
                text = text,
                pos = {w / 2, h / 2},
                xalign = TEXT_ALIGN_CENTER,
                yalign = TEXT_ALIGN_CENTER,
                font = "BR_SUPSP_1_FONT_1",
                color = Color(255,255,255,200),
            })
        end
        vote_button.DoClick = function()
            net.Start("br_vote_round_end")
            net.SendToServer()
        end
    end
    
    local function createbutts()
        local supsp_tab = {}

        if istable(br2_support_spawns) and table.Count(br2_support_spawns) > 0 then
            if CurTime() - br2_last_death < 30 then
                table.ForceInsert(supsp_tab, {nil, true})
            else
                for k,v in pairs(br2_support_spawns) do
                    if v[2] > 0 then
                        --print(v[1], supsp_tab1[v[1]])
                        table.ForceInsert(supsp_tab, {v[1], supsp_tab1[v[1]][1], supsp_tab1[v[1]][2]})
                    end
                end
            end
        end
    
        local last_y = 4 * size_mul

        for k,v in pairs(supsp_tab) do
            local supsp_button = vgui.Create("DButton", BR_SupportSpawns)
            supsp_button:SetSize(button_w, button_h)
            supsp_button:SetPos(0, last_y)
            supsp_button:SetText("")
            supsp_button.Paint = function(self, w, h)
                draw.RoundedBox(0, 0, 0, w, h, panel_color)
    
                local text = v[2]
                local int = 30 - (CurTime() - br2_last_death)
                if isbool(v[2]) then
                    text = "Spawn support in " .. math.Round(int) .. "s"
                end
                
                if isnumber(text) then
                    local mtf_spawn_time = GetConVar("br2_time_mtf_spawn"):GetFloat()
                    if mtf_spawn_time > (CurTime() - br2_round_state_start) then
                        text = "MTF Spawns in " .. math.Round(mtf_spawn_time - (CurTime() - br2_round_state_start)) .. "s"
                    else
                        text = "Spawn in a MTF Group"
                    end
                end

                draw.Text({
                    text = text,
                    pos = {w / 2, h / 2},
                    xalign = TEXT_ALIGN_CENTER,
                    yalign = TEXT_ALIGN_CENTER,
                    font = "BR_SUPSP_1_FONT_1",
                    color = Color(255,255,255,200),
                })
                if isbool(v[2]) and (int < 0) then
                    createbutts()
                    supsp_button:Remove()
                end
            end
            supsp_button.DoClick = function()
                if isnumber(v[2]) and GetConVar("br2_time_mtf_spawn"):GetFloat() > (CurTime() - br2_round_state_start) then
                    return
                end
                if v[1] != nil and v[3] != nil then
                    v[3](v[1])
                    BR_SupportSpawns:Remove()
                    BR_Scoreboard:Remove()
                end
            end
            last_y = last_y + button_h + (8 * size_mul)
        end
    end

    createbutts()
end

print("[Breach2] client/derma/menu_support_spawns.lua loaded!")
