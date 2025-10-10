
registerHandsAction("special_items_menu", {
    name = "Open Backpack",
    desc = "Check your backpack, drop or use items",
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
