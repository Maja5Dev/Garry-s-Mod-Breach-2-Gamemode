
registerHandsAction("check_body_notepad", {
    name = "Check the body's Notepad",
    desc = "Check the notepad found in this body",
    background_color = BR2_Hands_Actions_Colors.ragdoll_actions,

    can_do = function(self)
        local tr_ent = self.Owner:GetAllEyeTrace().Entity

        return IsValid(tr_ent)
        and tr_ent:GetPos():Distance(self.Owner:GetPos()) < 150
        and tr_ent:GetClass() == "prop_ragdoll"
    end,

    cl_effect = function(self)
        net.Start("br_get_body_notepad")
        net.SendToServer()
    end,

    cl_after = function(self)
        WeaponFrame:Remove()
    end
})
