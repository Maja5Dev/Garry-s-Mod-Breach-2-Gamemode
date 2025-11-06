
local function steal_body_outfit(self)
    local ply = self.Owner
    local ent = ply:GetAllEyeTrace().Entity

    if IsValid(ent) and ent:GetClass() == "prop_ragdoll" and ent:GetPos():Distance(ply:GetPos()) < 150 and istable(ent.Info) then
        local our_outfit = ply:GetOutfit()
        local outfit = ent:GetOutfit()

        if ply:GetModel() == ent:GetModel() or our_outfit.class == outfit.class then
            ply:PrintMessage(HUD_PRINTTALK, "You are already wearing this outfit.")
            return
        end

        if ply.cantChangeOutfit == true then
            ply:PrintMessage(HUD_PRINTTALK, "You cannot change your outfit.")
            return
        end

        if istable(outfit) and outfit.can_loot_this_outfit then
            BR2_ReplaceRagdollModel(ent, ply:GetModel(), ply:GetSkin(), ply)

            ply:ApplyOutfit(outfit.class)
            ply:EmitSound(Sound("npc/combine_soldier/zipline_clothing"..math.random(1,2)..".wav"))
            BR2_removeNearbyInfo(ply)

        else
            ply:PrintMessage(HUD_PRINTTALK, "You cannot loot this outfit.")
        end
    end
end

registerHandsAction("steal_outfit", {
    name = "Steal their outfit",
    desc = "Wear the outfit found in this body",
    background_color = BR2_Hands_Actions_Colors.ragdoll_actions,

    can_do = function(self)
        local tr_ent = self.Owner:GetAllEyeTrace().Entity

        return IsValid(tr_ent)
        and tr_ent:GetPos():Distance(self.Owner:GetPos()) < 150
        and tr_ent:GetClass() == "prop_ragdoll"
    end,

    sv_effect = function(self)
        steal_body_outfit(self)
    end,

    cl_after = function(self)
        WeaponFrame:Remove()
    end
})
