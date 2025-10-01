
AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "scp_035_real"
ENT.Author = "Maya"
ENT.PrintName = "SCP-035"
ENT.Spawnable = true
ENT.Category = "Breach 2"

function ENT:Think()
    local player_tab = {}

    for k,v in pairs(ents.FindInSphere(self:GetPos(), 400)) do
        if v:IsPlayer() and v:Alive() and !v:IsSpectator() and !table.HasValue(BR2_ROLES_UNAFFECTED_BY_SCP035, v.br_role) then
            table.ForceInsert(player_tab, v)
        end
    end

    if CLIENT then
        for k,v in pairs(player_tab) do
            local tr = util.TraceLine({
                start = v:GetShootPos(),
                endpos = self:GetPos(),
                filter = v
            })

            if tr.HitWorld then continue end
            if tr.Entity != self then continue end

            v:SetEyeAngles((self:GetPos() - v:GetShootPos()):Angle())
        end
    end

    scp_035.SetEffectsMask(self, player_tab)
end

function ENT:Use(ply)
	if !IsValid(ply) or !ply:Alive() or ply:IsSpectator() or table.HasValue(BR2_ROLES_UNAFFECTED_BY_SCP035, ply.br_role) then return end

	ply:Give("br2_scp_035_temp")
	self:Remove()
end

if CLIENT then
    oldFunc = scp_035.DisPlayGIF

    function scp_035.DisPlayGIF(ply, material, alpha)
        if material == "https://i.imgur.com/Uc1nY1n.gif" then
            material = "asset://garrysmod/materials/breach2/scp035_static.gif"
        end
        if material == "https://i.imgur.com/1aLhip5.gif" then
            material = "asset://garrysmod/materials/breach2/scp035_transform.gif"
        end

        return oldFunc(ply, material, alpha)
    end
end
