
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

	Breach_FixMapHDRBrightness()

	timer.Create("BR_Map_FixMapHDRBrightness_Timer", 1, 1, function()
		Breach_FixMapHDRBrightness()
	end)

	br_next_radio_play = 0

	OrganiseAnimatedButtons()

	if istable(MAPCONFIG.BUTTONS_2D.HIDING_CLOSETS) then
		for k,v in pairs(MAPCONFIG.BUTTONS_2D.HIDING_CLOSETS.buttons) do
			v.peeking_ent = ents.Create("br2_peeking")
			if IsValid(v.peeking_ent) then
				v.peeking_ent:SetModel("models/hunter/blocks/cube025x025x025.mdl")
				v.peeking_ent:SetPos(v.peeking_pos)
				v.peeking_ent:Spawn()
				v.peeking_ent:SetNoDraw(true)
			end
		end
	end

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

	--CORPSES
	if istable(MAPCONFIG.STARTING_CORPSES) and round_system.current_scenario.fake_corpses == true then
		local all_corpses = table.Copy(MAPCONFIG.STARTING_CORPSES)
		local corpse_infos = {}

		for i=1, MAPCONFIG.Starting_Corpses_Number() do
			local random_corpse = table.Random(all_corpses)
			table.ForceInsert(corpse_infos, random_corpse)
			table.RemoveByValue(all_corpses, random_corpse)
		end
		
		for k,v in pairs(corpse_infos) do
			local corpse = table.Random(v)
			local rag = ents.Create("prop_ragdoll")
			if IsValid(rag) then
				rag:SetModel(corpse.model)
				rag:SetPos(corpse.ragdoll_pos)
				rag.IsStartingCorpse = true
				rag:Spawn()
				ApplyCorpseInfo(rag, corpse, true)
				rag.CInfo = corpse
				rag.Info = {}
				rag.Info.CorpseID = rag:GetCreationID()
				rag.Info.Victim = NULL
				rag.Info.VictimNick = "Unknown"
				rag.Info.DamageType = DMG_GENERIC
				rag.Info.Time = CurTime() - math.random(20,1400)
				rag:SetNWInt("DeathTime", rag.Info.Time)
				rag:SetNWString("ExamineDmgInfo", " - Cause of death is unknown")
				rag.Info.Loot = {}
				--local random_item = table.Random({"item_radio", "item_medkit", "item_pills", "item_gasmask", "item_nvg", "keycard_level1", "keycard_level2", "kanade_tfa_crowbar"})
				--table.ForceInsert(rag.Info.Loot, form_basic_item_info(random_item))
				rag.RagdollHealth = 0
				rag.nextReviveMove = 0
				
				if isfunction(corpse.setup) then
					corpse.setup(rag)
					if istable(all_fake_corpses) then
						table.ForceInsert(all_fake_corpses, rag)
						rag.Info.notepad = {}
						rag.Info.notepad.people = {
							{
								br_ci_agent = rag.br_ci_agent,
								br_role = rag.br_role,
								br_showname = rag.br_showname,
								health = HEALTH_ALIVE,
								scp = false
							}
						}
					end
				end
			end
		end
	end
	
	timer.Create("BR2_MAPCONFIG_CORPSEINFO", 4, 1, function()
		for k,v in pairs(ents.FindByClass("prop_ragdoll")) do
			if v.CInfo then
				--ApplyCorpseInfo(v, v.CInfo, true)
				for i=0, (v:GetPhysicsObjectCount() - 1) do
					local bone = v:GetPhysicsObjectNum(i)
					if IsValid(bone) then
						bone:EnableMotion(true)
					end
				end
			end
		end
 	end)

	-- lua_run for k,v in pairs(ents.GetAll()) do if string.find(v:GetName(), "mbutton_") then print(v:GetName()) end end

	BR_DEFAULT_MAP_Organize_Keypads()

	BR_DEFAULT_MAP_Organize_Terminals()


	-- OUTFITS
	local outfit_groups = {}
	for k,v in pairs(MAPCONFIG.BUTTONS_2D.OUTFITTERS.buttons) do
		outfit_groups[v.item_gen_group] = outfit_groups[v.item_gen_group] or {}
		table.ForceInsert(outfit_groups[v.item_gen_group], v)
		v.items = {}
	end
	
	for k_outfit_group,outfit_group in pairs(outfit_groups) do
		if istable(MAPCONFIG.OUTFIT_GENERATION_GROUPS[k_outfit_group]) then
			local gen_groups = table.Copy(MAPCONFIG.OUTFIT_GENERATION_GROUPS[k_outfit_group])
			local all_outfitters = {}

			for i = 1, table.Count(gen_groups) do
				local rnd_outfitter = table.Random(gen_groups)
				table.ForceInsert(all_outfitters, rnd_outfitter)
				table.RemoveByValue(gen_groups, rnd_outfitter)
			end

			for k_item, item in pairs(all_outfitters) do
				local rnd_outfitter = table.Random(outfit_group)
				if istable(rnd_outfitter) then
					for i = 1, item[2] do
						table.ForceInsert(rnd_outfitter.items, item[1])
					end
					table.RemoveByValue(outfit_group, rnd_outfitter)
				end
			end
		end
	end

	-- ITEMS
	local container_groups = {}
	for k,v in pairs(MAPCONFIG.BUTTONS_2D.ITEM_CONTAINERS.buttons) do
		v.locked = false
		if math.random(1,4) == 2 and !v.canBeLocked then
			v.locked = true
		else
			container_groups[v.item_gen_group] = container_groups[v.item_gen_group] or {}
			table.ForceInsert(container_groups[v.item_gen_group], v)
		end
		v.items = {}
	end
	for k,v in pairs(MAPCONFIG.BUTTONS_2D.ITEM_CONTAINERS_CRATES.buttons) do
		container_groups[v.item_gen_group] = container_groups[v.item_gen_group] or {}
		table.ForceInsert(container_groups[v.item_gen_group], v)
		v.items = {}
		v.locked = true
	end

	for k_cont_group,cont_group in pairs(container_groups) do
		if istable(MAPCONFIG.ITEM_GENERATION_GROUPS[k_cont_group]) then
			local all_items = {}
			for k_item, item in pairs(MAPCONFIG.ITEM_GENERATION_GROUPS[k_cont_group]) do
				for i = 1, item[2] do
					table.ForceInsert(all_items, item[1])
				end
			end
			for k_button,button in pairs(cont_group) do
				if table.Count(button.items) == 0 and table.Count(all_items) > 0 then
					local rnd_item = table.Random(all_items)
					if rnd_item != nil then
						table.ForceInsert(button.items, form_basic_item_info(rnd_item))
						table.RemoveByValue(all_items, rnd_item)
					end
				end
			end
			for k_item,item in pairs(all_items) do
				local rnd_cont = table.Random(cont_group)
				if item != nil then
					table.ForceInsert(rnd_cont.items, form_basic_item_info(item))
				end
			end
		end
	end
	
	BR_DEFAULT_MAP_Organize_Cameras()

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