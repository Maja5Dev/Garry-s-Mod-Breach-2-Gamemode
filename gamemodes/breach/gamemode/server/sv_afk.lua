
local function HandleAfks()
	for k,v in pairs(player.GetAll()) do
		if v:Alive() and !v:IsSpectator() and !v:IsDowned() and v:GetVelocity():Length() < 15 then
			if v.br_afk_time == nil then
				v.br_afk_time = CurTime()
			end

			-- AFK damage
			v.nextAFKDamage = v.nextAFKDamage or 0
			if v.nextAFKDamage < CurTime() then
				if v:AfkTime() > 60 then
					v.nextAFKDamage = CurTime() + 2

					if v:Health() < 2 then
						local fdmginfo = DamageInfo()
						fdmginfo:SetDamage(20)
						fdmginfo:SetAttacker(v)
						fdmginfo:SetDamageType(DMG_PARALYZE)
						v:TakeDamageInfo(fdmginfo)
					else
						v:SetHealth(v:Health() - 1)
					end
				else
					v.nextAFKDamage = CurTime() + 5
				end
			end
		else
			v.br_afk_time = nil
		end
	end
end
hook.Add("Tick", "BR2_HandleAfks", HandleAfks)

local player_meta = FindMetaTable("Player")
function player_meta:AfkTime()
	if self.br_afk_time == nil then return 0 end
	return math.Round(CurTime() - self.br_afk_time)
end

print("[Breach2] server/sv_afk.lua loaded!")
