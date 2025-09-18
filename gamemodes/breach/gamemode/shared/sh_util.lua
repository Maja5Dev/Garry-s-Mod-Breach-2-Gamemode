
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
