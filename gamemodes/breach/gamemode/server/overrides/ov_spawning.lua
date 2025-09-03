
function GM:PlayerSpawn(ply)
	if ply:Team() == TEAM_UNASSIGNED then
		ply:SetSpectator()
	end
	
	ply:SetNoCollideWithTeammates(true)
	ply:SetSuppressPickupNotices(true)
	ply:SetCanWalk(false)
	ply.aliveTime = CurTime()
end

local pregame_organised = false
function GM:PlayerInitialSpawn(ply)
	ply:FirstSetup()

    -- allow pre-game players to have some fun
	timer.Simple(10, function()
		if game_state == GAMESTATE_NOTSTARTED and table.Count(player.GetAll()) < 3 then
			ply:PreGameSpawns()
			if !pregame_organised then
				Breach_Map_Organise()
				pregame_organised = true
			end
		end
	end)
end

print("[Breach2] server/overrides/ov_spawning.lua loaded!")
