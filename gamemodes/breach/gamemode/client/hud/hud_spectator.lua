
br2_current_spec_target = nil
function DrawSpectatorHud()
	local obv_target = LocalPlayer():GetObserverTarget()
	local spec_text = "Spectating (Click R to change mode, LMB/RMB to cycle players)"
	
	if IsValid(obv_target) then
		if obv_target:IsPlayer() then
			spec_text = "Spectating " .. obv_target:Nick()
		elseif obv_target.SCPNAME then
			spec_text = "Spectating " .. obv_target.SCPNAME
		end
		br2_current_spec_target = obv_target
	else
		for k,v in pairs(player.GetAll()) do
			local dist = LocalPlayer():GetPos():Distance(v:GetPos())
			if dist > 100 and !v:IsSpectator() and v:Alive() then
				local pos2d = v:GetPos():ToScreen()

				draw.Text({
					text = v:Nick(),
					pos = {pos2d.x, pos2d.y},
					xalign = TEXT_ALIGN_CENTER,
					yalign = TEXT_ALIGN_CENTER,
					font = "BR_SPECTATOR_FONT",
					color = Color(220,220,220, math.Clamp(dist - 255, 0, 255)),
				})
			end
		end
	end

	draw.Text({
		text = spec_text,
		pos = {ScrW() / 2, ScrH() - 8},
		xalign = TEXT_ALIGN_CENTER,
		yalign = TEXT_ALIGN_BOTTOM,
		font = "BR_SPECTATOR_FONT",
		color = Color(220,220,220,50),
	})
end

print("[Breach2] client/hud/hud_spectator.lua loaded!")
