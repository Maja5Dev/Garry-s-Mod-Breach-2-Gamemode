
net.Receive("br_get_owned_devices", function(len)
	local tab = net.ReadTable()

	if table.Count(tab) > 0 then
		BR_CURRENT_TERMINAL_PANEL.devices_pop(tab)
	end
end)

net.Receive("br_get_terminal_settings", function(len)
	local tab = net.ReadTable()

	if table.Count(tab) > 0 then
		BR_CURRENT_TERMINAL_PANEL.settings_pop(tab)
	end
end)

net.Receive("br_install_device", function(len)
	BR_Access_Terminal(terminal_frame.terminal)
	BR_Access_Terminal_Loading(terminal_frame.terminal)
	terminal_frame:Remove()
end)

net.Receive("br_open_terminal", function(len)
	local passed = net.ReadBool()
	local infoGot = net.ReadTable()
	local loginInfo = net.ReadTable()
	local eventlog = net.ReadTable()
	loading_terminal.endfunc(passed, infoGot, loginInfo, eventlog)
end)

net.Receive("br_hack_terminal", function(len)
	local logins = net.ReadTable()
	BR_Hack_Terminal(logins)
end)

net.Receive("br_update_eventlog", function(len)
	local eventlog = net.ReadTable()
	
	if IsValid(terminal_frame) then
		terminal_frame.eventlog = eventlog or {}
	end
end)
