
util.AddNetworkString("br_use_battery_on_item")

local function sendClose(pl)
	net.Start("br_use_battery_on_item")
		net.WriteBool(false)
	net.Send(pl)
end

net.Receive("br_use_battery_on_item", function(len, pl)
	local class = net.ReadString()

	local weapon = pl:GetWeapon(class)
	if IsValid(weapon) == false then
		sendClose(pl)
		return
	end

	if isnumber(weapon.BatteryLevel) == false then
		sendClose(pl)
		return
	end

	weapon.BatteryLevel = 100

	sendClose(pl)

	pl:PrintMessage(HUD_PRINTTALK, "You have replaced the battery in your " .. weapon.PrintName .. ".")

	for k,v in pairs(pl.br_special_items) do
		if v.class == "battery9v" then
			table.remove(pl.br_special_items, k)
			break
		end
	end
end)

special_item_system.AddItem({
    class = "battery9v",
    name = "9V Battery",
    upgrade = function(ent)
        return ent
    end,
    func = function(pl, ent)
        table.ForceInsert(pl.br_special_items, {class = "battery9v"})
        return true
    end,
    use = function(pl, item)
		net.Start("br_use_battery_on_item")
			net.WriteBool(true)
		net.Send(pl)

        return false
    end,
    onstart = function(pl)
        if pl.br_role == ROLE_JANITOR then
            table.ForceInsert(pl.br_special_items, {class = "battery9v"})
        end
    end,
    drop = function(pl, item)
        local res, item = br2_special_item_drop(pl, "battery9v", "9V Battery", "prop_physics", "models/mishka/models/battery.mdl", item)
        return item
    end
})
