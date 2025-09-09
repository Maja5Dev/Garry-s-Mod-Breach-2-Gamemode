
local function weed_effects(ply)
	ply:StartCustomScreenEffects({
		colour = 2,
		tt1 = 4,
		tt2 = 6,
		vignette_alpha = 100
	}, 15)
	ply:BR2_ShowNotification("MAN DATS SOM GOOD ASS SHIT")
	ply:AddRunStamina(-500)
	ply:AddJumpStamina(-00)
	ply:AddSanity(40)
	ply:SendLua("surface.PlaySound(\"breach2/420J.ogg\")")
end

function LockPickFunc(ply, v)
	for k,pl in pairs(player.GetAll()) do
		if pl.startedLockpicking and pl.startedLockpicking[2] + 9.1 > CurTime() then
			ply:ChatPrint("Someone else is lockpicking this crate...")
			return
		end
	end

	ply.startedLockpicking = {v, CurTime()}
	ply:SendLua("StartLockpicking()")
	ply:EmitSound("breach2/lockpick.mp3")
end

local function br2_special_item_drop(pl, class, name, force_class, mdl)
	--print(pl, class, name)
	local dropped_ent = ents.Create(force_class)
	if IsValid(dropped_ent) then
		local tr = util.TraceLine({
			start = pl:EyePos(),
			endpos = pl:EyePos() + (pl:EyeAngles():Forward() * 30),
			filter = pl
		})
		if tr.Hit == false then
			dropped_ent:SetPos(tr.HitPos)
		else
			dropped_ent:SetPos(pl:EyePos())
		end
		if mdl then
			dropped_ent:SetModel(mdl)
		end
		dropped_ent:SetAngles(Angle(-10, pl:EyeAngles().yaw, 0))
		dropped_ent:Spawn()
		dropped_ent.SI_Class = class
		dropped_ent.PrintName = name
		ForceSetPrintName(dropped_ent, name)
		dropped_ent:SetNWBool("isDropped", true)
		
		local phys = dropped_ent:GetPhysicsObject()
		if IsValid(phys) then
			phys:Wake()
			phys:SetMass(5)
			phys:ApplyForceCenter(pl:EyeAngles():Forward() * 1000)
		end
		for k,v in pairs(pl.br_special_items) do
			if v.class == class then
				table.RemoveByValue(pl.br_special_items, v)
				return true, dropped_ent
			end
		end
	end
	return false, NULL
end

local scp_294_func = function(ply, info, text)
	MAP_SCP_294_Coins = 0

	local cup = ents.Create("br2_cup")
	if IsValid(cup) then
		cup:SetPos(MAPCONFIG.SCP_294_CUP.pos)
		cup:SetAngles(MAPCONFIG.SCP_294_CUP.ang)
		cup:SetNWBool("isDropped", true)
		cup.SI_Class = "cup"
		cup.PrintName = "Cup of " .. TitleCase(text)
		cup.CupType = text
		cup:Spawn()
		
		ForceSetPrintName(cup, cup.PrintName)
	end
end

local scp294_sound_ahh = {"breach2/294/ahh.ogg", 1.2}
local scp294_sound_slurp = {"breach2/294/slurp.ogg", 0.766}
local scp294_sound_burn = {"breach2/294/burn.ogg", 0}
local scp294_sound_ew1 = {"breach2/294/ew1.ogg", 1.2}
local scp294_sound_ew2 = {"breach2/294/ew2.ogg", 1.2}
local scp294_sound_spit = {"breach2/294/spit.ogg", 0.766}
local scp294_sound_cough = {"breach2/294/cough.ogg", 0.766}

-- lua_run Entity(1).br_special_items = {{class = "flashlight_tactical"}, {class = "lockpick"}, {class = "coin"}, {class = "crafting_toolbox"}, {class = "device_cameras"}}
-- lua_run Entity(1).br_special_items = {{class = "ammo_pistol"}, {class = "ammo_smg"}, {class = "ammo_rifle"}, {class = "ammo_shotgun"}}
-- lua_run Entity(1).br_special_items[1] = {class = "document", name = "SCP-173 Doc", type = "doc_scp173"}

BR2_SCP_294_OUTCOMES = {
	{
		texts = {"nothing", "emptiness", "air", "vacuum", "half life 3", "hl3", "halflife3", "tf2 update"},
		type = SCP294_RESULT_NOTHING,
		sound = scp294_sound_slurp,
		func = function(ply, info, text) scp_294_func(ply, info, text) end,
		use = function(ply)
			ply:BR2_ShowNotification("There is nothing to drink in the cup.")
			return true
		end
	},

	{
		texts = {"water", "drink", "juice", "milk"},
		type = SCP294_RESULT_NORMAL,
		sound = scp294_sound_ahh,
		func = function(ply, info, text) scp_294_func(ply, info, text) end,
		use = function(ply)
			ply:BR2_ShowNotification("Well, that was refreshing.")
			ply:AddHealth(1)
			ply:AddThirst(-15)
			return true
		end
	},

	{
		texts = {"aloe vera", "aloe", "aloe vera drink", "cactus drink"},
		type = SCP294_RESULT_NORMAL,
		sound = scp294_sound_ahh,
		func = function(ply, info, text) scp_294_func(ply, info, text) end,
		use = function(ply)
			ply:AddHealth(15)
			return true
		end
	},

	{
		texts = {"energy drink", "redbull", "red bull", "monster", "energy"},
		type = SCP294_RESULT_NORMAL,
		sound = scp294_sound_ahh,
		func = function(ply, info, text) scp_294_func(ply, info, text) end,
		use = function(ply)
			ply:BR2_ShowNotification("Tastes like battery acid...")
			ply:AddRunStamina(3000)
			return true
		end
	},

	{
		texts = {"void", "antimatter", "anti-matter", "atomic", "nuclear", "nuclear bomb", "nuclear fusion", "nuclear fission",
		"nuclear reaction", "nuke", "quarks", "gluons", "gluon plasma", "plasma", "something that will destroy scp-682",
		"something that destroys scp-682", "something to destroy scp-682",  },
		type = SCP294_RESULT_INSANE,
		sound = nil,
		func = function(ply, info, text) scp_294_func(ply, info, text) end,
		use = function(ply)
			local effect = EffectData()
			effect:SetStart(ply:GetPos())
			effect:SetOrigin(ply:GetPos())
			effect:SetScale(200)
			effect:SetRadius(200)
			effect:SetMagnitude(0)

			util.Effect("Explosion", effect, true, true)
			util.Effect("HelicopterMegaBomb", effect, true, true)

			ply:Kill()

			ply:SendLua("surface.PlaySound(\"breach2/nuke2.ogg\")")
			return true
		end
	},

	{
		texts = {"blood"},
		type = SCP294_RESULT_STRUGGLING,
		sound = scp294_sound_ew1,
		func = function(ply, info, text) scp_294_func(ply, info, text) end,
		use = function(ply)
			ply.br_isBleeding = true
			return true
		end
	},

	{
		texts = {"breach 1", "old scp sl", "scp cb"},
		type = SCP294_RESULT_STRUGGLING,
		sound = scp294_sound_slurp,
		func = function(ply, info, text) scp_294_func(ply, info, text) end,
		use = function(ply)
			ply:BR2_ShowNotification("Nostalgia overwhelms you... you commit suicide.")
			ply:Kill()
			return true
		end
	},

	{
		texts = {"blood of jesus", "blood of christ", "blood of jesus christ"},
		type = SCP294_RESULT_STRUGGLING,
		sound = scp294_sound_slurp,
		func = function(ply, info, text) scp_294_func(ply, info, text) end,
		use = function(ply)
			ply:AddHealth(200)
			ply:BR2_ShowNotification("This drink tastes like red wine.")
			return true
		end
	},

	{
		texts = {"bose-einstein condensate", "quantum gas", "carbon", "hydrofluoric acid", "hydrochloric acid", "corrosive acid", "acid", "iron",
			"metal", "razor", "blades", "razorblades", "lava", "magma", "earth", "rock", "rocks", "stone", "liquid nitrogen", "nitrogen",
			"rage", "anger", "angry", "hate", "sulfuric acid", "strange matter", "superfluid", "helium", "liquid helium", "helium-4"
		},
		type = SCP294_RESULT_INSANE,
		sound = scp294_sound_spit,
		func = function(ply, info, text) scp_294_func(ply, info, text) end,
		use = function(ply)
			ply:Kill()
			return true
		end
	},

	{
		texts = {"butt ghost", "liquid butt ghost"},
		type = SCP294_RESULT_STRUGGLING,
		sound = scp294_sound_ew2,
		func = function(ply, info, text) scp_294_func(ply, info, text) end,
		use = function(ply)
			ply:BR2_ShowNotification("Ouch my ass is being eaten.")
			local ply_charid = ply.charid

			timer.Simple(3, function()
				if ply_charid == ply.charid and ply:Alive() and !ply:IsSpectator() then
					ply:Kill()
				end
			end)

			return true
		end
	},

	{
		texts = {"fear", "scare", "horror", "terror", "sanity"},
		type = SCP294_RESULT_NORMAL,
		sound = scp294_sound_ew2,
		func = function(ply, info, text) scp_294_func(ply, info, text) end,
		use = function(ply)
			ply:AddSanity(-100)
			return true
		end
	},

	{
		texts = {"fent", "fentanyl", "morphine", "heroin"},
		type = SCP294_RESULT_NORMAL,
		sound = scp294_sound_ew2,
		func = function(ply, info, text) scp_294_func(ply, info, text) end,
		use = function(ply)
			local ply_charid = ply.charid

			timer.Simple(10, function()
				if ply_charid == ply.charid and ply:Alive() and !ply:IsSpectator() then
					ply:Kill()
				end
			end)

			return true
		end
	},

	{
		texts = {"meth", "methamphetamine", "adderal"},
		type = SCP294_RESULT_NORMAL,
		sound = scp294_sound_slurp,
		func = function(ply, info, text) scp_294_func(ply, info, text) end,
		use = function(ply)
			ply.br_used_syringe = true
			ply:AddRunStamina(3000)
			ply:AddJumpStamina(200)
			return true
		end
	},

	{
		texts = {"weed", "420", "scp-420-j", "scp-420", "dope", "green dragon"},
		type = SCP294_RESULT_NORMAL,
		sound = scp294_sound_cough,
		func = function(ply, info, text) scp_294_func(ply, info, text) end,
		use = function(ply)
			weed_effects(ply)
			return true
		end
	},

	{
		texts = {"piss", "urine", "jarate", "pee", "vomit", "cum", "baby batter", "perfume", "deodorant", "shampoo", "cologne", "fragrance",
		"shit", "crap", "poop", "bath water", "bathwater", "sweat"},
		type = SCP294_RESULT_NORMAL,
		sound = scp294_sound_ew1,
		func = function(ply, info, text) scp_294_func(ply, info, text) end,
		use = function(ply)
			ply:BR2_ShowNotification("I am not drinking that")
			return false
		end
	},

	{
		texts = {"anti-energy-drink", "anti energy drink"},
		type = SCP294_RESULT_NORMAL,
		sound = scp294_sound_ew2,
		func = function(ply, info, text) scp_294_func(ply, info, text) end,
		use = function(ply)
			ply:AddRunStamina(-3000)
			ply:BR2_ShowNotification("The drink tastes terrible. You feel tired and drained.")
			return true
		end
	},

	{
		texts = {"beer", "lager", "alcohol", "wine"},
		type = SCP294_RESULT_NORMAL,
		sound = scp294_sound_ahh,
		func = function(ply, info, text) scp_294_func(ply, info, text) end,
		use = function(ply)
			ply:AddRunStamina(-3000)
			ply:AddSanity(30)
			ply:AddThirst(-30)
			ply:BR2_ShowNotification("Nice...")

			ply:StartCustomScreenEffects({
				colour = 1.7,
				blur1 = 0.2,
				blur2 = 0.8,
				blur3 = 0.01,
			}, 30)
			return true
		end
	},

	{
		texts = {"ssri", "escitalopram", "citalopram", "xanax", "fluoxetine", "sertraline", "paroxetine", "fluvoxamine"},
		type = SCP294_RESULT_NORMAL,
		sound = scp294_sound_ew2,
		func = function(ply, info, text) scp_294_func(ply, info, text) end,
		use = function(ply)
			ply:AddSanity(100)
			return true
		end
	},
}

-- lua_run Entity(1).br_special_items[1] = {class = "device_cameras"}

BR2_TOOLBOX_ITEMS = {
	{
		info = "You crafted a Lockpick",
		func = function(pl)
			table.ForceInsert(pl.br_special_items, {class = "lockpick"})
		end,
	},
	{
		info = "You crafted a Flashlight",
		func = function(pl)
			table.ForceInsert(pl.br_special_items, {class = "flashlight_normal"})
		end,
	},
	{
		info = "You crafted a Pipe",
		func = function(pl)
			for k,v in pairs(pl:GetWeapons()) do
				if v:GetClass() == "kanade_tfa_pipe" then
					pl:DropWep(v, 0)
				end
			end
			pl:Give("kanade_tfa_pipe")
		end,
	},
}

BR2_SPECIAL_ITEMS = {
	{
		class = "personal_medkit",
		name = "Personal Medkit",
		func = function(pl, ent)
			--print("funcky", pl, ent, ent.attributes, ent.Attrubutes)
			if #pl.br_special_items > 9 then
				pl:PrintMessage(HUD_PRINTTALK, "Your inventory is full!")
				return false
			end
			table.ForceInsert(pl.br_special_items, {class = "personal_medkit", attributes = ent.Attributes})
			pl.sp_medkit_uses = 4
			return true
		end,
		use = function(pl, item)
			for k,v in pairs(pl.br_special_items) do
				if spi_comp(v, item) then
					--print("tries to use", item, item.attributes)
					if !istable(item.attributes) then
						item.attributes = {}
					end
					if item.attributes["uses"] == nil then
						item.attributes["uses"] = 4
					end
					pl.br_isBleeding = false
					pl:SetHealth(pl:GetMaxHealth())

					item.attributes["uses"] = item.attributes["uses"] - 1
					if item.attributes["uses"] == 0 then
						table.RemoveByValue(pl.br_special_items, v)
					end

					local text = " uses"
					if item.attributes["uses"] == 1 then
						text = " use"
					end
					pl:ChatPrint("You feel much better, the medkit has "..item.attributes["uses"]..text.." left")
					return true
				end
			end
			return true
		end,
		onstart = function(pl)
		end,
		drop = function(pl, item)
			--local res, ent = br2_special_item_drop(pl, "personal_medkit", "Personal Medkit", "prop_physics", "models/items/healthkit.mdl")
			--ent.Attributes = item.attributes
			pl:ChatPrint("This item cannot be dropped")
		end
	},
	{
		class = "document",
		name = "Document",
		func = function(pl, ent)
			if #pl.br_special_items > 9 then
				pl:PrintMessage(HUD_PRINTTALK, "Your inventory is full!")
				return false
			end
			table.ForceInsert(pl.br_special_items, {class = "document", name = ent.PrintName, type = ent.DocType, attributes = ent.DocAttributes})
			return true
		end,
		use = function(pl, item)
			net.Start("br_use_document")
				net.WriteTable(item)
			net.Send(pl)
			return true
		end,
		onstart = function(pl)
		end,
		drop = function(pl, item)
			--local res, ent = br2_special_item_drop(pl, "document", "Document", "prop_physics", "models/props_interiors/paper_tray.mdl")
			local res, ent = br2_special_item_drop(pl, "document", "Document", "prop_physics", "models/foodnhouseholditems/newspaper2.mdl")
			ent.PrintName = item.name
			ent.DocType = item.type
			ent.DocAttributes = item.attributes
			ForceSetPrintName(ent, ent.PrintName)
		end
	},
	{
		class = "cup",
		name = "Cup",
		func = function(pl, ent)
			table.ForceInsert(pl.br_special_items, {class = "cup", name = ent.PrintName, type = ent.CupType})
			return true
		end,
		use = function(pl, item)
			for k,v in pairs(BR2_SCP_294_OUTCOMES) do
				if table.HasValue(v.texts, item.type) then
					local delay = 0.1

					if istable(v.sound) then
						pl:EmitSound(v.sound[1])
						delay = v.sound[2]
					end

					timer.Create("scp294use_"..pl:SteamID64(), delay, 1, function()
						for k2,v2 in pairs(pl.br_special_items) do
							if spi_comp(v2, item) then
								table.RemoveByValue(pl.br_special_items, v2)

								for k3,v3 in pairs(BR2_SCP_294_OUTCOMES) do
									if table.HasValue(v3.texts, item.type) then
										v3.use(pl)
									end
								end
							end
						end
					end)

					return false
				end
			end

			return true
		end,
		onstart = function(pl)
		end,
		drop = function(pl, ent)
			--local res, ent = br2_special_item_drop(pl, "cup", "Cup", "br2_cup")
			pl:PrintMessage(HUD_PRINTTALK, "This item cannot be dropped")
		end
	},
	{
		class = "coin",
		name = "Coin",
		func = function(pl)
			if #pl.br_special_items > 9 then
				pl:PrintMessage(HUD_PRINTTALK, "Your inventory is full!")
				return false
			end
			table.ForceInsert(pl.br_special_items, {class = "coin"})
			return true
		end,
		use = function(pl)
			pl:PrintMessage(HUD_PRINTTALK, "Just a shiny coin, probably usable in some places")
		end,
		onstart = function(pl)
		end,
		drop = function(pl)
			local res, item = br2_special_item_drop(pl, "coin", "Coin", "prop_physics", "models/cultist/items/coin/coin.mdl")
		end,
		scp_1162_class = "br2_item",
		scp_1162 = function(pl, ent)
			ent.PrintName = "Coin"
			ent.SI_Class = "coin"
			ForceSetPrintName(ent, ent.PrintName)
		end
	},
	{
		class = "crafting_toolbox",
		name = "Toolbox",
		func = function(pl, ent)
			if #pl.br_special_items > 9 then
				pl:PrintMessage(HUD_PRINTTALK, "Your inventory is full!")
				return false
			end
			table.ForceInsert(pl.br_special_items, {class = "crafting_toolbox", attributes = ent.Attributes})
			pl.sp_toolbox_uses = 3
			return true
		end,
		use = function(pl, item)
			for k,v in pairs(pl.br_special_items) do
				if spi_comp(v, item) then
					--print("tries to use", item, item.attributes)
					if !istable(item.attributes) then
						item.attributes = {}
					end
					if item.attributes["uses"] == nil then
						item.attributes["uses"] = 2
					end
					local rand_item = table.Random(BR2_TOOLBOX_ITEMS)
					rand_item.func(pl)

					item.attributes["uses"] = item.attributes["uses"] - 1
					if item.attributes["uses"] == 0 then
						table.RemoveByValue(pl.br_special_items, v)
					end

					local text = " uses"
					if item.attributes["uses"] == 1 then
						text = " use"
					end
					pl:ChatPrint(rand_item.info..", the toolbox has "..item.attributes["uses"]..text.." left")
					return true
				end
			end
			return true
		end,
		onstart = function(pl)
			if pl.br_role == "Engineer" then
				table.ForceInsert(pl.br_special_items, {class = "crafting_toolbox"})
			end
		end,
		drop = function(pl)
			local res, item = br2_special_item_drop(pl, "crafting_toolbox", "Toolbox", "prop_physics", "models/cultist/items/toolbox/tool_box.mdl")
		end,
		scp_1162_class = "br2_item",
		scp_1162 = function(pl, ent)
			ent.PrintName = "Toolbox"
			ent.SI_Class = "crafting_toolbox"
			ForceSetPrintName(ent, ent.PrintName)
		end
	},
	{
		class = "lockpick",
		name = "Lockpick",
		func = function(pl)
			if #pl.br_special_items > 9 then
				pl:PrintMessage(HUD_PRINTTALK, "Your inventory is full!")
				return false
			end
			table.ForceInsert(pl.br_special_items, {class = "lockpick"})
			return true
		end,
		use = function(pl)
			--pl:PrintMessage(HUD_PRINTTALK, "Universal lockpick, can be used to open doors or crates")
			local tr_lp = util.TraceLine({
				start = pl:EyePos(),
				endpos = pl:EyePos() + pl:EyeAngles():Forward() * 170,
				filter = pl
			})

			local tr_ent = tr_lp.Entity
			--print(tr_ent, IsValid(tr_ent), tr_ent:GetClass(), tr_ent:GetClass() == "prop_door_rotating")
			if IsValid(tr_ent) and tr_ent:GetClass() == "prop_door_rotating" then
				LockPickFunc(pl, tr_ent)
				--tr:Fire("unlock", "", 0)
				return
			end

			local closest = nil
			for k,v in pairs(MAPCONFIG.BUTTONS_2D.ITEM_CONTAINERS_CRATES.buttons) do
				local dis = v.pos:Distance(tr_lp.HitPos)
				if closest == nil or closest[2] > dis then
					closest = {v, dis}
				end
			end
			if closest != nil and closest[1].locked == true and closest[2] < 150 then
				LockPickFunc(pl, closest[1])
				return
			end

			pl:PrintMessage(HUD_PRINTTALK, "Universal lockpick, can be used to open doors or crates")
		end,
		onstart = function(pl)
			if pl.br_role == "Class D" and math.random(1,5) == 2 then
				table.ForceInsert(pl.br_special_items, {class = "lockpick"})
			end
		end,
		drop = function(pl)
			local res, item = br2_special_item_drop(pl, "lockpick", "Lockpick", "br2_item")
		end,
		scp_1162_class = "br2_item",
		scp_1162 = function(pl, ent)
			ent.PrintName = "Lockpick"
			ent.SI_Class = "lockpick"
			ForceSetPrintName(ent, ent.PrintName)
		end
	},
	{
		class = "device_cameras",
		name = "WCR [Cameras]",
		func = function(pl)
			if #pl.br_special_items > 9 then
				pl:PrintMessage(HUD_PRINTTALK, "Your inventory is full!")
				return false
			end
			table.ForceInsert(pl.br_special_items, {class = "device_cameras"})
			return true
		end,
		use = function(pl)
			pl:PrintMessage(HUD_PRINTTALK, "Installed in terminals, used to check the cameras")
		end,
		onstart = function(pl)
			if pl.br_role == "Engineer" and math.random(1,5) == 2 then
				table.ForceInsert(pl.br_special_items, {class = "crafting_toolbox"})
			end
		end,
		drop = function(pl)
			local res, item = br2_special_item_drop(pl, "device_cameras", "WCR [Cameras]", "prop_physics", "models/props_lab/reciever01c.mdl")
		end
	},
	{
		class = "scp_420",
		name = "SCP-420-J",
		func = function(pl)
			if #pl.br_special_items > 9 then
				pl:PrintMessage(HUD_PRINTTALK, "Your inventory is full!")
				return false
			end
			table.ForceInsert(pl.br_special_items, {class = "scp_420"})
			return true
		end,
		use = function(pl, item)
			weed_effects(pl)
			return true
		end,
		onstart = function(pl)
		end,
		drop = function(pl)
			local res, item = br2_special_item_drop(pl, "scp_420", "SCP-420-J", "prop_physics", "models/mishka/models/scp420.mdl")
		end
	},
	{
		class = "syringe",
		name = "Syringe",
		func = function(pl)
			if #pl.br_special_items > 9 then
				pl:PrintMessage(HUD_PRINTTALK, "Your inventory is full!")
				return false
			end
			table.ForceInsert(pl.br_special_items, {class = "syringe"})
			return true
		end,
		use = function(pl, item)
			for k,v in pairs(pl.br_special_items) do
				if spi_comp(v, item) then
					table.RemoveByValue(pl.br_special_items, v)
					pl:AddRunStamina(3000)
					pl:AddJumpStamina(200)
					pl.CrippledStamina = 0
					pl.nextNormalRun = CurTime()
					pl.br_speed_boost = CurTime() + 10
					pl:SetFOV(120, 1)
					pl.br_used_syringe = true
					pl:SendLua('surface.PlaySound("breach2/adrenaline_needle_in.wav")')
					return true
				end
			end
			return true
		end,
		onstart = function(pl)
		end,
		drop = function(pl)
			local res, item = br2_special_item_drop(pl, "syringe", "Syringe", "prop_physics", "models/mishka/models/syringe.mdl")
		end
	},
	{
		class = "scp_500",
		name = "SCP-500",
		func = function(pl)
			if #pl.br_special_items > 9 then
				pl:PrintMessage(HUD_PRINTTALK, "Your inventory is full!")
				return false
			end
			table.ForceInsert(pl.br_special_items, {class = "scp_500"})
			return true
		end,
		use = function(pl, item)
			for k,v in pairs(pl.br_special_items) do
				if spi_comp(v, item) then
					table.RemoveByValue(pl.br_special_items, v)
					pl:AddRunStamina(3000)
					pl:AddJumpStamina(200)
					pl.CrippledStamina = 0
					pl.br_sanity = 100
					pl.br_temperature = 0
					pl.br_isBleeding = false
					pl:SetHealth(pl:GetMaxHealth())
					pl.br_infection = 0
					pl.br_isInfected = false
					pl.SCP_Inflicted_1048a = false
					pl.SCP_Infected_049 = false
					pl:ChatPrint("Your wounds heal instantly...")
					return true
				end
			end
			return true
		end,
		onstart = function(pl)
		end,
		drop = function(pl)
			local res, item = br2_special_item_drop(pl, "scp_500", "SCP-500", "prop_physics", "models/cpthazama/scp/500.mdl")
		end
	},
	{
		class = "medicine",
		name = "Medicine",
		func = function(pl)
			if #pl.br_special_items > 9 then
				pl:PrintMessage(HUD_PRINTTALK, "Your inventory is full!")
				return false
			end
			table.ForceInsert(pl.br_special_items, {class = "medicine"})
			return true
		end,
		use = function(pl, item)
			for k,v in pairs(pl.br_special_items) do
				if spi_comp(v, item) then
					table.RemoveByValue(pl.br_special_items, v)

					pl:EmitSound("breach2/pills_deploy_"..math.random(1,3)..".wav")
					pl:SetHealth(math.Clamp(pl:Health() + 20, 1, pl:GetMaxHealth()))
					pl.br_infection = math.Clamp(pl.br_infection - 50, 0, 100)
					if pl.br_infection < 3 then
						pl.br_isInfected = false
					end
					pl:ChatPrint("Your took some medicine...")
					return true
				end
			end
			return true
		end,
		onstart = function(pl)
			if pl.br_role == "Doctor" then
				table.ForceInsert(pl.br_special_items, {class = class})
			end
		end,
		drop = function(pl)
			local res, item = br2_special_item_drop(pl, "medicine", "Medicine", "prop_physics", "models/cultist/items/painpills/w_painpills.mdl")
		end
	},
	{
		class = "eyedrops",
		name = "Eyedrops",
		func = function(pl)
			if #pl.br_special_items > 9 then
				pl:PrintMessage(HUD_PRINTTALK, "Your inventory is full!")
				return false
			end
			table.ForceInsert(pl.br_special_items, {class = "eyedrops"})
			return true
		end,
		use = function(pl, item)
			for k,v in pairs(pl.br_special_items) do
				if spi_comp(v, item) then
					table.RemoveByValue(pl.br_special_items, v)

					pl:ChatPrint("Your used the eyedrops...")
					return true
				end
			end
			return true
		end,
		onstart = function(pl)
		end,
		drop = function(pl)
			local res, item = br2_special_item_drop(pl, "eyedrops", "Eyedrops", "prop_physics", "models/cultist/items/eyedrops/eyedrops.mdl")
		end
	},
	{
		class = "ssri_pills",
		name = "SSRI Pills",
		func = function(pl)
			if #pl.br_special_items > 9 then
				pl:PrintMessage(HUD_PRINTTALK, "Your inventory is full!")
				return false
			end
			table.ForceInsert(pl.br_special_items, {class = "ssri_pills"})
			return true
		end,
		use = function(pl, item)
			for k,v in pairs(pl.br_special_items) do
				if spi_comp(v, item) then
					table.RemoveByValue(pl.br_special_items, v)

					pl.nextHorrorSCP = CurTime() + 45
					pl:AddSanity(50)
					pl:EmitSound("breach2/pills_deploy_"..math.random(1,3)..".wav")
					pl:ChatPrint("Your took the pills... you feel calmer.")
					return true
				end
			end
			return true
		end,
		onstart = function(pl)
			if pl.br_role == "Doctor" and math.random(1,5) == 2 then
				table.ForceInsert(pl.br_special_items, {class = "ssri_pills"})
			end
		end,
		drop = function(pl)
			local res, item = br2_special_item_drop(pl, "ssri_pills", "SSRI Pills", "prop_physics", "models/props_lab/jar01b.mdl")
		end
	},
	{
		class = "conf_folder",
		name = "Confidential Folder",
		func = function(pl)
			if #pl.br_special_items > 9 then
				pl:PrintMessage(HUD_PRINTTALK, "Your inventory is full!")
				return false
			end
			table.ForceInsert(pl.br_special_items, {class = "conf_folder"})
			return true
		end,
		use = function(pl, item)
			pl:PrintMessage(HUD_PRINTTALK, "Folder of Confidential Information")
			if pl.br_team == TEAM_CI then
				pl:SendLua('chat.AddText(Color(195, 55, 255), "This folder is a valuable property of the SCP Foundation, stealing it would be a good idea!")')
			
			elseif pl.br_team == TEAM_RESEARCHER or pl.br_team == TEAM_SECURITY then
				pl:SendLua('chat.AddText(Color(255, 225, 0), "This folder is a valuable property of the SCP Foundation, keep it safe!")')
			end
			return true
		end,
		onstart = function(pl)
			if pl.br_role == "Researcher" then
				table.ForceInsert(pl.br_special_items, {class = "conf_folder"})
			end
		end,
		drop = function(pl)
			local res, item = br2_special_item_drop(pl, "conf_folder", "Confidential Folder", "prop_physics", "models/scp_documents/secret_document.mdl")
		end
	},
}

function gvi_d(name)
	table.ForceInsert(Entity(1).br_special_items,
		{class = "document", name = "Printed Document", type = name, attributes = {doc_code = "2137"}
	})
end

function gvi(name)
	table.ForceInsert(Entity(1).br_special_items, {class=name})
end

function gvi_p(name)
	table.ForceInsert(Entity(8).br_special_items, {class=name})
end

BR2_FLASHLIGHT_TYPES = {
	{
		name = "Regular Flashlight",
		class = "flashlight_cheap",
		class2 = "br2_item_flashlight_cheap",
		level = 1,
		sound_on = "breach2/flashlight2.wav",
		sound_off = "breach2/flashlight2.wav",
		on_use = function(pl)
			pl.flashlight3d:SetKeyValue("enableshadows", 1)
			pl.flashlight3d:SetKeyValue("farz", 400)
			pl.flashlight3d:SetKeyValue("nearz", 8)
			pl.flashlight3d:SetKeyValue("lightfov", 50)
			pl.flashlight3d:SetKeyValue("lightcolor", "180, 180, 80")
			pl.flashlight3d:SetColor(Color(255, 255, 255))
	
			pl.flashlight3d:Fire("SpotlightTexture", "br2_flashlight/flashlight2")
		end
	},
	{
		name = "Heavy Duty Flashlight",
		class = "flashlight_normal",
		class2 = "br2_item_flashlight_normal",
		level = 2,
		sound_on = "breach2/flashlight3.wav",
		sound_off = "breach2/flashlight3.wav",
		on_use = function(pl)
			pl.flashlight3d:SetKeyValue("enableshadows", 1)
			pl.flashlight3d:SetKeyValue("farz", 650)
			pl.flashlight3d:SetKeyValue("nearz", 8)
			pl.flashlight3d:SetKeyValue("lightfov", 75)
			pl.flashlight3d:SetKeyValue("lightcolor", "200, 200, 150")
			pl.flashlight3d:SetColor(Color(255, 255, 255))
	
			pl.flashlight3d:Fire("SpotlightTexture", "br2_flashlight/flashlight2")
		end
	},
	{
		name = "Floodlight",
		class = "flashlight_tactical",
		class2 = "br2_item_flashlight_tactical",
		level = 3,
		sound_on = "breach2/flashlight4_on.wav",
		sound_off = "breach2/flashlight4_off.wav",
		on_use = function(pl)
			pl.flashlight3d:SetKeyValue("enableshadows", 1)
			pl.flashlight3d:SetKeyValue("farz", 2048)
			pl.flashlight3d:SetKeyValue("nearz", 8)
			pl.flashlight3d:SetKeyValue("lightfov", 90)
			pl.flashlight3d:SetKeyValue("lightcolor", "255, 255, 255")
			pl.flashlight3d:SetColor(Color(255, 255, 255))
			
			pl.flashlight3d:Fire("SpotlightTexture", "br2_flashlight/flashlight3")
		end
	},
}

local function add_flashlight(fl_info)
	local fltab = {
		class = fl_info.class,
		name = fl_info.name,
		func = function(pl)
			if #pl.br_special_items > 9 then
				pl:PrintMessage(HUD_PRINTTALK, "Your inventory is full!")
				return false
			end
			if !pl:CanUseFlashlight() then
				table.ForceInsert(pl.br_special_items, {class = fl_info.class})
				pl:AllowFlashlight(true)
				return true
			end
			pl:PrintMessage(HUD_PRINTTALK, "You already have a flashlight!")
			return false
		end,
		use = function(pl)
			pl:ForceUseFlashlight(fl_info)
		end,
		drop = function(pl)
			local res, item = br2_special_item_drop(pl, fl_info.class, fl_info.name, fl_info.class2)
			--if res == true then
				if IsValid(pl.flashlight3d) then
					pl.flashlight3d:Remove()
				end
				pl:AllowFlashlight("false")
			--end
		end,
		scp_1162_class = "br2_item",
		scp_1162 = function(pl, ent)
			ent.PrintName = fl_info.name
			ent.SI_Class = fl_info.class
			ForceSetPrintName(ent, ent.PrintName)
		end
	}
	if fl_info.class == "flashlight_normal" then
		fltab.onstart = function(pl)
			if pl:CanUseFlashlight() then
				table.ForceInsert(pl.br_special_items, {class = fl_info.class})
			end
		end
	else
		fltab.onstart = function(pl) end
	end
	table.ForceInsert(BR2_SPECIAL_ITEMS, fltab)
end

for k,v in pairs(BR2_FLASHLIGHT_TYPES) do
	--add_flashlight(v.class, v.name, v.class2)
	add_flashlight(v)
end

local function add_food(class, name, model, hunger, health)
	table.ForceInsert(BR2_SPECIAL_ITEMS, {
		class = class,
		name = name,
		func = function(pl)
			if #pl.br_special_items > 9 then
				pl:PrintMessage(HUD_PRINTTALK, "Your inventory is full!")
				return false
			end
			table.ForceInsert(pl.br_special_items, {class = class})
			return true
		end,
		use = function(pl, item)
			if pl.br_thirst > 100 then
				pl:PrintMessage(HUD_PRINTTALK, "You are not hungry")
				return false
			end

			for k,v in pairs(pl.br_special_items) do
				if spi_comp(v, item) then
					table.RemoveByValue(pl.br_special_items, v)
					if istable(hunger) then
						for i=1, hunger[2] do
							if #pl.br_special_items > 9 then
								br2_special_item_drop(pl, hunger[1], hunger[3], "prop_physics", hunger[4])
							else
								table.ForceInsert(pl.br_special_items, {class = hunger[1]})
							end
						end
					else
						pl:AddHunger(-hunger)
						pl:AddHealth(health)
					end
					
					if pl.br_hunger > 75 then
						pl:PrintMessage(HUD_PRINTTALK, "You ate the "..name..", you feel full")
					elseif pl.br_hunger > 60 then
						pl:PrintMessage(HUD_PRINTTALK, "You ate the "..name..", you feel satisfied")
					elseif pl.br_hunger > 35 then
						pl:PrintMessage(HUD_PRINTTALK, "You ate the "..name..", your feel less hungry")
					else
						pl:PrintMessage(HUD_PRINTTALK, "You ate the "..name..", your stomach still rumbles")
					end

					pl:EmitSound("breach2/eat.wav")
					return true
				end
			end
			return true
		end,
		onstart = function(pl)
		end,
		drop = function(pl)
			local res, item = br2_special_item_drop(pl, class, name, "prop_physics", model)
		end
	})
end

local function add_drink(class, name, model, thirst)
	table.ForceInsert(BR2_SPECIAL_ITEMS, {
		class = class,
		name = name,
		func = function(pl)
			if #pl.br_special_items > 9 then
				pl:PrintMessage(HUD_PRINTTALK, "Your inventory is full!")
				return false
			end
			table.ForceInsert(pl.br_special_items, {class = class})
			return true
		end,
		use = function(pl, item)
			if pl.br_thirst > 100 then
				pl:PrintMessage(HUD_PRINTTALK, "You are not thirsty")
				return false
			end

			for k,v in pairs(pl.br_special_items) do
				if spi_comp(v, item) then
					table.RemoveByValue(pl.br_special_items, v)
					if istable(thirst) then
						for i=1, thirst[2] do
							table.ForceInsert(pl.br_special_items, {class = thirst[1]})
						end
					else
						pl:AddThirst(-thirst)
					end

					if pl.br_thirst > 70 then
						pl:PrintMessage(HUD_PRINTTALK, "You drank the "..name..", your thirst is quenched")
					elseif pl.br_thirst > 35 then
						pl:PrintMessage(HUD_PRINTTALK, "You drank the "..name..", but your thirst hasn't been fully quenched")
					else
						pl:PrintMessage(HUD_PRINTTALK, "You drank the "..name..", you still feel thirsty")
					end

					if string.find(class, "soda") then
						pl:EmitSound("breach2/soda.wav")
					else
						pl:EmitSound("breach2/drink.wav")
					end

					return true
				end
			end

			return true
		end,
		onstart = function(pl)
		end,
		drop = function(pl)
			local res, item = br2_special_item_drop(pl, class, name, "prop_physics", model)
		end
	})
end

local function add_alcohol(class, name, model, thirst)
	table.ForceInsert(BR2_SPECIAL_ITEMS, {
		class = class,
		name = name,
		func = function(pl)
			if #pl.br_special_items > 9 then
				pl:PrintMessage(HUD_PRINTTALK, "Your inventory is full!")
				return false
			end
			table.ForceInsert(pl.br_special_items, {class = class})
			return true
		end,
		use = function(pl, item)
			for k,v in pairs(pl.br_special_items) do
				if spi_comp(v, item) then
					table.RemoveByValue(pl.br_special_items, v)
					if istable(thirst) then
						for i=1, thirst[2] do
							table.ForceInsert(pl.br_special_items, {class = thirst[1]})
						end
					else
						pl:AddThirst(-thirst)
					end

					pl:AddSanity(30)
					pl:BR2_ShowNotification("You drank the "..name..", it tasted nice...")

					pl:StartCustomScreenEffects({
						colour = 1.7,
						blur1 = 0.2,
						blur2 = 0.8,
						blur3 = 0.01,
					}, 30)

					pl:EmitSound("breach2/drink.wav")

					return true
				end
			end

			return true
		end,
		onstart = function(pl)
		end,
		drop = function(pl)
			local res, item = br2_special_item_drop(pl, class, name, "prop_physics", model)
		end
	})
end

add_food("food_cookies", "Cookies", "models/foodnhouseholditems/cookies.mdl", 10, 3)
add_food("food_sandwich", "Sandwich", "models/foodnhouseholditems/sandwich.mdl", 20, 5)
add_food("food_burger", "Burger", "models/foodnhouseholditems/mcdburgerbox.mdl", 30, 10)
add_food("food_icecream", "Ice Cream", "models/foodnhouseholditems/icecream1.mdl", 15, 2)
add_food("food_frenchfries", "French Fries", "models/foodnhouseholditems/mcdfrenchfries.mdl", 10, 4)
add_food("food_chips", "Chips", "models/foodnhouseholditems/chipslays.mdl", 10, 2)
add_food("food_pizzaslice", "Pizza Slice", "models/foodnhouseholditems/pizzaslice.mdl", 5, 7)
add_food("food_pizza", "Pizza", "models/foodnhouseholditems/pizzab.mdl", {"food_pizzaslice", 8, "Pizza Slice", "models/foodnhouseholditems/pizzaslice.mdl"}, 40)

add_drink("drink_orange_juice", "Orange Juice", "models/foodnhouseholditems/juice.mdl", 20)
add_drink("drink_bottle_water", "Water Bottle", "models/props/cs_office/Water_bottle.mdl", 20)
add_drink("drink_popcan", "Can of Soda", "models/props_junk/PopCan01a.mdl", 20)

add_alcohol("drink_wine", "Wine", "models/foodnhouseholditems/wine_white3.mdl", 60)

local function add_ammo_box(class, name, model, ammo_type, ammo_amount)
	table.ForceInsert(BR2_SPECIAL_ITEMS, {
		class = class,
		name = name,
		ammo_info = {ammo_type, ammo_amount},
		func = function(pl)
			if #pl.br_special_items > 9 then
				pl:PrintMessage(HUD_PRINTTALK, "Your inventory is full!")
				return false
			end
			table.ForceInsert(pl.br_special_items, {class = class})
			return true
		end,
		use = function(pl, item)
			pl:SendLua('surface.PlaySound("breach2/UI/Pickups/UI_Pickup_Ammo_'..math.random(1,3)..'.ogg")')
			for k,v in pairs(pl.br_special_items) do
				if spi_comp(v, item) then
					table.RemoveByValue(pl.br_special_items, v)
				end
			end
			pl:GiveAmmo(ammo_amount, ammo_type, false)
		end,
		onstart = function(pl)
		end,
		drop = function(pl)
			local res, item = br2_special_item_drop(pl, class, name, "prop_physics", model)
		end
	})
end

add_ammo_box("ammo_smg30", "SMG Ammo Box", "models/Items/BoxMRounds.mdl", "SMG1", 30)
add_ammo_box("ammo_smg60", "SMG Ammo Box", "models/Items/BoxMRounds.mdl", "SMG1", 60)
add_ammo_box("ammo_smg90", "SMG Ammo Box", "models/Items/BoxMRounds.mdl", "SMG1", 90)

add_ammo_box("ammo_pistol16", "Pistol Ammo Box", "models/Items/357ammo.mdl", "Pistol", 16)
add_ammo_box("ammo_pistol32", "Pistol Ammo Box", "models/Items/357ammo.mdl", "Pistol", 32)
add_ammo_box("ammo_pistol64", "Pistol Ammo Box", "models/Items/357ammo.mdl", "Pistol", 64)
add_ammo_box("ammo_pistol128", "Pistol Ammo Box", "models/Items/357ammo.mdl", "Pistol", 128)

add_ammo_box("ammo_rifle30", "Rifle Ammo Box", "models/Items/BoxSRounds.mdl", "AR2", 30)
add_ammo_box("ammo_rifle60", "Rifle Ammo Box", "models/Items/BoxSRounds.mdl", "AR2", 60)
add_ammo_box("ammo_rifle90", "Rifle Ammo Box", "models/Items/BoxSRounds.mdl", "AR2", 90)
add_ammo_box("ammo_rifle120", "Rifle Ammo Box", "models/Items/BoxSRounds.mdl", "AR2", 120)

add_ammo_box("ammo_sniper5", "Sniper Ammo Box", "models/Items/BoxSRounds.mdl", "SniperPenetratedRound", 5)
add_ammo_box("ammo_sniper10", "Sniper Ammo Box", "models/Items/BoxSRounds.mdl", "SniperPenetratedRound", 10)
add_ammo_box("ammo_sniper20", "Sniper Ammo Box", "models/Items/BoxSRounds.mdl", "SniperPenetratedRound", 20)
add_ammo_box("ammo_sniper40", "Sniper Ammo Box", "models/Items/BoxSRounds.mdl", "SniperPenetratedRound", 40)

add_ammo_box("ammo_shotgun10", "Shotgun Ammo Box", "models/Items/BoxBuckshot.mdl", "Buckshot", 10)
add_ammo_box("ammo_shotgun20", "Shotgun Ammo Box", "models/Items/BoxBuckshot.mdl", "Buckshot", 20)
add_ammo_box("ammo_shotgun30", "Shotgun Ammo Box", "models/Items/BoxBuckshot.mdl", "Buckshot", 30)

print("[Breach2] server/sv_items.lua loaded!")