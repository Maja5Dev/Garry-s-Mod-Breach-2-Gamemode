
-- Not sure where this is used
sound.Add({
	name = "br2_horror_roaming",
	channel = CHAN_VOICE,
	volume = 1.0,
	level = 75,
	pitch = 100,
	sound = "breach2/horror/Horror0.ogg"
})

RADIO4SOUNDSHC = {
	{"chatter1", 39},
	{"chatter2", 72},
	{"chatter4", 12},
	{"franklin1", 8},
	{"franklin2", 13},
	{"franklin3", 12},
	{"franklin4", 19},
	{"ohgod", 25}
}

RADIO4SOUNDS = table.Copy(RADIO4SOUNDSHC)

function RESET_ONESHOT_AMBIENTS()
	for i=1, 109 do
		table.ForceInsert(ALL_ONESHOT_AMBIENTS, "breach2/oneshots/EN_ONESHOTS_"..i..".ogg")
	end
end

BR2_RANDOM_MUSIC = {
	{ sound = "breach2/music/random_music_low_2.mp3", length = 76.77, volume = 0.7 },
	{ sound = "breach2/music/random_music_low_4.mp3", length = 184.63, volume = 0.7 },
	{ sound = "breach2/music/random_music_low_7.mp3", length = 108, volume = 0.7 },
	{ sound = "breach2/music/random_music_low_8.mp3", length = 55, volume = 0.7 },
	{ sound = "breach2/music/random_music_low_9.mp3", length = 167, volume = 0.7 },
}

BR2_SANITY_MUSIC = {
	{ sound = "breach2/music/distance2.wav", length = 20, volume = 0.6 },
	{ sound = "breach2/music/withinsight.ogg", length = 60.44, volume = 0.6 },
	{ sound = "breach2/music/random_music_medium_1.mp3", length = 173, volume = 0.6 },
	{ sound = "breach2/music/random_music_medium_3.mp3", length = 185, volume = 0.6 },
	{ sound = "breach2/music/random_music_medium_5.mp3", length = 270, volume = 0.6 },
	{ sound = "breach2/music/random_music_medium_11.mp3", length = 251, volume = 0.6 },
}

local horror_sound_path = "breach2/horror/"
BR2_SCP173_FIRST_SEEN_SOUNDS = {
	{horror_sound_path.."Horror5.ogg", 3.9},
	{horror_sound_path.."Horror6.ogg", 5.21},
	{horror_sound_path.."Horror8.ogg", 6.4},
}

BR2_SCP173_FAR_SEEN_SOUNDS = {
	{horror_sound_path.."Horror0.ogg", 7.67},
	{horror_sound_path.."Horror3.ogg", 7.06},
	{horror_sound_path.."Horror4.ogg", 7.1},
	{horror_sound_path.."Horror10.ogg", 6},
	{horror_sound_path.."Horror5.ogg", 3.9},
}

BR2_CLOSE_SEEN_SOUNDS = {
	{horror_sound_path.."Horror1.ogg", 7.04},
	{horror_sound_path.."Horror2.ogg", 8.56},
	{horror_sound_path.."Horror9.ogg", 3.5},
	{horror_sound_path.."Horror14.ogg", 6.4},
}

-- How far away the ambient sounds play from
BR2_AMBIENT_POS_MIN = 300
BR2_AMBIENT_POS_MAX = 800

BR_DEFAULT_AMBIENT_GENERAL = {
	"breach2/ambient/general/Ambient1.ogg",
	"breach2/ambient/general/Ambient2.ogg",
	"breach2/ambient/general/Ambient3.ogg",
	"breach2/ambient/general/Ambient4.ogg",
	"breach2/ambient/general/Ambient5.ogg",
	"breach2/ambient/general/Ambient6.ogg",
	"breach2/ambient/general/Ambient7.ogg",
	"breach2/ambient/general/Ambient8.ogg",
	"breach2/ambient/general/Ambient9.ogg",
	"breach2/ambient/general/Ambient10.ogg",
	"breach2/ambient/general/Ambient11.ogg",
	"breach2/ambient/general/Ambient12.ogg",
	"breach2/ambient/general/Ambient13.ogg",
	"breach2/ambient/general/Ambient14.ogg",
	"breach2/ambient/general/Ambient15.ogg",
}

BR_DEFAULT_AMBIENT_LCZ = {
	"breach2/ambient/zone1/Ambient1.ogg",
	"breach2/ambient/zone1/Ambient2.ogg",
	"breach2/ambient/zone1/Ambient3.ogg",
	"breach2/ambient/zone1/Ambient4.ogg",
	"breach2/ambient/zone1/Ambient5.ogg",
	"breach2/ambient/zone1/Ambient6.ogg",
	"breach2/ambient/zone1/Ambient7.ogg",
	"breach2/ambient/zone1/Ambient8.ogg",
}

BR_DEFAULT_AMBIENT_HCZ = {
	"breach2/ambient/zone2/Ambient1.ogg",
	"breach2/ambient/zone2/Ambient2.ogg",
	"breach2/ambient/zone2/Ambient3.ogg",
	"breach2/ambient/zone2/Ambient4.ogg",
	"breach2/ambient/zone2/Ambient5.ogg",
	"breach2/ambient/zone2/Ambient6.ogg",
	"breach2/ambient/zone2/Ambient7.ogg",
	"breach2/ambient/zone2/Ambient8.ogg",
	"breach2/ambient/zone2/Ambient9.ogg",
	"breach2/ambient/zone2/Ambient10.ogg",
	"breach2/ambient/zone2/Ambient11.ogg",
}

BR_DEFAULT_AMBIENT_EZ = {
	"breach2/ambient/zone3/Ambient1.ogg",
	"breach2/ambient/zone3/Ambient2.ogg",
	"breach2/ambient/zone3/Ambient3.ogg",
	"breach2/ambient/zone3/Ambient4.ogg",
	"breach2/ambient/zone3/Ambient5.ogg",
	"breach2/ambient/zone3/Ambient6.ogg",
	"breach2/ambient/zone3/Ambient7.ogg",
	"breach2/ambient/zone3/Ambient8.ogg",
	"breach2/ambient/zone3/Ambient9.ogg",
	"breach2/ambient/zone3/Ambient10.ogg",
	"breach2/ambient/zone3/Ambient11.ogg",
	"breach2/ambient/zone3/Ambient12.ogg",
}

BR_DEFAULT_COMMOTION_SOUNDS = {
    "breach2/intro/Commotion/Commotion1.ogg",
    "breach2/intro/Commotion/Commotion2.ogg",
    "breach2/intro/Commotion/Commotion3.ogg",
    "breach2/intro/Commotion/Commotion4.ogg",
    "breach2/intro/Commotion/Commotion5.ogg",
    "breach2/intro/Commotion/Commotion6.ogg",
    "breach2/intro/Commotion/Commotion7.ogg",
    "breach2/intro/Commotion/Commotion8.ogg",
    "breach2/intro/Commotion/Commotion9.ogg",
    "breach2/intro/Commotion/Commotion10.ogg",
    "breach2/intro/Commotion/Commotion11.mp3",
    "breach2/intro/Commotion/Commotion12.ogg",
    "breach2/intro/Commotion/Commotion13.mp3",
    "breach2/intro/Commotion/Commotion14.mp3",
    "breach2/intro/Commotion/Commotion15.mp3",
    "breach2/intro/Commotion/Commotion16.ogg",
    "breach2/intro/Commotion/Commotion17.ogg",
    "breach2/intro/Commotion/Commotion18.ogg",
    "breach2/intro/Commotion/Commotion19.ogg",
    "breach2/intro/Commotion/Commotion20.ogg",
    "breach2/intro/Commotion/Commotion21.ogg",
    "breach2/intro/Commotion/Commotion22.mp3",
    "breach2/intro/Commotion/Commotion23.ogg",
    "breach2/intro/Bang2.ogg",
    "breach2/intro/Bang3.ogg",
}
