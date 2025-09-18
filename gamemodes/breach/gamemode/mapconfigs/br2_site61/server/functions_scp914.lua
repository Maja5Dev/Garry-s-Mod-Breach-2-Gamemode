
function BR2_Get914Status()
	local skip_ents = {}
	
	for k,v in pairs(ents.GetAll()) do
		if v:GetPos() == Vector(709.000000, -832.000000, -8131.000000) then
			table.ForceInsert(skip_ents, v)
		end
	end
	
	local pos_tab = {
		{
			st = Vector(711.968750, -823.241089, -8130.947754),
			en = Vector(711.968750, -826.715942, -8130.899902)
		},
		{
			st = Vector(711.968750, -825.751526, -8124.646484),
			en = Vector(711.968750, -828.398987, -8127.150391)
		},
		{
			st = Vector(711.968750, -832.023193, -8121.808105),
			en = Vector(711.968750, -831.989441, -8125.920898)
		},
		{
			st = Vector(711.968750, -838.231140, -8124.668457),
			en = Vector(711.968750, -835.565186, -8127.099121)
		},
		{
			st = Vector(711.968750, -840.952881, -8130.949707),
			en = Vector(711.968750, -837.019043, -8130.874512)
		},
	}
	
	for i,v in ipairs(pos_tab) do
		local tr = util.TraceLine({
			start = v.st,
			endpos = v.en,
			mask = CONTENTS_SOLID + CONTENTS_MOVEABLE + CONTENTS_OPAQUE,
			filter = skip_ents
		})
		if tr.Hit == true then
			return i
		end
	end
	return 0
end

function BR2_Get_914_Enter_Entities()
	local pos1 = Vector(737,-678,-8190)
	local pos2 = Vector(804,-541,-8080)

	OrderVectors(pos1, pos2)
	local ents_found = {}

	for k,v in pairs(ents.FindInBox(pos1, pos2)) do
		table.ForceInsert(ents_found, v)
	end

	return ents_found
end

function BR2_Get_914_Enter_Delay()
	return 4
end

local scp914_teleported_positions = {
	Vector(754.16162109375, -1099.8955078125, -8159.96875),
	Vector(780.07446289063, -1098.6678466797, -8159.96875),
	Vector(781.66186523438, -1009.5772705078, -8159.96875),
	Vector(754.11010742188, -1009.8746337891, -8159.96875),
	Vector(753.52972412109, -1050.2017822266, -8159.96875),
	Vector(777.84912109375, -1051.9821777344, -8159.96875)
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

