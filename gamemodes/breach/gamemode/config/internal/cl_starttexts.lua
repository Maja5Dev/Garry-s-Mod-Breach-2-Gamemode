
local clr_big_text = Color(255,255,255,255)
local clr_small_text = Color(238,190,0,255)
local clr_highlight_text = Color(255,81,0,255)

BR_SCP_TEXT_TAB = {
    {"BR_TERMINAL_MAIN_TEXT", "1. SCP-173 (Light Containment Zone)", clr_highlight_text, true},
    {"BR_TERMINAL_MAIN_TEXT_SMALL", "   SCP-173 is a very dangerous object, it snaps the necks of humans who lose eye contact with it", clr_big_text, true},
    {"BR_TERMINAL_MAIN_TEXT_SMALL", "   The best way to avoid being killed is to stay in a group of at least 3 people", clr_big_text, true},
    {"BR_TERMINAL_MAIN_TEXT", "2. SCP-106 (Anywhere in the facility)", clr_highlight_text, true},
    {"BR_TERMINAL_MAIN_TEXT_SMALL", "   SCP-106 can move through solid matter and can appear anywhere in the facility", clr_big_text, true},
    {"BR_TERMINAL_MAIN_TEXT_SMALL", "   It attacks humans by dragging them into its so called Pocket Dimension", clr_big_text, true},
    {"BR_TERMINAL_MAIN_TEXT_SMALL", "   The best way to avoid being killed is to keep moving and run as soon as you spot it", clr_big_text, true},
    {"BR_TERMINAL_MAIN_TEXT", "3. SCP-457 (Heavy Containment Zone)", clr_highlight_text, true},
    {"BR_TERMINAL_MAIN_TEXT_SMALL", "   SCP-457 is a burning humanoid entity that attacks humans with its fire", clr_big_text, true},
    {"BR_TERMINAL_MAIN_TEXT_SMALL", "   Avoiding this SCP is usually hard, hiding from it is always a good idea", clr_big_text, true},
    {"BR_TERMINAL_MAIN_TEXT", "4. SCP-575 (Entrance Zone)", clr_highlight_text, true},
    {"BR_TERMINAL_MAIN_TEXT_SMALL", "   SCP-575 is an unknown form of matter that attacks any human in short range", clr_big_text, true},
    {"BR_TERMINAL_MAIN_TEXT_SMALL", "   The only way to avoid this SCP is to shine a flashlight on it", clr_big_text, true},
    {"BR_TERMINAL_MAIN_TEXT", "5. SCP-049 (Light Containment Zone)", clr_highlight_text, true},
    {"BR_TERMINAL_MAIN_TEXT_SMALL", "   SCP-049 is a hostile humanoid that believes all humans carry a disease", clr_big_text, true},
    {"BR_TERMINAL_MAIN_TEXT_SMALL", "   It is always ready to kill any human it sees in order to cure them afterwards", clr_big_text, true},
    {true, "BR_TERMINAL_MAIN_TEXT"}, -- break line
    {"BR_TERMINAL_MAIN_TEXT_SMALL", "These five are the main threats to players in this gamemode", clr_big_text, true},
    {"BR_TERMINAL_MAIN_TEXT_SMALL", "However, they are only a small fraction of the SCP objects present here", clr_big_text, true},
    {"BR_TERMINAL_MAIN_TEXT_SMALL", "Always stay vigilant and do not trust anything or anybody", clr_big_text, true},
}

BR_FAQ_TEXT_TAB = {
    {"BR_TERMINAL_MAIN_TEXT", "This gamemode has a lot of mechanics, systems, events, items and map interactions,", clr_big_text, true},
    {"BR_TERMINAL_MAIN_TEXT", "which can be overwhelming at times. Here is a list of frequently asked questions:", clr_big_text, true},
    {true, "BR_TERMINAL_MAIN_TEXT"}, -- break line
    {"BR_TERMINAL_MAIN_TEXT", "1. How do I pick up items, start SCP-914 or open terminals?", clr_highlight_text, true},
    {"BR_TERMINAL_MAIN_TEXT", " - While holding your hands, use the secondary attack to open the actions menu", clr_big_text, true},
    {"BR_TERMINAL_MAIN_TEXT", "2. Why did I randomly die in the LCZ?", clr_highlight_text, true},
    {"BR_TERMINAL_MAIN_TEXT", " - It was almost certainly SCP-173", clr_big_text, true},
    {"BR_TERMINAL_MAIN_TEXT", "3. Why can't I open the checkpoints?", clr_highlight_text, true},
    {"BR_TERMINAL_MAIN_TEXT", " - The LCZ has a lockdown system in the surveillance room", clr_big_text, true},
    {"BR_TERMINAL_MAIN_TEXT", " - The Entrance Zone can be locked down when SCP-008 is opened", clr_big_text, true},
    {"BR_TERMINAL_MAIN_TEXT", "4. Why am I dying from the cold outside?", clr_highlight_text, true},
    {"BR_TERMINAL_MAIN_TEXT", " - Find a warmer outfit in the facility, like a hazmat or a guard suit", clr_big_text, true},
    {"BR_TERMINAL_MAIN_TEXT", "5. Why are some models and textures errors?", clr_highlight_text, true},
    {"BR_TERMINAL_MAIN_TEXT", " - Check that all addons downloaded successfully and redownload the ones that didn't", clr_big_text, true},
    {"BR_TERMINAL_MAIN_TEXT", "6. Why does my game randomly crash while playing?", clr_highlight_text, true},
    {"BR_TERMINAL_MAIN_TEXT", " - Check that the sounds downloaded properly and watch the console for repeating errors", clr_big_text, true},
}

BR_KEYBINDS_TEXT_TAB = {
    {"BR_TERMINAL_MAIN_TEXT", "Menu Keybinds:", clr_big_text, true},
    {"BR_TERMINAL_MAIN_TEXT", "F1 (gm_showhelp) ", clr_highlight_text, false},
    {"BR_TERMINAL_MAIN_TEXT", "Gamemode Information", clr_big_text, true},
    {"BR_TERMINAL_MAIN_TEXT", "F2 (gm_showteam) ", clr_highlight_text, false},
    {"BR_TERMINAL_MAIN_TEXT", "Server Information", clr_big_text, true},
    {"BR_TERMINAL_MAIN_TEXT", "F3 (gm_showspare1) ", clr_highlight_text, false},
    {"BR_TERMINAL_MAIN_TEXT", "Help/Contact Information", clr_big_text, true},
    {"BR_TERMINAL_MAIN_TEXT", "F4 (gm_showspare2) ", clr_highlight_text, false},
    {"BR_TERMINAL_MAIN_TEXT", "Gamemode Tutorial", clr_big_text, true},
    {true, "BR_TERMINAL_MAIN_TEXT"},
    {"BR_TERMINAL_MAIN_TEXT", "Gameplay Keybinds:", clr_big_text, true},
    {"BR_TERMINAL_MAIN_TEXT", "E (+use) ", clr_small_text, false},
    {"BR_TERMINAL_MAIN_TEXT", "Interact with the highlighted button", clr_big_text, true},
    {"BR_TERMINAL_MAIN_TEXT", "Q (+menu) ", clr_small_text, false},
    {"BR_TERMINAL_MAIN_TEXT", "Drop the weapon you are holding", clr_big_text, true},
    {"BR_TERMINAL_MAIN_TEXT", "Mouse Wheel (invnext, invprev) ", clr_small_text, false},
    {"BR_TERMINAL_MAIN_TEXT", "Switch between your weapons", clr_big_text, true},
    {true, "BR_TERMINAL_MAIN_TEXT"},
    {"BR_TERMINAL_MAIN_TEXT", "Weapon Keybinds:", clr_big_text, true},
    {"BR_TERMINAL_MAIN_TEXT", "Mouse 1 (+attack) ", clr_small_text, false},
    {"BR_TERMINAL_MAIN_TEXT", "Primary attack", clr_big_text, true},
    {"BR_TERMINAL_MAIN_TEXT", "Mouse 2 (+attack2) ", clr_small_text, false},
    {"BR_TERMINAL_MAIN_TEXT", "Secondary attack", clr_big_text, true},
    {"BR_TERMINAL_MAIN_TEXT", "C (+menu_context) ", clr_small_text, false},
    {"BR_TERMINAL_MAIN_TEXT", "Weapon info and attachments", clr_big_text, true},
    {"BR_TERMINAL_MAIN_TEXT", "E + R (+use, +reload) ", clr_small_text, false},
    {"BR_TERMINAL_MAIN_TEXT", "Change the weapon's firing mode", clr_big_text, true},
}

BR_CONVARS_TEXT_TAB = {
    {"BR_TERMINAL_MAIN_TEXT", "ConVar: ", clr_big_text, false},
    {"BR_TERMINAL_MAIN_TEXT", "br2_cameras_go_around", clr_highlight_text, true},
    {"BR_TERMINAL_MAIN_TEXT_SMALL", " Default value: 0", clr_big_text, true},
    {"BR_TERMINAL_MAIN_TEXT_SMALL", " Let the camera list wrap around from the last camera back to the first one", clr_big_text, true},
    {true, "BR_TERMINAL_MAIN_TEXT"},
    {"BR_TERMINAL_MAIN_TEXT", "Command: ", clr_big_text, false},
    {"BR_TERMINAL_MAIN_TEXT", "br2_reset_chat", clr_highlight_text, true},
    {"BR_TERMINAL_MAIN_TEXT_SMALL", " Clears the chat", clr_big_text, true},
    {true, "BR_TERMINAL_MAIN_TEXT"},
    {"BR_TERMINAL_MAIN_TEXT", "Command: ", clr_big_text, false},
    {"BR_TERMINAL_MAIN_TEXT", "br2_reset_settings", clr_highlight_text, true},
    {"BR_TERMINAL_MAIN_TEXT_SMALL", " Resets every Breach 2 setting back to its default value", clr_big_text, true},
}

print("[Breach2] config/cl_starttexts.lua loaded!")
