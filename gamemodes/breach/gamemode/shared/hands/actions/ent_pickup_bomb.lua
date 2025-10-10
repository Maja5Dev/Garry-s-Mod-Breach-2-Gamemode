
registerHandsAction("pickup_bomb", {
    name = "Pickup the bomb",
    desc = "Pickup the bomb in front of you",
	background_color = BR2_Hands_Actions_Colors.pickup_actions,

    can_do = function(self)
        local tr_ent = self.Owner:GetAllEyeTrace().Entity

        return IsValid(tr_ent)
        and tr_ent:GetPos():Distance(self.Owner:GetPos()) < 150
        and tr_ent:GetClass() == "br2_c4_charge"
    end,

    cl_effect = function(self)
        chat.AddText(Color(255,0,0,255), "(C4) Trying to pick up the bomb...")
    end,

    sv_effect = function(self, ply)
        local tr_ent = ply:GetAllEyeTrace().Entity

        if IsValid(tr_ent) and tr_ent:GetClass() == "br2_c4_charge" and tr_ent:GetPos():Distance(ply:GetPos()) < 150 then
            local bomb = ply:Give("item_c4")
            bomb.isArmed = tr_ent.isArmed
            bomb.Activated = tr_ent.Activated
            bomb.Timer = tr_ent.Timer

            if tr_ent.nextExplode then
                bomb.nextExplode = tr_ent.nextExplode
            end

            tr_ent:Remove()
        end
    end,

    cl_after = function(self)
        WeaponFrame:Remove()
    end
})
