
registerHandsAction("identify_player", {
    name = "Identify",
    desc = "Identify the player you have last seen",
    background_color = BR2_Hands_Actions_Colors.someone_actions,

    can_do = function(self)
        return IsValid(lastseen_player)
        and lastseen_player:IsPlayer()
        and lastseen_player.br_team != TEAM_SCP
        and (CurTime() - lastseen) < 10
    end,

    cl_effect = function(self)
        BR_OpenIdentifyingMenu(lastseen_player, lastseen_nick, lastseen)
    end,

    cl_after = function(self)
        WeaponFrame:Remove()
    end
})
