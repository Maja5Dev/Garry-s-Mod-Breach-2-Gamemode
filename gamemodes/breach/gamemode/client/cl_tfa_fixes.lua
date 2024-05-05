
if old_GetHoloSightReticle == nil and br2_tfa_fixed == nil then
	old_GetHoloSightReticle = TFA.INS2.GetHoloSightReticle
	br2_tfa_fixed = false
	hook.Add("Tick", "BR2_TFA_FIXES", function()
		if br2_tfa_fixed == true then
			hook.Remove("Tick", "BR2_TFA_FIXES")
			return
		end
		if TFA and TFA.INS2 and isfunction(TFA.INS2.GetHoloSightReticle) then
			function TFA.INS2.GetHoloSightReticle(sighttype, rel)
				if rel == "yes" and sighttype == "sight_eotech" then
					local data = {}
					data.type = "Quad"
					data.bone = "A_RenderReticle"
					data.pos = Vector(5, 0, 0)
					data.angle = Angle(90, 0, 0)
					data.size = 0.15
					data.draw_func_outer = old_GetHoloSightReticle(sighttype, rel).draw_func_outer
					data.active = false
					data.rel = sighttype
					data.yuri = true
					return data
				else
					return old_GetHoloSightReticle(sighttype, rel)
				end
				return nil
			end
			br2_tfa_fixed = true
		end
	end)

	hook.Add("PlayerSwitchWeapon", "BR2_TFA_SWITCH_FIX", function(ply, oldWeapon, newWeapon)
		if CLIENT and br2_tfa_fixed and newWeapon.Category == "Breach 2 Weapons" then
			newWeapon.VElements["sight_eotech_lens"] = TFA.INS2.GetHoloSightReticle("sight_eotech", "yes")
		end
	end)
	hook.Add("HUDWeaponPickedUp", "BR2_TFA_DEPLOY_FIX", function(wep)
		if CLIENT and br2_tfa_fixed and wep.Category == "Breach 2 Weapons" then
			wep.VElements["sight_eotech_lens"] = TFA.INS2.GetHoloSightReticle("sight_eotech", "yes")
		end
	end)
end

cvars.AddChangeCallback("cl_tfa_hud_hitmarker_enabled", function(convar_name, value_old, value_new)
	--print(convar_name, value_old, value_new)
	RunConsoleCommand("cl_tfa_hud_hitmarker_enabled", 0)
end)

/*
hook.Add("PlayerSwitchWeapon", "DELENDA_TFASCREENS", function()
	timer.Simple(1, function()
		hook.Remove("PreRender", "TFASCREENS")
	end)
end)
*/

print("[Breach2] client/cl_tfa_fixes.lua loaded!")