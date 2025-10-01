
local AssignedNumbers = {}

local function GenerateUniqueNumber()
    local num
    repeat
        num = math.random(1000, 9999) -- generates 4-digit number
    until not AssignedNumbers[num]    -- repeat if already taken

    AssignedNumbers[num] = true       -- mark as used
    return num
end

function assign_system.Assign_ClassD(ply)
	Pre_Assign(ply)
	ply:ApplyOutfit("class_d")
	ply:Give("br_hands")

	local d9341_exists = false
	for k,v in pairs(player.GetAll()) do
		if v.br_showname == "D-9341" then
			d9341_exists = true
			break
		end
	end

	if !d9341_exists and math.random(1,50) == 21 then
		ply.br_showname = "D-9341"
	else
		local uniqueNum = GenerateUniqueNumber()
        ply.br_showname = "D-" .. uniqueNum
	end

	if ply.br_showname == "D-9341" then
		ply.isTheOne = true
	end

	ply.br_hunger = 90
	ply.br_thirst = 90
	ply.br_sanity = math.random(85, 100)
	ply.br_role = "Class D"
	ply.br_usesSanity = true
	ply.br_usesTemperature = true

	if ply.support_spawning == false then
		ply.br_support_spawns = {{"class_d", 1}, {"mtf", 1}}
		ply.first_info = "classd"
		ply.mission_set = "classd"
	end
	--ply:SetNWInt("br_support_team", SUPPORT_ROGUE)
	ply.br_support_team = SUPPORT_ROGUE
	ply.br_special_items = {
		{class = "document", name = "Class D Leaflet", type = "doc_leaflet", attributes = {doc_code = ply.br_showname}}
	}
	Post_Assign(ply)
	ply.DefaultWeapons = {"br_hands"}
	ply.canEscape = true
end

function assign_system.Assign_ClassD9341(ply)
	Pre_Assign(ply)
	ply:ApplyOutfit("class_d")
	ply:Give("br_hands")
	ply.br_showname = "D-9341"
	ply.isTheOne = true
	ply.br_role = "Class D"
	ply.br_usesSanity = true
	ply.br_usesTemperature = true
	ply.br_support_spawns = {}
	--ply:SetNWInt("br_support_team", SUPPORT_ROGUE)
	if ply.support_spawning == false then
		ply.br_support_team = SUPPORT_ROGUE
		ply.first_info = "classd"
		ply.mission_set = "classd"
	end
	Post_Assign(ply)
	ply.DefaultWeapons = {"br_hands"}
	ply.canEscape = true
end

print("[Breach2] server/sv_assign_players.lua loaded!")
