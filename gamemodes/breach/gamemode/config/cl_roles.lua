
BR2_PLAYER_SCOREBOARD_GROUPS = {
	scps = {
		sort = 6,
		check = function(pl) return pl.br_team == TEAM_SCP end,
		color = Color(232, 18, 39, 220),
		text = "SCPs"
	},
	mtf = {
		sort = 5,
		check = function(pl) return pl.br_team == TEAM_MTF end,
		color = Color(0, 0, 60, 220),
		text = "Mobile Task Force"
	},
	security = {
		sort = 4,
		check = function(pl) return pl.br_team == TEAM_SECURITY end,
		color = Color(29, 90, 198, 220),
		text = "Security"
	},
	foundation = {
		sort = 3,
		check = function(pl) return pl:IsFromFoundation() and pl.br_team != TEAM_SCP and pl.br_team != TEAM_SECURITY and pl.br_team != TEAM_MTF and pl.br_team != TEAM_CLASSD end,
		color = Color(120, 120, 120, 220),
		text = "Foundation Staff"
	},
	classds = {
		sort = 2,
		check = function(pl) return pl.br_team == TEAM_CLASSD end,
		color = Color(201, 87, 16, 220),
		text = "Class Ds"
	},
	unknown = {
		sort = 1,
		check = function(pl) return !pl:Alive() or pl:IsSpectator() or pl.br_role == "CI Soldier" end,
		color = Color(50, 50, 50, 220),
		text = "Unknown"
	},
}

BR2_SCOREBOARD_ROLE_COLORS = {}
BR2_SCOREBOARD_ROLE_COLORS["Janitor"] = Color(130, 62, 230)
BR2_SCOREBOARD_ROLE_COLORS["Doctor"] = Color(130, 62, 230)
BR2_SCOREBOARD_ROLE_COLORS["Researcher"] = Color(25, 140, 180)
BR2_SCOREBOARD_ROLE_COLORS["SD Officer"] = Color(30, 30, 200)
BR2_SCOREBOARD_ROLE_COLORS["Containment Specialist"] = Color(132, 25, 120)
BR2_SCOREBOARD_ROLE_COLORS["ISD Agent"] = Color(24, 33, 150)
BR2_SCOREBOARD_ROLE_COLORS["CI Soldier"] = chaos_color
BR2_SCOREBOARD_ROLE_COLORS["Class D"] = Color(201, 87, 16)
BR2_SCOREBOARD_ROLE_COLORS["MTF Operative"] = Color(0, 0, 60)
