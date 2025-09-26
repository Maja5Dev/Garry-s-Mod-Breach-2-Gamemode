
SWEP.Base			= "br2_item_base"
SWEP.PrintName		= "C4 Bomb"
SWEP.Spawnable		= true
SWEP.AdminSpawnable	= true
SWEP.Category		= "Breach 2"
SWEP.Slot			= 5
SWEP.SlotPos		= 0
SWEP.clevel			= 0

SWEP.ViewModelFOV 	= 54
SWEP.ViewModel		= "models/weapons/cstrike/c_c4.mdl"
SWEP.WorldModel		= "models/weapons/w_c4.mdl"
SWEP.HoldType		= "slam"
SWEP.UseHands		= true
SWEP.Pickupable 	= true

SWEP.PlantDistance 	= 100
SWEP.isArmed 		= false
SWEP.Activated		= false
SWEP.Timer 			= 30

SWEP.CustomDrop = function(self)
	local wep = self.Owner:GetWeapon("item_c4")
	local c4planted = ents.Create("br2_c4_charge")

	if IsValid(c4planted) then
		c4planted.UsePhysics = true
		c4planted:SetPos(self.Owner:GetPos())
		c4planted:Spawn()
		c4planted:Activate()
		c4planted.isArmed = wep.isArmed
		c4planted.Activated = wep.Activated
		c4planted.Timer = wep.Timer

		if wep.nextExplode then
			c4planted.nextExplode = wep.nextExplode
		end

		c4planted:SetMoveType(MOVETYPE_VPHYSICS)
	end
	self.Owner:StripWeapon("item_c4")
end

SWEP.Contents = {
	set_timer_30 = {
		id = 1,
		name = "Timer - 30s",
		desc = "Set the bomb's timer to 30 seconds",
		cl_effect = function(self)
			if self.Activated == true then
				chat.AddText(Color(255,0,0,255), "(C4) The timer cannot be set now")
			else
				chat.AddText(Color(255,0,0,255), "(C4) Timer set to 30 seconds")
				self.Timer = 30
			end
		end,
		sv_effect = function(self, ply)
			if self.Activated == false then
				self.Timer = 30
			end
		end
	},
	set_timer_60 = {
		id = 2,
		name = "Timer - 60s",
		desc = "Set the bomb's timer to 60 seconds",
		cl_effect = function(self)
			if self.Activated == true then
				chat.AddText(Color(255,0,0,255), "(C4) The timer cannot be set now")
			else
				chat.AddText(Color(255,0,0,255), "(C4) Timer set to 60 seconds")
				self.Timer = 60
			end
		end,
		sv_effect = function(self, ply)
			if self.Activated == false then
				self.Timer = 60
			end
		end
	},
	set_timer_120 = {
		id = 3,
		name = "Timer - 2min",
		desc = "Set the bomb's timer to 2 minutes",
		cl_effect = function(self)
			if self.Activated == true then
				chat.AddText(Color(255,0,0,255), "(C4) The timer cannot be set now")
			else
				chat.AddText(Color(255,0,0,255), "(C4) Timer set to 2 minutes")
				self.Timer = 120
			end
		end,
		sv_effect = function(self, ply)
			if self.Activated == false then
				self.Timer = 120
			end
		end
	},
	arm = {
		id = 4,
		name = "Arm",
		desc = "Arm the bomb",
		cl_effect = function(self)
			if self.Activated == true then
				chat.AddText(Color(255,0,0,255), "(C4) The bomb cannot be armed now")
			else
				chat.AddText(Color(255,0,0,255), "(C4) The bomb has been armed")
				self.isArmed = true
			end
		end,
		sv_effect = function(self, ply)
			if self.Activated == false then
				self.isArmed = true
			end
		end
	},
	disarm = {
		id = 5,
		name = "Disarm",
		desc = "Disarm the bomb",
		cl_effect = function(self)
			if self.Activated == true then
				chat.AddText(Color(255,0,0,255), "(C4) The bomb cannot be disarmed now")
			else
				chat.AddText(Color(255,0,0,255), "(C4) The bomb has been disarmed")
				self.isArmed = false
			end
		end,
		sv_effect = function(self, ply)
			if self.Activated == false then
				self.isArmed = false
			end
		end
	},
	activate = {
		id = 6,
		name = "Activate Timer",
		desc = "Activate the bomb timer",
		cl_effect = function(self)
			if self.Activated == true then
				chat.AddText(Color(255,0,0,255), "(C4) The bomb has already been activated!")
			else
				if self.isArmed then
					chat.AddText(Color(255,0,0,255), "(C4) Activated, the bomb will explode in "..self.Timer.." seconds")
					self.Activated = true
				else
					chat.AddText(Color(255,0,0,255), "(C4) The bomb must be armed to activate the timer")
				end
			end
		end,
		sv_effect = function(self, ply)
			if self.isArmed and self.Activated == false then
				self.Activated = true
				self.nextExplode = CurTime() + self.Timer
			end
		end
	},
	defuse = {
		id = 7,
		name = "Defuse the bomb",
		desc = "Try to defuse the bomb",
		cl_effect = function(self)
			if self.Activated then
				self.Activated = false
				self.isArmed = false
			else
				chat.AddText(Color(255,0,0,255), "(C4) The bomb hasn't been activated")
			end
		end,
		sv_effect = function(self, ply)
			if self.Activated then
				self.Activated = false
				self.isArmed = false
				local str = 'chat.AddText(Color(255,0,0,255), "(C4) Bomb defused. Timer of the bomb indicates that the bomb would explode in '..math.Round(self.nextExplode-CurTime(), 1)..' seconds.")'
				ply:SendLua(str)
			end
		end
	},
	explode = {
		id = 8,
		name = "Explode",
		desc = "Force the bomb to explode",
		cl_effect = function(self)
			if self.isArmed == false then
				chat.AddText(Color(255,0,0,255), "(C4) The bomb must be armed to explode")
			else
				surface.PlaySound("breach2/explosion_near.wav")
			end
		end,
		sv_effect = function(self, ply)
			if self.isArmed then
				ply:StripWeapon(self:GetClass())
				C4BombExplode(self, 500, 200, ply)
			end
		end
	},
}

function SWEP:Deploy()
	self:SetHoldType(self.HoldType)

	if SERVER then
		self.Owner:SendLua('LocalPlayer():GetActiveWeapon().isArmed = '..tostring(self.isArmed))
		self.Owner:SendLua('LocalPlayer():GetActiveWeapon().Activated = '..tostring(self.Activated))
		self.Owner:SendLua('LocalPlayer():GetActiveWeapon().Timer = '..tostring(self.Timer))
		
		if self.nextExplode then
			self.Owner:SendLua('LocalPlayer():GetActiveWeapon().nextExplode = '..tostring(self.nextExplode))
		end
	end
end

function SWEP:TraceChecks()
	local pos = 0
	local ang = 0

	if SERVER then
		local tr1 = self.Owner:GetAllEyeTrace()
		pos = tr1.HitPos
		ang = tr1.HitNormal:Angle()
		ang:RotateAroundAxis(ang:Right(), -90)
		ang:RotateAroundAxis(ang:Up(), 180)
	else
		pos = c4ghost:GetPos()
		ang = c4ghost:GetAngles()
	end

	local traces = {
		pos + (ang:Forward() * 8),
		pos - (ang:Forward() * 5),
		pos + (ang:Right() * 12),
		pos - (ang:Right() * 9),
		pos - (ang:Right() * 9) + Vector(0,0,7),
		pos + (ang:Right() * 12) + Vector(0,0,7),
		pos + (Angle(ang.pitch - 90, ang.yaw, ang.roll):Forward() * 10),
	}

	for k,v in pairs(traces) do
		local tr = util.TraceLine({
			start = pos,
			endpos = v,
		})
		if IsValid(c4ghost) then tr.filter = c4ghost end
		if tr.Hit then return false end
	end

	return true
end

SWEP.nextBeep = 0
function SWEP:Think()
	if self:GetHoldType() != self.HoldType then
		self:SetHoldType(self.HoldType)
	end

	if IsValid(c4ghost) then
		local tr = self.Owner:GetAllEyeTrace()
		local pos = tr.HitPos
		local ang = tr.HitNormal:Angle()
		c4ghost:SetPos(pos)
		ang:RotateAroundAxis(ang:Right(), -90)
		ang:RotateAroundAxis(ang:Up(), 180)

		local dist = pos:Distance(self.Owner:GetPos())
		if dist < self.PlantDistance and tr.HitWorld and self:TraceChecks() == true and self.Owner:OnGround() then
			c4ghost:SetNoDraw(false)
			c4ghost:SetColor(Color(0,255,0))
		else
			if dist > 600 then
				c4ghost:SetNoDraw(true)
			else
				c4ghost:SetNoDraw(false)
				c4ghost:SetColor(Color(255,0,0))
			end
		end
		
		c4ghost:SetAngles(ang)
	elseif CLIENT then
		c4ghost = ents.CreateClientProp()
		c4ghost:SetModel("models/weapons/w_c4_planted.mdl")
		c4ghost:Spawn()
	end

	if self.Planting then
		if self.Wait < CurTime() then
			self.Owner:Freeze(false)
			if self.Owner.StripWeapon then
				self.Owner:StripWeapon(self:GetClass())
				local c4planted = ents.Create("br2_c4_charge")
				if IsValid(c4planted) then
					c4planted:SetPos(self.PlantPos)
					c4planted:SetAngles(self.PlantAngles)
					c4planted:Spawn()
					c4planted:Activate()
					c4planted.isArmed = self.isArmed
					c4planted.Activated = self.Activated
					c4planted.Timer = self.Timer
					if self.nextExplode then
						c4planted.nextExplode = self.nextExplode
					end
				end
			end
		end
	end
end

function SWEP:Reload()
end

function SWEP:Holster()
	if self.Planting then
		return false
	else
		if IsValid(c4ghost) then
			c4ghost:Remove()
		end
		return true
	end
end

function SWEP:OnRemove()
	if IsValid(c4ghost) then
		c4ghost:Remove()
	end
	if self.Owner.Freeze then
		self.Owner:Freeze(false)
	end
end

SWEP.PlantPos = nil
SWEP.PlantAngles = nil
SWEP.Planting = false
SWEP.Wait = 0
function SWEP:PrimaryAttack()
	if not IsFirstTimePredicted() then return end
	if self.Wait > CurTime() then return end
	local tr = self.Owner:GetAllEyeTrace()
	if tr.HitPos:Distance(self.Owner:GetPos()) < self.PlantDistance and tr.HitWorld and self:TraceChecks() == true and self.Owner:OnGround() then
		local tr = self.Owner:GetAllEyeTrace()
		self.PlantPos = tr.HitPos
		local ang = tr.HitNormal:Angle()
		ang:RotateAroundAxis(ang:Right(), -90)
		ang:RotateAroundAxis(ang:Up(), 180)
		self.PlantAngles = ang
		self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
		self.Wait = CurTime() + self.Owner:GetViewModel():SequenceDuration()
		self.Planting = true
		self.Owner:Freeze(true)
	end
end

function SWEP:CreateFrame()

	if IsValid(WeaponFrame) then
		WeaponFrame:Remove()
	end

	WeaponFrame = vgui.Create("DFrame")
	WeaponFrame:SetSize(300, 400)
	WeaponFrame:SetTitle("")
	WeaponFrame.Paint = function(self, w, h)
		if IsValid(self) == false then
			return
		end
		draw.Text({
			text = "C4 ACTIONS",
			pos = {4, 4},
			xalign = TEXT_ALIGN_LEFT,
			yalign = TEXT_ALIGN_TOP,
			font = "BR_HOLSTER_TITLE",
			color = Color(255,255,255,255),
		})
		if input.IsKeyDown(KEY_ESCAPE) then
			self:KillFocus()
			self:Remove()
			gui.HideGameUI()
			return
		end
	end

	local last_y = 24
	for i=1, table.Count(self.Contents) do
		local item = nil

		for k,v in pairs(self.Contents) do
			if v.id == i then
				item = v
			end
		end
		
		local panel = vgui.Create("DPanel", WeaponFrame)
		panel:SetSize(300 - 8, 50 - 8)
		panel:SetPos(4, 4 + last_y)
		panel.Paint = function(self, w, h)
			draw.RoundedBox(0, 0, 0, w, h, Color(100, 100, 100, 100))
			draw.Text({
				text = item.name,
				pos = {4, 2},
				xalign = TEXT_ALIGN_LEFT,
				yalign = TEXT_ALIGN_TOP,
				font = "BR_HOLSTER_CONTENT_NAME",
				color = Color(255,255,255,255),
			})
			draw.Text({
				text = item.desc,
				pos = {4, h - 2},
				xalign = TEXT_ALIGN_LEFT,
				yalign = TEXT_ALIGN_BOTTOM,
				font = "BR_HOLSTER_CONTENT_AMOUNT",
				color = Color(255,255,255,255),
			})
		end

		local panel2 = vgui.Create("DButton", panel)
		panel2:SetPos(300 - 50 - 0, 0)
		panel2:SetSize(50 - 8, 50 - 8)
		panel2:SetText("")
		panel2.Paint = function(self, w, h)
			draw.RoundedBox(0, 0, 0, w, h, Color(255, 255, 255, 100))
			draw.Text({
				text = "DO",
				pos = {w / 2, h / 2},
				xalign = TEXT_ALIGN_CENTER,
				yalign = TEXT_ALIGN_CENTER,
				font = "BR_HOLSTER_CONTENT_USE",
				color = Color(255,255,255,255),
			})
		end
		panel2.DoClick = function()
			item.cl_effect(self)
			net.Start("br_c4_action")
				net.WriteInt(item.id, 8)
			net.SendToServer()
			WeaponFrame:Remove()
		end
		last_y = last_y + (50 - 8) + 6
	end

	WeaponFrame:SetSize(300, last_y + 4)
	WeaponFrame:Center()
	WeaponFrame:MakePopup()
end

function SWEP:SecondaryAttack()
	if CLIENT then
		self:CreateFrame()
	end
end

function SWEP:DrawHUD()
	if !BR2_ShouldDrawWeaponInfo() then return end
	
	draw.Text({
		text = "Primary attack plants the C4, secondary opens settings menu",
		pos = { ScrW() / 2, ScrH() - 6},
		font = "BR2_ItemFont",
		color = Color(255,255,255,80),
		xalign = TEXT_ALIGN_CENTER,
		yalign = TEXT_ALIGN_BOTTOM,
	})
end

function SWEP:GetBetterOne()
	if br_914status == SCP914_VERY_FINE and weapons.Get("kanade_tfa_rpg") then
		return "kanade_tfa_rpg"
	end

	return self
end
