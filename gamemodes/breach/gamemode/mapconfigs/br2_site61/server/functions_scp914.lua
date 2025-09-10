
function BR2_Get914Status()
	local skip_ents = {}
	
	for k,v in pairs(ents.GetAll()) do
		if v:GetPos() == Vector(709.000000, -832.000000, -8131.000000) then
			table.ForceInsert(skip_ents, v)
		end
	end
	
	local pos_tab = {
		{
			st = Vector(711.968750, -823.241089, -8130.947754),
			en = Vector(711.968750, -826.715942, -8130.899902)
		},
		{
			st = Vector(711.968750, -825.751526, -8124.646484),
			en = Vector(711.968750, -828.398987, -8127.150391)
		},
		{
			st = Vector(711.968750, -832.023193, -8121.808105),
			en = Vector(711.968750, -831.989441, -8125.920898)
		},
		{
			st = Vector(711.968750, -838.231140, -8124.668457),
			en = Vector(711.968750, -835.565186, -8127.099121)
		},
		{
			st = Vector(711.968750, -840.952881, -8130.949707),
			en = Vector(711.968750, -837.019043, -8130.874512)
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
	local pos1 = Vector(737,-678,-8190)
	local pos2 = Vector(804,-541,-8080)
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
				v:SetPos(Vector(768.773560, -1062.487549, -8190.468750))

				if v:IsPlayer() then
					local rndnum = math.random(1,4)

					if rndnum == 1 then
						v:AddSanity(-100)

					elseif rndnum == 2 then
						v:AddSanity(100)

					elseif rndnum == 3 then
						v:TakeDamage(50, v, nil)

					elseif rndnum == 4 then
						v:AddHealth(50)
					end

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

						if ent:GetClass() == "item_radio2" and ent.Code == nil then
							GiveRadioACode(ent)
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

