
local scp914_teleported_pos = Vector(0,0,0)

function BR2_Get914Status()
	for k,v in pairs(ents.GetAll()) do
		if v:GetName() == "914_dial" then
			local sequence = v:GetKeyValues()["sequence"]
			if sequence == 4 then return 1 end
			if sequence == 5 then return 2 end
			if sequence == 1 then return 3 end
			if sequence == 2 then return 4 end
			if sequence == 3 then return 5 end
		end
	end

	return 1
end

function BR2_Get_914_Enter_Entities()
	local pos1 = Vector(-3171,-214,-9220)
	local pos2 = Vector(-3035,-139,-9077)
	OrderVectors(pos1, pos2)
	local ents_found = {}
	for k,v in pairs(ents.FindInBox(pos1, pos2)) do
		if v.GetBetterOne or v:IsPlayer() then
			table.ForceInsert(ents_found, v)
		end
	end
	return ents_found
end

function BR2_914_End_Stage()
	timer.Create("BR2_914_NextStage", 11, 1, function()
		br2_914_disabled = false
	end)
end

br2_914_disabled = false
function BR2_Handle914_Start()
	if br2_914_disabled == true then
		return false
	else
		br2_914_disabled = true
		timer.Create("BR2_914_NextStage", 4, 1, function()
			br_914status = BR2_Get914Status()
			for k,v in pairs(BR2_Get_914_Enter_Entities()) do
				v:SetPos(scp914_teleported_pos)

				if v:IsPlayer() then
					v:Kill()

				elseif isfunction(v.GetBetterOne) then
					local better_one = v:GetBetterOne()
					if isstring(better_one) then
						local ent = ents.Create(better_one)
						if IsValid(ent) then
							ent:SetPos(v:GetPos() + Vector(0,0,10))

							ent:SetVelocity(Vector(0,0,0))
							ent:Spawn()
							ent:SetNWBool("isDropped", true)
						end
						if isnumber(ent.BatteryLevel) then
							ent.BatteryLevel = 100
						end
						if ent:GetClass() == "item_radio2" then
							for _,bt in pairs(MAPCONFIG.KEYPADS) do
								if ent.Code == nil and isnumber(bt.code) and bt.code_type == "radio" then
									ent.Code = bt.code
								end
							end
						end
					end
					v:Remove()
				end
			end
			BR2_914_End_Stage()
		end)
		return true
	end
end

print("[Breach2] Server/Functions/SCP-914 mapconfig loaded!")