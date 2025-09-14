
debug_crosshair_enabled = false
concommand.Add("br2_debug_crosshair", function(ply, cmd, args)
	if debug_crosshair_enabled == true then
		debug_crosshair_enabled = false
		print("Debug crosshair disabled")
	else
		debug_crosshair_enabled = true
		print("Debug crosshair enabled")
	end
end)

local all_drawables = {}

function draw_debug_recursive(tbl, prev_k)
    for k,v in pairs(tbl) do
        if isvector(v) then
            cam.Start3D()
                render.SetColorMaterial()
                render.DrawSphere(v, 1, 80, 60, Color(0, 255, 0, 255))
            cam.End3D()

            local name = k
            local is_area = (name == "pos1" or name == "pos2")
            if is_area or not name or name == "" or name == "pos" or isnumber(name) then
                if tbl["name"] then
                    name = tbl["name"]

                elseif isstring(prev_k) then
                    name = prev_k

                elseif isstring(tbl["item_gen_group"]) then
                    name = tbl["item_gen_group"]
                end
                if is_area then
                    name = name .. " ("..k..")"
                end
            end

            local color = Color(255,255,255,100)
            if tbl.color then
                color = tbl.color
            end

			table.ForceInsert(all_drawables, {v, name, color})
            DrawInfo(v, tostring(name), color)

        elseif istable(v) then
            draw_debug_recursive(v, k)
        end
    end
end

function draw_area(pos1, pos2, clr, name)
	cam.Start3D()
		render.SetColorMaterial()
		render.DrawBox(Vector(0,0,0), Angle(0,0,0), pos1, pos2, clr, true)
	cam.End3D()
	
	local pos = (pos1 + pos2) / 2
	pos = pos:ToScreen()

	draw.Text({
		text = name,
		font = "BR_Righteous",
		xalign = TEXT_ALIGN_CENTER,
		yalign = TEXT_ALIGN_CENTER,
		pos = {pos.x, pos.y},
	})
end

function DebugDrawZones(draw_sub_zones)
	if MAPCONFIG != nil then
		for k,v in pairs(MAPCONFIG.ZONES) do
			for k2,box in pairs(v) do
				if draw_sub_zones and box.sub_areas then
					for k3,box2 in pairs(box.sub_areas) do
						draw_area(box2[2], box2[3], box.color, box2[1])
					end
				end

				if box.pos1 then
					draw_area(box.pos1, box.pos2, box.color, box.name)
				end
			end
		end
	end
end

function DrawDebug()
	if #all_drawables > 0 then
		local lpos = LocalPlayer():GetPos()
		for k,v in pairs(all_drawables) do
			if v[1]:Distance(lpos) < 3000 then
				DrawInfo(v[1], v[2], v[3])
			end
		end
	else
		draw_debug_recursive(MAPCONFIG)
	end

	if debug_view_mode > 1 then
		DebugDrawZones(true)
	end

	if debug_crosshair_enabled then
		draw.Text({
			text = "+",
			font = "Default",
			pos = {ScrW()/2, ScrH()/2},
			xalign = TEXT_ALIGN_CENTER,
			yalign = TEXT_ALIGN_CENTER,
			color = Color(255,255,255,25)
		})
	end
end

local function DrawDebug914()
	local skip_ents = {}
	
	for k,v in pairs(ents.GetAll()) do
		if v:GetClass() == "class C_BaseEntity" and v:GetPos():Distance(Vector(10979, -3697, -10957)) < 5 then
			table.ForceInsert(skip_ents, v)
			--print(v)
		end
	end
	
	cam.Start3D()
		local tr = util.TraceLine({
			start = LocalPlayer():EyePos(),
			endpos = LocalPlayer():EyePos() + (LocalPlayer():EyeAngles():Forward() * 1000),
			--mask = CONTENTS_SOLID + CONTENTS_MOVEABLE + CONTENTS_OPAQUE,
			mask = CONTENTS_SOLID + CONTENTS_MOVEABLE,
			filter = skip_ents
		})
		render.SetColorMaterial()
		render.DrawSphere(tr.HitPos, 0.5, 30, 30, Color(255, 255, 255, 50))
		--if input.IsKeyDown(KEY_G) then
		--	print(tr.HitPos)
		--end
	cam.End3D()
	
	local pos_tab = {
		{
			st = Vector(10980.968750, -3688.924072, -10957.142578),
			en = Vector(10980.968750, -3691.739502, -10957.219727)
		},
		{
			st = Vector(10980.968750, -3690.754395, -10951.054688),
			en = Vector(10980.968750, -3693.096924, -10953.384766)
		},
		{
			st = Vector(10980.968750, -3697.023926, -10948.039063),
			en = Vector(10980.968750, -3696.967285, -10951.536133)
		},
		{
			st = Vector(10980.968750, -3703.054688, -10951.053711),
			en = Vector(10980.968750, -3701.015625, -10953.105469)
		},
		{
			st = Vector(10980.968750, -3706.023682, -10956.677734),
			en = Vector(10980.968750, -3702.247559, -10956.570313)
		},
	}
	
	for i,v in ipairs(pos_tab) do
		local tr = util.TraceLine({
			start = v.st,
			endpos = v.en,
			mask = CONTENTS_SOLID + CONTENTS_MOVEABLE + CONTENTS_OPAQUE,
			--mask = MASK_SHOT_PORTAL,
			filter = skip_ents
		})
		cam.Start3D()
			render.SetColorMaterial()
			if tr.Hit == true then
				render.DrawSphere(tr.HitPos, 0.5, 15, 15, Color(0, 255, 0, 255))
			else
				render.DrawSphere(tr.HitPos, 0.5, 15, 15, Color(255, 0, 0, 255))
			end
		cam.End3D()
	end
end

print("[Breach2] client/hud/hud_debug.lua loaded!")