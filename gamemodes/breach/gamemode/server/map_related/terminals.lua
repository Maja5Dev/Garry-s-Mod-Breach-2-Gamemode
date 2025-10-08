
function BR_DEFAULT_MAP_Organize_Terminals()
	BR2_TERMINALS = table.Copy(MAPCONFIG.BUTTONS_2D.TERMINALS.buttons)
	for k,v in pairs(BR2_TERMINALS) do
		v.Info = {
			tab_set = "TERMINAL_INFO_GENERIC",
			devices = {
				device_cameras = false
			}
		}

		v.Info.SettingsFunctions = v.special_functions
		
		if v.camerasEnabled then
			v.Info.devices.device_cameras = true
		end
	end
end
