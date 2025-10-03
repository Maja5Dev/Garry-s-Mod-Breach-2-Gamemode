
hook.Add("AddToolMenuTabs", "BR_AddSpawnmenuTab", function()
    spawnmenu.AddCreationTab("Breach Items", function()
        local ctrl = vgui.Create("SpawnmenuContentPanel")

        --ctrl:EnableModify()
        ctrl:EnableSearch("breachitems", "PopulateBRItems")

        ctrl:CallPopulateHook("PopulateBRItems")

        return ctrl
    end, "icon16/box.png")
end)

local function populateNode(pnlContent, tree, node, category_name, icon, tab, func)
    local node = tree:AddNode(category_name, icon)

    node.DoPopulate = function(self)
        if self.PropPanel then return end

        self.PropPanel = vgui.Create("ContentContainer", pnlContent)
        self.PropPanel:SetVisible(false)
        self.PropPanel:SetTriggerSpawnlistChange(false)

        for class, data in pairs(tab) do
            local res = func(self, class, data)
            if res == false then
                continue
            end
        end
    end

    node.DoClick = function(self)
        self:DoPopulate()
        pnlContent:SwitchPanel(self.PropPanel)
    end
end

local function populateSpecialItems(pnlContent, tree, node)
    populateNode(pnlContent, tree, node, "Items", "icon16/bricks.png", BR_ITEM_DESCRIPTIONS, function(self, class, data)
        if weapons.Get(class) then return false end
        if class == "document" or class == "cup" or string.find(class, "ammo_") or string.find(class, "drink_") or string.find(class, "food_") then return false end

        local icon = spawnmenu.CreateContentIcon("model", self.PropPanel, {
            nicename = data.name or class,
            spawnname = class, material = "entities/" .. class .. ".png", model = data.mdl or "", admin = true
        })

        icon.DoClick = function() RunConsoleCommand("br_spawn_item", class) end

        return true
    end)
end

local function populateAmmo(pnlContent, tree, node)
    populateNode(pnlContent, tree, node, "Ammo", "icon16/package.png", BR_ITEM_DESCRIPTIONS, function(self, class, data)
        if !string.find(class, "ammo_") then return false end

        local icon = spawnmenu.CreateContentIcon("model", self.PropPanel, {
            nicename = data.name or class,
            spawnname = class, material = "entities/" .. class .. ".png", model = data.mdl or "", admin = true
        })

        icon.DoClick = function() RunConsoleCommand("br_spawn_item", class) end

        return true
    end)
end

local function populateFood(pnlContent, tree, node)
    populateNode(pnlContent, tree, node, "Food", "icon16/emoticon_waii.png", BR_ITEM_DESCRIPTIONS, function(self, class, data)
        if !string.find(class, "food_") then return false end

        local icon = spawnmenu.CreateContentIcon("model", self.PropPanel, {
            nicename = data.name or class,
            spawnname = class, material = "entities/" .. class .. ".png", model = data.mdl or "", admin = true
        })

        icon.DoClick = function() RunConsoleCommand("br_spawn_item", class) end

        return true
    end)
end

local function populateDrinks(pnlContent, tree, node)
    populateNode(pnlContent, tree, node, "Drinks", "icon16/drink.png", BR_ITEM_DESCRIPTIONS, function(self, class, data)
        if !string.find(class, "drink_") then return false end

        local icon = spawnmenu.CreateContentIcon("model", self.PropPanel, {
            nicename = data.name or class,
            spawnname = class, material = "entities/" .. class .. ".png", model = data.mdl or "", admin = true
        })

        icon.DoClick = function() RunConsoleCommand("br_spawn_item", class) end

        return true
    end)
end

local function populateWeapons(pnlContent, tree, node)
    populateNode(pnlContent, tree, node, "Weapons", "icon16/gun.png", BR_ITEM_DESCRIPTIONS, function(self, class, data)
        local wepdata = weapons.Get(class)
        if !wepdata then return false end
        if !(table.HasValue(BR2_LETHAL_WEAPONS, class) or isBreachWeapon(wepdata)) or wepdata.ISSCP then return false end

        local name = data.name or class
        if wepdata and wepdata.PrintName then
            name = wepdata.PrintName
        end

        local icon = spawnmenu.CreateContentIcon("entity", self.PropPanel, {
            nicename = name, spawnname = class, material = "entities/" .. class .. ".png", admin = true
        })

        icon.DoClick = function() RunConsoleCommand("br_spawn_item", class)  end

        return true
    end)
end

local function populateSWEPItems(pnlContent, tree, node)
    populateNode(pnlContent, tree, node, "SWEP Items", "icon16/wrench.png", BR_ITEM_DESCRIPTIONS, function(self, class, data)
        local wepdata = weapons.Get(class)
        if !wepdata then return false end
        if table.HasValue(BR2_LETHAL_WEAPONS, class) or isBreachWeapon(wepdata) or wepdata.ISSCP then return false end

        local name = data.name or class
        if wepdata and wepdata.PrintName then
            name = wepdata.PrintName
        end

        local icon = spawnmenu.CreateContentIcon("model", self.PropPanel, {
            nicename = name, spawnname = class, material = "entities/" .. class .. ".png", model = wepdata.WorldModel or "", admin = true
        })

        icon.DoClick = function() RunConsoleCommand("br_spawn_item", class)  end

        return true
    end)
end

local function populateDocuments(pnlContent, tree, node)
    populateNode(pnlContent, tree, node, "Documents", "icon16/page_white_text.png", BR2_DOCUMENTS, function(self, class, data)
        local icon = spawnmenu.CreateContentIcon("entity", self.PropPanel, {
            nicename = data.name or data.class, spawnname = data.class, material = data.img.src, admin = true
        })

        icon.DoClick = function()
            RunConsoleCommand("br_spawn_item", data.class)
        end

        return true
    end)
end

local function populateSCP294Outcomes(pnlContent, tree, node)
    populateNode(pnlContent, tree, node, "SCP-294 Outcomes", "icon16/cup.png", BR2_SCP_294_OUTCOMES, function(self, class, data)
        local icon = spawnmenu.CreateContentIcon("entity", self.PropPanel, {
            nicename = "Cup of " .. data.texts[1], spawnname = data.texts[1], material = "", admin = true
        })

        icon.DoClick = function()
            RunConsoleCommand("br_spawn_item", data.texts[1])
        end

        return true
    end)
end

hook.Add("PopulateBRItems", "BR_PopulateSpawnmenu", function(pnlContent, tree, node)
    populateSpecialItems(pnlContent, tree, node)
    populateAmmo(pnlContent, tree, node)
    populateFood(pnlContent, tree, node)
    populateDrinks(pnlContent, tree, node)
    populateDocuments(pnlContent, tree, node)
    populateSWEPItems(pnlContent, tree, node)
    populateWeapons(pnlContent, tree, node)
    populateSCP294Outcomes(pnlContent, tree, node)
end)

search.AddProvider(function(str)
    local results = {}

    str = string.lower(str)

    for class, data in pairs(BR_ITEM_DESCRIPTIONS) do
        if class == "document" then continue end

        local name = string.lower(data.name or class)
        local showname = data.name or class

        local wepdata = weapons.Get(class)
        if wepdata and wepdata.ISSCP then continue end

        if wepdata and wepdata.PrintName then
            showname = wepdata.PrintName
        end

        local model = ""
        local icon_type = "entity"
        if wepdata and wepdata.WorldModel and wepdata.Category != "Kanade's TFA Pack" then
            model = wepdata.WorldModel
            icon_type = "model"
        end
        if data.mdl then
            model = data.mdl
            icon_type = "model"
        end

        if string.find(name, str, 1, true) or string.find(class, str, 1, true) then
            local entry = {
                text = name,
                icon = spawnmenu.CreateContentIcon(icon_type, g_SpawnMenu.SearchPropPanel, {
                    nicename = showname,
                    spawnname = class,
                    material = "entities/" .. class .. ".png",
                    model = model,
                    admin = true
                }),
                words = {class, data.name}
            }

            table.insert(results, entry)
        end
    end

    for _, data in pairs(BR2_DOCUMENTS) do
        local name = string.lower(data.name or data.class)

        local icon_material = ""
        if data.img.src then
            icon_material = data.img.src
        end

        if string.find(name, str, 1, true) or string.find(data.class, str, 1, true) then
            local entry = {
                text = name,
                icon = spawnmenu.CreateContentIcon("entity", g_SpawnMenu.SearchPropPanel, {
                    nicename = data.name or class,
                    spawnname = data.class,
                    material = icon_material,
                    admin = true
                }),
                words = {data.class, data.name}
            }

            table.insert(results, entry)
        end
    end

    for _, data in pairs(BR2_SCP_294_OUTCOMES) do
        local found = false
        local showname = ""
        for k,v in pairs(data.texts) do
            if string.find(v, str) then
                found = true
                showname = v
                break
            end
        end

        if found then
            local icon = spawnmenu.CreateContentIcon("entity", g_SpawnMenu.SearchPropPanel, {
                nicename = "Cup of " .. showname,
                spawnname = showname,
                material = "",
                admin = true
            })

            icon.DoClick = function()
                RunConsoleCommand("br_spawn_item", showname)
            end

            local entry = {
                text = showname,
                icon = icon,
                words = {showname}
            }

            table.insert(results, entry)
        end
    end

    return results
end, "breachitems")

