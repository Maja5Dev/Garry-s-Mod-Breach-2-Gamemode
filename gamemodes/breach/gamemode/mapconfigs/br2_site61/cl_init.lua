
MAPCONFIG = {}

-- FOR DEBUG PURPOSES
include("server/item_spawns.lua")
include("server/positions.lua")
--

function BR_Check914()
	local tr_hull = util.TraceHull({
		start = LocalPlayer():GetShootPos(),
		endpos = LocalPlayer():GetShootPos() + (LocalPlayer():GetAimVector() * 100),
		filter = LocalPlayer(),
		mins = Vector(-2, -2, -2), maxs = Vector(2, 2, 2),
		mask = MASK_SHOT_HULL
	})

	if IsValid(tr_hull.Entity) then
		local ent = tr_hull.Entity
		print(ent)
		if ent:GetClass() == "class C_BaseToggle" then
			--print(ent, ent:GetPos())
			local ent_pos = ent:GetPos()
			--ent_pos = Vector(math.Round(ent_pos.x), math.Round(ent_pos.y), math.Round(ent_pos.z))

			local pos_914_1 = BR2_Get_914_1_Pos()
			pos_914_1 = Vector(math.Round(pos_914_1.x), math.Round(pos_914_1.y), math.Round(pos_914_1.z))

			local pos_914_2 = BR2_Get_914_2_Pos()
			pos_914_2 = Vector(math.Round(pos_914_2.x), math.Round(pos_914_2.y), math.Round(pos_914_2.z))
			
            local scp914_1_enabled = false
            local scp914_2_enabled = false

			if ent_pos:Distance(pos_914_1) < 2 then
				scp914_1_enabled = true
			elseif ent_pos:Distance(pos_914_2) < 2 then
				scp914_2_enabled = true
			end

            return scp914_1_enabled, scp914_2_enabled
		end
	end

    return false, false
end

print("[Breach2] Clientside mapconfig loaded!")
