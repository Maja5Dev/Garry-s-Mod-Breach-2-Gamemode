
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
		if v.canEscape == true and v:IsInZone(evac_shelter_1) and v:Alive() then
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
			print(v:Nick(), "escaped through the evac shelter")
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

local primary_lights_enabled = false
function MAP_ResetGenerators()
	MAP_GENERATOR_1_ON = false
	MAP_GENERATOR_2_ON = false
	MAP_GENERATOR_3_ON = false
	MAP_GENERATOR_4_ON = false
	primary_lights_enabled = false
end

MAP_ResetGenerators()

function Map_GeneratorOn()
	local num_gen_enabled = 0
	if MAP_GENERATOR_1_ON then num_gen_enabled = num_gen_enabled + 1 end
	if MAP_GENERATOR_2_ON then num_gen_enabled = num_gen_enabled + 1 end
	if MAP_GENERATOR_3_ON then num_gen_enabled = num_gen_enabled + 1 end
	if MAP_GENERATOR_4_ON then num_gen_enabled = num_gen_enabled + 1 end

	if !primary_lights_enabled and num_gen_enabled > 1 then
		net.Start("br_enable_primary_lights")
		net.Broadcast()
	end
end

function MAP_Generator_1()
	MAP_GENERATOR_1_ON = true
	Map_GeneratorOn()
end

function MAP_Generator_2()
	MAP_GENERATOR_2_ON = true
	Map_GeneratorOn()
end

function MAP_Generator_3()
	MAP_GENERATOR_3_ON = true
	Map_GeneratorOn()
end

function MAP_Generator_4()
	MAP_GENERATOR_4_ON = true
	Map_GeneratorOn()
end

function MAP_PrimaryLights_Enable()
	net.Start("br_enable_primary_lights")
	net.Broadcast()
end

function MAP_PrimaryLights_Disable()
	net.Start("br_disable_primary_lights")
	net.Broadcast()
end
