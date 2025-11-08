
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

		{"br2_npc_cpt_scp_939a", Vector(6592.954590, -893.843567, -11551.968750)},

		-- minor scps
		{"br2_npc_cpt_scp012", Vector(-1122.385742, -195.140732, -8447.968750)},
		{"br2_npc_cpt_scp_513", Vector(-812.415161, 5603.627441, -7167.968750)},
		{"drg_scp1762_linux55version", Vector(1108.526245, 6267.038574, -7262)},
		{"br2_npc_cpt_scp_1025", Vector(1518.4587402344, 1512.3208007813, -8156.4716796875)},
		{"br2_npc_cpt_scp_1123", Vector(-304.29190063477, -1764.6800537109, -8150.96875)},
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

	BR_SpawnMapNPCTimer("br2_drg_scp049ue", MAPCONFIG.SPAWNS_LCZ, math.random(prep_time + 50, prep_time + 120))

	--zombies
	BR_SpawnMapNPCTimer("drg_scp0492ue2", MAPCONFIG.SPAWNS_LCZ, math.random(prep_time + 60, prep_time + 120))
	BR_SpawnMapNPCTimer("drg_scp0492ue3", MAPCONFIG.SPAWNS_HCZ, math.random(prep_time + 30, prep_time + 40))
	BR_SpawnMapNPCTimer("drg_scp0492ue3", MAPCONFIG.SPAWNS_HCZ, math.random(prep_time + 35, prep_time + 60))
	BR_SpawnMapNPCTimer("drg_scp0492ue3", MAPCONFIG.SPAWNS_HCZ, math.random(prep_time + 45, prep_time + 120))

	BR_SpawnMapNPCTimer("br2_npc_drg_scp_096", MAPCONFIG.SPAWNS_HCZ, math.random(prep_time + 80, prep_time + 170))
	BR_SpawnMapNPCTimer("br2_npc_drg_scp_106", MAPCONFIG.SPAWNS_HCZ, math.random(prep_time + 80, prep_time + 180))
	BR_SpawnMapNPCTimer("dughoo_scpcb_scp-1048a", MAPCONFIG.SPAWNS_LCZ, math.random(prep_time + 60, prep_time + 100))
	BR_SpawnMapNPCTimer("drg_scp999", MAPCONFIG.SPAWNS_ENTRANCEZONE, math.random(prep_time + 60, prep_time + 130))
	
	-- eye
	BR_SpawnMapNPCTimer("drg_scp131", MAPCONFIG.SPAWNS_ENTRANCEZONE, math.random(prep_time + 60, prep_time + 130))

	BR_SpawnMapNPCTimer("npc_cpt_scp_457", MAPCONFIG.SPAWNS_HCZ, math.random(prep_time + 50, prep_time + 90), true)
	
	-- shadow
	BR_SpawnMapNPCTimer("npc_cpt_scp_575", MAPCONFIG.SPAWNS_ENTRANCEZONE, math.random(prep_time + 60, prep_time + 90), true)

	-- LOUD spaghetti
	BR_SpawnMapNPCTimer("dughoo_scpcb_scp066", MAPCONFIG.SPAWNS_ENTRANCEZONE, math.random(prep_time + 90, prep_time + 140))
	
	-- duck
	BR_SpawnMapNPCTimer("npc_cpt_scp_1356", {
		Vector(-1805.0894775391, 4324.30859375, -7136),
		Vector(-1790.8957519531, 3944.8376464844, -7136),
		Vector(-2180.6157226563, 4310.9404296875, -7136)
	}, math.random(prep_time + 20, prep_time + 240))
end

function MAP_FemurBreaker()
	devprint("FEMUR BREAKER")

	timer.Remove("NPC_SPAWN_106_TIMER")

	for k,v in pairs(ents.GetAll()) do
		if IsValid(v) and
		((string.find(v:GetClass(), "scp106") or string.find(v:GetClass(), "scp_106") or string.find(v:GetClass(), "scpcb_106")) or
		(v:IsPlayer() and v.br_role == ROLE_SCP_106)
	) then
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

	round_system.AddEventLog("SCP-106 has been contained.")

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
