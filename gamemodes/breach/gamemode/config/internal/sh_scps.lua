
/*
035 should be allowed to pick up anything
049 shouldnt be allowed to pick up ammo, props, guns
049-2 shouldnt be allowed to pick up anything
*/

-- Add role names here to disallow them from opening the notepad
BR2_ROLES_DISALLOWED_NOTEPAD = {
    ROLE_SCP_173,
    ROLE_SCP_049_2,
}

BR2_ROLES_DISALLOWED_TERMINAL_USE = {
    ROLE_SCP_173,
    ROLE_SCP_049_2,
}

BR2_ROLES_DONT_RENDER_BUTTONS = {
    ROLE_SCP_173,
}

BR2_ROLES_DISALLOWED_SCP_ACTIONS = {
    ROLE_SCP_049_2,
    ROLE_SCP_035,
}

-- Add role names here to disallow them completely from picking up special items
BR2_ROLES_DISALLOWED_PICKUP_SITEMS = {
    ROLE_SCP_173,
    ROLE_SCP_049_2,
}

-- More fine grained limits for special items
BR2_ROLES_LOOT_LIMITS = {
    {
        role_name = ROLE_SCP_049,
        disallow = function(ply, item)
            local class = item.class or (IsEntity(item) and (item.SI_Class or item:GetClass()))
            -- Disallow 049 to loot any swep, ammo, food, drinks
            -- But allow keycards
            return (weapons.Get(class) or item.ammo_info or string.find(class, "ammo")
                or string.find(class, "doc_") or item.DocType
                or string.find(class, "conf_folder") or string.find(class, "food") or string.find(class, "drink"))
                and !string.find(class, "keycard")
        end
    },
}

-- Add role names here to disallow them to auto pick up items from the ground like ammo/energy from hl2
BR2_ROLES_DISALLOWED_PICKUP_ITEMS = {
    ROLE_SCP_049,
    ROLE_SCP_173,
    ROLE_SCP_049_2,
}

-- Add role names here to disallow them to pick up props
BR2_ROLES_DISALLOWED_PICKUPS = {
    ROLE_SCP_049,
    ROLE_SCP_173,
    ROLE_SCP_049_2,
}

BR2_ROLES_UNAFFECTED_BY_SCP035 = {
    ROLE_SCP_173,
    ROLE_SCP_035,
}

BR2_ROLE_WEAPON_LIMITS = {
    {
        role_name = ROLE_SCP_049,
        allow_only = function(ply, wep) return string.find(wep:GetClass(), "keycard") or wep:GetClass() == "br2_scp_035_temp" end
    },
    {
        role_name = ROLE_SCP_049_2,
        allow_only = function(ply, wep) return wep:GetClass() == "weapon_scp_049_2" or wep:GetClass() == "br2_scp_035_temp" end
    },
    {
        role_name = ROLE_SCP_173,
        allow_only = function(ply, wep) return wep:GetClass() == "weapon_scp_173" end
    },
}

-- used to display npc names in spectating TODO
BR_SPECTATABLE_NPC_CLASSES = {
	br2_drg_scp049ue = "SCP-049",
	br2_npc_drg_scp_096 = "SCP-096",
	br2_npc_drg_scp_106 = "SCP-106",
	npc_cpt_scp_457 = "SCP-457",
	npc_cpt_scp_575 = "SCP-575",
	npc_cpt_scp_173 = "SCP-173",
}

print("[Breach2] config/sh_npcs.lua loaded!")
