
BR2_SPECIAL_BUTTONS = {}
MAP_AAB = {}

function OrganiseAnimatedButtons()
	MAP_AAB = {}
	for k_button, v_button in pairs(ents.FindByClass("func_button")) do
		local closest_door = nil
		local closest_buttons = {}
		for k,v in pairs(ents.FindInSphere(v_button:GetPos(), 150)) do
			local dis = v:GetPos():Distance(v_button:GetPos())
			if v:GetClass() == "func_door" then
				if closest_door == nil or closest_door[2] > dis then
					closest_door = {v, dis}
				end
			elseif v:GetClass() == "prop_dynamic" then
				table.ForceInsert(closest_buttons, {v, dis})
			end
		end
		table.sort(closest_buttons, function(a, b) return a[2] < b[2] end)
		if closest_door then
			table.ForceInsert(MAP_AAB, v_button)
			v_button.triggers = {}
			for k,v in pairs(closest_buttons) do
				--if v[2] < 750 and #closest_buttons < 2 then
					v[1].active = 0
					table.ForceInsert(v_button.triggers, {v[1], closest_door[1]})
					--print('adding ', v[1], " and ", closest_door, " to ", v_button)
				--end
			end
		end
	end
end

local function GenerateRandomPassword()
    local str = "1234567890qwertyuiopasdfghjklzxcvbnm"
    local ret = ""
    for i=1, 4 do
        ret = ret .. str[math.random(1,36)]
    end
    print("random pass: " .. ret)
    return ret
end

function Breach_Map_Organise()
	print("organising the map...")

	--br_next_radio_play = 0

	Breach_FixMapHDRBrightness()

	OrganiseAnimatedButtons()

	BR_DEFAULT_MAP_Organize_HidingClosets()

	MAP_SCP_294_Coins = 0

	BR_DEFAULT_MAP_Organize_ItemSpawns()

	br2_914_disabled = false
	br_914status = 1
	
	local button_ents = {}

	BR_DEFAULT_MAP_Organize_Corpses()
	BR_DEFAULT_MAP_Organize_Terminals()
	BR_DEFAULT_MAP_Organize_Outfits()
	BR_DEFAULT_MAP_Organize_ItemContainers()
	BR_DEFAULT_MAP_Organize_Cameras()

	local allowed_button_classes = {
		"func_button"
	}
	
	-- BUTTONS
	if istable(MAPCONFIG.KEYPADS) then
		for i,butt in ipairs(MAPCONFIG.KEYPADS) do
			local button_found = false
			for k,v in pairs(ents.GetAll()) do
				if ((isstring(butt.ent_name) and butt.ent_name == v:GetName()) or (v:GetPos() == butt.pos) or (v:GetPos():Distance(butt.pos) < 3)) and table.HasValue(allowed_button_classes, v:GetClass()) then
					if butt.ent_name then
						print("Found a button with name (" .. butt.ent_name .. ")")
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
				print("Button not found", i, butt.pos)
			end
		end
	else
		print("[Breach2] No buttons found...")
		return
	end

	-- BUTTON CODES
	local numww = 0
	for k,v in pairs(button_ents) do
		if v.br_info.code != nil then
			local oldcode = v.br_info.code
			v.br_info.code = (math.random(1,9) * 1000) + (math.random(1,9) * 100) + (math.random(1,9) * 10) + math.random(1,9)
			print("Found a code button ("..oldcode..") changing to a random one ("..v.br_info.code..")", v.br_info.name)
			v.br_info.code_type = "radio"
			numww = numww + 1
		end
	end
	print("ALL CODE BUTTONS: " .. numww)
end

print("[Breach2] Server/Functions/Organise mapconfig loaded!")