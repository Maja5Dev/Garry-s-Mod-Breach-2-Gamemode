
br2_current_spec_target = nil
function DrawSpectatorHud()
	local obv_target = LocalPlayer():GetObserverTarget()
	local spec_text = "Spectating (Click R to change mode, LMB/RMB to cycle players)"
	
	if IsValid(obv_target) then
		if obv_target:IsPlayer() then
			spec_text = "Spectating " .. obv_target:Nick()
			
		elseif obv_target.SCPNAME then
			spec_text = "Spectating " .. obv_target.SCPNAME

		elseif BR_SPECTATABLE_NPC_CLASSES[obv_target:GetClass()] then
			spec_text = "Spectating " .. BR_SPECTATABLE_NPC_CLASSES[obv_target:GetClass()]
		end

		br2_current_spec_target = obv_target
	else
		local ents_to_spectate = {}

		for k,v in pairs(ents.GetAll()) do
			for k2,v2 in pairs(BR_SPECTATABLE_NPC_CLASSES) do
				if k2 == v:GetClass() then
					table.ForceInsert(ents_to_spectate, {v, v2})
				end
			end
		end

		for k,v in pairs(player.GetAll()) do
			if !v:IsSpectator() and v:Alive() then
				table.ForceInsert(ents_to_spectate, {v, v:Nick()})
			end
		end

		for k,v in pairs(ents_to_spectate) do
			local dist = LocalPlayer():GetPos():Distance(v[1]:GetPos())

			if dist > 100 then
				local pos2d = v[1]:GetPos():ToScreen()

				draw.Text({
					text = v[2],
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
