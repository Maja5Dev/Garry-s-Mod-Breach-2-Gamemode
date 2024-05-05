
hook.Add("PostPlayerDeath", "BR2_PostPlayerDeath", function(ply)
	ply:SendLua("BR_ClearMenus()")
end)

function GM:CanPlayerSuicide(ply)
	return ply:IsSuperAdmin()
end

function GM:PlayerDeathSound()
	return true
end

function GM:DoPlayerDeath(ply, attacker, dmginfo)
	if IsValid(ply) then
		ply:ForceRemoveFlashlight()
		ply:DropCurrentWeapon()
		if ply.isTheOne == true then
			ply:SendLua('surface.PlaySound("breach2/save1.ogg")')
			return
		end
		CreateRagdollPL(ply, attacker, dmginfo:GetDamageType(), ply:GetPos():Distance(attacker:GetPos()))
		ply:AddDeaths(1)
		if IsValid(attacker) and attacker:IsPlayer() then
			if attacker == ply then
				attacker:AddFrags(-1)
			else
				attacker:AddFrags(1)
			end
		end
	end
end

function GM:PlayerDeath(ply, inflictor, attacker)
	ply.NextSpawnTime = CurTime() + 2
	ply.DeathTime = CurTime()

	ply:ForceRemoveFlashlight()

	if istable(ply.br_support_spawns) then
		net.Start("cl_playerdeath")
			net.WriteInt(CurTime() - ply.aliveTime, 16)
			net.WriteTable(ply.br_support_spawns)
		net.Send(ply)
	end

	-- FIX FOR A VERY WEIRD BUG WITH FALLING DOWN
	if ply:HasWeapon("weapon_scp_173") then
		ply:StripWeapon("weapon_scp_173")
	end
	ply:SetWalkSpeed(200)
	ply:SetRunSpeed(200)
	ply:SetJumpPower(200)
	ply:SetViewEntity(ply)
	
	if ply:HasWeapon("item_c4") then
		local wep = ply:GetWeapon("item_c4")
		local c4planted = ents.Create("br2_c4_charge")
		if IsValid(c4planted) then
			c4planted.UsePhysics = true
			c4planted:SetPos(ply:GetPos())
			c4planted:Spawn()
			c4planted:Activate()
			c4planted.isArmed = wep.isArmed
			c4planted.Activated = wep.Activated
			c4planted.Timer = wep.Timer
			if wep.nextExplode then
				c4planted.nextExplode = wep.nextExplode
			end
			c4planted:SetMoveType(MOVETYPE_VPHYSICS)
		end
		ply:StripWeapon("item_c4")
	end
	
	if IsValid(attacker) and attacker:GetClass() == "trigger_hurt" then
		attacker = ply
	end
	if IsValid(attacker) and attacker:IsVehicle() and IsValid(attacker:GetDriver()) then
		attacker = attacker:GetDriver()
	end
	if !IsValid(inflictor) and IsValid(attacker) then
		inflictor = attacker
	end
	if IsValid(inflictor) and inflictor == attacker and (inflictor:IsPlayer() or inflictor:IsNPC()) then
		inflictor = inflictor:GetActiveWeapon()
		if !IsValid(inflictor) then
			inflictor = attacker
		end
	end
	if attacker == ply then
		print(attacker:Nick() .. " suicided!")
		return
	end
	if attacker:IsPlayer() then
		local gname = inflictor.PrintName or inflictor:GetClass()
		--if gname.PrintName then
		--	gname = gname.PrintName
		--end
		print(attacker:Nick() .. " killed " .. ply:Nick() .. " using " .. gname)
	end
end

function GM:PlayerDeathThink(pl)
	if pl.NextSpawnTime and pl.NextSpawnTime > CurTime() then return end
	
	if pl.isTheOne == true then
		local old_showname = pl.br_showname
		if IsValid(pl.LastBody) then
			pl.LastBody:Remove()
		end
		pl:Spawn()
		assign_system.Assign_ClassD(pl)
		pl:SetPos(table.Random(MAPCONFIG.SPAWNS_CLASSD_CELLS))
		pl.br_showname = old_showname
		pl.isTheOne = true

		pl.br_times_support_respawned = pl.br_times_support_respawned + 1
		for i=1, math.Clamp(pl.br_times_support_respawned, 0, 4) do
			pl:AddSanity(-15)
			pl:AddHealth(-15)
		end

		return
	end
	
	--if pl:IsBot() or pl:KeyPressed(IN_ATTACK) or pl:KeyPressed(IN_ATTACK2) or pl:KeyPressed(IN_JUMP) then
		pl:SetTeam(TEAM_UNASSIGNED)
		pl:Spawn()
	--end
end

print("[Breach2] server/overrides/ov_death.lua loaded!")
