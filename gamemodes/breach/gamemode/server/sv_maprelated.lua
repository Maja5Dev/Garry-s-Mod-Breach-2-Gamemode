
function form_basic_item_info(class, amount)
	for k,v in pairs(BR2_DOCUMENTS) do
		if v.class == class then
			return {class = class, ammo = 0, name = v.name}
		end
	end

	for k,v in pairs(BR2_SPECIAL_ITEMS) do
		if v.class == class then
			return {class = class, ammo = 0, v.name}
		end
	end

	if istable(class) then
		class = table.Random(class)
	end
	
	--print("TEST ITEM", class, weapons.Get(class), weapons.Get(class).PrintName)
	local wwep = weapons.Get(class)
	if wwep == nil then
		ErrorNoHalt("Couldn't find a weapon class: " .. class)
	end

	return {class = class, ammo = amount or 0, name = wwep.PrintName}
end

function Breach_FixMapHDRBrightness()
	for k,v in pairs(ents.FindByClass("env_tonemap_controller")) do
		v:Fire("UseDefaultAutoExposure", "0", 0)
		v:Fire("SetAutoExposureMin", "0.5", 0)
		v:Fire("SetAutoExposureMax", "1", 0)
	end
end

function BR_DEFAULT_MAP_Organize_HidingClosets()
	if istable(MAPCONFIG.BUTTONS_2D.HIDING_CLOSETS) then
		for k,v in pairs(MAPCONFIG.BUTTONS_2D.HIDING_CLOSETS.buttons) do
			v.peeking_ent = ents.Create("br2_peeking")
			if IsValid(v.peeking_ent) then
				v.peeking_ent:SetModel("models/hunter/blocks/cube025x025x025.mdl")
				v.peeking_ent:SetPos(v.peeking_pos)
				v.peeking_ent:Spawn()
				v.peeking_ent:SetNoDraw(true)
			end
		end
	end
end

function BR_DEFAULT_MAP_Organize_ItemSpawns()
	for k,v in pairs(MAPCONFIG.RANDOM_ITEM_SPAWNS) do
		local all_spawns = table.Copy(v.spawns)

		for i=1, #all_spawns - v.num do
			table.RemoveByValue(all_spawns, table.Random(all_spawns))
		end

		local all_ents = {}
		for i,spawn in ipairs(all_spawns) do
			local ent = ents.Create(v.class)
			
			if IsValid(ent) then
				if v.model then
					ent:SetModel(v.model)
				end

				ent:SetPos(spawn[1])
				ent:SetAngles(spawn[2])
				ent:Spawn()

				if isfunction(v.func) then
					v.func(ent)
				end
				
				table.ForceInsert(all_ents, ent)
			end
		end

		if isfunction(v.func_all) then
			v.func_all(all_ents)
		end
	end
end

function BR_CheckRagdollPositions()
	for k,v in pairs(MAPCONFIG.STARTING_CORPSES) do
		for k2,v2 in pairs(v) do
			local tr = util.TraceLine({
				start = v2.ragdoll_pos,
				endpos = v2.ragdoll_pos + Vector(0,0,1)
			})

			if tr.Hit and tr.HitWorld then
				ErrorNoHalt("Corpse in wall position " .. tostring(v2.ragdoll_pos) .. " for model " .. v2.model)
			end
		end
	end
end

function BR_DEFAULT_MAP_Organize_Corpses()
	BR_CheckRagdollPositions()

	if istable(MAPCONFIG.STARTING_CORPSES) and round_system.current_scenario.fake_corpses == true then
		local all_corpses = table.Copy(MAPCONFIG.STARTING_CORPSES)
		local corpse_infos = {}

		for i=1, MAPCONFIG.Starting_Corpses_Number() do
			local random_corpse = table.Random(all_corpses)
			table.ForceInsert(corpse_infos, random_corpse)
			table.RemoveByValue(all_corpses, random_corpse)
		end
		
		for k,v in pairs(corpse_infos) do
			local corpse = table.Random(v)
			local rag = ents.Create("prop_ragdoll")
			if IsValid(rag) then
				rag:SetModel(corpse.model)
				rag:SetPos(corpse.ragdoll_pos)
				rag.IsStartingCorpse = true
				rag:Spawn()
				ApplyCorpseInfo(rag, corpse, true)
				rag.CInfo = corpse
				rag.Info = {}
				rag.Info.CorpseID = rag:GetCreationID()
				rag.Info.Victim = NULL
				rag.Info.VictimNick = "Unknown"
				rag.Info.DamageType = DMG_GENERIC
				rag.Info.Time = CurTime() - math.random(20,1400)
				rag:SetNWInt("DeathTime", rag.Info.Time)
				rag:SetNWString("ExamineDmgInfo", " - Cause of death is unknown")
				rag.Info.Loot = {}
				--local random_item = table.Random({"item_radio", "item_medkit", "ssri_pills", "item_gasmask", "item_nvg", "keycard_level1", "keycard_level2", "kanade_tfa_crowbar"})
				--table.ForceInsert(rag.Info.Loot, form_basic_item_info(random_item))
				rag.RagdollHealth = 0
				rag.nextReviveMove = 0
				
				if isfunction(corpse.setup) then
					corpse.setup(rag)
					if istable(all_fake_corpses) then
						table.ForceInsert(all_fake_corpses, rag)
						rag.Info.notepad = {}
						rag.Info.notepad.people = {
							{
								br_ci_agent = rag.br_ci_agent,
								br_role = rag.br_role,
								br_showname = rag.br_showname,
								health = HEALTH_ALIVE,
								scp = false
							}
						}
					end
				end
			end
		end
	end

	timer.Create("BR2_MAPCONFIG_CORPSEINFO", 4, 1, function()
		for k,v in pairs(ents.FindByClass("prop_ragdoll")) do
			if v.CInfo then
				--ApplyCorpseInfo(v, v.CInfo, true)
				for i=0, (v:GetPhysicsObjectCount() - 1) do
					local bone = v:GetPhysicsObjectNum(i)
					if IsValid(bone) then
						bone:EnableMotion(true)
					end
				end
			end
		end
 	end)
end

function BR_DEFAULT_MAP_Organize_Keypad_Find()
	local button_ents = {}

	local allowed_button_classes = {
		"func_button"
	}

	if istable(MAPCONFIG.KEYPADS) then
		local mapconfig_keypads = table.Copy(MAPCONFIG.KEYPADS)

		for _,ent in pairs(ents.GetAll()) do
			for i,butt in ipairs(mapconfig_keypads) do
				local ent_class = ent:GetClass()
				local ent_pos = ent:GetPos()
				local should_break = false

				if table.HasValue(allowed_button_classes, ent_class) then
					local real_butt = FindKeyPadByName(butt.name)

					if (isvector(butt.pos) and ((ent_pos == butt.pos) or (ent_pos:Distance(butt.pos) < 3)))
					or (isstring(butt.ent_name) and butt.ent_name == ent:GetName()) then
						ent.br_info = MAPCONFIG.KEYPADS[real_butt]
						table.ForceInsert(button_ents, ent)
						MAPCONFIG.KEYPADS[real_butt].ent = ent
						table.RemoveByValue(mapconfig_keypads, butt)
						break

					elseif istable(butt.pos) then
						for k,v in pairs(butt.pos) do
							if ((ent_pos == v) or (ent_pos:Distance(v) < 3)) then
								ent.br_info = MAPCONFIG.KEYPADS[real_butt]
								table.ForceInsert(button_ents, ent)
								MAPCONFIG.KEYPADS[real_butt].ent = ent
								table.RemoveByValue(butt.pos, v)

								if table.Count(butt.pos) == 0 then
									table.RemoveByValue(mapconfig_keypads, butt)
								end

								should_break = true
								break
							end
						end
					end
				end

				if should_break then
					break
				end
			end
		end

		if table.Count(mapconfig_keypads) > 0 then
			ErrorNoHaltWithStack("BUTTONS NOT FOUND:")
			for k,v in pairs(mapconfig_keypads) do
				print(v.name)
			end
		else
			devprint("All buttons found!")
		end
	else
		ErrorNoHaltWithStack("[Breach2] No buttons found...")
	end

	return button_ents
end

local allowed_button_classes = {
	"func_button"
}

function BR_DEFAULT_MAP_Organize_Keypads()
	if istable(MAPCONFIG.BUTTONS) then
		for i,butt in ipairs(MAPCONFIG.BUTTONS) do
			local button_found = false
			for k,v in pairs(ents.GetAll()) do
				if ((isstring(butt.ent_name) and butt.ent_name == v:GetName()) or
					(v:GetPos() == butt.pos) or
					(v:GetPos():Distance(butt.pos) < 3)) and table.HasValue(allowed_button_classes, v:GetClass())
				then
					if butt.ent_name then
						devprint("Found a button with name (" .. butt.ent_name .. ")")
					end
					--print("Found a button with pos (" .. tostring(butt.pos) .. ")  and level " .. butt.level)
					v.br_info = butt
					table.ForceInsert(button_ents, v)
					butt.ent = v
					button_found = true
					continue
				end
			end

			if button_found == false then
				ErrorNoHaltWithStack("Button not found", i, butt.pos)
			end
		end
	else
		ErrorNoHaltWithStack("[Breach2] No code keypads found...")
		return
	end
end

function BR_DEFAULT_MAP_Organize_KeypadCodes()
	local button_ents = BR_DEFAULT_MAP_Organize_Keypad_Find()

	-- BUTTON CODES
	local numww = 0
	local code_pairs = {}
	local code_ents = {}

	for k,v in pairs(button_ents) do
		if isnumber(v.br_info.code) then
			table.ForceInsert(code_ents, v)
		end
	end

	for k,v in pairs(code_ents) do
		if v._cpfd then continue end

		local tab_of_pairs = {v}
		for k2,v2 in pairs(code_ents) do
			if v != v2 and v.br_info.name == v2.br_info.name then
				table.ForceInsert(tab_of_pairs, v2)
				v2._cpfd = true
			end
		end
		if table.Count(tab_of_pairs) > 1 then
			table.ForceInsert(code_pairs, tab_of_pairs)
		end
	end

	for k,v in pairs(code_pairs) do
		for k2,v2 in pairs(v) do
			table.RemoveByValue(code_ents, v2)
		end
		table.ForceInsert(code_ents, v)
	end

	for k,v in pairs(code_ents) do
		local newcode = (math.random(1,9) * 1000) + (math.random(1,9) * 100) + (math.random(1,9) * 10) + math.random(1,9)
		local stack = {}
		if istable(v) then
			for k2,v2 in pairs(v) do
				table.ForceInsert(stack, v2)
			end
		else
			table.ForceInsert(stack, v)
		end

		local rnd_name = ""

		for k2,v2 in pairs(stack) do
			v2.br_info.code = newcode
			v2.br_info.code_type = "radio"
			rnd_name = v2.br_info.name
			numww = numww + 1
		end

		devprint("Found a code button, setting a new code: ("..newcode..")", rnd_name)
	end
end

local function GenerateRandomPassword()
    local str = "1234567890qwertyuiopasdfghjklzxcvbnm"
    local ret = ""
    for i=1, 4 do
        ret = ret .. str[math.random(1,36)]
    end
    return ret
end

function BR_DEFAULT_MAP_Organize_Terminals()
	BR2_TERMINALS = table.Copy(MAPCONFIG.BUTTONS_2D.TERMINALS.buttons)
	for k,v in pairs(BR2_TERMINALS) do
		v.Info = {
			tab_set = "TERMINAL_INFO_GENERIC",
			devices = {
				device_cameras = false
			}
		}

		v.Info.SettingsFunctions = v.special_functions
		if math.random(1,7) == 4 then
			v.Info.devices.device_cameras = true
		end
	end
end

function BR_DEFAULT_MAP_Organize_Outfits()
	local outfit_groups = {}
	for k,v in pairs(MAPCONFIG.BUTTONS_2D.OUTFITTERS.buttons) do
		outfit_groups[v.item_gen_group] = outfit_groups[v.item_gen_group] or {}
		table.ForceInsert(outfit_groups[v.item_gen_group], v)
		v.items = {}
	end
	
	for k_outfit_group,outfit_group in pairs(outfit_groups) do
		if istable(MAPCONFIG.OUTFIT_GENERATION_GROUPS[k_outfit_group]) then
			local gen_groups = table.Copy(MAPCONFIG.OUTFIT_GENERATION_GROUPS[k_outfit_group])
			local all_outfitters = {}

			for i = 1, table.Count(gen_groups) do
				local rnd_outfitter = table.Random(gen_groups)
				table.ForceInsert(all_outfitters, rnd_outfitter)
				table.RemoveByValue(gen_groups, rnd_outfitter)
			end

			for k_item, item in pairs(all_outfitters) do
				local rnd_outfitter = table.Random(outfit_group)
				if istable(rnd_outfitter) then
					for i = 1, item[2] do
						table.ForceInsert(rnd_outfitter.items, item[1])
					end
					table.RemoveByValue(outfit_group, rnd_outfitter)
				end
			end
		end
	end
end

function BR_DEFAULT_MAP_Organize_ItemContainers()
	local container_groups = {}

	for k,v in pairs(MAPCONFIG.BUTTONS_2D.ITEM_CONTAINERS.buttons) do
		v.locked = false
		--if math.random(1,4) == 2 and !v.canBeLocked then
		--	v.locked = true
		--else
			container_groups[v.item_gen_group] = container_groups[v.item_gen_group] or {}
			table.ForceInsert(container_groups[v.item_gen_group], v)
		--end
		v.items = {}
	end

	for k,v in pairs(MAPCONFIG.BUTTONS_2D.ITEM_CONTAINERS_CRATES.buttons) do
		container_groups[v.item_gen_group] = container_groups[v.item_gen_group] or {}
		table.ForceInsert(container_groups[v.item_gen_group], v)
		v.items = {}
		v.locked = true
	end

	for k_cont_group,cont_group in pairs(container_groups) do
		if istable(MAPCONFIG.ITEM_GENERATION_GROUPS[k_cont_group]) then
			local all_items = {}

			for k_item, item in pairs(MAPCONFIG.ITEM_GENERATION_GROUPS[k_cont_group]) do
				for i = 1, item[2] do
					table.ForceInsert(all_items, item[1])
				end
			end

			for k_button,button in pairs(cont_group) do
				if table.Count(button.items) == 0 and table.Count(all_items) > 0 then
					local rnd_item = table.Random(all_items)
					if rnd_item != nil then
						table.ForceInsert(button.items, form_basic_item_info(rnd_item))
						table.RemoveByValue(all_items, rnd_item)
					end
				end
			end

			for k_item,item in pairs(all_items) do
				local rnd_cont = table.Random(cont_group)
				if item != nil then
					table.ForceInsert(rnd_cont.items, form_basic_item_info(item))
				end
			end
		end
	end
end

function BR_DEFAULT_MAP_Organize_Cameras()
	if istable(MAPCONFIG.CAMERAS) then
		for k,v in pairs(MAPCONFIG.CAMERAS) do
			for k2,v2 in pairs(v.cameras) do
				local camera = ents.Create("br2_camera")
				
				if IsValid(camera) then
					camera:SetModel("models/props/cs_assault/camera.mdl")
					camera:SetPos(v2.pos)
					camera:SetAngles(v2.ang)
					camera:Spawn()
					camera.CameraInfo = table.Copy(v2)
					camera.CameraName = v2.name
					camera:SetNWString("CameraName", v2.name)
				end
			end
		end
	else
		ErrorNoHaltWithStack("[Breach2] No cameras found...")
		return
	end
end

usable_radio_codes = {}

function ResetRadioCodes()
	usable_radio_codes = {}
	for _,bt in pairs(MAPCONFIG.KEYPADS) do
		if isnumber(bt.code) and bt.code_can_be_obtained_by_radio then
			table.ForceInsert(usable_radio_codes, bt.code)
		end
	end
end

function GiveRadioACode(ent)
	if #usable_radio_codes < 1 then
		ResetRadioCodes()
	end

	local chosen_code = table.Random(usable_radio_codes)

	if chosen_code then
		table.RemoveByValue(usable_radio_codes, chosen_code)
		ent.Code = chosen_code
		devprint("gave a new radio code", chosen_code, ent)
	end
end

function BR_DEFAULT_MAP_Organize_AddCodeDocuments()
	local codes_to_assign = {}

	-- First find all codes that are available to be assigned!
	for _, keypad in pairs(MAPCONFIG.KEYPADS) do
		if keypad.code_spawn_in_docs then

			-- Assign the code for all code groups (duplicate it)
			if keypad.code_spawn_in_docs.method == "duplicate" then
				for _, group in pairs(keypad.code_spawn_in_docs.groups) do
					table.ForceInsert(codes_to_assign, {group, keypad.code})
				end
			else
				-- Assign only one, randomly from the groups
				table.ForceInsert(codes_to_assign, {table.Random(keypad.code_spawn_in_docs.groups), keypad.code})
			end
		end
	end

	-- Then find all item containers
	local container_groups = {}
	
	for k,v in pairs(MAPCONFIG.BUTTONS_2D.ITEM_CONTAINERS.buttons) do
		container_groups[v.item_gen_group] = container_groups[v.item_gen_group] or {}

		for _, item in pairs(v.items) do
			table.ForceInsert(container_groups[v.item_gen_group], item)
		end
	end

	for k,v in pairs(MAPCONFIG.BUTTONS_2D.ITEM_CONTAINERS_CRATES.buttons) do
		container_groups[v.item_gen_group] = container_groups[v.item_gen_group] or {}

		for _, item in pairs(v.items) do
			table.ForceInsert(container_groups[v.item_gen_group], item)
		end
	end

	-- Find all document items in those containers
	local code_groups_items = {}
	
	for item_gen_group, items in pairs(container_groups) do
		for _, item in ipairs(items) do

			-- verify that the item is a document
			for _, doc in pairs(BR2_DOCUMENTS) do
				if doc.class == item.class then

					-- assign the item into the specific code group
					for _, item_gen_info in pairs(MAPCONFIG.ITEM_GENERATION_GROUPS[item_gen_group]) do
						if item_gen_info.assign_random_code and item_gen_info[1] == item.class then
							code_groups_items[item_gen_info.assign_random_code] = code_groups_items[item_gen_info.assign_random_code] or {}
							table.ForceInsert(code_groups_items[item_gen_info.assign_random_code], item)
							break
						end
					end
					break
				end
			end
		end
	end

	for _,ent in pairs(ents.GetAll()) do
		if ent.SI_Class == "document" and isstring(ent.CodeGroup) then
			table.ForceInsert(code_groups_items[ent.CodeGroup], ent)
		end
	end

	-- Assign the codes
	for _, v in pairs(codes_to_assign) do
		local code_group = v[1]
		local code = v[2]

		local random_item = table.Random(code_groups_items[code_group])

		random_item.attributes = {doc_code = tostring(code)}

		if isentity(random_item) then
			random_item.DocAttributes = random_item.attributes
			devprint("assigned code " .. code .. " to ent doc " .. tostring(random_item:GetPos()))
		else
			devprint("assigned code " .. code .. " to doc " .. tostring(random_item.class))
		end

		table.RemoveByValue(code_groups_items[code_group], random_item)
	end
end

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

					if v.br_role == "SCP-173" then
						v:TakeDamage(math.Clamp(v:Health() / 2, 1000, v:Health()), v, nil)

					elseif v.br_role == "SCP-049" then
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

function Kanade_DebugPrint1()
	local ent = Entity(1):GetAllEyeTrace().Entity
	local ent_pos = ent:GetPos()
	local ent_ang = ent:GetAngles()
	print("{Vector("..ent_pos.x..", "..ent_pos.y..", "..ent_pos.z..")" .. ", " .. "Angle("..ent_ang.pitch..", "..ent_ang.yaw..", "..ent_ang.roll..")},")
end

print("[Breach2] server/sv_maprelated.lua loaded!")
