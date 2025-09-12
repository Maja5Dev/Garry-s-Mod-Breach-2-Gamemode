
function GM:PlayerCanPickupWeapon(ply, wep)
	if ply.br_role == "SCP-049" or ply.br_role == "SCP-173" then
		return string.find(wep:GetClass(), "keycard")
	end

	if ply:IsSpectator() == true
	or ply:Alive() == false
	or (wep:GetNWBool("isDropped", false) == true and !IsValid(wep.Owner))
	then
		return false
	end
	
	return true
end

function GM:PlayerCanPickupItem(ply, item)
	if ply.br_role == "SCP-049" or ply.br_role == "SCP-173" then
		return false
	end

	return !(ply:IsSpectator())
end

function GM:AllowPlayerPickup(ply, ent)
	return !(ply:IsSpectator())
end

print("[Breach2] server/overrides/ov_items.lua loaded!")
