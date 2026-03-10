
util.AddNetworkString("br_ci_teams_update")
util.AddNetworkString("br_ci_teams_join")
util.AddNetworkString("br_ci_teams_leave")
util.AddNetworkString("br_ci_team_ready")

net.Receive("br_ci_teams_leave", function(len, ply)
	for k,v in pairs(BR2_CI_TEAMS) do
		for k2,v2 in pairs(v) do
			if v2 == ply then
				table.RemoveByValue(v, ply)

				net.Start("br_ci_teams_update")
					net.WriteTable(BR2_CI_TEAMS)
				net.Send(ply)

				return
			end
		end
	end
end)

function br2_ci_teams_check()
    for teamIndex, teamTable in pairs(BR2_CI_TEAMS) do
        for i = #teamTable, 1, -1 do
            local pl = teamTable[i]
            if not IsValid(pl) or pl.br_downed == true or !pl:IsSpectator() then
                table.remove(teamTable, i)

				devprint("Removed invalid player from CI team " .. teamIndex, pl)
            end
        end
    end
end


CI_NEEDED_TO_SPAWN = 3

function br2_ci_teams_add(ply, num)
	if SafeFloatConVar("br2_time_ci_spawn") > (CurTime() - br2_round_state_start) then
		ply:PrintMessage(HUD_PRINTTALK, "CI Support Spawns will be available in " .. math.Round(SafeFloatConVar("br2_time_ci_spawn") - (CurTime() - br2_round_state_start)) .. " seconds")
		return
	end

	local has_ci_spawn = false
	for k,v in pairs(ply.br_support_spawns) do
		if v[1] == "ci" and v[2] > 0 then
			has_ci_spawn = true
			break
		end
	end

	if not has_ci_spawn then
		ply:PrintMessage(HUD_PRINTTALK, "You do not have any CI support spawns left")
		return
	end

	if (num == 1 or num == 2) and table.Count(BR2_CI_TEAMS[num]) < CI_NEEDED_TO_SPAWN and ply:IsSpectator() and ply.br_downed != true then
		-- check for invalid players in teams
		br2_ci_teams_check()

		-- remove from other teams
		for k,v in pairs(BR2_CI_TEAMS) do
			for k2,pl in pairs(v) do
				if pl == ply then
					table.RemoveByValue(v, ply)
					break
				end
			end
		end

		-- add to the requested team
		if not table.HasValue(BR2_CI_TEAMS[num], ply) then
			table.ForceInsert(BR2_CI_TEAMS[num], ply)
		end

		-- if team is full, spawn them all, otherwise just update the team info
		if table.Count(BR2_CI_TEAMS[num]) == CI_NEEDED_TO_SPAWN then
			devprint("CI Team " .. num .. " is ready to deploy")

			hook.Run("BR_OnCISpawn", BR2_CI_TEAMS[num])
			
			local all_cis = table.Copy(BR2_CI_TEAMS[num])
			local existingCIs = {}

			-- get spawn positions
			local all_possible_ci_spawns = {}
			for ci_spawn_group_k, ci_spawn_group in pairs(MAPCONFIG.SPAWNS_MTF) do
				if ci_spawn_group.available() then
					table.ForceInsert(all_possible_ci_spawns, ci_spawn_group)
				end
			end

			-- get existing cis, spawned before this
			for k2,v2 in pairs(player.GetAll()) do
				if v2:Alive() and !v2:IsSpectator() and v2.br_team == TEAM_CI then
					table.ForceInsert(existingCIs, v2)
				end
			end

			if table.Count(all_possible_ci_spawns) == 0 then
				table.ForceInsert(all_possible_ci_spawns, table.Random(MAPCONFIG.SPAWNS_MTF))
			end

			local ci_spawn_tab = table.Random(all_possible_ci_spawns)
			local ci_spawns = table.Copy(ci_spawn_tab.spawns)

			ci_spawn_tab.func()

			-- Spawn them
			for plk, pl_ci in pairs(all_cis) do
				-- decrease their spawn count
				for k,v in pairs(pl_ci.br_support_spawns) do
					if v[1] == "ci" and v[2] > 0 then
						v[2] = v[2] - 1
					end
				end

				pl_ci.br_team = TEAM_CI
				pl_ci:SendLua("BR_ClearMenus()")

				pl_ci.charid = BR_GetUniqueCharID()
				pl_ci:SetNWInt("BR_CharID", pl_ci.charid)

				assign_system.Assign_CIsoldier(pl_ci)
				pl_ci.br_team = TEAM_CI

				local spawn = table.Random(ci_spawns)
				pl_ci:SetPos(spawn)

				table.ForceInsert(pl_ci.br_special_items, {class="flashlight_tactical"})

				if IsValid(pl_ci.Body) then
					pl_ci.Body.Info.Victim = nil
				end

				-- Assign a new notepad and send the info from start of the round
				notepad_system.AssignNewNotepad(pl_ci, false)
				
				table.RemoveByValue(ci_spawns, spawn)
			end

			-- Send info so they know eachother
			for k_ci1, ci1 in pairs(all_cis) do
				for k_ci2, ci2 in pairs(all_cis) do
					if ci1 != ci2 then
						notepad_system.AddPlayerInfo(ci1, ci2.br_showname, ci2.br_role, ci2.br_team, false, HEALTH_ALIVE, false, ci2.charid, ci2)
					end
				end

				for k2,v2 in pairs(existingCIs) do
					notepad_system.AddPlayerInfo(ci1, v2.br_showname, v2.br_role, v2.br_team, false, HEALTH_ALIVE, false, v2.charid, v2)
				end

				for i=1, 3 do
					timer.Simple(0.4, function()
						notepad_system.UpdateNotepad(ci1)
					end)
				end

				timer.Simple(0.5, function()
					net.Start("br_update_own_info")
						net.WriteString(ci1.br_showname)
						net.WriteString(ci1.br_role)
						net.WriteInt(ci1.br_team or TEAM_CI, 8)
						net.WriteBool(false)
						net.WriteBool(false)
					net.Send(ci1)

					BroadcastPlayerInfo(ci1)
				end)
			end

			net.Start("br_ci_team_ready")
			net.Send(BR2_CI_TEAMS[num])
			
			BR2_CI_TEAMS[num] = {}
		else
			net.Start("br_ci_teams_update")
				net.WriteTable(BR2_CI_TEAMS)
			net.Send(ply)
		end

		ply:PrintMessage(HUD_PRINTCONSOLE, "You have joined CI Team " .. num)
		return true
	end
	
	ply:PrintMessage(HUD_PRINTTALK, "For some reason you could not join this team")
	
	print("br2_ci_teams_add failed for " .. ply:Nick() .. ", num: " .. tostring(num))
	print("Conditions: ", (num == 1 or num == 2), table.Count(BR2_CI_TEAMS[num]) < CI_NEEDED_TO_SPAWN, ply:IsSpectator(), ply.br_downed != true)
end

function br2_ci_teams_remove(ply)
	br2_ci_teams_reset()

	for k,v in pairs(BR2_CI_TEAMS) do
		for k2, pl in pairs(v) do
			if pl == ply then
				table.RemoveByValue(v, ply)
				break
			end
		end
	end
end

function br2_ci_teams_reset()
	BR2_CI_TEAMS = {
		{},
		{},
		{},
		{}
	}
end

br2_ci_teams_reset()

net.Receive("br_ci_teams_join", function(len, ply)
	local num = net.ReadInt(8)
	br2_ci_teams_add(ply, num)
end)

net.Receive("br_ci_teams_update", function(len, ply)
    net.Start("br_ci_teams_update")
        net.WriteTable(BR2_CI_TEAMS)
    net.Send(ply)
end)
