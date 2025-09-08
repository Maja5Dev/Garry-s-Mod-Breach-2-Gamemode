
net.Receive("br_scp_action", function(len, ply)
    local str = net.ReadString()

	if !ply:IsSpectator() and ply:Alive() and ply.br_downed == false and ply.br_team == TEAM_SCP then
        for k,v in pairs(MAPCONFIG.SCP_ACTIONS) do
            if v.name == str then
                if v.pos:Distance(ply:GetPos()) < 400 and v.can_do(ply) then
                    v.sv_acton(ply)
                end
                return
            end
        end
	end
end)
