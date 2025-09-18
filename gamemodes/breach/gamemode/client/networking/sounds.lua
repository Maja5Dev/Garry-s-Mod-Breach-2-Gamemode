
net.Receive("br_playsound", function(len)
	--print("playing sound")
	local str = net.ReadString()
	local vec = net.ReadVector()
	sound.Play("breach2/" .. str, vec)
end)
