
registerHandsAction("use_914_1", {
    name = "Change SCP-914",
    desc = "Change SCP-914's status",
    background_color = Color(150,150,50),

    canDo = function(self)
        return select(1, BR_Check914())
    end,

    sv_effect = function(self, ply)
        if !br2_914_on_map or !ply:Alive() or ply:IsSpectator() then return end
        
        local tr_hull = util.TraceHull({
            start = ply:GetShootPos(),
            endpos = ply:GetShootPos() + (ply:GetAimVector() * 100),
            filter = ply,
            mins = Vector(-2, -2, -2), maxs = Vector(2, 2, 2),
            mask = MASK_SHOT_HULL
        })

        if IsValid(tr_hull.Entity) then
            local ent = tr_hull.Entity

            if ent:GetClass() == "func_button" and ent:GetPos():Distance(BR2_Get_914_1_Pos()) < 4 then
                ent:Use(ply, ply, USE_ON, 1)
            end
        end
    end,

    cl_after = function(self)
        WeaponFrame:Remove()
    end,

    sort = 12
})

registerHandsAction("use_914_2", {
    name = "Start SCP-914",
    desc = "Start the machine",
    background_color = Color(50,150,50),

    canDo = function(self)
        return select(2, BR_Check914())
    end,

    sv_effect = function(self, ply)
        if ply:Alive() == false or ply:IsSpectator() then return end
        if !(br2_914_on_map == true and BR2_Get914Status() != 0) then return end

        local tr_hull = util.TraceHull({
            start = ply:GetShootPos(),
            endpos = ply:GetShootPos() + (ply:GetAimVector() * 100),
            filter = ply,
            mins = Vector(-2, -2, -2), maxs = Vector(2, 2, 2),
            mask = MASK_SHOT_HULL
        })

        if IsValid(tr_hull.Entity) then
            local ent = tr_hull.Entity
            if ent:GetClass() == "func_button" and ent:GetPos():Distance(BR2_Get_914_2_Pos()) < 10 then
                ent:Use(ply, ply, USE_ON, 1)
                BR2_Handle914_Start()
            end
        end
    end,

    cl_after = function(self)
        WeaponFrame:Remove()
    end,

    sort = 13
})
