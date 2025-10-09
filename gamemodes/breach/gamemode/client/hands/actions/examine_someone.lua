
local function examine_Ragdoll(pl)
    if pl.Pulse then
        if pl.Pulse == true then
            chat.AddText(Color(255,0,0,255), " - They are dead")

            local dmg_info = pl:GetNWString("ExamineDmgInfo", nil)

            if dmg_info != nil then
                chat.AddText(Color(255,0,0,255), dmg_info)
            end

            local death_time = pl:GetNWInt("DeathTime", nil)

            if death_time != nil then
                chat.AddText(Color(255,255,255,255), " - They died " .. string.ToMinutesSeconds(CurTime() - death_time) .. " minutes ago")
            end

            return

        elseif isnumber(pl.Pulse) then
            chat.AddText(Color(255,255,255,255), " - They are probably alive")
            return
        end
    end

    chat.AddText(Color(255,255,255,255), " - Looks dead but i am not sure...")
end

local function examine_Outfit(pl)
    local outfit = pl:GetOutfit()

    if outfit != nil and outfit.examine_info != nil then
        chat.AddText(Color(255, 255, 255, 255), outfit.examine_info)
    end
end

local function examine_PersonalInfo(pl)
    if pl.br_showname != nil then
        if pl.br_showname == "D-9341" then
            chat.AddText(Color(255,255,255,255), " - You remember that they were the Class D-", Color(255,0,0), "9341")
        else
            chat.AddText(Color(255,255,255,255), " - You remember that their name was " .. pl.br_showname)
        end
    else
        chat.AddText(Color(255,255,255,255), " - You don't really know a lot about this person")
    end
    if pl.br_ci_agent == true then
        chat.AddText(Color(195, 55, 255), " - You rememeber that they were a Chaos Insurgency Spy!")
    end
end

local function examine_Armor(pl)
    if pl:Armor() > 0 then
        chat.AddText(Color(56, 205,255), " - They seems to be wearing some kind of armor")
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
        chat.AddText(Color(56, 205,255), " - They seem to be carrying lethal weapons")
    end
end

local function examine_WaterLevel(pl)
    local water = pl:WaterLevel()

    if water == 1 then
        chat.AddText(Color(255,255,255), " - They are slightly submerged")

    elseif water == 2 then
        chat.AddText(Color(255,255,255), " - They are submerged")

    elseif water == 3 then
        chat.AddText(Color(255, 255,255), " - They are completely submerged")
    end
end

local function examine_OnFire(pl)
    if pl:IsOnFire() then
        chat.AddText(Color(255,0,0), " - They are on fire!")
    end
end

local function examine_Dissolving(pl)
    if pl:IsFlagSet(FL_DISSOLVING) then
        chat.AddText(Color(0,255,0), " - They are dissolving!")
    end
end

local function examine_someone()
    local pl = lastseen_player
    if !IsValid(pl) then return end

    chat.AddText(Color(255,255,255,255), "Examining...")

    if pl:GetClass() == "prop_ragdoll" then
        examine_Ragdoll(pl)
        return
    end

    examine_Outfit(pl)
    examine_PersonalInfo(pl)
    examine_Armor(pl)
    examine_Weapons(pl)
    examine_WaterLevel(pl)
    examine_OnFire(pl)
    examine_Dissolving(pl)
end

registerHandsAction("examine_someone", {
    name = "Examine someone",
    desc = "Examine the player you last seen",
    background_color = Color(125,125,125),

    canDo = function(self)
        return (CurTime() - lastseen) < 4
        and IsValid(lastseen_player)

        and (
            (lastseen_player:IsPlayer()
            and lastseen_player.br_team != TEAM_SCP
            and (CurTime() - lastseen) < 4)

            or
            
            (lastseen_player:GetClass() == "prop_ragdoll")
        )
    end,

    cl_effect = function(self)
        examine_someone()
    end,

    cl_after = function(self)
        WeaponFrame:Remove()
    end,

    sort = 2
})
