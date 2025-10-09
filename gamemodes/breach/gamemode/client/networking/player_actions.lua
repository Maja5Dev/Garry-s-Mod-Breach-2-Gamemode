
net.Receive("br_check_someones_notepad", function(len)
	local notepad = net.ReadTable()
	BR_ShowNotepad(notepad)
end)

function EndPickpocketingNotepad()
	if !IsValid(targeted_player) then return end

	net.Start("br_check_someones_notepad")
		net.WriteEntity(targeted_player)
	net.SendToServer()
end

net.Receive("br_get_loot_info", function(len)
	local loot_info = net.ReadTable()
	local source_got = net.ReadTable()
	BR_OpenLootingMenu(loot_info, source_got)
end)

net.Receive("br_use_outfitter", function(len)
	local tab_got = net.ReadTable()
	BR_OpenOutfitterMenu(tab_got)
	surface.PlaySound("breach2/items/pickitem2.ogg")
end)
