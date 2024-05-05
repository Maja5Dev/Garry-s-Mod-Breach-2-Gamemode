
local player_meta = FindMetaTable("Player")

function player_meta:GetInfected(pl)
	self.next_iup2 = CurTime() + math.random(15,35)
	self.br_isInfected = true
	print(self:Nick() .. " got infected by " .. pl:Nick())
	PrintMessage(HUD_PRINTTALK, self:Nick() .. " got infected by " .. pl:Nick())
end

function player_meta:InfectiousTouch()
	if math.random(1,4) == 2 then
		local possibles = {}
		for k,v in pairs(player.GetAll()) do
			if v:Alive() and !v:IsSpectator() and v.canGetInfected and !v.br_isInfected and math.random(1,3) == 2 then
				local tr = util.TraceLine({
					start = self:EyePos(),
					endpos = v:GetPos(),
					filter = self
				})
				if v:GetPos():Distance(self:GetPos()) < 80 and tr.Entity == v then
					table.ForceInsert(possibles, v)
				end
			end
		end
		if table.Count(possibles) > 0 then
			table.Random(possibles):GetInfected(self)
		end
	end
end

function player_meta:InfectiousCough()
	local closest_player = nil
	for k,v in pairs(player.GetAll()) do
		if v:Alive() and !v:IsSpectator() and v.canGetInfected and !v.br_isInfected then
			local ipos = self:GetShootPos() + (self:EyeAngles():Forward() * 10)
			local idis = v:GetPos():Distance(ipos)
			if math.random(1,100) < 80 and idis < 90 and !v:HasAnyGasmasksOn() then
				if closest_player == nil or closest_player[2] > idis then
					closest_player = {v, idis}
				end
			end
		end
	end
	if closest_player then
		closest_player[1]:GetInfected(self)
	end
end

print("[Breach2] server/player_related/pl_infection.lua loaded!")
