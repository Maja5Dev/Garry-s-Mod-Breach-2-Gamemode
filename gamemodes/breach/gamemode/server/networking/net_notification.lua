
local player_meta = FindMetaTable("Player")

function player_meta:BR2_ShowNotification(text, duration)
	duration = duration or 3
    
    net.Start("br2_notification")
        net.WriteString(text)
        net.WriteFloat(duration)
    net.Send(self)
end
