
mission_escape = {
	class = "escape",
	name = "Escape from the facility"
}
mission_find_weapon = {
	class = "find_weapon",
	name = "Find a weapon"
}
mission_find_food = {
	class = "find_food",
	name = "Find food"
}
mission_find_outfit = {
	class = "find_outfit",
	name = "Find a better outfit"
}
mission_neutralize_researchers_guards = {
	class = "neutralize_researchers_guards",
	name = "Kill researchers and guards"
}
mission_neutralize_class_ds = {
	class = "neutralize_class_ds",
	name = "Neutralize Class Ds"
}
mission_turn_on_generator = {
	class = "turn_on_generator",
	name = "Turn on a generator"
}
mission_escort_staff = {
	class = "escort_staff",
	name = "Escort staff to evacuation zones"
}
mission_kill_humans = {
	class = "kill_humans",
	name = "Kill humans"
}
mission_cure_humans = {
	class = "cure_humans",
	name = "Cure humans"
}
mission_retrieve_scps = {
	class = "retrieve_scps",
	name = "Retrieve SCP objects"
}
mission_neutralize_site_staff = {
	class = "neutralize_site_staff",
	name = "Neutralize site staff"
}
mission_kidnap_site_staff = {
	class = "kidnap_site_staff",
	name = "Kidnap site staff"
}
mission_steal_information = {
	class = "steal_information",
	name = "Steal valuable information"
}
mission_escort_ci_spies = {
	class = "escort_ci_spies",
	name = "Escort CI Spies"
}
mission_neutralize_spies = {
	class = "neutralize_spies",
	name = "Neutralize CI spies"
}
mission_terminate_ci = {
	class = "terminate_ci",
	name = "Kill a Chaos Insurgency soldier"
}
mission_terminate_mtf = {
	class = "terminate_mtf",
	name = "Kill a Mobile Task Force operative"
}


BREACH_MISSIONS = {
	{
		class = "classd",
		name = "Survive",
		missions = {
			mission_escape,
			mission_find_weapon,
			mission_find_food,
			mission_find_outfit,
			mission_neutralize_researchers_guards
		},
	},
	{
		class = "staff",
		name = "Survive",
		missions = {
			mission_escape,
			mission_find_weapon,
			mission_find_food,
			mission_find_outfit,
			--neutralize_class_ds,
			mission_turn_on_generator,
		},
	},
	{
		class = "guard",
		name = "Bring order to chaos",
		missions = {
			mission_escort_staff,
			mission_find_food,
			neutralize_class_ds,
			mission_turn_on_generator,
		},
	},
	{
		class = "isd_agent",
		name = "Bring order to chaos",
		missions = {
			mission_escort_staff,
			mission_find_food,
			neutralize_class_ds,
			mission_neutralize_spies,
			mission_turn_on_generator,
		},
	},
	{
		class = "scp_049",
		name = "Survive",
		missions = {
			mission_escape,
			mission_cure_humans,
		},
	},
	{
		class = "scp_173",
		name = "Survive",
		missions = {
			mission_escape,
			mission_kill_humans,
		},
	},
	{
		class = "chaos_soldiers",
		name = "Bring chaos to the facility",
		missions = {
			mission_retrieve_scps,
			mission_neutralize_site_staff,
			mission_kidnap_site_staff,
			mission_steal_information,
			mission_escort_ci_spies,
		},
	},
	{
		class = "chaos_spies",
		name = "Bring chaos to the facility",
		missions = {
			mission_escape,
			mission_retrieve_scps,
			mission_find_weapon,
			mission_find_food,
			mission_find_outfit,
			mission_steal_information,
		},
	},

	--DEATHMATCH
	{
		class = "dm_mtf",
		name = "Terminate the Chaos Insurgency",
		missions = {
			mission_terminate_ci
		},
	},
	{
		class = "dm_ci",
		name = "Terminate the Mobile Task Force",
		missions = {
			mission_terminate_mtf
		},
	},
}

print("[Breach2] config/sh_missions.lua loaded!")