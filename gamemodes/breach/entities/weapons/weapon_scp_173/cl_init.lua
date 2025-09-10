include("shared.lua")

function SWEP:SingleReload()
	if self.TeleportingMode then
		self.TeleportingMode = false
		--chat.AddText("Teleporting mode disabled")
	else
		self.TeleportingMode = true
		--chat.AddText("Teleporting mode enabled")
	end

	net.Start("br_scp173_mode")
		net.WriteBool(self.TeleportingMode)
	net.SendToServer()
end

function SWEP:DrawHUD()
	if BR2_ShouldDrawWeaponInfo() then
		draw.Text({
			text = "Shift shows the next position, W teleports you to the next position if possible",
			pos = {ScrW() / 2, ScrH() - 30},
			font = "BR2_ItemFont",
			color = Color(255,255,255,80),
			xalign = TEXT_ALIGN_CENTER,
			yalign = TEXT_ALIGN_BOTTOM,
		})
		draw.Text({
			text = "Clicking R toggles free roaming mode, A and D switch shoulder",
			pos = {ScrW() / 2, ScrH() - 6},
			font = "BR2_ItemFont",
			color = Color(255,255,255,80),
			xalign = TEXT_ALIGN_CENTER,
			yalign = TEXT_ALIGN_BOTTOM,
		})
	end

	if self.TeleportingMode then
		return
	end

	local ent173 = self.Owner:GetNWEntity("entity173")
	if IsValid(ent173) then
		cam.Start3D()
			render.SetColorMaterial()
			
			self.CColor = Color(0,255,25,120)
			local nextpostab = self:TraceNextPos(ent173)
			for k,v in pairs(nextpostab.hits) do
				if v.Hit == true then
					self.CColor = Color(200,0,0,120)
				end
			end
			
			local ourpos = ent173:GetPos()
			local eyeangles = self.Owner:EyeAngles()
			local tr = util.TraceLine({
				start = Vector(ourpos.x, ourpos.y, ourpos.z + 95),
				endpos = Vector(ourpos.x, ourpos.y, ourpos.z + 95) + eyeangles:Forward() * 450,
				filter = {self.Owner, ent173},
				mask = MASK_ALL
			})
			if LocalPlayer():KeyDown(IN_SPEED) or LocalPlayer():KeyDown(IN_FORWARD) then
				render.SetMaterial(material_173_1)
				local dir = vector_up
				local npos = nextpostab.start.HitPos
				if (npos.z - ourpos.z) > 100 then
					dir = Vector(0,0,-1)
				end
				render.DrawQuadEasy(npos, dir, 150, 150, self.CColor, 0)
				render.DrawBeam(npos, npos + Vector(0, 0, 200), 80, 0.5, 1, self.CColor)
				if tr.HitNormal.z == -1 then
					local tr2 = util.TraceLine({
						start = npos,
						endpos = npos + Angle(-90,0,0):Forward() * 2000,
						filter = filters
					})

					render.DrawQuadEasy(tr2.HitPos, Vector(0,0,-1), 150, 150, self.CColor, 0)
					render.DrawBeam(tr2.HitPos, tr2.HitPos + Vector(0, 0, -200), 80, 0.5, 1, self.CColor)
				end
			end
			--render.SetColorMaterial()
			--render.DrawSphere(LocalPlayer():GetPos(), 20, 30, 30, Color(255,255,0,255))
			--render.DrawSphere(self:GetNWVector("NextPos"), 20, 30, 30, Color(0,255,0,255))
		cam.End3D()
	end
	
	--surface.SetDrawColor(self.CColor.r, self.CColor.g, self.CColor.b, self.CColor.a)
	surface.SetDrawColor(255, 255, 255, 100)
	draw.NoTexture()
	draw.Circle(ScrW() / 2, ScrH() / 2, 2, 30, 360)
end

function SWEP:PreDrawHalos()
	local ent173 = self.Owner:GetNWEntity("entity173")
	if IsValid(ent173) then
		local ourpos = ent173:GetPos()
		local eyeangles = self.Owner:EyeAngles()
		local tr_halo = util.TraceLine({
			start = Vector(ourpos.x, ourpos.y, ourpos.z + 95),
			endpos = Vector(ourpos.x, ourpos.y, ourpos.z + 95) + eyeangles:Forward() * 400,
			filter = {self.Owner, ent173},
			mask = MASK_ALL
		})
		local ent = tr_halo.Entity
		local skip_ent = false
		local targets = table.Copy(self.Targets)
		for k,v in pairs(self.Targets) do
			if v == ent then
				skip_ent = true
			end
		end
		if IsValid(ent) then
			--chat.AddText('"' .. tostring(ent:GetClass()) .. '"')
			if ent:IsPlayer() == true and ent:Alive() == true and ent:IsSpectator() and ent:Team() != TEAM_SCP then
				if skip_ent == true then
					table.RemoveByValue(targets, ent)
					halo.Add({ent}, Color(255,150,0), 5, 5, 5, true, false)
				else
					halo.Add({ent}, Color(255,255,0), 5, 5, 5, true, false)
				end
			end
		end
		
		halo.Add(targets, Color(255,0,0), 5, 5, 5, true, false)
	end
end

