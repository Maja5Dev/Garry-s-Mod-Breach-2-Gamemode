
local next_duck = 0

function GM:PlayerBindPress(ply, bind, pressed)
	if string.find(bind, "+reload") and pressed then
		local wep = ply:GetActiveWeapon()
		if IsValid(wep) and isfunction(wep.SingleReload) then
			wep:SingleReload()
		end
	end
	if string.find(bind, "+use") and pressed then
		local view_ent = ply:GetViewEntity()
		if IsValid(view_ent) and view_ent != ply then
			net.Start("br_hide_in_closet")
				net.WriteVector(BR_OUR_CLOSET_POS)
			net.SendToServer()
			return true
		end
	end
	if BR_IS_HIDING then return true end
	if string.find(bind, "act") then
		return true
	end
	if string.find(bind, "+duck") then
		if ply:Crouching() or next_duck > CurTime() then
			return true
		end
		next_duck = CurTime() + 0.35
		return false
	end
	if string.find(bind, "+jump") then
		if ply:GetJumpPower() < 5 or ply:IsSprinting() then
			return true
		end
	end
	if string.find(bind, "+use") and pressed and istable(focus_button_ready) then
		focus_button_ready.on_open(focus_button)
	elseif string.find(bind, "+menu_context") and debug_menu_enabled == false then
		return true
	elseif bind == "+menu" and debug_menu_enabled == false and pressed == true then
		net.Start("br_drop_weapon")
		net.SendToServer()
		return true
	elseif bind == "messagemode" or bind == "messagemode2" then
		BR_CreateChatFrame(true)
		return true
	elseif bind == "+attack" then
		if WepSwitchFrame and wep_selected != nil then
			--LocalPlayer():SelectWeapon(wep_selected)
			--input.SelectWeapon(wep_selected)
			LocalPlayer():SafeSelectWeapon(wep_selected)
			CloseWEP()
			return true
		end
	elseif bind == "invnext" and pressed then
		Switch_SelectNext()
		return true
	elseif bind == "invprev" and pressed then
		Switch_SelectPrev()
		return true
	elseif bind == "gm_showhelp" and pressed then
		OpenInfoMenu1()
		return true
	elseif bind == "gm_showteam" and pressed then
		OpenInfoMenu2()
		return true
	elseif bind == "gm_showspare1" and pressed then
		OpenInfoMenu3()
		return true
	elseif bind == "gm_showspare2" and pressed then
		OpenInfoMenu4()
		return true
	end
	if pressed then
		for i=1,10 do
			local b = "slot" .. tostring(i)
			if bind == b then
				OpenSlot(i)
				return true
			end
		end
	end
	--if string.find(bind, "+jump") then return true end
end

print("[Breach2] client/cl_binds.lua loaded!")
