
local function break_window(ply, pos, sound)
    ply.nextWindowBreak = ply.nextWindowBreak or 0

    if ply.nextWindowBreak > CurTime() then return end

    for k,ent in pairs(ents.GetAll()) do
        if ent:GetPos():Distance(pos) < 5 and (ent:GetModel() == "models/novux/sitegard/prop/br_kpp_window.mdl" or ent:GetClass() == "func_breakable") then
            ent:TakeDamage(10, ply, ply)
            if ent:Health() > 0 then
                EmitSound(sound, pos, 75, 100, 0.9)
            end
            ply.nextWindowBreak = CurTime() + 0.5
            return
        end
    end
end

local function can_open_window(ply, pos)
    if ply.br_team != TEAM_SCP then return false end

    for k,ent in pairs(ents.GetAll()) do
        if ent:GetPos():Distance(pos) < 5 and (ent:GetModel() == "models/novux/sitegard/prop/br_kpp_window.mdl" or ent:GetClass() == "func_breakable") then
            return true
        end
    end

    return false
end

MAPCONFIG.SCP_ACTIONS = {
    -- LCZ
    {
        name = "scp_173_teleport_lcz_to_hcz_1",
        tooltip = "Teleport to HCZ",
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
        tooltip = "Teleport to HCZ",
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
        name = "scp_lcz_break_window_1_left_front",
        tooltip = "Break",
        pos = Vector(-880,491,-8125),
        mat = br_default_map_teleport,
        can_do = function(ply) return can_open_window(ply, Vector(-880, 504, -8160)) end,
        sv_acton = function(ply) break_window(ply, Vector(-880, 504, -8160), "Breakable.MatMetal") end
    },
    {
        name = "scp_lcz_break_window_1_left_back",
        tooltip = "Break",
        pos = Vector(-880,514,-8125),
        mat = br_default_map_teleport,
        can_do = function(ply) return can_open_window(ply, Vector(-880, 504, -8160)) end,
        sv_acton = function(ply) break_window(ply, Vector(-880, 504, -8160), "Breakable.MatMetal") end
    },
    {
        name = "scp_lcz_break_window_1_right_front",
        tooltip = "Break",
        pos = Vector(-493,496,-8126),
        mat = br_default_map_teleport,
        can_do = function(ply) return can_open_window(ply, Vector(-496, 504, -8160)) end,
        sv_acton = function(ply) break_window(ply, Vector(-496, 504, -8160), "Breakable.MatMetal") end
    },
    {
        name = "scp_lcz_break_window_1_right_back",
        tooltip = "Break",
        pos = Vector(-498,512,-8126),
        mat = br_default_map_teleport,
        can_do = function(ply) return can_open_window(ply, Vector(-496, 504, -8160)) end,
        sv_acton = function(ply) break_window(ply, Vector(-496, 504, -8160), "Breakable.MatMetal") end
    },


    {
        name = "scp_lcz_break_window_2_left_front",
        tooltip = "Break",
        pos = Vector(1917,1280,-8125),
        mat = br_default_map_teleport,
        can_do = function(ply) return can_open_window(ply, Vector(1928, 1280, -8160)) end,
        sv_acton = function(ply) break_window(ply, Vector(1928, 1280, -8160), "Breakable.MatMetal") end
    },
    {
        name = "scp_lcz_break_window_2_left_front",
        tooltip = "Break",
        pos = Vector(1938,1280,-8124),
        mat = br_default_map_teleport,
        can_do = function(ply) return can_open_window(ply, Vector(1928, 1280, -8160)) end,
        sv_acton = function(ply) break_window(ply, Vector(1928, 1280, -8160), "Breakable.MatMetal") end
    },
    {
        name = "scp_lcz_break_window_2_right_front",
        tooltip = "Break",
        pos = Vector(1916,896,-8125),
        mat = br_default_map_teleport,
        can_do = function(ply) return can_open_window(ply, Vector(1928, 896, -8160)) end,
        sv_acton = function(ply) break_window(ply, Vector(1928, 896, -8160), "Breakable.MatMetal") end
    },
    {
        name = "scp_lcz_break_window_2_right_back",
        tooltip = "Break",
        pos = Vector(1939,896,-8125),
        mat = br_default_map_teleport,
        can_do = function(ply) return can_open_window(ply, Vector(1928, 896, -8160)) end,
        sv_acton = function(ply) break_window(ply, Vector(1928, 896, -8160), "Breakable.MatMetal") end
    },


    -- HCZ
    {
        name = "scp_hcz_break_window_1_right_front",
        tooltip = "Break",
        pos = Vector(-496,493,-7101),
        mat = br_default_map_teleport,
        can_do = function(ply) return can_open_window(ply, Vector(-496, 504, -7136)) end,
        sv_acton = function(ply) break_window(ply, Vector(-496, 504, -7136), "Breakable.MatMetal") end
    },
    {
        name = "scp_hcz_break_window_1_right_back",
        tooltip = "Break",
        pos = Vector(-496,515,-7101),
        mat = br_default_map_teleport,
        can_do = function(ply) return can_open_window(ply, Vector(-496, 504, -7136)) end,
        sv_acton = function(ply) break_window(ply, Vector(-496, 504, -7136), "Breakable.MatMetal") end
    },
    {
        name = "scp_hcz_break_window_1_left_front",
        tooltip = "Break",
        pos = Vector(-880,493,-7102),
        mat = br_default_map_teleport,
        can_do = function(ply) return can_open_window(ply, Vector(-880, 504, -7136)) end,
        sv_acton = function(ply) break_window(ply, Vector(-880, 504, -7136), "Breakable.MatMetal") end
    },
    {
        name = "scp_hcz_break_window_1_left_back",
        tooltip = "Break",
        pos = Vector(-880,514,-7102),
        mat = br_default_map_teleport,
        can_do = function(ply) return can_open_window(ply, Vector(-880, 504, -7136)) end,
        sv_acton = function(ply) break_window(ply, Vector(-880, 504, -7136), "Breakable.MatMetal") end
    },

    {
        name = "scp_hcz_break_window_2_left_front",
        tooltip = "Break",
        pos = Vector(1918,1280,-7101),
        mat = br_default_map_teleport,
        can_do = function(ply) return can_open_window(ply, Vector(1928, 1280, -7136)) end,
        sv_acton = function(ply) break_window(ply, Vector(1928, 1280, -7136), "Breakable.MatMetal") end
    },
    {
        name = "scp_hcz_break_window_2_left_back",
        tooltip = "Break",
        pos = Vector(1939,1280,-7101),
        mat = br_default_map_teleport,
        can_do = function(ply) return can_open_window(ply, Vector(1928, 1280, -7136)) end,
        sv_acton = function(ply) break_window(ply, Vector(1928, 1280, -7136), "Breakable.MatMetal") end
    },
    {
        name = "scp_hcz_break_window_2_right_front",
        tooltip = "Break",
        pos = Vector(1917,896,-7100),
        mat = br_default_map_teleport,
        can_do = function(ply) return can_open_window(ply, Vector(1928, 896, -7136)) end,
        sv_acton = function(ply) break_window(ply, Vector(1928, 896, -7136), "Breakable.MatMetal") end
    },
    {
        name = "scp_hcz_break_window_2_right_back",
        tooltip = "Break",
        pos = Vector(1938,896,-7100),
        mat = br_default_map_teleport,
        can_do = function(ply) return can_open_window(ply, Vector(1928, 896, -7136)) end,
        sv_acton = function(ply) break_window(ply, Vector(1928, 896, -7136), "Breakable.MatMetal") end
    },


    {
        name = "scp_173_teleport_hcz_to_lcz_1",
        tooltip = "Teleport to LCZ",
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
        tooltip = "Teleport to LCZ",
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


    --EZ
    {
        name = "scp_hcz_break_window_1_left_front",
        tooltip = "Break",
        pos = Vector(990,3540,-7096),
        mat = br_default_map_teleport,
        can_do = function(ply) return can_open_window(ply, Vector(992, 3543, -7093.990234)) end,
        sv_acton = function(ply) break_window(ply, Vector(992, 3543, -7093.990234), "Breakable.Glass") end
    },
    {
        name = "scp_hcz_break_window_1_left_back",
        tooltip = "Break",
        pos = Vector(990,3547,-7096),
        mat = br_default_map_teleport,
        can_do = function(ply) return can_open_window(ply, Vector(992, 3543, -7093.990234)) end,
        sv_acton = function(ply) break_window(ply, Vector(992, 3543, -7093.990234), "Breakable.Glass") end
    },

    {
        name = "scp_ez_break_window_1_right_front",
        tooltip = "Break",
        pos = Vector(1407,3539,-7096),
        mat = br_default_map_teleport,
        can_do = function(ply) return can_open_window(ply, Vector(1408, 3543, -7093.990234)) end,
        sv_acton = function(ply) break_window(ply, Vector(1408, 3543, -7093.990234), "Breakable.Glass") end
    },
    {
        name = "scp_ez_break_window_1_right_back",
        tooltip = "Break",
        pos = Vector(1407,3546,-7096),
        mat = br_default_map_teleport,
        can_do = function(ply) return can_open_window(ply, Vector(1928, 896, -7136)) end,
        sv_acton = function(ply) break_window(ply, Vector(1928, 896, -7136), "Breakable.Glass") end
    },

    {
        name = "scp_ez_break_window_2_left_front",
        tooltip = "Break",
        pos = Vector(636,5610,-7095),
        mat = br_default_map_teleport,
        can_do = function(ply) return can_open_window(ply, Vector(639, 5608, -7093.990234)) end,
        sv_acton = function(ply) break_window(ply, Vector(639, 5608, -7093.990234), "Breakable.Glass") end
    },
    {
        name = "scp_ez_break_window_2_left_back",
        tooltip = "Break",
        pos = Vector(642,5610,-7095),
        mat = br_default_map_teleport,
        can_do = function(ply) return can_open_window(ply, Vector(639, 5608, -7093.990234)) end,
        sv_acton = function(ply) break_window(ply, Vector(639, 5608, -7093.990234), "Breakable.Glass") end
    },

    {
        name = "scp_ez_break_window_2_right_front",
        tooltip = "Break",
        pos = Vector(636,5193,-7096),
        mat = br_default_map_teleport,
        can_do = function(ply) return can_open_window(ply, Vector(639, 5192, -7093.990234)) end,
        sv_acton = function(ply) break_window(ply, Vector(639, 5192, -7093.990234), "Breakable.Glass") end
    },
    {
        name = "scp_ez_break_window_2_right_back",
        tooltip = "Break",
        pos = Vector(643,5193,-7096),
        mat = br_default_map_teleport,
        can_do = function(ply) return can_open_window(ply, Vector(639, 5192, -7093.990234)) end,
        sv_acton = function(ply) break_window(ply, Vector(639, 5192, -7093.990234), "Breakable.Glass") end
    },

}

-- lua_run MAPCONFIG.SCP_ACTIONS[1].sv_acton(Entity(1))