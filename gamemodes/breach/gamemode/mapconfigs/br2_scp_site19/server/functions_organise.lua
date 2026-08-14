
BR2_SPECIAL_BUTTONS = {}

function Breach_Map_Organise()
	print("organising the map...")

	Breach_FixMapHDRBrightness()

	timer.Create("BR_Map_FixMapHDRBrightness_Timer", 1, 1, function()
		Breach_FixMapHDRBrightness()
	end)

	MAP_SCP_294_Coins = 0
	br2_914_disabled = false
	br_914status = 1

	BR_DEFAULT_MAP_Organize_HidingClosets()
	BR_DEFAULT_MAP_Organize_ItemSpawns()
	BR_DEFAULT_MAP_Organize_Corpses()
	BR_DEFAULT_MAP_Organize_Terminals()
	BR_DEFAULT_MAP_Organize_Outfits()
	BR_DEFAULT_MAP_Organize_ItemContainers()
	BR_DEFAULT_MAP_Organize_Cameras()
	BR_DEFAULT_MAP_Organize_KeypadCodes()
	BR_DEFAULT_MAP_Organize_Keypads()
	BR_DEFAULT_MAP_Organize_AddCodeDocuments()
end
hook.Add("BR2_Map_Organise", "BR2_Map_Breach_Map_Organise", Breach_Map_Organise)

print("[Breach2] Server/Functions/Organise mapconfig loaded!")