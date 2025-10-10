
registerHandsAction("loot_body", {
    name = "Loot the body",
    desc = "Search the body you are looking at",
    background_color = BR2_Hands_Actions_Colors.ragdoll_actions,

    can_do = function(self)
        local tr_ent = self.Owner:GetAllEyeTrace().Entity

        return IsValid(tr_ent)
        and tr_ent:GetPos():Distance(self.Owner:GetPos()) < 150
        and tr_ent:GetClass() == "prop_ragdoll"
    end,

    cl_effect = function(self)
        net.Start("br_get_loot_info")
        net.SendToServer()
    end,

    cl_after = function(self)
        WeaponFrame:Remove()
    end
})
