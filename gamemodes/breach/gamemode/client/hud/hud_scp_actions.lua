
function IsOffScreen(scrpos)
	return not scrpos.visible or scrpos.x < 0 or scrpos.y < 0 or scrpos.x > ScrW() or scrpos.y > ScrH()
end

local see_range = 600

local function canSeeSCPAction(cont, endpos, target_ent)
    endpos = endpos or EyePos()
	return (util.TraceLine({
        start = cont.pos,
        endpos = cont.pos + (endpos - cont.pos):Angle():Forward() * see_range
    }).Entity == target_ent)
end

scp_action_focus_button = nil
scp_action_focus_button_ready = nil
local focus_range = 400
local focus_stick = 0

function DoSCPAction()
    net.Start("br_scp_action")
        net.WriteString(scp_action_focus_button.name)
    net.SendToServer()
end

hook.Add("HUDPaint", "BR2_DrawSCPActions", function()
	scp_action_focus_button_ready = nil
	if !br_render_buttons or MAPCONFIG == nil or MAPCONFIG.SCP_ACTIONS == nil then return end

    local target_ent = LocalPlayer()
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
            end
        end
    end
	
	local mx = ScrW() / 2
	local my = ScrH() / 2
	local size_mul = ScrH() / 1080
	
    for i, button in ipairs(MAPCONFIG.SCP_ACTIONS) do
        local d = button.pos - pos
        d = d:Dot(d)
        local d1 = d / (see_range^2)
        local d2 = d / (170^2)
        pos = button.pos:ToScreen()

        if d1 < 1 and !IsOffScreen(pos) and canSeeSCPAction(button, target_ent:GetPos(), target_ent) and !BR_AnyMenusOn() then
            local x = math.abs(pos.x - mx)
            local y = math.abs(pos.y - my)
            
            if x < focus_range and y < focus_range and d2 < 1 then
                if focus_stick < CurTime() or scp_action_focus_button == button then
                    focus_stick = CurTime() + 0.1
                    scp_action_focus_button = button
                end
            end

            if button == scp_action_focus_button then
                surface.SetDrawColor(255, 255, 255, 200)
                surface.SetMaterial(button.mat.mat)
                surface.DrawTexturedRect(mx-( (button.mat.w * size_mul) /2), my-( (button.mat.h * size_mul) /2), button.mat.w, button.mat.h)
                scp_action_focus_button_ready = button
            else
                surface.SetDrawColor(255, 255, 255, 75 * (1 - d1))
                surface.SetMaterial(button.mat.mat)
                surface.DrawTexturedRect(pos.x - ( (button.mat.w * size_mul) / 2), pos.y - ( (button.mat.h * size_mul) / 2), button.mat.w, button.mat.h)
            end
        end
    end

	if focus_stick < CurTime() then
		scp_action_focus_button = nil
	end
end)

print("[Breach2] client/hud/hud_scp_actions.lua loaded!")
