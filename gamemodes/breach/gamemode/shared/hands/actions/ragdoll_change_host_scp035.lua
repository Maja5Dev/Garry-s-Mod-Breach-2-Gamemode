
registerHandsAction("change_host_scp035", {
    name = "Change your host to this body",
    desc = "Your current host is decaying",
    background_color = BR2_Hands_Actions_Colors.ragdoll_actions,

    can_do = function(self)
        local tr_ent = self.Owner:GetAllEyeTrace().Entity

        return self.Owner.br_role == ROLE_SCP_035
        and IsValid(tr_ent)
        and tr_ent:GetPos():Distance(self.Owner:GetPos()) < 150
        and tr_ent:GetClass() == "prop_ragdoll"
    end,

    sv_effect = function(self, ply)
        local tr_ent = self.Owner:GetAllEyeTrace().Entity

        if !(IsValid(tr_ent)
        and tr_ent:GetPos():Distance(self.Owner:GetPos()) < 150
        and tr_ent:GetClass() == "prop_ragdoll"
        )
        then
            ply:PrintMessage(HUD_PRINTTALK, "Invalid ragdoll")
            return
        end

        if tr_ent.IsStartingCorpse
        or (tr_ent.Info and CurTime() - tr_ent.Info.Time > 60)
        or tr_ent.Info == nil
        or tr_ent.scp035usedThisBody
        then
            ply:BR2_ShowNotification("This body seems to have spoiled already...")
            return
        end

        if tr_ent.Info.br_showname == nil then
            if istable(tr_ent.Info) then
                print("tr_ent.Info")
                PrintTable(tr_ent.Info)
            end

            error("Corpse br_showname is nil")
        end

        if IsValid(tr_ent.Info.Victim) and tr_ent.Info.Victim:Alive() and tr_ent.Info.Victim:IsDowned() then
            local dmg = DamageInfo()
            dmg:SetDamage(tr_ent.Info.Victim:Health() * 10)
            dmg:SetAttacker(ply)
            dmg:SetInflictor(ply)
            dmg:SetDamageType(DMG_GENERIC)

            tr_ent.Info.Victim:TakeDamageInfo(dmg)
        end

        ply.br_showname = tr_ent.Info.br_showname

        local old_notepad = table.Copy(notepad_system.AllNotepads[ply.charid])

        -- assign us their notepad
        local notepad = table.Copy(tr_ent.Info.notepad)
        notepad_system.ReplaceNotepad(ply, notepad, true)

        -- replace the ragdoll's notepad to our old one
        notepad_system.AllNotepads[tr_ent.Info.charid] = old_notepad

        BR2_ReplaceRagdollModel(tr_ent, ply:GetModel(), ply:GetSkin(), ply)

        ply:SetModel(tr_ent:GetModel())
        
        local hp = math.max(150, tr_ent:GetNWInt("VictimMaxHealth", 100) * 0.5)
        ply:SetHealth(hp)
        ply:SetMaxHealth(hp)

        net.Start("br_update_own_info")
            net.WriteString(ply.br_showname)
            net.WriteString(ply.br_role)
            net.WriteInt(TEAM_SCP, 8)
            net.WriteBool(ply.br_ci_agent)
        net.Send(ply)

        BroadcastPlayerUnknownInfo(ply)

        tr_ent.scp035usedThisBody = true
    end,

    cl_after = function(self)
        WeaponFrame:Remove()
    end
})
