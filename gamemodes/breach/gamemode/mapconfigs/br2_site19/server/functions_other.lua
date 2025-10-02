
function MAP_ResetGasZones()
	MAPCONFIG.GAS_ZONES = {
		{pos1 = Vector(28,4964,-7184), pos2 = Vector(-144,4598,-7024)},
		{pos1 = Vector(5653,-247,-11574), pos2 = Vector(5416,-81,-11405)},
		{pos1 = Vector(681,195,-8204), pos2 = Vector(514,384,-8056)},
		{pos1 = Vector(-3165,5083,-7491), pos2 = Vector(-3262,5299,-7325)},
	}
end
MAP_ResetGasZones()

function MAP_EvacShelter1()
	local evac_shelter_1 = {pos1 = Vector(4859,5126,-7190), pos2 = Vector(4687,4947,-7033)}

	local evac_items = nil
	local evac_weapons = nil
	local evac_ammo = nil

	for k,v in pairs(MAPCONFIG.BUTTONS_2D.ITEM_CONTAINERS.buttons) do
		if v.item_gen_group == "EZ_EVAC_SHELTER_ITEMS" then
			evac_items = v
		elseif v.item_gen_group == "EZ_EVAC_SHELTER_WEAPONS" then
			evac_weapons = v
		elseif v.item_gen_group == "EZ_EVAC_SHELTER_AMMO" then
			evac_ammo = v
		end
	end

	for k,v in pairs(player.GetAll()) do
		if v.canEscape == true and v:IsInZone(evac_shelter_1) and v:Alive() and !v:IsSpectator() then
			if evac_weapons then
				for k2,wep in pairs(v:GetWeapons()) do
					if wep.Pickupable == true then
						table.ForceInsert(evac_weapons.items, form_basic_item_info(wep:GetClass(), 0))
					end
				end
			end
			if evac_items then
				for k2,v2 in pairs(v.br_special_items) do
					for k3,v3 in pairs(BR2_SPECIAL_ITEMS) do
						if v3.class == v2.class then
							v2.ammo = 0
							table.ForceInsert(evac_items.items, v2)
						end
					end
				end
			end
			if evac_ammo then
				for k2,v2 in pairs(v:GetAmmoItems()) do
					table.ForceInsert(evac_ammo.items, v2)
				end
			end
			v:SetSpectator()
			devprint(v:Nick(), "escaped through the evac shelter")
			net.Start("cl_playerescaped")
				net.WriteInt(CurTime() - v.aliveTime, 16)
			net.Send(v)
		end
	end
end

function MAP_GasLeak1()
	table.ForceInsert(MAPCONFIG.GAS_ZONES, {name = "gasleak1", pos1 = Vector(432,-2032,-8199), pos2 = Vector(752,-2192,-8055)})
	timer.Remove("GasLeak1")
	timer.Create("GasLeak1", 5, 1, function()
		for k,v in pairs(MAPCONFIG.GAS_ZONES) do
			if v.name == "gasleak1" then
				table.RemoveByValue(MAPCONFIG.GAS_ZONES, v)
			end
		end
	end)
end

function MAP_GasLeak2()
	table.ForceInsert(MAPCONFIG.GAS_ZONES, {name = "gasleak2", pos1 = Vector(4355,7019,-7189), pos2 = Vector(4680,6935,-7000)})
	timer.Remove("GasLeak2")
	timer.Create("GasLeak2", 5, 1, function()
		for k,v in pairs(MAPCONFIG.GAS_ZONES) do
			if v.name == "gasleak2" then
				table.RemoveByValue(MAPCONFIG.GAS_ZONES, v)
			end
		end
	end)
end

function MAP_GasLeak3()
	table.ForceInsert(MAPCONFIG.GAS_ZONES, {name = "gasleak2", pos1 = Vector(6052,6062,-7181), pos2 = Vector(5963,5732,-7019)})
	timer.Remove("GasLeak3")
	timer.Create("GasLeak3", 5, 1, function()
		for k,v in pairs(MAPCONFIG.GAS_ZONES) do
			if v.name == "gasleak3" then
				table.RemoveByValue(MAPCONFIG.GAS_ZONES, v)
			end
		end
	end)
end

function MAP_ResetGenerators()
	MAP_GENERATOR_1_ON = false
	MAP_GENERATOR_2_ON = false
	MAP_GENERATOR_3_ON = false
	MAP_GENERATOR_4_ON = false
end

MAP_ResetGenerators()

function Map_GeneratorOn()
	if MAP_GENERATOR_1_ON and MAP_GENERATOR_2_ON and MAP_GENERATOR_3_ON and MAP_GENERATOR_4_ON then
		print("ALL GENERATORS ON")
		net.Start("br_enable_primary_lights")
		net.Broadcast()
	end
end

function MAP_Generator_1()
	MAP_GENERATOR_1_ON = true
	print("Generator 1 started")
end

function MAP_Generator_2()
	MAP_GENERATOR_2_ON = true
	print("Generator 2 started")
end

function MAP_Generator_3()
	MAP_GENERATOR_3_ON = true
	print("Generator 3 started")
end

function MAP_Generator_4()
	MAP_GENERATOR_4_ON = true
	print("Generator 4 started")
end

function MAP_PrimaryLights_Enable()
	if MAP_GENERATOR_1_ON and MAP_GENERATOR_2_ON and MAP_GENERATOR_3_ON and MAP_GENERATOR_4_ON then
		print("ALL GENERATORS ON")
		net.Start("br_enable_primary_lights")
		net.Broadcast()
	end
end

function MAP_PrimaryLights_Disable()
end

function MAP_FemurBreaker()
	print("FEMUR BREAKER")

	timer.Remove("NPC_SPAWN_106_TIMER")
	
	local scp_106 = ents.FindByClass("npc_cpt_scp_106")
	if table.Count(scp_106) > 0 then
		scp_106 = scp_106[1]
		if IsValid(scp_106) then
			scp_106:Remove()
		end
	end

	local scp_1062 = ents.FindByClass("drg_uescp106ver2")
	if table.Count(scp_1062) > 0 then
		scp_1062 = scp_1062[1]
		if IsValid(scp_1062) then
			scp_1062:Remove()
		end
	end

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

function MAP_ON_ROUND_START()
	print("opening scp chambers")
	local scp_doors = {
		{ents.FindByName("049_door")[1], "open"},
		{ents.FindInSphere(Vector(6376, -3958, 295.29998779297), 60)[1], "use"}
	}
	for k,v in pairs(scp_doors) do
		if IsValid(v[1]) then
			v[1]:Fire(v[2], "", 0)
		end
	end
end
hook.Add("BR2_RoundStart", "MAP_ROUNDSTART", MAP_ON_ROUND_START)

print("[Breach2] Server/Functions/Other mapconfig loaded!")