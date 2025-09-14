
MAPCONFIG.RANDOM_ITEM_SPAWNS = {
	-- CAFETERIA PIZZAS
	{
		model = "models/foodnhouseholditems/pizzab.mdl",
		class = "prop_physics",
		num = 4,
		func = function(ent)
			ent.PrintName = "Pizza"
			ent.SI_Class = "food_pizza"
			ent:SetNWBool("isDropped", true)
		end,
		spawns = {
			{Vector(4319.086914, 5063.978027, -7254.765137), Angle(0.031, -145.213, 0.155)},
			{Vector(4020.191650, 5109.750000, -7254.706055), Angle(-0.000, -133.149, 0.017)},
			{Vector(4164.763184, 4898.237305, -7254.833008), Angle(0.023, 170.900, 0.101)},
			{Vector(4057.629883, 4569.835449, -7254.711426), Angle(0.042, 40.007, 0.086)},
			{Vector(3919.929199, 4739.228516, -7253.705566), Angle(0.029, -8.221, 0.044)},
			{Vector(3720.343750, 4641.251465, -7254.522461), Angle(0.012, 44.897, 0.032)},
			{Vector(3572.036865, 4832.205566, -7254.501953), Angle(-0.022, 98.474, -0.209)},
		}
	},
	-- ENTRANCE ZONE SANDWICHES
	{
		model = "models/foodnhouseholditems/sandwich.mdl",
		class = "prop_physics",
		num = 4,
		func = function(ent)
			ent.PrintName = "Sandwich"
			ent.SI_Class = "food_sandwich"
			ent:SetNWBool("isDropped", true)
		end,
		spawns = {
			{Vector(3062.2646484375, 6710.9829101563, -7131.5771484375), Angle(0.046427190303802, 4.2887182235718, -0.132080078125)},
			{Vector(3205.4077148438, 7045.623046875, -7131.6337890625), Angle(0.1003535464406, 3.2433845996857, -0.28546142578125)},
			{Vector(2870.6159667969, 5066.2705078125, -7131.3178710938), Angle(0.065728284418583, -170.8662109375, -0.18698120117188)},
			{Vector(2714.15625, 4882.05859375, -7131.34765625), Angle(-0.058457627892494, -20.586050033569, -0.17324829101563)},
			{Vector(1321.55078125, 6028.9184570313, -7263.5844726563), Angle(0.053200826048851, 105.1580657959, -0.15133666992188)},
			{Vector(3001.3200683594, 4131.1538085938, -7195.380859375), Angle(0.097366213798523, -31.312187194824, -0.2769775390625)},
			{Vector(3366.2822265625, 4129.609375, -7195.5869140625), Angle(0.055669311434031, -146.71459960938, -0.15835571289063)},
		}
	},
	-- CLASS D CELLS SANDWICHES
	{
		model = "models/foodnhouseholditems/sandwich.mdl",
		class = "prop_physics",
		num = 3,
		func = function(ent)
			ent.PrintName = "Sandwich"
			ent.SI_Class = "food_sandwich"
			ent:SetNWBool("isDropped", true)
		end,
		spawns = {
			{Vector(-2768.3801269531, 967.01586914063, -8029.5913085938), Angle(-0.024031346663833, -90.068496704102, -0.10519409179688)},
			{Vector(-2977.6726074219, 974.80725097656, -8029.6206054688), Angle(-0.035067088901997, -89.929817199707, -0.15350341796875)},
			{Vector(-3185.5656738281, 974.23303222656, -8029.62890625), Angle(-0.0055804629810154, -80.698287963867, 0.56055301427841)},
			{Vector(-3393.685546875, 977.47967529297, -8029.5673828125), Angle(-0.014820163138211, -92.242118835449, -0.06488037109375)},
			{Vector(-3603.2709960938, 970.19177246094, -8029.5834960938), Angle(-0.020974457263947, -95.415954589844, -0.091827392578125)},
			{Vector(-3808.71484375, 975.00006103516, -8029.6401367188), Angle(-0.0062039778567851, -86.653045654297, 0.62311089038849)},
			{Vector(-3812.4567871094, 141.73872375488, -8029.6015625), Angle(-0.0040620034560561, 82.816284179688, 0.40810704231262)},
			{Vector(-3602.8142089844, 144.93319702148, -8029.5903320313), Angle(-0.0034384659957141, 86.314819335938, 0.34565052390099)},
			{Vector(-3390.7170410156, 145.82926940918, -8029.6372070313), Angle(-0.041408278048038, 94.618171691895, -0.1812744140625)},
			{Vector(-3182.98828125, 142.16040039063, -8029.6005859375), Angle(-0.027533020824194, 87.024299621582, -0.12054443359375)},
			{Vector(-2975.1027832031, 145.78425598145, -8029.6259765625), Angle(-0.0054141990840435, 97.709754943848, 0.54386180639267)},
			{Vector(-2770.2111816406, 144.91813659668, -8029.6059570313), Angle(-0.0043152570724487, 98.716690063477, 0.43354049324989)},

		}
	},
	-- ENTRANCE ZONE CHIPS
	{
		model = "models/foodnhouseholditems/chipslays.mdl",
		class = "prop_physics",
		num = 2,
		func = function(ent)
			ent.PrintName = "Chips"
			ent.SI_Class = "food_chips"
			ent:SetNWBool("isDropped", true)
		end,
		spawns = {
			{Vector(3225.2387695313, 6284.046875, -7192.3999023438), Angle(3.6770217418671, -117.23414611816, -6.6022644042969)},
			{Vector(3260.9875488281, 6289.0463867188, -7192.3784179688), Angle(4.8197722434998, -67.776168823242, -5.8687438964844)},
			{Vector(3228.9565429688, 6198.197265625, -7211.9672851563), Angle(-11.916441917419, -93.264831542969, 179.92198181152)},
		}
	},
	-- ENTRANCE ZONE ICE CREAM
	{
		model = "models/foodnhouseholditems/icecream1.mdl",
		class = "prop_physics",
		num = 2,
		func = function(ent)
			ent.PrintName = "Ice Cream"
			ent.SI_Class = "food_icecream"
			ent:SetNWBool("isDropped", true)
		end,
		spawns = {
			{Vector(5344.4677734375, 4859.86328125, -7383.2573242188), Angle(0.096788689494133, 137.07141113281, -0.13229370117188)},
			{Vector(5401.0795898438, 4871.1274414063, -7383.2446289063), Angle(0.089246734976768, 52.613452911377, -0.12020874023438)},
			{Vector(4289.1420898438, 6054.5649414063, -7126.9711914063), Angle(0.079295799136162, 17.038520812988, -0.090484619140625)},

		}
	},
	-- LCZ COOKIES
	{
		model = "models/foodnhouseholditems/cookies.mdl",
		class = "prop_physics",
		num = 4,
		func = function(ent)
			ent.PrintName = "Cookies"
			ent.SI_Class = "food_cookies"
			ent:SetNWBool("isDropped", true)
		end,
		spawns = {
			{Vector(690.90045166016, 2143.3305664063, -8153.4809570313), Angle(3.1866059303284, -111.38830566406, -0.0101318359375)},
			{Vector(2069.609375, 141.7361907959, -8153.2607421875), Angle(3.355259180069, 152.98112487793, -0.01348876953125)},
			{Vector(-197.05084228516, -1185.6187744141, -8153.49609375), Angle(3.2756013870239, -139.1053314209, -0.012298583984375)},
			{Vector(-674.29193115234, -715.00103759766, -8153.4790039063), Angle(3.1800026893616, 91.352104187012, 0.011158929206431)},
			{Vector(844.55444335938, 960.29870605469, -8153.2153320313), Angle(3.1053788661957, -120.20670318604, -0.009796142578125)},
			{Vector(1766.05078125, -1758.3145751953, -8153.2509765625), Angle(3.2959153652191, 78.245620727539, -0.011627197265625)},
			{Vector(-1207.2318115234, 1344.6712646484, -8153.4985351563), Angle(3.2883803844452, -28.424966812134, -0.01251220703125)},

		}
	},
	-- LCZ BURGERS
	{
		model = "models/foodnhouseholditems/mcdburgerbox.mdl",
		class = "prop_physics",
		num = 4,
		func = function(ent)
			ent.PrintName = "Burger"
			ent.SI_Class = "food_burger"
			ent:SetNWBool("isDropped", true)
		end,
		spawns = {
			{Vector(1489.9365234375, 1879.0113525391, -8149.21484375), Angle(0.16990423202515, 102.28967285156, -0.28314208984375)},
			{Vector(1469.8525390625, 1843.0391845703, -8149.1772460938), Angle(0.20070298016071, -107.182762146, -0.1575927734375)},
			{Vector(1521.0784912109, 1842.201171875, -8149.1904296875), Angle(0.22310051321983, -93.194534301758, -0.1751708984375)},
			{Vector(251.66334533691, 306.57147216797, -8149.205078125), Angle(0.24799735844135, 79.691947937012, -0.19473266601563)},
			{Vector(296.70349121094, 307.47039794922, -8149.1791992188), Angle(0.20375902950764, 76.980529785156, -0.16000366210938)},
			{Vector(286.82186889648, 264.91046142578, -8149.1723632813), Angle(0.12369947135448, -82.982734680176, -0.20614624023438)},
			{Vector(936.51611328125, -818.60845947266, -8154.150390625), Angle(0.15571616590023, 15.124555587769, -0.122802734375)},
		}
	},
	-- LCZ FRIES
	{
		model = "models/foodnhouseholditems/mcdfrenchfries.mdl",
		class = "prop_physics",
		num = 4,
		func = function(ent)
			ent.PrintName = "French Fries"
			ent.SI_Class = "food_burger"
			ent:SetNWBool("isDropped", true)
		end,
		spawns = {
			{Vector(299.08532714844, 266.31448364258, -8150.8193359375), Angle(-0.1111789047718, -92.183204650879, 0.50142651796341)},
			{Vector(308.22406005859, 305.67242431641, -8150.732421875), Angle(-0.043574031442404, 85.538269042969, 0.38705387711525)},
			{Vector(239.80116271973, 310.94424438477, -8150.828125), Angle(-0.11810507625341, 73.781280517578, 0.51314526796341)},
			{Vector(1539.9366455078, 1838.7587890625, -8150.7353515625), Angle(-0.045593667775393, -90.589073181152, 0.39047110080719)},
			{Vector(1482.4725341797, 1834.8315429688, -8150.84765625), Angle(-0.13328123092651, -83.466758728027, 0.53881984949112)},
			{Vector(1502.8564453125, 1879.4675292969, -8150.8193359375), Angle(-0.11117921769619, 109.93608093262, 0.50142651796341)},
		}
	},
	-- EZ WINE
	{
		model = "models/foodnhouseholditems/wine_white3.mdl",
		class = "prop_physics",
		num = 4,
		func = function(ent)
			ent.PrintName = "Wine"
			ent.SI_Class = "drink_wine"
			ent:SetNWBool("isDropped", true)
		end,
		spawns = {
			{Vector(5492.0512695313, 7416.150390625, -7125.3247070313), Angle(0.76939427852631, -131.00733947754, -0.90164184570313)},
			{Vector(5436.5454101563, 7402.4072265625, -7125.361328125), Angle(-0.22953523695469, -162.50128173828, -1.2153930664063)},
			{Vector(5438.603515625, 7467.1362304688, -7125.359375), Angle(0.074326761066914, 177.94102478027, -1.4342041015625)},
			{Vector(5437.361328125, 7549.2465820313, -7125.3623046875), Angle(-0.34322342276573, -175.95532226563, -1.1461486816406)},
			{Vector(5431.1357421875, 7600.6318359375, -7125.3784179688), Angle(-0.97725009918213, 153.0993347168, -1.0690002441406)},
			{Vector(5541.7075195313, 7719.6166992188, -7117.5024414063), Angle(-62.499076843262, 77.367698669434, 90.034820556641)},

		}
	},
	-- JUICE
	{
		model = "models/foodnhouseholditems/juice.mdl",
		class = "prop_physics",
		num = 7,
		func = function(ent)
			ent.PrintName = "Orange Juice"
			ent.SI_Class = "drink_orange_juice"
			ent:SetNWBool("isDropped", true)
		end,
		spawns = {
			{Vector(4739.6806640625, 6128.5815429688, -7120.9233398438), Angle(0.29182636737823, -171.58836364746, -0.23629760742188)},
			{Vector(5233.3500976563, 4184.5590820313, -7116.6708984375), Angle(0.24597963690758, -96.983581542969, -0.26223754882813)},
			{Vector(2907.5639648438, 5159.673828125, -7120.720703125), Angle(0.68960869312286, 103.92523956299, -0.55831909179688)},
			{Vector(1398.0982666016, 6498.5297851563, -7253.0336914063), Angle(0.89382719993591, 111.83669281006, -0.72897338867188)},
			{Vector(1580.5434570313, -5.5364923477173, -8144.9321289063), Angle(0.3389707505703, -13.36853313446, -0.2744140625)},
			{Vector(475.95941162109, 325.80377197266, -8144.9682617188), Angle(0.52740967273712, -144.09883117676, -0.42697143554688)},
			{Vector(1520.0228271484, 1265.8507080078, -8144.9780273438), Angle(0.57690048217773, 141.21946716309, -0.46697998046875)},
			{Vector(-1309.2890625, -42.875091552734, -8401.0107421875), Angle(0.74499255418777, 79.1689453125, -0.60330200195313)},
			{Vector(583.94305419922, 789.67504882813, -7121.0063476563), Angle(0.72159677743912, 145.7202911377, -0.58419799804688)},
			{Vector(1622.5274658203, 3927.4987792969, -7120.9868164063), Angle(0.62037658691406, -7.3192100524902, -0.50225830078125)},
			{Vector(2042.5112304688, 5669.1435546875, -7120.9682617188), Angle(0.52535229921341, -64.816719055176, -0.42532348632813)},
		}
	},




	-- DOCUMENT: 106
	{
		model = "models/foodnhouseholditems/newspaper2.mdl",
		class = "prop_physics",
		num = 1,
		func = function(ent)
			local doc_class = "doc_scp106"
			for k,v in pairs(BR2_DOCUMENTS) do
				if v.class == doc_class then
					ent.PrintName = v.name
					ent.DocType = doc_class
					ent.SI_Class = "document"
					ent.CodeGroup = "HCZ"
					ent:SetNWBool("isDropped", true)
					return
				end
			end
		end,
		spawns = {
			{Vector(-2978.2912597656, 6993.5981445313, -7382.4912109375), Angle(0.29450824856758, 77.322723388672, 179.3779296875)},
			{Vector(-3033.4191894531, 6994.3334960938, -7382.4736328125), Angle(-0.65225809812546, 76.319007873535, 179.37301635742)},
			{Vector(-2686.0903320313, 6782.8432617188, -7386.4721679688), Angle(-2.0628435611725, -104.24255371094, 179.36346435547)},
		}
	},
	-- DOCUMENT: 106_2
	{
		model = "models/foodnhouseholditems/newspaper2.mdl",
		class = "prop_physics",
		num = 1,
		func = function(ent)
			local doc_class = "doc_scp106_2"
			for k,v in pairs(BR2_DOCUMENTS) do
				if v.class == doc_class then
					ent.PrintName = v.name
					ent.DocType = doc_class
					ent.SI_Class = "document"
					ent:SetNWBool("isDropped", true)
					return
				end
			end
		end,
		spawns = {
			{Vector(-3040.5356445313, 6772.5712890625, -7380.5161132813), Angle(-13.575881004333, 162.9241027832, -177.30181884766)},
			{Vector(-2987.2131347656, 6988.5688476563, -7362.5180664063), Angle(-3.1176354885101, 15.292394638062, 179.41479492188)},
			{Vector(-2772.8071289063, 6988.1025390625, -7393.1181640625), Angle(-1.2937476634979, 53.82209777832, 179.49684143066)},
		}
	},
	-- DOCUMENT: 008
	{
		model = "models/foodnhouseholditems/newspaper2.mdl",
		class = "prop_physics",
		num = 1,
		func = function(ent)
			local doc_class = "doc_scp008"
			for k,v in pairs(BR2_DOCUMENTS) do
				if v.class == doc_class then
					ent.PrintName = v.name
					ent.DocType = doc_class
					ent.SI_Class = "document"
					ent.CodeGroup = "HCZ"
					ent:SetNWBool("isDropped", true)
					return
				end
			end
		end,
		spawns = {
			{Vector(-1536.8991699219, 4640.5717773438, -7130.4819335938), Angle(-0.19586969912052, 56.31266784668, 179.37538146973)},
			{Vector(-1439.7067871094, 4638.193359375, -7130.4887695313), Angle(-2.4304232597351, -6.1592864990234, 179.35632324219)},
			{Vector(-1239.5860595703, 4653.0581054688, -7130.0180664063), Angle(0.98345738649368, -178.11396789551, -11.725250244141)},
			{Vector(-1331.6016845703, 4652.0786132813, -7138.4853515625), Angle(-0.026490556076169, 104.11347198486, 179.37626647949)},
			{Vector(-1351.5040283203, 4567.41796875, -7166.4858398438), Angle(-2.3863899707794, -147.95751953125, 179.38432312012)},
		}
	},
	-- DOCUMENT: 035
	{
		model = "models/foodnhouseholditems/newspaper2.mdl",
		class = "prop_physics",
		num = 1,
		func = function(ent)
			local doc_class = "doc_scp035"
			for k,v in pairs(BR2_DOCUMENTS) do
				if v.class == doc_class then
					ent.PrintName = v.name
					ent.DocType = doc_class
					ent.SI_Class = "document"
					ent.CodeGroup = "HCZ"
					ent:SetNWBool("isDropped", true)
					return
				end
			end
		end,
		spawns = {
			{Vector(573.11059570313, 824.46075439453, -7130.4775390625), Angle(-0.44342228770256, 10.437952041626, 179.37409973145)},
			{Vector(588.39898681641, 696.80926513672, -7130.4697265625), Angle(-1.6954348087311, -86.835838317871, 179.19261169434)},
			{Vector(589.24926757813, 915.22094726563, -7129.7919921875), Angle(-7.2225527763367, -55.117382049561, -171.36825561523)},
			{Vector(467.70120239258, 860.99188232422, -7166.4692382813), Angle(-0.90461230278015, 159.32029724121, 179.37170410156)},
			{Vector(585.56463623047, 793.66015625, -7130.4711914063), Angle(-0.79359078407288, -12.588726043701, 179.37228393555)},
		}
	},
	-- DOCUMENT: SKULL
	{
		model = "models/foodnhouseholditems/newspaper2.mdl",
		class = "prop_physics",
		num = 1,
		func = function(ent)
			local doc_class = "doc_scp1123"
			for k,v in pairs(BR2_DOCUMENTS) do
				if v.class == doc_class then
					ent.PrintName = v.name
					ent.DocType = doc_class
					ent.SI_Class = "document"
					ent.CodeGroup = "LCZ"
					ent:SetNWBool("isDropped", true)
					return
				end
			end
		end,
		spawns = {
			{Vector(-179.90303039551, -1769.2491455078, -8150.5024414063), Angle(-2.7388024330139, -150.65606689453, 179.38958740234)},
			{Vector(-206.26736450195, -1772.4134521484, -8130.4653320313), Angle(-0.77592289447784, -140.86358642578, 179.44297790527)},
			{Vector(-208.6008605957, -1766.5238037109, -8170.4130859375), Angle(-6.280996799469, 179.82827758789, 179.47256469727)},
			{Vector(-223.77925109863, -1636.8151855469, -8190.4721679688), Angle(-0.73945730924606, 42.426067352295, 179.37255859375)},
		}
	},
	-- DOCUMENT: NUKE
	{
		model = "models/foodnhouseholditems/newspaper2.mdl",
		class = "prop_physics",
		num = 1,
		func = function(ent)
			local doc_class = "doc_nuke"
			for k,v in pairs(BR2_DOCUMENTS) do
				if v.class == doc_class then
					ent.PrintName = v.name
					ent.DocType = doc_class
					ent.SI_Class = "document"
					ent.CodeGroup = "HCZ"
					ent:SetNWBool("isDropped", true)
					return
				end
			end
		end,
		spawns = {
			{Vector(3700.29296875, -304.84310913086, -7146.4780273438), Angle(-0.42280039191246, 177.81575012207, 179.37420654297)},
			{Vector(3695.0600585938, -276.55899047852, -7146.5004882813), Angle(-2.6713781356812, 111.62942504883, 179.35668945313)},
			{Vector(3699.5354003906, -255.1209564209, -7146.46484375), Angle(-1.1299335956573, 9.6547908782959, 179.37054443359)},
			{Vector(3707.2802734375, -221.60934448242, -7141.6162109375), Angle(-10.086313247681, -154.25022888184, -4.4231262207031)},
			{Vector(3748.9562988281, -524.96081542969, -7154.484375), Angle(-0.056748762726784, -174.37921142578, 179.3761138916)},
			{Vector(3813.6740722656, -620.94714355469, -7182.4868164063), Angle(0.04842197149992, 41.116600036621, 179.37666320801)},
			{Vector(3942.5715332031, -413.59365844727, -7146.2182617188), Angle(-67.704078674316, -1.2146337032318, 179.37030029297)}
		}
	},
	-- DOCUMENT: 966
	{
		model = "models/foodnhouseholditems/newspaper2.mdl",
		class = "prop_physics",
		num = 1,
		func = function(ent)
			local doc_class = "doc_scp966"
			for k,v in pairs(BR2_DOCUMENTS) do
				if v.class == doc_class then
					ent.PrintName = v.name
					ent.DocType = doc_class
					ent.SI_Class = "document"
					ent.CodeGroup = "HCZ"
					ent:SetNWBool("isDropped", true)
					return
				end
			end
		end,
		spawns = {
			{Vector(-638.92547607422, 4084.1984863281, -7166.5146484375), Angle(-2.9995527267456, 138.80792236328, 179.38957214355)},
			{Vector(-739.51885986328, 4021.1943359375, -7130.2451171875), Angle(-2.5925686359406, 45.40412902832, 179.39050292969)},
			{Vector(-685.13287353516, 4030.0053710938, -7130.2368164063), Angle(0.058227751404047, 29.777187347412, 179.37670898438)},
			{Vector(-701.85363769531, 4017.6103515625, -7130.2446289063), Angle(0.48233178257942, 7.4769458770752, 179.37893676758)},
		}
	},
	-- DOCUMENT: 079
	{
		model = "models/foodnhouseholditems/newspaper2.mdl",
		class = "prop_physics",
		num = 1,
		func = function(ent)
			local doc_class = "doc_scp079"
			for k,v in pairs(BR2_DOCUMENTS) do
				if v.class == doc_class then
					ent.PrintName = v.name
					ent.DocType = doc_class
					ent.SI_Class = "document"
					ent.CodeGroup = "HCZ"
					ent:SetNWBool("isDropped", true)
					return
				end
			end
		end,
		spawns = {
			{Vector(-4016.7788085938, 4905.068359375, -7266.7744140625), Angle(-0.072797760367393, 65.443016052246, 179.37602233887)},
			{Vector(-3879.4240722656, 4598.1811523438, -7286.4814453125), Angle(-0.22819148004055, -137.84449768066, 179.37521362305)},
			{Vector(-4068.5380859375, 4735.1147460938, -7274.27734375), Angle(-3.2628321647644, 105.15947723389, 179.38479614258)},
			{Vector(-4068.5380859375, 4735.1147460938, -7274.27734375), Angle(-3.2628321647644, 105.15947723389, 179.38479614258)},
		}
	},
	-- DOCUMENT: MTF
	{
		model = "models/foodnhouseholditems/newspaper2.mdl",
		class = "prop_physics",
		num = 1,
		func = function(ent)
			local doc_class = "doc_mtf"
			for k,v in pairs(BR2_DOCUMENTS) do
				if v.class == doc_class then
					ent.PrintName = v.name
					ent.DocType = doc_class
					ent.SI_Class = "document"
					ent.CodeGroup = "HCZ"
					ent:SetNWBool("isDropped", true)
					return
				end
			end
		end,
		spawns = {
			{Vector(3385.3581542969, 6651.634765625, -7126.5068359375), Angle(-2.8032224178314, -111.95458984375, 179.37100219727)},
			{Vector(3474.2309570313, 6641.5556640625, -7126.5385742188), Angle(-0.19547292590141, -89.191566467285, 179.46673583984)},
			{Vector(3398.8537597656, 6647.966796875, -7146.4921875), Angle(0.34367325901985, -155.70822143555, 179.37818908691)},
			{Vector(3473.0729980469, 6646.1206054688, -7146.48828125), Angle(0.15340375900269, -131.2467956543, 179.37719726563)},
		}
	},
	-- DOCUMENT: SECURITY CLASSES
	{
		model = "models/foodnhouseholditems/newspaper2.mdl",
		class = "prop_physics",
		num = 1,
		func = function(ent)
			local doc_class = "doc_sc"
			for k,v in pairs(BR2_DOCUMENTS) do
				if v.class == doc_class then
					ent.PrintName = v.name
					ent.DocType = doc_class
					ent.SI_Class = "document"
					ent.CodeGroup = "HCZ"
					ent:SetNWBool("isDropped", true)
					return
				end
			end
		end,
		spawns = {
			{Vector(4645.6049804688, 5720.4458007813, -7126.5029296875), Angle(-2.5643427371979, -77.419662475586, 178.89395141602)},
			{Vector(4731.4252929688, 5720.1049804688, -7126.2270507813), Angle(-1.4513174295425, -43.214694976807, 179.15475463867)},
			{Vector(4721.7348632813, 5720.25390625, -7146.2583007813), Angle(-2.3594362735748, 161.29905700684, 179.85725402832)},
			{Vector(4662.0502929688, 5728.1635742188, -7146.4985351563), Angle(-0.3630128800869, 80.10376739502, 179.38607788086)},
		}
	},
	-- DOCUMENT: SCP-049 1
	{
		model = "models/foodnhouseholditems/newspaper2.mdl",
		class = "prop_physics",
		num = 1,
		func = function(ent)
			local doc_class = "doc_scp049"
			for k,v in pairs(BR2_DOCUMENTS) do
				if v.class == doc_class then
					ent.PrintName = v.name
					ent.DocType = doc_class
					ent.SI_Class = "document"
					ent.CodeGroup = "HCZ"
					ent:SetNWBool("isDropped", true)
					return
				end
			end
		end,
		spawns = {
			{Vector(4389.5654296875, -6446.345703125, -8570.4765625), Angle(-0.50723785161972, 33.387722015381, 179.37376403809)},
			{Vector(4392.9765625, -6401.4013671875, -8570.4716796875), Angle(-0.78393930196762, 63.226497650146, 179.37232971191)},
			{Vector(4297.3735351563, -6290.9516601563, -8606.4833984375), Angle(-0.10666113346815, 86.689277648926, 179.37585449219)},
		}
	},
	-- DOCUMENT: SCP-049 2
	{
		model = "models/foodnhouseholditems/newspaper2.mdl",
		class = "prop_physics",
		num = 1,
		func = function(ent)
			local doc_class = "doc_scp049_chamber"
			for k,v in pairs(BR2_DOCUMENTS) do
				if v.class == doc_class then
					ent.PrintName = v.name
					ent.DocType = doc_class
					ent.SI_Class = "document"
					ent:SetNWBool("isDropped", true)
					return
				end
			end
		end,
		spawns = {
			{Vector(3919.9523925781, -6256.2534179688, -8586.4853515625), Angle(-0.0050932974554598, 64.301025390625, 179.37637329102)}, -- right bottom shelf
			{Vector(3913.6298828125, -6269.818359375, -8566.44140625), Angle(0.057810056954622, 6.3512043952942, 179.36880493164)}, -- right middle shelf
			{Vector(3915.3474121094, -6264.6499023438, -8546.46875), Angle(28.008750915527, -1.1841608285904, 179.39892578125)}, -- right top shelf
			{Vector(3949.7700195313, -6380.3149414063, -8606.490234375), Angle(131.1579284668, 0.15230146050453, 179.37718200684)} -- on the ground
		}
	},
	-- DOCUMENT: SCP-939
	{
		model = "models/foodnhouseholditems/newspaper2.mdl",
		class = "prop_physics",
		num = 1,
		func = function(ent)
			local doc_class = "doc_scp939"
			for k,v in pairs(BR2_DOCUMENTS) do
				if v.class == doc_class then
					ent.PrintName = v.name
					ent.DocType = doc_class
					ent.SI_Class = "document"
					ent.CodeGroup = "HCZ"
					ent:SetNWBool("isDropped", true)
					return
				end
			end
		end,
		spawns = {
			{Vector(6298.8876953125, -756.48962402344, -11550.50390625), Angle(-2.7419881820679, 41.163650512695, 179.35223388672)},
			{Vector(6196.6333007813, -777.12664794922, -11550.497070313), Angle(-2.6210789680481, 83.047668457031, 179.39465332031)},
			{Vector(6144.7548828125, -671.08569335938, -11550.471679688), Angle(-1.1875722408295, 20.026082992554, 179.36344909668)},
			{Vector(5955.1694335938, -919.94171142578, -11550.467773438), Angle(-1.6956156492233, 144.17141723633, 179.21873474121)},
			{Vector(6031.8798828125, -71.4638671875, -11550.477539063), Angle(-0.48098593950272, -159.1086730957, 179.37390136719)},
		}
	},
	-- DOCUMENT: SCP-500
	{
		model = "models/foodnhouseholditems/newspaper2.mdl",
		class = "prop_physics",
		num = 1,
		func = function(ent)
			local doc_class = "doc_scp500"
			for k,v in pairs(BR2_DOCUMENTS) do
				if v.class == doc_class then
					ent.PrintName = v.name
					ent.DocType = doc_class
					ent.SI_Class = "document"
					ent.CodeGroup = "LCZ"
					ent:SetNWBool("isDropped", true)
					return
				end
			end
		end,
		spawns = {
			{Vector(1146.8575439453, 1441.3095703125, -8166.5356445313), Angle(-3.3893620967865, 162.21983337402, 179.36318969727)},
			{Vector(1006.1469116211, 1388.4796142578, -8142.4819335938), Angle(-0.19898436963558, -107.01245880127, 179.37536621094)},
			{Vector(996.80194091797, 1505.6091308594, -8142.5161132813), Angle(-3.0000448226929, 87.509590148926, 179.35540771484)},
			{Vector(1332.6246337891, 1216.7569580078, -8142.509765625), Angle(-2.8724493980408, -115.20356750488, 179.35375976563)},
		}
	},
	-- DOCUMENT: SCP-372
	{
		model = "models/foodnhouseholditems/newspaper2.mdl",
		class = "prop_physics",
		num = 1,
		func = function(ent)
			local doc_class = "doc_scp372"
			for k,v in pairs(BR2_DOCUMENTS) do
				if v.class == doc_class then
					ent.PrintName = v.name
					ent.DocType = doc_class
					ent.SI_Class = "document"
					ent.CodeGroup = "LCZ"
					ent:SetNWBool("isDropped", true)
					return
				end
			end
		end,
		spawns = {
			{Vector(-2438.1962890625, -521.94537353516, -8154.4936523438), Angle(0.43576422333717, 86.043525695801, 179.37866210938)},
			{Vector(-2462.0356445313, -525.45373535156, -8154.5083007813), Angle(-2.8871400356293, 30.11576461792, 179.39891052246)},
			{Vector(-2503.4545898438, -527.79095458984, -8154.51953125), Angle(-3.0638284683228, -34.297367095947, 179.35765075684)},
			{Vector(-2451.3098144531, -526.59149169922, -8134.5009765625), Angle(-2.6815760135651, -82.314514160156, 179.3576965332)},
			{Vector(-2503.7321777344, -530.61596679688, -8134.4750976563), Angle(-0.56140059232712, -49.701622009277, 179.37348937988)},
		}
	},
	-- HCZ TUNNELS: KEYCARD 3
	{
		class = "keycard_level3",
		num = 1,
		func = function(ent)
			ent:SetNWBool("isDropped", true)
		end,
		spawns = {
			{Vector(6431.3779296875, -1098.9445800781, -11551.553710938), Angle(0.00033421281841584, -3.1920166015625, -1.0260925292969)},
			{Vector(6961.3896484375, -931.24353027344, -11551.5546875), Angle(-1.3517756997317e-05, -42.646011352539, 1.0512939691544)},
			{Vector(5853.58984375, -483.74172973633, -11551.569335938), Angle(-0.00040579427150078, -98.519165039063, -1.3326416015625)},
			{Vector(5866.3754882813, -1124.2507324219, -11551.53125), Angle(0.00013895949814469, 160.19486999512, 179.32852172852)},
			{Vector(6332.0590820313, -2221.2097167969, -11551.498046875), Angle(-0.30383861064911, -166.61083984375, 179.54977416992)},
		}
	},
	-- HCZ TUNNELS: NVG
	{
		class = "item_nvg_military",
		num = 1,
		func = function(ent)
			ent:SetNWBool("isDropped", true)
		end,
		spawns = {
			{Vector(6572.8110351563, 41.232147216797, -11551.583007813), Angle(0.41230404376984, 102.42942047119, -0.05609130859375)},
			{Vector(6619.8989257813, -23.003667831421, -11551.517578125), Angle(-0.70496904850006, 1.9448220729828, -0.068145751953125)},
			{Vector(6548.8803710938, 56.14075088501, -11551.581054688), Angle(-0.59813272953033, -120.10710144043, -0.274169921875)},
			{Vector(6581.2802734375, 10.089445114136, -11551.591796875), Angle(-1.6873323917389, -81.973945617676, 0.4512183368206)},
			{Vector(6616.4750976563, 58.893245697021, -11551.5859375), Angle(-0.16513639688492, 146.38380432129, -0.47122192382813)},
		}
	},
}
