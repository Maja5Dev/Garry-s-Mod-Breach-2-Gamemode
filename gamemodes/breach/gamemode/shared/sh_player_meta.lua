local player_meta = FindMetaTable("Player")

function player_meta:GetAllEyeTrace()
	return util.TraceLine({
		start = self:EyePos(),
		endpos = self:EyePos() + self:EyeAngles():Forward() * 10000,
		filter = self,
		mask = MASK_ALL
	})
end

function player_meta:IsSpectator()
	return (self:Team() == TEAM_SPECTATOR)
end

function player_meta:IsFromFoundation()
	local bt = self.br_team
	if isnumber(bt) == false then return nil end
	return (bt == TEAM_CLASSD or bt == TEAM_SCP or bt == TEAM_MINORSTAFF or bt == TEAM_RESEARCHER or bt == TEAM_SECURITY or bt == TEAM_MTF or self.br_ci_agent == true)
end

function player_meta:IsFromFoundationHighStaff()
	local bt = self.br_team
	if isnumber(bt) == false then return nil end
	return (bt == TEAM_RESEARCHER or bt == TEAM_SECURITY or bt == TEAM_MTF or bt == TEAM_CI)
end

function player_meta:GetNiceSite()
	local pl_team = self.br_team
	if pl_team == TEAM_SPECTATOR then return "None" end
	if pl_team == TEAM_SCP then return "SCP Foundation" end
	if pl_team == TEAM_CLASSD then return "SCP Foundation" end
	if pl_team == TEAM_RESEARCHER then return "SCP Foundation" end
	if pl_team == TEAM_CI then return "Chaos Insurgency" end
	if pl_team == TEAM_SECURITY then return "SCP Foundation" end
	if pl_team == TEAM_MINORSTAFF then return "SCP Foundation" end
	if pl_team == TEAM_MTF then return "SCP Foundation" end
	return "None"
end

function player_meta:GetNiceBrTeam()
	local pl_team = self.br_team
	if pl_team == TEAM_SPECTATOR then return "TEAM_SPECTATOR" end
	if pl_team == TEAM_SCP then return "TEAM_SCP" end
	if pl_team == TEAM_CLASSD then return "TEAM_CLASSD" end
	if pl_team == TEAM_RESEARCHER then return "TEAM_RESEARCHER" end
	if pl_team == TEAM_CI then return "TEAM_CI" end
	if pl_team == TEAM_SECURITY then return "TEAM_SECURITY" end
	if pl_team == TEAM_MINORSTAFF then return "TEAM_MINORSTAFF" end
	if pl_team == TEAM_MTF then return "TEAM_MTF" end
	return "nil team"
end

function player_meta:GetNiceTeam()
	local pl_team = self:Team()
	if pl_team == TEAM_ALIVE then return "TEAM_ALIVE" end
	if pl_team == TEAM_SPECTATOR then return "TEAM_SPECTATOR" end
	return "nil team"
end

function player_meta:IsInZone(zone)
	local pos = self:GetPos()
	if zone.sub_areas then
		for k3,zone2 in pairs(zone.sub_areas) do
			local pos1 = Vector(zone2[2].x, zone2[2].y, zone2[2].z)
			local pos2 = Vector(zone2[3].x, zone2[3].y, zone2[3].z)
			OrderVectors(pos1, pos2)
			if pos:WithinAABox(pos1, pos2) then return true end
		end
	end
	if zone.pos1 then
		local pos1 = Vector(zone.pos1.x, zone.pos1.y, zone.pos1.z)
		local pos2 = Vector(zone.pos2.x, zone.pos2.y, zone.pos2.z)
		OrderVectors(pos1, pos2)
		if pos:WithinAABox(pos1, pos2) then return true end
	end
	return false
end

function player_meta:IsInEscapeZone()
	if MAPCONFIG and MAPCONFIG.ZONES and MAPCONFIG.ESCAPE_ZONES then
		for k,v in pairs(MAPCONFIG.ESCAPE_ZONES) do
			if self:IsInZone(v) then
				return true
			end
		end
	end
	return false
end

function player_meta:IsInGasZone()
	if MAPCONFIG and MAPCONFIG.ZONES and MAPCONFIG.GAS_ZONES then
		for k,v in pairs(MAPCONFIG.GAS_ZONES) do
			if self:IsInZone(v) then
				return true
			end
		end
	end
	return false
end

function player_meta:IsInPD()
	if MAPCONFIG and MAPCONFIG.ZONES and MAPCONFIG.ZONES.POCKETDIMENSION then
		for k,v in pairs(MAPCONFIG.ZONES.POCKETDIMENSION) do
			if self:IsInZone(v) then
				return true
			end
		end
	end
	return false
end

function player_meta:GetMusicZone()
	if istable(MAPCONFIG) and istable(MAPCONFIG.SPECIAL_MUSIC_ZONES) then
		for k,v in pairs(MAPCONFIG.SPECIAL_MUSIC_ZONES) do
			local pos1 = Vector(v.pos1.x, v.pos1.y, v.pos1.z)
			local pos2 = Vector(v.pos2.x, v.pos2.y, v.pos2.z)
			OrderVectors(pos1, pos2)
			if self:GetPos():WithinAABox(pos1, pos2) then
				return v
			end
		end
	end
	return nil
end

function BR2_GetZonePos(pos)
	if istable(MAPCONFIG) and istable(MAPCONFIG.ZONES) then
		for k,v in pairs(MAPCONFIG.ZONES) do
			for k2,zone in pairs(v) do
				if zone.sub_areas then
					for k3,zone2 in pairs(zone.sub_areas) do
						local pos1 = Vector(zone2[2].x, zone2[2].y, zone2[2].z)
						local pos2 = Vector(zone2[3].x, zone2[3].y, zone2[3].z)
						OrderVectors(pos1, pos2)
						if pos:WithinAABox(pos1, pos2) then
							return zone
						end
					end
				end
				if zone.pos1 then
					local pos1 = Vector(zone.pos1.x, zone.pos1.y, zone.pos1.z)
					local pos2 = Vector(zone.pos2.x, zone.pos2.y, zone.pos2.z)
					OrderVectors(pos1, pos2)
					if pos:WithinAABox(pos1, pos2) then return zone end
				end
			end
		end
	end
	return nil
end

function player_meta:GetSubAreaName()
	local pos = self:GetPos()
	if istable(MAPCONFIG) and istable(MAPCONFIG.ZONES) then
		for k,v in pairs(MAPCONFIG.ZONES) do
			for k2,zone in pairs(v) do
				if zone.sub_areas then
					for k3,zone2 in pairs(zone.sub_areas) do
						local pos1 = Vector(zone2[2].x, zone2[2].y, zone2[2].z)
						local pos2 = Vector(zone2[3].x, zone2[3].y, zone2[3].z)
						OrderVectors(pos1, pos2)
						if pos:WithinAABox(pos1, pos2) then return zone2[1] end
					end
				end
				if zone.pos1 then
					local pos1 = Vector(zone.pos1.x, zone.pos1.y, zone.pos1.z)
					local pos2 = Vector(zone.pos2.x, zone.pos2.y, zone.pos2.z)
					OrderVectors(pos1, pos2)
					if pos:WithinAABox(pos1, pos2) then return zone.name end
				end
			end
		end
	end
	return nil
end

function player_meta:GetZone()
	return BR2_GetZonePos(self:GetPos(), false)
end

function player_meta:GetSubZoneName()
	return BR2_GetZoneName(self:GetPos(), true)
end

--lua_run for k,v in pairs(player.GetAll()) do print(v:Nick(), v:GetOutfit().name, v:GetModel()) end
--lua_run print(Entity(1):GetOutfit().name)
function player_meta:GetOutfit()
	if istable(BREACH_OUTFITS) and table.Count(BREACH_OUTFITS) > 0 then
		local our_model = self:GetModel()
		for k,v in pairs(BREACH_OUTFITS) do
			if isstring(v.model) then
				if v.model == our_model then return v end
			elseif istable(v.model) then
				for k2,v2 in pairs(v.model) do
					if v2 == our_model then return v end
				end
			end
		end
	end
	return BR_DEFAULT_OUTFIT
end

print("[Breach2] shared/sh_player_meta.lua loaded!")