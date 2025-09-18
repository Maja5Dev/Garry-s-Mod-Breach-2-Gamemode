
SWEP.Base			= "keycard_base"
SWEP.PrintName		= "Keycard Level 2"
SWEP.Spawnable		= true
SWEP.AdminSpawnable	= true
SWEP.Category		= "Breach 2"
SWEP.clevel			= 2
--SWEP.ForceSkin 		= 7
SWEP.ForceSkin 		= 1

function SWEP:GetBetterOne()
	local r = math.random(1,100)

	if br_914status == SCP914_ROUGH then
		return "coin"

	elseif br_914status == SCP914_COARSE then
		return table.Random({"keycard_master", "keycard_playing", "coin", "coin"})

	elseif br_914status == SCP914_1_1 then
		return "keycard_level2"

	elseif br_914status == SCP914_FINE then
		if r < 6 then
			return table.Random({"keycard_master", "keycard_playing"})
		elseif r < 30 then
			return "keycard_level2"
		else
			return "keycard_level3"
		end

	elseif br_914status == SCP914_VERY_FINE then
		if r < 6 then
			return "keycard_omni"

		elseif r < 25 then
			return "keycard_level3"
		else
			return table.Random({"keycard_master", "keycard_playing"})
		end
	end

	return self
end
