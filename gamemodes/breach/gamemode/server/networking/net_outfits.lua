
local function removeNearbyInfo(ply)
	for _, otherply in pairs(player.GetAll()) do
		local tr = util.TraceLine({
			start = ply:GetPos(),
			endpos = otherply:GetPos(),
			filter = ply,
			mask = MASK_SHOT_HULL
		})

		if otherply != ply and tr.Entity != otherply then
			notepad_system.RemovePlayerInfo(otherply, ply.charid)
		end
	end
end

net.Receive("br_take_outfit", function(len, ply)
	if len < 256 and ply:Alive() and ply:IsSpectator() == false and istable(MAPCONFIG) then
		local str_got = net.ReadString()

		for k,v in pairs(MAPCONFIG.BUTTONS_2D.OUTFITTERS.buttons) do
			if v.pos:Distance(ply:GetPos()) < 150 and table.HasValue(v.items, str_got) then
				print("found outfitter with item")
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

local function reapply_body_info(ent, new)
	new.Info = table.Copy(ent.Info)
	new.RagdollHealth = ent.RagdollHealth
	new.nextReviveMove = ent.nextReviveMove

	if ent.CInfo then
		new.CInfo = table.Copy(ent.CInfo)
	end
	if ent.IsStartingCorpse then
		new.IsStartingCorpse = ent.IsStartingCorpse
	end
	if ent.Info.Time then
		new:SetNWInt("DeathTime", ent.Info.Time)
	end
	new:SetNWString("ExamineDmgInfo", ent:GetNWString("ExamineDmgInfo", ""))

	for k,v in pairs(player.GetAll()) do
		if v.Body == ent then
			v.Body = new
		end

		if v.retrievingNotes == ent then
			v.retrievingNotes = new
		end
	end
end

net.Receive("br_steal_body_outfit", function(len, ply)
	if ply:Alive() and ply:IsSpectator() == false then
		local ent = ply:GetAllEyeTrace().Entity

		if IsValid(ent) and ent:GetClass() == "prop_ragdoll" and ent:GetPos():Distance(ply:GetPos()) < 150 and istable(ent.Info) then
			local our_outfit = ply:GetOutfit()
			local outfit = ent:GetOutfit()

			if ply:GetModel() == ent:GetModel() or our_outfit.class == outfit.class then
				ply:PrintMessage(HUD_PRINTTALK, "You are already wearing this outfit.")
				return
			end

			if ply.cantChangeOutfit == true then
				ply:PrintMessage(HUD_PRINTTALK, "You cannot change your outfit.")
				return
			end

			if istable(outfit) and outfit.can_loot_this_outfit then
				local bone_positions = {}
				for i = 0, ent:GetPhysicsObjectCount() - 1 do
					local bone = ent:GetPhysicsObjectNum(i)
					if IsValid(bone) then
						bone:EnableMotion(false)
						bone:SetVelocity(Vector(0,0,0))
						bone_positions[i] = {
							pos = bone:GetPos(),
							ang = bone:GetAngles()
						}
					end
				end

				local pos = ent:GetPos() + Vector(0,0,10)
				local ang = ent:GetAngles()
				ent:Remove()

				local new = ents.Create("prop_ragdoll")

				new.blockPhysicsDamageFor = CurTime() + 2

				reapply_body_info(ent, new)

				new:SetModel(ply:GetModel())
				new:SetPos(pos)
				new:SetAngles(ang)

				new:SetSkin(ply:GetSkin())
				for i = 0, ply:GetNumBodyGroups() - 1 do
					new:SetBodygroup(i, ply:GetBodygroup(i))
				end

				new:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)
				new:Spawn()
				new:Activate()

				for i = 0, new:GetPhysicsObjectCount() - 1 do
					local bone = new:GetPhysicsObjectNum(i)
					if IsValid(bone) and bone_positions[i] then
						bone:SetPos(bone_positions[i].pos)
						bone:SetAngles(bone_positions[i].ang)
        				bone:EnableMotion(false)
						bone:SetVelocity(Vector(0,0,0))
					end
				end

				timer.Simple(0, function()
					if IsValid(new) then
						new:SetCollisionGroup(COLLISION_GROUP_DEBRIS_TRIGGER)
						new:CollisionRulesChanged()

						for i = 0, new:GetPhysicsObjectCount() - 1 do
							local bone = new:GetPhysicsObjectNum(i)
							if IsValid(bone) then
								bone:EnableMotion(true)
								bone:Wake()
								bone:SetVelocity(Vector(0,0,0))
							end
						end
					end
				end)

				ply:ApplyOutfit(outfit.class)
				ply:EmitSound(Sound("npc/combine_soldier/zipline_clothing"..math.random(1,2)..".wav"))
				removeNearbyInfo(ply)

			else
				ply:PrintMessage(HUD_PRINTTALK, "You cannot loot this outfit.")
			end
		end
	end
end)

net.Receive("br_use_outfitter", function(len, ply)
	if len < 256 and ply:Alive() and ply:IsSpectator() == false and istable(MAPCONFIG) then

		if ply.cantChangeOutfit then
			ply:PrintMessage(HUD_PRINTTALK, "You couldn't find anything useful...")
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
