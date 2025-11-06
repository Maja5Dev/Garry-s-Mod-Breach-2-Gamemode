
AddCSLuaFile()

ENT.Base = "npc_cpt_scp_513"
ENT.Type = "ai"
ENT.PrintName = "SCP"
ENT.Author = "Maya"
ENT.Category = "SCP:CB Breach 2"

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
