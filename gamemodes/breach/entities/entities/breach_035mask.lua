
AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "scp_035_real"
ENT.Author = "Maya"
ENT.PrintName = "SCP-035"
ENT.Spawnable = true
ENT.Category = "Breach 2"

if CLIENT then
    function ENT:Think()
        for k,v in pairs(ents.FindInSphere(self:GetPos(), 500)) do
            if v:IsPlayer() and v:Alive() and !v:IsSpectator() and !table.HasValue(BR2_ROLES_UNAFFECTED_BY_SCP035, v.br_role) then
                scp_035.LookAtMe(v, self)
            end
        end
    end
end

function ENT:Use(ply)
	if !IsValid(ply) or !ply:Alive() or ply:IsSpectator() or table.HasValue(BR2_ROLES_UNAFFECTED_BY_SCP035, ply.br_role) then return end

	ply:Give("br2_scp_035_temp")
	self:Remove()
end
