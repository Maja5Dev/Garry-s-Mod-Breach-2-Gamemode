
BR_IS_HIDING = false

local hmat = Material("vgui/zoom")
function DrawHidingInfo()
	local view_ent = LocalPlayer():GetViewEntity()
	if IsValid(view_ent) and view_ent != LocalPlayer() then
		surface.SetDrawColor(Color(255, 255, 255, 255))
		surface.SetMaterial(hmat)
		surface.DrawTexturedRectRotated(ScrW()/2, ScrH()/2 - 1, ScrW(), ScrH(), 0)
		surface.DrawTexturedRectRotated(ScrW()/2 - 1, ScrH()/2, ScrW(), ScrH(), 180)
		surface.DrawTexturedRectRotated(ScrW()/2 - 1, ScrH()/2 - 1, ScrH(), ScrW(), 90)
		surface.DrawTexturedRectRotated(ScrW()/2, ScrH()/2, ScrH(), ScrW(), -90)

		BR_IS_HIDING = true

		draw.Text({
			text = "Press the use button to leave",
			pos = { ScrW() / 2, ScrH() - 40},
			font = "BR2_ItemFont",
			color = Color(255,255,255,10),
			xalign = TEXT_ALIGN_CENTER,
			yalign = TEXT_ALIGN_CENTER,
		})
		return
	end
	BR_IS_HIDING = false
end

print("[Breach2] client/hud/hud_hiding.lua loaded!")
