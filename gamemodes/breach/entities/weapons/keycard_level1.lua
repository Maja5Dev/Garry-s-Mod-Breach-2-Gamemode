
SWEP.Base			= "keycard_base"
SWEP.PrintName		= "Keycard Level 1"
SWEP.Spawnable		= true
SWEP.AdminSpawnable	= true
SWEP.Category		= "Breach 2"
SWEP.clevel			= 1
--SWEP.ForceSkin 		= 6
SWEP.ForceSkin 		= 0

function SWEP:GetBetterOne()
	local r = math.random(1,100)
	if br_914status == 1 then
		return nil
	elseif br_914status == 2 then
		return table.Random({"keycard_master", "keycard_playing"})
	elseif br_914status == 3 then
		return "keycard_level1"
	elseif br_914status == 4 then
		if r < 6 then
			return table.Random({"keycard_master", "keycard_playing"})
		else
			return "keycard_level2"
		end
	elseif br_914status == 5 then
		if r < 6 then
			return "keycard_omni"
		else
			return table.Random({"keycard_master", "keycard_playing"})
		end
	end
	return nil
end
