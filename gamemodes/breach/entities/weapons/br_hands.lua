SWEP.Base = "tfa_melee_base"
DEFINE_BASECLASS(SWEP.Base)

SWEP.PrintName 		= "Hands"
SWEP.Spawnable		= true
SWEP.AdminSpawnable	= true
SWEP.Category 		= "Breach 2"
SWEP.Slot			= 0
SWEP.SlotPos		= 0
SWEP.HoldType 		= "normal"
SWEP.ViewModel 		= "models/weapons/tfa_nmrih/v_me_fists.mdl"
SWEP.WorldModel 	= ""
SWEP.ViewModelFOV 	= 50
SWEP.UseHands 		= true

SWEP.Pickupable = false
SWEP.PushingMode = true
SWEP.SCP049Mode = false
SWEP.PunchingMode = false
SWEP.IsHands = true

function SWEP:IsSCP049()
	if CLIENT then
		return (BR2_OURNOTEPAD.people and BR2_OURNOTEPAD.people[1] != nil and BR2_OURNOTEPAD.people[1].br_role == ROLE_SCP_049)
	else
		return (self.Owner.br_role == ROLE_SCP_049)
	end
end

SWEP.NextReload = 0
function SWEP:Reload()
	if not IsFirstTimePredicted() or self.NextReload > CurTime() then return end
	self.NextReload = CurTime() + 0.5

	local dmg_holdtype = "fist"

	if self:IsSCP049() then
		self.PushingMode = false
		self.PunchingMode = false
		self.SCP049Mode = true
		self.HoldType = "pistol"

		if SERVER then
			self:SetHoldType(self.HoldType)
		end

		return
	else
		self.PunchingMode = !self.PunchingMode
	end

	self.PushingMode = !self.PushingMode

	if self.PushingMode then
		self.HoldType = "normal"
	else
		self.HoldType = dmg_holdtype
	end

	if SERVER then
		self:SetHoldType(self.HoldType)
	end
end

function SWEP:CalcViewModelView(cv_viewmodel, cv_old_eyepos, cv_old_eyeang, cv_eyepos, cv_eyeang)
	if self.PunchingMode == false then
		return cv_eyepos - (cv_eyeang:Forward() * 200), cv_eyeang
	end
end

function SWEP:CreateHandActions()
	if self.Contents == nil then
		self.Contents = table.Copy(BR2_GetHandActions())
	end
end

function SWEP:Deploy()
	if self.BaseClass.Deploy then
		self.BaseClass.Deploy(self)
	end

	if CLIENT then
		self:CreateHandActions()
	end
end

function SWEP:CheckActions()
	self:CreateHandActions()

	-- remove old temporary actions
	local toRemove = {}

	for k,v in pairs(self.Contents) do
		if v.temporary then
			table.ForceInsert(toRemove, v)
		end
	end

	for k,v in pairs(toRemove) do
		table.RemoveByValue(self.Contents, v)
	end

	-- Add temporary actions
	hook.Run("BR2_OnHandsAddActions", self)

	for k,v in pairs(self.Contents) do
		-- add sort index
		if v.sort == nil then
			if BR2_Hands_Sort[k] then
				v.sort = BR2_Hands_Sort[k]
			else
				error("No sort index with hand action " .. k .. "")
			end
		end

		-- check if we can do these actions
		if v.can_do == true then
			v.enabled = true

		elseif isfunction(v.can_do) then
			v.enabled = v.can_do(self)
		
		elseif isfunction(v.cl_can_do) then
			v.enabled = v.cl_can_do(self)
		
		else
			error("Invalid can_do with hand action " .. k .. "")
		end
	end

	-- sort them
	local sorted = {}
	for k, v in pairs(self.Contents) do
		table.insert(sorted, v)
	end

	table.sort(sorted, function(a, b)
		return a.sort < b.sort
	end)

	self.Contents = sorted
end

local open_frame_lock_for = 0
function SWEP:CreateFrame()
	if open_frame_lock_for > CurTime() then return end

	if IsValid(WeaponFrame) then
		WeaponFrame:Remove()
	end

	open_frame_lock_for = CurTime() + 0.1
	
	self:CheckActions()

	/* WORK IN PROGRESS
	if IsValid(lastseen_player) and lastseen_player:GetClass() == "prop_ragdoll" then
		if lastseen_player.Has035Attached then
			self.Contents["remove_body_attachment_"..i..""] = {
				id = table.Count(self.Contents) + 1,
				enabled = true,
				delete_after = 1,
				name = "Remove the mask",
				desc = "Remove the mask from the face",
				background_color = Color(0,150,150),
				cl_effect = function(self)
					chat.AddText(Color(255,255,255,255), "Trying to remove the mask...")
					net.Start("br_remove_body_attachment")
						net.WriteEntity(lastseen_player)
						net.WriteString("035mask")
					net.SendToServer()
				end,
				cl_after = function()
					WeaponFrame:Remove()
				end
			}
		end
	end
	*/

	WeaponFrame = vgui.Create("DFrame")
	WeaponFrame:SetSize(360, 400)
	WeaponFrame:SetTitle("")
	WeaponFrame:ShowCloseButton(true)
	WeaponFrame:SetKeyboardInputEnabled(false)
	WeaponFrame.Paint = function(self, w, h)
		if IsValid(self) == false then
			return
		end
		--draw.RoundedBox(0, 0, 0, w, h, Color(150, 150, 150, 50))
		draw.Text({
			text = "ACTIONS",
			pos = {4, 4},
			xalign = TEXT_ALIGN_LEFT,
			yalign = TEXT_ALIGN_TOP,
			font = "BR_HOLSTER_TITLE",
			color = Color(255,255,255,255),
		})
		--if input.IsKeyDown(KEY_ESCAPE) or !LocalPlayer():KeyDown(IN_ATTACK2) then
		if input.IsKeyDown(KEY_ESCAPE) then
			self:KillFocus()
			self:Remove()
			gui.HideGameUI()
			return
		end
	end

	local last_y = 24
	for k,item in pairs(self.Contents) do
		if item.enabled == true then
			local panel = vgui.Create("DPanel", WeaponFrame)
			panel:SetSize(360 - 8, 50 - 8)
			panel:SetPos(4, 4 + last_y)
			panel.clr = item.background_color or BR2_Hands_Actions_Colors.default
			panel.clr.a = 100
			panel.Paint = function(self, w, h)
				draw.RoundedBox(0, 0, 0, w, h, panel.clr)

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
			panel2:SetPos(360 - 50 - 0, 0)
			panel2:SetSize(50 - 8, 50 - 8)
			panel2:SetText("")
			panel2.Paint = function(self, w, h)
				draw.RoundedBox(0, 0, 0, w, h, Color(255, 255, 255, 50))

				draw.Text({
					text = "DO",
					pos = {w / 2, h / 2},
					xalign = TEXT_ALIGN_CENTER,
					yalign = TEXT_ALIGN_CENTER,
					font = "BR_HOLSTER_CONTENT_USE",
					color = Color(255,255,255,255),
				})
				--if self:IsHovered() and LocalPlayer():KeyDown(IN_ATTACK) then
				--	panel2.DoClick()
				--end
			end

			panel2.DoClick = function()
				if isfunction(item.cl_effect) then
					item.cl_effect(self)
				end

				if isfunction(item.sv_effect) then
					net.Start("br_hands_action")
						net.WriteString(item.className)
					net.SendToServer()
				end

				if isfunction(item.cl_after) then
					item.cl_after(self)
				end
			end
			last_y = last_y + (50 - 8) + 6
		end
	end

	WeaponFrame:SetSize(360, last_y + 4)
	WeaponFrame:Center()
	WeaponFrame:MakePopup()
end

SWEP.AllowToPush = {
	"prop_physics",
	"prop_ragdoll",
	"player",
}

SWEP.NextPush = 0
function SWEP:Push()
	local pl = self.Owner
	
	if pl:Alive() and pl:IsSpectator() == false and !pl:IsFrozen() and self.NextPush < CurTime() then
		local tr = util.TraceLine({
			start = pl:EyePos(),
			endpos = pl:EyePos() + (pl:EyeAngles():Forward() * 100),
			filter = pl
		})
		
		local ent = tr.Entity
		if tr.Hit and !tr.HitWorld and IsValid(ent) and table.HasValue(self.AllowToPush, ent:GetClass()) then
			local ang = Angle(0, pl:EyeAngles().yaw, 0)

			if ent:IsPlayer() then
				local vel = ent:GetVelocity()
				ent:SetVelocity(vel + (ang:Forward() * 500))
				self.NextPush = CurTime() + 2

			elseif ent:GetClass() == "prop_ragdoll" then
				local phys = ent:GetPhysicsObject()
				if IsValid(phys) then
					phys:ApplyForceCenter(ang:Forward() * 600)
				end
				self.NextPush = CurTime() + 0.01

			else
				local phys = ent:GetPhysicsObject()
				if IsValid(phys) then
					phys:ApplyForceCenter(ang:Forward() * 500)
				end

				self.NextPush = CurTime() + 0.01
			end

			ent:EmitSound("breach2/player/shove_0"..math.random(1,5)..".wav")
		end
	end
end

SWEP.InspectPos = Vector(0, 0, 0)
SWEP.InspectAng = Vector(0, 0, 0)

SWEP.Primary.Directional = true
SWEP.Primary.Attacks = {
	{
		["act"] = ACT_VM_SWINGHARD, -- Animation; ACT_VM_THINGY, ideally something unique per-sequence
		["len"] = 50, -- Trace distance
		["dir"] = Vector(15, 0, 0), -- Trace arc cast
		["dmg"] = 14, --Damage
		["dmgtype"] = DMG_CRUSH, --DMG_SLASH,DMG_CRUSH, etc.
		["delay"] = 0.3, --Delay
		["spr"] = false, --Allow attack while sprinting?
		["snd"] = "", -- Sound ID
		["snd_delay"] = 0.22,
		["viewpunch"] = Angle(5, 10, 0), --viewpunch angle
		["end"] = 0.8, --time before next attack
		["hull"] = 10, --Hullsize
		["direction"] = "L", --Swing dir,
		["hitflesh"] = Sound("Weapon_Crowbar.Melee_Hit"),
		["hitworld"] = Sound("Weapon_Crowbar.Melee_Hit"),
		["combotime"] = 0
	},
	{
		["act"] = ACT_VM_SWINGHARD, -- Animation; ACT_VM_THINGY, ideally something unique per-sequence
		["len"] = 50, -- Trace distance
		["dir"] = Vector(-15, 0, 0), -- Trace arc cast
		["dmg"] = 14, --Damage
		["dmgtype"] = DMG_CRUSH, --DMG_SLASH,DMG_CRUSH, etc.
		["delay"] = 0.3, --Delay
		["spr"] = false, --Allow attack while sprinting?
		["snd"] = "", -- Sound ID
		["snd_delay"] = 0.22,
		["viewpunch"] = Angle(5, -10, 0), --viewpunch angle
		["end"] = 0.8, --time before next attack
		["hull"] = 10, --Hullsize
		["direction"] = "R", --Swing dir,
		["hitflesh"] = Sound("Weapon_Crowbar.Melee_Hit"),
		["hitworld"] = Sound("Weapon_Crowbar.Melee_Hit"),
		["combotime"] = 0
	}
}

SWEP.Offset = {
	Pos = {
		Up = 0,
		Right = 0,
		Forward = 0
	},
	Ang = {
		Up = 0,
		Right = 0,
		Forward = 0
	},
	Scale = 1
}

local last_attack = 1

local att = {}
local lvec, ply, targ
lvec = Vector()
function SWEP:PunchAttack()
	if not self:VMIV() then return end
	if CurTime() <= self:GetNextPrimaryFire() then return end
	if not TFA.Enum.ReadyStatus[self:GetStatus()] then return end
	table.Empty(att)
	local founddir = false
	
	if last_attack == 1 then last_attack = 2 else last_attack = 1 end
	local use_attack = last_attack

	local our_anim = "Attack_Quick"
	if use_attack == 2 then our_anim = "Attack_Quick2" end
	if IsFirstTimePredicted() or SERVER then self:SendViewModelSeq(our_anim) end
	--self:SendViewModelSeq(our_anim)
	
	if self.Primary.Directional then
		ply = self:GetOwner()
		lvec.x = 0
		lvec.y = 0

		if ply:KeyDown(IN_MOVERIGHT) then lvec.y = lvec.y - 1 end
		if ply:KeyDown(IN_MOVELEFT) then lvec.y = lvec.y + 1 end
		if ply:KeyDown(IN_FORWARD) or ply:KeyDown(IN_JUMP) then lvec.x = lvec.x + 1 end
		if ply:KeyDown(IN_BACK) or ply:KeyDown(IN_DUCK) then lvec.x = lvec.x - 1 end
		
		lvec.z = 0
		if lvec.y > 0.3 then targ = "L"
		elseif lvec.y < -0.3 then targ = "R"
		elseif lvec.x > 0.5 then targ = "F"
		elseif lvec.x < -0.1 then targ = "B"
		else targ = ""
		end

		for k, v in pairs(self.Primary.Attacks) do
			if (not self:GetSprinting() or v.spr) and v.direction and string.find(v.direction, targ) then
				if string.find(v.direction, targ) then
					founddir = true
				end
				table.insert(att, #att + 1, k)
			end
		end
	end

	if not self.Primary.Directional or #att <= 0 or not founddir then
		for k, v in pairs(self.Primary.Attacks) do
			if (not self:GetSprinting() or v.spr) and v.dmg then
				table.insert(att, #att + 1, k)
			end
		end
	end
	
	if #att <= 0 then return end
	attack = self.Primary.Attacks[use_attack]
	ind = att[use_attack]
	self:PlaySwing(attack.act)
	
	self:SetVP(true)
	self:SetVPPitch(attack.viewpunch.p)
	self:SetVPYaw(attack.viewpunch.y)
	self:SetVPRoll(attack.viewpunch.r)
	self:SetVPTime(CurTime() + attack.snd_delay / self:GetAnimationRate(attack.act))
	self:GetOwner():ViewPunch(-Angle(attack.viewpunch.p / 2, attack.viewpunch.y / 2, attack.viewpunch.r / 2))

	self.up_hat = false
	self:SetStatus(TFA.Enum.STATUS_SHOOTING)
	self:SetMelAttackID(use_attack)
	self:SetStatusEnd(CurTime() + attack.delay / self:GetAnimationRate(attack.act))
	self:SetNextPrimaryFire(CurTime() + attack["end"] / self:GetAnimationRate(attack.act))
	self:GetOwner():SetAnimation(PLAYER_ATTACK1)
	self:SetComboCount(self:GetComboCount() + 1)
end

function SWEP:SmackEffect(trace, dmg)
	local vSrc = trace.StartPos
	local bFirstTimePredicted = IsFirstTimePredicted()
	local bHitWater = bit.band(util.PointContents(vSrc), MASK_WATER) ~= 0
	local bEndNotWater = bit.band(util.PointContents(trace.HitPos), MASK_WATER) == 0
	
	local trSplash = bHitWater and bEndNotWater and util.TraceLine({
		start = trace.HitPos,
		endpos = vSrc,
		mask = MASK_WATER
	}) or not (bHitWater or bEndNotWater) and util.TraceLine({
		start = vSrc,
		endpos = trace.HitPos,
		mask = MASK_WATER
	})
	
	if (trSplash and bFirstTimePredicted) then
		local data = EffectData()
		data:SetOrigin(trSplash.HitPos)
		data:SetScale(1)
		if (bit.band(util.PointContents(trSplash.HitPos), CONTENTS_SLIME) ~= 0) then
			data:SetFlags(1)
		end
		util.Effect("watersplash", data)
	end
	
	local dam, force, dt = dmg:GetBaseDamage(), dmg:GetDamageForce(), dmg:GetDamageType()
	dmg:SetDamage(dam)
	dmg:SetDamageForce(force)
end

SWEP.AttackDelay = 0.8
SWEP.NextAttack = 0

SWEP.fixPlaybackRate = 0
function SWEP:Think()
	if SERVER and self.Owner:KeyDown(IN_ATTACK) then
		if self.PushingMode then
			self:Push()
		end
	end

	if self:GetHoldType() != self.HoldType then
		self:SetHoldType(self.HoldType)
	end

	if self:IsSCP049() and self.PushingMode then
		self.PushingMode = false
		self.PunchingMode = false
		self.SCP049Mode = true
		self.HoldType = "pistol"
		if SERVER then
			self:SetHoldType(self.HoldType)
		end
	end

	if self.fixPlaybackRate == 0 then
		self:GetOwner():GetViewModel():SetPlaybackRate(1)
		self.fixPlaybackRate = 1
	end

	if self.PickpocketingSomeonesNotepad and progress_bar_status > 0 and (!IsValid(targeted_player) or targeted_player:GetPos():Distance(LocalPlayer():GetPos()) > 210) then
		EndProgressBar()
		chat.AddText(color_white, "They are too far away to check their notepad...")
	end
end

SWEP.Primary.Automatic = true
function SWEP:PrimaryAttack()
	if self.PunchingMode == true then
		self:PunchAttack()
		return
	end

	if CLIENT or self.SCP049Mode == false or self.NextAttack > CurTime() then return end
	self.NextAttack = CurTime() + self.AttackDelay
	local hullsize = 4
	local tr = util.TraceHull({
		start = self.Owner:GetShootPos(),
		endpos = self.Owner:GetShootPos() + (self.Owner:GetAimVector() * 60),
		filter = self.Owner,
		mins = Vector(-hullsize, -hullsize, -hullsize),
		maxs = Vector(hullsize, hullsize, hullsize),
		mask = MASK_SHOT_HULL
	})

	local ent = tr.Entity
	if IsValid(ent) and ent:IsPlayer() and ent:Alive() and !ent:IsSpectator() and ent.br_team != TEAM_SCP then
		ent.lastPlayerInfo = ent:CopyPlayerInfo(self.Owner)
		ent:TakeDamage(60, self.Owner, self.Owner)
		--ent:Kill()
		self.Owner:EmitSound("breach2/scp/966/damage_966.ogg")
		return
	end

	self.Owner:EmitSound("npc/zombie/claw_miss1.wav")
end

function SWEP:SecondaryAttack()
	if CLIENT and IsFirstTimePredicted() then
		self:CreateFrame()
	end
end

function SWEP:DrawHUD()
	if !BR2_ShouldDrawWeaponInfo() then return end

	local text = "Secondary attack opens action menu, Reload toggles pushing mode"
	
	if self:IsSCP049() then
		text = "Left click to attack, to cure, first kill, then check pulse, and cure"
	end

	draw.Text({
		text = text,
		pos = { ScrW() / 2, ScrH() - 6},
		font = "BR2_ItemFont",
		color = Color(255,255,255,15),
		xalign = TEXT_ALIGN_CENTER,
		yalign = TEXT_ALIGN_BOTTOM,
	})
end
