
local function GenerateRandomString(length, charset)
    local str = ""
    charset = charset or "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    for i = 1, length do
        local rand = math.random(1, #charset)
        str = str .. string.sub(charset, rand, rand)
    end
    return str
end

local function LoginExists(login)
    for _, entry in ipairs(round_system.logins) do
        if entry[1] == login then
            return true
        end
    end
    return false
end

function BR2_GenerateTerminalAuth(ply)
    local login, password

    -- Keep generating until we find a unique login
    repeat
        login = GenerateRandomString(6, "abcdefghijklmnopqrstuvwxyz0123456789")
    until not LoginExists(login)

    -- Password can be random, doesn't need uniqueness
    password = GenerateRandomString(10)

    table.ForceInsert(round_system.logins, {
        ply = ply,
        login = login,
        password = password,
        nick = ply:Nick()
    })

    return login, password
end
