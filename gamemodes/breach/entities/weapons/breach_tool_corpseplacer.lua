AddCSLuaFile()

if CLIENT then
	SWEP.BounceWeaponIcon = false
end

SWEP.Author			= "Kanade"
SWEP.Contact		= "Steam"

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel 		= "models/weapons/cstrike/c_pist_usp.mdl"
SWEP.WorldModel		= "models/weapons/w_pist_usp.mdl"
SWEP.WorldModel		= ""
SWEP.PrintName		= "Corpse Placer"
SWEP.Slot			= 4
SWEP.SlotPos		= 0
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

SWEP.RagdollInfo = {}

SWEP.NextReload = 0
function SWEP:Reload()
	if CLIENT or self.NextReload > CurTime() then return end
	print("----------------------------------------------------------------------------------------------------------------------------------------/")
	print("from "..self.Owner:Nick())
	local pos = self.RagdollInfo.ragdoll_pos
	local ang = self.RagdollInfo.ragdoll_ang
	local vel = self.RagdollInfo.ragdoll_vel
	local mdl = self.RagdollInfo.ragdoll_mdl
	print("{")
	print("	items = {},")
	print('	model = "'..mdl..'",')
	print("	setup = function(rag)")
	print("		rag.br_showname = GetRandomName()")
	print('		rag.br_role = "ROLE NAME"')
	print("		rag.br_ci_agent = false")
	print("	end,")
	print("	ragdoll_pos = Vector("..pos.x..","..pos.y..","..pos.z.."),")
	print("	ragdoll_ang = Angle("..ang.pitch..","..ang.yaw..","..ang.roll.."),")
	--print("	ragdoll_vel = Vector("..vel.x..","..ang.y..","..vel.z.."),")
	print("	bones = {")
	for i,v in ipairs(self.RagdollInfo.bones) do
		pos = self.RagdollInfo.bones[i].pos
		ang = self.RagdollInfo.bones[i].ang
		vel = self.RagdollInfo.bones[i].vel
		print("		{")
		print("			pos = Vector("..pos.x..","..pos.y..","..pos.z.."),")
		print("			ang = Angle("..ang.pitch..","..ang.yaw..","..ang.roll.."),")
		--print("			vel = Vector("..vel.x..","..vel.y..","..vel.z.."),")
		
		print("		},")
	end
	print("	},")
	print("}")
	self.NextReload = CurTime() + 1
end

function SWEP:PrimaryAttack()
	if SERVER then
		local ent = self.Owner:GetAllEyeTrace().Entity
		if IsValid(ent) and ent:GetClass() == "prop_ragdoll" then
			self.RagdollInfo = {}
			self.RagdollInfo.ragdoll_pos = ent:GetPos()
			self.RagdollInfo.ragdoll_ang = ent:GetAngles()
			self.RagdollInfo.ragdoll_mdl = ent:GetModel()
			--self.RagdollInfo.ragdoll_vel = ent:GetVelocity()
			self.RagdollInfo.bones = {}
			local num = ent:GetPhysicsObjectCount() - 1
			for i=0, num do
				print(i)
				local bone = ent:GetPhysicsObjectNum(i)
				if IsValid(bone) then
					self.RagdollInfo.bones[i] = {}
					self.RagdollInfo.bones[i].pos = bone:GetPos()
					self.RagdollInfo.bones[i].ang = bone:GetAngles()
					--self.RagdollInfo.bones[i].vel = bone:GetVelocity()
				end
			end
			--print("")
			--PrintTable(self.RagdollInfo)
		end
	elseif IsFirstTimePredicted() then
		chat.AddText(color_white, "saved")
	end
end

-- lua_run Entity(1):GetActiveWeapon().RagdollInfo = MAPCONFIG.STARTING_CORPSES[2]
function SWEP:SecondaryAttack()
	--if true then return end
	if SERVER then
		local ent = self.Owner:GetAllEyeTrace().Entity
		if self.RagdollInfo and IsValid(ent) and ent:GetClass() == "prop_ragdoll" then
			--ent:Spawn()
			ent:SetModel(self.RagdollInfo.ragdoll_mdl)
			ent:SetPos(self.RagdollInfo.ragdoll_pos)
			ent:SetAngles(self.RagdollInfo.ragdoll_ang)
			ent:SetVelocity(Vector(0,0,0))
			local num = ent:GetPhysicsObjectCount() - 1
			for i=0, num do
				local bone = ent:GetPhysicsObjectNum(i)
				if IsValid(bone) and self.RagdollInfo.bones[i] then
					bone:SetPos(self.RagdollInfo.bones[i].pos)
					bone:SetAngles(self.RagdollInfo.bones[i].ang)
					bone:SetVelocity(Vector(0,0,0))
				end
			end
		end
	end
end

function SWEP:Deploy()

end

function SWEP:Initialize()

end

function SWEP:Think()

end
