
net.Receive("br_loot_crate", function(len, ply)
	if len < 500 and ply:Alive() and ply:IsSpectator() == false and istable(MAPCONFIG) and ply.startedLockpicking == nil then
		local pos_got = net.ReadVector()

		for k,v in pairs(MAPCONFIG.BUTTONS_2D.ITEM_CONTAINERS_CRATES.buttons) do
			if v.pos == pos_got then
				if v.locked == true then
					for k2,v2 in pairs(ply.br_special_items) do
						if v2.class == "lockpick" then
							LockPickFunc(ply, v)
							return
						end
					end
					ply:PrintMessage(HUD_PRINTTALK, "This crate seems to be locked...")
					return
				end

				net.Start("br_get_loot_info")
					net.WriteTable(v.items)
					net.WriteTable({"container", pos_got})
				net.Send(ply)

				if SafeBoolConVar("br2_debug_mode") then
					print(NiceVector(v.pos))
				end

				return
			end
		end
	end
end)

net.Receive("br_loot_container", function(len, ply)
	if len < 500 and ply:Alive() and ply:IsSpectator() == false and istable(MAPCONFIG) then
		local pos_got = net.ReadVector()

		for k,v in pairs(MAPCONFIG.BUTTONS_2D.ITEM_CONTAINERS.buttons) do
			if v.pos == pos_got then
				if v.locked then
					ply:PrintMessage(HUD_PRINTTALK, "Seems to be locked...")
					return
				end

				net.Start("br_get_loot_info")
					net.WriteTable(v.items)
					net.WriteTable({"container", pos_got})
				net.Send(ply)

				if SafeBoolConVar("br2_debug_mode") then
					print(NiceVector(v.pos))
				end

				return
			end
		end
	end
end)

net.Receive("br_get_body_notepad", function(len, ply)
	if ply:Alive() and ply:IsSpectator() == false then
		local ent = ply:GetAllEyeTrace().Entity

		if IsValid(ent) and ent:GetClass() == "prop_ragdoll" and ent:GetPos():Distance(ply:GetPos()) < 150 and istable(ent.Info) and istable(ent.Info.notepad) then
			net.Start("br_get_body_notepad")
				net.WriteTable(ent.Info.notepad)
			net.Send(ply)
		end
	end
end)

net.Receive("br_get_loot_info", function(len, ply)
	if ply:Alive() and ply:IsSpectator() == false then
		local ent = ply:GetAllEyeTrace().Entity

		if IsValid(ent) and ent:GetClass() == "prop_ragdoll" and ent:GetPos():Distance(ply:GetPos()) < 150 and istable(ent.Info) and istable(ent.Info.Loot) then
			net.Start("br_get_loot_info")
				net.WriteTable(ent.Info.Loot)
				net.WriteTable({"body", ent})
			net.Send(ply)
		end
	end
end)

net.Receive("br_take_loot", function(len, ply)
	if len > 1500 or !ply:Alive() or ply:IsSpectator() or ply.br_role == "SCP-173" then return end
	local item = net.ReadTable()
	local source = net.ReadTable()

	if istable(item.class) then
		item.class = item.class.class
	end

	if isstring(item.class) and table.Count(source) > 1 and isstring(source[1]) then
		local source_tab = nil

		if ply.br_role == "SCP-049" or ply.br_role == "SCP-173" then
			local swep = weapons.Get(item.class)
			if (swep or item.ammo_info or string.find(item.class, "ammo") or string.find(item.class, "food") or string.find(item.class, "drink"))
				and !string.find(item.class, "keycard")
			then
				ply:PrintMessage(HUD_PRINTTALK, "You cannot pick up weapons!")
				return
			end
		end

		if !ply.br_uses_hunger_system and string.find(item.class, "food") or string.find(item.class, "drink") then
			ply:PrintMessage(HUD_PRINTTALK, "You dont't want food or drinks.")
			return
		end

		if source[1] == "container" and isvector(source[2]) and source[2]:Distance(ply:GetPos()) < 160 then
			for k,v in pairs(MAPCONFIG.BUTTONS_2D.ITEM_CONTAINERS.buttons) do
				if v.pos == source[2] then
					source_tab = v.items
				end
			end

			for k,v in pairs(MAPCONFIG.BUTTONS_2D.ITEM_CONTAINERS_CRATES.buttons) do
				if v.pos == source[2] then
					source_tab = v.items
				end
			end
		elseif source[1] == "body" and isentity(source[2]) and IsValid(source[2]) and source[2]:GetPos():Distance(ply:GetPos()) < 160 and istable(source[2].Info) then
			source_tab = source[2].Info.Loot
		end

		if istable(source_tab) then
			for k,v in pairs(source_tab) do
				local class = item.class
				if istable(class) then
					class = class.class
				end

				local class2 = v.class
				if istable(class2) then
					class2 = class2.class
				end

				if class2 == class then
					local swep = weapons.Get(class)
					if swep == nil then
						for k2,v2 in pairs(BR2_DOCUMENTS) do
							if v2.class == class or v2.class == item.type then
								print("doc debug")
								PrintTable(item)
								table.RemoveByValue(source_tab, v)
								table.ForceInsert(ply.br_special_items, {class = "document", name = v2.name, type = v2.class, attributes = item.attributes})
								return
							end
						end

						for k2,v2 in pairs(BR2_SPECIAL_ITEMS) do
							if v2.class == class then
								--PrintTable(item)
								--v2.PrintName = item.name
								--v2.DocType = item.type
								--v2.DocAttributes = item.attrubutes
								local res = v2.func(ply, v2) or false
								if res == true then
									table.RemoveByValue(source_tab, v)
								end
								return
							end
						end
					end

					for k2,v2 in pairs(ply:GetWeapons()) do
						if v2.Slot == swep.Slot then
							local dropped_wep = ents.Create(class)
							
							if IsValid(dropped_wep) then
								dropped_wep:SetPos(ply:GetPos() + Vector(0,0,30))
								dropped_wep:Spawn()
								dropped_wep:SetNWBool("isDropped", true)
							end

							table.RemoveByValue(source_tab, v)
							return
						end
					end

					local wep = ply:Give(class)
					if IsValid(wep) then
						if isnumber(item.ammo) and item.ammo > 0 then
							wep:SetClip1(item.ammo)
						end

						if item.code != nil then
							wep.Code = item.code
						end

						if item.battery_level != nil then
							wep.BatteryLevel = item.battery_level
						end
					end
					table.RemoveByValue(source_tab, v)
				end
			end
		end
	end
end)

print("[Breach2] server/networking/net_looting.lua loaded!")
