
MAPCONFIG.Starting_Corpses_Number = function()
	--return table.Count(MAPCONFIG.STARTING_CORPSES) - 4 - math.random(0,10)
    --return table.Count(MAPCONFIG.STARTING_CORPSES)
    return 0
end

--lua_run Entity(1):SetPos(MAPCONFIG.STARTING_CORPSES[1].ragdoll_pos)
MAPCONFIG.STARTING_CORPSES = {
}
