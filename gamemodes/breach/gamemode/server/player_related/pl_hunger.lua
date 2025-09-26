
local player_meta = FindMetaTable("Player")

function player_meta:AddHealth(amount)
	self:SetHealth(math.Clamp(self:Health() + amount, 0, self:GetMaxHealth()))
end

function player_meta:AddHunger(amount)
	self.br_hunger = math.Clamp(self.br_hunger - amount, 0, 125)
end

function player_meta:AddThirst(amount)
	self.br_thirst = math.Clamp(self.br_thirst - amount, 0, 125)
end

function player_meta:UpdateHungerThirst()
	net.Start("br_update_hunger")
		net.WriteInt(self.br_hunger, 16)
		net.WriteInt(self.br_thirst, 16)
	net.Send(self)
end

print("[Breach2] server/player_related/pl_hunger.lua loaded!")
