
local function check_someones_notepad(self)
    local pl = lastseen_player
    if !IsValid(pl) then return end

    self.PickpocketingSomeonesNotepad = true
    targeted_player = lastseen_player

    progress_bar_func = function()
        EndPickpocketingNotepad()
        self.PickpocketingSomeonesNotepad = false
    end
    
    InitiateProgressBar(3, "Checking notepad...")
end

registerHandsAction("check_someones_notepad", {
    name = "Check their notepad",
    desc = "Open their notepad",
    background_color = BR2_Hands_Actions_Colors.someone_actions,

    can_do = function(self)
        return IsValid(lastseen_player)
        and lastseen_player:IsPlayer()
        and lastseen_player.br_team != TEAM_SCP
        and (CurTime() - lastseen) < 4
        and lastseen_player:GetPos():Distance(self.Owner:GetPos()) < 150
        and (LocalPlayer().br_team == TEAM_SECURITY or LocalPlayer().br_team == TEAM_MTF or LocalPlayer().br_team == TEAM_CI)
    end,

    cl_effect = function(self)
        check_someones_notepad(self)
    end,

    cl_after = function(self)
        WeaponFrame:Remove()
    end
})
