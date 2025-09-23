

br2_lastPositions = {}
br2_nextANP = 0
function CLTick()
	local client = LocalPlayer()
	if !IsValid(client) then return end

	/*
	if br2_nextANP < CurTime() and LocalPlayer().Alive != nil then
		BR_AssignNotepadPlayers()
		br2_nextANP = CurTime() + 2
	end
	*/
	HandleFootstepsCL()
	HorrorCL_Breath()

	if our_last_zone_stage == 0 then
		local our_zone = client:GetSubAreaName()
		if our_zone != our_last_zone and our_zone then
			our_last_zone = our_zone
			our_last_zone_stage = 1
			our_last_zone_alpha = 0
		end
	end

	local wep = LocalPlayer():GetActiveWeapon()
	if IsValid(wep) and wep.IsHands == true then
		BR2_HANDS_ACTIVE = true
	else
		BR2_HANDS_ACTIVE = false
	end

	for k,v in pairs(LocalPlayer():GetWeapons()) do
		if isfunction(v.GlobalCLThink) then
			v:GlobalCLThink()
		end
	end

	if SCP_895_STATUS == 1 and CAMERAS_EXIT_BUTTON then
		local x,y = input.GetCursorPos()
		local dist_x, dist_y = CAMERAS_EXIT_BUTTON:GetPos()
		local w, h = CAMERAS_EXIT_BUTTON:GetSize()
		dist_x = x - (dist_x + (w / 4))
		dist_y = y - (dist_y + (h / 2))

		local power_x = 0
		local power_y = 0
		local dta = 6
		local dtp = 10
		local kx = dist_x < 0
		local ky = dist_y < 0

		if kx then
			power_x = dta - (-dist_x / dtp)
		else
			power_x = dta - (dist_x / dtp)
		end

		if ky then
			power_y = dta - (-dist_y / dtp)
		else
			power_y = dta - (dist_y / dtp)
		end

		if power_x > 0 and power_y > 0 then
			if kx then
				x = x - power_x
			else
				x = x + power_x
			end
			if ky then
				y = y - power_y
			else
				y = y + power_y
			end
		end
		input.SetCursorPos(x, y)
	end
end
hook.Add("Tick", "client_tick_hook", CLTick)

print("[Breach2] client/cl_tick.lua loaded!")
