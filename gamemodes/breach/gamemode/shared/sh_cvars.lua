
local all_br2_cvars = {}

function br2_add_cvar(name, value, helptext)
	--if !ConVarExists(name) then CreateConVar(name, value, {FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_NOTIFY}, helptext) end
	CreateConVar(name, value, {FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_NOTIFY}, helptext)
	table.ForceInsert(all_br2_cvars, {name, value})
end

concommand.Add("br2_reset_settings", function()
	for k,v in pairs(all_br2_cvars) do
		print(v[1] .. " set to " .. v[2])
		RunConsoleCommand(v[1], v[2])
	end
end)

function GetBR2conVar(name)
	local cvar = GetConVar(name)
	if cvar == nil then return nil end
	return cvar:GetInt()
end

function SafeBoolConVar(name)
	return cvars.Bool(name, false)
end

function SafeIntConVar(name)
	return cvars.Number(name, 1)
end

function SafeFloatConVar(name)
	return cvars.Number(name, 1)
end

print("[Breach2] shared/sh_cvars.lua loaded!")
