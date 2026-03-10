


local function teleportToSpawnpoint(ply)
	if istable(ply.br_spawn_groups) then
		local all_possible_spawns = {}

		for k,pos in pairs(ply.br_spawn_groups) do
			local pos_available = true

			for k2,pl in pairs(player.GetAll()) do
				local trace = util.TraceLine({
					start = pl:GetPos(),
					endpos = pos,
					mask = MASK_SOLID,
					filter = pl
				})

				if trace.HitPos == pos then
					pos_available = false
				end
			end
			
			if pos_available == true then
				table.ForceInsert(all_possible_spawns, pos)
			end
		end

		ply:SetPos(table.Random(all_possible_spawns))
	end
end

function default_support_spawn_human(ply)
	ply:SetHealth(20)

	ply.br_times_support_respawned = ply.br_times_support_respawned + 1
	for i=1, math.Clamp(ply.br_times_support_respawned, 0, 3) do
		ply.br_sanity = ply.br_sanity - 20
	end

	ply.charid = BR_GetUniqueCharID()
	ply:SetNWInt("BR_CharID", ply.charid)

	teleportToSpawnpoint(ply)

	notepad_system.AssignNewNotepad(ply, false)
	notepad_system.UpdateNotepad(ply)
end

net.Receive("br_support_spawn", function(len, ply)
	if ply:IsSpectator() and CurTime() - ply.DeathTime > 30 then
		local support_spawn = net.ReadString()

		for k,v in pairs(ply.br_support_spawns) do
			if v[1] == support_spawn then
				if v[2] > 0 then
					v[2] = v[2] - 1
					devprint(ply:Nick() .. " support spawned")
					ply:SendLua('surface.PlaySound("breach2/save3.ogg")')
					ply.support_spawning = true
					ply.br_times_support_respawned = ply.br_times_support_respawned + 1
					ply.retrievingNotes = false

					if support_spawn == "researcher" then
						ply.dont_assign_items = true
						assign_system.Assign_Researcher(ply)
						ply.br_team = TEAM_RESEARCHER
						default_support_spawn_human(ply)
						ply:Give("keycard_level1")
			
					elseif support_spawn == "class_d" then
						ply.dont_assign_items = true
						ply.retrievingNotes = false
						assign_system.Assign_ClassD(ply)
						ply.br_team = TEAM_CLASSD
						default_support_spawn_human(ply)

					elseif support_spawn == "scp_049_2" then
						ply.br_spawn_groups = table.Copy(MAPCONFIG)["SPAWNS_HCZ"]
						ply.dont_assign_items = true
						ply.retrievingNotes = false
						assign_system.Assign_SCP0492(ply)
						ply.br_team = TEAM_SCP
						teleportToSpawnpoint(ply)
						ply.charid = BR_GetUniqueCharID()
						ply:SetNWInt("BR_CharID", ply.charid)

					elseif support_spawn == "doctor" then
						ply.dont_assign_items = true
						ply.retrievingNotes = false
						assign_system.Assign_Doctor(ply)
						ply.br_team = TEAM_MINORSTAFF
						default_support_spawn_human(ply)

					elseif support_spawn == "janitor" then
						ply.dont_assign_items = true
						ply.retrievingNotes = false
						assign_system.Assign_Janitor(ply)
						ply.br_team = TEAM_MINORSTAFF
						default_support_spawn_human(ply)

					elseif support_spawn == "explorer" then
						ply.dont_assign_items = false
						ply.retrievingNotes = false
						assign_system.Assign_ClassD9341(ply)
						ply.br_team = TEAM_CLASSD
						default_support_spawn_human(ply)
						ply:Give("keycard_omni")
						ply:Give("item_nvg_military")
						ply:Give("kanade_tfa_mp5k")
						ply:Give("kanade_tfa_glock")
						ply:Give("kanade_tfa_rpg")
						ply:SetAmmo(120, "pistol")
						ply:SetAmmo(360, "smg1")
					end

					if support_spawn != "explorer" then
						ply:AddSanity(-10 * ply.br_times_support_respawned)
					end

					ply:AddRunStamina(-10000)
					ply:SetFOV(160, 0)
					ply:SetFOV(DEF_FOV, 2)
					ply.support_spawning = false

					BroadcastPlayerUnknownInfo(ply)

					for k2,mtf_team in pairs(BR2_MTF_TEAMS) do
						for k3,mtf in pairs(mtf_team) do
							if mtf == ply then
								table.RemoveByValue(mtf_team, ply)
							end
						end
					end
					
					hook.Call("BR2_SupportSpawned", GAMEMODE, ply)
				else
					return
				end

				return
			end
		end
	end
end)

print("[Breach2] server/networking/net_supports.lua loaded!")

