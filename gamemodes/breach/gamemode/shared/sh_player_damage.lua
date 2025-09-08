
BR2_BODY_GROUPS = {
	ignore = {
		"forward",
		"ulna",
		"tie",
		"attachment",
	},
	head = {
		"head",
		"neck",
	},
	body = {
		"spine",
		"clavicle",
		"trapezius",
		"pelvis",
	},
	l_arms = {
		"l_upperarm",
		"l_forearm",
		"l_hand",
		"l_shoulder",
		"l_bicep",
		"l_wrist",
		"l_finger",
		"l_elbow",
	},
	r_arms = {
		"r_upperarm",
		"r_forearm",
		"r_hand",
		"r_shoulder",
		"r_bicep",
		"r_wrist",
		"r_finger",
		"r_elbow",
	},
	r_legs = {
		"r_foot",
		"r_toe",
		"r_leg",
		"r_calf",
	},
	l_legs = {
		"l_foot",
		"l_toe",
		"l_leg",
		"l_calf",
	}
}

function GM:ScalePlayerDamage(victim, hitgroup, dmginfo)
	local attacker = dmginfo:GetAttacker()
	local inflictor = dmginfo:GetInflictor()

	if victim:GetNoDraw() == true then
		dmginfo:ScaleDamage(0)
		return true
	end

	if SERVER then
		if attacker:IsPlayer() and attacker:Alive() and attacker:IsSpectator() == false then
			local same_team = victim.br_team == attacker.br_team
			if (round_system.current_scenario.friendly_fire_enabled == false and same_team)
			or (victim.br_team == TEAM_MTF and attacker.br_team == TEAM_MTF)
			or (victim.br_role == "CI Soldier" and attacker.br_role == "CI Soldier")
			or (game_state == GAMESTATE_PREPARING) then
				return true
			end
		end
	end

	local dmg_mul = 1

	-- ALTERNATE HITGROUP DETECTION - NO NEED TO HAVE MODELS WITH HITGROUPS
	if SERVER and hitgroup == HITGROUP_GENERIC then
		local hit_pos = dmginfo:GetDamagePosition()
		local ply_pos = victim:GetPos()
		local max_ply_z = victim:OBBMaxs().z
		if victim:KeyDown(IN_DUCK) then
			max_ply_z = max_ply_z * 1.2
		end

		local wep = victim:GetActiveWeapon()
		if IsValid(wep) then
			local hold_type = wep:GetHoldType()
			if hold_type == "smg" or hold_type == "ar2" or hold_type == "grenade"
			or hold_type == "shotgun" or hold_type == "rpg" or hold_type == "melee"
			or hold_type == "slam" or hold_type == "fist" or hold_type == "melee2" or hold_type == "knife" then
				max_ply_z = max_ply_z * 0.9
			end
		end
		
		local hit_level =  math.Round((hit_pos - ply_pos).z / max_ply_z, 2)
		local closest_bone = nil
		local hitbox = "body"
		
		for i = 0, victim:GetBoneCount() - 1 do
			local bone_name = victim:GetBoneName(i)
			local bone_pos ,bone_ang = victim:GetBonePosition(i)
			local dist = hit_pos:Distance(bone_pos)
			local use_bone = true
			
			for k,v in pairs(BR2_BODY_GROUPS["ignore"]) do
				if string.find(bone_name:lower(), v) then
					use_bone = false
				end
			end
			if use_bone == true and (closest_bone == nil or dist < closest_bone[3]) then
				closest_bone = {i, bone_name, dist}
			end
		end
		
		for k1,v1 in pairs(BR2_BODY_GROUPS) do
			for k,v in pairs(v1) do
				if string.find(closest_bone[2]:lower(), v) then
					hitbox = k1
				end
			end
		end
		if hitbox == "head" and hit_level < 0.88 then hitbox = "body" end
		
		if hitbox == "head" then
			hitgroup = HITGROUP_HEAD
		elseif hitbox == "l_arms" then
			hitgroup = HITGROUP_LEFTARM
		elseif hitbox == "r_arms" then
			hitgroup = HITGROUP_RIGHTARM
		elseif hitbox == "l_legs" then
			hitgroup = HITGROUP_LEFTLEG
		elseif hitbox == "r_legs" then
			hitgroup = HITGROUP_RIGHTLEG
		else
			hitgroup = HITGROUP_GENERIC
		end
		
		--print("hit_level: "..hit_level)
		--print("closest_bone", closest_bone[1], closest_bone[2], closest_bone[3])
	else
		if hitgroup == HITGROUP_CHEST or hitgroup == HITGROUP_STOMACH or hitgroup == HITGROUP_GEAR then
			hitgroup = HITGROUP_GENERIC
		end
	end
	
	--print("final hitgroup", hitgroup)
	
	if hitgroup == HITGROUP_HEAD then
		--dmginfo:ScaleDamage(math.random(1.5, 2.5))
		dmg_mul = dmg_mul * math.random(1.5, 2.5)
		
	elseif hitgroup == HITGROUP_LEFTARM then
		--dmginfo:ScaleDamage(math.random(0.8, 1))
		dmg_mul = dmg_mul * math.random(0.8, 1)
		
	elseif hitgroup == HITGROUP_RIGHTARM then
		--dmginfo:ScaleDamage(math.random(0.8, 1))
		dmg_mul = dmg_mul * math.random(0.8, 1)
		
	elseif hitgroup == HITGROUP_LEFTLEG then
		--dmginfo:ScaleDamage(math.random(0.8, 1))
		dmg_mul = dmg_mul * math.random(0.8, 1)
		
	elseif hitgroup == HITGROUP_RIGHTLEG then
		--dmginfo:ScaleDamage(math.random(0.8, 1))
		dmg_mul = dmg_mul * math.random(0.8, 1)
		
	--else
		--dmginfo:ScaleDamage(1)
	end
	
	if SERVER and IsValid(inflictor) and inflictor:GetClass() == "br_hands" and IsValid(attacker) and attacker:IsPlayer() and isnumber(attacker.br_sanity) then
		if attacker.br_sanity < 10 then
			dmg_mul = dmg_mul * 2.5
			attacker.br_sanity = 0
			attacker:SetHealth(math.Clamp(attacker:Health() + 6, 1, attacker:GetMaxHealth()))

		elseif attacker.br_sanity < 35 then
			dmg_mul = dmg_mul * 1.75
			attacker.br_sanity = attacker.br_sanity - 5
			attacker:SetHealth(math.Clamp(attacker:Health() + 4, 1, attacker:GetMaxHealth()))
			
		elseif attacker.br_sanity < 65 then
			dmg_mul = dmg_mul * 1.5
			attacker.br_sanity = attacker.br_sanity - 3
			attacker:SetHealth(math.Clamp(attacker:Health() + 2, 1, attacker:GetMaxHealth()))
		else
			attacker.br_sanity = attacker.br_sanity - 1
		end
	end

	local can_start_bleeding = false
	
	local outfit = victim:GetOutfit()

	if SERVER and IsValid(inflictor) and inflictor.Category == "Breach 2 Weapons" then
		dmg_mul = dmg_mul * SafeFloatConVar("br2_gun_damage")
		if outfit.bullet_damage then
			dmg_mul = dmg_mul * outfit.bullet_damage
		end
	--else
		--dmginfo:ScaleDamage(1)
	end

	if outfit.explosion_damage and dmginfo:GetDamageType() == DMG_BLAST then
		dmg_mul = dmg_mul * outfit.explosion_damage
	elseif outfit.fire_damage and dmginfo:GetDamageType() == DMG_BLAST then
		dmg_mul = dmg_mul * outfit.fire_damage
	end

	if victim.br_role == "SCP-173" then
		dmginfo:ScaleDamage(0)
		dmg_mul = 0
		dmginfo:SetDamage(0)
	elseif victim.br_team != TEAM_SCP then
		if SERVER and SafeBoolConVar("br2_down_players") and round_system.current_scenario.downing_enabled == true then
			if victim:IsDowned() == false then
				local next_health = victim:Health() - dmginfo:GetDamage()
				if next_health > 4 and next_health < 41 then
					local chances = GetBR2conVar("br2_chance_to_get_downed")
					if chances == nil then
						chances = 0
					else
						chances = math.Clamp(chances, 0, 100)
					end
					if math.random(0, 100) <= chances then
						victim:SetDowned(dmginfo)
					end
				end
			else
				dmginfo:ScaleDamage(0)
				dmg_mul = 0
				dmginfo:SetDamage(0)
			end

			can_start_bleeding = true
			if IsValid(inflictor) and inflictor.IsStunBaton == true and inflictor.StunningEnabled then
				can_start_bleeding = false
				victim:ViewPunch(Angle(math.random(-30,30), math.random(-30,30), 0))
				victim:SendLua("StunBaton_GotStunned()")
			end
			if can_start_bleeding and victim.canStartBleeding == true and round_system.current_scenario.bleeding_enabled == true and dmginfo:GetDamage() > 12 and math.random(1,5) == 4 then
				victim.br_isBleeding = true
				--print(victim:Nick() .. " started bleeding")
			end
		end
	end
	
	if SERVER and attacker:IsPlayer() then
		print(victim:Nick() .. " (" .. victim:GetNiceBrTeam() .. ") got attacked by " .. attacker:Nick() .. " (" .. attacker:GetNiceBrTeam() .. ") health: "..victim:Health() - dmginfo:GetDamage().."")
	end

	if SERVER and victim.br_team != TEAM_SCP and victim.br_usesSanity then
		local lower_sanity_by = math.Round(dmginfo:GetDamage() * 0.4)
		victim:AddSanity(-lower_sanity_by)
		--print(victim, "sanity by damage", lower_sanity_by)
	end

	if SERVER then
		if victim.br_isInfected then
			dmg_mul = dmg_mul * 1.2
			victim:AddSanity(-1)
		end
	end

	dmginfo:ScaleDamage(dmg_mul)
end

print("[Breach2] shared/sh_player_damage.lua loaded!")
