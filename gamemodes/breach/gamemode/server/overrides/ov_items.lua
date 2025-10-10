
function GM:PlayerCanPickupWeapon(ply, wep)
	for k,v in pairs(BR2_ROLE_WEAPON_LIMITS) do
		if v.role_name == ply.br_role then
			return v.allow_only(ply, wep)
		end
	end

	if ply:IsSpectator() or ply:Alive() == false or (wep:GetNWBool("isDropped", false) == true and !IsValid(wep.Owner)) then
		return false
	end
	
	return true
end

function GM:PlayerCanPickupItem(ply, item)
	if table.HasValue(BR2_ROLES_DISALLOWED_PICKUP_ITEMS, ply.br_role) then
		return false
	end

	return !(ply:IsSpectator())
end

function GM:AllowPlayerPickup(ply, ent)
    if ply:IsSpectator() or table.HasValue(BR2_ROLES_DISALLOWED_PICKUPS, ply.br_role) then return false end

	-- If an object is too heavy, dont pick it up
    local mass = 0
    local phys = ent:GetPhysicsObject()
	
    if IsValid(phys) then
        mass = phys:GetMass()
    end

	return (mass < 15)
end

print("[Breach2] server/overrides/ov_items.lua loaded!")
