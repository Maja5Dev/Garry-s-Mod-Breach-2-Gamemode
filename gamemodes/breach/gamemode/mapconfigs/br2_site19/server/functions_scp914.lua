
function BR2_Get914Status()
	local skip_ents = {}
	
	for k,v in pairs(ents.GetAll()) do
		if v:GetClass() == "func_button" and v:GetPos():Distance(Vector(10979, -3697, -10957)) < 5 then
			print(v)
			table.ForceInsert(skip_ents, v)
		end
	end
	
	local pos_tab = {
		{
			st = Vector(10980.968750, -3688.924072, -10957.142578),
			en = Vector(10980.968750, -3691.739502, -10957.219727)
		},
		{
			st = Vector(10980.968750, -3690.754395, -10951.054688),
			en = Vector(10980.968750, -3693.096924, -10953.384766)
		},
		{
			st = Vector(10980.968750, -3697.023926, -10948.039063),
			en = Vector(10980.968750, -3696.967285, -10951.536133)
		},
		{
			st = Vector(10980.968750, -3703.054688, -10951.053711),
			en = Vector(10980.968750, -3701.015625, -10953.105469)
		},
		{
			st = Vector(10980.968750, -3706.023682, -10956.677734),
			en = Vector(10980.968750, -3702.247559, -10956.570313)
		},
	}
	
	for i,v in ipairs(pos_tab) do
		local tr = util.TraceLine({
			start = v.st,
			endpos = v.en,
			mask = CONTENTS_SOLID + CONTENTS_MOVEABLE + CONTENTS_OPAQUE,
			filter = skip_ents
		})
		if tr.Hit == true then
			return i
		end
	end
	return 0
end


function BR2_Get_914_Enter_Entities()
	local pos1 = Vector(11027,-3399,-11036)
	local pos2 = Vector(11101,-3546,-10878)
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
				v:SetPos(Vector(11062,-3921,-10993))
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