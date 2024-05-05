
local player_meta = FindMetaTable("Player")

function player_meta:SetSpectator()
	self:StripPlayer()
	self.br_role = nil
	self:SetNoDraw(true)
	self:SetNoTarget(true)
	self:SetTeam(TEAM_SPECTATOR)
	self:Spectate(OBS_MODE_ROAMING)
end

function player_meta:SpectateCamera(camera)
	self:SetViewEntity(camera)
	self.UsingCamera = camera
	camera.User = self
end

function player_meta:SpectatePlayerRight()
	if !self:Alive() then return end

	local mode = self:GetObserverMode()
	if mode != OBS_MODE_IN_EYE and mode != OBS_MODE_CHASE then return end
	local obv_target = self:GetObserverTarget()

	local all_alive = {}
	for k,v in pairs(player.GetAll()) do
		--if v:Alive() and !v:IsSpectator() and v.br_downed == false and v.br_support_team == self.br_support_team then
		if v:Alive() and !v:IsSpectator() and v.br_downed == false then
			table.ForceInsert(all_alive, v)
		end
	end
	for k,v in pairs(ents.GetAll()) do
		if table.HasValue(BR_SCP_NPC_CLASSES, v:GetClass()) then
			table.ForceInsert(all_alive, v)
		end
	end
	local new_target = all_alive[1] or self
	for i,v in ipairs(all_alive) do
		if v == obv_target then
			if all_alive[i+1] != nil then
				new_target = all_alive[i+1]
				break
			end
		end
	end
	self:SpectateEntity(new_target)
	self:SetPos(new_target:GetPos())
	--print("changing target to", new_target)

	if mode == OBS_MODE_IN_EYE then
		local obs_target = self:GetObserverTarget()
		if IsValid(obs_target) then
			self:SetupHands(obs_target)
		end
	end
end

function player_meta:SpectatePlayerLeft()
	if !self:Alive() then return end
	local mode = self:GetObserverMode()
	if mode != OBS_MODE_IN_EYE and mode != OBS_MODE_CHASE then return end
	local obv_target = self:GetObserverTarget()

	local all_alive = {}
	for k,v in pairs(player.GetAll()) do
		--if v:Alive() and !v:IsSpectator() and v.br_downed == false and v.br_support_team == self.br_support_team then
		if v:Alive() and !v:IsSpectator() and v.br_downed == false then
			table.ForceInsert(all_alive, v)
		end
	end
	for k,v in pairs(ents.GetAll()) do
		if table.HasValue(BR_SCP_NPC_CLASSES, v:GetClass()) then
			table.ForceInsert(all_alive, v)
		end
	end
	local new_target = all_alive[1] or self
	for i,v in ipairs(all_alive) do
		if v == obv_target then
			if all_alive[i-1] != nil then
				new_target = all_alive[i-1]
			else
				new_target = all_alive[#all_alive]
			end
			break
		end
	end
	self:SpectateEntity(new_target)
	self:SetPos(new_target:GetPos())
	--print("changing target to", new_target)

	if mode == OBS_MODE_IN_EYE then
		local obs_target = self:GetObserverTarget()
		if IsValid(obs_target) then
			self:SetupHands(obs_target)
		end
	end
end

function player_meta:ChangeSpecMode()
	if !self:Alive() or !self:IsSpectator() then return end
	local mode = self:GetObserverMode()

	local all_alive = {}
	for k,v in pairs(player.GetAll()) do
		if v:Alive() and !v:IsSpectator() and v.br_downed == false and v != self and v.br_support_team == self.br_support_team then
			table.ForceInsert(all_alive, v)
		end
	end

	if all_alive == 0 then
		self:Spectate(OBS_MODE_ROAMING)
		return
	end

	if mode == OBS_MODE_IN_EYE then
		self:Spectate(OBS_MODE_CHASE)
		self:SpectatePlayerLeft()
	elseif mode == OBS_MODE_CHASE then
		self:Spectate(OBS_MODE_ROAMING)
	elseif mode == OBS_MODE_ROAMING then
		self:Spectate(OBS_MODE_IN_EYE)
		self:SpectatePlayerLeft()

		local obs_target = self:GetObserverTarget()
		if IsValid(obs_target) then
			self:SetupHands(obs_target)
		end
	else
		self:Spectate(OBS_MODE_ROAMING)
	end
end

-- lua_run print(Entity(1):UnSpectatePlayer(true))
function player_meta:UnSpectatePlayer(savepos)
	--print("unpsectating "..self:Nick())
	local pos = self:GetPos()
	local ang = self:EyeAngles()
	self:SetNoDraw(false)
	self:UnSpectate()
	self:Spawn()
	if savepos == true then
		self:SetPos(pos)
		self:SetEyeAngles(ang)
	end
end

hook.Add("KeyPress", "BR2_KEYPRESS_SPECTATE", function(ply, key)
	if !ply:IsSpectator() then return end
	if key == IN_ATTACK then
		ply:SpectatePlayerLeft()
	elseif key == IN_ATTACK2 then
		ply:SpectatePlayerRight()
	elseif key == IN_RELOAD then
		ply:ChangeSpecMode()
	end
end)

print("[Breach2] server/player_related/pl_spectating.lua loaded!")
