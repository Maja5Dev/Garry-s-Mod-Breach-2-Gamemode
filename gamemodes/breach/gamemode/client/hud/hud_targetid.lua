
function DrawText(text, font, posx, posy, color, align)
	surface.SetFont(font)
	surface.SetTextColor(color.r, color.g, color.b, color.a)
	if align == true then
		local tw, th = surface.GetTextSize(text)
		tw = tw / 2
		th = th / 2
		surface.SetTextPos(posx - tw, posy - th)
	else
		surface.SetTextPos(posx, posy)
	end
	surface.DrawText(text)
end

lastseen_player = NULL
lastseen_nick = ""
lastseen_color = Color(0,0,0,0)
lastseen_alpha = 0
lastseen = 0

function weird_testing()
	local tr = util.TraceHull({
		start = LocalPlayer():EyePos(),
		endpos = LocalPlayer():EyePos() + LocalPlayer():EyeAngles():Forward() * 10000,
		mins = Vector(-10, -10, -10),
		maxs = Vector(10, 10, 10),
		--mask = MASK_SHOT_HULL
		mask = MASK_ALL
	})
	print(tr, tr.HitPos, tr.Entity, tr.Entity:GetSolidFlags())
end

function DrawTargetID()
	if IsValid(LocalPlayer()) and isfunction(LocalPlayer().GetEyeTrace) and !LocalPlayer():Alive() or LocalPlayer():IsSpectator() or BR_AnyMenusOn() then return end
	local trace = LocalPlayer():GetAllEyeTrace()

	if trace == nil then return end

	local is_checking = false
	if trace.Hit and trace.HitNonWorld then
		local ent = trace.Entity
		if IsValid(ent) == false or ent:GetNoDraw() == true then return end

		local dis = LocalPlayer():GetPos():Distance(ent:GetPos())
		if ent:IsPlayer() then
			if ent:IsSpectator() == false and math.Round(dis) < (FOG_LEVEL * 0.4) then
				lastseen_player = ent
				if LocalPlayer():IsSpectator() then
					lastseen_nick = ent:Nick()
				else
					if isstring(ent.br_showname) then
						lastseen_nick = ent.br_showname
					else
						lastseen_nick = "[Unknown]"
					end
					if LocalPlayer():IsAdmin() then
						lastseen_nick = lastseen_nick .. " (" .. ent:Nick() .. ")"
					end
				end
				lastseen_color = Color(255,255,255)
				lastseen = CurTime() + 2
				lastseen_alpha = 255
			end

		elseif isstring(ent.PrintName) and EntIsPickupable(ent) then
			lastseen_nick = ent.PrintName
			lastseen_player = ent
			lastseen_color = item_halo_color
			lastseen = CurTime() + 2
			lastseen_alpha = 255

		elseif ent:GetClass() == "prop_ragdoll" and dis < 70 then
			lastseen_player = ent
			--print(ent)
			--print(ent.Pulse)
			if ent.Pulse == nil then
				--if progress_bar_end == nil then
				if progress_circle_end == nil then
					lastseen_nick = "Press E to check the pulse"
					if input.IsButtonDown(KEY_E) then
						--progress_bar_time = 4
						--progress_bar_end = CurTime() + 4
						progress_circle_time = 4
						progress_circle_end = CurTime() + 4
						progress_circle_color = Color(255,255,255,255)
						last_body = ent
						--progress_bar_func = function()
						progress_circle_func = function()
							--net.Start("br_check_pulse")
							net.Start("br_end_checking_pulse")
							net.SendToServer()
						end
						net.Start("br_start_checking_pulse")
						net.SendToServer()
						is_checking = true
					end
				else
					lastseen_nick = "Checking the pulse..."
					is_checking = true
				end
				lastseen_color = Color(255,255,255)
				lastseen = CurTime() + 2
				lastseen_alpha = 255
			else
				if isnumber(ent.Pulse) and (ent.Pulse + 24) < CurTime() then
					ent.Pulse = nil
					return
				end
				
				local revive_text1 = "Press E to revive"
				local revive_text2 = "Reviving..."
				local can_revive = true
				
				if LocalPlayer().br_role == "SCP-049" then
					revive_text1 = "Press E to cure"
					revive_text2 = "Curing..."
					
				elseif ent.Pulse == true then
					lastseen_nick = "Dead"
					can_revive = false
				end
				
				if can_revive then
					--if progress_bar_end == nil then
					if progress_circle_end == nil then
						lastseen_nick = revive_text1
						if input.IsButtonDown(KEY_E) then
							--progress_bar_time = 8
							--progress_bar_end = CurTime() + 8
							progress_circle_time = 8
							progress_circle_end = CurTime() + 8
							progress_circle_color = Color(255,0,0,255)

							progress_circle_func = function()
							--progress_bar_func = function()
								net.Start("br_end_reviving")
								net.SendToServer()
							end
							
							net.Start("br_start_reviving")
							net.SendToServer()

							is_checking = true
						end
					else
						lastseen_nick = revive_text2
						is_checking = true
					end
				end
				lastseen_color = Color(255,0,0)
				lastseen = CurTime() + 2
				lastseen_alpha = 255
			end
		end
	end
	/*
	if is_checking == false and progress_bar_end != nil then
		progress_bar_time = nil
		progress_bar_end = nil
		progress_bar_func = nil
		progress_bar_status = 0
	end
	*/
	
	if progress_circle_end != nil and IsValid(last_body) then
		if (last_body:GetPos():Distance(LocalPlayer():GetPos()) > 60) or LocalPlayer():KeyDown(IN_ATTACK) or LocalPlayer():KeyDown(IN_ATTACK2) then
			progress_circle_time = nil
			progress_circle_end = nil
			progress_circle_func = nil
			progress_circle_status = 0
		end
	end
	
	if lastseen_alpha > 0 then
		lastseen_alpha = lastseen_alpha - 4
		--DrawText(lastseen_nick, "BR_TargetID", ScrW() / 2 + 2, ScrH() / 2 + 47, Color(0, 0, 0, lastseen_alpha), true)
		DrawText(lastseen_nick, "BR_TargetID", ScrW() / 2, ScrH() - 16, Color(lastseen_color.r, lastseen_color.g, lastseen_color.b, lastseen_alpha), true)
	end
end

print("[Breach2] client/hud/hud_targetid.lua loaded!")
