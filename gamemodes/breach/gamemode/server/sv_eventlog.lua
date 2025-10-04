
hook.Add("OnNPCKilled", "BR_Eventlog_OnNPCKilled", function(npc, attacker, inflictor)
    local class = npc:GetClass()

    if string.find(class, "scp106") or string.find(class, "scp_106") then
        round_system.AddEventLog("SCP-106 has been contained.")

    elseif string.find(class, "scp173") or string.find(class, "scp_173")
     or string.find(class, "scpiso_173") then
        round_system.AddEventLog("SCP-173 has been contained.")

    elseif (string.find(class, "scp049") or string.find(class, "scp_049"))
    and not (string.find(class, "scp0492") or string.find(class, "scp_0492"))
    and not (string.find(class, "scp049-2") or string.find(class, "scp_049-2"))
    then
        round_system.AddEventLog("SCP-049 has been contained.")

    elseif string.find(class, "scp035") or string.find(class, "scp_035") then
        round_system.AddEventLog("SCP-035 has been contained.")

    elseif string.find(class, "scp096") or string.find(class, "scp_096") then
        round_system.AddEventLog("SCP-096 has been contained.")

    elseif string.find(class, "scp457") or string.find(class, "scp_457") then
        round_system.AddEventLog("SCP-457 has been contained.")

    elseif string.find(class, "scp575") or string.find(class, "scp_575") then
        round_system.AddEventLog("SCP-575 has been contained.")

    elseif string.find(class, "scp1048") or string.find(class, "scp_1048") then
        round_system.AddEventLog("SCP-1048 has been contained.")

    elseif string.find(class, "scp939") or string.find(class, "scp_939") then
        round_system.AddEventLog("SCP-939 has been contained.")

    elseif string.find(class, "scp966") or string.find(class, "scp_966") then
        round_system.AddEventLog("SCP-966 has been contained.")
    end
end)

hook.Add("PlayerDeath", "BR_Eventlog_PlayerDeath", function(ply, inflictor, attacker)
    if IsValid(ply) then
        if ply.br_role == "SCP-173" then
            round_system.AddEventLog("SCP-173 has been contained.")

        elseif ply.br_role == "SCP-049" then
            round_system.AddEventLog("SCP-049 has been contained.")

        elseif ply.br_role == "SCP-035" then
            round_system.AddEventLog("SCP-035 has been contained.")

        elseif ply.br_role == "SCP-106" then
            round_system.AddEventLog("SCP-106 has been contained.")

        elseif ply.br_role == "SCP-096" then
            round_system.AddEventLog("SCP-096 has been contained.")

        elseif ply.br_role == "SCP-966" then
            round_system.AddEventLog("SCP-966 has been contained.")
        end
    end
end)

hook.Add("BR_OnMTFSpawn", "BR_Eventlog_OnMTFSpawn", function()
    round_system.AddEventLog("Mobile Task Force has entered the facility.")
end)
