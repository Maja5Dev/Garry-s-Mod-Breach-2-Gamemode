
function GM:DrawOverlay()
	local client = LocalPlayer()
	if !IsValid(client) or not client.Alive then return end

	if !BR2_ShouldDrawAnyHud() then
		draw.RoundedBox(0, 0, 0, ScrW(), ScrH(), Color(0,0,0,255))

		local text_1 = ""
		local text_2 = ""
		local color = Color(255,255,255,255)
		if (CurTime() - br2_last_escape) < 12 then
			text_1 = "YOU ESCAPED"
			text_2 = "YOU ESCAPED FROM THE FACILITY IN " .. string.ToMinutesSeconds(br2_survive_time) .. " MINUTES"
		elseif !client:Alive() then
			text_1 = "YOU ARE DEAD"
			text_2 = "YOU WERE ALIVE FOR " .. string.ToMinutesSeconds(br2_survive_time) .. " MINUTES"
			color = Color(255,0,0,255)
		end
		draw.Text({
			text = text_1,
			pos = {ScrW() / 2, ScrH() / 2},
			xalign = TEXT_ALIGN_CENTER,
			yalign = TEXT_ALIGN_CENTER,
			font = "BR_DEATH_SCREEN_1",
			color = color,
		})
		draw.Text({
			text = text_2,
			pos = {ScrW() / 2, ScrH() / 2 + (80 * (ScrH() / 1080))},
			xalign = TEXT_ALIGN_CENTER,
			yalign = TEXT_ALIGN_CENTER,
			font = "BR_DEATH_SCREEN_2",
			color = color,
		})
		return
	end
	
	DrawTargetID()
	DrawHealing()
	DrawProgressBar()
	DrawProgressCircle()
	DrawBlinking()

	BR_WATCHING_CAMERAS = client:GetViewEntity():GetClass() == "br2_camera_view"

	if !BR_WATCHING_CAMERAS and !client:IsSpectator() then
		DrawHidingInfo()
		DrawTemperature()
		DrawSprintMeter()
	end

	if debug_view_mode then
		DrawDebug()
	end
	--DrawDebug914()
end

print("[Breach2] client/hud/hud_overlay.lua loaded!")
