
special_item_system.AddItem({
    class = "personal_medkit",
    name = "Personal Medkit",
    upgrade = function(ent)
        if !istable(ent.Attributes) then
            ent.Attributes = {}
        end
        if ent.Attributes["uses"] == nil then
            ent.Attributes["uses"] = 3
        end

        if br_914status == SCP914_ROUGH then
            return table.Random({"ssri_pills", "antibiotics"})

        elseif br_914status == SCP914_COARSE then
            return "syringe"

        elseif br_914status == SCP914_FINE then
            if ent.Attributes["uses"] < 3 then
                ent.Attributes["uses"] = ent.Attributes["uses"] + 1
                return ent
            end

        elseif br_914status == SCP914_VERY_FINE then
            if ent.Attributes["uses"] < 3 then
                ent.Attributes["uses"] = 3
                return ent
            else
                return "item_medkit"
            end
        end

        return ent
    end,
    func = function(pl, ent)
        table.ForceInsert(pl.br_special_items, {class = "personal_medkit", attributes = ent.Attributes})
        return true
    end,
    use = function(pl, item)
        if pl.br_role == ROLE_SCP_049 then
            pl:BR2_ShowNotification("Ineffective alchemies. I better throw this away.")
            return false
        end

        if pl:Health() == pl:GetMaxHealth() and pl.br_isBleeding == false then
            pl:BR2_ShowNotification("I don't need to use this right now.")
            return false
        end

        if !istable(item.attributes) then
            item.attributes = {}
        end

        if item.attributes["uses"] == nil then
            item.attributes["uses"] = 3
        end

        pl.br_isBleeding = false
        pl:AddHealth(50)

        item.attributes["uses"] = item.attributes["uses"] - 1
        if item.attributes["uses"] == 0 then
            return true
        end

        local text = " uses"
        if item.attributes["uses"] == 1 then
            text = " use"
        end

        pl:ChatPrint("You feel much better, the medkit has "..item.attributes["uses"]..text.." left")

        return false
    end,
    drop = function(pl, item)
        local res, item = br2_special_item_drop(pl, "personal_medkit", "Personal Medkit", "prop_physics", "models/cultist/items/medkit/w_medkit.mdl", item)
        return item
    end
})

special_item_system.AddItem({
    class = "syringe",
    name = "Syringe",
    upgrade = function(ent)
        local r = math.random(1,100)

        if br_914status == SCP914_ROUGH then
            return table.Random({"antibiotics", "eyedrops"})

        elseif br_914status == SCP914_COARSE then
            return table.Random({"ssri_pills", "antibiotics"})

        elseif br_914status == SCP914_1_1 then
            if r < 26 then
                return "ssri_pills"
            end

        elseif br_914status == SCP914_FINE then
            if r > 26 then
                return "personal_medkit"
            end

        elseif br_914status == SCP914_VERY_FINE then
            if r < 16 then
                return "item_medkit"
            else
                return "personal_medkit"
            end
        end

        return ent
    end,
    func = function(pl)
        table.ForceInsert(pl.br_special_items, {class = "syringe"})
        return true
    end,
    use = function(pl, item)
        if pl.br_role == ROLE_SCP_049 then
            pl:BR2_ShowNotification("This will serve better in my studies than in my veins.")
            return false
        end

        pl:AddRunStamina(3000)
        pl:AddJumpStamina(200)
        pl.CrippledStamina = 0
        pl.nextNormalRun = CurTime()
        pl.br_speed_boost = CurTime() + 15
        pl:SetFOV(110, 1)
        pl.br_used_syringe = true

        pl:SendLua('surface.PlaySound("breach2/player/adrenaline_needle_in.wav")')
        return true
    end,
    drop = function(pl)
        local res, item = br2_special_item_drop(pl, "syringe", "Syringe", "prop_physics", "models/mishka/models/syringe.mdl")
        return item
    end
})

special_item_system.AddItem({
    class = "scp_500",
    name = "SCP-500",
    upgrade = function(ent)
        local r = math.random(1,100)

        if br_914status == SCP914_ROUGH then
            return table.Random({"ssri_pills", "antibiotics"})

        elseif br_914status == SCP914_COARSE then
            return "personal_medkit"

        elseif br_914status == SCP914_1_1 or br_914status == SCP914_FINE then
            if r > 20 then
                return "item_medkit"
            end

        elseif br_914status == SCP914_VERY_FINE then
            if r < 31 then
                return "item_medkit"
            end
        end

        return ent
    end,
    func = function(pl)
        table.ForceInsert(pl.br_special_items, {class = "scp_500"})
        return true
    end,
    use = function(pl, item)
        if pl.br_role == ROLE_SCP_049 then
            pl:BR2_ShowNotification("A fleeting remedy that does not address the pestilence.")
            return false
        end

        pl:UsedSCP500()
        return true
    end,
    drop = function(pl)
        local res, item = br2_special_item_drop(pl, "scp_500", "SCP-500", "prop_physics", "models/cpthazama/scp/500.mdl")
        return item
    end
})

special_item_system.AddItem({
    class = "antibiotics",
    name = "Antibiotics",
    upgrade = function(ent)
        local r = math.random(1,100)

        if br_914status == SCP914_COARSE or br_914status == SCP914_ROUGH then
            return "eyedrops"

        elseif br_914status == SCP914_1_1 then
            if r < 51 then
                return "eyedrops"
            else
                return "ssri_pills"
            end

        elseif br_914status == SCP914_FINE then
            if r < 21 then
                return "syringe"
            else
                return "ssri_pills"
            end

        elseif br_914status == SCP914_VERY_FINE then
            if r < 10 then
                return "item_medkit"

            elseif r < 20 then
                return "personal_medkit"

            elseif r < 40 then
                return "syringe"

            else
                return "ssri_pills"
            end
        end

        return ent
    end,
    func = function(pl)
        table.ForceInsert(pl.br_special_items, {class = "antibiotics"})
        return true
    end,
    use = function(pl, item)
        if pl.br_role == ROLE_SCP_049 then
            pl:BR2_ShowNotification("Ineffective alchemies. I better throw this away.")
            return false
        end

        pl:EmitSound("breach2/items/pills_deploy_"..math.random(1,3)..".wav")

        pl:AddHealth(5)
        pl:AddSanity(20)

        pl.br_infection = math.Clamp(pl.br_infection - 65, 0, 100)

        if pl.br_infection < 3 then
            pl.br_isInfected = false
        end

        pl:BR2_ShowNotification("I hope this is effective...")
        return true
    end,
    onstart = function(pl)
        if pl.br_role == ROLE_DOCTOR or pl:GetOutfit().class == "medic" then
            table.ForceInsert(pl.br_special_items, {class = class})
        end
    end,
    drop = function(pl)
        local res, item = br2_special_item_drop(pl, "antibiotics", "Medicine", "prop_physics", "models/cultist/items/painpills/w_painpills.mdl")
        return item
    end
})

special_item_system.AddItem({
    class = "eyedrops",
    name = "Eyedrops",
    func = function(pl)
        table.ForceInsert(pl.br_special_items, {class = "eyedrops"})
        return true
    end,
    use = function(pl, item)
        pl.usedEyeDrops = CurTime() + 12
        pl:ChatPrint("Your used the eyedrops...")
        return true
    end,
    drop = function(pl)
        local res, item = br2_special_item_drop(pl, "eyedrops", "Eyedrops", "prop_physics", "models/cultist/items/eyedrops/eyedrops.mdl")
        return item
    end
})

special_item_system.AddItem({
    class = "ssri_pills",
    name = "SSRI Pills",
    func = function(pl)
        table.ForceInsert(pl.br_special_items, {class = "ssri_pills"})
        return true
    end,
    use = function(pl, item)
        if pl.br_role == ROLE_SCP_049 then
            pl:BR2_ShowNotification("Ineffective alchemies. I better throw this away.")
            return false
        end
        
        if pl:SanityLevel() > 4 then
            pl:PrintMessage(HUD_PRINTTALK, "Your sanity is fine, you don't need to use them.")
            return false
        end

        pl.nextHorrorSCP = CurTime() + 45
        pl:AddSanity(60)
        pl:EmitSound("breach2/items/pills_deploy_"..math.random(1,3)..".wav")
        pl:ChatPrint("Your took the pills... you feel calmer.")
        return true
    end,
    onstart = function(pl)
        if pl.br_role == ROLE_DOCTOR and math.random(1, 4) == 2 then
            table.ForceInsert(pl.br_special_items, {class = "ssri_pills"})
        end
    end,
    drop = function(pl)
        local res, item = br2_special_item_drop(pl, "ssri_pills", "SSRI Pills", "prop_physics", "models/cultist/items/painpills/w_painpills.mdl")
        return item
    end
})

special_item_system.AddItem({
    class = "scp_420",
    name = "SCP-420-J",
    upgrade = function(ent)
        local r = math.random(1,100)

        if br_914status == SCP914_ROUGH then
            return "eyedrops"

        elseif br_914status == SCP914_COARSE then
            return "antibiotics"

        elseif br_914status == SCP914_1_1 then
            return "ssri_pills"

        elseif br_914status == SCP914_FINE then
            if r < 31 then
                return table.Random({"ssri_pills", "syringe"})
            else
                return "personal_medkit"
            end

        elseif br_914status == SCP914_VERY_FINE then
            if r < 35 then
                return "item_medkit"
            else
                return "personal_medkit"
            end
        end
    end,
    func = function(pl)
        table.ForceInsert(pl.br_special_items, {class = "scp_420"})
        return true
    end,
    use = function(pl, item)
        weed_effects(pl)
        return true
    end,
    drop = function(pl)
        local res, item = br2_special_item_drop(pl, "scp_420", "SCP-420-J", "prop_physics", "models/mishka/models/scp420.mdl")
        return item
    end
})
