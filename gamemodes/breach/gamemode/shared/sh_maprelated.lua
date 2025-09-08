
BR_DEFAULT_CommotionSounds = {
		"breach2/intro/Commotion/Commotion1.ogg",
		"breach2/intro/Commotion/Commotion2.ogg",
		"breach2/intro/Commotion/Commotion3.ogg",
		"breach2/intro/Commotion/Commotion4.ogg",
		"breach2/intro/Commotion/Commotion5.ogg",
		"breach2/intro/Commotion/Commotion6.ogg",
		"breach2/intro/Commotion/Commotion7.ogg",
		"breach2/intro/Commotion/Commotion8.ogg",
		"breach2/intro/Commotion/Commotion9.ogg",
		"breach2/intro/Commotion/Commotion10.ogg",
		"breach2/intro/Commotion/Commotion11.mp3",
		"breach2/intro/Commotion/Commotion12.ogg",
		"breach2/intro/Commotion/Commotion13.mp3",
		"breach2/intro/Commotion/Commotion14.mp3",
		"breach2/intro/Commotion/Commotion15.mp3",
		"breach2/intro/Commotion/Commotion16.ogg",
		"breach2/intro/Commotion/Commotion17.ogg",
		"breach2/intro/Commotion/Commotion18.ogg",
		"breach2/intro/Commotion/Commotion19.ogg",
		"breach2/intro/Commotion/Commotion20.ogg",
		"breach2/intro/Commotion/Commotion21.ogg",
		"breach2/intro/Commotion/Commotion22.mp3",
		"breach2/intro/Commotion/Commotion23.ogg",
		"breach2/intro/Bang2.ogg",
		"breach2/intro/Bang3.ogg",
}

br_default_mat_lock_opened = Material("breach2/scpu/lock_opened.png")
br_default_mat_lock_closed = Material("breach2/scpu/lock_closed.png")
br_default_mat_lock_picking = Material("breach2/scpu/lock_picking.png")

br_default_mat_scpu_opened = Material("breach2/scpu/Handy2.png")
br_default_mat_scpu_closed = Material("breach2/scpu/Handy.png")
br_default_mat_hiding_icon = Material("breach2/scpu/hiding_2_icon.png")

br_default_mat_map_teleport = Material("breach2/scpu/PDA_Tab_Icon_Map.png")

br_default_scpu_lock_picking = {
	mat = br_default_mat_lock_picking,
	w = 66,
	h = 90
}

br_default_scpu_lock_opened = {
	mat = br_default_mat_lock_opened,
	w = 66,
	h = 90
}

br_default_scpu_lock_closed = {
	mat = br_default_mat_lock_closed,
	w = 66,
	h = 90
}

br_default_scpu_opened = {
	mat = br_default_mat_scpu_opened,
	w = 1173 / 15,
	h = 1666 / 15
}

br_default_scpu_closed = {
	mat = br_default_mat_scpu_closed,
	w = 1173 / 15,
	h = 1666 / 15
}

br_default_map_teleport = {
	mat = br_default_mat_map_teleport,
	w = 80,
	h = 64
}

br_default_button_icons = {
	scpu = {
		opened = br_default_scpu_opened,
		closed = br_default_scpu_closed,
	},
	scpu_locks = {
		opened_func = function(num, button, tab)
			if lockpicking_timestamp > CurTime() and progress_circle_status != 0 then
				return br_default_scpu_lock_picking
			end
			if table.HasValue(br_crates_info, num) then
				return scpu_opened
			end
		end,
		closed_func = function(num, button, tab)
			if lockpicking_timestamp > CurTime() and progress_circle_status != 0 then
				return br_default_scpu_lock_picking
			end
			if table.HasValue(br_crates_info, num) then
				return br_default_scpu_lock_opened
			end
		end,
		opened = br_default_scpu_lock_closed,
		closed = br_default_scpu_lock_closed,
	},
	scu_hiding = {
		opened = {
			mat = br_default_mat_hiding_icon,
			w = 64,
			h = 64
		},
		closed = {
			mat = br_default_mat_hiding_icon,
			w = 64,
			h = 64
		}
	}
}

br_default_ambient_general = {
	"breach2/ambient/general/Ambient1.ogg",
	"breach2/ambient/general/Ambient2.ogg",
	"breach2/ambient/general/Ambient3.ogg",
	"breach2/ambient/general/Ambient4.ogg",
	"breach2/ambient/general/Ambient5.ogg",
	"breach2/ambient/general/Ambient6.ogg",
	"breach2/ambient/general/Ambient7.ogg",
	"breach2/ambient/general/Ambient8.ogg",
	"breach2/ambient/general/Ambient9.ogg",
	"breach2/ambient/general/Ambient10.ogg",
	"breach2/ambient/general/Ambient11.ogg",
	"breach2/ambient/general/Ambient12.ogg",
	"breach2/ambient/general/Ambient13.ogg",
	"breach2/ambient/general/Ambient14.ogg",
	"breach2/ambient/general/Ambient15.ogg",
}

br_default_ambient_lcz = {
	"breach2/ambient/zone1/Ambient1.ogg",
	"breach2/ambient/zone1/Ambient2.ogg",
	"breach2/ambient/zone1/Ambient3.ogg",
	"breach2/ambient/zone1/Ambient4.ogg",
	"breach2/ambient/zone1/Ambient5.ogg",
	"breach2/ambient/zone1/Ambient6.ogg",
	"breach2/ambient/zone1/Ambient7.ogg",
	"breach2/ambient/zone1/Ambient8.ogg",
}

br_default_ambient_hcz = {
	"breach2/ambient/zone2/Ambient1.ogg",
	"breach2/ambient/zone2/Ambient2.ogg",
	"breach2/ambient/zone2/Ambient3.ogg",
	"breach2/ambient/zone2/Ambient4.ogg",
	"breach2/ambient/zone2/Ambient5.ogg",
	"breach2/ambient/zone2/Ambient6.ogg",
	"breach2/ambient/zone2/Ambient7.ogg",
	"breach2/ambient/zone2/Ambient8.ogg",
	"breach2/ambient/zone2/Ambient9.ogg",
	"breach2/ambient/zone2/Ambient10.ogg",
	"breach2/ambient/zone2/Ambient11.ogg",
}

br_default_ambient_ez = {
	"breach2/ambient/zone3/Ambient1.ogg",
	"breach2/ambient/zone3/Ambient2.ogg",
	"breach2/ambient/zone3/Ambient3.ogg",
	"breach2/ambient/zone3/Ambient4.ogg",
	"breach2/ambient/zone3/Ambient5.ogg",
	"breach2/ambient/zone3/Ambient6.ogg",
	"breach2/ambient/zone3/Ambient7.ogg",
	"breach2/ambient/zone3/Ambient8.ogg",
	"breach2/ambient/zone3/Ambient9.ogg",
	"breach2/ambient/zone3/Ambient10.ogg",
	"breach2/ambient/zone3/Ambient11.ogg",
	"breach2/ambient/zone3/Ambient12.ogg",
}

print("[Breach2] shared/sh_maprelated.lua loaded!")
