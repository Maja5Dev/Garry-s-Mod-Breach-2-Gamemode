
SWEP.Base			= "keycard_base"
SWEP.PrintName		= "Keycard Level 5"
SWEP.Spawnable		= true
SWEP.AdminSpawnable	= true
SWEP.Category		= "Breach 2"
SWEP.clevel			= 5
--SWEP.ForceSkin 		= 10
SWEP.ForceSkin 		= 6

function SWEP:GetBetterOne()
	local r = math.random(1,2)

	if br_914status == SCP914_ROUGH then
		if r == 1 then
			return "keycard_master"
		else
			return "keycard_playing"
		end

	elseif br_914status == SCP914_COARSE then
		return "keycard_level4"

	elseif br_914status == SCP914_1_1 then
		if r == 1 then
			return "keycard_5"
		else
			return "keycard_omni"
		end

	elseif br_914status == SCP914_FINE or br_914status == SCP914_VERY_FINE then
		if r == 1 then
			return "keycard_omni"
		end
	end

	return self
end
