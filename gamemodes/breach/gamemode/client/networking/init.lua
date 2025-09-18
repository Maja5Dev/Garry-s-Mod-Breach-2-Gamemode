
firstsounds_end = 0
br2_our_sanity = 6
br2_is_bleeding = false
BR_OUR_TEMPERATURE = 0
BR_OUR_STAMINA = 0
BR_OUR_INFECTION = 0
br2_support_spawns = {}
br_crates_info = {}
BR2_MTF_TEAMS = {
	{},
	{},
}

br_our_team_num = 0
br2_round_state_start = 0

function BR2_CL_GENERATORS_ON()
	surface.PlaySound("breach2/intro/Light2.ogg")
	br2_generators_on = CurTime() + 1
	br2_generators_on_flash = true
	primary_lights_on = true
end

net.Receive("br_enable_primary_lights", function(len)
	BR2_CL_GENERATORS_ON()
end)

net.Receive("br_disable_primary_lights", function(len)
	primary_lights_on = false
end)

net.Receive("br_force_print_name", function(len)
	local ent_got = net.ReadEntity()
	local str_got = net.ReadString()

	if IsValid(ent_got) then
		ent_got.PrintName = str_got
		ent_got.ForceHalo = true
	end
end)

net.Receive("br_custom_screen_effects", function(len)
	local duration = net.ReadFloat()
	local tab = net.ReadTable()
	
	br_our_custom_screen_effects = tab
	br_our_custom_screen_effects_for = CurTime() + duration
end)

include("health.lua")
include("info.lua")
include("items.lua")
include("player_actions.lua")
include("player.lua")
include("round.lua")
include("scps.lua")
include("sounds.lua")
include("support_spawns.lua")
include("terminal.lua")
include("updates.lua")

print("[Breach2] client/networking/init.lua loaded!")
