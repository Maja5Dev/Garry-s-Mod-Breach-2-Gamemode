
include("hud_blinking.lua")
include("hud_buttons.lua")
include("hud_scp_actions.lua")
include("hud_debug.lua")
include("hud_healing.lua")
include("hud_hiding.lua")
include("hud_progress.lua")
include("hud_scoreboard.lua")
include("hud_spectator.lua")
include("hud_sprint.lua")
include("hud_targetid.lua")
include("hud_temperature.lua")
include("hud_voice.lua")
include("hud_wepswitch.lua")
include("hud_screen_effects.lua")
include("hud_notification.lua")

include("hud_overlay.lua")

function BR2_ShouldDrawAnyHud()
	return LocalPlayer and IsValid(LocalPlayer()) and LocalPlayer().Alive and LocalPlayer():Alive() and (CurTime() - br2_last_death) >= 12
end

function DrawInfo(pos, txt, clr)
	pos = pos:ToScreen()
	draw.TextShadow({
		text = txt,
		pos = { pos.x, pos.y },
		font = "BR_DEBUG_FONT",
		color = clr,
		xalign = TEXT_ALIGN_CENTER,
		yalign = TEXT_ALIGN_CENTER,
	}, 2, 255)
end

--br2_mat_gasmask = Material("breach2/gasmask_overlay.png")
br2_mat_gasmask = Material("breach2/masks/gasmask2.png")
br2_mat_nvg = Material("breach2/masks/nvg2.png")
function DrawNormalHud()
	if our_last_zone_stage > 0 and our_last_zone then
		draw.Text({
			text = our_last_zone,
			font = "BR_NEW_ZONE_NAME",
			pos = {36, ScrH() - 24},
			xalign = TEXT_ALIGN_LEFT,
			yalign = TEXT_ALIGN_BOTTOM,
			color = Color(255,255,255, math.Clamp(our_last_zone_alpha, 0, 200))
		})

		if our_last_zone_stage == 1 then
			our_last_zone_alpha = our_last_zone_alpha + 1.5
			if our_last_zone_alpha > 1250 then
				our_last_zone_alpha = 255
				our_last_zone_stage = 2
			end
		else
			our_last_zone_alpha = our_last_zone_alpha - 1
			if our_last_zone_alpha < 1 then
				our_last_zone_stage = 0
				our_last_zone_next = 0
				our_last_zone_alpha = 0
			end
		end
	end

	for k,v in pairs(LocalPlayer():GetWeapons()) do
		if v.GasMaskOn == true then
			surface.SetDrawColor(255, 255, 255, 255)
			surface.SetMaterial(br2_mat_gasmask)
			surface.DrawTexturedRect(0, 0, ScrW(), ScrH())
		--elseif v.NVG and v.Enabled and (!isnumber(v.BatteryLevel) or v.BatteryLevel > 0) and v.NVG.draw_nvg then
		--elseif v.NVG and v.Enabled and (!isnumber(v.BatteryLevel) or v.BatteryLevel > 0) then
		elseif v.NVG and v.Enabled then
			if v.NVG.draw_nvg then
				surface.SetDrawColor(255, 255, 255, 255)
				surface.SetMaterial(br2_mat_nvg)
				surface.DrawTexturedRect(0, 0, ScrW(), ScrH())
			end
			
			if v.DLightLevel > 0.1 then
				v.Dlight = DynamicLight(LocalPlayer():EntIndex())
				v.Dlight.pos = LocalPlayer():GetShootPos()
				v.Dlight.r = 255
				v.Dlight.g = 255
				v.Dlight.b = 255
				v.Dlight.brightness = v.DLightLevel
				v.Dlight.Decay = 1000
				v.Dlight.Size = 512
				v.Dlight.DieTime = CurTime() + 1
			else
				if v.Dlight then
					v.Dlight = nil
				end
			end

		end
	end
end

function GM:HUDPaint()
	if br2_blackscreen and br2_blackscreen > CurTime() then
		draw.RoundedBox(0, 0, 0, ScrW(), ScrH(), Color(0,0,0,255))
	end

	local client = LocalPlayer()
	if client.Alive == nil then return end
	
	if !BR2_ShouldDrawAnyHud() then
		return

	elseif LocalPlayer():IsSpectator() then
		DrawSpectatorHud()
	else
		DrawNormalHud()
	end

	if debug_view_mode > 0 then
		DrawDebug()
		--DrawDebug914()
	end
end

local hide = {
	CHudHealth = true,
	CHudBattery = true,
	CHudAmmo = true,
	CHudBattery = true,
	CHudCrosshair = true,
	CHudDeathNotice = true,
	CHudGeiger = true,
	CHudWeapon = true,
	CHudSecondaryAmmo = true,
	CHudChat = true,
	CHudWeaponSelection = true,
	CHudZoom = true,
	CHudPoisonDamageIndicator = true,
	--CHudVoiceStatus = true,
}

hook.Add("HUDShouldDraw", "BR_HideHUD", function(name)
	if hide[name] then return !hide[name] end
end)

print("[Breach2] client/hud/init.lua loaded!")
