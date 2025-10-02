
net.Receive("br_install_device", function(len, ply)
	if len < 512 and !ply:IsSpectator() and ply:Alive() and ply.br_downed == false then
		local device = net.ReadString()
		local terminal = net.ReadString()

		local found_device = nil
		for k,v in pairs(ply.br_special_items) do
			if v.class == device then
				found_device = v
				break
			end
		end

		if found_device == nil then
			error("[Breach2] Player " .. ply:Nick() .. " tried to install a device they do not own (" .. device .. ")!\n")
			return
		end

		for _, terminal_tab in pairs(BR2_TERMINALS) do
			if terminal_tab.name == terminal then
				if terminal_tab.Info.devices[device] == true then
					ply:PrintMessage(HUD_PRINTTALK, "This terminal already has this device installed!")
					return
				end

				terminal_tab.Info.devices[device] = true
				table.RemoveByValue(ply.br_special_items, found_device)

				net.Start("br_install_device")
				net.Send(ply)

				ply:PrintMessage(HUD_PRINTTALK, "Device installed")

				return
			end
		end

		ply:PrintMessage(HUD_PRINTTALK, "Terminal not found!")
	end
end)

net.Receive("br_use_special_item", function(len, ply)
	if !ply:IsSpectator() and ply:Alive() and ply.br_downed == false then
		local item = net.ReadTable()

		for k,v in pairs(ply.br_special_items) do
			if spi_comp(v, item) then
				for k2,v2 in pairs(BR2_SPECIAL_ITEMS) do
					if v.class == v2.class then
						local remove = v2.use(ply, v)

						if remove then
							table.RemoveByValue(ply.br_special_items, v)
						end

						return
					end
				end

				break
			end
		end
	end
end)

net.Receive("br_drop_special_item", function(len, ply)
	if !ply:IsSpectator() and ply:Alive() and ply.br_downed == false then
		local item = net.ReadTable()

		for k,v in pairs(ply.br_special_items) do
			if spi_comp(v, item) then
				for k2,v2 in pairs(BR2_SPECIAL_ITEMS) do
					if v2.class == v.class then
						v2.drop(ply, v)
						return
					end
				end
			end
		end
	end
end)

net.Receive("br_get_special_items", function(len, ply)
	net.Start("br_get_special_items")
		net.WriteTable(ply.br_special_items)
	net.Send(ply)
end)

net.Receive("br_get_owned_devices", function(len, ply)
	if len < 8 and !ply:IsSpectator() and ply:Alive() and ply.br_downed == false then
		local tab = {}
		for k,v in pairs(ply.br_special_items) do
			if string.find(v.class, "device_") then
				table.ForceInsert(tab, v)
			end
		end
		net.Start("br_get_owned_devices")
			net.WriteTable(tab)
		net.Send(ply)
	end
end)


net.Receive("br_pickup_item", function(len, ply)
	if len < 700 and ply:Alive() and ply:IsSpectator() == false and !table.HasValue(BR2_ROLES_DISALLOWED_PICKUP_SITEMS, ply.br_role) then
		local ent_got = net.ReadEntity()

		local nfilter = ply
		for k,v in pairs(ents.GetAll()) do
			if v:GetModel() == "models/vinrax/scp294/scp294.mdl" then
				nfilter = {ply, v}
			end
		end

		for _,ent in pairs(ents.FindInSphere(util.TraceLine({start = ply:EyePos(), endpos = ply:EyePos() + ply:EyeAngles():Forward() * 80, filter = nfilter}).HitPos, 40)) do
			if ent:GetNWBool("isDropped", false) == true and !IsValid(ent.Owner) then
				if ent_got == ent then

					for k2,v2 in pairs(BR2_ROLES_LOOT_LIMITS) do
						if v2.role_name == ply.br_role then
							if v2.disallow(ply, ent) then
								ply:PrintMessage(HUD_PRINTTALK, "Your cannot pick up this item.")
								return
							else
								break
							end
						end
					end

					if isstring(ent.SI_Class) then
						for k,v in pairs(BR2_SPECIAL_ITEMS) do
							if ply:IsBackPackFull() then
								ply:PrintMessage(HUD_PRINTTALK, "Your inventory is full!")
								return
							end

							if v.class == ent.SI_Class then
								local res = v.func(ply, ent) or false
								if res == true then
									ent:Remove()
								end
								return
							end
						end
						return
					end

					for k,v in pairs(ply:GetWeapons()) do
						if v.Slot == ent.Slot then
							ply:PrintMessage(HUD_PRINTTALK, "You already have an item at slot " .. (v.Slot + 1 .. ""))
							return
						end
					end
					
					ply:PickupWeapon(ent)
				end
			end
		end
		
		local entf = ply:GetAllEyeTrace().Entity
		if IsValid(entf) and entf:GetNWBool("isDropped", false) == true and !IsValid(entf.Owner) and entf:GetPos():Distance(ply:GetPos()) < 150 then
			if ent_got == entf then
				for k,v in pairs(ply:GetWeapons()) do
					if v.Slot == entf.Slot then
						return
					end
				end

				local new_ent = ply:Give(entf:GetClass())
				if entf.Clip1 and entf:Clip1() > 0 then
					new_ent:SetClip1(entf:Clip1())
				end

				if entf.Code != nil then
					new_ent.Code = entf.Code
				end

				if entf.Attributes != nil then
					new_ent.Attributes = entf.Attributes
				end
				
				if entf.BatteryLevel != nil then
					new_ent.BatteryLevel = entf.BatteryLevel
				end
				entf:Remove()
			end
		end
	end
end)

print("[Breach2] server/networking/net_items.lua loaded!")
