
function BR2_GetCountryCode(ply)
    if !ply:IsBot() then
        local ip = ply:IPAddress()
        print(ip)

        http.Fetch("http://ip-api.com/json/" .. ip .. "", 
            function(body)
                print(body)

                local data = util.JSONToTable(body)

                PrintTable(data)

                if data and data.countryCode then
                    ply.CountryCode = tolower(data.countryCode)
                    ply:SetNWString("CountryCode", tolower(data.countryCode))
                end
            end,
            function(err)
                print("[Breach2] Error fetching country code for player " .. ply:Nick() .. ": " .. err)
            end
        )
    end
end
