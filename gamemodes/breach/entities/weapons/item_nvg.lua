
SWEP.Base			= "item_nvg_base"
SWEP.PrintName		= "Green NVG"

function SWEP:GetBetterOne()
	if br_914status == SCP914_FINE then
		return "item_nvg2"

	elseif br_914status == SCP914_VERY_FINE then
		return table.Random({"item_nvg3", "item_nvg_military"})
	end

	return self
end
