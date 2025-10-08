
BR2_SPECIAL_BUTTONS = {}

function Breach_Map_Organise()
	print("organising the map...")

	Breach_FixMapHDRBrightness()

	timer.Create("BR_Map_FixMapHDRBrightness_Timer", 1, 1, function()
		Breach_FixMapHDRBrightness()
	end)

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
				if ((isstring(butt.ent_name) and butt.ent_name == v:GetName()) or
					(v:GetPos() == butt.pos) or (v:GetPos():Distance(butt.pos) < 3)) and
					table.HasValue(allowed_button_classes, v:GetClass())
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
end
hook.Add("BR2_Map_Organise", "BR2_Map_Breach_Map_Organise", Breach_Map_Organise)

print("[Breach2] Server/Functions/Organise mapconfig loaded!")