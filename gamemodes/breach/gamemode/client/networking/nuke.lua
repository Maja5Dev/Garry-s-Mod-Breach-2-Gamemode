
net.Receive("br_was_nuked", function(len)
    local nuked = net.ReadBool()

    timer.Destroy("BR_NukeSiren")

    if nuked then
        util.ScreenShake(Vector(0, 0, 0), 500, 1, 1, 0)

        RunConsoleCommand("stopsound")

        timer.Simple(0.1, function()
            surface.PlaySound("breach2/nuke/nuke2.ogg")
        end)
    else
        -- survived the nuke
        surface.PlaySound("breach2/nuke/nuke1.ogg")

        util.ScreenShake(Vector(0, 0, 0), 60, 10, 1, 1000)
    end
end)

local sirenChannel

net.Receive("br_nuke_activation", function(len)
    local activated = net.ReadBool()

    br2_nuke_activated = activated
    br2_nuke_activation_time = CurTime()

    if activated then
        sound.PlayFile("sound/breach2/nuke/siren.ogg", "", function(channel, errid, errmsg)
            if IsValid(channel) then
                sirenChannel = channel
                channel:EnableLooping(true)
                channel:Play()
            else
                print("Failed to play:", errmsg)
            end
        end)
    else
        if IsValid(sirenChannel) then
            sirenChannel:Stop()
        end
    end
end)

hook.Add("BR2_PreparingStart", "BR2_RemoveNukeSiren", function()
    timer.Destroy("BR_NukeSiren")
end)
