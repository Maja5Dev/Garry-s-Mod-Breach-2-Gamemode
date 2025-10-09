
function Pre_Assign(ply)
	ply:UnSpectatePlayer(false)
	ply:SetViewEntity(ply)
	ply:StripPlayer()
	ply:SetTeam(TEAM_ALIVE)
	ply:SetHealth(100)
	ply:SetMaxHealth(100)
	ply:SetArmor(0)
	ply:PlayerSetSpeeds(DEF_SLOWWALKSPEED, DEF_WALKSPEED, DEF_RUNSPEED)
	ply:SetJumpPower(DEF_JUMPPOWER)
	ply:SetSuppressPickupNotices(true)
	ply.DefaultJumpPower = DEF_JUMPPOWER
	ply:AllowFlashlight(false)
	ply.br_showname = GetRandomName()
	ply.br_hands = nil
	ply.br_customspawn = nil
	ply.br_special_items = {}
	ply.br_role = "Unknown"
	ply.br_ci_agent = false
	ply.br_downed = false

	ply.br_sanity = 100
	ply.br_hunger = 120
	ply.br_thirst = 120
	ply.br_temperature = 0
	ply.br_infection = 0
	ply.br_speed_boost = 0
	ply.br_isBleeding = false
	ply.br_isInfected = false
	ply.br_asymptomatic = false
	ply.br_uses_hunger_system = true
	ply.br_usesSanity = false
	ply.br_usesStamina = true
	ply.br_usesTemperature = false
	ply.canStartBleeding = true
	ply.can_get_infected = true
	ply.getsPossibleTraitors = false
	ply.canEscape = true
	ply.use049sounds = false
	ply.use173behavior = false
	ply.canContain173 = false
	ply.getsAllCIinfo = false

	ply.DefaultWeapons = {}
	ply:SetBloodColor(BLOOD_COLOR_RED)
	ply:SetCanZoom(false)
	ply:BR_SetColor(Color(255,255,255,255))
	ply:SetMaterial("")
	ply:SetGravity(1)
	ply:SetLadderClimbSpeed(75)
	ply:SetFOV(DEF_FOV, 0)
	ply:SetNoTarget(false)
	ply:SetCrouchedWalkSpeed(0.5)
	ply:SetUnDuckSpeed(0.5)
	ply:SetDuckSpeed(0.3)
	ply:ResetHull()
	ply:SetCustomCollisionCheck(false)
	ply:SetNWBool("br_is_reviving", false)
	ply.retrievingNotes = false
	ply.flashlightEnabled = false
	ply.isTheOne = false
	ply.is_hiding_in_closet = nil
	ply.startedLockpicking = nil
	ply.lastSentCode = nil
	ply.viewing895 = false
	ply.cantUseFlashlight = false
	ply.cantChangeOutfit = false

	ply.nextBreath = 0
	ply.NextCough = 0
	ply.disable_coughing = false
	ply.nextDamageInGas = 0
	ply.next049Breath = 0
	ply.next_hsd = 0
	ply.next_iup1 = 0
	ply.next_iup2 = 0
	ply.nextTemperatureCheck = 0
	ply.nextTemperatureDamage = 0
	ply.next_hunger_update = CurTime() + 1
	ply.next_hunger = CurTime() + 30
	ply.next_thirst = CurTime() + 30
	ply.next_health_update = 0
	ply.next_revive_update = 0
	ply.next895dmg = 0
	ply.nextFlashlightUse = 0
	ply.nextJumpStaminaCheck =  0
	ply.nextRunStaminaCheck =  0
	ply.lastRunning = 0
	ply.attachmentModels = nil
	ply.next035Decay = CurTime() + cvars.Number("br2_035_decay_speed", 5)

	-- 173 blinking
	ply.seen_173 = 0
	ply.usedEyeDrops = 0
	ply.blinking_enabled = true
	ply.nextBlink = 0
	ply.firstSeen173 = false

	if IsValid(ply.flashlight3d) then
		ply.flashlight3d:Remove()
	end

	if ply.support_spawning == false then
		ply.br_support_spawns = {}
		ply.br_support_team = SUPPORT_NONE
	end
	ply.br_times_support_respawned = 0

	br2_mtf_teams_remove(ply)

	ply:Reset_SNPC_Stuff()
end

local function send_info(ply)
	net.Start("br_update_own_info")
		net.WriteString(ply.br_showname)
		net.WriteString(ply.br_role)
		net.WriteInt(ply.br_team, 8)
		net.WriteBool(ply.br_ci_agent)
	net.Send(ply)
end

function Post_Assign(ply)
	ply:SetupHands()

	local send_times = math.Clamp(GetConVar("br2_time_preparing"):GetInt(), 3, 5)

	timer.Create("BR_UpdateOwnInfo" .. ply:SteamID64(), 1, send_times, function()
		send_info(ply)
	end)

	ply.dont_assign_items = false
	ply.support_spawning = false
end
assign_system = {}

include("assign_ci.lua")
include("assign_classds.lua")
include("assign_deathmatch.lua")
include("assign_minor.lua")
include("assign_scps.lua")
include("assign_sd_mtfs.lua")
