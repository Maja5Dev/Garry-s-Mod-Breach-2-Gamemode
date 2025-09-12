
local function break_window(ply, pos, sound, button_pos)
    ply.nextSCPBreak = ply.nextSCPBreak or 0
    if ply.nextSCPBreak > CurTime() then return end

    for k,ent in pairs(ents.GetAll()) do
        if ent:GetPos():Distance(pos) < 10 and (ent:GetModel() == "models/novux/sitegard/prop/br_kpp_window.mdl" or ent:GetClass() == "func_breakable") then
            ent:TakeDamage(5, ply, ply)

            if ent:Health() > 0 then
                EmitSound(sound, button_pos, 120, 100, 0.8)
            end

            ply.nextSCPBreak = CurTime() + 0.5
            return
        end
    end
end

local function can_break_window(ply, pos)
    if ply.br_team != TEAM_SCP then return false end

    for k,ent in pairs(ents.GetAll()) do
        if ent:GetPos():Distance(pos) < 10 and (ent:GetModel() == "models/novux/sitegard/prop/br_kpp_window.mdl" or ent:GetClass() == "func_breakable") then
            return true
        end
    end

    return false
end

local function break_gate(ply, button_pos, sound)
    ply.nextSCPBreak = ply.nextSCPBreak or 0
    if ply.nextSCPBreak > CurTime() then return end

    local once = false

    for k,ent in pairs(ents.GetAll()) do
        if ent:GetPos():Distance(button_pos) < 100 and ent:GetModel() == "models/foundation/containment/door01.mdl" then
            if ent.hasBeenSetup == nil then
                ent.hasBeenSetup = true
                ent:SetHealth(1000)
            end

            ent:SetHealth(math.Clamp(ent:Health() - 50, 0, 10000))

            if !once then
                if ent:Health() > 0 then
                    EmitSound(sound, button_pos, 120, 100, 0.8)
                else
                    local effect = EffectData()
                    effect:SetStart(ent:GetPos())
                    effect:SetOrigin(ent:GetPos())
                    effect:SetScale(200)
                    effect:SetRadius(200)
                    effect:SetMagnitude(1)
                    
                    util.Effect("Explosion", effect, true, true)
                    util.Effect("HelicopterMegaBomb", effect, true, true)

                    --remove func doors too
                    for k2,ent2 in pairs(ents.GetAll()) do
                        if ent2:GetPos():Distance(button_pos) < 100 and ent2:GetClass() == "func_door" then
                            ent2:Remove()
                        end
                    end
                end

                ply.nextSCPBreak = CurTime() + 0.5
                once = true
            end

            if ent:Health() < 1 then
                ent:Remove()
            end
        end
    end
end

local function can_break_gate(ply, pos)
    if ply.br_team != TEAM_SCP then return false end

    for k,ent in pairs(ents.GetAll()) do
        if ent:GetPos():Distance(pos) < 100 and ent:GetModel() == "models/foundation/containment/door01.mdl" then
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
        can_do = function(ply) return can_break_window(ply, Vector(-880, 504, -8160)) end,
        sv_acton = function(ply) break_window(ply, Vector(-880, 504, -8160), "Breakable.MatMetal", Vector(-880,500,-8125)) end
    },
    {
        name = "scp_lcz_break_window_1_left_back",
        tooltip = "Break",
        pos = Vector(-880,514,-8125),
        mat = br_default_map_teleport,
        can_do = function(ply) return can_break_window(ply, Vector(-880, 504, -8160)) end,
        sv_acton = function(ply) break_window(ply, Vector(-880, 504, -8160), "Breakable.MatMetal", Vector(-880,500,-8125)) end
    },
    {
        name = "scp_lcz_break_window_1_right_front",
        tooltip = "Break",
        pos = Vector(-493,496,-8126),
        mat = br_default_map_teleport,
        can_do = function(ply) return can_break_window(ply, Vector(-496, 504, -8160)) end,
        sv_acton = function(ply) break_window(ply, Vector(-496, 504, -8160), "Breakable.MatMetal", Vector(-493,500,-8126)) end
    },
    {
        name = "scp_lcz_break_window_1_right_back",
        tooltip = "Break",
        pos = Vector(-498,512,-8126),
        mat = br_default_map_teleport,
        can_do = function(ply) return can_break_window(ply, Vector(-496, 504, -8160)) end,
        sv_acton = function(ply) break_window(ply, Vector(-496, 504, -8160), "Breakable.MatMetal", Vector(-493,500,-8126)) end
    },


    {
        name = "scp_lcz_break_window_2_left_front",
        tooltip = "Break",
        pos = Vector(1917,1280,-8125),
        mat = br_default_map_teleport,
        can_do = function(ply) return can_break_window(ply, Vector(1928, 1280, -8160)) end,
        sv_acton = function(ply) break_window(ply, Vector(1928, 1280, -8160), "Breakable.MatMetal", Vector(1920,1280,-8125)) end
    },
    {
        name = "scp_lcz_break_window_2_left_front",
        tooltip = "Break",
        pos = Vector(1938,1280,-8124),
        mat = br_default_map_teleport,
        can_do = function(ply) return can_break_window(ply, Vector(1928, 1280, -8160)) end,
        sv_acton = function(ply) break_window(ply, Vector(1928, 1280, -8160), "Breakable.MatMetal", Vector(1920,1280,-8125)) end
    },
    {
        name = "scp_lcz_break_window_2_right_front",
        tooltip = "Break",
        pos = Vector(1916,896,-8125),
        mat = br_default_map_teleport,
        can_do = function(ply) return can_break_window(ply, Vector(1928, 896, -8160)) end,
        sv_acton = function(ply) break_window(ply, Vector(1928, 896, -8160), "Breakable.MatMetal", Vector(1920,896,-8125)) end
    },
    {
        name = "scp_lcz_break_window_2_right_back",
        tooltip = "Break",
        pos = Vector(1939,896,-8125),
        mat = br_default_map_teleport,
        can_do = function(ply) return can_break_window(ply, Vector(1928, 896, -8160)) end,
        sv_acton = function(ply) break_window(ply, Vector(1928, 896, -8160), "Breakable.MatMetal", Vector(1920,896,-8125)) end
    },


    -- HCZ
    {
        name = "scp_hcz_break_window_1_right_front",
        tooltip = "Break",
        pos = Vector(-496,493,-7101),
        mat = br_default_map_teleport,
        can_do = function(ply) return can_break_window(ply, Vector(-496, 504, -7136)) end,
        sv_acton = function(ply) break_window(ply, Vector(-496, 504, -7136), "Breakable.MatMetal", Vector(-496,493,-7101)) end
    },
    {
        name = "scp_hcz_break_window_1_right_back",
        tooltip = "Break",
        pos = Vector(-496,515,-7101),
        mat = br_default_map_teleport,
        can_do = function(ply) return can_break_window(ply, Vector(-496, 504, -7136)) end,
        sv_acton = function(ply) break_window(ply, Vector(-496, 504, -7136), "Breakable.MatMetal", Vector(-496,493,-7101)) end
    },
    {
        name = "scp_hcz_break_window_1_left_front",
        tooltip = "Break",
        pos = Vector(-880,493,-7102),
        mat = br_default_map_teleport,
        can_do = function(ply) return can_break_window(ply, Vector(-880, 504, -7136)) end,
        sv_acton = function(ply) break_window(ply, Vector(-880, 504, -7136), "Breakable.MatMetal", Vector(-880,493,-7102)) end
    },
    {
        name = "scp_hcz_break_window_1_left_back",
        tooltip = "Break",
        pos = Vector(-880,514,-7102),
        mat = br_default_map_teleport,
        can_do = function(ply) return can_break_window(ply, Vector(-880, 504, -7136)) end,
        sv_acton = function(ply) break_window(ply, Vector(-880, 504, -7136), "Breakable.MatMetal", Vector(-880,493,-7102)) end
    },

    {
        name = "scp_hcz_break_window_2_left_front",
        tooltip = "Break",
        pos = Vector(1918,1280,-7101),
        mat = br_default_map_teleport,
        can_do = function(ply) return can_break_window(ply, Vector(1928, 1280, -7136)) end,
        sv_acton = function(ply) break_window(ply, Vector(1928, 1280, -7136), "Breakable.MatMetal", Vector(1918,1280,-7101)) end
    },
    {
        name = "scp_hcz_break_window_2_left_back",
        tooltip = "Break",
        pos = Vector(1939,1280,-7101),
        mat = br_default_map_teleport,
        can_do = function(ply) return can_break_window(ply, Vector(1928, 1280, -7136)) end,
        sv_acton = function(ply) break_window(ply, Vector(1928, 1280, -7136), "Breakable.MatMetal", Vector(1918,1280,-7101)) end
    },
    {
        name = "scp_hcz_break_window_2_right_front",
        tooltip = "Break",
        pos = Vector(1917,896,-7100),
        mat = br_default_map_teleport,
        can_do = function(ply) return can_break_window(ply, Vector(1928, 896, -7136)) end,
        sv_acton = function(ply) break_window(ply, Vector(1928, 896, -7136), "Breakable.MatMetal", Vector(1917,896,-7100)) end
    },
    {
        name = "scp_hcz_break_window_2_right_back",
        tooltip = "Break",
        pos = Vector(1938,896,-7100),
        mat = br_default_map_teleport,
        can_do = function(ply) return can_break_window(ply, Vector(1928, 896, -7136)) end,
        sv_acton = function(ply) break_window(ply, Vector(1928, 896, -7136), "Breakable.MatMetal", Vector(1917,896,-7100)) end
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
        name = "scp_ez_break_window_1_left_front",
        tooltip = "Break",
        pos = Vector(990,3540,-7096),
        mat = br_default_map_teleport,
        can_do = function(ply) return can_break_window(ply, Vector(992, 3543, -7093.990234)) end,
        sv_acton = function(ply) break_window(ply, Vector(992, 3543, -7093.990234), "Breakable.Glass", Vector(990,3540,-7096)) end
    },
    {
        name = "scp_ez_break_window_1_left_back",
        tooltip = "Break",
        pos = Vector(990,3547,-7096),
        mat = br_default_map_teleport,
        can_do = function(ply) return can_break_window(ply, Vector(992, 3543, -7093.990234)) end,
        sv_acton = function(ply) break_window(ply, Vector(992, 3543, -7093.990234), "Breakable.Glass", Vector(990,3540,-7096)) end
    },

    {
        name = "scp_ez_break_window_1_right_front",
        tooltip = "Break",
        pos = Vector(1407,3539,-7096),
        mat = br_default_map_teleport,
        can_do = function(ply) return can_break_window(ply, Vector(1408, 3543, -7093.990234)) end,
        sv_acton = function(ply) break_window(ply, Vector(1408, 3543, -7093.990234), "Breakable.Glass", Vector(1407,3539,-7096)) end
    },
    {
        name = "scp_ez_break_window_1_right_back",
        tooltip = "Break",
        pos = Vector(1410,3549,-7096),
        mat = br_default_map_teleport,
        can_do = function(ply) return can_break_window(ply, Vector(1408, 3543, -7093.990234)) end,
        sv_acton = function(ply) break_window(ply, Vector(1408, 3543, -7093.990234), "Breakable.Glass", Vector(1407,3539,-7096)) end
    },

    {
        name = "scp_ez_break_window_2_left_front",
        tooltip = "Break",
        pos = Vector(636,5610,-7095),
        mat = br_default_map_teleport,
        can_do = function(ply) return can_break_window(ply, Vector(639, 5608, -7093.990234)) end,
        sv_acton = function(ply) break_window(ply, Vector(639, 5608, -7093.990234), "Breakable.Glass", Vector(636,5610,-7095)) end
    },
    {
        name = "scp_ez_break_window_2_left_back",
        tooltip = "Break",
        pos = Vector(642,5610,-7095),
        mat = br_default_map_teleport,
        can_do = function(ply) return can_break_window(ply, Vector(639, 5608, -7093.990234)) end,
        sv_acton = function(ply) break_window(ply, Vector(639, 5608, -7093.990234), "Breakable.Glass", Vector(636,5610,-7095)) end
    },

    {
        name = "scp_ez_break_window_2_right_front",
        tooltip = "Break",
        pos = Vector(636,5193,-7096),
        mat = br_default_map_teleport,
        can_do = function(ply) return can_break_window(ply, Vector(639, 5192, -7093.990234)) end,
        sv_acton = function(ply) break_window(ply, Vector(639, 5192, -7093.990234), "Breakable.Glass", Vector(636,5193,-7096)) end
    },
    {
        name = "scp_ez_break_window_2_right_back",
        tooltip = "Break",
        pos = Vector(643,5193,-7096),
        mat = br_default_map_teleport,
        can_do = function(ply) return can_break_window(ply, Vector(639, 5192, -7093.990234)) end,
        sv_acton = function(ply) break_window(ply, Vector(639, 5192, -7093.990234), "Breakable.Glass", Vector(636,5193,-7096)) end
    },

    {
        name = "scp_ez_break_gate_a_front",
        tooltip = "Break",
        pos = Vector(2546,7395,-7116),
        mat = br_default_map_teleport,
        can_do = function(ply) return can_break_gate(ply, Vector(2546,7395,-7116)) end,
        sv_acton = function(ply) break_gate(ply, Vector(2546,7395,-7116), "Breakable.MatMetal") end
    },
    {
        name = "scp_ez_break_gate_a_back",
        tooltip = "Break",
        pos = Vector(2546,7420,-7113),
        mat = br_default_map_teleport,
        can_do = function(ply) return can_break_gate(ply, Vector(2546,7420,-7113)) end,
        sv_acton = function(ply) break_gate(ply, Vector(2546,7420,-7113), "Breakable.MatMetal") end
    },


    {
        name = "scp_ez_break_gate_b_front",
        tooltip = "Break",
        pos = Vector(6423,5209,-7119),
        mat = br_default_map_teleport,
        can_do = function(ply) return can_break_gate(ply, Vector(6423,5209,-7119)) end,
        sv_acton = function(ply) break_gate(ply, Vector(6423,5209,-7119), "Breakable.MatMetal") end
    },
    {
        name = "scp_ez_break_gate_b_front",
        tooltip = "Break",
        pos = Vector(6447,5209,-7119),
        mat = br_default_map_teleport,
        can_do = function(ply) return can_break_gate(ply, Vector(6447,5209,-7119)) end,
        sv_acton = function(ply) break_gate(ply, Vector(6447,5209,-7119), "Breakable.MatMetal") end
    },
}

-- lua_run MAPCONFIG.SCP_ACTIONS[1].sv_acton(Entity(1))