
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
	ply:SelectWeapon("br2_scp_035_temp")
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

        -- TEMPORARILY DISABLE, NEED TO SELF HOST THESE GIFS
        --return oldFunc(ply, material, alpha)
    end

    -- removed jumpscare sound
    function scp_035.DisPlayFinalText(ply, delay)
        timer.Create("DisplayFinalEffect_SCP035_"..ply:EntIndex(), delay, 1, function()
            if !IsValid(ply) or !ply.SCP035_AffectByMask or ply.SCP035_IsWear or !ply:Alive() then return end
            
            local TextFinal_1 = scp_035.TranslateLanguage(SCP_035_LANG, "FinalText_1")
            local TextFinal_2 = scp_035.TranslateLanguage(SCP_035_LANG, "FinalText_2")

            ply.SCP035_SimpleText_1 = scp_035.DisPlaySimpleText(ply, TextFinal_1, #TextFinal_2 > 4 and SCP_035_CONFIG.ScrW * 0.02 or SCP_035_CONFIG.ScrW * 0.05, SCP_035_CONFIG.ScrH * 0.3)
            ply.SCP035_SimpleText_2 = scp_035.DisPlaySimpleText(ply, TextFinal_2, SCP_035_CONFIG.ScrW * 0.8, SCP_035_CONFIG.ScrH * 0.3)
            ply.SCP035_StaticNoise = scp_035.DisPlayGIF(ply, "https://i.imgur.com/Uc1nY1n.gif")
            ply.SCP035_MaskIMG = scp_035.DisPlayIMG(ply, "scp_035/mask_deform_v"..math.random(1, 3)..".png")

            timer.Simple(1, function()
                if (IsValid(ply)) then
                    ply.SCP035_StaticNoise:Remove()
                    ply.SCP035_MaskIMG:Remove()
                    ply.SCP035_SimpleText_1:Remove()
                    ply.SCP035_SimpleText_2:Remove()

                    scp_035.DisPlayFinalText(ply, math.random(5, 10))
                end
            end)
        end)
    end
end
