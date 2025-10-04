

br2_nuke_exploded = false
br2_nuke_activated_for = nil
br2_nuke_activator = nil

br2_nuke_deactivated_for = nil
br2_nuke_deactivator = nil

function NukeKillPlayers()
    if br2_nuke_exploded then return end

    br2_nuke_exploded = true
    print("nuke exploded!")

    for k,v in pairs(player.GetAll()) do
        if v:Alive() and !v:IsSpectator() and v.br_role != "SCP-682" then
            local zone = v:GetZone()

            if zone == nil or zone.name != "Outside" then
                local dmg = DamageInfo()
                dmg:SetDamage(v:Health() * 4)
                dmg:SetDamageType(DMG_BLAST)

                v:TakeDamageInfo(dmg)

                net.Start("br_was_nuked")
                    net.WriteBool(true)
                net.Send(v)
            else
                net.Start("br_was_nuked")
                    net.WriteBool(false)
                net.Send(v)
            end
        end
    end

    br2_round_state_end = CurTime()
end

function BR_ActivateNuke()
    print("nuke activated")

    local nuke_time = cvars.Number("br2_time_nuke", 90)

    br2_round_state_end = CurTime() + nuke_time
    round_system.AddEventLog("Omega warhead detonation sequence initiated (T-"..nuke_time.." seconds).")

    net.Start("br_nuke_activation")
        net.WriteBool(true)
    net.Broadcast()

    timer.Create("BR_NukeExplosion", nuke_time, 1, function()
        NukeKillPlayers()
    end)
end

hook.Add("BR2_RoundStateChange", "PreventRoundEndNuke", function()
    if game_state == GAMESTATE_ROUND and br2_nuke_exploded == false and WinCheck() > 0 then
        if !timer.Exists("BR_NukeExplosion") then
            BR_ActivateNuke()
        end
        
        return true -- prevent round from ending
    end
end)

function BR_DeactivateNuke()
    timer.Destroy("BR_NukeExplosion")

    net.Start("br_nuke_activation")
        net.WriteBool(false)
    net.Broadcast()
end

hook.Add("BR2_PreparingStart", "BR2_RemoveNukeTimer", function()
    timer.Destroy("BR_NukeExplosion")
    br2_nuke_exploded = false
    br2_nuke_activated_for = nil
    br2_nuke_activator = nil
    br2_nuke_deactivated_for = nil
    br2_nuke_deactivator = nil
end)
