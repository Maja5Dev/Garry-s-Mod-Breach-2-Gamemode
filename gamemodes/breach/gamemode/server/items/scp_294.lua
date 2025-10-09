
scp_294_func = function(ply, info, text)
	MAP_SCP_294_Coins = 0

	local cup = ents.Create("br2_cup")
	if IsValid(cup) then
		cup:SetPos(MAPCONFIG.SCP_294_CUP.pos)
		cup:SetAngles(MAPCONFIG.SCP_294_CUP.ang)
		cup:SetNWBool("isDropped", true)
		cup.SI_Class = "cup"
		cup.PrintName = "Cup of " .. TitleCase(text)
		cup.CupType = text
		cup:Spawn()
		
		ForceSetPrintName(cup, cup.PrintName)
	end
end

local scp294_sound_ahh = {"breach2/294/ahh.ogg", 1.2}
local scp294_sound_slurp = {"breach2/294/slurp.ogg", 0.766}
local scp294_sound_burn = {"breach2/294/burn.ogg", 0}
local scp294_sound_ew1 = {"breach2/294/ew1.ogg", 1.2}
local scp294_sound_ew2 = {"breach2/294/ew2.ogg", 1.2}
local scp294_sound_spit = {"breach2/294/spit.ogg", 0.766}
local scp294_sound_cough = {"breach2/294/cough.ogg", 0.766}

-- lua_run Entity(1).br_special_items = {{class = "flashlight_tactical"}, {class = "lockpick"}, {class = "coin"}, {class = "crafting_toolbox"}, {class = "device_cameras"}}
-- lua_run Entity(1).br_special_items = {{class = "ammo_pistol"}, {class = "ammo_smg"}, {class = "ammo_rifle"}, {class = "ammo_shotgun"}}
-- lua_run Entity(1).br_special_items[1] = {class = "document", name = "SCP-173 Doc", type = "doc_scp173"}



special_item_system.AddItem({
    class = "cup",
    name = "Cup",
    func = function(pl, ent)
        table.ForceInsert(pl.br_special_items, {class = "cup", name = ent.PrintName, type = ent.CupType})
        return true
    end,
    use = function(pl, item)
        if timer.Exists("drinkuse" .. pl:SteamID64()) then return end

        if pl.br_role == ROLE_SCP_049 then
            pl:BR2_ShowNotification("This will serve better in my studies than in my veins.")
            return false
        end

        for k,v in pairs(BR2_SCP_294_OUTCOMES) do
            if table.HasValue(v.texts, item.type) then
                local delay = 0.1

                if istable(v.sound) then
                    pl:EmitSound(v.sound[1])
                    delay = v.sound[2]
                end

                timer.Create("drinkuse" .. pl:SteamID64(), delay, 1, function()
                    for k2,v2 in pairs(pl.br_special_items) do
                        if spi_comp(v2, item) then
                            for k3,v3 in pairs(BR2_SCP_294_OUTCOMES) do
                                if table.HasValue(v3.texts, item.type) then
                                    local remove = v3.use(pl)

                                    if remove then
                                        table.RemoveByValue(pl.br_special_items, v2)
                                    end

                                    break
                                end
                            end

                            break
                        end
                    end
                end)

                return false
            end
        end

        return true
    end,
    drop = function(pl, item)
        local res, ent = br2_special_item_drop(pl, "cup", "Cup", "prop_physics", "models/mishka/models/plastic_cup.mdl", item)
        ent.SI_Class = "cup"
        ent.PrintName = item.name
        ent.CupType = item.type
        ent:Spawn()
        
        ForceSetPrintName(ent, ent.PrintName)
        return ent
    end
})
