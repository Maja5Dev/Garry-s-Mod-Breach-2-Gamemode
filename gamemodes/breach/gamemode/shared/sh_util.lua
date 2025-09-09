
function MathRandom(num)
	return (math.Round(math.random(1, 99999999) % (num)) + 1)
end

function TableRandom(tbl)
	return tbl[MathRandom(#tbl)]
end

function NiceVector(pos) -- used only for debugging
	return "Vector("..pos.x..","..pos.y..","..pos.z..")"
end

function bprint(data) -- used only for debugging
	if GetConVar("developer"):GetInt() > 0 then
		print(data)
	end
end

function GetAlivePlayers()
	local tab = {}
	
	for k,v in pairs(player.GetAll()) do
		if v:Alive() and v:IsSpectator() == false then
			table.ForceInsert(tab, v)
		end
	end
	
	return tab
end

function GetBRteamPlayers(br_team)
	local tab = {}
	for k,v in pairs(player.GetAll()) do
		if v:Alive() and v:IsSpectator() == false and v.br_team == br_team then
			table.ForceInsert(tab, v)
		end
	end
	return tab
end

function isBreachWeapon(ent)
	if ent.Category == "Breach 2 Weapons" or ent.Category == "Kanade's TFA Pack" or ent.ISSCP then
		return true
	end
	return false
end

local lethal_weapons = {
	"kanade_tfa_beretta",
	"kanade_tfa_m1911",
	"kanade_tfa_mp5k",
	"kanade_tfa_mk18",
	"kanade_tfa_ump45",
	"kanade_tfa_m4a1",
	"kanade_tfa_m16a4",
	"kanade_tfa_m590",
	"kanade_tfa_m249",
	"kanade_tfa_rpk",
	"kanade_tfa_m14",
	
	"kanade_tfa_sterling",
	"kanade_tfa_rpg",
	"kanade_tfa_mp7",
	"kanade_tfa_m1014",
	"kanade_tfa_m40a1",
	"kanade_tfa_glock",
	"kanade_tfa_g36c",
	"kanade_tfa_ak12",
}

function isLethalWeapon(ent)
	for k,v in pairs(lethal_weapons) do
		if v == ent:GetClass() then return true end
	end
	return false
end

local lowercaseWords = {
    ["of"] = true,
    ["a"]  = true,
    ["the"] = true,
    ["an"] = true,
    ["and"] = true,
    ["in"] = true,
    ["on"] = true,
    ["at"] = true,
    ["to"] = true,
    ["for"] = true,
    ["but"] = true,
    ["or"] = true
}

function TitleCase(str)
    local result = {}
    local i = 0

    for word in string.gmatch(str, "%S+") do
        i = i + 1
        local lower = string.lower(word)

        if i > 1 and lowercaseWords[lower] then
            table.insert(result, lower)
        else
            -- capitalize first letter, keep rest lowercase
            table.insert(result, string.upper(string.sub(lower, 1, 1)) .. string.sub(lower, 2))
        end
    end

    return table.concat(result, " ")
end


print("[Breach2] shared/sh_util.lua loaded!")