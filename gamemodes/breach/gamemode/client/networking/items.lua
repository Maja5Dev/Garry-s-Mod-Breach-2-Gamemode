
net.Receive("br_send_crate_info", function(len)
	br_crates_info = net.ReadTable()
end)

net.Receive("br_keypad", function(len)
	OpenKeyPad()
end)

net.Receive("br_updatebattery", function(len)
	local int_got = net.ReadInt(8)
	local int2_got = net.ReadInt(8)
	local wep = LocalPlayer():GetActiveWeapon()

	for k,v in pairs(LocalPlayer():GetWeapons()) do
		if v.Slot == int2_got then
			wep.BatteryLevel = int_got
		end
	end
end)

net.Receive("br_updatecode_radio", function(len)
	local code = net.ReadString()
	local wep = LocalPlayer():GetActiveWeapon()
	if IsValid(wep) then
		wep.Code = code
	end
end)

net.Receive("br_get_special_items", function(len)
	local tab = net.ReadTable()
	BR_OpenInventoryMenu(tab)
end)

lockpicking_timestamp = 0

function StartLockpicking()
	lockpicking_timestamp = CurTime() + 9
	InitiateProgressCircle(9)

	chat.AddText(Color(255,255,255,255), "Started lockpicking...")
end

function StopLockpicking()
	lockpicking_timestamp = 0
	progress_circle_end = nil
	progress_circle_time = nil
	progress_circle_status = 0

	chat.AddText(Color(255,255,255,255), "Stopped lockpicking...")
end

net.Receive("br_use_document", function(len)
	local doc_info = net.ReadTable()
	Open_Document(doc_info)
end)
