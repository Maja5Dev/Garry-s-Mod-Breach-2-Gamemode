
-- Spawns in Class D's cells
MAPCONFIG.SPAWNS_CLASSD_CELLS = {
}

-- Spawns in Light Containment Zone
MAPCONFIG.SPAWNS_LCZ = {		
}

-- Spawns in Heavy Containment Zone
MAPCONFIG.SPAWNS_HCZ = {
}

-- Spawns in Entrance Zone
MAPCONFIG.SPAWNS_ENTRANCEZONE = {
}

-- Where Security spawns
MAPCONFIG.SPAWNS_ENTRANCEZONE_EARLY = {
}

-- Where Chaos Insurgency spawns later
MAPCONFIG.SPAWNS_CHAOSINSURGENCY = {
	{
		name = "Near Gate C",
		spawns = {		
		}
	},
	{
		name = "Near Gate B",
		spawns = {				
		},
	},
	{
		name = "Near Gate A",
		spawns = {						
		},
	}
}

-- Where CI Soldiers spawn at the start of the round
MAPCONFIG.SPAWNS_ENTRANCEZONE_LATE = {}

for k,v in pairs(MAPCONFIG.SPAWNS_CHAOSINSURGENCY) do
	table.Add(MAPCONFIG.SPAWNS_ENTRANCEZONE_LATE, v.spawns)
end

-- SCP 035's spawns
MAPCONFIG.SPAWNS_SCP_035 = {
}

-- SCP 939's spawns
MAPCONFIG.SPAWNS_SCP_939 = {
}

-- SCP 049's spawns
MAPCONFIG.SPAWNS_SCP_049 = {
}

-- SCP 096's spawns
MAPCONFIG.SPAWNS_SCP_096 = {
}

-- SCP 173's spawns
MAPCONFIG.SPAWNS_SCP_173 = {
}

-- SCP 106's spawn
MAPCONFIG.SPAWNS_SCP_106 = {
}

-- SCP 457's spawn
MAPCONFIG.SPAWNS_SCP_457 = {
}

-- SCP 966's spawn
MAPCONFIG.SPAWNS_SCP_966 = {	
}


-- Where Mobile Task Force spawns when they arrive in the facility
MAPCONFIG.SPAWNS_MTF = {
}

MAPCONFIG.POCKETDIMENSION_SPAWNS = {
}

MAPCONFIG.SCP_294_CUP = {pos = Vector(0, 0, 0), ang = Angle(0, 0, 0)}

print("[Breach2] Server/Positions mapconfig loaded!")