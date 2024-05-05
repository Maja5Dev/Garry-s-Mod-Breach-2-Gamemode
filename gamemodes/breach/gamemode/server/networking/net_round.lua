

BR_ROUND_END_VOTERS = {}
--lua_run for k,v in pairs(player.GetAll()) do if v:IsBot() then table.ForceInsert(BR_ROUND_END_VOTERS, v) end end
net.Receive("br_vote_round_end", function(len, ply)
	local votes = table.Count(BR_ROUND_END_VOTERS)
	local votes_needed = math.Round(#player.GetAll() * 0.75)
	if game_state == GAMESTATE_ROUND and ply.next_re_vote_change < CurTime() and votes < votes_needed then
		if table.HasValue(BR_ROUND_END_VOTERS, ply) then
			table.RemoveByValue(BR_ROUND_END_VOTERS, ply)
			--ply:PrintMessage(HUD_PRINTTALK, "Removed the vote, next vote change in 10 seconds")
			net.Start("br_vote_round_end")
				net.WriteBool(false)
			net.Send(ply)
		else
			table.ForceInsert(BR_ROUND_END_VOTERS, ply)
			--ply:PrintMessage(HUD_PRINTTALK, "Voted, next vote change in 10 seconds")
			net.Start("br_vote_round_end")
				net.WriteBool(true)
			net.Send(ply)
		end
		votes = table.Count(BR_ROUND_END_VOTERS)
		ply.next_re_vote_change = CurTime() + 15
		for k,v in pairs(BR_ROUND_END_VOTERS) do
			if !IsValid(v) then
				table.RemoveByValue(BR_ROUND_END_VOTERS, v)
			end
		end
		if votes >= votes_needed then
			PrintMessage(HUD_PRINTTALK, "Players voted for the round to end, postround started")
			Debug_NextRoundStage()
			return
		else
			for k,v in pairs(player.GetAll()) do
				if v:IsSpectator() then
					v:PrintMessage(HUD_PRINTTALK, "Votes for round end: ("..votes.."/"..votes_needed..")")
				end
			end
		end
	end
	BroadcastLua('br_round_end_votes = '..table.Count(BR_ROUND_END_VOTERS))
end)

print("[Breach2] server/networking/net_round.lua loaded!")
