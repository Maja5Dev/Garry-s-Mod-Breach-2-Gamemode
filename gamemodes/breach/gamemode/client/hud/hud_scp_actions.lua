
function IsOffScreen(scrpos)
	return not scrpos.visible or scrpos.x < 0 or scrpos.y < 0 or scrpos.x > ScrW() or scrpos.y > ScrH()
end

local see_range = 600

local function canSeeSCPAction(cont, endpos, target_ent)
	return (util.TraceLine({
        start = cont.pos,
        endpos = cont.pos + (endpos - cont.pos):Angle():Forward() * see_range
    }).Entity == target_ent)
end

scp_action_focus_button = nil
scp_action_focus_button_ready = nil
local focus_range = 400
local focus_stick_scp = 0

function DoSCPAction()
    net.Start("br_scp_action")
        net.WriteString(scp_action_focus_button.name)
    net.SendToServer()
end

surface.CreateFont("BR2_SCPActionToolTip", {
	font = "Tahoma",
	extended = false,
	size = 24,
	weight = 1000,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
})

hook.Add("HUDPaint", "BR2_DrawSCPActions", function()
	scp_action_focus_button_ready = nil
	if !br_render_buttons or MAPCONFIG == nil or MAPCONFIG.SCP_ACTIONS == nil then return end

    local target_ent = LocalPlayer()
    local target_pos = EyePos()
    local pos = LocalPlayer():GetPos()
    local wep = LocalPlayer():GetActiveWeapon()
    if IsValid(wep) then
        if wep.CalcViewInfo then
            local view = wep:CalcViewInfo(LocalPlayer(), nil, LocalPlayer():EyeAngles(), 90)
            if view then
                pos = view.origin
            end
        end

        if wep:GetClass() == "weapon_scp_173" then
            local ent173 = LocalPlayer():GetNWEntity("entity173")
            if IsValid(ent173) then
                target_ent = ent173
                target_pos = target_ent:GetPos()
            end
        end
    end
	
	local mx = ScrW() / 2
	local my = ScrH() / 2
	
    for i, button in ipairs(MAPCONFIG.SCP_ACTIONS) do
        if button.pos == nil or pos == nil then continue end
        local d = button.pos - pos
        d = d:Dot(d)
        local d1 = d / (see_range^2)
        local d2 = d / (170^2)
        local spos = button.pos:ToScreen()

        if button.canDoFor == nil or button.canDoFor < CurTime() then
            if button.can_do(LocalPlayer()) then
                button.canDoFor = CurTime() + 0.1
            else
                button.canDoFor = nil
            end
        end

        if d1 < 1 and !IsOffScreen(spos) and canSeeSCPAction(button, target_pos, target_ent) and !BR_AnyMenusOn() and button.canDoFor and button.canDoFor > CurTime() then
            local x = math.abs(spos.x - mx)
            local y = math.abs(spos.y - my)
            
            if x < focus_range and y < focus_range and d2 < 1 then
                if focus_stick_scp < CurTime() or scp_action_focus_button == button then
                    focus_stick_scp = CurTime() + 0.1
                    scp_action_focus_button = button
                end
            end

            if button == scp_action_focus_button then
                surface.SetDrawColor(255, 255, 255, 200)
                surface.SetMaterial(button.mat.mat)
                surface.DrawTexturedRect(mx-( (button.mat.w) /2), my-( (button.mat.h) /2), button.mat.w, button.mat.h)
                scp_action_focus_button_ready = button

                draw.Text({
                    text = button.tooltip,
                    pos = {mx, my - 60},
                    xalign = TEXT_ALIGN_CENTER,
                    yalign = TEXT_ALIGN_CENTER,
                    font = "BR2_SCPActionToolTip",
                    color = Color(255,255,255,255),
                })
            else
                surface.SetDrawColor(255, 255, 255, 75 * (1 - d1))
                surface.SetMaterial(button.mat.mat)
                surface.DrawTexturedRect(spos.x - ( (button.mat.w) / 2), spos.y - ( (button.mat.h) / 2), button.mat.w, button.mat.h)
            end
        end
    end

	if focus_stick_scp < CurTime() then
		scp_action_focus_button = nil
	end
end)

print("[Breach2] client/hud/hud_scp_actions.lua loaded!")
