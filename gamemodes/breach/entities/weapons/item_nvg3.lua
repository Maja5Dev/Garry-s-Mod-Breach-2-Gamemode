
SWEP.Base			= "item_nvg_base"
SWEP.PrintName		= "Blue NVG"
SWEP.Category		= "Breach 2"

SWEP.EntityUpdateDelay = 4

if CLIENT then
	SWEP.NextCLUpdateEntities = 0
	SWEP.DisplayEntities = {}

	net.Receive("br_send_nvg_entities", function(len)
		local tab = net.ReadTable()
		local next_update = net.ReadFloat()
		local wep = LocalPlayer():GetWeapon("item_nvg3")

		if wep and istable(wep.DisplayEntities) then
			wep.DisplayEntities = tab
		end

		wep.NextCLUpdateEntities = next_update
	end)
else
	SWEP.NextUpdateEntities = 0

	function SWEP:GatherEntities()
		local entities = {}

		for k,v in pairs(ents.FindInSphere(self.Owner:GetPos(), 2000)) do
			if v:IsNPC() or (v:IsPlayer() and self.Owner != v and ((v:Alive() and !v:IsSpectator()) or v:IsDowned())) then
				local name = "Unknown"

				if v:IsPlayer() then
					if v.br_role == "SCP-173" then
						name = "SCP-173"
					else
						name = "Human"
					end
				end

				if BLUE_NVG_ENTITY_NAMES[v:GetClass()] then
					if BLUE_NVG_ENTITY_NAMES[v:GetClass()] == true then
						continue
					else
						name = BLUE_NVG_ENTITY_NAMES[v:GetClass()]
					end
				end

				table.ForceInsert(entities, {name, v:GetPos()})
			end
		end

		return entities
	end
end

function SWEP:GlobalThink()
	if self.BaseClass.GlobalThink then
		self.BaseClass.GlobalThink(self)
	end

	if self.Enabled and self.BatteryLevel > 0 and self.NextUpdateEntities < CurTime() then
		self.NextUpdateEntities = CurTime() + self.EntityUpdateDelay

		local entities = self:GatherEntities()

		net.Start("br_send_nvg_entities")
			net.WriteTable(entities)
			net.WriteFloat(self.NextUpdateEntities)
		net.Send(self.Owner)
	end
end


function SWEP:Deploy()
	self:SetHoldType(self.HoldType)
	self.Owner:DrawViewModel(!self.Enabled)

	if IsFirstTimePredicted() then
		if CLIENT then
			surface.PlaySound("breach2/items/pickitem2.ogg")
		end
		self.Weapon:SendWeaponAnim(ACT_VM_DEPLOY)
	end

	self.NextUpdateEntities = CurTime()
end

local function DrawNVG3EntitiesInfo(entities)
	for k,ent in pairs(entities) do
		local name = ent[1]
		local pos = ent[2]

		-- draw text where they are and how far away they are
		local dist = LocalPlayer():GetPos():Distance(pos)
		local pos2d = (pos + Vector(0,0,80)):ToScreen()
		local size = math.Clamp(2048 - dist, 32, 2048) / 2048

		draw.Text({
			text = name.." ("..math.Round(dist).." units)",
			pos = {pos2d.x, pos2d.y},
			font = "BR2_BlueNVG1",
			color = Color(255,255,255,200 * size),
			xalign = TEXT_ALIGN_CENTER,
			yalign = TEXT_ALIGN_CENTER,
		})
	end
end

function SWEP:GlobalDraw()
	self.BaseClass.GlobalDraw(self)

	if self.Enabled and self.DisplayEntities then
		DrawNVG3EntitiesInfo(self.DisplayEntities)

		draw.Text({
			text = "Next update in " .. string.format("%.1f", math.Clamp(self.NextCLUpdateEntities - CurTime(), 0, self.EntityUpdateDelay)),
			pos = {ScrW() / 2, ScrH() * 0.8},
			font = "BR2_BlueNVG1",
			color = Color(255,255,255,80),
			xalign = TEXT_ALIGN_CENTER,
			yalign = TEXT_ALIGN_BOTTOM,
		})
	end
end

SWEP.Enabled = false
SWEP.DefaultNVG = {
	contrast = 2.5,
	colour = 0,
	brightness = -0.12,
	clr_r = 0,
	clr_g = 0,
	clr_b = 1,
	add_r = 0,
	add_g = 0,
	add_b = 0.2,
	vignette_alpha = 255,
	draw_nvg = true,
	effect = function(nvg, tab, wep)
		--         Darken, Multiply, SizeX, SizeY, Passes, ColorMultiply, Red, Green, Blue
		DrawBloom(0,      1,        1,     1,     1,      1,            1,   1,     1)

		tab.contrast = nvg.contrast
		tab.colour = nvg.colour
		tab.brightness = nvg.brightness
		tab.clr_r = nvg.clr_r
		tab.clr_g = nvg.clr_g
		tab.clr_b = nvg.clr_b
		tab.add_r = nvg.add_r
		tab.add_g = nvg.add_g
		tab.add_b = nvg.add_b
		tab.vignette_alpha = nvg.vignette_alpha
	end,
	fog = function(fog_mul)
		render.FogStart(0)
		render.FogEnd((FOG_LEVEL * fog_mul) * 1.75)
		render.FogColor(1, 1, 2)
		render.FogMaxDensity(1)
		render.FogMode(MATERIAL_FOG_LINEAR)
		return true
	end
}
SWEP.NVG = table.Copy(SWEP.DefaultNVG)

function SWEP:NVGSettings()
	return {
		{"Contrast", "slider", {self.NVG.contrast, 0.5, 5, 2.5}, function(value) self.NVG.contrast = value end},
		{"Color", "slider", {self.NVG.add_b, 0.2, 2, 0.2}, function(value) self.NVG.add_b = value end},
		{"Brightness", "slider", {self.NVG.brightness, -1, 0, -0.12}, function(value) self.NVG.brightness = value end},
		{"Light", "slider", {self.DLightLevel, 0, 5, 0}, function(value) self.DLightLevel = value end},
	}
end

function SWEP:GetBetterOne()
	if br_914status == SCP914_ROUGH then
		return "item_nvg"

	elseif br_914status == SCP914_COARSE then
		return "item_nvg2"

	elseif br_914status == SCP914_1_1 then
		return "item_nvg_military"
	end

	return self
end
