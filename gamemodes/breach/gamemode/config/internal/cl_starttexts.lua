
local clr_big_text = Color(255,255,255,255)
local clr_small_text = Color(238,190,0,255)
local clr_highlight_text = Color(255,81,0,255)

BR_SCP_TEXT_TAB = {
    {"BR_TERMINAL_MAIN_TEXT", "1. SCP-173 (Light Containment Zone)", clr_highlight_text, true},
    {"BR_TERMINAL_MAIN_TEXT_SMALL", "   SCP-173 is a very dangerous object, it snaps necks of humans when they loose eye contact with it", clr_big_text, true},
    {"BR_TERMINAL_MAIN_TEXT_SMALL", "   Best way to avoid being killed is to stick in groups of at least 3 people", clr_big_text, true},
    {"BR_TERMINAL_MAIN_TEXT", "2. SCP-106 (Inside the facility)", clr_highlight_text, true},
    {"BR_TERMINAL_MAIN_TEXT_SMALL", "   SCP-106 can move through solid materials and can appear all around the facility", clr_big_text, true},
    {"BR_TERMINAL_MAIN_TEXT_SMALL", "   It attacks humans by trying to capture them to its so called Pocket Dimension", clr_big_text, true},
    {"BR_TERMINAL_MAIN_TEXT_SMALL", "   Best way to avoid being killed is to always move and run from this SCP when spotted", clr_big_text, true},
    {"BR_TERMINAL_MAIN_TEXT", "3. SCP-457 (Heavy Containment Zone)", clr_highlight_text, true},
    {"BR_TERMINAL_MAIN_TEXT_SMALL", "   SCP-457 is a burning humanoid entity that attacks humans with its fire", clr_big_text, true},
    {"BR_TERMINAL_MAIN_TEXT_SMALL", "   Avoiding this SCP is usually hard but hiding from it is always a good idea", clr_big_text, true},
    {"BR_TERMINAL_MAIN_TEXT", "4. SCP-575 (Entrance Zone)", clr_highlight_text, true},
    {"BR_TERMINAL_MAIN_TEXT_SMALL", "   SCP-575 is an unknown form of matter which attacks humans on while in short range", clr_big_text, true},
    {"BR_TERMINAL_MAIN_TEXT_SMALL", "   The only possible way of avoiding this SCP is to flash the flashlight on it", clr_big_text, true},
    {"BR_TERMINAL_MAIN_TEXT", "5. SCP-049 (Light Containment Zone)", clr_highlight_text, true},
    {"BR_TERMINAL_MAIN_TEXT_SMALL", "   SCP-049 is a hostile humanoid that thinks all normal humans have a disease", clr_big_text, true},
    {"BR_TERMINAL_MAIN_TEXT_SMALL", "   He is always ready to kill any human he sees to remove the disease later", clr_big_text, true},
    {true, "BR_TERMINAL_MAIN_TEXT"}, -- break line
    {"BR_TERMINAL_MAIN_TEXT_SMALL", "These five are the main enemies of players in this gamemode", clr_big_text, true},
    {"BR_TERMINAL_MAIN_TEXT_SMALL", "However they are a small fraction of SCP objects present here", clr_big_text, true},
    {"BR_TERMINAL_MAIN_TEXT_SMALL", "Always stay vigilant and don't trust anything or anybody", clr_big_text, true},
}

BR_FAQ_TEXT_TAB = {
    {"BR_TERMINAL_MAIN_TEXT", "This gamemode has a lot of mechanics, systems, events, items and map interactions", clr_big_text, true},
    {"BR_TERMINAL_MAIN_TEXT", "Which can be pretty overwhelming at times, here is a list of frequently asked questions:", clr_big_text, true},
    {true, "BR_TERMINAL_MAIN_TEXT"}, -- break line
    {"BR_TERMINAL_MAIN_TEXT", "1. How do I pickup items? / How do I start SCP-914? / How do I open terminals?", clr_highlight_text, true},
    {"BR_TERMINAL_MAIN_TEXT", " - When holding hands, use the secondary attack to open actions menu", clr_big_text, true},
    {"BR_TERMINAL_MAIN_TEXT", "2. Why did I randomly die in the LCZ?", clr_highlight_text, true},
    {"BR_TERMINAL_MAIN_TEXT", " - 99% it was SCP-173!", clr_big_text, true},
    {"BR_TERMINAL_MAIN_TEXT", "3. I can't open the checkpoints!", clr_highlight_text, true},
    {"BR_TERMINAL_MAIN_TEXT", " - LCZ has a lockdown system in the surveillance room", clr_big_text, true},
    {"BR_TERMINAL_MAIN_TEXT", " - Entrance Zone can be locked down when SCP-008 is opened", clr_big_text, true},
    {"BR_TERMINAL_MAIN_TEXT", "4. Im dying from the cold outside!", clr_highlight_text, true},
    {"BR_TERMINAL_MAIN_TEXT", " - Find a better outfit in the facility like a hazmat or a guard suit", clr_big_text, true},
    {"BR_TERMINAL_MAIN_TEXT", "5. Some models/textures are errors!", clr_highlight_text, true},
    {"BR_TERMINAL_MAIN_TEXT", " - Check if all addons were downloaded successfully and redownload the ones that didnt", clr_big_text, true},
    {"BR_TERMINAL_MAIN_TEXT", "6. My game is randomly crashing when playing", clr_highlight_text, true},
    {"BR_TERMINAL_MAIN_TEXT", " - Check if the sounds were downloaded properly / check the console for spamming errors", clr_big_text, true},
}

BR_KEYBINDS_TEXT_TAB = {
    {"BR_TERMINAL_MAIN_TEXT", "F1 (gm_showhelp) ", clr_highlight_text, false},
    {"BR_TERMINAL_MAIN_TEXT", "Gamemode Information", clr_big_text, true},
    {"BR_TERMINAL_MAIN_TEXT", "F2 (gm_showteam) ", clr_highlight_text, false},
    {"BR_TERMINAL_MAIN_TEXT", "Server Information", clr_big_text, true},
    {"BR_TERMINAL_MAIN_TEXT", "F3 (gm_showspare1) ", clr_highlight_text, false},
    {"BR_TERMINAL_MAIN_TEXT", "Help/Contact Information", clr_big_text, true},
    {"BR_TERMINAL_MAIN_TEXT", "F4 (gm_showspare2) ", clr_highlight_text, false},
    {"BR_TERMINAL_MAIN_TEXT", "Tutorials", clr_big_text, true},
    {true, "BR_TERMINAL_MAIN_TEXT"},
    {"BR_TERMINAL_MAIN_TEXT", "Weapon Keybinds:", clr_big_text, true},
    {"BR_TERMINAL_MAIN_TEXT", "Mouse 1 (+attack) ", clr_small_text, false},
    {"BR_TERMINAL_MAIN_TEXT", "Primary attack", clr_big_text, true},
    {"BR_TERMINAL_MAIN_TEXT", "Mouse 2 (+attack2) ", clr_small_text, false},
    {"BR_TERMINAL_MAIN_TEXT", "Secondary attack", clr_big_text, true},
    {"BR_TERMINAL_MAIN_TEXT", "C (+menu_context) ", clr_small_text, false},
    {"BR_TERMINAL_MAIN_TEXT", "Weapon info / Attachments", clr_big_text, true},
    {"BR_TERMINAL_MAIN_TEXT", "E + R (+use, +reload) ", clr_small_text, false},
    {"BR_TERMINAL_MAIN_TEXT", "Change weapon's firing modes", clr_big_text, true},
}

BR_CONVARS_TEXT_TAB = {
    {"BR_TERMINAL_MAIN_TEXT", "ConVar: ", clr_big_text, false},
    {"BR_TERMINAL_MAIN_TEXT", "br2_cameras_go_around", clr_highlight_text, true},
    {"BR_TERMINAL_MAIN_TEXT_SMALL", " Default value: 0", clr_big_text, true},
    {"BR_TERMINAL_MAIN_TEXT_SMALL", " Camera arrows can loop around", clr_big_text, true},
    {true, "BR_TERMINAL_MAIN_TEXT"},
    {"BR_TERMINAL_MAIN_TEXT", "Command: ", clr_big_text, false},
    {"BR_TERMINAL_MAIN_TEXT", "br2_reset_chat", clr_highlight_text, true},
    {"BR_TERMINAL_MAIN_TEXT_SMALL", " Cleans the chat", clr_big_text, true},
}

print("[Breach2] config/cl_starttexts.lua loaded!")