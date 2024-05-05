if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Folded Sights"
ATTACHMENT.Description = { "Folded Sights" }
ATTACHMENT.Icon = "entities/kanade_att_fs.png"
ATTACHMENT.ShortName = "Folded Sights"

ATTACHMENT.WeaponTable = {
	["VElements"] = {
		["sights_folded"] = {
			["active"] = true
		},
	},
	["WElements"] = {
		["sights_folded"] = {
			["active"] = true
		},
	},
	["IronSightsPos"] = function(wep, val) return wep.IronSightsPos_Folded or val end,
	["IronSightsAng"] = function(wep, val) return wep.IronSightsAng_Folded or val end,
	["Secondary"] = {
		["IronFOV"] = function(wep, val) return wep.Secondary.IronFOV_RDS or val * 0.9 end
	},
	["IronSightTime"] = function(wep, val) return val * 1.075 end,
	["INS2_SightVElement"] = "sights_folded",
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
