
hook.Add("BR2_PreparingStart", "BR2_ResetDecontaminationStatus", function()
    round_system.lcz_decontaminated = false

    timer.Destroy("LCZDecontamination")
    timer.Destroy("LCZDecontaminationWarning1")
    timer.Destroy("LCZDecontaminationWarning2")
end)

hook.Add("BR2_RoundStart", "BR2_DecontaminationTimers", function()
	timer.Create("LCZDecontamination", BR_GetRoundTime() * (GetConVar("br2_time_decontamination"):GetInt() / 100), 1, function()
        round_system.lcz_decontaminated = true
        round_system.AddEventLog("Light Containment Zone decontamination activated.")
		BroadcastLua('BR_EnableDecontamination()')

        for k,v in pairs(player.GetAll()) do
            if istable(v.br_support_spawns) then
                v.br_support_spawns["doctor"] = nil
                v.br_support_spawns["janitor"] = nil
                v.br_support_spawns["researcher"] = nil
                v.br_support_spawns["class_d"] = nil
            end
        end
	end)

	-- 90 seconds before decontamination
	timer.Create("LCZDecontaminationWarning1", (BR_GetRoundTime() * (GetConVar("br2_time_decontamination"):GetInt() / 100)) - 90, 1, function()
		round_system.AddEventLog("WARNING: LCZ Decontamination will commence in 90 seconds. Please evacuate the area immediately.", nil, true, "lcz")
	end)

	-- 20 seconds before decontamination
	timer.Create("LCZDecontaminationWarning2", (BR_GetRoundTime() * (GetConVar("br2_time_decontamination"):GetInt() / 100)) - 20, 1, function()
		BroadcastLua('BR_EnableDecontaminationWarning()')
	end)
end)

/*
hook.Add("BR2_PlayerUseKeypadCheck", "BR2_BlockDecontUse", function(ply, ent, lvl, klvl, card)
    if round_system.lcz_decontaminated == true and ent.br_info != nil and ent.br_info.dis_after_decon == true then
        ply:BR2_ShowNotification("The decontamination process is active! I cannot use this keypad right now.")
        return false
    end
end)
*/
