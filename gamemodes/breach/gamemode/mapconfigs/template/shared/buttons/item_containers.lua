
MAPCONFIG.BUTTONS_2D.ITEM_CONTAINERS = {
	mat = button_icons.scpu,
	on_open = function(button)
		TryToOpenContainer(button)
	end,
	buttons = {
		{pos = XXXXXXXXXXXXXXXXXXXXXXX, canSee = DefaultItemContainerCanSee, item_gen_group = "BBBBBBBBBBBBBBB"}, -- ZZZZZZZZZZZZZZ
	}
}

MAPCONFIG.BUTTONS_2D.ITEM_CONTAINERS_CRATES = {
	mat = button_icons.scpu_locks,
	on_open = function(button)
		TryToOpenCrate(button)
	end,
	buttons = {
	--LCZ
		{pos = XXXXXXXXXXXXXXXXXXXXXXX, canSee = DefaultItemContainerCanSee, item_gen_group = "BBBBBBBBBBBBBBB"}, -- ZZZZZZZZZZZZZZ
	--HCZ
		{pos = XXXXXXXXXXXXXXXXXXXXXXX, canSee = DefaultItemContainerCanSee, item_gen_group = "BBBBBBBBBBBBBBB"}, -- ZZZZZZZZZZZZZZ
	
	--EZ
		{pos = XXXXXXXXXXXXXXXXXXXXXXX, canSee = DefaultItemContainerCanSee, item_gen_group = "BBBBBBBBBBBBBBB"}, -- ZZZZZZZZZZZZZZ
	}
}

MAPCONFIG.BUTTONS_2D.OUTFITTERS = {
	mat = button_icons.scpu,
	on_open = function(button)
		if button == nil or LocalPlayer():GetOutfit().can_change_outfits == false then
			chat.AddText(Color(255, 255, 255), "You couldn't find anything useful...")
			return
		end
		net.Start("br_use_outfitter")
			net.WriteVector(button.pos)
		net.SendToServer()
	end,
	buttons = {
		{pos = XXXXXXXXXXXXXXXXXXXXXXX, canSee = DefaultItemContainerCanSee, item_gen_group = "BBBBBBBBBBBBBBB"}, -- ZZZZZZZZZZZZZZ
		{pos = XXXXXXXXXXXXXXXXXXXXXXX, canSee = DefaultItemContainerCanSee, item_gen_group = "BBBBBBBBBBBBBBB"}, -- ZZZZZZZZZZZZZZ
		{pos = XXXXXXXXXXXXXXXXXXXXXXX, canSee = DefaultItemContainerCanSee, item_gen_group = "BBBBBBBBBBBBBBB"}, -- ZZZZZZZZZZZZZZ
		{pos = XXXXXXXXXXXXXXXXXXXXXXX, canSee = DefaultItemContainerCanSee, item_gen_group = "BBBBBBBBBBBBBBB"}, -- ZZZZZZZZZZZZZZ
		{pos = XXXXXXXXXXXXXXXXXXXXXXX, canSee = DefaultItemContainerCanSee, item_gen_group = "BBBBBBBBBBBBBBB"}, -- ZZZZZZZZZZZZZZ
	}
}

print("[Breach2] Shared/Buttons/ItemContainers mapconfig loaded!")