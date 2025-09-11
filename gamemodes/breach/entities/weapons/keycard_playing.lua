
SWEP.Base			= "keycard_base"
SWEP.PrintName		= "Playing Card"
SWEP.Spawnable		= true
SWEP.AdminSpawnable	= true
SWEP.Category		= "Breach 2"
SWEP.clevel			= 0
--SWEP.ForceSkin 		= 13
SWEP.ForceSkin 		= 19

function SWEP:GetBetterOne()
	local r = math.random(1,10)
	if br_914status == 3 then
		return "keycard_level1"
	elseif br_914status == 4 then
		if r == 1 then
			return "keycard_level2"
		else
			return "keycard_level1"
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
