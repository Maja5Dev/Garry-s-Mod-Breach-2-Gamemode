AddCSLuaFile()

if CLIENT then
	SWEP.BounceWeaponIcon = false
end

SWEP.Author			= "Maya"
SWEP.Contact		= "Steam"

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel 		= "models/weapons/cstrike/c_pist_usp.mdl"
SWEP.WorldModel		= "models/weapons/w_pist_usp.mdl"
SWEP.WorldModel		= ""
SWEP.PrintName		= "Spawn Placer"
SWEP.Slot			= 5
SWEP.SlotPos		= 5
SWEP.DrawAmmo		= false
SWEP.DrawCrosshair	= true
SWEP.HoldType		= "revolver"
SWEP.Spawnable		= false
SWEP.AdminSpawnable	= false
SWEP.Base			= "weapon_base"
SWEP.UseHands		= true

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Ammo			=  "none"
SWEP.Primary.Automatic		= false

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Ammo			=  "none"
SWEP.Secondary.Automatic	=  false

SWEP.Spawns = {}
SWEP.Mode = 1
SWEP.NextChange = 0
SWEP.StartingPos = Vector(0,0,0)
SWEP.Power = 5

SWEP.Modes = {
	{
		reload = function()
			if CLIENT then
				chat.AddText("Mode 1: Adding Spawns")
				print("Mode 1: Adding Spawns")
			end
		end,
		primary = function(this)
			if CLIENT then
				chat.AddText(tostring(this.StartingPos))
				print(tostring(this.StartingPos))
			end
			if SERVER then
				local spawn = ents.Create("prop_physics")
				if IsValid(spawn) then
					spawn:SetModel("models/props_borealis/bluebarrel001.mdl")
					spawn:SetPos(Entity(1):GetAllEyeTrace().HitPos + this.StartingPos)
					spawn:SetNWBool("SPAWNPLACED", true)
					table.ForceInsert(this.Spawns, spawn)
					spawn:Spawn()
					
					local phys = spawn:GetPhysicsObject()
					if phys and phys:IsValid() then 
						phys:EnableMotion(false) 
					end
				end
			end
		end,
		secondary = function(this)
			this.StartingPos.z = this.StartingPos.z - 5
			if this.StartingPos.z < -30 then
				this.StartingPos.z = 30
			end
			if CLIENT then
				chat.AddText(tostring(this.StartingPos))
				print(tostring(this.StartingPos))
			end
		end,
	},
	{
		reload = function()
			if CLIENT then
				chat.AddText("Mode 2: Deleting Spawns")
				print("Mode 2: Deleting Spawns")
			end
		end,
		primary = function(this)
			if SERVER then
				local ent = this.Owner:GetAllEyeTrace().Entity
				if IsValid(ent) then
					for k,v in pairs(this.Spawns) do
						if v == ent then
							v:Remove()
						end
					end
				end
			end
		end,
		secondary = function(this)
			this.CurrentMode = 1
			this.Modes[1].reload()
		end,
	},
	{
		reload = function()
			if CLIENT then
				chat.AddText("Mode 3: Printing")
				print("Mode 3: Printing")
			end
		end,
		primary = function(this)
			if SERVER then
				print("/print/ " .. CurTime())
				for k,v in pairs(this.Spawns) do
					local pos = v:GetPos()
					print("Vector(".. pos[1] .. ", " .. pos[2] .. ", " .. pos[3] .."),")
				end
				print("|print|")
			end
		end,
		secondary = function()
			
		end,
	},
	{
		reload = function()
			if CLIENT then
				chat.AddText("Mode 4: Moving X")
				print("Mode 4: Moving X")
			end
		end,
		primary = function(this)
			this.StartingPos.x = this.StartingPos.x + this.Power
			if CLIENT then
				chat.AddText(tostring(this.StartingPos))
				print(tostring(this.StartingPos))
			end
		end,
		secondary = function(this)
			this.StartingPos.x = this.StartingPos.x - this.Power
			if CLIENT then
				chat.AddText(tostring(this.StartingPos))
				print(tostring(this.StartingPos))
			end
		end,
	},
	{
		reload = function()
			if CLIENT then
				chat.AddText("Mode 5: Moving Y")
				print("Mode 5: Moving Y")
			end
		end,
		primary = function(this)
			this.StartingPos.y = this.StartingPos.y + this.Power
			if CLIENT then
				chat.AddText(tostring(this.StartingPos))
				print(tostring(this.StartingPos))
			end
		end,
		secondary = function(this)
			this.StartingPos.y = this.StartingPos.y - this.Power
			if CLIENT then
				chat.AddText(tostring(this.StartingPos))
				print(tostring(this.StartingPos))
			end
		end,
	},
	{
		reload = function()
			if CLIENT then
				chat.AddText("Mode 6: Moving Z")
				print("Mode 6: Moving Z")
			end
		end,
		primary = function(this)
			this.StartingPos.z = this.StartingPos.z + this.Power
			if CLIENT then
				chat.AddText(tostring(this.StartingPos))
				print(tostring(this.StartingPos))
			end
		end,
		secondary = function(this)
			this.StartingPos.z = this.StartingPos.z - this.Power
			if CLIENT then
				chat.AddText(tostring(this.StartingPos))
				print(tostring(this.StartingPos))
			end
		end,
	},
	{
		reload = function()
			if CLIENT then
				chat.AddText("Mode 7: Clear all")
				print("Mode 7: Clear all")
			end
		end,
		primary = function(this)
			for k,v in pairs(this.Spawns) do
				if IsValid(v) then
					v:Remove()
				end
			end
		end,
		secondary = function(this)
			this.CurrentMode = 1
			this.Modes[1].reload()
		end,
	}
}

function SWEP:CheckSpawns()
	for k,v in pairs(self.Spawns) do
		if IsValid(v) == false then
			table.RemoveByValue(self.Spawns, v)
			print("deleted an invalid spawn")
		end
	end
end

SWEP.NextChange = 0
SWEP.CurrentMode = 1
function SWEP:Reload()
	--if not IsFirstTimePredicted() then return end
	if self.NextChange > CurTime() then return end
	self.NextChange = CurTime() + 0.25
	
	self:CheckSpawns()
	
	if self.Modes[self.CurrentMode + 1] == nil then
		self.CurrentMode = 1
	else
		self.CurrentMode = self.CurrentMode + 1
	end
	self.Modes[self.CurrentMode].reload(self)
	print(self.CurrentMode)
end

function SWEP:Deploy()
end

function SWEP:Initialize()
	self:SetHoldType(self.HoldType)
end

function SWEP:DrawHUD()
	local tr = self.Owner:GetAllEyeTrace()
	if CLIENT then

		for k,v in pairs(ents.FindByClass("prop_physics")) do
			if v:GetNWBool("SPAWNPLACED") == true then
				local posss = v:GetPos():ToScreen()
				draw.Text({
					text = "SPAWN",
					pos = {posss.x, posss.y},
					xalign = TEXT_ALIGN_CENTER,
					yalign = TEXT_ALIGN_BOTTOM,
					font = "BR_SPECTATOR_FONT",
					color = Color(220,220,220,150),
				})
			end
		end

		cam.Start3D()
			render.SetColorMaterial()

			local tr2 = util.TraceLine({
				start = LocalPlayer():GetPos(),
				endpos = LocalPlayer():GetPos() + Angle(90,0,0):Forward() * 10000
			})
			render.DrawSphere(tr2.HitPos, 1, 30, 30, Color(255, 0, 255, 100))
			
			render.DrawSphere(tr.HitPos, 1, 30, 30, Color(255, 255, 255, 100))
			if self.FirstPos != nil then
				render.DrawSphere(self.FirstPos, 1, 30, 30, Color(0, 255, 0, 255))
				render.DrawSphere(self.FirstPos, 10, 30, 30, Color(0, 255, 0, 10))
			end
			if self.SecondPos != nil then
				render.DrawSphere(self.SecondPos, 1, 30, 30, Color(0, 0, 255, 255))
				render.DrawSphere(self.SecondPos, 10, 30, 30, Color(0, 0, 255, 10))
			end
			if self.FirstPos != nil and self.SecondPos != nil then
				--local wpos = (self.SecondPos - self.FirstPos)
				--local len = (self.SecondPos - self.FirstPos):Length()
				--local trace_c = util.TraceLine({
				--	start = self.FirstPos,
				--	endpos = self.FirstPos + (self.SecondPos - self.FirstPos):Angle():Forward() * (len / 2),
				--})
				render.DrawBox(Vector(0,0,0), Angle(0,0,0), self.FirstPos, self.SecondPos, Color(200,0,0, 10), true)
				--self.Owner:SetEyeAngles(wpos)
				--print(wpos)
				--render.DrawSphere(trace_c.HitPos, 15, 30, 30, Color(255, 0, 0, 15))
				--render.DrawBox(self.FirstPos, Angle(0,0,0), Vector(0,0,0), Vector(10,100,10), Color(255,0,0,100), false)
				--render.DrawLine(Vector startPos, Vector endPos, table color, boolean writeZ=false)
			end
		cam.End3D()
	end
end
function SWEP:Think()
end
function SWEP:PrimaryAttack()
	if self.NextChange > CurTime() then return end
	self.NextChange = CurTime() + 0.25
	
	self:CheckSpawns()
	self.Modes[self.CurrentMode].primary(self)
end
function SWEP:SecondaryAttack()
	if not IsFirstTimePredicted() then return end
	
	self:CheckSpawns()
	self.Modes[self.CurrentMode].secondary(self)
end


