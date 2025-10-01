
BR_ROLE_FIRST_TEXTS = {
    /*
    cont_spec = {
        "You are a Containment Specialist, trained to handle and recontain escaped SCP objects",
        "After an unexpected Chaos Insurgency attack the facility fell into chaos",
        "Some SCP objects broke containment and Class Ds are on the loose",
        "Your main focus will be securing breached SCPs and assisting security forces",
    },
    TODO */ 
    cont_spec = {
        "You are a Containment Specialist, trained to handle and recontain escaped SCP objects",
        "After an unexpected Chaos Insurgency attack the facility fell into chaos",
        "Some SCP objects broke containment and Class Ds are on the loose",
        "Your main goal right now is to escape, it is too dangerous here",
    },
	isd_agent = {
        "You are an agent from the Internal Security Department INVESTIGATING staff members",
        "After an unexpected Chaos Insurgency attack the facility fell into chaos",
        "Some SCP objects broke containment and Class Ds are on the loose",
        "Your main focus will be set on finding any CI spies responsible for the breach",
    },
    sd_officer = {
        "You are a guard from the Security Department HAVING THE FACILITY'S STAFF IN CHECK",
        "After an unexpected Chaos Insurgency attack the facility fell into chaos",
        "Some SCP objects broke containment and Class Ds are on the loose",
        "Find staff members and bring them to safety until the MTF comes",
    },
    janitor = {
        "You are just a janitor, one of many minor staff members in this foundation",
        "After an unexpected Chaos Insurgency attack the facility fell into chaos",
        "Some SCP objects broke containment and Class Ds are on the loose",
        "Work with guards and other staff members to achieve your goals",
    },
    engineer = {
        "You are an Engineer, one of many minor staff members in this foundation",
        "After an unexpected Chaos Insurgency attack the facility fell into chaos",
        "Some SCP objects broke containment and Class Ds are on the loose",
        "Work with guards and other staff members to achieve your goals",
    },
    doctor = {
        "You are a medical doctor, one of many minor staff members in this foundation",
        "After an unexpected Chaos Insurgency attack the facility fell into chaos",
        "Some SCP objects broke containment and Class Ds are on the loose",
        "Work with guards and other staff members to achieve your goals",
	},
	classd = {
        "After an unexpected Chaos Insurgency attack the facility fell into chaos",
        "You don't know who you really are and you don't remember your past",
        "Researchers used you as a guinea pig to test anomalous SCP objects",
        "Stay vigilant, do not trust others because anybody can be your potential enemy",
    },
    researcher = {
        "You are a researcher analyzing strange anomalous SCP objects",
        "After an unexpected Chaos Insurgency attack the facility fell into chaos",
        "Some SCP objects broke containment and Class Ds are on the loose",
        "Work with guards and other staff members to achieve your goals",
    },
    ci_soldier = {
        "You are a soldier from the Chaos Insurgency involved in the containment breach",
        "Your group brought this facility into real chaos, now its time to finish the job",
        "SCP objects, Class Ds, guards and researchers are your enemies, kill them",
        "Teamwork with other CI members will be CRUCIAL to win this fight",
    },
    ci_spy = {
        "You are a spy from the Chaos Insurgency involved in the containment breach",
        "Your group brought this facility into real chaos, but for you its not safe",
        "SCP objects, Class Ds, guards and researchers are your enemies",
        "Steal any valuable information or SCP objects you find in this place",
        "Teamwork with other CI members will be CRUCIAL to win this fight",
	},
    scp_049 = {
        "You are SCP-049, the Plague Doctor",
        "You are driven by an uncontrollable urge to 'cure' humans of a disease you perceive them to have",
        "You must find humans and 'cure' them by touching them, turning them into SCP-049-2",
        "Work with other SCPs to eliminate all humans in this facility",
    },
    scp_035 = {
        "You are SCP-035, the Possessive Mask",
        "When worn, you completely take over the mind and body of the host",
        "Your host body will slowly decay, but you may seek out new victims to possess",
        "Use deception and manipulation to trick humans into helping you",
        "Work with other SCPs to eliminate all humans in this facility",
    },
    scp_173 = {
        "You are SCP-173, the Sculpture",
        "You are a hostile and extremely dangerous entity",
        "You cannot move while being observed by any living creature",
        "Blinking or looking away even for a short time is enough for you to move",
        "You must kill all humans in this facility, work with other SCPs to achieve your goal",
    },

	-- DEATHMATCH
    dm_ci = {
		"You are a soldier from the Chaos Insurgency involved in the containment breach",
		"After a long fight with foundation's security, the facility is in your hands",
		"But the Mobile Task Forces were deployed and has entered the facility",
		"They are near the gates in the Entrance Zone, prepare yourselves",
		--"You can either go assault the Entrance Zone or defend the Heavy Containment Zone",
		"You can either go assault them or defend your positions and wait for them to attack",
		"Work with your teammates to achieve complete victory in capturing this facility"
    },
    dm_mtf = {
		"You are an operative in a Mobile Task Force group, fighting to retake this facility",
		"Spies from the Chaos Insurgency broke into our security systems starting the breach",
		"Multiple SCP objects broke free and plunged this facility into complete chaos",
		"These anomalous SCP objects and valuable information were stolen from us",
		"Our group of operatives is here to retake this facility from Chaos Insrugency",
		"Work with your teammates, kill any unathorized personnel and remember to stay vigilant"
    }
}

print("[Breach2] config/cl_firstrole.lua loaded!")