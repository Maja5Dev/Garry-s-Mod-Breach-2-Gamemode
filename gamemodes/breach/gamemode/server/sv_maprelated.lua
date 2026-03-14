
include("map_related/cameras.lua")
include("map_related/codes.lua")
include("map_related/generators.lua")
include("map_related/hiding_closets.lua")
include("map_related/items.lua")
include("map_related/keypads.lua")
include("map_related/outfitters.lua")
include("map_related/ragdolls.lua")
include("map_related/scp_914.lua")
include("map_related/terminals.lua")

function FindKeyPadByName(name)
	for i,v in ipairs(MAPCONFIG.KEYPADS) do
		if v.name == name then
			return i
		end
	end
end

function Breach_FixMapHDRBrightness()
	for k,v in pairs(ents.FindByClass("env_tonemap_controller")) do
		v:Fire("UseDefaultAutoExposure", "0", 0)
		v:Fire("SetAutoExposureMin", "0.5", 0)
		v:Fire("SetAutoExposureMax", "1", 0)
	end
end

function Breach_SCP294_Keyboard(ply)
	if IsValid(uses_294) and uses_294:Alive() and !uses_294:IsSpectator() and !uses_294.br_downed then
		uses_294:BR2_ShowNotification("Someone else used the SCP-294")
		uses_294:SendLua("CloseSCP_294()")
	end

	if MAP_SCP_294_Coins == 2 then
		ply:SendLua("OpenSCP_294()")
		uses_294 = ply

	elseif MAP_SCP_294_Coins == 1 then
		ply:PrintMessage(HUD_PRINTTALK, "You need to insert one more coin")
	else
		ply:PrintMessage(HUD_PRINTTALK, "You need to insert two coins")
	end
end

function Breach_SCP294_Coiner(ply, sound_pos)
	if MAP_SCP_294_Coins == 2 then
		ply:PrintMessage(HUD_PRINTTALK, "Coins are already in")
	else
		for k,v in pairs(ply.br_special_items) do
			if v.class == "coin" then
				ply:PrintMessage(HUD_PRINTTALK, "Inserted a coin in")
				sound.Play("ambient/office/coinslot1.wav", sound_pos, 75, 100, 1)
				MAP_SCP_294_Coins = MAP_SCP_294_Coins + 1
				table.RemoveByValue(ply.br_special_items, v)
				return
			end
		end

		ply:PrintMessage(HUD_PRINTTALK, "You don't have any coins!")
	end
end

function Breach_SCP1162(ply)
	local owned_weps = {}
	for k,v in pairs(ply:GetWeapons()) do
		if v.Pickupable == true or v.droppable == true or table.HasValue(BR2_LETHAL_WEAPONS, v:GetClass()) then
			table.ForceInsert(owned_weps, v)
		end
	end

	if table.Count(owned_weps) == 0 and table.Count(ply.br_special_items) == 0 then
		ply:TakeDamage(20, ply, ply)
		ply:BleedEffect()
	else

		local rnd_class = table.Random(BR2_SCP_1162_DROPS)

		local ent = nil
		for k,v in pairs(BR2_SPECIAL_ITEMS) do
			if v.class == rnd_class then
				ent = v.drop(ply)
				break
			end
		end
		
		if ent == nil then
			if istable(rnd_class) then
				ent = ents.Create(rnd_class[1])
			else
				ent = ents.Create(rnd_class)
			end
		end

		if IsValid(ent) then
			ent:SetPos(Vector(893,882,-8144))
			ent:SetNWBool("isDropped", true)
			ent:Spawn()

			if istable(rnd_class) then
				rnd_class[2](ply, ent)
			end

			local rnd_wep = table.Random(owned_weps)
			if IsValid(rnd_wep) then
				ply:StripWeapon(rnd_wep:GetClass())
			else
				local rnd_item = table.Random(ply.br_special_items)
				table.RemoveByValue(ply.br_special_items, rnd_item)
			end
		end
	end
end

print("[Breach2] server/sv_maprelated.lua loaded!")
