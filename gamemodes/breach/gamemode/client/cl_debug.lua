
debug_view_mode = 0
concommand.Add("br2_debug_view", function()
	if LocalPlayer():IsSuperAdmin() then
		primary_lights_on = !primary_lights_on
		debug_view_mode = debug_view_mode + 1
		if debug_view_mode > 2 then
			debug_view_mode = 0
		end
	end
end)

debug_menu_enabled = false
concommand.Add("br2_debug_toggle_qmenu", function(ply, cmd, args)
	debug_menu_enabled = !debug_menu_enabled
end)
