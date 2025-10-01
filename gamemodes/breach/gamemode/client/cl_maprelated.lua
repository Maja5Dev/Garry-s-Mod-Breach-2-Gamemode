
function DefaultItemContainerCanSee(cont)
	if table.HasValue(BR2_ROLES_DISALLOWED_PICKUP_SITEMS, LocalPlayer().br_role) then return false end

	return util.TraceLine({
		start = EyePos(),
		endpos = cont.pos,
		filter = LocalPlayer()
	}).Fraction == 1
end

function DefaultTerminalCanSee(terminal)
	if table.HasValue(BR2_ROLES_DISALLOWED_PICKUP_SITEMS, LocalPlayer().br_role) then return false end

	return (util.TraceLine({start = terminal.pos, endpos = terminal.pos + (EyePos() - terminal.pos):Angle():Forward() * 150}).Entity == LocalPlayer())
end

function DefaultOutfitterCanSee(outfitter)
	if table.HasValue(BR2_ROLES_DISALLOWED_PICKUP_SITEMS, LocalPlayer().br_role) then return false end

	return util.TraceLine({
		start = EyePos(),
		endpos = outfitter.pos,
		filter = LocalPlayer()
	}).Fraction == 1
end

function CanSeeFrom(pos)
	return util.TraceLine({
		start = EyePos(),
		endpos = pos,
		filter = LocalPlayer()
	}).Fraction == 1
end

function TryToOpenContainer(cont)
	if table.HasValue(BR2_ROLES_DISALLOWED_PICKUP_SITEMS, LocalPlayer().br_role) then return end

	if cont != nil then
		net.Start("br_loot_container")
			net.WriteVector(cont.pos)
		net.SendToServer()
	end
end

function TryToOpenCrate(cont)
	if table.HasValue(BR2_ROLES_DISALLOWED_PICKUP_SITEMS, LocalPlayer().br_role) then return end

	if cont != nil then
		net.Start("br_loot_crate")
			net.WriteVector(cont.pos)
		net.SendToServer()
	end
end

BR_OUR_CLOSET_POS = Vector(0,0,0)

function TryToHideInCloset(closet)
	if table.HasValue(BR2_ROLES_DISALLOWED_PICKUP_SITEMS, LocalPlayer().br_role) then return end

	if closet != nil then
		net.Start("br_hide_in_closet")
			net.WriteVector(closet.pos)
		net.SendToServer()
		BR_OUR_CLOSET_POS = closet.pos
	end
end

local next_simple_button_use = 0
function SodaMachineUse(button)
	if table.HasValue(BR2_ROLES_DISALLOWED_PICKUP_SITEMS, LocalPlayer().br_role) then return end
	
	if next_simple_button_use > CurTime() then return end
	
	net.Start("br_use_soda_machine")
		net.WriteVector(button.pos)
	net.SendToServer()

	next_simple_button_use = CurTime() + 1
end

print("[Breach2] client/cl_maprelated.lua loaded!")
