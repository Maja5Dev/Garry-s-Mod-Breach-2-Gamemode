
function are_we_downed()
	return LocalPlayer():Alive() and LocalPlayer():IsSpectator() == false and (CurTime() - last_health_check) < 2 and LocalPlayer():IsFrozen()
end

function NiceHealth()
	local hl = (LocalPlayer():Health() / LocalPlayer():GetMaxHealth())
	
	if hl < 0.15 then
		return "Nearly dead", Color(255, 0, 0, 255)

	elseif hl < 0.25 then
		return "Badly wounded", Color(255, 100, 0, 255)

	elseif hl < 0.5 then
		return "Wounded", Color(255, 150, 0, 255)

	elseif hl < 0.75 then
		return "Hurt", Color(255, 255, 0, 255)

	elseif hl < 0.9 then
		return "Slightly hurt", Color(150, 255, 0, 255)

	elseif hl > 2 then
		return "Very Healthy", Color(0, 255, 0, 255)
	else
		return "Healthy", Color(0, 255, 0, 255)
	end
end
