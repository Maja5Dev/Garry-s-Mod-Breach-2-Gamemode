
function isValidPlayerCorpse(ply, ent)
	if !IsValid(ent) or ent:GetClass() != "prop_ragdoll" or !istable(ent.Info) or ent:GetPos():Distance(ply:GetPos()) > 120 then
		return false, false
	end

	return true, IsValid(ent.Info.Victim)
				and ent.Info.Victim:Alive()
				and ent.Info.Victim:IsSpectator() == false
				and ent.RagdollHealth > 10
				and ent.Info.charid == ent.Info.Victim:GetNWInt("BR_CharID", -1)
end

local function end_reviving_pl(ply)
	ply.startedReviving = nil
	ply.lastPulseChecked = NULL
	ply:ResetHull()
end

net.Receive("br_end_reviving", function(len, ply)
	if ply:Alive() == false or ply:IsSpectator() or istable(ply.startedReviving) == false or ply.startedCheckingPulse != nil then
		return
	end

	local ent = ply.startedReviving[1]
	local isPlayerValid, isPlayerAlive = isValidPlayerCorpse(ply, ent)

	if ply.br_role == ROLE_SCP_049 then
		if isPlayerValid
		and IsValid(ent.Info.Victim)
		and (!ent.Info.Victim:Alive() or ent.Info.Victim:IsSpectator())
		and !(ent:GetPos():Distance(ply:GetPos()) > 150)
		and IsValid(ply.lastPulseChecked)
		and ply.lastPulseChecked == ent
		and ((ply.startedReviving[2] + 6.1) > CurTime())
		then
			ent.Info.Victim:UnDownPlayerAsZombie(ply)
			end_reviving_pl(ply)
		end

	elseif isPlayerValid then
		if IsValid(ply.lastPulseChecked) and ply.lastPulseChecked == ent and ((ply.startedReviving[2] + 6.1) > CurTime()) then
			if isPlayerAlive and ent.Info.Victim.Body != nil then
				ent.Info.Victim:UnDownPlayer(ply)
			end

			net.Start("br_end_reviving")
				net.WriteBool(isPlayerAlive)
			net.Send(ply)

			end_reviving_pl(ply)
		end
	end
end)

local function start_reviving_pl(ply, ent)
	ply.startedReviving = {ent, CurTime()}

	ply:SetHull(Vector(-16, -16, 0), Vector(16, 16, 24))
	ply:SetHullDuck(Vector(-16, -16, 0), Vector(16, 16, 24))
	ply:DoCustomAnimEvent(PLAYERANIMEVENT_ATTACK_GRENADE, 982)
	ply:SetNWBool("br_is_reviving", true)
end

net.Receive("br_start_reviving", function(len, ply)
	if !ply:Alive() or ply:IsSpectator() or ply.startedCheckingPulse != nil then return end

	local tr = ply:GetAllEyeTrace()
	local ent = tr.Entity

	if IsValid(ply.lastPulseChecked) and ply.lastPulseChecked == ent and ent.IsStartingCorpse != true then
		if ent:GetClass() == "prop_ragdoll"
		and istable(ent.Info)
		and IsValid(ent.Info.Victim)
		and ent.Info.Victim:Alive()
		and ent.Info.charid == ent.Info.Victim:GetNWInt("BR_CharID", -1)
		and string.find(ent.Info.br_role, "SCP") == nil
		then
			if ply.br_role == ROLE_SCP_049 then
				start_reviving_pl(ply, ent)

			elseif isValidPlayerCorpse(ply, ent) and !ent.Info.Victim:IsSpectator() then
				start_reviving_pl(ply, ent)
			end

			return
		end
	end
end)

net.Receive("br_end_checking_pulse", function(len, ply)
	if ply:Alive() == false or ply:IsSpectator() or istable(ply.startedCheckingPulse) == false or ply.startedReviving != nil then return end
	
	local ent = ply.startedCheckingPulse[1]
	local isPlayerValid, isPlayerAlive = isValidPlayerCorpse(ply, ent)

	if ent.IsStartingCorpse == true or !isPlayerValid then
		net.Start("br_end_checking_pulse")
			net.WriteBool(false) -- if the player is alive
			net.WriteBool(false) -- if the player corpse is valid
		net.Send(ply)

		ply.startedCheckingPulse = nil

	elseif isPlayerValid then
		if (ent:GetPos():Distance(ply:GetPos()) > 150) or (ply.startedCheckingPulse[2] + 4.1) > CurTime() then
			net.Start("br_end_checking_pulse")
				net.WriteBool(isPlayerAlive)
				net.WriteBool(true)
			net.Send(ply)
			
			ply.startedCheckingPulse = nil
		end
	end
end)

net.Receive("br_start_checking_pulse", function(len, ply)
	if !ply:Alive() or ply:IsSpectator() or ply.startedReviving != nil then return end

	local tr = ply:GetAllEyeTrace()
	local ent = tr.Entity

	if ent:GetPos():Distance(ply:GetPos()) < 150 then
		ply.startedCheckingPulse = {ent, CurTime()}
		ply.lastPulseChecked = ent
	end
end)

net.Receive("br_check_pulse", function(len, ply)
	if ply:Alive() == false or ply:IsSpectator() then return end
	
	local tr = ply:GetAllEyeTrace()
	local ent = tr.Entity

	if IsValid(ent) and ent:GetClass() == "prop_ragdoll" and ent.cptBaseRagdoll == nil and ent.drgBaseRagdoll == nil then
		local dis = ent:GetPos():Distance(ply:GetPos())

		if dis < 120 then
			local is_alive = false

			if istable(ent.Info) and IsValid(ent.Info.Victim) and ent.Info.Victim:Alive()
				and ent.Info.Victim:IsSpectator() == false and ent.RagdollHealth > 10
			then
				is_alive = true
			end
			
			net.Start("br_check_pulse")
				net.WriteBool(is_alive)
			net.Send(ply)

			ply.lastPulseChecked = ent
		end
	end
end)

print("[Breach2] server/networking/net_health.lua loaded!")

