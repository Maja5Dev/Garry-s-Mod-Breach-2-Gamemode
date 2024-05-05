
SWEP.Base			= "keycard_base"
SWEP.PrintName		= "Keycard Level 4"
SWEP.Spawnable		= true
SWEP.AdminSpawnable	= true
SWEP.Category		= "Breach 2"
SWEP.clevel			= 4
--SWEP.ForceSkin 		= 9
SWEP.ForceSkin 		= 3

function SWEP:GetBetterOne()
	local r = math.random(1,100)
	if br_914status == 1 then
		return table.Random({"keycard_master", "keycard_playing", "keycard_level1"})
	elseif br_914status == 2 then
		return "keycard_level2"
	elseif br_914status == 3 then
		return "keycard_level4"
	elseif br_914status == 4 then
		if r < 6 then
			return "keycard_level2"
		elseif r < 51 then
			return "keycard_level4"
		else
			return "keycard_level5"
		end
	elseif br_914status == 5 then
		if r < 10 then
			return "keycard_omni"
		else
			return table.Random({"keycard_master", "keycard_playing"})
		end
	end
	return nil
end
