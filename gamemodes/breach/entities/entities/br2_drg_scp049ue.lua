
AddCSLuaFile()

ENT.Base = "drg_scp049ue"
ENT.Author = "Maya"
ENT.PrintName = "SCP-049"
ENT.Spawnable = true
ENT.Category = "SCP:CB Breach 2"
ENT.SpawnHealth = 1500

ENT.Faction = "FACTION_SCP"
ENT.Factions = {"FACTION_SCP"}

function ENT:OnOtherKilled(ent, dmg)
    local attacker = dmg:GetAttacker()
    
    print(ent, dmg, attacker)
    -- NextBot [12][br2_npc_drg_scp_1048]	CTakeDamageInfo [0.0 dmg]	NextBot [10][br2_drg_scp049ue]


    if IsValid(attacker) and attacker == self then
        self.IsPhase2 = true

        if self:IsPossessed() then return end

        self:Cure2()
        self.IsPhase2 = false
    end
end
