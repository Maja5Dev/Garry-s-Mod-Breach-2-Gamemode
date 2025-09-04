
function BR_PlayerCanPickupWeapon(ply, wep)
	if ply:IsSpectator() == true or ply:Alive() == false then return false end
	if istable(ply.lastDroppedWeapon) and ply.lastDroppedWeapon[1] == wep and (CurTime() - ply.lastDroppedWeapon[2]) < 2 then
		return false
	end
	for k,v in pairs(ply:GetWeapons()) do
		if (v:GetClass() == wep:GetClass()) or (v:GetSlot() == wep:GetSlot()) then
			return false
		end
	end
	return true
end

function GM:PlayerCanPickupWeapon(ply, wep)
	--return BR_PlayerCanPickupWeapon(ply, wep)
	if ply.br_role == "SCP-049" or ply.br_role == "SCP-173" then
		return string.find(wep:GetClass(), "keycard")
	end
	if ply:IsSpectator() == true or ply:Alive() == false then return false end
	if wep:GetNWBool("isDropped", false) == true and !IsValid(wep.Owner) then return false end
	--if ply.DefaultWeapons and table.Count(ply.DefaultWeapons) > 0 then ply:SelectWeapon(ply.DefaultWeapons[1]) end
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
