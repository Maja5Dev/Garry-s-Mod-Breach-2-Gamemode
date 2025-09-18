
SWEP.Base			= "br2_item_base"
SWEP.PrintName		= "Tactical Flashlight"
SWEP.Spawnable		= true
SWEP.AdminSpawnable	= true
SWEP.Slot			= 10
SWEP.SlotPos		= 0
SWEP.clevel			= 0
SWEP.Pickupable 	= true

SWEP.ViewModel		= "models/weapons/tfa_nmrih/v_item_maglite.mdl"
SWEP.WorldModel		= "models/weapons/tfa_nmrih/w_item_maglite.mdl"

function SWEP:GetBetterOne()
	if br_914status == SCP914_ROUGH then
		return "item_battery_9v"

	elseif br_914status == SCP914_1_1 or br_914status == SCP914_FINE then
		return "br2_item_flashlight_tactical"

	elseif br_914status == SCP914_VERY_FINE or br_914status == SCP914_COARSE then
		return "br2_item_flashlight_cheap"
	end
	
	return self
end
