
AddCSLuaFile()

SWEP.Category = "Breach 2"
SWEP.Base = "scp_035_swep"
SWEP.PrintName = "SCP-035"
SWEP.Author = "Maya"
SWEP.Purpose = ""
SWEP.DrawCrosshair = false

function SWEP:PutTheMask()
    local ply = self.Owner

	ply:Freeze(true)
	self:SendWeaponAnim(ACT_VM_DRAW)
	self:SetCurentAnim()

	ply.SCP035_IsTransforming = true

	timer.Simple(self.CurentAnim, function()
        if !IsValid(self) or !IsValid(ply) or !ply:Alive() or ply:IsSpectator() then return end

        if SERVER then
            ply:AddAttachmentModel({
                model = "models/scp_035_real/scp_035_real.mdl",
                --bone = "ValveBiped.Bip01_Head1",
                attachment = "eyes",
                offset = Vector(0, 1.6, -1.3),
                angOffset = Angle(6, 0, 0)
            })

            --scp_035.SetTableClient(ply, "PlayersWearingMask", true) 
            scp_035.SetTranform(ply)
        end

		self:SendWeaponAnim(ACT_VM_IDLE)
		self:SetCurentAnim()

		timer.Simple(7.6, function()
			if !IsValid(self) or !IsValid(ply) or !ply:Alive() or ply:IsSpectator() then return end

            if SERVER then
                ply.br_role = "SCP-035"
                ply.br_team = TEAM_SCP
                ply:AddFlags(FL_NOTARGET)
                ply.br_usesSanity = false
                ply:SetNWString("CPTBase_NPCFaction", "BR2_FACTION_SCP_035")

                net.Start("br_update_own_info")
                    net.WriteString(ply.br_showname)
                    net.WriteString(ply.br_role)
                    net.WriteInt(TEAM_SCP, 8)
                    net.WriteBool(ply.br_ci_agent)
                net.Send(ply)
            end

			--ply.SCP035_IsWear = true
			ply.SCP035_IsTransforming = false
			scp_035.RemoveEffectProximity(ply)

			if SERVER then 
				ply:Freeze(false)
				--scp_035.StartIdleSound(ply)
                ply:StripWeapon(self:GetClass())
            else
                if ply.SCP035_TransitionTransform then
                    ply.SCP035_TransitionTransform:Remove()
                    ply.SCP035_TransitionTransform = nil
                end
                RunConsoleCommand("lastinv")
			end
		end)
    end)
end
