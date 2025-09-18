
local scp914_teleported_positions = {
	Vector(9679,-1101,-838),
	Vector(9679,-1074,-838),
	Vector(9679,-1048,-838),
	Vector(9679,-1029,-838)
}

local next_teleported_pos = 1

function BR2_Get_914_Exit_Position()
    local pos = scp914_teleported_positions[next_teleported_pos]

    next_teleported_pos = next_teleported_pos + 1
    if next_teleported_pos > #scp914_teleported_positions then
        next_teleported_pos = 1
    end

    return pos
end


function BR2_Get914Status()
	for k,v in pairs(ents.GetAll()) do
		if v:GetName() == "914_selecter_rot" then
			return math.Round(math.abs(v:GetAngles().roll) / 45) + 1
		end
	end
	return 1
end

function BR2_Get_914_Enter_Entities()
	local pos1 = Vector(9716,-1609,-961)
	local pos2 = Vector(9635,-1477,-824)
	OrderVectors(pos1, pos2)
	local ents_found = {}
	for k,v in pairs(ents.FindInBox(pos1, pos2)) do
		--if v.GetBetterOne or v:IsPlayer() then
		if v.GetBetterOne then
			table.ForceInsert(ents_found, v)
		end
	end
	return ents_found
end

function BR2_914_End_Stage()
	timer.Create("BR2_914_NextStage", 11, 1, function()
		br2_914_disabled = false
	end)
end

print("[Breach2] Server/Functions/SCP-914 mapconfig loaded!")