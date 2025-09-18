
SWEP.Base			= "keycard_base"
SWEP.PrintName		= "Keycard Omni"
SWEP.Spawnable		= true
SWEP.AdminSpawnable	= true
SWEP.Category		= "Breach 2"
SWEP.clevel			= 6
--SWEP.ForceSkin 		= 11
SWEP.ForceSkin 		= 5

function SWEP:GetBetterOne()
	local r = math.random(1,2)
	
	if br_914status == SCP914_ROUGH then
		if r == 1 then
			return "keycard_master"
		else
			return "keycard_playing"
		end

	elseif br_914status == SCP914_COARSE then
		if r == 1 then
			return "keycard_level4"
		else
			return "keycard_level5"
		end

	elseif br_914status == SCP914_1_1 then
		return "keycard_level5"

	elseif br_914status == SCP914_FINE or br_914status == SCP914_VERY_FINE then
		return "keycard_omni"
	end

	return self
end
