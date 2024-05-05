
SWEP.Base			= "keycard_base"
SWEP.PrintName		= "Keycard Level 3"
SWEP.Spawnable		= true
SWEP.AdminSpawnable	= true
SWEP.Category		= "Breach 2"
SWEP.clevel			= 3
--SWEP.ForceSkin 		= 8
SWEP.ForceSkin 		= 2

function SWEP:GetBetterOne()
	local r = math.random(1,100)
	if br_914status == 1 then
		return nil
	elseif br_914status == 2 then
		return table.Random({"keycard_master", "keycard_playing"})
	elseif br_914status == 3 then
		return "keycard_level3"
	elseif br_914status == 4 then
		if r < 6 then
			return "keycard_level1"
		elseif r < 51 then
			return "keycard_level3"
		else
			return "keycard_level4"
		end
	elseif br_914status == 5 then
		if r < 8 then
			return "keycard_omni"
		else
			return table.Random({"keycard_master", "keycard_playing"})
		end
	end
	return nil
end
