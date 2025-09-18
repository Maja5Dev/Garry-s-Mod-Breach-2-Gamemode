
net.Receive("br_mtf_team_ready", function(len)
	system.FlashWindow()
end)

net.Receive("br_mtf_teams_update", function(len)
	BR2_MTF_TEAMS = net.ReadTable()

	local found_ourselves = false
	local our_team = nil
	for i,v in ipairs(BR2_MTF_TEAMS) do
		for k,pl in pairs(v) do
			if pl == LocalPlayer() then
				found_ourselves = true
				our_team = v
				br_our_team_num = i
			end
		end
	end

	if istable(our_team) and #our_team > 1 then
		return
	end

	if found_ourselves == false then
		if IsValid(br_our_mtf_frame) then
			br_our_mtf_frame:Remove()
		end
	else
		if !IsValid(br_our_mtf_frame) then
			BR_OpenMTFMenu()
		end
	end
end)

net.Receive("br_pregame_spawns", function(len)
	br2_last_death = CurTime() - 20
	br2_survive_time = 0
	br2_support_spawns = net.ReadTable()
end)

net.Receive("br_update_support_spawns", function(len)
	br2_support_spawns = net.ReadTable()
end)
