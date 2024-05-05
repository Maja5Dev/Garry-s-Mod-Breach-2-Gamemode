
local meter_val = 1500 / 255
sprint_meter_mat = Material("breach2/br2_sprint.png")
function DrawSprintMeter()
	--draw.Text({text = tostring(BR_OUR_STAMINA),pos = {ScrW() / 2, ScrH() / 2}})
	if BR_OUR_STAMINA < 1500 then
		local size_mul = math.Clamp(ScrH() / 1080, 0.1, 1)
		local size = 64 * size_mul
		local posx = ScrW() -size -24
		local posy = ScrH()/2 -size

		local alpha = (255 - (BR_OUR_STAMINA / meter_val)) * 0.5
		surface.SetDrawColor(Color(255,255,255,alpha))
		surface.SetMaterial(sprint_meter_mat)
		surface.DrawTexturedRect(posx, posy-(size/2), size, size)
	end
end

print("[Breach2] client/hud/hud_sprint.lua loaded!")
