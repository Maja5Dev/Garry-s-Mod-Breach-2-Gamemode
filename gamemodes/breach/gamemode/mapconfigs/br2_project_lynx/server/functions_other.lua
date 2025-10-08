
function MAP_ResetGasZones()
	MAPCONFIG.GAS_ZONES = {
		--{pos1 = XXXXXXXXXX, pos2 = YYYYYYYYYYYYYY},
	}
end
MAP_ResetGasZones()

function MAP_FemurBreaker()
	print("FEMUR BREAKER")
	BroadcastLua("surface.PlaySound('cpthazama/scp/106Contain.mp3')")
	return false
end

print("[Breach2] Server/Functions/Other mapconfig loaded!")