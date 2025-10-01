
BR2_SPECIAL_BUTTONS = {}

/* example
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
*/

local function fix914()
	if table.Count(player.GetAll()) == 0 then
		timer.Create("BR_Map_Fix914", 5, 1, fix914)
		return
	end

	for k,v in pairs(ents.GetAll()) do
		if v:GetClass() == "func_button" and v:GetPos():Distance(BR2_Get_914_1_Pos()) < 4 then
			v:Use(player.GetAll()[1], player.GetAll()[1], USE_ON, 1)
		end
	end
end

function Breach_Map_Organise_AfterAssign()
	local scp035exists = false
	for k,v in pairs(player.GetAll()) do
		if IsValid(v) and v:Alive() and !v:IsSpectator() and v.br_role == "SCP-035" then
			scp035exists = true
			break
		end
	end

	if !scp035exists then
		local rnd = math.random(1,2)

		if rnd == 1 then
			local mask035 = ents.Create("breach_035mask")

			if IsValid(mask035) then
				local tab = table.Random(MAPCONFIG.SPAWNS_ENT_SCP_035)
				mask035:SetPos(tab[1])
				mask035:SetAngles(tab[2])
				mask035:Spawn()
			end
		else
			local all_viable_corpses = {}
			for k,v in pairs(ents.GetAll()) do
				if v:GetClass() == "prop_ragdoll" and v.IsStartingCorpse then
					table.insert(all_viable_corpses, v)
				end
			end

			local rnd_corpse = table.Random(all_viable_corpses)
			if IsValid(rnd_corpse) then
				local mask035 = ents.Create("breach_035mask")
				if IsValid(mask035) then
					mask035:Spawn()
					mask035:SetPos(rnd_corpse:GetPos() + Vector(0,0,15))
				end
			end
		end
	end
end

hook.Add("Tick", "Position035", function()

end)

function Breach_Map_Organise()
	devprint("organising the map...")

	Breach_FixMapHDRBrightness()

	timer.Create("BR_Map_FixMapHDRBrightness_Timer", 1, 1, function()
		Breach_FixMapHDRBrightness()
	end)

	MAP_SCP_294_Coins = 0

	BR2_SPECIAL_BUTTONS = {}

	timer.Remove("BR_Map_Fix914")

	for k,v in pairs(ents.GetAll()) do
		local name = v:GetName():lower()
		if string.find(name, "spec_button") then
			BR2_SPECIAL_BUTTONS[name] = v
		end
	end

	timer.Create("BR_Map_Fix914", 1, 1, fix914)
	
	timer.Remove("BR_Unlock173")
	timer.Remove("BR_Unlock173")
	timer.Create("BR_Unlock173", cvars.Number("br2_time_preparing", 25) + cvars.Number("br2_time_unlock_scps", 25), 1, function()
		for k,v in pairs(ents.GetAll()) do
			local name = v:GetName():lower()
			if name == "open173doors" then
				local rnd_pl = table.Random(player.GetAll())
				if IsValid(rnd_pl) then
					v:Use(rnd_pl, rnd_pl, 1, 1)
				end
			end
		end
	end)

	/*
	timer.Remove("BR_SCP008")
	timer.Remove("BR_SCP008_2")
	timer.Create("BR_SCP008", 5, 1, function()
		for k,v in pairs(ents.GetAll()) do
			local name = v:GetName():lower()
			if name == "008_containment_door" then
				local rnd_pl = table.Random(player.GetAll())
				if IsValid(rnd_pl) then
					v:Use(rnd_pl, rnd_pl, 1, 1)
				end
			end
		end
	end)

	local scp_008_time = GetConVar("br2_time_008_open"):GetInt()
	timer.Create("BR_SCP008_2", scp_008_time, 1, function()
		for k,v in pairs(ents.GetAll()) do
			local name = v:GetName():lower()
			if name == "008_containment_door" then
				local tr = util.TraceLine({
					start = Vector(-1586,4896,-7088),
					endpos = Vector(-1579,4896,-7088),
				})
				if tr.Hit then
					local rnd_pl = table.Random(player.GetAll())
					v:Use(rnd_pl, rnd_pl, 1, 1)
				end
			end
		end
	end)
	*/

	BR_DEFAULT_MAP_Organize_ItemSpawns()

	br2_914_disabled = false
	br_914status = 1
	
	/*
	br2_914_fix_ent_1 = ents.Create("prop_physics")
	if IsValid(br2_914_fix_ent_1) then
		br2_914_fix_ent_1:SetPos(Vector(783.786865, -610.382507, -8192.000000))
		br2_914_fix_ent_1:SetModel("models/hunter/plates/plate2x3.mdl")
		br2_914_fix_ent_1:SetMaterial("phoenix_storms/metalset_1-2")
		br2_914_fix_ent_1:Spawn()
		local phys = br2_914_fix_ent_1:GetPhysicsObject()
		if IsValid(phys) then
			phys:EnableMotion(false)
		end
	end
	
	br2_914_fix_ent_2 = ents.Create("prop_physics")
	if IsValid(br2_914_fix_ent_2) then
		br2_914_fix_ent_2:SetPos(Vector(783.786865, -1060.382568, -8192))
		br2_914_fix_ent_2:SetModel("models/hunter/plates/plate2x3.mdl")
		br2_914_fix_ent_2:SetMaterial("phoenix_storms/metalset_1-2")
		br2_914_fix_ent_2:Spawn()
		local phys = br2_914_fix_ent_2:GetPhysicsObject()
		if IsValid(phys) then
			phys:EnableMotion(false)
		end
	end
	*/
	
	if SafeBoolConVar("br2_testing_mode") == false then
		SpawnMapNPCs()
	end

    BR_DEFAULT_MAP_Organize_Corpses()
    BR_DEFAULT_MAP_Organize_Terminals()
	BR_DEFAULT_MAP_Organize_Outfits()
    BR_DEFAULT_MAP_Organize_ItemContainers()
    BR_DEFAULT_MAP_Organize_Cameras()
	BR_DEFAULT_MAP_Organize_KeypadCodes()
	BR_DEFAULT_MAP_Organize_Keypads()

	BR_DEFAULT_MAP_Organize_AddCodeDocuments()
end

