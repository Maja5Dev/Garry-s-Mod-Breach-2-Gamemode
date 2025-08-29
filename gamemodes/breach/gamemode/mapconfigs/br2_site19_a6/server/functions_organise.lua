
BR2_SPECIAL_BUTTONS = {}

/* example
function MAP_ON_ROUND_START()
	print("opening scp chambers")
	local scp_doors = {
		--{ents.FindByName("049_door")[1], "open"},
		--{ents.FindInSphere(Vector(6376, -3958, 295.29998779297), 60)[1], "use"}
	}
	for k,v in pairs(scp_doors) do
		if IsValid(v[1]) then
			v[1]:Fire(v[2], "", 0)
		end
	end
end
hook.Add("BR2_RoundStart", "MAP_ROUNDSTART", MAP_ON_ROUND_START)
*/

function Breach_Map_Organise()
	print("organising the map...")

	MAP_SCP_294_Coins = 0

	BR2_SPECIAL_BUTTONS = {}
	for k,v in pairs(ents.GetAll()) do
		local name = v:GetName():lower()
		if string.find(name, "spec_button") then
			BR2_SPECIAL_BUTTONS[name] = v
		end
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


	for k,v in pairs(MAPCONFIG.RANDOM_ITEM_SPAWNS) do
		local all_spawns = table.Copy(v.spawns)
		for i=1, #all_spawns - v.num do
			table.RemoveByValue(all_spawns, table.Random(all_spawns))
		end
		local all_ents = {}
		for i,spawn in ipairs(all_spawns) do
			local ent = ents.Create(v.class)
			if IsValid(ent) then
				if v.model then
					ent:SetModel(v.model)
				end
				ent:SetPos(spawn[1])
				ent:SetAngles(spawn[2])
				ent:Spawn()
				if isfunction(v.func) then
					v.func(ent)
				end
				table.ForceInsert(all_ents, ent)
			end
		end
		if isfunction(v.func_all) then
			v.func_all(all_ents)
		end
	end

	br2_914_disabled = false
	br_914status = 1
	
	/*
	br2_914_fix_ent_1 = ents.Create("prop_physics")
	if IsValid(br2_914_fix_ent_1) then
		br2_914_fix_ent_1:SetPos(Vector(783.786865, -610.382507, -8192.000000))
		br2_914_fix_ent_1:SetModel("models/hunter/plates/plate2x3.mdl")
		br2_914_fix_ent_1:SetMaterial("phoenix_storms/metalset_1-2")
		br2_914_fix_ent_1:Spawn()
		local phys = br2_914_fix_ent_1:GetPhysicsObject()
		if IsValid(phys) then
			phys:EnableMotion(false)
		end
	end
	
	br2_914_fix_ent_2 = ents.Create("prop_physics")
	if IsValid(br2_914_fix_ent_2) then
		br2_914_fix_ent_2:SetPos(Vector(783.786865, -1060.382568, -8192))
		br2_914_fix_ent_2:SetModel("models/hunter/plates/plate2x3.mdl")
		br2_914_fix_ent_2:SetMaterial("phoenix_storms/metalset_1-2")
		br2_914_fix_ent_2:Spawn()
		local phys = br2_914_fix_ent_2:GetPhysicsObject()
		if IsValid(phys) then
			phys:EnableMotion(false)
		end
	end
	*/
	
	if SafeBoolConVar("br2_testing_mode") == false then
		SpawnMapNPCs()
	end
	
	local button_ents = {}

    BR_DEFAULT_MAP_Organize_Corpses()
    BR_DEFAULT_MAP_Organize_Terminals()
	BR_DEFAULT_MAP_Organize_Outfits()
    BR_DEFAULT_MAP_Organize_ItemContainers()
    BR_DEFAULT_MAP_Organize_Cameras()
    
    -- TODO: Implement keypads

	 -- lua_run for k,v in pairs(ents.GetAll()) do if string.find(v:GetName(), "mbutton_") then print(v:GetName()) end end

	-- BUTTONS
	if istable(MAPCONFIG.BUTTONS) then
		for i,butt in ipairs(MAPCONFIG.BUTTONS) do
			local button_found = false
			for k,v in pairs(ents.GetAll()) do
				if (isstring(butt.ent_name) and butt.ent_name == v:GetName()) or (v:GetPos() == butt.pos) or (v:GetPos():Distance(butt.pos) < 3) then
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

