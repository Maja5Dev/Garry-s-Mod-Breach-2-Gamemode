
function BR_DEFAULT_MAP_Organize_Keypad_Find()
	local button_ents = {}

	local allowed_button_classes = {
		"func_button"
	}

	if istable(MAPCONFIG.KEYPADS) then
		local mapconfig_keypads = table.Copy(MAPCONFIG.KEYPADS)

		for _,ent in pairs(ents.GetAll()) do
			for i,butt in ipairs(mapconfig_keypads) do
				local ent_class = ent:GetClass()
				local ent_pos = ent:GetPos()
				local should_break = false

				if table.HasValue(allowed_button_classes, ent_class) then
					local real_butt = FindKeyPadByName(butt.name)

					if (isvector(butt.pos) and ((ent_pos == butt.pos) or (ent_pos:Distance(butt.pos) < 3)))
					or (isstring(butt.ent_name) and butt.ent_name == ent:GetName()) then
						ent.br_info = MAPCONFIG.KEYPADS[real_butt]
						table.ForceInsert(button_ents, ent)
						MAPCONFIG.KEYPADS[real_butt].ent = ent
						table.RemoveByValue(mapconfig_keypads, butt)
						break

					elseif istable(butt.pos) then
						for k,v in pairs(butt.pos) do
							if ((ent_pos == v) or (ent_pos:Distance(v) < 3)) then
								ent.br_info = MAPCONFIG.KEYPADS[real_butt]
								table.ForceInsert(button_ents, ent)
								MAPCONFIG.KEYPADS[real_butt].ent = ent
								table.RemoveByValue(butt.pos, v)

								if table.Count(butt.pos) == 0 then
									table.RemoveByValue(mapconfig_keypads, butt)
								end

								should_break = true
								break
							end
						end
					end
				end

				if should_break then
					break
				end
			end
		end

		if table.Count(mapconfig_keypads) > 0 then
			ErrorNoHaltWithStack("BUTTONS NOT FOUND:")
			for k,v in pairs(mapconfig_keypads) do
				print(v.name)
			end
		else
			devprint("All buttons found!")
		end
	else
		ErrorNoHaltWithStack("[Breach2] No buttons found...")
	end

	return button_ents
end

local allowed_button_classes = {
	"func_button"
}

function BR_DEFAULT_MAP_Organize_Keypads()
	if istable(MAPCONFIG.BUTTONS) then
		for i,butt in ipairs(MAPCONFIG.BUTTONS) do
			local button_found = false
			for k,v in pairs(ents.GetAll()) do
				if ((isstring(butt.ent_name) and butt.ent_name == v:GetName()) or
					(v:GetPos() == butt.pos) or
					(v:GetPos():Distance(butt.pos) < 3)) and table.HasValue(allowed_button_classes, v:GetClass())
				then
					if butt.ent_name then
						devprint("Found a button with name (" .. butt.ent_name .. ")")
					end
					--print("Found a button with pos (" .. tostring(butt.pos) .. ")  and level " .. butt.level)
					v.br_info = butt
					table.ForceInsert(button_ents, v)
					butt.ent = v
					button_found = true
					continue
				end
			end

			if button_found == false then
				ErrorNoHaltWithStack("Button not found", i, butt.pos)
			end
		end
	else
		ErrorNoHaltWithStack("[Breach2] No code keypads found...")
		return
	end
end

function BR_DEFAULT_MAP_Organize_KeypadCodes()
	local button_ents = BR_DEFAULT_MAP_Organize_Keypad_Find()

	-- BUTTON CODES
	local numww = 0
	local code_pairs = {}
	local code_ents = {}

	for k,v in pairs(button_ents) do
		if isnumber(v.br_info.code) then
			table.ForceInsert(code_ents, v)
		end
	end

	for k,v in pairs(code_ents) do
		if v._cpfd then continue end

		local tab_of_pairs = {v}
		for k2,v2 in pairs(code_ents) do
			if v != v2 and v.br_info.name == v2.br_info.name then
				table.ForceInsert(tab_of_pairs, v2)
				v2._cpfd = true
			end
		end
		if table.Count(tab_of_pairs) > 1 then
			table.ForceInsert(code_pairs, tab_of_pairs)
		end
	end

	for k,v in pairs(code_pairs) do
		for k2,v2 in pairs(v) do
			table.RemoveByValue(code_ents, v2)
		end
		table.ForceInsert(code_ents, v)
	end

	for k,v in pairs(code_ents) do
		local newcode = (math.random(1,9) * 1000) + (math.random(1,9) * 100) + (math.random(1,9) * 10) + math.random(1,9)
		local stack = {}
		if istable(v) then
			for k2,v2 in pairs(v) do
				table.ForceInsert(stack, v2)
			end
		else
			table.ForceInsert(stack, v)
		end

		local rnd_name = ""

		for k2,v2 in pairs(stack) do
			v2.br_info.code = newcode
			v2.br_info.code_type = "radio"
			rnd_name = v2.br_info.name
			numww = numww + 1
		end

		devprint("Found a code button, setting a new code: ("..newcode..")", rnd_name)
	end
end
