
BR2_HandsActions = {}

function registerHandsAction(name, tab)
    tab.className = name
    BR2_HandsActions[name] = tab
end

function addTemporaryHandsAction(target_tab, name, tab)
    tab.className = name
    tab.temporary = true
    target_tab[name] = tab
end

function BR2_GetHandActions()
    return BR2_HandsActions
end

BR2_Hands_Actions_Colors = {
    self_actions = Color(125, 125, 125),

    someone_actions = Color(150, 0, 150),
    ragdoll_actions = Color(125, 225, 50),
    pickup_actions = Color(0, 150, 150),
    ent_important_actions = Color(225, 130, 50),

    default = Color(100, 100, 100),
}

BR2_Hands_Sort = {
    -- self important actions
    examine_yourself = 1,
    special_items_menu = 2,

    -- other player actions
    examine_someone = 20,
    identify_player = 21,
    check_someones_notepad = 22,

    -- body
    loot_body = 40,
    check_body_notepad = 41,
    steal_outfit = 42,
    change_host_scp035 = 43,

    -- entities
    box_173 = 60,
    put_on_scp35 = 61,
    use_914_1 = 62,
    use_914_2 = 63,

    -- less important item pickups
    pickup_bomb = 100,
    /*
    101-110 reserved for picking up items
    */
}

include("actions/ent_box_173.lua")
include("actions/ent_pickup_bomb.lua")
include("actions/ent_pickup_items.lua")
include("actions/ent_put_on_scp035.lua")
include("actions/ent_scp914_controls.lua")
include("actions/ragdoll_change_host_scp035.lua")
include("actions/ragdoll_check_notepad.lua")
include("actions/ragdoll_loot.lua")
include("actions/ragdoll_steal_outfit.lua")
include("actions/someone_check_notepad.lua")
include("actions/someone_examine.lua")
include("actions/someone_identify.lua")
include("actions/yourself_backpack.lua")
include("actions/yourself_examine.lua")
