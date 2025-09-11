
function MAP_ResetGasZones()
	MAPCONFIG.GAS_ZONES = {
		--{pos1 = XXXXXXXXXX, pos2 = YYYYYYYYYYYYYY},
	}
end
MAP_ResetGasZones()

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
	BroadcastLua("surface.PlaySound('cpthazama/scp/106Contain.mp3')")
	return false
end

print("[Breach2] Server/Functions/Other mapconfig loaded!")