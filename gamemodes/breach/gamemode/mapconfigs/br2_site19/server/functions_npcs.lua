
function BR_SpawnMapNPC(npc, zone)
	local all_players = {}
	for k,v in pairs(player.GetAll()) do
		if v:Alive() == true and v:IsSpectator() == false then
			table.ForceInsert(all_players, v)
		end
	end

	for k,v in pairs(ents.GetAll()) do
		if string.find(v:GetClass(), "npc_cpt_scp") then
			table.ForceInsert(all_players, v)
		end
	end

	local all_suitable_spawns = {}
	for pos_num,pos in ipairs(zone) do
		local pos_available = true
		local pos_points = 0
		for pl_num,pl in pairs(all_players) do
			local dist = pl:GetPos():Distance(pos)
			local trace = util.TraceLine({
				start = pl:GetPos(),
				endpos = pos,
				mask = MASK_SOLID,
				filter = pl
			})
			if dist < 700 and trace.Hit == false then
				pos_available = false
				break
			else
				pos_points = pos_points + dist
			end
		end
		if pos_available == true then
			table.ForceInsert(all_suitable_spawns, {pos, pos_points})
		end
	end
	/*
	local best_spawn = nil
	for k,v in pairs(all_suitable_spawns) do
		if best_spawn == nil or best_spawn[2] > v[2] then
			best_spawn = v
		end
	end
	*/
	local best_spawn = table.Random(all_suitable_spawns)

	if best_spawn != nil then
		local npc = ents.Create(npc)
		if IsValid(npc) then
			npc:SetPos(best_spawn[1])
			npc:Spawn()
			npc:Activate()
			return true
		end
	end
	return false
end

function SpawnMapNPCs()
	if GetConVar("br2_enable_npcs"):GetBool() == false then return end
	if round_system.current_scenario.disable_npc_spawning == true then return end

	local npc_tab = {
		--{"npc_cpt_scp_173", Vector(-183.948669, 1345.252441, -8063.968750)},
		--{"npc_cpt_scp_966", Vector(-650.879883, 4119.376953, -7167.968750)},
		--{"npc_cpt_scp_966", Vector(-474.215820, 4124.738281, -7167.968750)},
		--{"npc_cpt_scp_966", Vector(-752.841125, 4201.270020, -7167.968750)},
		--{"npc_cpt_scp_939_b", Vector(6699.372070, -1848.375977, -11551.968750)},
		--{"npc_cpt_scp_939_c", Vector(6929.901367, -885.706116, -11551.968750)},
		--{"npc_cpt_scp_178specs", Vector(658.442383, 1594.945190, -8145.907227)},

		/*
		{"npc_cpt_scp_106", Vector(-2730.027832, 5804.986328, -7166.968750)},
		{"npc_cpt_scp_457", Vector(-2567.378174, 2985.477783, -7167.968750)},
		{"npc_cpt_scp_575", Vector(1232.431885, 1351.772705, -8191.968750)},
		{"npc_cpt_scp_650", Vector(-952.335449, 2317.005615, -6143.968750)},
		*/
		{"npc_cpt_scp_939_a", Vector(10382.291992188, -3043.9111328125, -11916.96875)},
		{"npc_cpt_scp_012", Vector(-1122.385742, -195.140732, -8447.968750)},
		--{"npc_cpt_scp_1025", Vector(969.080566, 1265.391113, -8191.968750)},
		{"npc_cpt_scp_513", Vector(-812.415161, 5603.627441, -7167.968750)},
		--{"npc_cpt_scp_714", Vector(1518.547607, 1512.050903, -8156.471680)},
	}

	for k,v in pairs(npc_tab) do
		local npc = ents.Create(v[1])
		if IsValid(npc) then
			npc:SetPos(v[2])
			npc:Spawn()
			npc:Activate()
		end
	end
	
	local prep_time = math.Clamp(GetConVar("br2_time_preparing"):GetInt(), 45, 200) * 1.75
	print("prep_time_round", prep_time)

	timer.Remove("NPC_SPAWN_049_TIMER")
	timer.Create("NPC_SPAWN_049_TIMER", math.random(prep_time + 30, prep_time + 60), 1, function()
		BR_SpawnMapNPC("npc_cpt_scp_049", MAPCONFIG.SPAWNS_LCZ)
	end)

	timer.Remove("NPC_SPAWN_096_TIMER")
	timer.Create("NPC_SPAWN_096_TIMER", math.random(prep_time + 120, prep_time + 200), 1, function()
		BR_SpawnMapNPC("npc_cpt_scp_096", MAPCONFIG.SPAWNS_HCZ)
	end)

	timer.Remove("NPC_SPAWN_106_TIMER")
	timer.Create("NPC_SPAWN_106_TIMER", math.random(prep_time + 45, prep_time + 60), 1, function()
		BR_SpawnMapNPC("npc_cpt_scp_106", MAPCONFIG.SPAWNS_HCZ)
	end)

	timer.Remove("NPC_SPAWN_173_TIMER")
	timer.Create("NPC_SPAWN_173_TIMER", math.random(prep_time + 140, prep_time + 200), 1, function()
		BR_SpawnMapNPC("npc_cpt_scp_173", MAPCONFIG.SPAWNS_LCZ)
	end)

	timer.Remove("NPC_SPAWN_1048_TIMER")
	timer.Create("NPC_SPAWN_1048_TIMER", math.random(prep_time + 60, prep_time + 90), 1, function()
		BR_SpawnMapNPC("npc_cpt_scp_1048", MAPCONFIG.SPAWNS_LCZ)
	end)

	timer.Remove("NPC_SPAWN_457_TIMER")
	timer.Create("NPC_SPAWN_457_TIMER", math.random(prep_time + 45, prep_time + 90), 1, function()
		BR_SpawnMapNPC("npc_cpt_scp_457", MAPCONFIG.SPAWNS_HCZ)
	end)

	timer.Remove("NPC_SPAWN_575_TIMER")
	timer.Create("NPC_SPAWN_575_TIMER", math.random(prep_time + 60, prep_time + 90), 1, function()
		BR_SpawnMapNPC("npc_cpt_scp_575", MAPCONFIG.SPAWNS_ENTRANCEZONE)
	end)

	timer.Remove("NPC_SPAWN_066_TIMER")
	timer.Create("NPC_SPAWN_066_TIMER", math.random(prep_time + 90, prep_time + 140), 1, function()
		BR_SpawnMapNPC("npc_cpt_scp_066", MAPCONFIG.SPAWNS_ENTRANCEZONE)
	end)
end

print("[Breach2] Server/Functions/NPCs mapconfig loaded!")