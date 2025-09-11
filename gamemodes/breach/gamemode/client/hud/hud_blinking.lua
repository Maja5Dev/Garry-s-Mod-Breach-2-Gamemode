
br_next_blink = 0
br_blink_time = 0

local br_blink_alpha = 0
local br_next_unblink = 0

function DrawBlinking()
	local cl1 = br_next_blink - CurTime()
	local cl2 = CurTime() - br_next_unblink

	if cl1 > 0 and cl1 < 0.2 then
		br_blink_alpha = br_blink_alpha + 15

		if br_blink_alpha > 255 then
			br_blink_alpha = 255
			br_next_unblink = CurTime() + 0.2
		end

	elseif cl2 > 0 then
		if cl2 < 0.2 then
			br_blink_alpha = br_blink_alpha - 15
		else
			br_blink_alpha = 0
		end
	end

	if br_blink_alpha > 0 and br_blink_alpha < 256 then
		draw.RoundedBox(0, 0, 0, ScrW(), ScrH(), Color(0, 0, 0, br_blink_alpha))
	end

	if br_next_blink > CurTime() then
		local perc = (br_next_blink - CurTime()) / br_blink_time
		--draw.RoundedBox(0, 0, 0, ScrW(), ScrH(), Color(0,0,0,br_blink_alpha))
		local x = ScrW() / 2 - 158.5
		local y = ScrH() / 1.3

		surface.SetDrawColor(Color(255,255,255,255))
		surface.SetMaterial(mat_progress_bar_1)
		surface.DrawTexturedRect(x, y, 317, 34)
		
		surface.SetDrawColor(Color(255,255,255,255))
		surface.SetMaterial(mat_progress_bar_2)
		surface.DrawTexturedRect(x + 8, y, 303 * perc, 34)
	end
end

print("[Breach2] client/hud/hud_blinking.lua loaded!")
