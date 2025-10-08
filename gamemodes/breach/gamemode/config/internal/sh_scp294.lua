
BR2_SCP_294_OUTCOMES = {
	{
		texts = {"nothing", "emptiness", "air", "vacuum", "half life 3", "hl3", "halflife3", "tf2 update"},
		type = SCP294_RESULT_NOTHING,
		sound = nil,
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
			ply:UpdateHungerThirst()
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
			ply:AddThirst(-30)
			ply:UpdateHungerThirst()
			return true
		end
	},
	{
		texts = {"coffee"},
		type = SCP294_RESULT_NORMAL,
		sound = scp294_sound_ahh,
		func = function(ply, info, text) scp_294_func(ply, info, text) end,
		use = function(ply)
			ply:BR2_ShowNotification("Bitter.")
			ply:AddRunStamina(1000)
			return true
		end
	},
	{
		texts = {"scp-500", "scp500"},
		type = SCP294_RESULT_NORMAL,
		sound = scp294_sound_ahh,
		func = function(ply, info, text) scp_294_func(ply, info, text) end,
		use = function(ply)
			ply:UsedSCP500()
			return true
		end
	},

	{
		texts = {"void", "antimatter", "anti-matter", "atomic", "nuclear", "nuclear bomb", "nuclear fusion", "nuclear fission",
		"nuclear reaction", "nuke", "quarks", "gluons", "gluon plasma", "plasma", "something that will destroy scp-682",
		"something that destroys scp-682", "something to destroy scp-682"},
		type = SCP294_RESULT_INSANE,
		sound = nil,
		func = function(ply, info, text) scp_294_func(ply, info, text) end,
		use = function(ply)
			local effect = EffectData()
			effect:SetStart(ply:GetPos())
			effect:SetOrigin(ply:GetPos())
			effect:SetScale(400)
			effect:SetRadius(400)
			effect:SetMagnitude(0)
			effect:SetDamageType(DMG_BLAST)

			util.Effect("Explosion", effect, true, true)
			util.Effect("HelicopterMegaBomb", effect, true, true)

			ply:Kill()

			ply:SendLua("surface.PlaySound(\"breach2/nuke/nuke2.ogg\")")
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
		sound = nil,
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
			ply:AddHunger(-20)
			ply:BR2_ShowNotification("Nice...")

			ply:StartCustomScreenEffects({
				colour = 1.7,
				blur1 = 0.2,
				blur2 = 0.8,
				blur3 = 0.01,
			}, 30)

			ply:UpdateHungerThirst()
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
