
notepad_system = {}
notepad_system.AllNotepads = {} -- lua_run PrintTable(notepad_system.AllNotepads)

notepad_system.ClearAllNotepads = function()
    for k,v in pairs(player.GetAll()) do
        v.notepad = nil
    end
    notepad_system.AllNotepads = {}
end

notepad_system.GetNotepad = function(id)
    return notepad_system.AllNotepads[id]
end

notepad_system.GetPlayerNotepad = function(ply)
    if IsValid(ply) and ply:IsPlayer() then
        return notepad_system.AllNotepads[ply.charid]
    end

    return nil
end

notepad_system.AssignNewNotepad = function(ply, to_send)
    if !IsValid(ply) or !ply:IsPlayer() or ply:IsSpectator() or !ply:Alive() then return end

    notepad_system.AllNotepads[ply.charid] = {
        people = {
            {
                br_showname = ply.br_showname,
                br_role = ply.br_role,
                br_team = ply.br_team,
                br_ci_agent = ply.br_ci_agent,
                health = HEALTH_ALIVE,
                scp = (ply.br_team == TEAM_SCP)
            }
        }
    }

    ply.notepad = notepad_system.AllNotepads[ply.charid]

    if to_send then
        net.Start("br_send_notepad")
            net.WriteTable(ply.notepad)
        net.Send(ply)
    end
end

notepad_system.ReplaceNotepad = function(ply, notepad, to_send)
    if !IsValid(ply) or !ply:IsPlayer() or ply:IsSpectator() or !ply:Alive() then return end

    ply.notepad = notepad

    notepad_system.AllNotepads[ply.charid] = notepad

    if to_send then
        net.Start("br_send_notepad_learn")
            net.WriteTable(ply.notepad)
        net.Send(ply)
    end
end

notepad_system.AddAutomatedInfo = function(ply, text)
    if IsValid(ply) and ply:IsPlayer() then
        local np = notepad_system.GetPlayerNotepad(ply)
        if istable(np) then
            np.automated_info = np.automated_info or {}
            table.ForceInsert(np.automated_info, tostring(text))
        end
    end
end

notepad_system.RemovePlayerInfo = function(ply, info_charid)
    if notepad_system.AllNotepads[ply.charid] == nil then return end

    local found = false
    for i,v in ipairs(notepad_system.AllNotepads[ply.charid].people) do
        if v.charid == info_charid then
            table.remove(notepad_system.AllNotepads[ply.charid].people, i)
            found = true
        end
    end

    if found then
        notepad_system.UpdateNotepad(ply)
    end
end

notepad_system.DeleteNotepad = function(ply)
    if notepad_system.AllNotepads[ply.charid] == nil then return end

    notepad_system.AllNotepads[ply.charid] = {
        people = {}
    }

    notepad_system.UpdateNotepad(ply)
end

notepad_system.AddPlayerInfo = function(ply, info_showname, info_role, info_team, info_ci_agent, info_health, info_scp, info_charid, info_ent)
    if IsValid(ply) and ply:IsPlayer() and istable(notepad_system.AllNotepads[ply.charid]) then
        for k,v in pairs(notepad_system.AllNotepads[ply.charid].people) do
            if v.br_showname == info_showname then
                return
            end
        end

        local formed_info = {
            br_showname = info_showname,
            br_role = info_role,
            br_team = info_team,
            br_ci_agent = info_ci_agent,
            health = info_health,
            scp = info_scp,
            charid = info_charid
        }

        if info_ent then
            formed_info.ent = info_ent
        end
        
        table.ForceInsert(notepad_system.AllNotepads[ply.charid].people, formed_info)
    end
end

notepad_system.UpdateNotepad = function(ply)
   -- print("trying to update a notepad for " .. tostring(ply:Nick()))
    if IsValid(ply) and ply:IsPlayer() then
        local np = notepad_system.GetPlayerNotepad(ply)

        if istable(np) then
            net.Start("br_send_notepad")
                net.WriteTable(np)
            net.Send(ply)
        else
            error("Notepad not found of player " .. ply:Nick())
        end
    else
        error("Tried to update notepad of invalid player " .. ply:Nick())
    end
end

print("[Breach2] server/sv_notepad_system.lua loaded!")
