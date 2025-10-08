
function BR_AssignNotepadPlayers()
	for _,pl in pairs(player.GetAll()) do
		if pl != LocalPlayer() then
			pl.br_showname = nil
			pl.br_ci_agent = nil
			pl.br_role = nil
			pl.health = nil
			pl.scp = nil
		end
	end

	if LocalPlayer().Alive and LocalPlayer():Alive() and !LocalPlayer():IsSpectator() then
		for _,pl in pairs(player.GetAll()) do
			if BR2_OURNOTEPAD.people == nil then
				--print(pl:Nick() .. " ERRRROOOORR RRR R")
				--PrintTable(BR2_OURNOTEPAD)
				BR2_OURNOTEPAD = {}
				BR2_OURNOTEPAD.people = {}
			end

			for k,v in pairs(BR2_OURNOTEPAD.people) do
				if pl:GetNWInt("BR_CharID") == v.charid then
					--print("found " .. pl:Nick() .. " " .. v.charid)
					pl.br_showname = v.br_showname
					pl.br_ci_agent = v.br_ci_agent
					pl.br_role = v.br_role
					pl.br_team = v.br_team
					pl.health = v.health
					pl.scp = v.scp
				end
			end
		end
	else
		print(LocalPlayer(), LocalPlayer().br_role, LocalPlayer().br_team, LocalPlayer():Alive(), LocalPlayer():IsSpectator())
		error("tried to update notepad of dead localplayer")
	end
end

net.Receive("br_send_notepad", function(len)
	local got_tab = net.ReadTable()
	BR2_OURNOTEPAD = got_tab

	for k,v in pairs(player.GetAll()) do
		if v != LocalPlayer() then
			v.br_info = nil
			v.br_showname = nil
			v.br_role = nil
			v.br_team = nil
		end
	end

	if BR2_OURNOTEPAD.people and table.Count(BR2_OURNOTEPAD.people) > 0 then
		timer.Simple(0.1, BR_AssignNotepadPlayers)
	end
end)

net.Receive("br_send_info", function(len)
	local info_got = net.ReadTable()
	local steamid64_got = net.ReadString()

	local ply_got = player.GetBySteamID64(steamid64_got)

	if IsValid(ply_got) and istable(info_got) then
		ply_got.br_showname = info_got.br_showname
		ply_got.br_role = info_got.br_role
		ply_got.br_team = info_got.br_team
		ply_got.br_ci_agent = info_got.br_ci_agent
		ply_got.br_info = info_got
	else
		print("info_got")
		if istable(info_got) then
			PrintTable(info_got)
		end
		error("Got info on a player but its invalid " .. tostring(ply_got) .. " " .. tostring(info_got))
	end
end)

net.Receive("br_get_body_notepad", function(len)
	local tab = net.ReadTable()
	BR_ShowNotepad(tab)
end)

net.Receive("br_retrieve_own_notes", function(len)
	net.Start("br_retrieve_own_notes")
		net.WriteTable(br2_notepad_own_notes or {})
	net.SendToServer()
end)

net.Receive("br_update_own_info", function(len)
	local client = LocalPlayer()

	client.br_showname = net.ReadString()
	client.br_role = net.ReadString()
	client.br_team = net.ReadInt(8)
	client.br_ci_agent = net.ReadBool()

	client.ShouldDisableLegs = false
	if client.br_role == ROLE_SCP_173 then
		client.ShouldDisableLegs = true
	end
end)
