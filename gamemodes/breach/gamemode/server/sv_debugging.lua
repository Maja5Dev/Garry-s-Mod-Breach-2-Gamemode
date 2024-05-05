
local player_meta = FindMetaTable("Player")

function player_meta:PrintItemPosAngles()
	local ent = self:GetEyeTrace().Entity
	local pos = ent:GetPos()
	local ang = ent:GetAngles()

	print("{Vector("..math.Round(pos.x)..","..math.Round(pos.y)..math.Round(pos.z).."), Angle("..math.Round(ang.pitch)..","..math.Round(ang.yaw)..","..math.Round(ang.roll)..")},")
end

-- lua_run Entity(1):CheckSpeeds()
function player_meta:CheckSpeeds()
	print("speeds of "..self:Nick())
	print("speed_slow_walking: "..self.speed_slow_walking)
	print("speed_walking: "..self.speed_walking)
	print("speed_running: "..self.speed_running)
end

--lua_run Entity(1):Br_Info()
--lua_run for k,v in pairs(player.GetAll()) do v:Br_Info() end
function player_meta:Br_Info()
	if IsValid(self) == true and self:IsPlayer() == true then
		print("")
		print("[Nickname]: " .. self:Nick())
		print("")
		print("br_showname: " .. tostring(self.br_showname))
		print("IsBot: " .. tostring(self:IsBot()))
		print("IsAlive: " .. tostring(self:Alive()))
		print("Health: " .. self:Health() .. "/" .. self:GetMaxHealth())
		print("Armor: " .. self:Armor())
		print("Walk speed/Run speed: " .. self:GetWalkSpeed() .. "/" .. self:GetRunSpeed())
		print("Model: " .. self:GetModel())
		print("Role: " .. tostring(self.br_role))
		print("Role exists: " .. tostring(role_system.RoleExists(self.br_role)))
		print("Team: " .. self:GetNiceBrTeam() .. " (" .. tostring(self.br_team) .. ")")
		print("GmodTeam: " .. self:GetNiceTeam() .. " (" .. self:Team() .. ")")
		print("Foundation: " .. tostring(self:IsFromFoundation()))
		print("HighFoundation: " .. tostring(self:IsFromFoundationHighStaff()))
		print("")
		print("")
	end
end

print("[Breach2] server/sv_debugging.lua loaded!")
