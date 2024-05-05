
function IsOffScreen(scrpos)
	return not scrpos.visible or scrpos.x < 0 or scrpos.y < 0 or scrpos.x > ScrW() or scrpos.y > ScrH()
end

focus_button = nil
focus_button_ready = nil
local focus_range = 100
local focus_stick = 0

br_render_buttons = true

hook.Add("HUDPaint", "BR2_DrawButtons", function()
	focus_button_ready = nil
	if !br_render_buttons or MAPCONFIG == nil or MAPCONFIG.BUTTONS_2D == nil or BR2_HANDS_ACTIVE == false then return end
	local mx = ScrW() / 2
	local my = ScrH() / 2
	local size_mul = ScrH() / 1080
	for _,bgroup in pairs(MAPCONFIG.BUTTONS_2D) do
		for i,button in ipairs(bgroup.buttons) do
			local pos = LocalPlayer():GetPos()
			local d = button.pos - pos
			d = d:Dot(d)
			local d1 = d / (150^2)
			local d2 = d / (100^2)
			pos = button.pos:ToScreen()
			if d1 < 1 and !IsOffScreen(pos) and button.canSee(button) and !BR_AnyMenusOn() then
				local x = math.abs(pos.x - mx)
				local y = math.abs(pos.y - my)
				
				if x < focus_range and y < focus_range and d2 < 1 then
					if focus_stick < CurTime() or focus_button == button then
						focus_stick = CurTime() + 0.1
						focus_button = button
					end
				end
				--surface.SetDrawColor(255, 255, 255, 75 * (1 - d1))
				if button == focus_button then

					local opened_tab = table.Copy(bgroup.mat.opened)
					if isfunction(bgroup.mat.opened_func) then
						local ret = bgroup.mat.opened_func(i, button, opened_tab)
						if istable(ret) then
							opened_tab = table.Copy(ret)
						end
					end
					surface.SetDrawColor(255, 255, 255, 200)
					surface.SetMaterial(opened_tab.mat)
					surface.DrawTexturedRect(mx-( (opened_tab.w * size_mul) /2),my-( (opened_tab.h * size_mul) /2), opened_tab.w, opened_tab.h)
					focus_button_ready = bgroup
				else
					local closed_tab = table.Copy(bgroup.mat.closed)
					if isfunction(bgroup.mat.closed_func) then
						local ret = bgroup.mat.closed_func(i, button, opened_tab)
						if istable(ret) then
							closed_tab = table.Copy(ret)
						end
					end
					surface.SetDrawColor(255, 255, 255, 75 * (1 - d1))
					surface.SetMaterial(closed_tab.mat)
					surface.DrawTexturedRect(pos.x - ( (closed_tab.w * size_mul) / 2), pos.y - ( (closed_tab.h * size_mul) / 2), closed_tab.w, closed_tab.h)
				end
			end
		end
	end
	if focus_stick < CurTime() then
		focus_button = nil
	end
end)

print("[Breach2] client/hud/hud_buttons.lua loaded!")
