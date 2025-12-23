
net.Receive("br_scp173_mode", function(len, ply)
	if len < 200 and ply.br_role == ROLE_SCP_173 then
		local wep = ply:GetActiveWeapon()
		wep:HandleMovementModeToggle()
	end
end)

net.Receive("br_scp173_teleport", function(len, ply)
	if len < 200 and ply.br_role == ROLE_SCP_173 then
		local wep = ply:GetActiveWeapon()
		wep:HandleTeleportFromFreeRoam()
	end
end)

print("[Breach2] server/networking/net_scp.lua loaded!")
