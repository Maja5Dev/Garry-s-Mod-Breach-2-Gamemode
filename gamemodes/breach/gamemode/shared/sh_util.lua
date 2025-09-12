
function MathRandom(num)
	return (math.Round(math.random(1, 99999999) % (num)) + 1)
end

function TableRandom(tbl)
	return tbl[MathRandom(#tbl)]
end

function NiceVector(pos) -- used only for debugging
	return "Vector("..pos.x..", "..pos.y..", "..pos.z..")"
end

function NiceAngle(ang) -- used only for debugging
	return "Angle("..ang.yaw..", "..ang.pitch..", "..ang.roll..")"
end

function DebugNiceVecAngTab()
	local tr = Entity(1):GetEyeTrace()
	if tr.HitWorld then
		return "hit world"
	end
	local pos = tr.Entity:GetPos()
	local ang = tr.Entity:GetAngles()
	return "{" .. NiceVector(pos) .. ", " .. NiceAngle(ang) .. "},"
end

function devprint(data) -- used only for debugging
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
	"kanade_tfa_acr",
	"kanade_tfa_ak103",
	"kanade_tfa_ar15",
	"kanade_tfa_aug",
	"kanade_tfa_cobra",
	"kanade_tfa_colt",
	"kanade_tfa_cz805",
	"kanade_tfa_deagle",
	"kanade_tfa_dsr1",
	"kanade_tfa_f90mbr",
	"kanade_tfa_famas",
	"kanade_tfa_fnfal",
	"kanade_tfa_fnp45",
	"kanade_tfa_g3",
	"kanade_tfa_g36",
	"kanade_tfa_hkg36c",
	"kanade_tfa_gry",
	"kanade_tfa_krissv",
	"kanade_tfa_l85a2",
	"kanade_tfa_makarov",
	"kanade_tfa_mosin",
	"kanade_tfa_mp5a5",
	"kanade_tfa_p90",
	"kanade_tfa_remington",
	"kanade_tfa_sawedoff",
	"kanade_tfa_scar",
	"kanade_tfa_scarh",
	"kanade_tfa_sg552",
	"kanade_tfa_tac338",
	"kanade_tfa_vhs",
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