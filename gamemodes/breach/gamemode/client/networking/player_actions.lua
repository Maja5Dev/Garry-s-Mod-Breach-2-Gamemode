
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

--TODO
function EndLootingBody()
	if !IsValid(examined_player) then return end

	net.Start("br_get_loot_info")
		net.WriteEntity(examined_player)
	net.SendToServer()
end

--TODO
function EndExaminingSomeone()
	if !IsValid(examined_player) then return end

	--chat.AddText(Color(255,255,255,255), "Examining...")
	if examined_player:GetClass() == "prop_ragdoll" then
		if examined_player.Pulse then
			if examined_player.Pulse == true then
				chat.AddText(Color(255,0,0,255), " - He is dead")
				local dmg_info = examined_player:GetNWString("ExamineDmgInfo", nil)
				if dmg_info != nil then
					chat.AddText(Color(255,0,0,255), dmg_info)
				end
				local death_time = examined_player:GetNWInt("DeathTime", nil)
				if death_time != nil then
					chat.AddText(Color(255,255,255,255), " - He died " .. string.ToMinutesSeconds(CurTime() - death_time) .. " minutes ago")
				end
				return
			elseif isnumber(examined_player.Pulse) then
				chat.AddText(Color(255,255,255,255), " - He is probably alive")
				return
			end
		end
		chat.AddText(Color(255,255,255,255), " - Looks dead but i am not sure...")
		return
	end
--PERSONAL INFOS
	if examined_player.br_showname != nil then
		chat.AddText(Color(255,255,255,255), " - You remember that their name was " .. examined_player.br_showname)
	else
		chat.AddText(Color(255,255,255,255), " - You don't really know a lot about this person")
	end
--ARMOR
	if examined_player:Armor() > 0 then
		chat.AddText(Color(56, 205,255), " - He seems to be wearing some kind of armor")
	end
--WEAPONS
	local has_wep = false
	for k,v in pairs(examined_player:GetWeapons()) do
		if IsValid(v) and isLethalWeapon(v) then
			has_wep = true
		end
	end
	if has_wep then
		chat.AddText(Color(56, 205,255), " - He seems to be carrying lethal weapons")
	end
--WATER LEVEL
	local water = examined_player:WaterLevel()
	if water == 1 then
		chat.AddText(Color(255,255,255), " - He is slightly submerged")
	elseif water == 2 then
		chat.AddText(Color(255,255,255), " - He is submerged")
	elseif water == 3 then
		chat.AddText(Color(255, 255,255), " - He is completely submerged")
	end
--FIRE
	if examined_player:IsOnFire() then
		chat.AddText(Color(255,0,0), " - He is on fire!")
	end
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
