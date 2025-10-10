
br_last_char_id_used = 0
function BR_GetUniqueCharID()
	local highest_char_id = br_last_char_id_used

	for i,v in ipairs(player.GetAll()) do
		if v.charid > highest_char_id then
			highest_char_id = v.charid
		end
	end

	if highest_char_id > 500000000 then
		highest_char_id = 0
	end

	br_last_char_id_used = br_last_char_id_used + 1

	return (highest_char_id + 1)
end

function C4BombExplode(ent, radius, damage, ply)
	local effect = EffectData()
	effect:SetStart(ent:GetPos())
	effect:SetOrigin(ent:GetPos())
	effect:SetScale(200)
	effect:SetRadius(200)
	effect:SetMagnitude(0)
	effect:SetDamageType(DMG_BLAST)
	
	for k,v in pairs(ents.FindInSphere(ent:GetPos(), radius)) do
		if v:IsPlayer() and v:Alive() and v:IsSpectator() == false then
			local endpos = v:GetPos()
			local endent = v
			local dmgmul = 1

			if v:IsDowned() then
				endpos = v.Body:GetPos()
				endent = v.Body
			end

			if v.br_role == ROLE_SCP_173 and IsValid(v.entity173) then
				endpos = v.entity173:GetPos()
				endent = v.entity173
				dmgmul = 2
			end

			local filters = {ent}

			if ent:GetClass() == "item_c4" then
				table.ForceInsert(filters, ply)
			end

			for k2,v2 in pairs(player.GetAll()) do
				if v != v2 then
					table.ForceInsert(filters, v2)
				end
			end

			local tr = util.TraceLine({
				start = ent:GetPos(),
				endpos = endpos,
				filter = filters,
			})
			
			if IsValid(tr.Entity) and (
				tr.Entity == endent
				or (isfunction(tr.Entity.GetOwner) and tr.Entity:GetOwner() == v))
			then
				local damage = math.Clamp((damage - math.Round(v:GetPos():Distance(ent:GetPos()) / 1.75)) * dmgmul, 1, 500)

				local dmginfo = DamageInfo()
				dmginfo:SetDamage(damage)
				dmginfo:SetAttacker(ply)
				dmginfo:SetInflictor(ent)
				dmginfo:SetDamageType(DMG_BLAST)

				endent:SetVelocity((endent:GetPos() - ent:GetPos()):Angle():Forward() * 400)
				endent:TakeDamageInfo(dmginfo)
			end
		end
	end

	if ent:GetClass() == "item_c4" then
		local dmginfo = DamageInfo()
		dmginfo:SetDamage(damage)
		dmginfo:SetAttacker(ply)
		dmginfo:SetInflictor(ent)
		dmginfo:SetDamageType(DMG_BLAST)

		v:SetVelocity((v:GetPos() - ent:GetPos()):Angle():Forward() * 400)
		v:TakeDamageInfo(dmginfo)
	end
	
	util.Effect("Explosion", effect, true, true)
	util.Effect("HelicopterMegaBomb", effect, true, true)
end

local function reapply_body_info(ent, new)
	new.Info = table.Copy(ent.Info)
	new.RagdollHealth = ent.RagdollHealth
	new.nextReviveMove = ent.nextReviveMove

	if ent.CInfo then
		new.CInfo = table.Copy(ent.CInfo)
	end
	if ent.IsStartingCorpse then
		new.IsStartingCorpse = ent.IsStartingCorpse
	end
	if ent.Info.Time then
		new:SetNWInt("DeathTime", ent.Info.Time)
	end
	new:SetNWString("ExamineDmgInfo", ent:GetNWString("ExamineDmgInfo", ""))

	for k,v in pairs(player.GetAll()) do
		if v.Body == ent then
			v.Body = new
		end

		if v.retrievingNotes == ent then
			v.retrievingNotes = new
		end
	end
end

function BR2_ReplaceRagdollModel(ent, model, skin, ply)
	local bone_positions = {}

	for i = 0, ent:GetPhysicsObjectCount() - 1 do
		local bone = ent:GetPhysicsObjectNum(i)

		if IsValid(bone) then
			bone:EnableMotion(false)
			bone:SetVelocity(Vector(0,0,0))

			bone_positions[i] = {
				pos = bone:GetPos(),
				ang = bone:GetAngles()
			}
		end
	end

	local pos = ent:GetPos() + Vector(0,0,10)
	local ang = ent:GetAngles()
	ent:Remove()

	local new = ents.Create("prop_ragdoll")

	new.blockPhysicsDamageFor = CurTime() + 2

	reapply_body_info(ent, new)

	new:SetModel(model)
	new:SetSkin(skin)

	new:SetPos(pos)
	new:SetAngles(ang)

	if IsValid(ply) then
		for i = 0, ply:GetNumBodyGroups() - 1 do
			new:SetBodygroup(i, ply:GetBodygroup(i))
		end
	end

	new:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)
	new:Spawn()
	new:Activate()

	for i = 0, new:GetPhysicsObjectCount() - 1 do
		local bone = new:GetPhysicsObjectNum(i)
		if IsValid(bone) and bone_positions[i] then
			bone:SetPos(bone_positions[i].pos)
			bone:SetAngles(bone_positions[i].ang)

			bone:EnableMotion(false)
			bone:SetVelocity(Vector(0,0,0))
		end
	end

	timer.Simple(0, function()
		if IsValid(new) then
			new:SetCollisionGroup(COLLISION_GROUP_DEBRIS_TRIGGER)
			new:CollisionRulesChanged()

			for i = 0, new:GetPhysicsObjectCount() - 1 do
				local bone = new:GetPhysicsObjectNum(i)

				if IsValid(bone) then
					bone:EnableMotion(true)
					bone:Wake()
					bone:SetVelocity(Vector(0,0,0))
				end
			end
		end
	end)
end

print("[Breach2] server/sv_misc.lua loaded!")
