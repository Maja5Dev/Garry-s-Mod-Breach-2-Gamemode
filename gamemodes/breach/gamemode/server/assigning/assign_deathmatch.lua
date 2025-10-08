
-- DEATHMATCH ROLES

function assign_system.Assign_DM_MTF_NTF(ply)
	Pre_Assign(ply)
	ply:PlayerSetSpeeds(DEF_SLOWWALKSPEED * 0.85, DEF_WALKSPEED * 0.85, DEF_RUNSPEED * 0.85)
	ply:ApplyOutfit("mtf")
	ply.cantChangeOutfit = true
	ply:AllowFlashlight(true)
    ply:Give("br_hands")
    ply:Give("keycard_level4")
	ply.br_role = ROLE_MTF_OPERATIVE
	ply.br_usesTemperature = false
	ply.br_uses_hunger_system = false
	ply.br_support_spawns = {}
    ply.first_info = "dm_mtf"
    ply.mission_set = "dm_mtf"
	ply.br_support_team = SUPPORT_FOUNDATION
	Post_Assign(ply)
	ply.DefaultWeapons = {"br_hands"}
	ply.canEscape = false
end

function assign_system.Assign_DM_CIsoldier(ply)
	Pre_Assign(ply)
	ply:PlayerSetSpeeds(DEF_SLOWWALKSPEED * 0.85, DEF_WALKSPEED * 0.85, DEF_RUNSPEED * 0.85)
	ply:ApplyOutfit("ci_soldier")
	ply.cantChangeOutfit = true
	ply:AllowFlashlight(true)
	ply:Give("br_hands")
	ply:Give("keycard_omni")
	ply.br_role = ROLE_CI_SOLDIER
	ply.br_usesTemperature = false
    ply.br_uses_hunger_system = false
    ply.br_support_spawns = {}
    ply.first_info = "dm_ci"
    ply.mission_set = "dm_ci"
	ply.br_support_team = SUPPORT_CI
	Post_Assign(ply)
	ply.DefaultWeapons = {"br_hands"}
	ply.canEscape = false
end
