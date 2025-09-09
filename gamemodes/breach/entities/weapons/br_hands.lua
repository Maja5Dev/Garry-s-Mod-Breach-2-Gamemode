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
		return (BR2_OURNOTEPAD.people and BR2_OURNOTEPAD.people[1] != nil and BR2_OURNOTEPAD.people[1].br_role == "SCP-049")
	else
		return (self.Owner.br_role == "SCP-049")
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

SWEP.Contents = {
	examine = {
		id = 1,
		enabled = true,
		name = "Examine yourself",
		desc = "Check everything you know about yourself",
		background_color = Color(125,125,125),
		cl_effect = function(self)
			local pl = LocalPlayer()
			chat.AddText(Color(255,255,255,255), "Examining...")
			if pl:Alive() == false then
				chat.AddText(Color(255, 255, 255), " - Well, you are dead... I guess")
				return
			end
			local fake_stats = false
			if math.random(1,4) == 2 and br2_our_sanity < 2 then
				fake_stats = true
			end
		--PERSONAL INFOS
			if istable(BR2_OURNOTEPAD) and istable(BR2_OURNOTEPAD.people) and table.Count(BR2_OURNOTEPAD.people) > 0 then
				local personal_info = BR2_OURNOTEPAD.people[1]
				if isstring(personal_info.br_showname) and personal_info.scp != true then
					if personal_info.br_showname == "D-9341" then
						chat.AddText(Color(255,255,255,255), " - You are D-9341, ", Color(244,65,131,255), "the chosen one")
					else
						chat.AddText(Color(255,255,255,255), " - You are ", Color(255,255,255,255), personal_info.br_showname)
					end
				end
				if isstring(personal_info.br_role) then
					chat.AddText(Color(255,255,255,255), " - You are a ", Color(255,255,255,255), personal_info.br_role)
				end
				if personal_info.br_ci_agent == true then
					chat.AddText(Color(255, 255, 255), " - You are a ", Color(255, 0, 255), "Chaos Insurgency Spy", Color(255, 255, 255), "!")
				end
			end
		--ARMOR
			if pl:Armor() > 0 then
				chat.AddText(Color(255, 255, 255), " - You are wearing some kind of armor")
			end
		--WEAPONS
			local has_wep = false
			for k,v in pairs(pl:GetWeapons()) do
				if IsValid(v) and isLethalWeapon(v) then
					has_wep = true
				end
			end
			if has_wep then
				chat.AddText(Color(255, 255, 255), " - You are carrying lethal weapons")
			end
		--LOCATION
			local our_area = pl:GetZone()
			local area_name = pl:GetSubAreaName()
			if area_name then
				chat.AddText(Color(255, 255, 255), " - " .. "Location: "..pl:GetSubAreaName())
			else
				if istable(our_area) and isstring(our_area.examine_info) then
					chat.AddText(Color(255, 255, 255), " - " .. our_area.examine_info)
				end
			end
		--TEMPERATURE ZONE
			if istable(our_area) and isnumber(our_area.zone_temp) then
				if our_area.zone_temp == ZONE_TEMP_WARM then
					chat.AddText(Color(255, 255, 255), " - You feel like it's warm here")

				elseif our_area.zone_temp == ZONE_TEMP_HOT then
					chat.AddText(Color(255, 255, 255), " - You feel like it's hot here")

				elseif our_area.zone_temp == ZONE_TEMP_COLD then
					chat.AddText(Color(255, 255, 255), " - You feel like it's cold here")

				elseif our_area.zone_temp == ZONE_TEMP_VERYCOLD then
					chat.AddText(Color(255, 255, 255), " - You feel like it's very cold here")
				end
			end
		--TEMPERATURE
			local high_temp_enabled = SafeBoolConVar("br2_temperature_high_enabled")
			if BR_OUR_TEMPERATURE < -900 then
				chat.AddText(Color(255, 0, 0), " - Your body is freezing!")

			elseif BR_OUR_TEMPERATURE < -500 then
				chat.AddText(Color(255, 100, 100), " - Your body temperature is very low")

			elseif BR_OUR_TEMPERATURE < -200 then
				chat.AddText(Color(255, 255, 255), " - Your body temperature is low")

			elseif high_temp_enabled and BR_OUR_TEMPERATURE > 900 then
				chat.AddText(Color(255, 0, 0), " - Your body temperature is very high!")

			elseif high_temp_enabled and BR_OUR_TEMPERATURE > 500 then
				chat.AddText(Color(255, 100, 100), " - Your body temperature is very high")

			elseif high_temp_enabled and BR_OUR_TEMPERATURE > 200 then
				chat.AddText(Color(255, 255, 255), " - Your body temperature is high")

			else
				chat.AddText(Color(255, 255, 255), " - Your body temperature is normal")
			end
		--OUTFIT
			local our_outfit = LocalPlayer():GetOutfit()
			if istable(our_outfit) and isstring(our_outfit.examine) then
				chat.AddText(Color(255, 255, 255), " - "..our_outfit.examine)
			end
		--HEALTH
			local t_health, c_health = NiceHealth()
			if fake_stats then
				local insane_texts = {
					"Very healthy!",
					"Healthy!",
					"Just fine!",
					"Good enough!",
					"Healthy, just a little bit tired!",
					"SCP-173 is behind you!",
					"Today was the pizza day, right?",
					"I am going to die"
				}
				chat.AddText(Color(255,255,255,255), " - Your health: ", Color(0,255,0,255), tostring(table.Random(insane_texts)))
			else
				chat.AddText(Color(255,255,255,255), " - Your health: ", c_health, t_health)
			end
		--SANITY
			local t_sanity, c_sanity = NiceSanity()
			if fake_stats then
				local insane_texts = {
					"Totally fine!",
					"Completely sane!",
					"Fully sane, as always!",
					"Who even cares about sanity?",
					"Very fine! dont worry...",
				}
				chat.AddText(Color(255,255,255,255), " - Your mental state: ", Color(0,255,0,255), tostring(table.Random(insane_texts)))
			else
				chat.AddText(Color(255,255,255,255), " - Your mental state: ", c_sanity, t_sanity)
			end
		--INFECTION
			if BR_OUR_INFECTION >= 25 then
				chat.AddText(Color(255,255,255,255), " - You feel weak")
			--elseif BR_OUR_INFECTION >= 50 then
			--	chat.AddText(Color(255,255,255,255), " - You feel like you are sick")
			--elseif BR_OUR_INFECTION >= 75 then
			--	chat.AddText(Color(255,255,255,255), " - You feel like you are sick")
			end
		--HUNGER
			if br_our_hunger < 25 then
				chat.AddText(Color(255,0,0,255), " - You are very hungry!")
			elseif br_our_hunger < 50 then
				chat.AddText(Color(255,100,0,255), " - You are hungry!")
			elseif br_our_hunger < 75 then
				chat.AddText(Color(255,255,255,255), " - You are a bit hungry")
			else
				chat.AddText(Color(255,255,255,255), " - You aren't hungry")
			end
		--THIRST
			if br_our_thirst < 25 then
				chat.AddText(Color(255,0,0,255), " - You are very thirsty!")
			elseif br_our_thirst < 50 then
				chat.AddText(Color(255,100,0,255), " - You are thirsty!")
			elseif br_our_thirst < 75 then
				chat.AddText(Color(255,255,255,255), " - You are a bit thirsty")
			else
				chat.AddText(Color(255,255,255,255), " - You aren't thirsty")
			end
		--BLEEDING
			if br2_is_bleeding == true or (fake_stats and math.random(1,2) == 2) then
				chat.AddText(Color(255,0,0,255), " - You are bleeding!")
			end
		--WATER LEVEL
			local water = pl:WaterLevel()
			if water == 1 then
				chat.AddText(Color(56,205,255), " - You are slightly submerged")
			elseif water == 2 then
				chat.AddText(Color(56,205,255), " - You are submerged")
			elseif water == 3 then
				chat.AddText(Color(56, 205,255), " - You are completely submerged")
			end
		--FIRE
			if pl:IsOnFire() then
				chat.AddText(Color(255,0,0), " - You are on fire!")
			end
		--DISSOLVING
			if pl:IsFlagSet(FL_DISSOLVING) then
				chat.AddText(Color(0,255,0), " - You are dissolving!")
			end
		end,
		cl_after = function(self)
			WeaponFrame:Remove()
		end
	},
	examine_someone = {
		id = 2,
		enabled = false,
		name = "Examine someone",
		desc = "Examine the player you last seen",
		background_color = Color(125,125,125),
		cl_effect = function(self)
			local pl = lastseen_player
			if !IsValid(pl) then return end

			chat.AddText(Color(255,255,255,255), "Examining...")

			if pl:GetClass() == "prop_ragdoll" then
				if pl.Pulse then
					if pl.Pulse == true then
						chat.AddText(Color(255,0,0,255), " - He is dead")
						local dmg_info = pl:GetNWString("ExamineDmgInfo", nil)

						if dmg_info != nil then
							chat.AddText(Color(255,0,0,255), dmg_info)
						end

						local death_time = pl:GetNWInt("DeathTime", nil)
						if death_time != nil then
							chat.AddText(Color(255,255,255,255), " - He died " .. string.ToMinutesSeconds(CurTime() - death_time) .. " minutes ago")
						end

						return
					elseif isnumber(pl.Pulse) then
						chat.AddText(Color(255,255,255,255), " - He is probably alive")
						return
					end
				end
				chat.AddText(Color(255,255,255,255), " - Looks dead but i am not sure...")
				return
			end
		--MODEL
			local our_outfit = pl:GetOutfit()
			if our_outfit != nil and our_outfit.examine_info != nil then
				chat.AddText(Color(255, 255, 255, 255), our_outfit.examine_info)
			end
		--PERSONAL INFOS
			if pl.br_showname != nil then
				if pl.br_showname == "D-9341" then
					chat.AddText(Color(255,255,255,255), " - You remember that they were the Class D-", Color(255,0,0), "9341")
				else
					chat.AddText(Color(255,255,255,255), " - You remember that their name was " .. pl.br_showname)
				end
			else
				chat.AddText(Color(255,255,255,255), " - You don't really know a lot about this person")
			end
			if pl.br_ci_agent == true then
				chat.AddText(Color(195, 55, 255), " - You rememeber that they were a Chaos Insurgency Spy!")
			end
		--ARMOR
			if pl:Armor() > 0 then
				chat.AddText(Color(56, 205,255), " - They seems to be wearing some kind of armor")
			end
		--WEAPONS
			local has_wep = false
			for k,v in pairs(pl:GetWeapons()) do
				if IsValid(v) and isLethalWeapon(v) then
					has_wep = true
				end
			end
			if has_wep then
				chat.AddText(Color(56, 205,255), " - They seem to be carrying lethal weapons")
			end
		--WATER LEVEL
			local water = pl:WaterLevel()
			if water == 1 then
				chat.AddText(Color(255,255,255), " - They are slightly submerged")
			elseif water == 2 then
				chat.AddText(Color(255,255,255), " - They are submerged")
			elseif water == 3 then
				chat.AddText(Color(255, 255,255), " - They are completely submerged")
			end
		--FIRE
			if pl:IsOnFire() then
				chat.AddText(Color(255,0,0), " - They are on fire!")
			end
		end,
		cl_after = function(self)
			WeaponFrame:Remove()
		end
	},
	special_items_menu = {
		id = 5,
		enabled = true,
		name = "Open Backpack",
		desc = "Check your backpack, drop or use items",
		background_color = Color(150,75,50),
		cl_effect = function(self)
			net.Start("br_get_special_items")
			net.SendToServer()
		end,
		cl_after = function(self)
			WeaponFrame:Remove()
		end
	},
	identify_player = {
		id = 7,
		enabled = false,
		name = "Identify",
		desc = "Identify the player you have last seen",
		background_color = Color(0,150,150),
		cl_effect = function(self)
			BR_OpenIdentifyingMenu(lastseen_player, lastseen_nick, lastseen)
		end,
		cl_after = function(self)
			WeaponFrame:Remove()
		end
	},
	loot_body = {
		id = 8,
		enabled = false,
		name = "Loot the body",
		desc = "Search the body you are looking at",
		cl_effect = function(self)
			net.Start("br_get_loot_info")
			net.SendToServer()
		end,
		cl_after = function(self)
			WeaponFrame:Remove()
		end
	},
	check_body_notepad = {
		id = 9,
		enabled = false,
		name = "Check their Notepad",
		desc = "Check the notepad found in this body",
		cl_effect = function(self)
			net.Start("br_get_body_notepad")
			net.SendToServer()
		end,
		cl_after = function(self)
			WeaponFrame:Remove()
		end
	},
	pickup_bomb = {
		id = 11,
		enabled = false,
		name = "Pickup the bomb",
		desc = "Pickup the bomb in front of you",
		background_color = Color(125,0,0),
		cl_effect = function(self)
			chat.AddText(Color(255,0,0,255), "(C4) Trying to pick up the bomb...")
		end,
		sv_effect = function(self, ply)
			local tr_ent = ply:GetAllEyeTrace().Entity
			if IsValid(tr_ent) and tr_ent:GetClass() == "br2_c4_charge" and tr_ent:GetPos():Distance(ply:GetPos()) < 150 then
				local bomb = ply:Give("item_c4")
				bomb.isArmed = tr_ent.isArmed
				bomb.Activated = tr_ent.Activated
				bomb.Timer = tr_ent.Timer
				if tr_ent.nextExplode then
					bomb.nextExplode = tr_ent.nextExplode
				end
				tr_ent:Remove()
			end
		end,
		cl_after = function(self)
			WeaponFrame:Remove()
		end
	},
	use_914_1 = {
		id = 13,
		enabled = false,
		name = "Change SCP-914",
		desc = "Change SCP-914's status",
		background_color = Color(150,150,50),
		sv_effect = function(self, ply)
			if !br2_914_on_map or !ply:Alive() or ply:IsSpectator() then return end
			
			local tr_hull = util.TraceHull({
				start = ply:GetShootPos(),
				endpos = ply:GetShootPos() + (ply:GetAimVector() * 100),
				filter = ply,
				mins = Vector(-2, -2, -2), maxs = Vector(2, 2, 2),
				mask = MASK_SHOT_HULL
			})
			if IsValid(tr_hull.Entity) then
				local ent = tr_hull.Entity
				if ent:GetClass() == "func_button" and ent:GetPos():Distance(BR2_Get_914_1_Pos()) < 4 then
					ent:Use(ply, ply, USE_ON, 1)
				end
			end
		end,
		cl_after = function(self)
			WeaponFrame:Remove()
		end
	},
	use_914_2 = {
		id = 12,
		enabled = false,
		name = "Start SCP-914",
		desc = "Start the machine",
		background_color = Color(50,150,50),
		sv_effect = function(self, ply)
			if ply:Alive() == false or ply:IsSpectator() then return end
			if !(br2_914_on_map == true and BR2_Get914Status() != 0) then return end
			local tr_hull = util.TraceHull({
				start = ply:GetShootPos(),
				endpos = ply:GetShootPos() + (ply:GetAimVector() * 100),
				filter = ply,
				mins = Vector(-2, -2, -2), maxs = Vector(2, 2, 2),
				mask = MASK_SHOT_HULL
			})
			if IsValid(tr_hull.Entity) then
				local ent = tr_hull.Entity
				if ent:GetClass() == "func_button" and ent:GetPos():Distance(BR2_Get_914_2_Pos()) < 10 then
					ent:Use(ply, ply, USE_ON, 1)
					BR2_Handle914_Start()
				end
			end
		end,
		cl_after = function(self)
			WeaponFrame:Remove()
		end
	},
	check_someones_notepad = {
		id = 15,
		enabled = false,
		name = "Check their notepad",
		desc = "Open their notepad",
		background_color = Color(125,125,125),
		cl_effect = function(self)
			local pl = lastseen_player
			if !IsValid(pl) then return end

			if self.LootingSomeone then
				EndProgressBar()
				self.LootingSomeone = false
			end
			if self.ExaminingSomeone then
				EndProgressBar()
				self.ExaminingSomeone = false
			end

			self.PickpocketingSomeonesNotepad = true
			targeted_player = lastseen_player

			progress_bar_func = function()
				EndPickpocketingNotepad()
				self.ExaminingSomeone = false
				self.LootingSomeone = false
				self.PickpocketingSomeonesNotepad = false
			end
			InitiateProgressBar(3, "Checking notepad...")
		end,
		cl_after = function(self)
			WeaponFrame:Remove()
		end
	},
}

function SWEP:CheckContents()
	if self.Owner.br_role == "MTF Operative" or self.Owner.br_team == TEAM_MTF then
		local tr_hull = util.TraceHull({
			start = self.Owner:GetShootPos(),
			endpos = self.Owner:GetShootPos() + (self.Owner:GetAimVector() * 100),
			filter = self.Owner,
			mins = Vector(-2, -2, -2), maxs = Vector(2, 2, 2),
			mask = MASK_SHOT_HULL
		})

		local ent = tr_hull.Entity
		if IsValid(ent) and ent:GetClass() == "npc_cpt_scp_173" then
			self.Contents.box_173 = {
				id = 14,
				enabled = true,
				name = "Box 173",
				desc = "Put a box on the SCP-173",
				sv_effect = function(self, ply)
					if ply:Alive() == false or ply:IsSpectator() or !ply.canContain173 then return end

					local tr_hull = util.TraceHull({
						start = ply:GetShootPos(),
						endpos = ply:GetShootPos() + (ply:GetAimVector() * 100),
						filter = ply,
						mins = Vector(-2, -2, -2), maxs = Vector(2, 2, 2),
						mask = MASK_SHOT_HULL
					})
					
					local ent = tr_hull.Entity
					if IsValid(ent) and ent:GetClass() == "npc_cpt_scp_173" and !IsValid(ent.Box) then
						ent:ContainSCP(ply)
					end
				end,
				cl_after = function(self)
					WeaponFrame:Remove()
				end
			}
		else
			if istable(self.Contents.box_173) then
				self.Contents.box_173.enabled = false
			end
		end
	end
end

function SWEP:CreateFrame()
	if IsValid(WeaponFrame) then
		WeaponFrame:Remove()
	end

	for k,v in pairs(self.Contents) do
		if isnumber(v.delete_after) then
			v.delete_after = v.delete_after - 1
			self.Contents[k] = nil
		end
	end
	
	local tr_hull = util.TraceHull({
		start = LocalPlayer():GetShootPos(),
		endpos = LocalPlayer():GetShootPos() + (LocalPlayer():GetAimVector() * 100),
		filter = LocalPlayer(),
		mins = Vector(-2, -2, -2), maxs = Vector(2, 2, 2),
		mask = MASK_SHOT_HULL
	})
	
	self:CheckContents()

	local scp914_1_enabled, scp914_2_enabled = BR_Check914()
	
	self.Contents.use_914_1.enabled = scp914_1_enabled
	self.Contents.use_914_2.enabled = scp914_2_enabled
	
	local tr_ent = self.Owner:GetAllEyeTrace().Entity
	self.Contents.pickup_bomb.enabled = false
	self.Contents.loot_body.enabled = false
	self.Contents.check_body_notepad.enabled = false

	if IsValid(tr_ent) and tr_ent:GetPos():Distance(self.Owner:GetPos()) < 150 then
		if tr_ent:GetClass() == "br2_c4_charge" then
			self.Contents.pickup_bomb.enabled = true
		elseif tr_ent:GetClass() == "prop_ragdoll" then
			self.Contents.loot_body.enabled = true
			self.Contents.check_body_notepad.enabled = true
			--self.Contents.check_pulse.enabled = true
		end
	end
	
	self.Contents.identify_player.enabled = false
	self.Contents.examine_someone.enabled = false
	self.Contents.check_someones_notepad.enabled = false
	if IsValid(lastseen_player) and lastseen_player:GetClass() == "prop_ragdoll" or lastseen_player:IsPlayer() and lastseen_player.br_team != TEAM_SCP then
		if (CurTime() - lastseen) < 10 then
			self.Contents.identify_player.enabled = true
		end

		if (CurTime() - lastseen) < 4 then
			self.Contents.examine_someone.enabled = true

			if lastseen_player:GetPos():Distance(self.Owner:GetPos()) < 150 and
				(LocalPlayer().br_team == TEAM_SECURITY or LocalPlayer().br_team == TEAM_MTF or LocalPlayer().br_team == TEAM_CI)
			then
				self.Contents.check_someones_notepad.enabled = true
			end
		end
	end
	
	local nfilter = self.Owner
	for k,v in pairs(ents.GetAll()) do
		if v:GetModel() == "models/vinrax/scp294/scp294.mdl" then
			nfilter = {self.Owner, v}
		end
	end

	local tr = util.TraceLine({
		start = self.Owner:EyePos(),
		endpos = self.Owner:EyePos() + (self.Owner:EyeAngles():Forward() * 70),
		filter = nfilter
	})

	local pickupable_items = {}

	for k,v in pairs(ents.FindInSphere(tr.HitPos, 40)) do
		if v:GetNWBool("isDropped", false) == true and !IsValid(v.Owner) then
			tr = util.TraceLine({
				start = self.Owner:EyePos(),
				endpos = v:GetPos(),
				filter = nfilter
			})
			if tr.Entity == v then
				table.ForceInsert(pickupable_items, v)
			end
		end
	end
	
	local entf = LocalPlayer():GetAllEyeTrace().Entity
	if IsValid(entf) and entf:GetNWBool("isDropped", false) == true and !IsValid(entf.Owner) and entf:GetPos():Distance(LocalPlayer():GetPos()) < 150 then
		local found = false
		for k,v in pairs(pickupable_items) do
			if v == entf then
				found = true
			end
		end
		if found == false then
			table.ForceInsert(pickupable_items, entf)
		end
	end
	
	local item_names_from_models = {
		{"models/foodnhouseholditems/pizzab.mdl", "Pizza"},
		{"models/foodnhouseholditems/sandwich.mdl", "Sandwich"},
		{"models/foodnhouseholditems/cookies.mdl", "Cookies"},
		{"models/foodnhouseholditems/mcdburgerbox.mdl", "Burger"},
		{"models/foodnhouseholditems/icecream1.mdl", "Ice Cream"},
		{"models/foodnhouseholditems/mcdfrenchfries.mdl", "French Fries"},
		{"models/foodnhouseholditems/chipslays.mdl", "Chips"},
		{"models/foodnhouseholditems/wine_white3.mdl", "Wine"},
		{"models/foodnhouseholditems/juice.mdl", "Orange Juice"},
		{"models/foodnhouseholditems/newspaper2.mdl", "Document"},
		{"models/cpthazama/scp/500.mdl", "SCP-500"},
	}

	for i,v in ipairs(pickupable_items) do
		local item_name = ""
		for k2,v2 in pairs(item_names_from_models) do
			if v2[1] == v:GetModel() then
				item_name = v2[2]
			end
		end
		if v.GetPrintName then
			item_name = v:GetPrintName()
		elseif v.PrintName then
			item_name = v.PrintName
		end
		
		self.Contents["pickup_item_"..i..""] = {
			id = table.Count(self.Contents) + 1,
			enabled = true,
			delete_after = 1,
			name = "Pickup "..item_name.."",
			desc = "Pickup the item",
			background_color = Color(0,150,150),
			cl_effect = function(self)
				chat.AddText(Color(255,255,255,255), "Trying to pick up: "..item_name.."...")
				net.Start("br_pickup_item")
					net.WriteEntity(v)
				net.SendToServer()
			end,
			cl_after = function()
				--self.Contents["pickup_item_"..i..""] = nil
				WeaponFrame:Remove()
				--self:CreateFrame()
			end
		}
	end
	
	--for k,v in pairs(self.Contents) do v.enabled = true end

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

	--table.sort(self.Contents, function(a, b) return a.id > b.id end)

	--print("###################################################################################################################################################################################################")
	--PrintTable(self.Contents)

	local new_contents = {}

	for i=1, table.Count(self.Contents) * 1.5 do
		for k,v in pairs(self.Contents) do
			if i == v.id then
				table.ForceInsert(new_contents, v)
			end
		end
	end

	--PrintTable(new_contents)

	local last_y = 24
	for k,item in pairs(new_contents) do
		if item.enabled == true then
			local panel = vgui.Create("DPanel", WeaponFrame)
			panel:SetSize(360 - 8, 50 - 8)
			panel:SetPos(4, 4 + last_y)
			panel.clr = item.background_color or Color(100, 100, 100)
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
					net.Start("br_action")
						net.WriteInt(item.id, 8)
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
			--print("Trying to push " .. ent:GetName() .. " ("..CurTime()..")")
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

	--TODO
	if self.LootingSomeone and progress_bar_status > 0 then
		if !IsValid(targeted_player or targeted_player:GetPos():Distance(LocalPlayer():GetPos()) > 250) then
			EndProgressBar()
		end
		local tr = util.TraceLine({
			start = LocalPlayer():EyePos(),
			endpos = targeted_player:GetPos(),
			filter = LocalPlayer()
		})
		if tr.Entity != targeted_player then
			EndProgressBar()
		end
	end

	--TODO
	if self.ExaminingSomeone and progress_bar_status > 0 then
		if !IsValid(targeted_player or targeted_player:GetPos():Distance(LocalPlayer():GetPos()) > 250) then
			EndProgressBar()
			chat.AddText(color_white, "They are too far away to properly examine...")
		end
		local tr = util.TraceLine({
			start = LocalPlayer():EyePos(),
			endpos = targeted_player:GetPos(),
			filter = LocalPlayer()
		})
		if tr.Entity != targeted_player or LocalPlayer():GetAimVector():Dot((LocalPlayer():GetPos() - targeted_player:GetPos() + Vector(70)):GetNormalized()) > 0.3 then
			EndProgressBar()
			chat.AddText(color_white, "I can't see them...")
		end
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
	if CLIENT then
		self:CreateFrame()
	end
end

function SWEP:DrawHUD()
	if !BR2_ShouldDrawWeaponInfo() then return end

	local text = "Secondary attack opens action menu, Reload toggles pushing mode"
	
	if self:IsSCP049() then
		text = "Left click to attack, Secondary attack opens action menu, Reload toggles punching mode"
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
