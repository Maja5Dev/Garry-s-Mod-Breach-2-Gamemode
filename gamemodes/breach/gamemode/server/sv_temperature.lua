util.AddNetworkString("br_update_temperature")

local player_meta = FindMetaTable("Player")
function player_meta:AddTemperature(amount)
	self.br_temperature = math.Clamp(self.br_temperature + amount, -1000, 1000)
end

zone_temp_table = {
	--                      to decrease,   effective resistances
	[ZONE_TEMP_VERYCOLD] = {-40, {OUTFIT_COLD_RESISTANCE_HIGH, OUTFIT_COLD_RESISTANCE_MEDIUM, OUTFIT_COLD_RESISTANCE_LOW, OUTFIT_COLD_RESISTANCE_VERYLOW}},
	[ZONE_TEMP_COLD] = {-5, {OUTFIT_COLD_RESISTANCE_MEDIUM, OUTFIT_COLD_RESISTANCE_LOW, OUTFIT_COLD_RESISTANCE_VERYLOW}},
	--[ZONE_TEMP_NORMAL] = {0, {OUTFIT_COLD_RESISTANCE_VERYHIGH, OUTFIT_COLD_RESISTANCE_HIGH, OUTFIT_COLD_RESISTANCE_MEDIUM, OUTFIT_COLD_RESISTANCE_LOW, OUTFIT_COLD_RESISTANCE_VERYLOW}},
	[ZONE_TEMP_NORMAL] = {0, {}},
	[ZONE_TEMP_WARM] = {5, {OUTFIT_COLD_RESISTANCE_VERYHIGH, OUTFIT_COLD_RESISTANCE_HIGH}},
	[ZONE_TEMP_HOT] = {10, {OUTFIT_COLD_RESISTANCE_VERYHIGH, OUTFIT_COLD_RESISTANCE_HIGH, OUTFIT_COLD_RESISTANCE_MEDIUM}},
}

outfit_temp_table = {
	[OUTFIT_COLD_RESISTANCE_VERYHIGH] = {25, 12},
	[OUTFIT_COLD_RESISTANCE_HIGH] = {15, 6},
	[OUTFIT_COLD_RESISTANCE_MEDIUM] = {5, 4},
	[OUTFIT_COLD_RESISTANCE_LOW] = {0, 1.7},
	[OUTFIT_COLD_RESISTANCE_VERYLOW] = {0, 1.2},
}

function HandleTemperature()
	if SafeBoolConVar("br2_debug_dev_mode") then return end

	local high_temp_enabled = SafeBoolConVar("br2_temperature_high_enabled")

	for k,v in pairs(player.GetAll()) do
		if v:Alive() and !v:IsSpectator() and v.br_usesTemperature then
			if v.nextTemperatureCheck < CurTime() then
				v.nextTemperatureCheck = CurTime() + SafeFloatConVar("br2_temperature_speed")
				local outfit = v:GetOutfit()
				local resistance = outfit.temp_resistance
				local ott = outfit_temp_table[resistance]

				if istable(outfit) and isnumber(resistance) and ott then
					local zone = v:GetZone()
					local add_temp = 0
					local skip_zone_temp = false

					-- zone temperature
					if istable(zone) and isnumber(zone.zone_temp) then
						local ztt = zone_temp_table[zone.zone_temp]
						if ztt then
							if table.HasValue(ztt[2], resistance) then
								add_temp = add_temp + ztt[1]
							end

							if ztt[1] >= 0 and v.br_temperature < 0 then
								add_temp = add_temp + 1
							end

							skip_zone_temp = (high_temp_enabled and !ztt[2] and v.br_temperature >= 0)
						end
					end

					-- outfit temperature
					add_temp = add_temp + ott[1]
					v.nextTemperatureCheck = CurTime() + SafeFloatConVar("br2_temperature_speed") * ott[2]

					if (skip_zone_temp and add_temp > 0) or (v.br_temperature >= 1000 and !high_temp_enabled) then
						add_temp = 0
					end

					v:AddTemperature(add_temp)
					v.last_add_temp = add_temp
					--v:PrintMessage(HUD_PRINTCENTER, tostring(high_temp_enabled) .. " / " .. tostring(v.br_temperature) .. " / " .. tostring(skip_zone_temp))
					
					net.Start("br_update_temperature")
						net.WriteInt(v.br_temperature, 16)
					net.Send(v)
				end
			end

			if v.nextTemperatureDamage < CurTime() then
				local health_to_decrease = 0
				local next_temp_damage = 1

				if v.br_temperature < -999 then
					health_to_decrease = 5
					next_temp_damage = 0.5
	
				elseif v.br_temperature < -800 then
					health_to_decrease = 2
					next_temp_damage = 0.5
	
				elseif v.br_temperature < -400 then
					health_to_decrease = 1
					next_temp_damage = 0.5

				elseif v.br_temperature < -200 then
					health_to_decrease = 1
					next_temp_damage = 5
				end
	
				if high_temp_enabled then
					if v.br_temperature > 999 then
						health_to_decrease = 2
						next_temp_damage = 0.5
	
					elseif v.br_temperature > 800 then
						health_to_decrease = 1
						next_temp_damage = 0.5
	
					elseif v.br_temperature > 400 then
						health_to_decrease = 1
						next_temp_damage = 1

					elseif v.br_temperature > 200 then
						health_to_decrease = 1
						next_temp_damage = 5
					end
				end

				if v.last_add_temp > 0 then
					health_to_decrease = math.Round(health_to_decrease * 0.75)
					next_temp_damage = next_temp_damage + 1
				end

				if health_to_decrease >= v:Health() then
					v:TakeDamage(1, v, v)

					local fdmginfo = DamageInfo()
					fdmginfo:SetDamage(20)
					fdmginfo:SetAttacker(v)
					fdmginfo:SetDamageType(DMG_SLOWBURN)
					v:TakeDamageInfo(fdmginfo)
				else
					v:SetHealth(v:Health() - health_to_decrease)
				end
				v.nextTemperatureDamage = CurTime() + next_temp_damage
			end
		end
	end
end
hook.Add("Tick", "BR2_HandleTemperature", HandleTemperature)

print("[Breach2] server/sv_temperature.lua loaded!")
