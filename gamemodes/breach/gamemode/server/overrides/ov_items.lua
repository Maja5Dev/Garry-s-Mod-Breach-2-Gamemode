
function GM:PlayerCanPickupWeapon(ply, wep)
	if ply.br_role == "SCP-173" then
		return wep:GetClass() == "weapon_scp_173"
	end

	-- 049 can only pick up a keycard
	if ply.br_role == "SCP-049" then
		return string.find(wep:GetClass(), "keycard")
	end

	if ply:IsSpectator() or ply:Alive() == false or (wep:GetNWBool("isDropped", false) == true and !IsValid(wep.Owner)) then
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
    if ply:IsSpectator() or ply.br_role == "SCP-173" then return false end

	-- If an object is too heavy, dont pick it up
    local mass = 0
    local phys = ent:GetPhysicsObject()
    if phys then
        mass = phys:GetMass()
    end

	return (mass < 15)
end

print("[Breach2] server/overrides/ov_items.lua loaded!")
