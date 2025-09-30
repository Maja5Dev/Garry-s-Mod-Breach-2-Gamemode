
special_item_system.AddItem({
    class = "severed_hand",
    name = "Severed Hand",
    func = function(pl)
        table.ForceInsert(pl.br_special_items, {class = "severed_hand"})
        return true
    end,
    use = function(pl, item)
        pl:BR2_ShowNotification("Ew... Might be useful...")
        return false
    end,
    drop = function(pl)
        local res, item = br2_special_item_drop(pl, "severed_hand", "Severed Hand", "prop_physics", "models/cultist/items/hand_keycard/hand_keycard.mdl")
        return item
    end
})

special_item_system.AddItem({
    class = "lockpick",
    name = "Lockpick",
    func = function(pl)
        table.ForceInsert(pl.br_special_items, {class = "lockpick"})
        return true
    end,
    use = function(pl)
        --pl:PrintMessage(HUD_PRINTTALK, "Universal lockpick, can be used to open doors or crates")
        local tr_lp = util.TraceLine({
            start = pl:EyePos(),
            endpos = pl:EyePos() + pl:EyeAngles():Forward() * 170,
            filter = pl
        })

        local tr_ent = tr_lp.Entity
        --print(tr_ent, IsValid(tr_ent), tr_ent:GetClass(), tr_ent:GetClass() == "prop_door_rotating")
        if IsValid(tr_ent) and tr_ent:GetClass() == "prop_door_rotating" then
            LockPickFunc(pl, tr_ent)
            --tr:Fire("unlock", "", 0)
            return
        end

        local closest = nil
        for k,v in pairs(MAPCONFIG.BUTTONS_2D.ITEM_CONTAINERS_CRATES.buttons) do
            local dis = v.pos:Distance(tr_lp.HitPos)
            if closest == nil or closest[2] > dis then
                closest = {v, dis}
            end
        end
        if closest != nil and closest[1].locked == true and closest[2] < 150 then
            LockPickFunc(pl, closest[1])
            return
        end

        pl:PrintMessage(HUD_PRINTTALK, "Universal lockpick, can be used to open doors or crates")
    end,
    onstart = function(pl)
        if pl.br_role == "Class D" and math.random(1,5) == 2 then
            table.ForceInsert(pl.br_special_items, {class = "lockpick"})
        end
    end,
    drop = function(pl)
        local res, item = br2_special_item_drop(pl, "lockpick", "Lockpick", "br2_item")
        return item
    end,
    scp_1162 = function(pl, ent)
        ent.PrintName = "Lockpick"
        ent.SI_Class = "lockpick"
        ForceSetPrintName(ent, ent.PrintName)
    end
})

special_item_system.AddItem({
    class = "coin",
    name = "Coin",
    upgrade = function(ent)
        local r = math.random(1,100)

        if br_914status == SCP914_1_1 then
            if r < 30 then
                return table.Random({"keycard_playing", "keycard_master"})
            end

        elseif br_914status == SCP914_FINE then
            if r < 51 then
                return table.Random({"keycard_playing", "keycard_master"})
            else
                return "keycard_level1"
            end

        elseif br_914status == SCP914_VERY_FINE then
            if r == 1 then
                return "keycard_omni"
            elseif r < 70 then
                return table.Random({"keycard_playing", "keycard_master"})
            else
                return "keycard_level1"
            end
        end

        return ent
    end,
    func = function(pl)
        table.ForceInsert(pl.br_special_items, {class = "coin"})
        return true
    end,
    use = function(pl)
        pl:PrintMessage(HUD_PRINTTALK, "Just a shiny coin, probably usable in some places")
    end,
    drop = function(pl)
        local res, item = br2_special_item_drop(pl, "coin", "Coin", "prop_physics", "models/cultist/items/coin/coin.mdl")
        return item
    end,
    scp_1162 = function(pl, ent)
        ent.PrintName = "Coin"
        ent.SI_Class = "coin"
        ForceSetPrintName(ent, ent.PrintName)
    end
})
