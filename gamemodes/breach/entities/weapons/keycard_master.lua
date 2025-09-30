
SWEP.Base			= "keycard_base"
SWEP.PrintName		= "MasteCard"
SWEP.Spawnable		= true
SWEP.AdminSpawnable	= true
SWEP.Category		= "Breach 2"
SWEP.clevel			= 0
SWEP.ViewModel		= "models/vodoroda/breach2/visa/v_visa.mdl"
SWEP.WorldModel		= "models/vodoroda/breach2/visa/w_visa.mdl"

function SWEP:GetBetterOne()
	local r = math.random(1,10)

	if br_914status == SCP914_ROUGH then
		return "coin"

	elseif br_914status == SCP914_COARSE then
		return table.Random({"keycard_master", "keycard_playing", "coin"})

	elseif br_914status == SCP914_FINE then
		if r < 3 then
			return "keycard_level2"
		else
			return "keycard_level1"
		end

	elseif br_914status == SCP914_VERY_FINE then
		if r < 10 then
			return "keycard_omni"
		else
			return table.Random({"keycard_master", "keycard_playing", "coin"})
		end
	end

	return self
end
