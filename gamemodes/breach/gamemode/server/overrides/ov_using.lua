
function ShouldPlayerUse(ply, ent)
	ent.lastUse = CurTime()

	if SafeBoolConVar("br2_debug_mode") and ent:GetClass() == "func_button" then
		local pos = ent:GetPos()
		ply:PrintMessage(HUD_PRINTCONSOLE, "Vector(" .. pos.x .. ", " .. pos.y .. ", " .. pos.z .. ")")
	end
	
	if ply:IsSpectator() then return false end

	if istable(ent.br_info) then
		ply.use_delay = ply.use_delay or 0
		if ply.use_delay > CurTime() then return false end
		
		local lvl, card = ply:GetKeycardLevel()
		local klvl = 0
		local usesounds = false
		
		if isfunction(ent.br_info.customcheck) == true and ent.br_info.customcheck(ply, ent) == false then
			return false
		end

		if isnumber(ent.br_info.code) == true then
			ply.use_delay = CurTime() + 0.1
			ply.lastkeypad = ent
			net.Start("br_keypad")
			net.Send(ply)
			return false
		end
		
		if card == true then
			if ent.br_info.sounds != nil then
				usesounds = ent.br_info.sounds
			end
		end

		if ent.br_info.level != nil then
			klvl = ent.br_info.level
		end
		
		if lvl < klvl then
			ply.use_delay = CurTime() + 1.2
			if usesounds == true then ply:EmitSound("breach2/keycarduse2.ogg", 75, 100, 0.7) end

			if ent.br_info.unusable != true then
				ply:BR2_ShowNotification("I need a keycard level " .. tostring(klvl) .. " to unlock this keypad...")
			end
			return false
		else
			if usesounds == true then ply:EmitSound("breach2/keycarduse1.ogg", 75, 100, 0.7) end
		end
		
		ply.use_delay = CurTime() + 1.2
	end
	return true
end

function GM:PlayerUse(ply, ent)
	if ply.entity173 then
		local wep = ply:GetActiveWeapon()
		if wep and wep.TeleportingMode then
			return false
		end
	end

	if ply.usingBlock then
		ply.usingBlock = false
		return true
	end

	if ent.triggers then
		for k,v in pairs(ent.triggers) do
			v[1].active = CurTime() + 4
		end
	end

	local wep = ply:GetActiveWeapon()
	if IsValid(wep) then
		if isfunction(wep.HandleUse) then
			wep:HandleUse()
			ply.lastuse = CurTime() + 1
			return false
		end
	end

	return ShouldPlayerUse(ply, ent)
end

print("[Breach2] server/overrides/ov_using.lua loaded!")
