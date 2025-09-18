

include("shared.lua")

include("client/cl_light_level.lua") -- just contains functions
include("config/sh_weapons.lua") -- config for weapons, top priority
include("config/cl_sounds.lua") -- needs to be before cl_music.lua and map files
include("shared/sh_maprelated.lua")
include("client/cl_maprelated.lua")
include("mapconfigs/"..game.GetMap().."/cl_init.lua")
include("mapconfigs/"..game.GetMap().."/shared.lua")

include("client/cl_fonts.lua") -- need to be loaded before any UI files
include("client/cl_sanity.lua") -- functions that are ran by the server, any priority but should be before networking
include("client/cl_footsteps.lua")
include("client/cl_calcview.lua")

include("client/cl_music.lua") -- music and sound related things, doesnt need to be loaded super quickly because functions are used only after-round

include("client/networking/init.lua") -- should be after sanity

/* DERMA MENUS */
include("config/sh_missions.lua")-- these need to be before derma
include("config/cl_firstrole.lua") -- these need to be before derma
include("config/cl_starttexts.lua") -- these need to be before derma
include("client/derma/init.lua") -- loads many files

/* HUD */
include("config/cl_screeneffects.lua") -- load before hud
include("client/cl_chat.lua") -- all chat stuff, any load order
include("client/hud/init.lua") -- loads many files

include("client/cl_player.lua") -- player related overrides, low priority
include("client/cl_tfa_fixes.lua") -- very low priority
include("client/cl_binds.lua") -- quite a lot of things, any load order
include("client/cl_fog.lua")

include("client/cl_tick.lua") -- lowest load order

--RunConsoleCommand("mat_specular", "0")

br2_last_death = -12
br2_last_escape = -12
BR_WATCHING_CAMERAS = false
starting_time = CurTime()

if BR2_OURNOTEPAD == nil then
	BR2_OURNOTEPAD = {}
	BR2_OURINFO = {}
end

RADIO4SOUNDSHC = {
	{"chatter1", 39},
	{"chatter2", 72},
	{"chatter4", 12},
	{"franklin1", 8},
	{"franklin2", 13},
	{"franklin3", 12},
	{"franklin4", 19},
	{"ohgod", 25}
}

RADIO4SOUNDS = table.Copy(RADIO4SOUNDSHC)

game_state = GAMESTATE_NOTSTARTED
br2_round_state_end = 0
body_health = 0
last_health_check = 0
last_revive_check = 0
last_revive_time = 0
last_body = NULL

last_got_stunned = 0

function are_we_downed()
	return LocalPlayer():Alive() and LocalPlayer():IsSpectator() == false and (CurTime() - last_health_check) < 2 and LocalPlayer():IsFrozen()
end

function NiceHealth()
	local hl = (LocalPlayer():Health() / LocalPlayer():GetMaxHealth())
	
	if hl < 0.15 then
		return "Nearly dead", Color(255, 0, 0, 255)

	elseif hl < 0.25 then
		return "Badly wounded", Color(255, 100, 0, 255)

	elseif hl < 0.5 then
		return "Wounded", Color(255, 150, 0, 255)

	elseif hl < 0.75 then
		return "Hurt", Color(255, 255, 0, 255)

	elseif hl < 0.9 then
		return "Slightly hurt", Color(150, 255, 0, 255)

	elseif hl > 2 then
		return "Very Healthy", Color(0, 255, 0, 255)
	else
		return "Healthy", Color(0, 255, 0, 255)
	end
end

surface.CreateFont("CSKillIcons", {
	font = "csd",
	size = 75,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	shadow = false,
	additive = true
})

sanity_alpha_delay = 0

br2_support_spawns = {{"mtf", 1}}

primary_lights_on = false
debug_view_mode = 0
concommand.Add("br2_debug_view", function()
	if LocalPlayer():IsSuperAdmin() then
		primary_lights_on = !primary_lights_on
		debug_view_mode = debug_view_mode + 1
		if debug_view_mode > 2 then
			debug_view_mode = 0
		end
	end
end)

debug_menu_enabled = false
concommand.Add("br2_debug_toggle_qmenu", function(ply, cmd, args)
	debug_menu_enabled = !debug_menu_enabled
end)

sound.Add({
	name = "br2_horror_roaming",
	channel = CHAN_VOICE,
	volume = 1.0,
	level = 75,
	pitch = 100,
	sound = "breach2/horror/Horror0.ogg"
})

local next_notepad_send = 0

BR2_HANDS_ACTIVE = false

function reset_our_last_zone()
	our_last_zone = nil
	our_last_zone_next = 0
	our_last_zone_alpha = 0
	our_last_zone_stage = 0
end
reset_our_last_zone()

function BleedingEffect(pos)
	local tr = util.TraceLine({
		start = pos,
		endpos = pos + Vector(0,0,-1000),
		mask = MASK_SOLID
	})
	if tr == nil then return end
	if tr.Hit then
		util.Decal("Blood", tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal)
	end
end

function StunBaton_GotStunned()
	last_got_stunned = CurTime()
end

function draw.Circle(x, y, radius, seg, fraction)
	local cir = {}

	table.insert(cir, { x = x, y = y, u = 0.5, v = 0.5 })
	for i = 0, seg do
		local a = math.rad((i / seg) * -fraction)
		table.insert(cir, { x = x + math.sin(a) * radius, y = y + math.cos(a) * radius, u = math.sin(a) / 2 + 0.5, v = math.cos(a) / 2 + 0.5 })
	end

	local a = math.rad(0) -- This is needed for non absolute segment counts
	table.insert(cir, { x = x + math.sin(a) * radius, y = y + math.cos(a) * radius, u = math.sin(a) / 2 + 0.5, v = math.cos(a) / 2 + 0.5 })

	surface.DrawPoly(cir)
end

material_173_1 = CreateMaterial("blinkGlow7", "UnlitGeneric", {
	["$basetexture"] = "particle/particle_glow_05",
	["$basetexturetransform"] = "center .5 .5 scale 1 1 rotate 0 translate 0 0",
	["$additive"] = 1,
	["$translucent"] = 1,
	["$vertexcolor"] = 1,
	["$vertexalpha"] = 1,
	["$ignorez"] = 0
})

local pickupable_classes = {"item_", "keycard_", "kanade_tfa_"}

function EntIsPickupable(ent)
	if IsValid(ent:GetOwner()) then return false end

	local class = ent:GetClass()
	for k,v in pairs(pickupable_classes) do
		if string.find(class, v) then
			return true
		end
	end
	return (ent.ForceHalo or ent:GetNWBool("isDropped", false))
end


item_halo_color = Color(134, 240, 240)
function GM:PreDrawHalos()
	local client = LocalPlayer()
	if !client:Alive() or client:IsSpectator() then return end
	
	local haloents = {}
	for k,v in pairs(ents.GetAll()) do
		if EntIsPickupable(v) and v:GetPos():Distance(client:GetPos()) < 200 then
			table.ForceInsert(haloents, v)
		end
	end
	halo.Add(haloents, item_halo_color, 3, 3, 1)
end



SCP_895_STATUS = 0
SCP_895_CLICKED = 0
SCP_895_TIME = 0


function CheckSCP895()
	for k,v in pairs(MAPCONFIG.CAMERAS) do
		for k2,v2 in pairs(v.cameras) do
			if v2.name == BR_CURRENT_CAMERA and v2.is_895 then
				if SCP_895_STATUS == 0 then
					SCP_895_STATUS = 1
					SCP_895_CLICKED = 0
					SCP_895_TIME = CurTime() + 2
				end
				return
			end
		end
	end
	SCP_895_STATUS = 0
end

function ResetSCP895()
	SCP_895_STATUS = 0
end

print("[Breach2] cl_init.lua loaded!")