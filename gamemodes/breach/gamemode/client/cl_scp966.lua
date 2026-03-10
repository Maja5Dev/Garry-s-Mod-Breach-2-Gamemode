
hook.Add("PrePlayerDraw", "HideSCP966", function(ply)
    if ply:GetModel() == "models/966/966.mdl" then
        return !HasNVGOn(LocalPlayer())
    end
end)
