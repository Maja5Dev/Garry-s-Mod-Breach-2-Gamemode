
registerHandsAction("box_173", {
    name = "Box 173",
    desc = "Put a box on the SCP-173",

    canDo = function(self)
        if !(self.Owner.br_role == ROLE_MTF_OPERATIVE or self.Owner.br_team == TEAM_MTF) then
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

        return IsValid(ent) and ent:GetClass() == "npc_cpt_scp_173"
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

        if IsValid(ent) and ent:GetClass() == "npc_cpt_scp_173" and !IsValid(ent.Box) then
            ent:ContainSCP(ply)
        end
    end,

    cl_after = function(self)
        WeaponFrame:Remove()
    end,

    sort = 14
})