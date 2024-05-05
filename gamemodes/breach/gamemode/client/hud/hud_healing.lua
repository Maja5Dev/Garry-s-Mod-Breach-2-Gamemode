
healing_mats_smooth = {
	mat_icon1 = Material("br2_healing/icon1.png"),
	mat_icon2 = Material("br2_healing/icon2.png"),
	mat_main_ring = Material("br2_healing/main_ring.png"),
	mat_ring_bg_big = Material("br2_healing/ring_bg_big.png"),
	mat_ring_bg_small = Material("br2_healing/ring_bg_small.png")
}
healing_mats = {
	mat_icon1 = Material("br2_healing_1024/icon1.png"),
	mat_icon2 = Material("br2_healing_1024/icon2.png"),
	mat_main_ring = Material("br2_healing_1024/main_ring.png"),
	mat_ring_bg_big = Material("br2_healing_1024/ring_bg_big.png"),
	mat_ring_bg_small = Material("br2_healing_1024/ring_bg_small.png")
}
for i=1, 24 do
	healing_mats_smooth["outer_small_"..i..""] = Material("br2_healing/outer_small_"..i..".png")
	healing_mats_smooth["outer_big_"..i..""] = Material("br2_healing/outer_big_"..i..".png")
	healing_mats["outer_small_"..i..""] = Material("br2_healing_1024/outer_small_"..i..".png")
	healing_mats["outer_big_"..i..""] = Material("br2_healing_1024/outer_big_"..i..".png")
end

healing_progress = 0
healing_status = 0

function DrawHealing()
	if are_we_downed() then
		if (last_revive_check + 1) > CurTime() then
			healing_progress = math.Round(24*(last_revive_time/8))
			healing_status = 2
		else
			healing_progress = math.Round(24*(body_health/100))
			healing_status = 1
		end
	else
		healing_progress = 0
		healing_status = 0
	end
	--if last_health_check
	if healing_status == 0 then return end
	local is_healing = (healing_status == 2)
	local m_size = 128
	local posx = ScrW()/2
	local posy = ScrH()/2
	local function draw_next(mat, clr)
		if clr then
			surface.SetDrawColor(clr)
		end
		surface.SetMaterial(mat)
		surface.DrawTexturedRect(posx-(m_size/2), posy-(m_size/2), m_size, m_size)
	end
	local icon_main = "mat_icon2"
	local icon_progress = "outer_small_"
	if is_healing then
		icon_main = "mat_icon1"
		icon_progress = "outer_big_"
	end
	-- Smooth
	--draw_next(healing_mats_smooth["mat_ring_bg_small"], Color(255, 255, 255, 255))
	draw_next(healing_mats_smooth["mat_main_ring"], Color(255, 255, 255, 160))
	for i=1, healing_progress do
		draw_next(healing_mats_smooth[icon_progress..i..""], Color(255, 255, 255, 160))
	end
	if !is_healing then
		draw_next(healing_mats_smooth[icon_main], Color(255, 255, 255, 200))
	end
	
	-- Hard
	draw_next(healing_mats["mat_main_ring"], Color(255, 255, 255, 160))
	for i=1, healing_progress do
		draw_next(healing_mats[icon_progress..i..""], Color(255, 255, 255, 160))
	end
	draw_next(healing_mats[icon_main], Color(255, 255, 255, 200))
end

print("[Breach2] client/hud/hud_healing.lua loaded!")
