
net.Receive("br_scp173_mode", function(len, ply)
	if len < 200 and ply.br_role == "SCP-173" then
		local wep = ply:GetActiveWeapon()
		wep:HandleMovementModeToggle()
	end
end)

print("[Breach2] server/networking/net_scp.lua loaded!")
