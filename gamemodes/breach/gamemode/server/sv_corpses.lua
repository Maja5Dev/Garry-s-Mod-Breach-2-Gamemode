
function CreateRagdollPL(victim, attacker, dmgtype, distance)
	if not IsValid(victim) then return NULL end

	local rag = ents.Create("prop_ragdoll")
	if IsValid(rag) == false then return NULL end

	rag:SetNWString("ExamineDmgInfo", " - Cause of death is unknown")

	if victim == attacker then
		--print("dmg_type", dmgtype)
		if dmgtype == DMG_CLUB then
			rag:SetNWString("ExamineDmgInfo", " - They starved to death")
		elseif dmgtype == DMG_ENERGYBEAM then
			rag:SetNWString("ExamineDmgInfo", " - They died of dehydration")
		elseif dmgtype == DMG_SLOWBURN then
			if victim.br_temperature < -400 then
				rag:SetNWString("ExamineDmgInfo", " - They froze to death")
			elseif victim.br_temperature > 400 then
				rag:SetNWString("ExamineDmgInfo", " - Extreme heat lead to their death")
			end
		elseif dmgtype == DMG_PARALYZE and victim.br_sanity < 50 then
			rag:SetNWString("ExamineDmgInfo", " - They died of despair")
		end

	elseif attacker:IsPlayer() then
		local inflictor = attacker:GetActiveWeapon()
		local item_infos = {
			kanade_tfa_beretta = " - Looks like someone killed them using a pistol",
			kanade_tfa_m1911 = " - Looks like someone killed them using a pistol",
			kanade_tfa_crowbar = " - Looks like someone killed them using a blunt melee weapon",
			kanade_tfa_stunbaton = " - Looks like someone killed them using a baton",
			kanade_tfa_knife = " - Looks like someone killed them using a sharp melee weapon",
			kanade_tfa_axe = " - Looks like someone killed them using a sharp melee weapon",
			kanade_tfa_pipe = " - Looks like someone killed them using a blunt melee weapon",
			kanade_tfa_mp5k = " - Looks like someone killed them using a submachine gun",
			kanade_tfa_mk18 = " - Looks like someone killed them using a submachine gun",
			kanade_tfa_ump45 = " - Looks like someone killed them using a submachine gun",
			kanade_tfa_m4a1 = " - Looks like someone killed them using an assault rifle",
			kanade_tfa_m16a4 = " - Looks like someone killed them using an assault rifle",
			kanade_tfa_m249 = " - Looks like someone killed them using an assault rifle",
			kanade_tfa_rpk = " - Looks like someone killed them using an assault rifle",
			kanade_tfa_m590 = " - Looks like someone killed them using a shotgun",
			br_hands = " - Looks like someone killed them in a fist-fight",
		}
		if IsValid(inflictor) and isstring(item_infos[inflictor:GetClass()]) then
			rag:SetNWString("ExamineDmgInfo", item_infos[inflictor:GetClass()])
		end
	end

	rag:SetNWInt("DeathTime", CurTime())

	victim.retrievingNotes = rag
	victim.lastRetrievingNotes = CurTime()
	net.Start("br_retrieve_own_notes")
	net.Send(victim)

	rag:SetPos(victim:GetPos())
	rag:SetModel(victim:GetModel())
	rag:SetAngles(victim:GetAngles())
	rag:SetColor(victim:GetColor())
	rag:Spawn()
	rag:Activate()
	rag.Info = {}
	rag.Info.charid = victim.charid
	rag.Info.CorpseID = rag:GetCreationID()
	rag.Info.Victim = victim
	rag.Info.VictimNick = victim:Nick()
	rag.Info.br_role = victim.br_role
	rag.Info.DamageType = dmgtype
	rag.Info.Time = CurTime()

	if istable(notepad_system.AllNotepads[victim.charid]) then
		rag.Info.notepad = table.Copy(notepad_system.AllNotepads[victim.charid])
	end

	rag.Info.Loot = {}
	for k,v in pairs(victim.br_special_items) do
		for k2,v2 in pairs(BR2_SPECIAL_ITEMS) do
			if v2.class == v.class then
				v.ammo = 0
				table.ForceInsert(rag.Info.Loot, v)
			end
		end
	end

	for k,v in pairs(victim:GetAmmoItems()) do
		table.ForceInsert(rag.Info.Loot, v)
	end

	for k,v in pairs(victim:GetWeapons()) do
		if v.Pickupable != false then
			if v.ShouldDrop == true then
				v:CustomDrop()
				continue
			end
			
			local item_info = {class = v:GetClass(), ammo = 0, name = v:GetName()}
			if isfunction(v.Clip1) and v:Clip1() > 0 then
				item_info.ammo = v:Clip1()
			end
			if v.Code != nil then
				item_info.code = v.Code
			end
			if v.BatteryLevel != nil then
				item_info.battery_level = v.BatteryLevel
			end
			if isfunction(v.GetPrintName) then
				item_info.name = v:GetPrintName()
			end
			table.ForceInsert(rag.Info.Loot, item_info)
		end
	end
	rag.RagdollHealth = 100
	rag.nextReviveMove = 0
	
	rag:SetCollisionGroup(COLLISION_GROUP_DEBRIS_TRIGGER)
	timer.Simple(1, function() if IsValid(rag) then rag:CollisionRulesChanged() end end)
	
	local num = rag:GetPhysicsObjectCount() - 1
	local v = victim:GetVelocity() * 0.35
	
	for i = 0, num do
		local bone = rag:GetPhysicsObjectNum(i)
		if IsValid(bone) then
			local bp, ba = victim:GetBonePosition(rag:TranslatePhysBoneToBone(i))
			if bp and ba then
				bone:SetPos(bp)
				bone:SetAngles(ba)
			end
			bone:SetVelocity(v)
		end
	end

	if rag:GetModel() != SCP_173_MODEL then
		victim:Spectate(OBS_MODE_IN_EYE)
		victim:SpectateEntity(rag)
	end

	victim.Body = rag
	return tag
end

function ApplyCorpseInfo(ent, info, blood)
	if IsValid(ent) and ent:GetClass() == "prop_ragdoll" then
		--if info.model then ent:SetModel(info.model) end
		ent:SetPos(info.ragdoll_pos)
		ent:SetAngles(Angle(0,0,0))
		--ent:SetVelocity(info.ragdoll_vel)
		ent:SetVelocity(Vector(0,0,0))

		local num = ent:GetPhysicsObjectCount() - 1
		for i=0, num do
			local bone = ent:GetPhysicsObjectNum(i)
			if IsValid(bone) and istable(info.bones[i]) then
				bone:SetPos(info.bones[i].pos)
				bone:SetAngles(info.bones[i].ang)
				--bone:SetVelocity(info.bones[i].vel)
				bone:SetVelocity(Vector(0,0,0))
				bone:EnableMotion(false)
			end
		end
		
		ent:SetCollisionGroup(COLLISION_GROUP_DEBRIS_TRIGGER)
		timer.Simple(1, function() if IsValid(ent) then ent:CollisionRulesChanged() end end)
	end
end

print("[Breach2] server/sv_corpses.lua loaded!")
