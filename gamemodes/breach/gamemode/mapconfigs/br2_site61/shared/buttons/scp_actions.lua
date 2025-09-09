
MAPCONFIG.SCP_ACTIONS = {
    {
        name = "scp_173_teleport_lcz_to_hcz_1",
        pos = Vector(1873, 1324, -8128),
        mat = br_default_map_teleport,
        can_do = function(ply)
            return ply.br_role == "SCP-173"
        end,
        sv_acton = function(ply)
            local ent173 = ply:GetNWEntity("entity173")
            ply:SetPos(Vector(1871, 1277, -7163))
            ply:SetEyeAngles(Angle(2, -126, 0))

            if IsValid(ent173) then
                ent173:SetAngles(Angle(2, -126, 0))
            end
        end
    },
    {
        name = "scp_173_teleport_lcz_to_hcz_2",
        pos = Vector(-927, 448, -8126),
        mat = br_default_map_teleport,
        can_do = function(ply)
            return ply.br_role == "SCP-173"
        end,
        sv_acton = function(ply)
            local ent173 = ply:GetNWEntity("entity173")
            ply:SetPos(Vector(-485, 180, -7163))
            ply:SetEyeAngles(Angle(10, 137, 0))

            if IsValid(ent173) then
                ent173:SetAngles(Angle(10, 137, 0))
            end
        end
    },


    {
        name = "scp_173_teleport_hcz_to_lcz_1",
        pos = Vector(1873,1326,-7105),
        mat = br_default_map_teleport,
        can_do = function(ply)
            return ply.br_role == "SCP-173"
        end,
        sv_acton = function(ply)
            local ent173 = ply:GetNWEntity("entity173")
            ply:SetPos(Vector(1868, 1296, -8187))
            ply:SetEyeAngles(Angle(10, -121, 0))

            if IsValid(ent173) then
                ent173:SetAngles(Angle(10, -121, 0))
            end
        end
    },
    {
        name = "scp_173_teleport_hcz_to_lcz_2",
        pos = Vector(-490,137,-7108),
        mat = br_default_map_teleport,
        can_do = function(ply)
            return ply.br_role == "SCP-173"
        end,
        sv_acton = function(ply)
            local ent173 = ply:GetNWEntity("entity173")
            ply:SetPos(Vector(-896, 442, -8187))
            ply:SetEyeAngles(Angle(10, -27, 0))

            if IsValid(ent173) then
                ent173:SetAngles(Angle(10, -27, 0))
            end
        end
    },

}

-- lua_run MAPCONFIG.SCP_ACTIONS[1].sv_acton(Entity(1))