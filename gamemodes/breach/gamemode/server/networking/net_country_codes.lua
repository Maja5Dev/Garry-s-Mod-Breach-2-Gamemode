
function BR2_GetCountryCode(ply)
    if !ply:IsBot() then
        local ip = ply:IPAddress()

        if ip then
            http.Fetch("http://ip-api.com/json/" .. string.Explode(":", ip)[1] .. "", 
                function(body)
                    local data = util.JSONToTable(body)

                    if data and data.countryCode then
                        ply.CountryCode = string.lower(data.countryCode)
                        ply:SetNWString("CountryCode", string.lower(data.countryCode))
                    end
                end,
                function(err)
                    print("[Breach2] Error fetching country code for player " .. ply:Nick() .. ": " .. err)
                end
            )
        end
    end
end
