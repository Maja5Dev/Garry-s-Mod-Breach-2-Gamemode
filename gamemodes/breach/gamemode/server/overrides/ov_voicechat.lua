
function GM:PlayerCanHearPlayersVoice(listener, talker)
	if game_state == GAMESTATE_POSTROUND then return true end

	if talker.br_downed then return false

	local dis = listener:GetPos():Distance(talker:GetPos())
	if listener:IsSpectator() == true or listener:Alive() == false then
		if talker:IsSpectator() == true or talker:Alive() == false then
			return true
		else
			if dis < DEF_PLAYER_RANGE then
				return true, true
			else
				return false
			end
		end
	else
		if talker:IsSpectator() == true or talker:Alive() == false then
			return false
		else
			local radio1 = nil
			for k,v in pairs(talker:GetWeapons()) do
				if v.IsRadio == true then
					if v.Enabled == true and v.BatteryLevel > 1 then
						radio1 = v.Channel
					end
					break
				end
			end
			if radio1 != nil then
				for k,v in pairs(listener:GetWeapons()) do
					if v.IsRadio == true then
						if v.Enabled == true and v.BatteryLevel > 0 and radio1 == v.Channel then
							return true
						end
						break
					end
				end
			end
			if dis < DEF_PLAYER_RANGE then
				return true, true
			else
				return false
			end
		end
	end
end

function GM:PlayerCanSeePlayersChat(text, teamOnly, listener, talker)
	if game_state == GAMESTATE_POSTROUND then return true end
	if !IsValid(talker) or !IsValid(listener) then return false end
	if talker == listener then return true end
	if talker.br_downed then return false

	local dis = listener:GetPos():Distance(talker:GetPos())
	if listener:IsSpectator() == true or listener:Alive() == false then
		if talker:IsSpectator() == true or talker:Alive() == false then
			--talker:PrintMessage(HUD_PRINTTALK, "chat_spec1: " .. listener:Nick())
			return true
		else
			if dis < DEF_PLAYER_RANGE then
				--talker:PrintMessage(HUD_PRINTTALK, "chat_spec2: " .. listener:Nick())
				return true
			else
				return false
			end
		end
	else
		if talker:IsSpectator() == true or talker:Alive() == false then
			return false
		else
			if dis < DEF_PLAYER_RANGE then
				--talker:PrintMessage(HUD_PRINTTALK, "chat: " .. listener:Nick())
				return true
			else
				return false
			end
		end
	end
end

print("[Breach2] server/overrides/ov_voicechat.lua loaded!")
