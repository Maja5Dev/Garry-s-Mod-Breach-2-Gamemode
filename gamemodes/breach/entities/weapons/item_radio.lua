
SWEP.Base			= "br2_item_base"
SWEP.PrintName		= "Radio"
--SWEP.ViewModel		= "models/mishka/models/radio.mdl"
--SWEP.WorldModel		= "models/mishka/models/radio.mdl"
SWEP.ViewModel		= "models/radio/c_radio.mdl"
SWEP.WorldModel		= "models/radio/w_radio.mdl"
SWEP.Slot			= 6
SWEP.SlotPos		= 1
SWEP.Spawnable		= true
SWEP.AdminSpawnable	= true
SWEP.Category		= "Breach 2"
SWEP.Pickupable 	= true
SWEP.UseHands 		= true

SWEP.IsRadio = true
SWEP.Channel = 1
SWEP.Enabled = false
SWEP.NextChange = 0

SWEP.BatteryLevel = math.random(60,100)
SWEP.BatterySpeed = 4

SWEP.BoneAttachment = "ValveBiped.Bip01_R_Hand"
SWEP.WorldModelPositionOffset = Vector(6, -4, -2)
SWEP.WorldModelAngleOffset = Angle(90, -45, 90)

function SWEP:SaveVariablesTo(ent)
	ent.BatteryLevel = self.BatteryLevel
end

function SWEP:Deploy()
	self.Owner:DrawViewModel(false)
	if CLIENT and IsFirstTimePredicted() then
		surface.PlaySound("breach2/pickitem2.ogg")
		self:RemoveSounds()
	end
end

function SWEP:DrawWorldModel()
	if LocalPlayer() != self.Owner and (LocalPlayer():GetObserverMode() == OBS_MODE_IN_EYE) then return end
	if !IsValid(self.Owner) then
		self:DrawModel()
	else
		if !IsValid(self.WM) then
			self.WM = ClientsideModel(self.WorldModel)
			self.WM:SetNoDraw(true)
		end

		local boneid = self.Owner:LookupBone(self.BoneAttachment)
		if not boneid then return end

		local matrix = self.Owner:GetBoneMatrix(boneid)
		if not matrix then return end

		local newpos, newang = LocalToWorld(self.WorldModelPositionOffset, self.WorldModelAngleOffset, matrix:GetTranslation(), matrix:GetAngles())

		self.WM:SetPos(newpos)
		self.WM:SetAngles(newang)
		self.WM:SetupBones()
		if self.ForceSkin then
			self.WM:SetSkin(self.ForceSkin)
		end
		self.WM:DrawModel()
	end
end

function SWEP:PlaySound(name, volume, looping)
	if CLIENT then
		sound.PlayFile(name, "mono noblock", function(station, errorID, errorName)
			if IsValid(station) then
				station:SetPos(LocalPlayer():GetPos())
				station:SetVolume(volume)
				if looping then
					station:EnableLooping(looping)
					station:SetTime(360)
				end
				station:Play()
				LocalPlayer().channel = station
			end
		end)
	end
end

function SWEP:RemoveSounds()
	if CLIENT then
		if LocalPlayer().channel != nil then
			LocalPlayer().channel:EnableLooping(false)
			LocalPlayer().channel:Stop()
			LocalPlayer().channel = nil
		end
	end
end

function SWEP:StopSounds()
	if CLIENT then
		if LocalPlayer().channel != nil then
			LocalPlayer().channel:SetVolume(0)
		end
	end
end

SWEP.LastSound = 0
function SWEP:CheckSounds()
	if CLIENT then
		local r = "sound/radio/"
		if self.Channel == 1 then
			self:PlaySound(r .. "radioalarm.ogg", 1, true)
			self.IsLooping = true
		elseif self.Channel == 2 then
			self:PlaySound(r .. "radioalarm2.ogg", 1, false)
			self.NextSoundCheck = CurTime() + 12
			self.IsLooping = false
		elseif self.Channel == 3 then
			self.LastSound = self.LastSound + 1
			if IsValid(LocalPlayer().channel) then
				LocalPlayer().channel:EnableLooping(false)
				LocalPlayer().channel:Stop()
			end
			if self.LastSound == 0 then
				self.NextSoundCheck = CurTime() + 24
			elseif self.LastSound == 1 then
				self.NextSoundCheck = CurTime() + 15
			elseif self.LastSound == 2 then
				self.NextSoundCheck = CurTime() + 21
			elseif self.LastSound == 3 then
				self.NextSoundCheck = CurTime() + 25
			elseif self.LastSound == 4 then
				self.NextSoundCheck = CurTime() + 28
			elseif self.LastSound == 5 then
				self.NextSoundCheck = CurTime() + 35
			elseif self.LastSound == 6 then
				if true or math.random(1,5) == 3 then
					self:PlaySound(r.."morioh_radio_1.mp3", 1, false)
					self.IsLooping = false
					self.NextSoundCheck = CurTime() + 48
				else
					self.NextSoundCheck = CurTime() + 46
				end
			elseif self.LastSound == 7 then
				self.NextSoundCheck = CurTime() + 20
			elseif self.LastSound == 8 then
				self.NextSoundCheck = CurTime() + 24
			elseif self.LastSound == 9 then
				self.LastSound = 0
				self.NextSoundCheck = CurTime() + 24
			end
			local sound = "scpradio" .. self.LastSound
			--print(r .. sound .. ".ogg")
			self:PlaySound(r .. sound .. ".ogg", 1, false)
			self.IsLooping = false
		elseif self.Channel == 4 then
			if #RADIO4SOUNDS > 0 then
				if math.random(1,4) == 4 then
					local rndtbl = table.Random(RADIO4SOUNDS)
					self:PlaySound(r .. rndtbl[1] .. ".ogg", 1, false)
					self.NextSoundCheck = CurTime() + rndtbl[2] + 5
					self.IsLooping = false
					table.RemoveByValue(RADIO4SOUNDS, rndtbl)
				else
					self.NextSoundCheck = CurTime() + 5
					self.IsLooping = false
				end
			else
				self.IsLooping = true
			end
		end
	end
end

SWEP.IsLooping = false
SWEP.NextSoundCheck = 0
SWEP.NextBatteryCheck = 0
function SWEP:Think()
	if SERVER then
		if self.NextBatteryCheck < CurTime() then
			if self.Enabled then
				self.BatteryLevel = self.BatteryLevel - 1
				if self.BatteryLevel < 1 then self.BatteryLevel = 0 end
			end
			self.NextBatteryCheck = CurTime() + self.BatterySpeed
			net.Start("br_updatebattery")
				net.WriteInt(self.BatteryLevel, 8)
				net.WriteInt(self.Slot, 8)
			net.Send(self.Owner)
		end
		return
	end
	if self.Enabled then
		if self.IsLooping == false then
			if self.NextSoundCheck < CurTime() then
				if self.BatteryLevel > 0 then
					self:CheckSounds()
				else
					self:RemoveSounds()
				end
			end
		end
	end
end

function SWEP:PrimaryAttack()
	if !self.Enabled then return end
	if self.NextChange > CurTime() then return end
	self.Channel = self.Channel + 1
	if self.Channel > 9 then
		self.Channel = 1
	end
	if CLIENT then
		surface.PlaySound("radio/squelch.ogg")
	end
	self.IsLooping = false
	self:RemoveSounds()
	if self.Enabled then
		if self.BatteryLevel > 0 then
			self:CheckSounds()
		else
			self:RemoveSounds()
		end
	end
	self.NextChange = CurTime() + 0.1
end

function SWEP:OnRemove()
	if CLIENT then
		self.IsLooping = false
		self:StopSounds()
		self.Enabled = false
	end
end

function SWEP:SecondaryAttack()
	if self.NextChange > CurTime() then return end
	self.Enabled = !self.Enabled
	self.NextChange = CurTime() + 0.1
	if CLIENT then
		if self.Enabled then
			if IsValid(LocalPlayer().channel) then
				LocalPlayer().channel:SetVolume(1)
			end
		else
			self:StopSounds()
		end
	end
end

function SWEP:CanPrimaryAttack()
end

local ourMat = Material("breach2/RadioHUD.png")
function SWEP:DrawHUD()
	if LocalPlayer() != self.Owner then return end
	local rw = math.Clamp(ScrW(), 1, 1920) / 7.6
	local rh = (rw * 2) * 1.1
	local size_mul = math.Clamp(ScrH() / 1080, 0.1, 1)
	surface.SetDrawColor(255, 255, 255, 255)
	surface.SetMaterial(ourMat)
	surface.DrawTexturedRect(ScrW() - rw, ScrH() - rh + 1, rw, rh)
	if !self.Enabled and BR2_ShouldDrawWeaponInfo() then
		draw.Text({
			text = "Primary attack changes the channel and secondary attack toggles the radio",
			pos = { ScrW() / 2, ScrH() - 15},
			font = "BR2_ItemFont",
			color = Color(255,255,255,80),
			xalign = TEXT_ALIGN_CENTER,
			yalign = TEXT_ALIGN_CENTER,
		})
	end
	if self.Enabled then
		draw.Text({
			text = self.Channel,
			pos = {ScrW() - rw + (174 * size_mul), ScrH() - rh + (390 * size_mul)},
			font = "BR2_RadioFont_1",
			color = Color(0,0,0,250),
			xalign = TEXT_ALIGN_RIGHT,
			yalign = TEXT_ALIGN_TOP,
		})
		draw.Text({
			text = "CHN",
			--text = tostring(self.BatteryLevel),
			pos = {ScrW() - rw + (150 * size_mul), ScrH() - rh + (394 * size_mul)},
			font = "BR2_RadioFont_2",
			color = Color(0,0,0,250),
			xalign = TEXT_ALIGN_RIGHT,
			yalign = TEXT_ALIGN_TOP,
		})
		draw.Text({
			text = ""..self.BatteryLevel.."%",
			pos = {ScrW() - rw + (66 * size_mul), ScrH() - rh + (438 * size_mul)},
			font = "BR2_RadioFont_3",
			color = Color(0,0,0,250),
			xalign = TEXT_ALIGN_LEFT,
			yalign = TEXT_ALIGN_BOTTOM,
		})
	end
end

function SWEP:GetBetterOne()
	if br_914status == 1 or br_914status == 2 then
		return nil
	elseif br_914status == 3 or br_914status == 4 then
		return "item_radio"
	elseif br_914status == 5 then
		return "item_radio2"
	end
	return nil
end
