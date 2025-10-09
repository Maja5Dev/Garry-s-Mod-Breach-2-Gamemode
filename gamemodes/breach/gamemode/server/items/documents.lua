

special_item_system.AddItem({
    class = "document",
    name = "Document",
    func = function(pl, ent)
        table.ForceInsert(pl.br_special_items, {class = "document", name = ent.PrintName, type = ent.DocType, attributes = ent.DocAttributes})
        return true
    end,
    use = function(pl, item)
        net.Start("br_use_document")
            net.WriteTable(item)
        net.Send(pl)

        pl:EmitSound("breach2/UI/Pickups/PICKUP_Map_01.ogg")

        return false
    end,
    drop = function(pl, item)
        --local res, ent = br2_special_item_drop(pl, "document", "Document", "prop_physics", "models/props_interiors/paper_tray.mdl")
        local res, ent = br2_special_item_drop(pl, "document", "Document", "prop_physics", "models/foodnhouseholditems/newspaper2.mdl", item)
        ent.PrintName = item.name
        ent.DocType = item.type
        ent.DocAttributes = item.attributes
        ForceSetPrintName(ent, ent.PrintName)
        ent:SetNWString("SetPrintName", ent.PrintName)

        return ent
    end
})

special_item_system.AddItem({
    class = "conf_folder",
    name = "Confidential Folder",
    func = function(pl)
        table.ForceInsert(pl.br_special_items, {class = "conf_folder"})
        return true
    end,
    use = function(pl, item)
        pl:PrintMessage(HUD_PRINTTALK, "Folder of Confidential Information")
        if pl.br_team == TEAM_CI then
            pl:SendLua('chat.AddText(Color(195, 55, 255), "This folder is a valuable property of the SCP Foundation, stealing it would be a good idea!")')
        
        elseif pl.br_team == TEAM_RESEARCHER or pl.br_team == TEAM_SECURITY then
            pl:SendLua('chat.AddText(Color(255, 225, 0), "This folder is a valuable property of the SCP Foundation, keep it safe!")')
        end
        return false
    end,
    onstart = function(pl)
        if pl.br_role == ROLE_RESEARCHER or pl:GetOutfit().class == "scientist" then
            table.ForceInsert(pl.br_special_items, {class = "conf_folder"})
        end
    end,
    drop = function(pl)
        local res, item = br2_special_item_drop(pl, "conf_folder", "Confidential Folder", "prop_physics", "models/scp_documents/secret_document.mdl")
        return item
    end
})
