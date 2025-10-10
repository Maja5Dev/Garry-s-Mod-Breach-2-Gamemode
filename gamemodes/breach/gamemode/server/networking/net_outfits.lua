
local function removeNearbyInfo(ply)
	for _, otherply in pairs(player.GetAll()) do
		local tr = util.TraceLine({
			start = ply:GetPos(),
			endpos = otherply:GetPos(),
			filter = ply,
			mask = MASK_SHOT_HULL
		})

		if otherply != ply and tr.Entity != otherply then
			otherply:SendPlayerUnknownInfo(ply)
		end
	end
end

net.Receive("br_take_outfit", function(len, ply)
	if len < 256 and ply:Alive() and ply:IsSpectator() == false and istable(MAPCONFIG) then
		local str_got = net.ReadString()

		for k,v in pairs(MAPCONFIG.BUTTONS_2D.OUTFITTERS.buttons) do
			if v.pos:Distance(ply:GetPos()) < 150 and table.HasValue(v.items, str_got) then
				local our_pos = 1
				local our_model = ply:GetModel()
				local our_model_class = nil
				local outfit = nil

				for i,v in ipairs(BREACH_OUTFITS) do
					if v.class == str_got then
						outfit = table.Copy(v)
					end

					if isstring(v.model) then
						if v.model == our_model then
							if isnumber(ply.lastOutfitPos) then
								ply.lastOutfitPos = i
							else
								our_pos = i
							end

							our_model_class = v.class
						end
					else
						for i2,v2 in ipairs(v.model) do
							if v2 == our_model then
								if isnumber(ply.lastOutfitPos) then
									ply.lastOutfitPos = i2
								else
									our_pos = i2
								end

								our_model_class = v.class
							end
						end
					end
				end

				if outfit != nil and our_model_class != nil then
					if our_pos then
						ply:ApplyOutfit(str_got, our_pos)
					else
						ply:ApplyOutfit(str_got)
					end
					
					ply:EmitSound(Sound("npc/combine_soldier/zipline_clothing"..math.random(1,2)..".wav"))
					table.RemoveByValue(v.items, str_got)
					table.ForceInsert(v.items, our_model_class)

					removeNearbyInfo(ply)
				end

				return
			end
		end
	end
end)

net.Receive("br_use_outfitter", function(len, ply)
	if len < 256 and ply:Alive() and ply:IsSpectator() == false and istable(MAPCONFIG) then

		if ply.cantChangeOutfit then
			ply:PrintMessage(HUD_PRINTTALK, "You cannot change your outfit.")
			return
		end

		local vector_got = net.ReadVector()
		for k,v in pairs(MAPCONFIG.BUTTONS_2D.OUTFITTERS.buttons) do
			if v.pos == vector_got then
				net.Start("br_use_outfitter")
					net.WriteTable(v.items)
				net.Send(ply)
			end
		end
	end
end)

print("[Breach2] server/networking/net_outfits.lua loaded!")
