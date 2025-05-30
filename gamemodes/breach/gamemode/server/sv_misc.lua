
function BR_GetUniqueCharID()
	local highest_char_id = 0

	for i,v in ipairs(player.GetAll()) do
		if v.charid > highest_char_id then
			highest_char_id = v.charid
		end
	end

	return (highest_char_id + 1)
end

function C4BombExplode(ent, radius, damage, ply)
	local effect = EffectData()
	effect:SetStart(ent:GetPos())
	effect:SetOrigin(ent:GetPos())
	effect:SetScale(200)
	effect:SetRadius(200)
	effect:SetMagnitude(0)
	
	for k,v in pairs(ents.FindInSphere(ent:GetPos(), radius)) do
		if v:IsPlayer() and v:Alive() and v:IsSpectator() == false then
			local filters = {}
			table.ForceInsert(filters, ent)

			if IsValid(ply) then
				table.ForceInsert(filters, ply)
			end

			local tr = util.TraceLine({
				start = ent:GetPos(),
				endpos = v:GetPos() + Vector(0,0,40),
				filter = filters
			})
			
			if tr.Entity == v then
				local num = math.Clamp(damage - math.Round(v:GetPos():Distance(ent:GetPos()) / 1.75), 1, 500)
				print("C4 blew and damaged " .. v:Nick() .. " with " .. tostring(num) .. " damage.")
				v:TakeDamage(num, ent, ent)
				v:SetVelocity((v:GetPos() - ent:GetPos()):Angle():Forward() * 600)
				--util.BlastDamage(ent, ent, v:GetPos(), 5, num)
			end
		end
	end
	
	if IsValid(ply) then
		ply:TakeDamage(damage, ply, ply)
		--util.BlastDamage(ent, ent, ply:GetPos(), 5, damage)
	end
	
	util.Effect("Explosion", effect, true, true)
	util.Effect("HelicopterMegaBomb", effect, true, true)
end

print("[Breach2] server/sv_misc.lua loaded!")
