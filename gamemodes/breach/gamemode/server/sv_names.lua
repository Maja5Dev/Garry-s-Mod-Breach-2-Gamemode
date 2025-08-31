
function ForceSetPrintName(ent, name)
	net.Start("br_force_print_name")
		net.WriteEntity(ent)
		net.WriteString(name)
	net.Broadcast()
end

-- lua_run TestRandomNames()
function TestRandomNames()
	round_system.current_names = table.Copy(round_system.current_scenario.name_list)
	
	local names_got = {}
	local times_to_do = 256
	for i=1, times_to_do do
		table.ForceInsert(names_got, GetRandomName())
	end

	local num_duplicates = 0
	for k,v in pairs(names_got) do
		local names_got_w = table.Copy(names_got)
		table.RemoveByValue(names_got_w, v)
		for k2, v2 in pairs(names_got_w) do
			if v == v2 then
				print("[Duplicate found] " ..  v .. " - " .. v2)
				num_duplicates = num_duplicates + 1
			end
		end
	end

	print("random ("..times_to_do..") - duplicates: " .. num_duplicates)
	local n_dup = {}
	local s_dup = {}

	for k,v in pairs(BREACH_NAMES.names) do
		local n2 = table.Copy(BREACH_NAMES.names)
		table.RemoveByValue(n2, v)
		for k2,v2 in pairs(n2) do
			if v == v2 then
				table.ForceInsert(n_dup, v2)
			end
		end
	end

	for k,v in pairs(BREACH_NAMES.surnames) do
		local n2 = table.Copy(BREACH_NAMES.surnames)
		table.RemoveByValue(n2, v)
		for k2,v2 in pairs(n2) do
			if v == v2 then
				table.ForceInsert(s_dup, v2)
			end
		end
	end
	
	print("Names - duplicates (" .. #n_dup .. ")")
	PrintTable(n_dup)
	print("Surnames - duplicates (" .. #s_dup .. ")")
	PrintTable(s_dup)
	print("Max posibilities: " .. #BREACH_NAMES.names * #BREACH_NAMES.surnames)
	
end

apn = {}
function create_all_possible_names()
	apn = {}
	for k,v in pairs(round_system.current_scenario.name_list.surnames) do
		for k2,v2 in pairs(round_system.current_scenario.name_list.names) do
			table.ForceInsert(apn, v2 .. " " .. v)
		end
	end
end

function GetRandomName()
	local rand_name = table.Random(apn)
	if rand_name == nil then
		create_all_possible_names()
		rand_name = table.Random(apn)
	end
	table.RemoveByValue(apn, rand_name)
	return rand_name
end

print("[Breach2] server/sv_names.lua loaded!")