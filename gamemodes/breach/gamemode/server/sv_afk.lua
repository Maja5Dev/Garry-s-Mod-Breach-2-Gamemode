
local function HandleAfks()
	for k,v in pairs(player.GetAll()) do
		if v:Alive() and !v:IsSpectator() and v:GetVelocity():Length() < 15 then
			if v.br_afk_time == nil then
				v.br_afk_time = CurTime()
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
