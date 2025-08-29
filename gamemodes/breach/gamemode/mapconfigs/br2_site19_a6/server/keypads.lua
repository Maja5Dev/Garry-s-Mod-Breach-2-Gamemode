
YYYYYYYYYYYYYYYYYYYY = Vector(0,0,0)

function FindKeyPadByName(name)
	for i,v in ipairs(MAPCONFIG.KEYPADS) do
		if v.name == name then
			return i
		end
	end
end

MAPCONFIG.KEYPADS = {
	{
		name = "XXXXXXXXXXXXXXXXXXXXXX",
		pos = YYYYYYYYYYYYYYYYYYYY,
		level = 1,
		sounds = true
	},
}
