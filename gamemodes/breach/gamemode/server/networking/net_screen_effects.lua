
local player_meta = FindMetaTable("Player")

function player_meta:StartCustomScreenEffects(tab, duration)
    net.Start("br_custom_screen_effects")
        net.WriteFloat(duration)
        net.WriteTable(tab)
    net.Send(self)
end
