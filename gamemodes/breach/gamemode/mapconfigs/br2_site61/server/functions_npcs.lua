
function SpawnMapNPCs()
	if GetConVar("br2_enable_npcs"):GetBool() == false then return end
	if round_system.current_scenario.disable_npc_spawning == true then return end

	devprint("! spawning npcs enabled !")

	local npc_tab = {
		--{"npc_cpt_scp_173", Vector(-183.948669, 1345.252441, -8063.968750)},
		--{"npc_cpt_scp_966", Vector(-650.879883, 4119.376953, -7167.968750)},
		--{"npc_cpt_scp_966", Vector(-474.215820, 4124.738281, -7167.968750)},
		--{"npc_cpt_scp_966", Vector(-752.841125, 4201.270020, -7167.968750)},
		--{"npc_cpt_scp_939_b", Vector(6699.372070, -1848.375977, -11551.968750)},
		--{"npc_cpt_scp_939_c", Vector(6929.901367, -885.706116, -11551.968750)},
		--{"npc_cpt_scp_178specs", Vector(658.442383, 1594.945190, -8145.907227)},

		{"drg_scp0492ue3", Vector(3531.3984375, -6678.494140625, -8607.96875)},
		{"drg_scp0492ue3", Vector(4664.5073242188, -6689.1069335938, -8606.96875)},

		{"npc_cpt_scp_939_a", Vector(6592.954590, -893.843567, -11551.968750)},

		-- minor scps
		{"npc_cpt_scp_012", Vector(-1122.385742, -195.140732, -8447.968750)},
		{"npc_cpt_scp_513", Vector(-812.415161, 5603.627441, -7167.968750)},
		{"drg_scp1762_linux55version", Vector(1108.526245, 6267.038574, -7262)},
		{"npc_cpt_scp_1025", Vector(1518.4587402344, 1512.3208007813, -8156.4716796875)},
		{"npc_cpt_scp_1123", Vector(-304.29190063477, -1764.6800537109, -8150.96875)},
	}

	for k,v in pairs(npc_tab) do
		local npc = ents.Create(v[1])
		if IsValid(npc) then
			npc:SetPos(v[2])
			npc:Spawn()
			npc:Activate()
		end
	end
	
	local prep_time = math.Clamp(GetConVar("br2_time_preparing"):GetInt(), 45, 200) * 1.5

	timer.Remove("NPC_SPAWN_049_TIMER")
	timer.Create("NPC_SPAWN_049_TIMER", math.random(prep_time + 50, prep_time + 120), 1, function()
		BR_SpawnMapNPC("drg_scp049ue", MAPCONFIG.SPAWNS_LCZ)
	end)

	--zombies
	timer.Remove("NPC_SPAWN_0492_TIMER1")
	timer.Create("NPC_SPAWN_0492_TIMER1", math.random(prep_time + 60, prep_time + 120), 1, function()
		BR_SpawnMapNPC("drg_scp0492ue2", MAPCONFIG.SPAWNS_LCZ)
	end)
	timer.Remove("NPC_SPAWN_0492_TIMER1")
	timer.Create("NPC_SPAWN_0492_TIMER1", math.random(prep_time + 30, prep_time + 40), 1, function()
		BR_SpawnMapNPC("drg_scp0492ue3", MAPCONFIG.SPAWNS_HCZ)
	end)
	timer.Remove("NPC_SPAWN_0492_TIMER2")
	timer.Create("NPC_SPAWN_0492_TIMER2", math.random(prep_time + 35, prep_time + 60), 1, function()
		BR_SpawnMapNPC("drg_scp0492ue3", MAPCONFIG.SPAWNS_HCZ)
	end)
	timer.Remove("NPC_SPAWN_0493_TIMER2")
	timer.Create("NPC_SPAWN_0493_TIMER2", math.random(prep_time + 45, prep_time + 120), 1, function()
		BR_SpawnMapNPC("drg_scp0492ue3", MAPCONFIG.SPAWNS_HCZ)
	end)

	timer.Remove("NPC_SPAWN_096_TIMER")
	timer.Create("NPC_SPAWN_096_TIMER", math.random(prep_time + 80, prep_time + 170), 1, function()
		BR_SpawnMapNPC("drg_scp096mod2", MAPCONFIG.SPAWNS_HCZ)
	end)

	timer.Remove("NPC_SPAWN_106_TIMER")
	timer.Create("NPC_SPAWN_106_TIMER", math.random(prep_time + 80, prep_time + 180), 1, function()
		BR_SpawnMapNPC("drg_uescp106ver2", MAPCONFIG.SPAWNS_HCZ)
	end)

	timer.Remove("NPC_SPAWN_173_TIMER")
	timer.Create("NPC_SPAWN_173_TIMER", math.random(prep_time + 140, prep_time + 200), 1, function()
		BR_SpawnMapNPC("npc_cpt_scp_173", MAPCONFIG.SPAWNS_LCZ)
	end)

	timer.Remove("NPC_SPAWN_1048_TIMER")
	timer.Create("NPC_SPAWN_1048_TIMER", math.random(prep_time + 60, prep_time + 100), 1, function()
		BR_SpawnMapNPC("dughoo_scpcb_scp-1048a", MAPCONFIG.SPAWNS_LCZ)
	end)

	timer.Remove("NPC_SPAWN_999_TIMER")
	timer.Create("NPC_SPAWN_999_TIMER", math.random(prep_time + 60, prep_time + 130), 1, function()
		BR_SpawnMapNPC("drg_scp999", MAPCONFIG.SPAWNS_ENTRANCEZONE)
	end)

	timer.Remove("NPC_SPAWN_131_TIMER")
	timer.Create("NPC_SPAWN_131_TIMER", math.random(prep_time + 60, prep_time + 130), 1, function()
		BR_SpawnMapNPC("drg_scp131", MAPCONFIG.SPAWNS_ENTRANCEZONE)
	end)

	timer.Remove("NPC_SPAWN_457_TIMER")
	timer.Create("NPC_SPAWN_457_TIMER", math.random(prep_time + 50, prep_time + 90), 1, function()
		local npc = BR_SpawnMapNPC("npc_cpt_scp_457", MAPCONFIG.SPAWNS_HCZ)

		if IsValid(npc) and npc != false then
			npc.lockedNPCSpawns = MAPCONFIG.SPAWNS_HCZ
		end
	end)

	timer.Remove("NPC_SPAWN_575_TIMER")
	timer.Create("NPC_SPAWN_575_TIMER", math.random(prep_time + 60, prep_time + 90), 1, function()
		local npc = BR_SpawnMapNPC("npc_cpt_scp_575", MAPCONFIG.SPAWNS_ENTRANCEZONE)

		if IsValid(npc) and npc != false then
			npc.lockedNPCSpawns = MAPCONFIG.SPAWNS_ENTRANCEZONE
		end
	end)

	timer.Remove("NPC_SPAWN_066_TIMER")
	timer.Create("NPC_SPAWN_066_TIMER", math.random(prep_time + 90, prep_time + 140), 1, function()
		BR_SpawnMapNPC("dughoo_scpcb_scp066", MAPCONFIG.SPAWNS_ENTRANCEZONE)
	end)

	timer.Remove("NPC_SPAWN_1356_TIMER")
	timer.Create("NPC_SPAWN_1356_TIMER", math.random(prep_time + 20, prep_time + 240), 1, function()
		BR_SpawnMapNPC("npc_cpt_scp_1356", {
			Vector(-1805.0894775391, 4324.30859375, -7136),
			Vector(-1790.8957519531, 3944.8376464844, -7136),
			Vector(-2180.6157226563, 4310.9404296875, -7136)
		})
	end)
end

function MAP_FemurBreaker()
	devprint("FEMUR BREAKER")

	timer.Remove("NPC_SPAWN_106_TIMER")

	for k,v in pairs(ents.GetAll()) do
		if IsValid(v) and string.find(v:GetClass(), "scp106") or string.find(v:GetClass(), "scp_106") or string.find(v:GetClass(), "scpcb_106") then
			v:SetPos(Vector(-2387.296875, 6250.779785, -7418.968750))
			v.cannotTeleport = true
		end
	end

	/*
	if table.Count(scp_106) > 0 then
		scp_106 = scp_106[1]
		if IsValid(scp_106) then
			scp_106:Remove()
		end
	end
	*/

	BroadcastLua("surface.PlaySound('cpthazama/scp/106Contain.mp3')")

	/*
	local tr = util.TraceLine({
		start = Vector(-2522,6345,-7616),
		endpos = Vector(-2510,6369,-7499),
	})
	if tr.Hit and br2_round_state_end - CurTime() then
		timer.Remove("NPC_SPAWN_106_TIMER")
		local scp_106 = ents.FindByClass("npc_cpt_scp_106")
		if table.Count(scp_106) > 0 then
			scp_106 = scp_106[1]
			if IsValid(scp_106) then
				scp_106:Remove()
				BroadcastLua("surface.PlaySound('cpthazama/scp/106Contain.mp3')")
			end
		end
	end
	*/
	return false
end
