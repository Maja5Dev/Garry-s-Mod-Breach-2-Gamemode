
usable_radio_codes = {}

function ResetRadioCodes()
	usable_radio_codes = {}

	for _,bt in pairs(MAPCONFIG.KEYPADS) do
		if isnumber(bt.code) and bt.code_can_be_obtained_by_radio then
			table.ForceInsert(usable_radio_codes, bt.code)
		end
	end
end
hook.Add("BR2_Map_Organise", "BR2_ResetRadioCodes", ResetRadioCodes)

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
