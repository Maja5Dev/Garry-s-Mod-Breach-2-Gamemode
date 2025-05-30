
local player_meta = FindMetaTable("Player")

function player_meta:SendPlayerInfo(ply)
	local info = ply:FormInfo(self)
	if istable(info) then
		bprint("sending pinfo to: " .. self:Nick())
		net.Start("br_send_info")
			net.WriteTable(info)
			net.WriteEntity(ply)
		net.Send(self)
	end
end

function player_meta:CopyPlayerInfo(attacker)
	local player_info = {}
	player_info.PlayerTeam = self:Team()
	player_info.PlayerArmor = self:Armor()
	player_info.PlayerHealth = self:Health()
	player_info.PlayerMaxHealth = self:GetMaxHealth()
	player_info.PlayerWalkSpeed = self:GetWalkSpeed()
	player_info.PlayerRunSpeed = self:GetRunSpeed()
	player_info.PlayerJumpPower = self:GetJumpPower()
	player_info.PlayerMoveType = self:GetMoveType()
	player_info.PlayerNoDraw = self:GetNoDraw()
	player_info.PlayerAmmo = {}

	for k,v in pairs(self:GetWeapons()) do
		if IsValid(v) and v.GetPrimaryAmmoType then
			local ammo_type = v:GetPrimaryAmmoType()
			local ammo_amount = self:GetAmmoCount(v:GetPrimaryAmmoType())
			if ammo_amount > 0 then
				table.ForceInsert(player_info.PlayerAmmo, {ammo_type, ammo_amount})
			end
		end
	end

	if IsValid(attacker) and attacker:IsPlayer() then
		player_info.PlayerAttacker = attacker:SteamID64()
	end

	player_info.BreachShowName = self.br_showname
	player_info.BreachIsBleeding = self.br_isBleeding
	player_info.BreachSanity = self.br_sanity
	player_info.BreachTemperature = self.br_temperature

	player_info.BreachHunger = self.br_hunger
	player_info.BreachThirst = self.br_thirst

	player_info.BreachHands = self.br_hands
	player_info.BreachCustomSpawn = self.br_customspawn
	player_info.BreachRole = self.br_role
	player_info.BreachCIAgent = self.br_ci_agent
	player_info.BreachZombie = self.br_zombie
	player_info.BreachDowned = self.br_downed
	player_info.BreachNotepad = self.notepad
	player_info.BreachCharID = self.charid
	return player_info
end

function player_meta:ApplyPlayerInfo(player_info)
	self:SetTeam(player_info.PlayerTeam)
	self:SetArmor(player_info.PlayerArmor)
	--self:SetHealth(player_info.PlayerHealth)
	self:SetMaxHealth(player_info.PlayerMaxHealth)
	self:SetWalkSpeed(player_info.PlayerWalkSpeed)
	self:SetRunSpeed(player_info.PlayerRunSpeed)
	self:SetJumpPower(player_info.PlayerJumpPower)
	self:SetMoveType(player_info.PlayerMoveType)
	self:SetNoDraw(player_info.PlayerNoDraw)
	--for k,v in pairs(player_info.PlayerAmmo) do
	--	self:SetAmmo(v[2], v[1])
	--end
	self.br_showname = player_info.BreachShowName
	self.br_isBleeding = player_info.BreachIsBleeding
	self.br_sanity = player_info.BreachSanity
	self.br_temperature = player_info.BreachTemperature

	self.br_hunger = player_info.BreachHunger
	self.br_thirst = player_info.BreachThirst

	self.br_hands = player_info.BreachHands
	self.br_customspawn = player_info.BreachCustomSpawn
	self.br_role = player_info.BreachRole
	self.br_ci_agent = player_info.BreachCIAgent
	self.br_zombie = player_info.BreachZombie
	self.charid = player_info.BreachCharID

	if istable(self.DefaultWeapons) then
		for k,v in pairs(self.DefaultWeapons) do
			self:Give(v)
		end
	end

	if IsValid(self.Body) and istable(self.Body.Info) and istable(self.Body.Info.Loot) then
		for k,v in pairs(self.Body.Info.Loot) do
			if isstring(v.class) then

				local found_spitem = false
				for k2,v2 in pairs(BR2_SPECIAL_ITEMS) do
					if v2.class == v.class then
						--table.ForceInsert(self.br_special_items, v)
						found_spitem = true
					end
				end

				if !found_spitem then
					local wep = self:Give(v.class)
					if v.ammo and wep.SetClip1 then
						wep:SetClip1(v.ammo)
					end
				end
			end
		end
	end
	
	--NOTEPAD
	if istable(self.Body.Info.notepad) then
		notepad_system.AllNotepads[self.charid] = self.Body.Info.notepad
		notepad_system.UpdateNotepad(self)
	end
end

print("[Breach2] server/player_related/pl_info.lua loaded!")
