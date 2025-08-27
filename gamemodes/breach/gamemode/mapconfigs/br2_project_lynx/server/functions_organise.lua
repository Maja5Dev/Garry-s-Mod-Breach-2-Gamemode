
BR2_SPECIAL_BUTTONS = {}

local function GenerateRandomPassword()
    local str = "1234567890qwertyuiopasdfghjklzxcvbnm"
    local ret = ""
    for i=1, 4 do
        ret = ret .. str[math.random(1,36)]
    end
    print("random pass: " .. ret)
    return ret
end

function MAP_ON_ROUND_START()
	print("opening scp chambers")
	local scp_doors = {
		--{ents.FindByName("049_door")[1], "open"},
		--{ents.FindInSphere(Vector(6376, -3958, 295.29998779297), 60)[1], "use"}
	}
	for k,v in pairs(scp_doors) do
		if IsValid(v[1]) then
			v[1]:Fire(v[2], "", 0)
		end
	end
end
hook.Add("BR2_RoundStart", "MAP_ROUNDSTART", MAP_ON_ROUND_START)

function Breach_Map_Organise()
	print("organising the map...")

	BR_DEFAULT_MAP_Organize_HidingClosets()

	MAP_SCP_294_Coins = 0

	BR_DEFAULT_MAP_Organize_ItemSpawns()

	br2_914_disabled = false
	br_914status = 1

	BR_DEFAULT_MAP_Organize_Corpses()
	BR_DEFAULT_MAP_Organize_Terminals()
	BR_DEFAULT_MAP_Organize_Outfits()
	BR_DEFAULT_MAP_Organize_ItemContainers()
	BR_DEFAULT_MAP_Organize_Cameras()
	local button_ents = BR_DEFAULT_MAP_Organize_Keypads()

	if SafeBoolConVar("br2_testing_mode") == false then
		SpawnMapNPCs()
	end

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

	rz_open_code = nil

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

		print("Found a code button, setting a new code: ("..newcode..")", rnd_name)

	end
	print("ALL CODE BUTTONS: " .. numww)

	ResetRadioCodes()
end

print("[Breach2] Server/Functions/Organise mapconfig loaded!")