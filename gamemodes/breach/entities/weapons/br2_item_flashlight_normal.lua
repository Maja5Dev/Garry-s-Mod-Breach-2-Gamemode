
SWEP.Base			= "br2_item_base"
SWEP.PrintName		= "Breach 2 Heavy Duty Flashlight"
SWEP.Spawnable		= true
SWEP.AdminSpawnable	= true
SWEP.Slot			= 10
SWEP.SlotPos		= 0
SWEP.clevel			= 0
SWEP.Pickupable 	= true

SWEP.ViewModel		= "models/props_junk/cardboard_box004a.mdl"
SWEP.WorldModel		= "models/props_junk/cardboard_box004a.mdl"

function SWEP:GetBetterOne()
	if br_914status == 1 then
		return nil
	elseif br_914status == 3 then
		return "br2_item_flashlight_normal"
	elseif br_914status == 4 then
		return "br2_item_flashlight_tactical"
	elseif br_914status == 5 or br_914status == 2 then
		return "br2_item_flashlight_cheap"
	end
	return nil
end
