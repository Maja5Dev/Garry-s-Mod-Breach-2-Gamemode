
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

function Breach_Map_Organise()
	print("organising the map...")

	OrganiseAnimatedButtons()

	BR_DEFAULT_MAP_Organize_HidingClosets()

	MAP_SCP_294_Coins = 0

	BR2_SPECIAL_BUTTONS = {}
	for k,v in pairs(ents.GetAll()) do
		local name = v:GetName():lower()
		if string.find(name, "spec_button") then
			BR2_SPECIAL_BUTTONS[name] = v
		end

		/*
		if v:GetClass() == "func_door" then
			local closest_button = nil
			for k2,v2 in pairs(ents.FindInSphere(ply:GetPos(), 250)) do
				if v2:GetClass() == "prop_dynamic" then
					if closest_button == nil or closest_button[2] > dis then
						closest_button = {v, dis}
					end
				end
			end

			v.br_sbutton = closest_button[1]
		end
		*/
	end

	timer.Remove("BR_SCP008")
	timer.Remove("BR_SCP008_2")
	timer.Create("BR_SCP008", 5, 1, function()
		for k,v in pairs(ents.GetAll()) do
			local name = v:GetName():lower()
			if name == "008_containment_door" then
				local rnd_pl = table.Random(player.GetAll())
				v:Use(rnd_pl, rnd_pl, 1, 1)
			end
		end
	end)

	if round_system.current_scenario.scp_008_no_auto_closing == false then
		local scp_008_time = GetConVar("br2_time_008_open"):GetInt()
		timer.Create("BR_SCP008_2", scp_008_time, 1, function()
			for k,v in pairs(ents.GetAll()) do
				local name = v:GetName():lower()
				if name == "008_containment_door" then
					local tr = util.TraceLine({
						start = Vector(-1586,4896,-7088),
						endpos = Vector(-1579,4896,-7088),
					})
					if tr.Hit then
						local rnd_pl = table.Random(player.GetAll())
						v:Use(rnd_pl, rnd_pl, 1, 1)
					end
				end
			end
		end)
	end
	
	BR_DEFAULT_MAP_Organize_ItemSpawns()

	br2_914_disabled = false
	br_914status = 1

	SpawnMapNPCs()

	BR_DEFAULT_MAP_Organize_Corpses()
	BR_DEFAULT_MAP_Organize_Terminals()
	BR_DEFAULT_MAP_Organize_Outfits()
	BR_DEFAULT_MAP_Organize_ItemContainers()
	BR_DEFAULT_MAP_Organize_Cameras()
	BR_DEFAULT_MAP_Organize_KeypadCodes()
	BR_DEFAULT_MAP_Organize_Keypads()
	BR_DEFAULT_MAP_Organize_AddCodeDocuments()
end
hook.Add("BR2_Map_Organise", "BR2_Map_Breach_Map_Organise", Breach_Map_Organise)

print("[Breach2] Server/Functions/Organise mapconfig loaded!")