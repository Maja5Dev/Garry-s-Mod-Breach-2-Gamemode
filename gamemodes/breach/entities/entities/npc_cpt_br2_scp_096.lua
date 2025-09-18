
AddCSLuaFile()

ENT.Base = "npc_cpt_scp_096"
ENT.StartHealth = 1000
ENT.Category = "Breach 2 NPCs"

function ENT:SetInit()
    self.BaseClass.SetInit(self)

	self.IdleLoop:SetSoundLevel(90)
	self.TriggerLoop:SetSoundLevel(90)
	self.ChaseLoop:SetSoundLevel(95)
end

function ENT:FindFaceLookers()
	if self.IsTriggered or CurTime() <= self.NextCanTriggerT then return end

	local facepos = self:GetBonePosition(38)

	for _, v in ipairs(ents.FindInSphere(self:GetPos(), 100)) do
		if IsValid(v) then
			if v:IsPlayer() && v:Team() != TEAM_SPECTATOR && v:Team() != (TEAM_SCP or 8) then
				local dist = self:CPT_FindDistanceToPos(facepos,v:GetEyeTrace().HitPos)

				if self.IsTriggered == false && dist <= 55 && GetConVarNumber("ai_ignoreplayers") == 0 && self:Disposition(v) != D_LI && v:Visible(self) && (self:GetForward():Dot(((v:GetPos() +v:OBBCenter()) -self:GetPos() +self:OBBCenter()):GetNormalized()) > math.cos(math.rad(SCP_SightAngle +20))) then
					self.IsTriggered = true
					self.TriggeredEntity = v
					self:OnTriggered(v,30)
				end

			elseif v:IsNPC() and ((isstring(v.Faction) and v.Faction != "FACTION_SCP") or (istable(v.Faction) and !table.HasValue(v.Faction, "FACTION_SCP"))) then
				if self.IsTriggered == false && self:Disposition(v) != D_LI && v:Visible(self) && (self:GetForward():Dot(((v:GetPos() +v:OBBCenter()) -self:GetPos() +self:OBBCenter()):GetNormalized()) > math.cos(math.rad(SCP_SightAngle +20))) && (v:GetForward():Dot(((self:GetPos() +self:OBBCenter()) -v:GetPos() +v:OBBCenter()):GetNormalized()) > math.cos(math.rad(SCP_SightAngle))) then
					self.IsTriggered = true
					self.TriggeredEntity = v
					self:OnTriggered(v,15)
				end
			end
		end
	end
end
