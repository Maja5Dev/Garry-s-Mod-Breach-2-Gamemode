
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

        local icon = spawnmenu.CreateContentIcon("breachitem", self.PropPanel, {
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

        local icon = spawnmenu.CreateContentIcon("breachitem", self.PropPanel, {
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

        local icon = spawnmenu.CreateContentIcon("breachitem", self.PropPanel, {
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

        local icon = spawnmenu.CreateContentIcon("breachitem", self.PropPanel, {
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
        local skin = nil
        if wepdata and wepdata.PrintName then
            name = wepdata.PrintName
        end
        if wepdata and wepdata.ForceSkin then
            skin = wepdata.ForceSkin
        end

        local icon = spawnmenu.CreateContentIcon("breachitem", self.PropPanel, {
            nicename = name, spawnname = class, material = "entities/" .. class .. ".png", model = wepdata.WorldModel or "", skin = skin, admin = true
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
        local icon = spawnmenu.CreateContentIcon("breachitem", self.PropPanel, {
            nicename = "Cup of " .. data.texts[1], spawnname = data.texts[1], model = "models/mishka/models/plastic_cup.mdl", admin = true
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

spawnmenu.AddContentType("breachitem", function(container, obj)
	-- basic validation
	if (not obj.nicename) then return end
	if (not obj.spawnname) then return end
	if (not obj.model and not obj.material) then return end

	local icon

	-- If we have a model, use a SpawnIcon (supports SetModel / rotating preview).
	if (obj.model and obj.model ~= "") then
		icon = vgui.Create("SpawnIcon", container)
        icon:SetSize(128, 128)
		icon:SetModel(obj.model, obj.skin)

		-- store a few fields so our click/menu handlers can access them
		icon.spawnname = obj.spawnname
		icon.nicename  = obj.nicename
		icon.admin     = obj.admin

		-- show the name under the SpawnIcon (ContentIcon normally shows the name)
		local lbl = vgui.Create("DLabel", icon)
		lbl:Dock(BOTTOM)
		lbl:DockMargin(0, 2, 0, 0)
		lbl:SetText(obj.nicename)
		lbl:SetFont("DermaDefaultBold")
        lbl:SetTextColor(Color(255, 255, 255))
		lbl:SetContentAlignment(5) -- center
		lbl:SizeToContentsY()

		-- left click: spawn entity
		function icon:DoClick()
			RunConsoleCommand("gm_spawnsent", self.spawnname)
			surface.PlaySound("ui/buttonclickrelease.wav")
		end

		-- right click: simple menu that mirrors the old "spawn with toolgun" option
		function icon:DoRightClick()
			local menu = DermaMenu()
			menu:AddOption("#spawnmenu.menu.spawn_with_toolgun", function()
				RunConsoleCommand("gmod_tool", "creator")
				RunConsoleCommand("creator_type", "0")
				RunConsoleCommand("creator_name", self.spawnname)
			end):SetIcon("icon16/brick_add.png")
			menu:Open()
		end

	else
		-- fallback: original ContentIcon behavior (uses material)
		icon = vgui.Create("ContentIcon", container)
		icon:SetContentType("entity")
		icon:SetSpawnName(obj.spawnname)
		icon:SetName(obj.nicename)
		icon:SetMaterial(obj.material)
		icon:SetAdminOnly(obj.admin)
		icon:SetColor(Color(205, 92, 92, 255))

		-- keep the old OpenMenuExtra if ContentIcon expects it
		icon.OpenMenu = icon.OpenGenericSpawnmenuRightClickMenu
	end

	-- shared tooltip + extra info
	local toolTip = language.GetPhrase(obj.nicename)
	local ENTinfo = scripted_ents.Get(obj.spawnname)
	if (not ENTinfo) then ENTinfo = list.Get("SpawnableEntities")[ obj.spawnname ] end
	if (ENTinfo) then
		local extraInfo = ""
		if (ENTinfo.Information and ENTinfo.Information ~= "") then extraInfo = extraInfo .. "\n" .. ENTinfo.Information end
		if (ENTinfo.Author and ENTinfo.Author ~= "") then extraInfo = extraInfo .. "\n" .. language.GetPhrase("entityinfo.author") .. " " .. ENTinfo.Author end
		if (#extraInfo > 0) then toolTip = toolTip .. "\n" .. extraInfo end
	end

	-- set tooltip (call whichever exists)
	if icon.SetTooltip then
		icon:SetTooltip(toolTip)
	elseif icon.SetToolTip then
		icon:SetToolTip(toolTip)
	end

	-- ensure ContentIcon-like extra menu exists for the SpawnIcon case too
	if (not icon.OpenMenuExtra) then
		function icon:OpenMenuExtra(menu)
			menu:AddOption("#spawnmenu.menu.spawn_with_toolgun", function()
				RunConsoleCommand("gmod_tool", "creator")
				RunConsoleCommand("creator_type", "0")
				RunConsoleCommand("creator_name", obj.spawnname)
			end):SetIcon("icon16/brick_add.png")
		end
	end

	-- Add to container
	if (IsValid(container)) then
		container:Add(icon)
	end

	return icon
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

        local model = nil
        local skin = nil
        if wepdata and wepdata.WorldModel and wepdata.Category != "Maya's TFA Pack" then
            model = wepdata.WorldModel
        end
        if wepdata and wepdata.ForceSkin then
            skin = wepdata.ForceSkin
        end
        if data.mdl then
            model = data.mdl
        end

        if string.find(name, str, 1, true) or string.find(class, str, 1, true) then
            local entry = {
                text = name,
                icon = spawnmenu.CreateContentIcon("breachitem", g_SpawnMenu.SearchPropPanel, {
                    nicename = showname,
                    spawnname = class,
                    material = "entities/" .. class .. ".png",
                    model = model,
                    skin = skin,
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
            local icon = spawnmenu.CreateContentIcon("breachitem", g_SpawnMenu.SearchPropPanel, {
                nicename = "Cup of " .. showname,
                spawnname = showname,
                model = "models/mishka/models/plastic_cup.mdl",
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

