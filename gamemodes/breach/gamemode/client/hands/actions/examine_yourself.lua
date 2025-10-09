
local fake_examine_stats = false

local function examine_Armor(pl)
    if pl:Armor() > 0 then
        chat.AddText(Color(255, 255, 255), " - You are wearing some kind of armor")
    end
end

local function examine_PersonalInfo(pl)
    local our_showname = nil
    local our_role = nil
    local isscp = false
    local isciagent = false

    if pl.br_role and pl.br_showname then
        our_showname = pl.br_showname
        our_role = pl.br_role
        isscp = (pl.br_team == TEAM_SCP)
        isciagent = pl.br_ci_agent
    end

    if istable(BR2_OURNOTEPAD) and istable(BR2_OURNOTEPAD.people) and table.Count(BR2_OURNOTEPAD.people) > 0 then
        if !our_showname then
            our_showname = BR2_OURNOTEPAD.people[1].br_showname
        end
        if !our_role then
            our_role = BR2_OURNOTEPAD.people[1].br_role
        end
        if isscp == nil then
            isscp = (BR2_OURNOTEPAD.people[1].br_team == TEAM_SCP) or (BR2_OURNOTEPAD.people[1].scp)
        end
        if isciagent == nil then
            isciagent = BR2_OURNOTEPAD.people[1].br_ci_agent
        end
    end

    local prefix = " - You are "
    if our_role == ROLE_SCP_035 then
        prefix = " - Your host is called "
    end

    if our_showname and (!isscp or our_showname != our_role) then
        if our_showname == "D-9341" then
            chat.AddText(Color(255,255,255,255), prefix .. "D-9341, ", Color(244,65,131,255), "the chosen one")
        else
            chat.AddText(Color(255,255,255,255), prefix, Color(255,255,255,255), our_showname)
        end
    end

    if our_role then
        chat.AddText(Color(255,255,255,255), " - You are a ", Color(255,255,255,255), our_role)
    end

    if isciagent then
        chat.AddText(Color(255, 255, 255), prefix .. "a ", Color(255, 0, 255), "Chaos Insurgency Spy", Color(255, 255, 255), "!")
    end
end

local function examine_SCP035(pl)
    if our_role == ROLE_SCP_035 then
        local health_times_left = math.Round(pl:Health() / (pl:GetMaxHealth() * 0.01))

        local last_decay = pl:GetNWFloat("last035decay", CurTime())

        local time_left = (health_times_left * cvars.Number("br2_035_decay_speed", 5)) - (CurTime() - last_decay)

        local text_left = ""

        if time_left <= 60 then
            if time_left < 2 then
                text_left = ", goodbye"
            else
                text_left = ", it has " .. math.floor(time_left) .. " seconds left"
            end

        else
            text_left = ", it has " .. string.FormattedTime(time_left, "%02i:%02i") .. " minutes left"
        end

        chat.AddText(Color(255,0,0,255), " - The body of your host is decaying (" .. (100 - math.Round(health_times_left)) .. "%)" .. text_left)
    end
end

local function examine_Weapons(pl)
    local has_wep = false

    for k,v in pairs(pl:GetWeapons()) do
        if IsValid(v) and isLethalWeapon(v) then
            has_wep = true
        end
    end

    if has_wep then
        chat.AddText(Color(255, 255, 255), " - You are carrying lethal weapons")
    end
end

local function examine_Zone(pl)
    local our_area = pl:GetZone()
    local area_name = pl:GetSubAreaName()

    if area_name then
        chat.AddText(Color(255, 255, 255), " - " .. "Location: "..pl:GetSubAreaName())
    else
        if istable(our_area) and isstring(our_area.examine_info) then
            chat.AddText(Color(255, 255, 255), " - " .. our_area.examine_info)
        end
    end
end

local function examine_TemperatureZone(pl)
    if istable(our_area) and isnumber(our_area.zone_temp) then
        if our_area.zone_temp == ZONE_TEMP_WARM then
            chat.AddText(Color(255, 255, 255), " - You feel like it's warm here")

        elseif our_area.zone_temp == ZONE_TEMP_HOT then
            chat.AddText(Color(255, 255, 255), " - You feel like it's hot here")

        elseif our_area.zone_temp == ZONE_TEMP_COLD then
            chat.AddText(Color(255, 255, 255), " - You feel like it's cold here")

        elseif our_area.zone_temp == ZONE_TEMP_VERYCOLD then
            chat.AddText(Color(255, 255, 255), " - You feel like it's very cold here")
        end
    end
end

local function examine_Temperature(pl)
    local high_temp_enabled = SafeBoolConVar("br2_temperature_high_enabled")

    if BR_OUR_TEMPERATURE < -900 then
        chat.AddText(Color(255, 0, 0), " - Your body is freezing!")

    elseif BR_OUR_TEMPERATURE < -500 then
        chat.AddText(Color(255, 100, 100), " - Your body temperature is very low")

    elseif BR_OUR_TEMPERATURE < -200 then
        chat.AddText(Color(255, 255, 255), " - Your body temperature is low")

    elseif high_temp_enabled and BR_OUR_TEMPERATURE > 900 then
        chat.AddText(Color(255, 0, 0), " - Your body temperature is very high!")

    elseif high_temp_enabled and BR_OUR_TEMPERATURE > 500 then
        chat.AddText(Color(255, 100, 100), " - Your body temperature is very high")

    elseif high_temp_enabled and BR_OUR_TEMPERATURE > 200 then
        chat.AddText(Color(255, 255, 255), " - Your body temperature is high")

    else
        chat.AddText(Color(255, 255, 255), " - Your body temperature is normal")
    end
end

local function examine_Outfit(pl)
    local our_outfit = pl:GetOutfit()
    
    if istable(our_outfit) and isstring(our_outfit.examine) then
        chat.AddText(Color(255, 255, 255), " - "..our_outfit.examine)
    end
end

local function examine_Health(pl)
    local t_health, c_health = NiceHealth()
    if fake_stats then
        local insane_texts = {
            "Very healthy!",
            "Healthy!",
            "Just fine!",
            "Good enough!",
            "Healthy, just a little bit tired!",
            "SCP-173 is behind you!",
            "Today was the pizza day, right?",
            "I am going to die"
        }
        chat.AddText(Color(255,255,255,255), " - Your health: ", Color(0,255,0,255), tostring(table.Random(insane_texts)))
    else
        chat.AddText(Color(255,255,255,255), " - Your health: ", c_health, t_health)
    end
end

local function examine_Sanity(pl)
    local t_sanity, c_sanity = NiceSanity()
    if fake_stats then
        local insane_texts = {
            "Totally fine!",
            "Completely sane!",
            "Fully sane, as always!",
            "Who even cares about sanity?",
            "Very fine! dont worry...",
        }
        chat.AddText(Color(255,255,255,255), " - Your mental state: ", Color(0,255,0,255), tostring(table.Random(insane_texts)))
    else
        chat.AddText(Color(255,255,255,255), " - Your mental state: ", c_sanity, t_sanity)
    end
end

local function examine_Infection(pl)
    if BR_OUR_INFECTION >= 25 then
        chat.AddText(Color(255,255,255,255), " - You feel weak")

    elseif BR_OUR_INFECTION >= 50 then
    	chat.AddText(Color(255,255,255,255), " - You feel like you are sick")

    elseif BR_OUR_INFECTION >= 75 then
    	chat.AddText(Color(255,255,255,255), " - You feel like you are sick")
    end
end

local function examine_Hunger(pl)
    if br_our_hunger == nil then return end

    if br_our_hunger < 25 then
        chat.AddText(Color(255,0,0,255), " - You are very hungry!")

    elseif br_our_hunger < 50 then
        chat.AddText(Color(255,100,0,255), " - You are hungry!")

    elseif br_our_hunger < 75 then
        chat.AddText(Color(255,255,255,255), " - You are a bit hungry")
    else
        chat.AddText(Color(255,255,255,255), " - You aren't hungry")
    end
end

local function examine_Thirst(pl)
    if br_our_thirst == nil then return end

    if br_our_thirst < 25 then
        chat.AddText(Color(255,0,0,255), " - You are very thirsty!")

    elseif br_our_thirst < 50 then
        chat.AddText(Color(255,100,0,255), " - You are thirsty!")

    elseif br_our_thirst < 75 then
        chat.AddText(Color(255,255,255,255), " - You are a bit thirsty")
        
    else
        chat.AddText(Color(255,255,255,255), " - You aren't thirsty")
    end
end

local function examine_Bleeding(pl)
    if br2_is_bleeding == true or (fake_stats and math.random(1,2) == 2) then
        chat.AddText(Color(255,0,0,255), " - You are bleeding!")
    end
end

local function examine_WaterLevel(pl)
    local water = pl:WaterLevel()

    if water == 1 then
        chat.AddText(Color(56,205,255), " - You are slightly submerged")

    elseif water == 2 then
        chat.AddText(Color(56,205,255), " - You are submerged")

    elseif water == 3 then
        chat.AddText(Color(56, 205,255), " - You are completely submerged")
    end
end

local function examine_OnFire(pl)
    if pl:IsOnFire() then
        chat.AddText(Color(255,0,0), " - You are on fire!")
    end
end

local function examine_Dissolving(pl)
    if pl:IsFlagSet(FL_DISSOLVING) then
        chat.AddText(Color(0,255,0), " - You are dissolving!")
    end
end

local function examine_yourself()
    local pl = LocalPlayer()

    chat.AddText(Color(255,255,255,255), "Examining...")

    if pl:Alive() == false then
        chat.AddText(Color(255, 255, 255), " - Well, you are dead... I guess")
        return
    end

    fake_examine_stats = false

    if math.random(1,4) == 2 and br2_our_sanity < 2 then
        fake_examine_stats = true
    end

    examine_PersonalInfo(pl)
    examine_SCP035(pl)

    examine_Armor(pl)
    examine_Weapons(pl)

    examine_Zone(pl)
    examine_TemperatureZone(pl)
    examine_Temperature(pl)
    examine_Outfit(pl)

    examine_Sanity(pl)
    examine_Health(pl)
    examine_Bleeding(pl)
    examine_Infection(pl)

    examine_Hunger(pl)
    examine_Thirst(pl)
    
    examine_WaterLevel(pl)
    examine_OnFire(pl)
    examine_Dissolving(pl)
end

registerHandsAction("examine_yourself", {
    name = "Examine yourself",
    desc = "Check everything you know about yourself",
    background_color = Color(125,125,125),

    canDo = true,

    cl_effect = function(self)
        examine_yourself()
    end,

    cl_after = function(self)
        WeaponFrame:Remove()
    end,

    sort = 1
})
