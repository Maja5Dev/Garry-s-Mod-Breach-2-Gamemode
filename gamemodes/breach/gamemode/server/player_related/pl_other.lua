
local player_meta = FindMetaTable("Player")

function player_meta:HasSpecialItem(class_name)
	for k,v in pairs(self.br_special_items) do
		if v.class == class_name then
			return true
		end
	end

	return false
end

function player_meta:BR_SetColor(color)
	self:SetPlayerColor(Vector(color.r / 255, color.g / 255, color.b / 255))
end

function player_meta:FormInfo(ply)
	local info = {}

	info["br_role"] = self.br_role

	local sendteam = self.br_team

	if ply and self.br_team == TEAM_CI and ply.br_ci_agent == true and self.br_team == TEAM_CI then
		sendteam = TEAM_RESEARCHER
	end

	info["br_team"] = sendteam

	if ply and ply.br_team == TEAM_CI and self.br_ci_agent == true then
		info["br_ci_agent"] = true
	else
		info["br_ci_agent"] = false
	end

	if isstring(self.br_showname) then
		info["br_showname"] = self.br_showname
	end

	return info
end

function player_meta:GetKeycardLevel()
	local wep = self:GetActiveWeapon()
	if IsValid(wep) then
		if wep.clevel != nil then
			return wep.clevel, true
		end
	end
	return 0, false
end

function player_meta:FirstSetup()
	self.br_role = "Unknown"
	self.br_team = nil
	self.br_showname = nil
	self.br_sanity = 100
	self.br_usesSanity = false
	self.br_isBleeding = false
	self.isTheOne = false
	self.dont_assign_items = false
	self:SetNoDraw(true)

	local disonnected_info = round_system.disconnected_players[self:SteamID64()]

	if disonnected_info != nil and istable(disonnected_info.br_support_spawns) then
		self.br_support_spawns = disonnected_info.br_support_spawns
	else
		self.br_support_spawns = {}
	end

	self.support_spawning = false
	self.br_times_support_respawned = 0
	self.br_downed = false
	self:SetTeam(TEAM_UNASSIGNED)

	self.next_re_vote_change = 0
	self.terminal_delay = 0
	self.nextSanityCheck = 0
	self.nextJumpChange = 0
	self.nextBleed = 0
	self.charid = 0
	self.nextNormalRun = 0
	self.CrippledStamina = 0
	self.nextBreath = 0
	self.next_sanity_update = 0
	self.br_temperature = 0
	self.nextBTerminal = 0
	self.next_hiding = 0
	self.nextSupportSpawnUpdate = 0
	--self.next_mtf_team_update = self.next_mtf_team_update or 0
end

function player_meta:GetAmmoItems()
	local ret = {}

	for i, v in pairs(self:GetAmmo()) do
		local ammo_amount = v
		local attempt = 1

		while(ammo_amount > 0 and attempt < 50) do
			local best_fit = nil

			for k, item in pairs(BR2_SPECIAL_ITEMS) do
				if istable(item.ammo_info) and item.ammo_info[1] == game.GetAmmoName(i) and ammo_amount >= item.ammo_info[2] then
					if (best_fit == nil) or (item.ammo_info[2] > best_fit.ammo_info[2]) then
						best_fit = item
					end
				end
			end

			if best_fit != nil then
				for i=1, math.Round(v / best_fit.ammo_info[2]) do -- less attempts
					if ammo_amount >= best_fit.ammo_info[2] then
						ammo_amount = ammo_amount - best_fit.ammo_info[2]
						--print("added " .. best_fit.class .. " to " .. self:Nick() .. "'s loot ", ammo_amount)
						table.ForceInsert(ret, {class = best_fit.class, ammo = 0, name = best_fit.name})
					end
				end
			end

			if (ammo_amount < 10) or (best_fit == nil) then break end
			attempt = attempt + 1
		end
		--print(game.GetAmmoName(i), "attempts: " .. attempt)
	end
	return ret
end

function player_meta:StripPlayer()
	self:RemoveAllAmmo()
	self:StripWeapons()
end

function player_meta:Reset_SNPC_Stuff()
	self:SetNWBool("SCP_HasNightvision",false)
	self:SetNWBool("SCP_IsBeingDrained",false)
	self:SetNWBool("SCP_Has178",false)
	self:SetNWBool("SCP_895Horror",false)
	self:SetNWString("SCP_895HorrorID",nil)
	self:SetNWBool("SCP_IsBlinking",false)
	self:SetNWBool("SCP_Touched1123",false)
	self:SetNWBool("SCP_Touched1123_Horror",false)
	self:SetNWInt("SCP_BlinkTime",CurTime() +math.random(4,7))
	self:SetNWInt("SCP_LastBlinkAmount",0)

	self.SCP_Infected_008 = false
	self.SCP_Infected_049 = false
	self.SCP_Inflicted_1048a = false
	self.SCP_Disease_LungCancer = false
	self.SCP_Disease_Appendicitis = false
	self.SCP_Disease_CommonCold = false
	self.SCP_Disease_Chickenpox = false
	self.SCP_Disease_Asthma = false
	self.SCP_Disease_CardiacArrest = false
	self.SCP_Has714 = false
	self.SCP_Has427 = false
	self.SCP_Has005 = false
	self.SCP_NextUse1123T = CurTime()
	self.SCP_Using420 = false
	self.CPTBase_SCP_Zombie = NULL
	self.SCP_SpawnedZombieEntity = false

	self.Faction = "FACTION_PLAYER"
	self:SetNWString("CPTBase_NPCFaction", "FACTION_PLAYER")
end

function player_meta:DropCurrentWeapon(set_vel)
	local wep = self:GetActiveWeapon()
	if IsValid(wep) and wep.Pickupable != false then
		self:DropWep(wep, set_vel)
	end
end

function player_meta:DropWep(wep, set_vel)
	if isfunction(wep.CustomDrop) then
		wep:CustomDrop(self)
		return
	end

	/*
	if set_vel == true then
		self:DropWeapon(wep)
		self:ConCommand("lastinv")
		return
	end
	*/

	local dropped_ent = ents.Create(wep:GetClass())
	if IsValid(dropped_ent) then
		--dropped_ent:SetPos(self:GetPos() + Vector(0,0,40))
		local tr = util.TraceLine({
			start = self:EyePos(),
			endpos = self:EyePos() + (self:EyeAngles():Forward() * 30),
			filter = self
		})

		if tr.Hit == false then
			dropped_ent:SetPos(tr.HitPos)
		else
			dropped_ent:SetPos(self:EyePos())
		end

		dropped_ent:SetAngles(Angle(-10, self:EyeAngles().yaw, 0))
		dropped_ent:Spawn()

		if wep.Clip1 and wep:Clip1() > 0 then
			dropped_ent:SetClip1(wep:Clip1())
		else
			dropped_ent:SetClip1(0)
		end

		dropped_ent:SetNWBool("isDropped", true)
		
		if set_vel == true then
			local phys = dropped_ent:GetPhysicsObject()
			if IsValid(phys) then
				phys:SetMass(5)
				phys:ApplyForceCenter(self:EyeAngles():Forward() * 1000)
				phys:EnableGravity(true)
				phys:SetDamping(0, 0)
			end
		end
		
		dropped_ent:SetGravity(1)
		
		if isfunction(wep.SaveVariablesTo) then
			wep:SaveVariablesTo(dropped_ent)
		end

		self.lastDroppedWeapon = {dropped_ent, CurTime()}
		self:StripWeapon(wep:GetClass())
	end
end

function player_meta:BleedEffect()
	local pos = self:GetPos()
	BroadcastLua('BleedingEffect(Vector('..pos.x..', '..pos.y..', '..pos.z..'))')
	self:EmitSound("breach2/D9341/BloodDrip"..math.random(0,3)..".ogg")
end

function player_meta:ForceRemoveFlashlight()
	if IsValid(self.flashlight3d) then
		self.flashlight3d:Remove()
	end
	self.flashlightEnabled = false
end

function player_meta:ForceUseFlashlight(fl)
	if IsValid(self.flashlight3d) then
		self.flashlight3d:Remove()
	end

	if self.flashlightEnabled == false then
		self.flashlight3d = ents.Create("env_projectedtexture")
		fl.on_use(self)
		self:SetNWEntity("flashlight3d", self.flashlight3d)
	end

	if self.flashlightEnabled then
		self:EmitSound(fl.sound_off)
	else
		self:EmitSound(fl.sound_on)
	end


	self.flashlightEnabled = !self.flashlightEnabled
end

function player_meta:HasAnyGasmasksOn()
	local has_gasmask = false
	local outfit = self:GetOutfit()

	if outfit != nil and outfit.has_gasmask == true then
		has_gasmask = true
	end

	for _,wep in pairs(self:GetWeapons()) do
		if wep.GasMaskOn == true then
			has_gasmask = true
		end
	end
	
	return has_gasmask
end

function player_meta:TeleportToPD()
	local pos = table.Random(MAPCONFIG.POCKETDIMENSION_SPAWNS)
	self:SetPos(pos)
	self:SetEyeAngles(Angle(0,math.random(-179,179),0))
	self:SendLua("GotTeleportedToPD()")
end

function player_meta:PreGameSpawns()
	--self.br_support_spawns = {{"class_d", 1}, {"janitor", 1}, {"doctor", 1}, {"researcher", 1}}
	self.br_support_spawns = {{"explorer", 10}}
	self.br_support_team = SUPPORT_FOUNDATION

	self.DeathTime = CurTime() - 20

	net.Start("br_pregame_spawns")
		net.WriteTable(self.br_support_spawns)
	net.Send(self)
end

function player_meta:GetLightLevel()
	net.Start("br_getlightlevel")
	net.Send(self)
end

function player_meta:IsInLowLight()
	return self.lightLevel and self.lightLevel < 0.5
end

print("[Breach2] server/player_related/pl_other.lua loaded!")