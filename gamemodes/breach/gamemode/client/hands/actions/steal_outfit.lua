
registerHandsAction("steal_outfit", {
    name = "Steal their outfit",
    desc = "Wear the outfit found in this body",

    canDo = function(self)
        local tr_ent = self.Owner:GetAllEyeTrace().Entity

        return IsValid(tr_ent)
        and tr_ent:GetPos():Distance(self.Owner:GetPos()) < 150
        and tr_ent:GetClass() == "prop_ragdoll"
    end,

    cl_effect = function(self)
        net.Start("br_steal_body_outfit")
        net.SendToServer()
    end,

    cl_after = function(self)
        WeaponFrame:Remove()
    end,

    sort = 10,
})
