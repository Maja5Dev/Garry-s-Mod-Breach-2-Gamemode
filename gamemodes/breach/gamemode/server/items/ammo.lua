
local function add_ammo_box(class, name, model, ammo_type, ammo_amount)
	special_item_system.AddItem({
		class = class,
		name = name,
		ammo_info = {ammo_type, ammo_amount},
		func = function(pl)
			table.ForceInsert(pl.br_special_items, {class = class})
			return true
		end,
		use = function(pl, item)
			pl:SendLua('surface.PlaySound("breach2/UI/Pickups/UI_Pickup_Ammo_'..math.random(1,3)..'.ogg")')
			pl:GiveAmmo(ammo_amount, ammo_type, false)
			return true
		end,
		onstart = function(pl)
		end,
		drop = function(pl)
			local res, item = br2_special_item_drop(pl, class, name, "prop_physics", model)
			return item
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
