
function LockPickFunc(ply, v)
	for k,pl in pairs(player.GetAll()) do
		if pl.startedLockpicking and pl.startedLockpicking[2] + 9.1 > CurTime() then
			ply:ChatPrint("Someone else is lockpicking this crate...")
			return
		end
	end

	ply.startedLockpicking = {v, CurTime()}
	ply:SendLua("StartLockpicking()")
	ply:EmitSound("breach2/lockpick.mp3")
end

function br2_special_item_drop(pl, class, name, force_class, mdl, item)
	local dropped_ent = ents.Create(force_class)

	if IsValid(dropped_ent) then
		if IsValid(pl) then
			local tr = util.TraceLine({
				start = pl:EyePos(),
				endpos = pl:EyePos() + (pl:EyeAngles():Forward() * 30),
				filter = pl
			})

			if tr.Hit == false then
				dropped_ent:SetPos(tr.HitPos)
			else
				dropped_ent:SetPos(pl:EyePos())
			end

			dropped_ent:SetAngles(Angle(-10, pl:EyeAngles().yaw, 0))
		end

		if mdl then
			dropped_ent:SetModel(mdl)
		end

		dropped_ent:Spawn()
		dropped_ent.SI_Class = class
		dropped_ent.PrintName = name
		ForceSetPrintName(dropped_ent, name)
		dropped_ent:SetNWBool("isDropped", true)
		
		if istable(item) and item.attributes then
			dropped_ent.Attributes = item.attributes

		elseif isentity(item) and item.Attributes then
			dropped_ent.Attributes = item.Attributes
		end
		
		local phys = dropped_ent:GetPhysicsObject()
		if IsValid(phys) then
			phys:Wake()
			phys:SetMass(5)
			if IsValid(pl) then
				phys:ApplyForceCenter(pl:EyeAngles():Forward() * 1000)
			end
		end

		if IsValid(pl) and pl:Alive() and !pl:IsSpectator() then
			for k,v in pairs(pl.br_special_items) do
				if item and !spi_comp(item, v) then continue end
				if v.class == class then
					table.RemoveByValue(pl.br_special_items, v)
					return true, dropped_ent
				end
			end
		else
			return true, dropped_ent
		end

		-- scp 1162 and 914 use this
		--error("created item but didn't find it " .. class .. " " .. name .. " " .. mdl)
	end

	return false, dropped_ent
end

function weed_effects(ply)
	ply:StartCustomScreenEffects({
		colour = 2,
		tt1 = 4,
		tt2 = 6,
		vignette_alpha = 100
	}, 15)
	ply:BR2_ShowNotification("MAN DATS SOM GOOD ASS SHIT")
	ply:AddRunStamina(-500)
	ply:AddJumpStamina(-00)
	ply:AddSanity(40)
	ply:SendLua("surface.PlaySound(\"breach2/420J.ogg\")")
end

-- lua_run Entity(1).br_special_items[1] = {class = "device_cameras"}

BR2_SPECIAL_ITEMS = {
	{
		class = "device_cameras",
		name = "WCR [Cameras]",
		func = function(pl)
			table.ForceInsert(pl.br_special_items, {class = "device_cameras"})
			return true
		end,
		use = function(pl)
			pl:PrintMessage(HUD_PRINTTALK, "Installed in terminals, used to check the cameras")
		end,
		onstart = function(pl)
			if pl.br_role == ROLE_ENGINEER and math.random(1,5) == 2 then
				table.ForceInsert(pl.br_special_items, {class = "crafting_toolbox"})
			end
		end,
		drop = function(pl)
			local res, item = br2_special_item_drop(pl, "device_cameras", "WCR [Cameras]", "prop_physics", "models/props_lab/reciever01c.mdl")
			return item
		end
	},
}

special_item_system = {}

special_item_system.AddItem = function(tab)
	devprint("Registering item " .. tab.class)
	table.ForceInsert(BR2_SPECIAL_ITEMS, tab)
end

special_item_system.GetItem = function(class)
	for k,v in pairs(BR2_SPECIAL_ITEMS) do
		if v.class == class then
			return v
		end
	end
end

function gvi_d(name)
	table.ForceInsert(Entity(1).br_special_items,
		{class = "document", name = "Printed Document", type = name, attributes = {doc_code = "9999"}
	})
end

function gvi(name) -- for debug purposes
	table.ForceInsert(Entity(1).br_special_items, {class=name})
end

include("items/access_items.lua")
include("items/ammo.lua")
include("items/documents.lua")
include("items/drinks.lua")
include("items/flashlights.lua")
include("items/food.lua")
include("items/medical.lua")
include("items/scp_294.lua")
include("items/toolbox.lua")
include("items/batteries.lua")

print("[Breach2] server/sv_items.lua loaded!")