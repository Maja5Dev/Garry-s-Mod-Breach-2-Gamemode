
MAPCONFIG = {}

function DefaultItemContainerCanSee(cont)
	return (util.TraceLine({start = cont.pos, endpos = cont.pos + (EyePos() - cont.pos):Angle():Forward() * 150}).Entity == LocalPlayer())
end

function DefaultTerminalCanSee(terminal)
	return (util.TraceLine({start = terminal.pos, endpos = terminal.pos + (EyePos() - terminal.pos):Angle():Forward() * 150}).Entity == LocalPlayer())
end

function DefaultOutfitterCanSee(outfitter)
	--if LocalPlayer():GetOutfit().can_change_outfits == false then return false end
	return (util.TraceLine({start = outfitter.pos, endpos = outfitter.pos + (EyePos() - outfitter.pos):Angle():Forward() * 150}).Entity == LocalPlayer())
end

function CanSeeFrom(pos)
	return (util.TraceLine({start = pos, endpos = pos + (EyePos() - pos):Angle():Forward() * 150}).Entity == LocalPlayer())
end

function TryToOpenContainer(cont)
	if cont != nil then
		net.Start("br_loot_container")
			net.WriteVector(cont.pos)
		net.SendToServer()
	end
end

function TryToOpenCrate(cont)
	if cont != nil then
		net.Start("br_loot_crate")
			net.WriteVector(cont.pos)
		net.SendToServer()
	end
end

BR_OUR_CLOSET_POS = Vector(0,0,0)

function TryToHideInCloset(closet)
	if closet != nil then
		net.Start("br_hide_in_closet")
			net.WriteVector(closet.pos)
		net.SendToServer()
		BR_OUR_CLOSET_POS = closet.pos
	end
end

print("[Breach2] Clientside mapconfig loaded!")
