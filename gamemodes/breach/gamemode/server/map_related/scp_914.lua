
function BR2_914_End_Stage()
	timer.Create("BR2_914_NextStage", 11, 1, function()
		br2_914_disabled = false
	end)
end

local function scp914_upgrade_item(sp_item, ent)
	better_one = sp_item.upgrade(ent)
	sp_item = nil

	if isentity(better_one) then
		return better_one
	end

	if weapons.Get(better_one) then
		return ents.Create(better_one)

	elseif isstring(better_one) then
		for k2,v2 in pairs(BR2_SPECIAL_ITEMS) do
			if v2.class == better_one then
				sp_item = v2
				break
			end
		end
	end

	if sp_item and isfunction(sp_item.drop) then
		return sp_item.drop()

	elseif isstring(better_one) then
		return ents.Create(better_one)
	end

	return nil
end

local function scp914_setup_new_ent(ent)
	ent:SetVelocity(Vector(0,0,0))

	if !ent:IsPlayer() then
		ent:Spawn()
		ent:SetNWBool("isDropped", true)

		if ent:GetClass() == "item_radio2" and ent.Code == nil then
			GiveRadioACode(ent)
		end
	end
end

br2_914_disabled = false
function BR2_Handle914_Start()
	if br2_914_disabled == true then
		return false
	else
		br2_914_disabled = true
		timer.Create("BR2_914_NextStage", BR2_Get_914_Enter_Delay(), 1, function()
			br_914status = BR2_Get914Status()

			for k,v in pairs(BR2_Get_914_Enter_Entities()) do
				local ent = nil

				-- players
				if v:IsPlayer() and v:Alive() and !v:IsSpectator() then
					ent = v

					if v.br_role == ROLE_SCP_173 then
						v:TakeDamage(math.Clamp(v:Health() / 2, 1000, v:Health()), v, nil)

					elseif v.br_role == ROLE_SCP_049 then
						v:TakeDamage(math.Clamp(v:Health() / 2, 1000, v:Health()), v, nil)

					elseif br_914status == SCP914_ROUGH then
						local rndnum = math.random(1,4)

						if rndnum == 1 then
							v:Kill()

						elseif rndnum == 2 and !v.br_isInfected and !v.br_isBleeding then
							v.br_isInfected = true
							v.br_isBleeding = true
							v:AddSanity(-35) -- always a sanity drop
						else
							v:AddSanity(-100)
							v:AddHunger(50)
							v:AddThirst(50)
							v:AddSanity(-35) -- always a sanity drop
						end

					elseif br_914status == SCP914_COARSE then
						local rndnum = math.random(1,6)

						if rndnum == 1 then
							v:AddSanity(-40)

						elseif rndnum == 2 then
							v:AddHunger(40)

						elseif rndnum == 3 then
							v:AddThirst(40)

						elseif rndnum == 4 then
							if v.br_isInfected then
								v:TakeDamage(30, v, nil)
							else
								v.br_isInfected = true
							end

						elseif rndnum == 5 then
							if v.br_isBleeding then
								v:TakeDamage(30, v, nil)
							else
								v.br_isBleeding = true
							end

						elseif rndnum == 6 then
							v:TakeDamage(50, v, nil)
						end
						v:AddSanity(-30) -- always a sanity drop
					
					elseif br_914status == SCP914_1_1 then
						-- if the player is infected, sacrifice their health, hunger and thrist to remove it
						if v.br_isInfected and v:Health() > 15 then
							v.br_isInfected = false
							v:TakeDamage(15, v, nil)
							v:AddHunger(10)
							v:AddThirst(10)
						end

						-- if the player is bleeding, sacrifice health for it
						if v.br_isBleeding and v:Health() > 20 then
							v.br_isBleeding = false
							v:TakeDamage(20, v, nil)
						end

						-- if the player is thirsty, sacrifice hunger to satiate thirst
						if v.br_thirst > 50 and v.br_hunger < 50 then
							v:AddHunger(50)
							v:AddThirst(-50)

						-- if the player is hungry, sacrifice thirst to satiate hunger
						elseif v.br_hunger > 50 and v.br_thirst < 50 then
							v:AddHunger(-50)
							v:AddThirst(50)
						end

						v:AddSanity(-20) -- always a sanity drop

					elseif br_914status == SCP914_FINE then
						v:AddHealth(20)
						v:AddHunger(-10)
						v:AddThirst(-10)
						v:AddSanity(-15) -- always a sanity drop

					elseif br_914status == SCP914_VERY_FINE then
						v:AddHealth(50)
						v:AddHunger(-20)
						v:AddThirst(-20)
						v:AddSanity(-15) -- always a sanity drop
					end

				-- special (backpack) items
				elseif v.SI_Class and !isfunction(v.GetBetterOne) then
					for k2,v2 in pairs(BR2_SPECIAL_ITEMS) do
						if v2.class == v.SI_Class then
							if isfunction(v2.upgrade) then
								ent = scp914_upgrade_item(v2, v)
								if IsValid(ent) then
									scp914_setup_new_ent(ent)
								end
							end
							break
						end
					end

					if v != ent and IsValid(ent) and IsValid(v) then
						v:Remove()
					end

				-- for sweps or ents
				elseif isfunction(v.GetBetterOne) then
					local better_one = v:GetBetterOne()

					if isstring(better_one) then
						-- if the better one is not a weapon, check if it's an item
						if !weapons.Get(better_one) then
							local sp_item = nil

							for k2,v2 in pairs(BR2_SPECIAL_ITEMS) do
								if v2.class == better_one then
									sp_item = v2
									break
								end
							end

							if sp_item and isfunction(sp_item.upgrade) then
								ent = scp914_upgrade_item(sp_item, v)
								
								if IsValid(ent) then
									scp914_setup_new_ent(ent)
								end
							else
								-- must be an upgradable entity
								ent = ents.Create(better_one)

								if IsValid(ent) then
									scp914_setup_new_ent(ent)
								end
							end
						else
							ent = ents.Create(better_one)

							if IsValid(ent) then
								scp914_setup_new_ent(ent)
							end
						end

					elseif isentity(better_one) then
						ent = better_one
					end

					if v != ent and IsValid(ent) and IsValid(v) then
						v:Remove()
					end
				end

				if ent == nil and IsValid(v) and (isnumber(v.BatteryLevel) or (v:IsWeapon() and v:Clip1() > -1)) then
					ent = v
				end

				if IsValid(ent) then
					local pos = BR2_Get_914_Exit_Position()
					ent:SetPos(pos)

					if isnumber(ent.BatteryLevel) then
						if br_914status == SCP914_ROUGH then
							ent.BatteryLevel = 0

						elseif br_914status == SCP914_COARSE then
							ent.BatteryLevel = math.Clamp(ent.BatteryLevel - 25, 0, 100)

						elseif br_914status == SCP914_FINE then
							ent.BatteryLevel = math.Clamp(ent.BatteryLevel + 25, 25, 100)

						elseif br_914status == SCP914_VERY_FINE then
							ent.BatteryLevel = 100
						end
					end

					if ent:IsWeapon() and ent:Clip1() > -1 then
						if br_914status == SCP914_ROUGH then
							ent:SetClip1(0)

						elseif br_914status == SCP914_COARSE then
							if ent.Primary and ent.Primary.ClipSize then
								ent:SetClip1(math.Clamp(ent:Clip1() - (ent.Primary.ClipSize / 2), 0, ent.Primary.ClipSize))
							else
								ent:TakePrimaryAmmo(10)
							end

						elseif br_914status == SCP914_FINE then
							if ent.Primary and ent.Primary.ClipSize then
								ent:SetClip1(math.Clamp(ent:Clip1() + (ent.Primary.ClipSize / 2), 0, ent.Primary.ClipSize))
							end

						elseif br_914status == SCP914_VERY_FINE then
							if ent.Primary and ent.Primary.ClipSize then
								ent:SetClip1(ent.Primary.ClipSize)
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
