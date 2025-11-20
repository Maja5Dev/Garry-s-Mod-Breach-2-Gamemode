
BR2_WEAPON_SETS = {
    sd_officer = {
        main = {
            {"kanade_tfa_mp5k", "smg1", 60},
            {"kanade_tfa_mp5a5", "smg1", 60},
            {"kanade_tfa_mp7", "smg1", 80},
            {"kanade_tfa_ump45", "smg1", 50},
            {"kanade_tfa_p90", "smg1", 100},

            {"kanade_tfa_m1014", "buckshot", 21},
            {"kanade_tfa_m590", "buckshot", 27},
        },
        side = {
            {"kanade_tfa_beretta", "pistol", 30},
            {"kanade_tfa_glock", "pistol", 34},
            {"kanade_tfa_colt", "pistol", 16},
            {"kanade_tfa_cobra", "357", 12},
            {"kanade_tfa_makarov", "pistol", 16},
            {"kanade_tfa_fnp45", "pistol", 30},
        },
        additional = {
            "item_radio",
            "item_gasmask",
            "item_nvg",
        },
    },

    sd_officer_light = {
        side = {
            {"kanade_tfa_beretta", "pistol", 30},
            {"kanade_tfa_glock", "pistol", 34},
            {"kanade_tfa_colt", "pistol", 16},
            {"kanade_tfa_makarov", "pistol", 16},
            {"kanade_tfa_fnp45", "pistol", 30},
        },
        additional = {
            "item_radio",
            "item_gasmask",
        },
    },

    mtf_soldier = {
        main = {
            {"kanade_tfa_scarh", "ar2", 100},
            {"kanade_tfa_sg552", "ar2", 120},
            {"kanade_tfa_ak12", "ar2", 120},
            {"kanade_tfa_ak103", "ar2", 120},
            {"kanade_tfa_ar15", "ar2", 120},
            {"kanade_tfa_aug", "ar2", 120},
            {"kanade_tfa_cz805", "ar2", 120},
            {"kanade_tfa_f90mbr", "ar2", 140},
            {"kanade_tfa_famas", "ar2", 100},
            {"kanade_tfa_fnfal", "ar2", 100},
            {"kanade_tfa_g3", "ar2", 100},
            {"kanade_tfa_gry", "ar2", 160},
            {"kanade_tfa_hkg36c", "ar2", 120},
            {"kanade_tfa_l85a2", "ar2", 120},
            {"kanade_tfa_m4a1", "ar2", 120},
            {"kanade_tfa_scar", "ar2", 120},
            {"kanade_tfa_vhs", "ar2", 120},
            {"kanade_tfa_m16a4", "ar2", 100},
            {"kanade_tfa_krissv", "smg1", 150},

            {"kanade_tfa_m249", "ar2", 200},
            --{"kanade_tfa_tac338", "SniperPenetratedRound", 30},
            --{"kanade_tfa_m40a1", "SniperPenetratedRound", 30},
            --{"kanade_tfa_remington", "SniperPenetratedRound", 30},
        },
        side = {
            {"kanade_tfa_beretta", "pistol", 30},
            {"kanade_tfa_glock", "pistol", 34},
            {"kanade_tfa_colt", "pistol", 16},
            {"kanade_tfa_makarov", "pistol", 16},
            {"kanade_tfa_fnp45", "pistol", 30},
        },
        additional = {
            "item_radio",
            "item_nvg3",
            "item_gasmask",
        }
    }
}

print("[Breach2] config/sv_weapon_sets.lua loaded!")