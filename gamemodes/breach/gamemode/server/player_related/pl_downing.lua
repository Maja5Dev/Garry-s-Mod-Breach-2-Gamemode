
local player_meta = FindMetaTable("Player")

function player_meta:IsDowned()
	if self.br_downed == nil then
		self.br_downed = false
	end
	return self.br_downed
end

function player_meta:SetDowned(dmginfo)
	self:ForceRemoveFlashlight()
	self:DropCurrentWeapon()

	local attacker = dmginfo:GetAttacker()
	self.lastPlayerInfo = self:CopyPlayerInfo(attacker)
	CreateRagdollPL(self, attacker, dmginfo:GetDamageType(), self:GetPos():Distance(attacker:GetPos()))

	self:StripPlayer()
	self:Freeze(true)
	self:SetWalkSpeed(0)
	self:SetRunSpeed(0)
	self:SetJumpPower(0)
	self:SetNoDraw(true)
	self:SetMoveType(MOVETYPE_NONE)
	self:AddFlags(FL_NOTARGET)
	self.br_downed = true

	self:EmitSound("breach2/player/breathe1.wav")

	net.Start("br_player_downed")
	net.Send(self)

	devprint(self:Nick() .. " downed")
end

function player_meta:Test_SetDowned()
	local info = DamageInfo()
	info:SetAttacker(self)
	info:SetInflictor(self)
	info:SetDamage(4)
	self:SetDowned(info)
end

function player_meta:UnDownPlayer(healer)
	local rag_pos = self.Body:GetPos()
	if self.lastPlayerInfo then
		self:ApplyPlayerInfo(self.lastPlayerInfo)
		--PrintTable(self.lastPlayerInfo)
		self:SetHealth(math.Clamp(self.lastPlayerInfo.PlayerHealth * 0.5, 1, self:GetMaxHealth()))
	end
	
	self:Freeze(false)
	self:SetMoveType(MOVETYPE_WALK)
	self:SetNoDraw(false)
	self:UnSpectate()
	self:Spawn()
	self:SetPos(rag_pos)
	self:RemoveFlags(FL_NOTARGET)
	self:SetModel(self.Body:GetModel())

	local pos = rag_pos
	if not util.IsInWorld(pos) then
		pos = healer:GetPos()
	else
		-- double check with hull
		local tr_check = util.TraceHull({
			start = pos,
			endpos = pos,
			mask = MASK_PLAYERSOLID,
			filter = {self, self.Body, healer},
			mins = Vector(-16,-16,0),
			maxs = Vector(16,16,72)
		})
		if tr_check.Hit then
			pos = healer:GetPos()
		end
	end

	self:SetPos(pos)

	self:AddSanity(-20)
	self:AddTemperature(-200)

	--print("health before: " .. tostring(self.lastPlayerInfo.PlayerHealth))
	--print("health after: " .. tostring(self:Health()))
	if IsValid(self.Body) then
		self.Body:Remove()
	end

	self.br_downed = false
	self.lastPlayerInfo = nil
end

print("[Breach2] server/player_related/pl_downing.lua loaded!")
