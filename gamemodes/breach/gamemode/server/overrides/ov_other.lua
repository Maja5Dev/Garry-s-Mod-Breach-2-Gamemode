

function GM:PlayerSetHandsModel(ply, ent)
	local simplemodel = player_manager.TranslateToPlayerModelName(ply:GetModel())
	local info = player_manager.TranslatePlayerHands(simplemodel)
	
	if ply.br_hands != nil then
		ent:SetModel(ply.br_hands.mdl)
		if ply.br_hands.skin then
			ent:SetSkin(ply.br_hands.skin)
		end
		if ply.br_hands.bgroups then
			ent:SetBodyGroups(ply.br_hands.bgroups)
		end
		return
	end
	
	if info then
		ent:SetModel(info.model)
		ent:SetSkin(0)
		ent:SetBodyGroups(0)
	end
end

function GM:IsSpawnpointSuitable(ply, spawnpointent, bMakeSuitable)
	local Pos = spawnpointent:GetPos()
	local Ents = ents.FindInBox(Pos + Vector(-16, -16, 0), Pos + Vector(16, 16, 72))

	if (ply:Team() == TEAM_SPECTATOR or ply:Team() == TEAM_UNASSIGNED) then return true end

	local Blockers = 0

	for k,v in pairs(Ents) do
		if IsValid(v) and v:IsPlayer() and v:Alive() then
			Blockers = Blockers + 1
		end
	end

	if bMakeSuitable then return true end
	if Blockers > 0 then return false end
	return true

end

function GM:EntityTakeDamage(ent, dmginfo)
	--PLAYER RAGDOLL
	if istable(ent.Info) and isnumber(ent.RagdollHealth) then
		if IsValid(ent.Info.Victim) then
			if ent.Info.Victim:IsPlayer() and ent.Info.Victim:IsDowned() == true and ent.RagdollHealth > 0 then
				ent.RagdollHealth = ent.RagdollHealth - dmginfo:GetDamage()
				if ent.RagdollHealth < 1 then
					local pl = ent.Info.Victim
					pl:Freeze(false)
					pl:KillSilent()
					--pl:Kill()
					if pl.isTheOne == true then
						pl:SendLua('surface.PlaySound("breach2/save1.ogg")')
					end
					pl.LastBody = ent.Info.Victim.Body
					pl.Body = nil
					for k,v in pairs(player.GetAll()) do
						if istable(v.startedReviving) and v.startedReviving[1] == ent then
							v.startedReviving = nil
						end
					end
					--ent.Info = nil
				end
			end
		end
	end
	return false
end

function GM:PlayerDisconnected(ply)
	ply:ForceRemoveFlashlight()

	for k,v in pairs(BR2_MTF_TEAMS) do
		for k2,v2 in pairs(v) do
			if v2 == ply then
				table.RemoveByValue(v, ply)
			end
		end
	end
	if ply:Alive() and ply:IsSpectator() == false and ply.br_downed == false then
		CreateRagdollPL(ply, ply, DMG_PARALYZE, 0)
	end
end

function GM:PlayerSwitchFlashlight(ply, enabled)
	if !ply:Alive() or ply:IsSpectator() or ply.nextFlashlightUse > CurTime() or ply.cantUseFlashlight then return false end

	ply.nextFlashlightUse = CurTime() + 0.25

	local best_flashlight = nil
	for k,v in pairs(ply.br_special_items) do
		for k2,v2 in pairs(BR2_FLASHLIGHT_TYPES) do
			if v.class == v2.class then
				if best_flashlight == nil or best_flashlight.level < v2.level then
					best_flashlight = v2
				end
			end
		end
	end
	if best_flashlight == nil then return false end
	ply:ForceUseFlashlight(best_flashlight)

	return false
end

function GM:PlayerSpray(ply)
	local sprays_enabled = GetConVar("br2_enable_sprays"):GetBool()
	if sprays_enabled == false then
		return true
	end
	return ply:IsSpectator()
end

function GM:GetFallDamage(ply, speed)
	if ply.br_role == "SCP-173" then return 0 end
	return (speed / 9)
end

print("[Breach2] server/overrides/ov_other.lua loaded!")
