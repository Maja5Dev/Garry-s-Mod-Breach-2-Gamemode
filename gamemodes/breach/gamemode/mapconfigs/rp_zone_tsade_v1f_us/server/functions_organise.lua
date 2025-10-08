
BR2_SPECIAL_BUTTONS = {}

local things_to_open = {
	{"func_button", Vector(7866.9301757813, -1564, -920), "use"},
	{"func_button", Vector(7869.9301757813, -1124, -920), "use"},
	{"func_button", Vector(6393.5, -330, -805), "use"},
}

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

	RZ_Open_Code()
end
hook.Add("BR2_RoundStart", "MAP_ROUNDSTART", MAP_ON_ROUND_START)

rz_open_code = nil

local function rz_give_code_to(ply)
	notepad_system.AddAutomatedInfo(ply, "Checkpoint code: "..rz_open_code.."")
	notepad_system.UpdateNotepad(ply)
end

local function rz_give_doc_code_to(ply)
	table.ForceInsert(ply.br_special_items, {class = "document", name = "SCP Object Classes", type = "doc_object_classes", attributes = {doc_code = tostring(rz_open_code)}})
end

function RZ_Open_Code()
	if rz_open_code then
		local rz_chance = math.random(1,3)
		rz_chance = 1

		-- give the code to a random ci researcher spy and a random researcher
		if rz_chance == 1 then
			local all_ci_researchers = {}
			local all_researchers = {}
			for k,v in pairs(player.GetAll()) do
				if v.br_role == ROLE_RESEARCHER then
					if v.br_team == TEAM_CI then
						table.ForceInsert(all_ci_researchers, v)
					else
						table.ForceInsert(all_researchers, v)
					end
				end
			end

			local gave_doc = false

			if table.Count(all_ci_researchers) > 0 then
				local rnd_ci_res = table.Random(all_ci_researchers)
				--print("rnd_ci_res", rnd_ci_res)
				if math.random(1,2) == 1 then
					rz_give_doc_code_to(rnd_ci_res)
					gave_doc = true
				else
					rz_give_code_to(rnd_ci_res)
				end
			end

			if table.Count(all_researchers) > 0 then
				local rnd_res = table.Random(all_researchers)
				--print("rnd_res", rnd_res)
				if !gave_doc and math.random(1,2) == 1 then
					rz_give_doc_code_to(rnd_res)
				else
					rz_give_code_to(rnd_res)
				end
			end
		end
	end
end

hook.Add("BR2_SupportSpawned", "rz_give_late_researcher_code", function(ply)
	if IsValid(ply) and ply:Alive() and !ply:IsSpectator() and ply.br_role == ROLE_RESEARCHER and IsRoundTimeProgress(0.25) then
		rz_give_code_to(ply)
		ply:ChatPrint("Check your notepad for additional information")
	end
end)

function Breach_Map_Organise()
	print("organising the map...")

	Breach_FixMapHDRBrightness()

	timer.Create("BR_Map_FixMapHDRBrightness_Timer", 1, 1, function()
		Breach_FixMapHDRBrightness()
	end)

	-- open certain things
	for k,v in pairs(ents.GetAll()) do
		for k2,v2 in pairs(things_to_open) do
			if v:GetClass() == v2[1] and v:GetPos() == v2[2] then
				--print("found open thing: ", v)
				v:Fire(v2[3], "", 0)
			end
		end
	end

	BR_DEFAULT_MAP_Organize_HidingClosets()

	MAP_SCP_294_Coins = 0

	BR_DEFAULT_MAP_Organize_ItemSpawns()

	br2_914_disabled = false
	br_914status = 1
	
	local button_ents = {}

	BR_DEFAULT_MAP_Organize_Corpses()
	BR_DEFAULT_MAP_Organize_Terminals()
	BR_DEFAULT_MAP_Organize_Outfits()
	BR_DEFAULT_MAP_Organize_ItemContainers()
	BR_DEFAULT_MAP_Organize_Cameras()

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

		if rnd_name == "LCZ_RESEARCHAREA_CHECKPOINT" then
			rz_open_code = newcode
		end

		print("Found a code button, setting a new code: ("..newcode..")", rnd_name)

	end

	print("rz_open_code: ", rz_open_code)
end
hook.Add("BR2_Map_Organise", "BR2_Map_Breach_Map_Organise", Breach_Map_Organise)

print("[Breach2] Server/Functions/Organise mapconfig loaded!")