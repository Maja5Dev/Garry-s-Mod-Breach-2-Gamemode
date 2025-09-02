
br2_generators_on_flash = false
temprature_strongness = 0

local zoom_mat = Material("vgui/zoom")
local mat_color = Material("pp/colour")
hook.Add("RenderScreenspaceEffects", "br2_screenspace_effects", function()
	local scrw = ScrW()
	local scrh = ScrH()
	local client = LocalPlayer()

	local i = {
		contrast = 1.2,
		colour = 1.1,
		brightness = 0,
		clr_r = 0,
		clr_g = 0,
		clr_b = 0,
		add_r = 0,
		add_g = 0,
		add_b = 0,
		vignette_alpha = 160,
		tt1 = 1,
		tt2 = 2
	}

	if !client:Alive() or (CurTime() - br2_last_death) < 12 then
		i.brightness = -1
	end

	-- only when alive
	if client:Alive() and client:IsSpectator() == false then
		-- stun effect
		if (CurTime() - last_got_stunned) < 1 then
			i.brightness = 1 - (CurTime() - last_got_stunned)
		end

		if temprature_strongness > BR_OUR_TEMPERATURE then
			temprature_strongness = temprature_strongness - 0.2
		end

		-- low temperature, cold!
		if BR_OUR_TEMPERATURE < -50 then
			local brightness_dec = ((-temprature_strongness) / 1000) / 4
			--brightness = brightness - brightness_dec
			i.add_b = i.add_b + (brightness_dec / 4)
			i.colour = i.colour - (brightness_dec / 4)
			i.vignette_alpha = i.vignette_alpha - (BR_OUR_TEMPERATURE / 15)
		end

		/*
		if br2_our_sanity == 1 then
			if sanity_alpha_delay < 1 then
				sanity_alpha_delay = sanity_alpha_delay + 0.001
			end
		else
			if sanity_alpha_delay > 0 then
				sanity_alpha_delay = sanity_alpha_delay - 0.01
			end
		end
		if sanity_alpha_delay > 0 then
			i.contrast = 0.8 * sanity_alpha_delay
			i.colour = 0.8 * sanity_alpha_delay
			i.vignette_alpha = 200 * sanity_alpha_delay
			i.brightness = -0.01 * sanity_alpha_delay
		end
		if IsValid(horror_scp_ent) and horror_scp_ent.isEnding > 0 then
			i.vignette_alpha = 255
			DrawMotionBlur(0.1, 1, 0.1)
		end
		*/

		if IsValid(cameras_frame) then
			-- in camera effects
			DrawSharpen(1,1)
			i.brightness = 0.3
			i.contrast = 1.2
			i.add_b = 0.2
			i.vignette_alpha = 150
			DrawMaterialOverlay("effects/combine_binocoverlay", 0)
		else
			-- Pocket Dimension effects
			if client:IsInPD() then
				i.vignette_alpha = 200
				i.brightness = 0.03
				i.contrast = 2
				i.colour = 1.5
				i.add_g = 0.035
				if got_teleported_to_pd and (CurTime() - got_teleported_to_pd) < 4 then
					DrawMotionBlur(0.2, 0.7, 0.1)
					i.vignette_alpha = 255
					i.brightness = 0.01
				else
					DrawMotionBlur(0.1, 1, 0.01)
				end
			end

			-- downed blur
			if are_we_downed() then
				DrawToyTown(20, ScrH())
			end

			if client:GetViewEntity():GetClass() == "br2_camera_view" then
				net.Start("br_stop_using_camera")
				net.SendToServer()
			end
			
			-- night vision effects
			local nvg = nil
			for k,v in pairs(client:GetWeapons()) do
				if v.NVG and v.Enabled then
					if !isnumber(v.BatteryLevel) or v.BatteryLevel > 0 then
						nvg = v.NVG
						if isfunction(nvg.effect) then
							nvg.effect(nvg, i)
						end
					else
						brightness = -1
					end
				end
			end

			if LocalPlayer().br_role == "SCP-049" then
				nvg = BR_SCP_049_NVG
				if isfunction(nvg.effect) then
					nvg.effect(nvg, i)
				end
			end

			if br2_our_sanity < 40 and BR_INSANITY_ATTACK > CurTime() then
				nvg = BR_INSANITY_NVG
				if isfunction(nvg.effect) then
					nvg.effect(nvg, i)
				end
			end

			if !nvg then
				-- no night vision on
				DrawBloom(1, 0.2, 2, 9, 1, 1, 1, 1, 1)
				DrawToyTown(i.tt1, scrh / i.tt2)
				DrawSharpen(0.5, 0.5)

				if br2_generators_on_flash then
					local left = br2_generators_on - CurTime()
					if left < 0 then
						br2_generators_on_flash = false
						surface.PlaySound("breach2/intro/Light3.ogg")
						primary_lights_on = true
					end
					i.brightness = -1
				end
			
				if primary_lights_on == true then
					i.contrast = 1.5
				end
			end
		end
	end
	
	mat_color:SetTexture("$fbtexture", render.GetScreenEffectTexture())
	mat_color:SetFloat("$pp_colour_brightness", i.brightness)
	mat_color:SetFloat("$pp_colour_contrast", i.contrast)
	mat_color:SetFloat("$pp_colour_colour", i.colour)
	mat_color:SetFloat("$pp_colour_mulr", i.clr_r)
	mat_color:SetFloat("$pp_colour_mulg", i.clr_g)
	mat_color:SetFloat("$pp_colour_mulb", i.clr_b)
	mat_color:SetFloat("$pp_colour_addr", i.add_r)
	mat_color:SetFloat("$pp_colour_addg", i.add_g)
	mat_color:SetFloat("$pp_colour_addb", i.add_b)
	render.UpdateScreenEffectTexture()

	render.SetMaterial(mat_color)
	render.DrawScreenQuad()

	surface.SetDrawColor(Color(0, 0, 0, i.vignette_alpha))
	surface.SetMaterial(zoom_mat)
	surface.DrawTexturedRectRotated(scrw/2, scrh/2 - 1, scrw, scrh, 0)
	surface.DrawTexturedRectRotated(scrw/2 - 1, scrh/2, scrw, scrh, 180)
	surface.DrawTexturedRectRotated(scrw/2 - 1, scrh/2 - 1, scrh, scrw, 90)
	surface.DrawTexturedRectRotated(scrw/2, scrh/2, scrh, scrw, -90)
end)

print("[Breach2] client/hud/hud_screen_effects.lua loaded!")
