
primary_lights_enabled = false
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
