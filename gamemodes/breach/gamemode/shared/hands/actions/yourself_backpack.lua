
registerHandsAction("special_items_menu", {
    name = "Open your backpack",
    desc = "Check, use or drop the items you are carrying",
		background_color = Color(150,75,50),

    can_do = true,

    cl_effect = function(self)
        net.Start("br_get_special_items")
        net.SendToServer()
    end,

    cl_after = function(self)
        WeaponFrame:Remove()
    end
})
