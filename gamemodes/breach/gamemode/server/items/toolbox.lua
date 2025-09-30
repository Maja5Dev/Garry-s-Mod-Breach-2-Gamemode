
local BR2_TOOLBOX_ITEMS = {
	{
		info = "You crafted a Lockpick",
		func = function(pl)
			table.ForceInsert(pl.br_special_items, {class = "lockpick"})
		end,
	},
	{
		info = "You crafted a Flashlight",
		func = function(pl)
			table.ForceInsert(pl.br_special_items, {class = "flashlight_normal"})
		end,
	},
	{
		info = "You crafted a Pipe",
		func = function(pl)
			for k,v in pairs(pl:GetWeapons()) do
				if v:GetClass() == "kanade_tfa_pipe" then
					pl:DropWep(v, 0)
				end
			end
			pl:Give("kanade_tfa_pipe")
		end,
	},
}

special_item_system.AddItem({
    class = "crafting_toolbox",
    name = "Toolbox",
    func = function(pl, ent)
        table.ForceInsert(pl.br_special_items, {class = "crafting_toolbox", attributes = ent.Attributes})
        return true
    end,
    use = function(pl, item)
        if pl:IsBackPackFull() then
            pl:PrintMessage(HUD_PRINTTALK, "Your inventory is full!")
            return
        end

        if !istable(item.attributes) then
            item.attributes = {}
        end

        if item.attributes["uses"] == nil then
            item.attributes["uses"] = 2
        end

        local rand_item = table.Random(BR2_TOOLBOX_ITEMS)
        rand_item.func(pl)

        item.attributes["uses"] = item.attributes["uses"] - 1

        local text = " uses"
        if item.attributes["uses"] == 1 then
            text = " use"
        end

        pl:ChatPrint(rand_item.info..", the toolbox has "..item.attributes["uses"]..text.." left")

        if item.attributes["uses"] == 0 then
            return true
        end

        return false
    end,
    onstart = function(pl)
        if pl.br_role == "Engineer" then
            table.ForceInsert(pl.br_special_items, {class = "crafting_toolbox"})
        end
    end,
    drop = function(pl, item)
        local res, item = br2_special_item_drop(pl, "crafting_toolbox", "Toolbox", "prop_physics", "models/cultist/items/toolbox/tool_box.mdl", item)
        return item
    end,
    scp_1162 = function(pl, ent)
        ent.PrintName = "Toolbox"
        ent.SI_Class = "crafting_toolbox"
        ForceSetPrintName(ent, ent.PrintName)
    end
})
