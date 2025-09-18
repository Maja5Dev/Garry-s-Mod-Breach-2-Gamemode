
net.Receive("br_update_temperature", function(len)
	BR_OUR_TEMPERATURE = net.ReadInt(16)
end)

net.Receive("br_update_misc", function(len)
	BR_OUR_STAMINA = net.ReadInt(16)
	BR_OUR_INFECTION = net.ReadInt(16)
end)
