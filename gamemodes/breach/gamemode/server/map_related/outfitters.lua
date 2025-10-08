
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
