
local function box173Player(ent, ntf)
    local replacement_scp = ents.Create("npc_cpt_scp_173")
    replacement_scp:SetPos(ent:GetPos())
    replacement_scp:SetAngles(ent:GetAngles())
    replacement_scp:Spawn()

    ent:KillSilent()

    replacement_scp:ContainSCP(ntf)
end

registerHandsAction("box_173", {
    name = "Box 173",
    desc = "Put a box on the SCP-173",
	background_color = BR2_Hands_Actions_Colors.ent_important_actions,

    can_do = function(self)
        if !self.Owner.canContain173 then
            return
        end

		local tr_hull = util.TraceHull({
			start = self.Owner:GetShootPos(),
			endpos = self.Owner:GetShootPos() + (self.Owner:GetAimVector() * 100),
			filter = self.Owner,
			mins = Vector(-2, -2, -2),
            maxs = Vector(2, 2, 2),
			mask = MASK_SHOT_HULL
		})

        local ent = tr_hull.Entity

        return IsValid(ent) and !IsValid(ent.Box) and
        (
            ent:GetClass() == "npc_cpt_scp_173"
            or ent:GetClass() == "breach_173ent"
            or (ent:IsPlayer() and ent:GetModel() == SCP_173_MODEL)
        )
    end,

    sv_effect = function(self, ply)
        if ply:Alive() == false or ply:IsSpectator() or !ply.canContain173 then return end

        local tr_hull = util.TraceHull({
            start = ply:GetShootPos(),
            endpos = ply:GetShootPos() + (ply:GetAimVector() * 100),
            filter = ply,
            mins = Vector(-2, -2, -2), maxs = Vector(2, 2, 2),
            mask = MASK_SHOT_HULL
        })
        
        local ent = tr_hull.Entity

        if ent:GetClass() == "breach_173ent" then
            ent = ent.Owner
        end

        if IsValid(ent) and !IsValid(ent.Box) then
            if ent:GetClass() == "npc_cpt_scp_173" then
                ent:ContainSCP(ply)

            elseif ent:IsPlayer() and ent.br_role == ROLE_SCP_173 then
                box173Player(ent, ply)
            end
        end
    end,

    cl_after = function(self)
        WeaponFrame:Remove()
    end
})