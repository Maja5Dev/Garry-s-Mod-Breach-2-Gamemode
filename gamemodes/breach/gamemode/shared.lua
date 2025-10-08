GM.Name 	= "Breach 2"
GM.Author 	= "Maya"
GM.Email 	= ""
GM.Website 	= "steamcommunity.com/profiles/76561198156389563"

DeriveGamemode("sandbox")

include("config/sh_server_specific.lua") -- enums of server-related things, top priority
include("shared/sh_enums.lua") -- just all the enums, top priority
include("config/internal/sh_enums.lua") -- after shared/sh_enums.lua
include("config/internal/sh_outfits.lua") -- contains just the table of outfits, top priority
include("shared/sh_documents.lua") -- table of documents, top priority
include("shared/sh_player_damage.lua") -- table containing missions, top priority

include("shared/sh_cvars.lua") -- used in sv_round.lua, sh_player_damage.lua, sv_player.lua, sv_sanity.lua, sv_networking.lua, sv_temperature.lua, sv_functions_organise.lua
include("config/internal/sh_cvars.lua") -- after shared/sh_cvars.lua
include("shared/sh_util.lua") -- things used in sv_round.lua, sv_sanity.lua, sv_player_meta.lua and br_hands.lua
include("shared/sh_player_meta.lua") -- low priority

function GM:Move(ply, mv)
	local wep = ply:GetActiveWeapon()
	
	if IsValid(wep) and isfunction(wep.Move) then
		return wep:Move(ply, mv)
	end

	return false
end

team.SetUp(TEAM_ALIVE, "Default", Color(255, 255, 0))

-- Compare two items
function spi_comp(item1, item2)
	--print("item1") PrintTable(item1) print("item2") PrintTable(item2)

	if item1.attributes and item1.attributes then
		if item2.attributes then
			for attrib_name, attrib_value in pairs(item2.attributes) do
				if item1.attributes[attrib_name] != attrib_value then
					return false
				end
			end
		else
			return false
		end
	end

	return (item1.class == item2.class) and (item1.name == item2.name) and (item1.type == item2.type)
end

-- Disable default footsteps
function GM:PlayerFootstep(ply, pos, foot, sound, volume, filter)
	if string.find(sound, "ladder") then
		EmitSound("player/ap_footsteps/ladder"..MathRandom(4)..".wav", ply:GetPos(), ply:EntIndex(), CHAN_AUTO, 0.2, 70)
	end
	return true
end

/*
hook.Add("StartCommand", "BR2_StartCommand", function(ply, cmd)
	--if ply:GetMoveType() != MOVETYPE_ISOMETRIC then return end
	local desired_speed = 160
	cmd:SetForwardMove(0)
	cmd:SetSideMove(0)
	--if SERVER then
		if ply == Entity(1) then
			--cmd:RemoveKey(IN_FORWARD)
			--cmd:ClearMovement()
			--cmd:ClearButtons()
			--cmd:SetForwardMove(0)
			--cmd:SetSideMove(0)
			if cmd:KeyDown(IN_SPEED) then
				desired_speed = 230
			end
			if cmd:KeyDown(IN_DUCK) then
				desired_speed = 230 * 0.5
			end
			
			local speed = desired_speed
			local next_vel = Vector(0,0,0)
			
			if cmd:KeyDown(IN_FORWARD) then
				local eye_ang = ply:EyeAngles()
				if cmd:KeyDown(IN_MOVELEFT) or cmd:KeyDown(IN_MOVERIGHT) then
					speed = speed * 0.79
				end
				local dot_vel = Angle(0, eye_ang.yaw, eye_ang.roll):Forward() * speed
				local new_vel = Vector(dot_vel.x, dot_vel.y, 0)
				next_vel = next_vel + Vector(dot_vel.x, dot_vel.y, 0)
			elseif cmd:KeyDown(IN_BACK) then
				local eye_ang = ply:EyeAngles()
				if cmd:KeyDown(IN_MOVELEFT) or cmd:KeyDown(IN_MOVERIGHT) then
					speed = speed * 0.79
				end
				local dot_vel = Angle(0, eye_ang.yaw, eye_ang.roll):Forward() * -speed
				local new_vel = Vector(dot_vel.x, dot_vel.y, 0)
				next_vel = next_vel + Vector(dot_vel.x, dot_vel.y, 0)
			end
			if cmd:KeyDown(IN_MOVELEFT) then
				local eye_ang = ply:EyeAngles()
				if cmd:KeyDown(IN_FORWARD) or cmd:KeyDown(IN_BACK) then
					speed = speed * 0.79
				end
				local dot_vel = Angle(0, eye_ang.yaw, eye_ang.roll):Right() * -speed
				local new_vel = Vector(dot_vel.x, dot_vel.y, 0)
				next_vel = next_vel + Vector(dot_vel.x, dot_vel.y, 0)
			elseif cmd:KeyDown(IN_MOVERIGHT) then
				local eye_ang = ply:EyeAngles()
				if cmd:KeyDown(IN_FORWARD) or cmd:KeyDown(IN_BACK) then
					speed = speed * 0.79
				end
				local dot_vel = Angle(0, eye_ang.yaw, eye_ang.roll):Right() * speed
				local new_vel = Vector(dot_vel.x, dot_vel.y, 0)
				next_vel = next_vel + Vector(dot_vel.x, dot_vel.y, 0)
			end
			
			ply:SetLocalVelocity(next_vel)
		end
	--end
end)
*/

/*
function GM:HandlePlayerJumping(ply, velocity)
	if ply:GetJumpPower() < 5 then return true end
	return false
end
*/

-- ANIMATION STUFF
/*
hook.Add("DoAnimationEvent", "wOS.LastStand.CallIncap", function(ply, event, data)
	if event == PLAYERANIMEVENT_ATTACK_GRENADE  then
		local seq
		if data == 981 then
			seq = ply:LookupSequence("wos_l4d_collapse_to_incap")
		elseif data == 982 then
			seq = ply:LookupSequence("wos_l4d_getup_from_pounced")
		end
		if not seq or seq < 0 then return end
		ply:AddVCDSequenceToGestureSlot(GESTURE_SLOT_VCD, seq, 0, true) 
		return ACT_INVALID
	end
end)

hook.Add("CalcMainActivity", "wOS.LastStand.IdleAnim", function(ply)
	local seq = ply:LookupSequence("wos_l4d_idle_incap_pistol")
	if ply:GetNWBool("br_is_reviving", false) then
		seq = ply:LookupSequence("wos_l4d_heal_incap_crouching")
	end
	if seq < 0 then return end
	return -1, seq
end)
*/


local EMeta = FindMetaTable("Entity")
local WMeta = FindMetaTable("Weapon")

function WMeta:PlaySequence(seq_id, idle)
	if !idle then
		self.IdlePlaying = false
	end
	
	if !(self and self:IsValid()) or !(self.Owner && self.Owner:IsValid()) then return end
	local vm = self.Owner:GetViewModel()
	
	if !(vm and vm:IsValid()) then return end
    if isstring(seq_id) then
		seq_id = vm:LookupSequence(seq_id)
	end
	
	vm:SetCycle(0)
	vm:SetPlaybackRate(1.0)
	vm:SendViewModelMatchingSequence(seq_id)
end


print("[Breach2] shared.lua loaded!")