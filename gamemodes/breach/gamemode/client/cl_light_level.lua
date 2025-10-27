
-- Function to get average light level around player
function GetAverageLightLevel(ply, numSamples, distance)
    if not IsValid(ply) then return 0 end

    numSamples = numSamples or 32 -- number of traces to sample
    distance   = distance or 200  -- how far each trace goes

    local origin = ply:EyePos()
    local totalLight = 0
    local directions = {}

    -- Generate evenly distributed directions (hemisphere around player)
    for i = 1, numSamples do
        local angle = Angle(
            math.Rand(-90, 90),  -- pitch
            math.Rand(-180, 180), -- yaw
            0
       )
        table.insert(directions, angle:Forward())
    end

    for _, dir in ipairs(directions) do
        local tr = util.TraceLine({
            start  = origin,
            endpos = origin + dir * distance,
            filter = ply
        })

        -- Sample light at hit position
        local lightColor = render.GetLightColor(tr.HitPos)
        -- Convert to brightness (average of RGB or weighted)
        local brightness = lightColor.r + lightColor.g + lightColor.b

        totalLight = totalLight + brightness
    end

    return (totalLight / numSamples) * 10
end

function SendLightLevelInfo()
	net.Start("br_getlightlevel")
        net.WriteFloat(GetAverageLightLevel(LocalPlayer()))
    net.SendToServer()
end

net.Receive("br_getlightlevel", function(len)
    SendLightLevelInfo()
end)
