
local scp914_teleported_positions = {
}
local next_teleported_pos = 1

function BR2_Get914Status()
	for k,v in pairs(ents.GetAll()) do
		if v:GetName() == "914_selecter_rot" then
			return math.Round(math.abs(v:GetAngles().roll) / 45) + 1
		end
	end
	return 1
end

function BR2_Get_914_Enter_Entities()
	local pos1 = Vector(0,0,0) -- TODO
	local pos2 = Vector(0,0,0) -- TODO
	OrderVectors(pos1, pos2)
	local ents_found = {}
	for k,v in pairs(ents.FindInBox(pos1, pos2)) do
		--if v.GetBetterOne or v:IsPlayer() then
		if v.GetBetterOne then
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

				v:SetPos(scp914_teleported_positions[next_teleported_pos])
				next_teleported_pos = next_teleported_pos + 1
				if next_teleported_pos > #scp914_teleported_positions then
					next_teleported_pos = 1
				end

				if v:IsPlayer() then
					v:Kill()
				elseif isfunction(v.GetBetterOne) then
					local better_one = v:GetBetterOne()
					if isstring(better_one) then
						local ent = ents.Create(better_one)
						print(better_one, ent, ent:GetPos())
						if IsValid(ent) then
							ent:SetPos(v:GetPos() + Vector(0,0,10))

							ent:SetVelocity(Vector(0,0,0))
							ent:Spawn()
							ent:SetNWBool("isDropped", true)

							v:Remove()

							if br_914status > 3 and isnumber(ent.BatteryLevel) then
								ent.BatteryLevel = 100
							end
							if ent:GetClass() == "item_radio2" and ent.Code == nil then
								GiveRadioACode(ent)
							end
						end
					end
				end
			end
			BR2_914_End_Stage()
		end)
		return true
	end
end

print("[Breach2] Server/Functions/SCP-914 mapconfig loaded!")