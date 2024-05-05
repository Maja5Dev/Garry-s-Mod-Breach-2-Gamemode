
function GM:OnPlayerChat(ply, strText, bTeamOnly, bPlayerIsDead)
	local client = LocalPlayer()
	local tab = {}
	/*
	if (bTeamOnly) then
		table.insert(tab, Color(30, 160, 40))
		table.insert(tab, "(TEAM) ")
	end
	*/
	
	if IsValid(ply) == true then
		if ply:IsSpectator() == true or bPlayerIsDead == true then
			--table.insert(tab, Color(255, 100, 100))
			--table.insert(tab, "*SPECT* ")
			table.insert(tab, Color(232, 209, 83))
			if client:IsSpectator() == true or client:Alive() == false then
				table.insert(tab, ply:Nick())
			else
				return true
			end
		else
			table.insert(tab, Color(100, 209, 100))
			local dis = client:GetPos():Distance(ply:GetPos())
			if dis > DEF_PLAYER_RANGE then return true end
			
			if isstring(ply.br_showname) then
				if client:IsAdmin() then
					table.insert(tab, ply.br_showname .. " (" .. ply:Nick() .. ")")
				else
					table.insert(tab, ply.br_showname)
				end
			else
				if client:IsAdmin() then
					table.insert(tab, "[Unknown]" .. " (" .. ply:Nick() .. ")")
				else
					table.insert(tab, "[Unknown]")
				end
			end
		end
	else
		table.insert(tab, "Console")
	end

	table.insert(tab, Color(255, 255, 255))
	table.insert(tab, ": "..strText)

	chat.AddText(unpack(tab))

	return true
end

print("[Breach2] client/cl_player.lua loaded!")