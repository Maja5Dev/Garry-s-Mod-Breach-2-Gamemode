
function BR_CheckRagdollPositions()
	for i,v in ipairs(MAPCONFIG.STARTING_CORPSES) do
		local ragdoll_pos = nil

		-- legacy setup
		if isvector(v.ragdoll_pos) then
			ragdoll_pos = v.ragdoll_pos
		end

		-- new setup
		if istable(v.positions) then
			ragdoll_pos = table.Random(v.positions).ragdoll_pos
		end

		if ragdoll_pos == nil then
			ErrorNoHaltWithStack("Corpse " .. i .. " doesn't have a position")
		end

		local tr = util.TraceLine({
			start = ragdoll_pos,
			endpos = ragdoll_pos + Vector(0,0,1)
		})

		if tr.Hit and tr.HitWorld then
			ErrorNoHalt("Corpse in wall position " .. tostring(ragdoll_pos) .. " for model " .. v.model)
		end
	end
end

function BR_DEFAULT_MAP_Organize_Corpses()
	BR_CheckRagdollPositions()

	if istable(MAPCONFIG.STARTING_CORPSES) and round_system.current_scenario.fake_corpses == true then
		local all_corpses = table.Copy(MAPCONFIG.STARTING_CORPSES)
		local corpse_infos = {}

		for i=1, MAPCONFIG.Starting_Corpses_Number() do
			local random_corpse = table.Random(all_corpses)
			table.ForceInsert(corpse_infos, random_corpse)
			table.RemoveByValue(all_corpses, random_corpse)
		end
		
		for i,corpse in ipairs(corpse_infos) do
			local rag = ents.Create("prop_ragdoll")

			if IsValid(rag) then
				local ragdoll_pos = nil

				-- legacy setup
				if isvector(corpse.ragdoll_pos) then
					ragdoll_pos = corpse.ragdoll_pos
				end

				-- new setup
				if istable(corpse.positions) then
					local random_pos = table.Random(corpse.positions)
					ragdoll_pos = random_pos.ragdoll_pos
				end

				rag.IsStartingCorpse = true

				rag:SetModel(corpse.model)
				rag:SetPos(ragdoll_pos)
				rag:Spawn()

				ApplyCorpseInfo(rag, corpse, true)

				rag.CInfo = corpse
				rag.Info = {}
				rag.Info.CorpseID = rag:GetCreationID()
				rag.Info.Victim = NULL
				rag.Info.br_showname = nil
				rag.Info.DamageType = DMG_GENERIC
				rag.Info.Time = CurTime() - math.random(20,1400)
				rag.RagdollHealth = 0
				rag.nextReviveMove = 0

				rag:SetNWInt("DeathTime", rag.Info.Time)
				rag:SetNWString("ExamineDmgInfo", " - Cause of death is unknown")

				-- Add loot
				rag.Info.Loot = {}
				if istable(corpse.items) then
					for k2,v2 in pairs(corpse.items) do
						if istable(v2) then
							table.ForceInsert(rag.Info.Loot, form_basic_item_info(table.Random(v2)))

						elseif isstring(v2) then
							table.ForceInsert(rag.Info.Loot, form_basic_item_info(v2))
						end
					end
				end
				
				-- Setup function, usually for role, showname, team
				if isfunction(corpse.setup) then
					corpse.setup(rag)

					if istable(all_fake_corpses) then
						table.ForceInsert(all_fake_corpses, rag)
						rag.Info.notepad = {}
						rag.Info.notepad.people = {
							{
								br_ci_agent = rag.br_ci_agent,
								br_role = rag.br_role,
								br_showname = rag.br_showname,
								health = HEALTH_ALIVE,
								scp = false
							}
						}
					end
				end
			end
		end
	end

	timer.Create("BR2_Mapconfig_SetupRagdollBones", 4, 1, function()
		for k,v in pairs(ents.FindByClass("prop_ragdoll")) do
			if v.IsStartingCorpse then
				for i=0, (v:GetPhysicsObjectCount() - 1) do
					local bone = v:GetPhysicsObjectNum(i)

					if IsValid(bone) then
						bone:EnableMotion(true)
					end
				end
			end
		end
 	end)
end
