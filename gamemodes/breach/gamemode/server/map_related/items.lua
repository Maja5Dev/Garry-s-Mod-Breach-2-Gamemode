
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
	
	local wwep = weapons.Get(class)
	if wwep == nil then
		ErrorNoHalt("Couldn't find a weapon class: " .. class)
	end

	return {class = class, ammo = amount or 0, name = wwep.PrintName}
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
