
net.Receive("br_scp173_mode", function(len, ply)
	local scp173mode = net.ReadBool()
	local wep = ply:GetActiveWeapon()

	if IsValid(wep) and wep.HandleTeleport then
		wep:HandleTeleport(ply, scp173mode)
	end
end)

print("[Breach2] server/networking/net_scp.lua loaded!")
