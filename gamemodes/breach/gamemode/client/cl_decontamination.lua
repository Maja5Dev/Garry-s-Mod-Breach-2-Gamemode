
local alarm_station = nil
local gas_station = nil

hook.Add("BR2_PreparingStart", "BR2_ResetDecontaminationStatus", function()
    decontamination_status = 0
end)

function BR_EnableDecontaminationWarning()
    decontamination_status = 1

    if LocalPlayer():Alive() and !LocalPlayer():IsSpectator() and LocalPlayer():IsInLCZ() then
        sound.PlayFile("sound/breach2/UI/alarm9.wav", "", function(station, errCode, errStr)
            if IsValid(station) then
                station:Play()
                station:SetVolume(0.7)
                station:EnableLooping(true)
                alarm_station = station
            else
                print("Error playing alarm9 sound!", errCode, errStr)
            end
        end)
    end
end

function BR_EnableDecontamination()
    decontamination_status = 2

    if LocalPlayer():IsInLCZ() then
        sound.PlayFile("sound/breach2/UI/alarm6.wav", "", function(station, errCode, errStr)
            if IsValid(station) then
                station:Play()
                station:EnableLooping(true)
                alarm_station = station
            else
                print("Error playing alarm6 sound!", errCode, errStr)
            end
        end)

        sound.PlayFile("sound/ambient/gas/steam2.wav", "", function(station, errCode, errStr)
            if IsValid(station) then
                station:Play()
                station:EnableLooping(true)
                gas_station = station
            else
                print("Error playing gas sound!", errCode, errStr)
            end
        end)
    end
end

timer.Create("BR_DecontaminationStopSounds", 0.2, 0, function()
    if decontamination_status != 2 then return end

    if LocalPlayer():Alive() and !LocalPlayer():IsSpectator() and LocalPlayer().IsInLCZ and !LocalPlayer():IsInLCZ() then
        if IsValid(alarm_station) then
            alarm_station:Stop()
            alarm_station = nil
        end

        if IsValid(gas_station) then
            gas_station:Stop()
            gas_station = nil
        end
    end
end)
