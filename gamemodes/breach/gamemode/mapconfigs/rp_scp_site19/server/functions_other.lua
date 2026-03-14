
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

print("[Breach2] Server/Functions/Other mapconfig loaded!")