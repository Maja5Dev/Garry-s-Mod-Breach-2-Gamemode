
function BR_AssignNotepadPlayers(dont_assign_local_player, old_notepad)
	if BR2_OURNOTEPAD.people == nil then
		BR2_OURNOTEPAD = {}
		BR2_OURNOTEPAD.people = {}
	end

	if istable(old_notepad) then
		-- add old people that arent in the new notepad
		for _, pl_old in ipairs(old_notepad.people) do
			local found = false

			for _, pl in ipairs(BR2_OURNOTEPAD.people) do
				if pl.charid == pl_old.charid then
					found = true
				end
			end

			if !found then
				table.ForceInsert(BR2_OURNOTEPAD, pl_old)
			end
		end

		-- learning new things about already known people
		for _, pl in ipairs(BR2_OURNOTEPAD.people) do
			for _, pl_old in ipairs(old_notepad.people) do
				if pl.charid == pl_old.charid then
					-- learnt that they are a spy
					if pl.br_ci_agent == false and pl_old.br_ci_agent == true then
						pl.br_ci_agent = true
					end

					if pl.br_showname == nil and pl_old.br_showname != nil then
						pl.br_showname = pl_old.br_showname
					end

					if pl.br_role == nil and pl_old.br_role != nil then
						pl.br_role = pl_old.br_role
					end

					if pl.scp == nil and pl_old.scp != nil then
						pl.scp = pl_old.scp
					end
				end
			end
		end
	end

	if LocalPlayer().Alive and LocalPlayer():Alive() and !LocalPlayer():IsSpectator() then
		for _,pl in pairs(player.GetAll()) do
			if dont_assign_local_player and pl == LocalPlayer() then
				continue
			end

			for k,v in pairs(BR2_OURNOTEPAD.people) do
				if pl:GetNWInt("BR_CharID") == v.charid and (dont_assign_local_player != true or pl.br_showname == nil) then
					pl.br_showname = v.br_showname

					-- learning
					if dont_assign_local_player and v.br_ci_agent != pl.br_ci_agent and pl.br_ci_agent == false then
						pl.br_ci_agent = v.br_ci_agent
					end

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

-- do not replace localplayer info on this, used by 035 changing hosts
net.Receive("br_send_notepad_learn", function(len)
	local old_notepad = table.Copy(BR2_OURNOTEPAD)

	local got_tab = net.ReadTable()
	BR2_OURNOTEPAD = got_tab

	if BR2_OURNOTEPAD.people and table.Count(BR2_OURNOTEPAD.people) > 0 then
		timer.Simple(0.1, function()
			BR_AssignNotepadPlayers(true, old_notepad)
		end)
	end
end)

net.Receive("br_send_info", function(len)
	local info_got = net.ReadTable()
	local steamid64_got = net.ReadString()

	local ply_got = player.GetBySteamID64(steamid64_got)

	if IsValid(ply_got) and istable(info_got) then
		if info_got.br_showname then
			ply_got.br_showname = info_got.br_showname
		end

		if info_got.br_role then
			ply_got.br_role = info_got.br_role
		end

		if info_got.br_team then
			ply_got.br_team = info_got.br_team
		end

		if info_got.br_ci_agent then
			ply_got.br_ci_agent = info_got.br_ci_agent
		end
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
