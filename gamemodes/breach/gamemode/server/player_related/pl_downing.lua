
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
	self.br_downed = true
	net.Start("br_player_downed")
	net.Send(self)
	print(self:Nick() .. " downed")
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

	local tr_test = util.TraceLine({
		start = rag_pos,
		endpos = rag_pos + Angle(-90,0,0):Forward() * 100,
		mask = MASK_SOLID,
		filter = {self, self.Body, healer}
	})

	if tr_test.Hit then
		self:SetPos(healer:GetPos())
	else
		self:SetPos(rag_pos)
	end

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

local function FindClearSpawnPos(origin, ply, radius, step, max_attempts)
    radius = radius or 32
    step = step or 16
    max_attempts = max_attempts or 10

    local mins = ply:OBBMins()
    local maxs = ply:OBBMaxs()

    for i = 0, max_attempts do
        local offset = VectorRand():GetNormalized() * (radius + i * step)
        local pos = origin + offset
        local tr = util.TraceHull({
            start = pos,
            endpos = pos,
            mins = mins,
            maxs = maxs,
            mask = MASK_PLAYERSOLID,
            filter = ply
        })
        if not tr.Hit then
            return pos
        end
    end

    return origin -- fallback, no empty spot found
end

function player_meta:UnDownPlayerAsZombie(healer)
	self.DefaultWeapons = {"weapon_scp_049_2"}
	self.br_special_items = table.Copy(self.Body.Info.Loot)
	self.Body.Info.Loot = {}

	local rag_pos = self.Body:GetPos()
	local lpi = self.lastPlayerInfo

	if lpi then
		lpi.PlayerTeam = TEAM_SCP
		lpi.BreachRole = "SCP-049-2"
		lpi.PlayerHealth = 200
		lpi.PlayerMaxHealth = 200
		lpi.PlayerWalkSpeed = 100
		lpi.PlayerRunSpeed = 180
		lpi.PlayerJumpPower = 170
		lpi.BreachCIAgent = false
		lpi.BreachZombie = true
		lpi.BreachIsBleeding = false
		lpi.can_get_infected = false
		lpi.disable_coughing = true
		self:ApplyPlayerInfo(lpi)
	end

	net.Start("br_update_own_info")
		net.WriteString(self.br_showname)
		net.WriteString(lpi.BreachRole)
		net.WriteBool(false)
		net.WriteBool(true)
	net.Send(self)

	self:Freeze(false)
	self:SetMoveType(MOVETYPE_WALK)
	self:SetNoDraw(false)
	self:UnSpectate()
	self:Spawn()

	local spawn_pos = rag_pos
	if IsValid(healer) then
		spawn_pos = FindClearSpawnPos(rag_pos, healer, 32, 16, 10)
	end
	self:SetPos(spawn_pos)
	
	if IsValid(self.Body) then
		self.Body:Remove()
	end
	self.br_downed = false
	self.lastPlayerInfo = nil
end

print("[Breach2] server/player_related/pl_downing.lua loaded!")
