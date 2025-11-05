
AddCSLuaFile()

ENT.Base = "npc_cpt_scp_513"

function ENT:OnInputAccepted(event, activator)
	if IsValid(activator)
	and activator:IsPlayer()
	and activator:Alive()
	and activator:Team() != TEAM_SPECTATOR
	and activator:Team() != (TEAM_SCP or 8)
	then
		self.BaseClass.OnInputAccepted(self, event, activator)
	end
end
