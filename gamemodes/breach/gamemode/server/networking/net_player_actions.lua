
-- Not sure why this is disabled
/*
net.Receive("br_send_info", function(len, ply)
	if ply.net_delay == nil then ply.net_delay = 0 end
	if ply.net_delay > CurTime() then return end
	local target_ply = net.ReadEntity()
	if ply:Alive()
	if IsValid(target_ply) == true then
		if target_ply:IsPlayer() == true then
			bprint(ply:Nick() .. " wants to get information about: " .. tostring(target_ply))
			ply:SendPlayerInfo(target_ply)
		end
	end
	ply.net_delay = CurTime() + 4
end)
*/

net.Receive("br_hide_in_closet", function(len, ply)
	if len < 512 and istable(MAPCONFIG.BUTTONS_2D.HIDING_CLOSETS) and !ply:IsSpectator() and ply:Alive() and ply.br_downed == false then
		local pos = net.ReadVector()
		for k,v in pairs(MAPCONFIG.BUTTONS_2D.HIDING_CLOSETS.buttons) do
			if v.pos == pos then
				if IsValid(v.player) then
					v.player:Stop_HidingInCloset(v)
				else
					--ply:SelectWeapon("br_hands")
					ply:Start_HidingInCloset(v)
				end

				return
			end
		end
	end
end)

net.Receive("br_use_294", function(len, ply)
	if len < 512 and istable(MAPCONFIG.SCP_294_CUP) and !ply:IsSpectator() and ply:Alive() and ply.br_downed == false then
		local text = net.ReadString()

		for k,v in pairs(BR2_SCP_294_OUTCOMES) do
			if table.HasValue(v.texts, text) then
				net.Start("br_use_294")
					net.WriteInt(v.type, 4)
				net.Send(ply)
				v.func(ply, v, text)
				return
			end
		end

		net.Start("br_use_294")
			net.WriteInt(1, 4)
		net.Send(ply)
	end
end)

net.Receive("br_use_soda_machine", function(len, ply)
	if len < 100 and ply:Alive() and ply:IsSpectator() == false and istable(MAPCONFIG) and game_state != GAMESTATE_POSTROUND then
		local vector_got = net.ReadVector()

		for k,v in pairs(MAPCONFIG.BUTTONS_2D.SODAMACHINES.buttons) do
			if v.pos == vector_got then
				for k2,v2 in pairs(ply.br_special_items) do
					if v2.class == "coin" then
						table.RemoveByValue(ply.br_special_items, v2)

						sound.Play("breach2/Button.ogg", v.pos, 75, 100, 1)
						sound.Play("ambient/office/coinslot1.wav", v.pos, 75, 100, 1)
						--name = "UseSodaMachine"..tostring(CurTime())
						timer.Simple(1, function()
							sound.Play("ambient/office/button1.wav", v.pos_inside, 75, 100, 0.75)

							timer.Simple(1, function()
								sound.Play("ambient/office/lever6.wav", v.pos_inside, 75, 100, 0.5)
								local out = ents.Create("prop_Physics")
								if IsValid(out) then
									out.WorldModel = v.mdl
									out:SetModel(v.mdl)
									out:SetPos(v.pos_out)
									out:SetAngles(v.ang_out)

									out.SI_Class = v.class
									out.PrintName = v.name
									ForceSetPrintName(out, v.name)
									out:SetNWBool("isDropped", true)

									out:Spawn()
									out.WorldModel = v.mdl
									out:SetModel(v.mdl)

									local phys = out:GetPhysicsObject()
									if IsValid(phys) then
										phys:Wake()
										phys:SetMass(5)
									end

								end
							end)
						end)
						return
					end
				end
				ply:PrintMessage(HUD_PRINTTALK, "You need a coin to use this machine!")
			end
		end
	end
end)

net.Receive("br_use_button_simple", function(len, ply)
	if len < 100 and ply:Alive() and ply:IsSpectator() == false and istable(MAPCONFIG) then
		local vector_got = net.ReadVector()

		for k,v in pairs(MAPCONFIG.BUTTONS_2D) do
			for k2,v2 in pairs(v.buttons) do
				if v2.pos == vector_got and isfunction(v2.func_sv) then
					v2.func_sv(ply)
				end
			end
		end
	end
end)

net.Receive("br_retrieve_own_notes", function(len, ply)
    if ply.retrievingNotes == true or isentity(ply.retrievingNotes) then
        if ply.lastRetrievingNotes > (CurTime() + 2) then
            ply.retrievingNotes = false
            return
        end

        if len < 10000 then
            local tab = net.ReadTable()
            --PrintTable(tab)
            if tab != nil and istable(tab) then
                if isentity(ply.retrievingNotes) then
                    print("retrieved notes")
                    local ent = ply.retrievingNotes
                    if istable(ent.Info.notepad) then
                        ent.Info.notepad.own_notes = tab
                    end
                else

                    if istable(ply.notepad) then
                        notepad_system.AllNotepads[ply.charid].own_notes = tab
                        ply.notepad = notepad_system.AllNotepads[ply.charid]
                    end
                end
                ply.retrievingNotes = false
            end
        end
    end
end)

net.Receive("br_drop_weapon", function(len, ply)
	if ply:Alive() and ply:IsSpectator() == false then
		ply:DropCurrentWeapon(true)
	end
end)

net.Receive("br_action", function(len, ply)
	if ply:Alive() and ply:IsSpectator() == false then
		local wep = ply:GetActiveWeapon()
		if IsValid(wep) and wep.IsHands == true and wep.Contents then
			wep:CheckContents()
			
			local int = net.ReadInt(8)
			for k,v in pairs(wep.Contents) do
				if v.id == int then
					v.sv_effect(wep, ply)
					return
				end
			end
		end
	end
end)

net.Receive("br_c4_action", function(len, ply)
	if ply:Alive() and ply:IsSpectator() == false then
		local wep = ply:GetActiveWeapon()

		if IsValid(wep) and wep:GetClass() == "item_c4" and wep.Contents then
			local int = net.ReadInt(8)
			for k,v in pairs(wep.Contents) do
				if v.id == int then
					v.sv_effect(wep, ply)
					return
				end
			end
		end
	end
end)

net.Receive("br_use_medkit_item", function(len, ply)
	if ply:Alive() and ply:IsSpectator() == false then
		local wep = ply:GetActiveWeapon()
		
		if IsValid(wep) and wep:GetClass() == "item_medkit" then
			local str = net.ReadString()

			if wep.Contents and wep.Contents[str] then
				wep.Contents[str].amount = wep.Contents[str].amount - 1
				wep.Contents[str].sv_effect(ply)

				if wep.Contents[str].amount < 1 then
					wep.Contents[str] = nil
					if table.Count(wep.Contents) < 1 then
						ply:StripWeapon(wep:GetClass())
					end
				end
			end
		end
	end
end)

net.Receive("br_stop_using_camera", function(len, ply)
	if ply:GetViewEntity():GetClass() == "br2_camera_view" then
		ply:SetViewEntity(ply)
	end
end)

net.Receive("br_use_camera", function(len, ply)
	if ply:Alive() == false or ply:IsSpectator() or ply.lastTerminal == nil then return end
	if ply.lastTerminal.Info.devices.device_cameras == false then return end

	local str = net.ReadString()
	for k,cgroup in pairs(MAPCONFIG.CAMERAS) do
		for k2,v in pairs(cgroup.cameras) do
			if v.name == str then
				for k2,v2 in pairs(ents.FindByClass("br2_camera")) do
					if v2.CameraName == v.name and IsValid(v2.camera_view_ent) then
						ply:SetViewEntity(v2.camera_view_ent)
						ply.viewing895 = v.is_895
						return
					end
				end
			end
		end
	end
	ply:SetViewEntity(ply)
end)

net.Receive("br_keypad", function(len, ply)
	if ply:IsSpectator() == false and ply:Alive() == true then
		if ply.net_delay == nil then ply.net_delay = 0 end
		if ply.net_delay > CurTime() then return end
		ply.net_delay = CurTime() + 0.5
		if IsValid(ply.lastkeypad) == false then return end
		
		local code = net.ReadString()
		
		local nearby_ents = ents.FindInSphere(ply:GetPos(), 100)
		for k,v in pairs(nearby_ents) do
			if v == ply.lastkeypad then
				--print("found keypad!")
				if istable(v.br_info) == true then
					if isnumber(v.br_info.code) == true then
						if v.br_info.code == tonumber(code) then
							ply:EmitSound("breach2/ScannerUse1.ogg", 75, 100, 0.7)
							v:Use(ply, ply, USE_ON, 1)
						else
							ply:EmitSound("breach2/ScannerUse2.ogg", 75, 100, 0.7)
						end
					end
				end
				return
			end
		end
	end
end)

net.Receive("br_check_someones_notepad", function(len, ply)
	if ply:IsSpectator() == false and ply:Alive() == true then
		if ply.net_delay == nil then ply.net_delay = 0 end
		if ply.net_delay > CurTime() then return end
		ply.net_delay = CurTime() + 0.5
		
		local target_ply = net.ReadEntity()
		if IsValid(target_ply) and target_ply:IsPlayer() and target_ply:Alive() and !target_ply:IsSpectator() and target_ply:GetPos():Distance(ply:GetPos()) < 170 and target_ply.br_team != TEAM_SCP then
			local notepad = notepad_system.GetPlayerNotepad(target_ply)

			if !istable(notepad) then
				ply:BR2_ShowNotification("This person doesn't seem to have a notepad.")
				return
			end

			net.Start("br_check_someones_notepad")
				net.WriteTable(notepad)
			net.Send(ply)
		end
	end
end)

net.Receive("br_hack_terminal", function(len, ply)
	local name = net.ReadString()

	if ply:Alive() and !ply:IsSpectator() and name then
		for k,v in pairs(MAPCONFIG.BUTTONS_2D.TERMINALS.buttons) do
			if v.name == name and v.pos:Distance(ply:GetPos()) < 200 then
				net.Start("br_hack_terminal")
					net.WriteTable(round_system.logins or {})
				net.Send(ply)
				return
			end
		end
	end
end)

print("[Breach2] server/networking/net_player_actions.lua loaded!")
