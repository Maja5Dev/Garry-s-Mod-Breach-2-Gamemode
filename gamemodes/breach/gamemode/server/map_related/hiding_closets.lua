
function BR_DEFAULT_MAP_Organize_HidingClosets()
	if istable(MAPCONFIG.BUTTONS_2D.HIDING_CLOSETS) then
		for k,v in pairs(MAPCONFIG.BUTTONS_2D.HIDING_CLOSETS.buttons) do
			v.peeking_ent = ents.Create("br2_peeking")
			if IsValid(v.peeking_ent) then
				v.peeking_ent:SetModel("models/hunter/blocks/cube025x025x025.mdl")
				v.peeking_ent:SetPos(v.peeking_pos)
				v.peeking_ent:Spawn()
				v.peeking_ent:SetNoDraw(true)
			end
		end
	end
end
