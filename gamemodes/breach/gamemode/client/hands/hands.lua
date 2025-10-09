
local BR2_HandsActions = {}

function registerHandsAction(name, tab)
    BR2_HandsActions[name] = tab
end

function addTemporaryHandsAction(name, tab)
    tab.temporary = true
    BR2_HandsActions[name] = tab
end

function BR2_GetHandActions()
    return BR2_HandsActions
end

include("actions/check_body_notepad.lua")
include("actions/check_someones_notepad.lua")
include("actions/examine_someone.lua")
include("actions/examine_yourself.lua")
include("actions/identify_someone.lua")
include("actions/loot_body.lua")
include("actions/pickup_bomb.lua")
include("actions/pickup_items.lua")
include("actions/put_on_scp_035.lua")
include("actions/put_scp173_into_box.lua")
include("actions/scp914.lua")
include("actions/special_items_menu.lua")
include("actions/steal_outfit.lua")
 