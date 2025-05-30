
temp_cold_mat = Material("breach2/br2_temp_cold.png")
temp_hot_mat = Material("breach2/br2_temp_hot.png")

function DrawTemperature()
	local size_mul = math.Clamp(ScrH() / 1080, 0.1, 1)
	local size = 64 * size_mul
	local posx = ScrW()-(size)-24
	local posy = ScrH()/2

	if BR_OUR_TEMPERATURE < -50 then
		surface.SetDrawColor(Color(255,255,255,-BR_OUR_TEMPERATURE / 10))
		surface.SetMaterial(temp_cold_mat)
		surface.DrawTexturedRect(posx, posy-(size/2), size, size)
		
	elseif BR_OUR_TEMPERATURE > 50 then
		surface.SetDrawColor(Color(255,255,255,BR_OUR_TEMPERATURE / 10))
		surface.SetMaterial(temp_hot_mat)
		surface.DrawTexturedRect(posx, posy-(size/2), size, size)
	end
end

print("[Breach2] client/hud/hud_temperature.lua loaded!")
