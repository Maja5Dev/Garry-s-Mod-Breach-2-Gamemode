
function SimpleButtonUse(button)
	button.func_cl()
	net.Start("br_use_button_simple")
		net.WriteVector(button.pos)
	net.SendToServer()
end


br_default_mat_lock_opened = Material("breach2/scpu/lock_opened.png")
br_default_mat_lock_closed = Material("breach2/scpu/lock_closed.png")
br_default_mat_lock_picking = Material("breach2/scpu/lock_picking.png")

br_default_mat_scpu_opened = Material("breach2/scpu/Handy2.png")
br_default_mat_scpu_closed = Material("breach2/scpu/Handy.png")
br_default_mat_hiding_icon = Material("breach2/scpu/hiding_2_icon.png")

br_default_mat_map_teleport = Material("breach2/scpu/PDA_Tab_Icon_Map_upscaled.png")

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
	w = 60,
	h = 48
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

print("[Breach2] shared/sh_maprelated.lua loaded!")
