
local function findPickupables(self)
	local filter = self.Owner

	for k,v in pairs(ents.GetAll()) do
		if v:GetModel() == "models/vinrax/scp294/scp294.mdl" then
			filter = {self.Owner, v}
		end
	end

	local tr = util.TraceLine({
		start = self.Owner:EyePos(),
		endpos = self.Owner:EyePos() + (self.Owner:EyeAngles():Forward() * 70),
		filter = filter
	})

	local pickupable_items = {}

	for k,v in pairs(ents.FindInSphere(tr.HitPos, 40)) do
		if v:GetNWBool("isDropped", false) == true and !IsValid(v.Owner) then
			tr = util.TraceHull({
				start = self.Owner:EyePos(),
				endpos = v:GetPos(),
				mins = Vector(-4, -4, -4),
				maxs = Vector(4, 4, 4),
				filter = filter
			})

			if tr.Entity == v then
				table.ForceInsert(pickupable_items, v)
			end
		end
	end
	
	local entf = LocalPlayer():GetAllEyeTrace().Entity

	if IsValid(entf) and entf:GetNWBool("isDropped", false) == true and !IsValid(entf.Owner) and entf:GetPos():Distance(LocalPlayer():GetPos()) < 150 then
		local found = false

		for k,v in pairs(pickupable_items) do
			if v == entf then
				found = true
			end
		end

		if found == false then
			table.ForceInsert(pickupable_items, entf)
		end
	end

    return pickupable_items
end

hook.Add("BR2_OnHandsAddActions", "AddPickupItemsActions", function(self)
    local pickupable_items = findPickupables(self)

	for i,v in ipairs(pickupable_items) do
		local item_name = ""

		for k2,v2 in pairs(BR_ITEM_NAMES_FROM_MODELS) do
			if v2[1] == v:GetModel() then
				item_name = v2[2]
			end
		end
		
		if string.len(v:GetNWString("SetPrintName", "")) > 0 then
			item_name = v:GetNWString("SetPrintName", "")

		elseif isfunction(v.GetPrintName) and string.len(v:GetPrintName(), "") > 0  then
			item_name = v:GetPrintName()

		elseif v.PrintName then
			item_name = v.PrintName
		end
		
		addTemporaryHandsAction("pickup_item_" .. i .. "", {
			name = "Pick up " .. item_name .. "",
			desc = "Pick up the item",
			background_color = Color(0,150,150),

            canDo = true,

			cl_effect = function(self)
				chat.AddText(Color(255,255,255,255), "Trying to pick up: "..item_name.."...")

				net.Start("br_pickup_item")
					net.WriteEntity(v)
				net.SendToServer()
			end,

			cl_after = function()
				WeaponFrame:Remove()
			end
		})
	end
end)
