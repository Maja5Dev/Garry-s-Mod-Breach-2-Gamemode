
local player_meta = FindMetaTable("Player")

function player_meta:ApplyOutfit(class, pos)
	for k,v in pairs(BREACH_OUTFITS) do
		if v.class == class then
			if IsColor(v.player_color) then
				self:BR_SetColor(v.player_color)
			end
			
			--print(self:GetModel())
			if isstring(v.model) then
				self:SetModel(v.model)
			else
				if pos == nil then
					self:SetModel(table.Random(v.model))
				else
					self:SetModel(v.model[math.Clamp(pos, 1, table.Count(v.model))])
				end
			end

			--print(self:GetModel())
			if istable(v.hands) then
				self.br_hands = table.Copy(v.hands)
				self:SetupHands()
			end
		end
	end
end

function player_meta:Start_HidingInCloset(closet)
	if self.next_hiding > CurTime() or !IsValid(closet.peeking_ent) then return end
	
	sound.Play("breach2/closet_2.mp3", closet.peeking_pos, 60, 100, 1)

	self.next_hiding = CurTime() + 4
	self.next_lhiding = CurTime() + 2
	self:SetViewEntity(closet.peeking_ent)

	if closet.inside_func then
		closet.inside_func(self, closet.peeking_ent)
	end

	self:SetLocalVelocity(Vector(0,0,0))
	self:SetMoveType(MOVETYPE_NONE)
	self:SetNoDraw(true)
	self.is_hiding_in_closet = {CurTime(), pos}
	closet.player = self
end

function player_meta:Stop_HidingInCloset(closet)
	if self.next_lhiding < CurTime() then
		sound.Play("breach2/closet_2.mp3", closet.peeking_pos, 60, 100, 1)
		self:SetViewEntity(self)
		self:SetMoveType(MOVETYPE_WALK)
		self:SetNoDraw(false)

		if closet.outside_func then
			closet.outside_func(self)
		end

		self.is_hiding_in_closet = nil
		closet.player = nil
	end
end

function player_meta:UsedSCP500()
	self:AddRunStamina(3000)
	self:AddJumpStamina(200)
	self.CrippledStamina = 0
	self:AddSanity(100)
	self.br_temperature = 0
	self.br_isBleeding = false
	self:SetHealth(self:GetMaxHealth())
	self.br_infection = 0
	self.br_isInfected = false
	self.SCP_Inflicted_1048a = false
	self.SCP_Infected_049 = false
	self:BR2_ShowNotification("I feel so much better...")
end

print("[Breach2] server/player_related/pl_actions.lua loaded!")
