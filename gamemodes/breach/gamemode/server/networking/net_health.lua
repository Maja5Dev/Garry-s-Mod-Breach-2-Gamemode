
function isValidPlayerCorpse(ply, ent)
	if IsValid(ent) and ent:GetClass() == "prop_ragdoll" and istable(ent.Info) then
		if ent:GetPos():Distance(ply:GetPos()) < 80 then
			if IsValid(ent.Info.Victim) and ent.Info.Victim:Alive() and ent.Info.Victim:IsSpectator() == false and ent.RagdollHealth > 10
				and ent.Info.charid == ent.Info.Victim:GetNWInt("BR_CharID", -1)
			then
				return true, true
			else
				return true, false
			end
		end
	end
	return false, false
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

	if ply.br_role == "SCP-049" then
		if !(ent:GetPos():Distance(ply:GetPos()) > 60) and IsValid(ply.lastPulseChecked) and ply.lastPulseChecked == ent and ((ply.startedReviving[2] + 8.1) > CurTime()) then
			--if isPlayerAlive then
				--ent.Info.Victim:Kill()
				--ent.Info.Victim:KillSilent()
				ent.Info.Victim:UnDownPlayerAsZombie(ply)
			--end

			/*
			net.Start("br_end_reviving")
				net.WriteBool(false)
			net.Send(ply)
			local scp_049_2 = ents.Create("npc_cpt_scientistzombie")
			if IsValid(scp_049_2) then
				scp_049_2:SetPos(ent:GetPos())
				scp_049_2:Spawn()
				--scp_049_2:SetModel(ent:GetModel())
				--scp_049_2:Activate()
				ent:Remove()
			end
			*/

			
			end_reviving_pl(ply)
		end
	elseif isPlayerValid then
		if !(ent:GetPos():Distance(ply:GetPos()) > 60) and IsValid(ply.lastPulseChecked) and ply.lastPulseChecked == ent and ((ply.startedReviving[2] + 8.1) > CurTime()) then
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
	if ply:Alive() == false or ply:IsSpectator() or ply.startedCheckingPulse != nil then return end

	local tr = ply:GetAllEyeTrace()
	local ent = tr.Entity

	if IsValid(ply.lastPulseChecked) and ply.lastPulseChecked == ent then
		if ent:GetClass() == "prop_ragdoll" and istable(ent.Info) and IsValid(ent.Info.Victim)
			and ent.Info.Victim:Alive() and !ent.Info.Victim:IsSpectator()
			and ent.Info.charid == ent.Info.Victim:GetNWInt("BR_CharID", -1)
		then
			if ply.br_role == "SCP-049" then
				start_reviving_pl(ply, ent)
				--print("started reviving")

			elseif isValidPlayerCorpse(ply, ent) then
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

	if isPlayerValid then
		if !(ent:GetPos():Distance(ply:GetPos()) > 60) and ((ply.startedCheckingPulse[2] + 4.1) > CurTime()) then
			--print("pulse_end_check_1")
			net.Start("br_end_checking_pulse")
				net.WriteBool(isPlayerAlive)
			net.Send(ply)
			ply.startedCheckingPulse = nil
		end

	elseif ent.IsStartingCorpse == true then
		--print("pulse_end_check_2")
		net.Start("br_end_checking_pulse")
			net.WriteBool(false)
		net.Send(ply)
		ply.startedCheckingPulse = nil
	end
end)

net.Receive("br_start_checking_pulse", function(len, ply)
	if ply:Alive() == false or ply:IsSpectator() or ply.startedReviving != nil then return end

	local tr = ply:GetAllEyeTrace()
	local ent = tr.Entity

	if ent:GetPos():Distance(ply:GetPos()) < 60 then
		--print("pulse_start_check_1")
		ply.startedCheckingPulse = {ent, CurTime()}
		ply.lastPulseChecked = ent
	end
end)

net.Receive("br_check_pulse", function(len, ply)
	if ply:Alive() == false or ply:IsSpectator() then return end
	
	local tr = ply:GetAllEyeTrace()
	local ent = tr.Entity
	if IsValid(ent) and ent:GetClass() == "prop_ragdoll" then
		local dis = ent:GetPos():Distance(ply:GetPos())
		if dis < 120 then
			local is_alive = false

			if istable(ent.Info) then
				if IsValid(ent.Info.Victim) and ent.Info.Victim:Alive() and ent.Info.Victim:IsSpectator() == false and ent.RagdollHealth > 10 then
					is_alive = true
				end
			end
			
			net.Start("br_check_pulse")
			net.WriteBool(is_alive)
			net.Send(ply)
			ply.lastPulseChecked = ent
		end
	end
end)

print("[Breach2] server/networking/net_health.lua loaded!")

