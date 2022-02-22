/*
 * ----------- Outlast/ Outlast Whistleblower ASL -----------
 * Credits to Gelly, AlexisDR, moderators for stress testing.
 * isLoading, x/y/z coords, inControl found by MattMatt.
 * Splitter and logical changes by Kuno Demetries.
 * End timing and 32-bit implementation by Anti.
 * Additional checkpoint settings by Anti and Alexis.
 * aiden#2345 on Discord
*/

state("OLGame", "Patch2, 64bit") {
  int       isLoading : 0x1FFBCC8, 0x118; // probably a bool; if so, should be changed to that.
  float     xcoord    : 0x2020F38, 0x278, 0x40, 0x454, 0x80;
  float     zcoord    : 0x2020F38, 0x278, 0x40, 0x454, 0x84;
  float     ycoord    : 0x2020F38, 0x278, 0x40, 0x454, 0x88;
  int       inControl : 0x2020F38, 0x248, 0x60, 0x30, 0x278, 0x54; // probably a bool; if so, should be changed to that.
  string100 map       : 0x2006F00, 0x6F4, 0x40, 0xAB4, 0x80, 0x0; // Thanks to cheat mods for the game you can find current checkpoint
}

state("OLGame", "Patch2, 32bit") {
  int       isLoading : 0x17E5B30, 0xD8;
  float     xcoord    : 0x17E7764, 0x1D4, 0x38C, 0x78, 0x4, 0x50;
  float     zcoord    : 0x17E7764, 0x1D4, 0x38C, 0x78, 0x4, 0x54;
  float     ycoord    : 0x17E7764, 0x1D4, 0x38C, 0x78, 0x4, 0x58;
  int       inControl : 0x17E7764, 0x1D4, 0x38C, 0x1F4, 0x68, 0x60; // In control == 1
  string100 map       : 0x178C598, 0x7D4, 0x58, 0x0;
}

startup {
  string[,] mySettings = {
    { null, "Outlast", "Outlast" },
      { "Outlast", "adminblock", "Admin Block" },
        { "adminblock", "Admin_Garden", "Entering garden" },
        { "adminblock", "Admin_Explosion", "Entering asylum window" },
        { "adminblock", "Admin_Mezzanine", "Drop down from vent" },
        { "adminblock", "Admin_MainHall", "After first cutscene" },
        { "adminblock", "Admin_WheelChair", "Picked up keycard" },
        { "adminblock", "Admin_SecurityRoom", "Power shuts off" },
        { "adminblock", "Admin_Basement", "Entering basement" },
        { "adminblock", "Admin_Electricity", "Power back on" },
        { "adminblock", "Admin_PostBasement", "Leaving basement" },

      { "Outlast", "prisonblock", "Prison Block" },
        { "prisonblock", "Prison_Start", "Prison start" },
        { "prisonblock", "Prison_IsolationCells01_Mid", "Leaving cell" },
        { "prisonblock", "Prison_ToPrisonFloor", "After first decontamination" },
        { "prisonblock", "Prison_PrisonFloor_3rdFloor", "Down the drain" },
        { "prisonblock", "Prison_PrisonFloor_SecurityRoom1", "Pressed first button" },
        { "prisonblock", "Prison_PrisonFloor02_IsolationCells01", "After variant chase" },
        { "prisonblock", "Prison_Showers_2ndFloor", "Entering showers 2nd floor" },
        { "prisonblock", "Prison_PrisonFloor02_PostShowers", "Leaving showers 2nd floor" },
        { "prisonblock", "Prison_PrisonFloor02_SecurityRoom2", "Pressed second button" },
        { "prisonblock", "Prison_IsolationCells02_Soldier", "After Fire" },
        { "prisonblock", "Prison_IsolationCells02_PostSoldier", "Escaped Chris" },
        { "prisonblock", "Prison_OldCells_PreStruggle", "Before variant jumps onto you" },
        { "prisonblock", "Prison_OldCells_PreStruggle2", "Before variant grabs you through bars" },

      { "Outlast", "sewers", "Sewers" },
        { "sewers", "Sewer_start", "Entering Sewers" },
        { "sewers", "Sewer_FlushWater", "Before Flushing Water" },
        { "sewers", "Sewer_WaterFlushed", "Turning 2nd valve" },
        { "sewers", "Sewer_Ladder", "After climbing 2nd ladder" },
        { "sewers", "Sewer_ToCitern", "After climbing down 3rd ladder" },
        { "sewers", "Sewer_Citern1", "Before cistern" },
        { "sewers", "Sewer_Citern2", "Before waterhops" },
        { "sewers", "Sewer_PostCitern", "After escaping Chris" },
        { "sewers", "Sewer_ToMaleWard", "After variant attack" },

      { "Outlast", "maleward", "Male Ward" },
        { "maleward", "Male_Start", "Entering Male Ward" },
        { "maleward", "Male_Chase", "Chase start" },
        { "maleward", "Male_ChasePause", "Jumping the gap" },
        { "maleward", "Male_Torture", "Trager cutscene start" },
        { "maleward", "Male_TortureDone", "Trager cutscene end" },
        { "maleward", "Male_surgeon", "Drop down from first vent after cutscene" },
        { "maleward", "Male_GetTheKey", "Drop down from second vent after cutscene" },
        { "maleward", "Male_GetTheKey2", "Found the key" },
        { "maleward", "Male_Elevator", "Unlocked elevator" },
        { "maleward", "Male_ElevatorDone", "Trager death" },
        { "maleward", "Male_Priest", "Father Martin reunion" },
        { "maleward", "Male_Cafeteria", "Entering cafeteria" },
        { "maleward", "Male_SprinklerOff", "Sprinklers off" },
        { "maleward", "Male_SprinklerOn", "Sprinklers turned on" },

      { "Outlast", "courtyard", "Courtyard" },
        { "courtyard", "Courtyard_Start", "Entering Courtyard" },
        { "courtyard", "Courtyard_Corridor", "Unlocked corridor" },
        { "courtyard", "Courtyard_Chapel", "Upper Courtyard" },
        { "courtyard", "Courtyard_Soldier1", "Before first Chris encounter" },
        { "courtyard", "Courtyard_Soldier2", "Before second Chris encounter (Do not use in Glitchless)" },
        { "courtyard", "Courtyard_FemaleWard", "Escaped Chris" },

      { "Outlast", "femaleward", "Female Ward" },
        { "femaleward", "Female_Start", "Entering Female Ward" },
        { "femaleward", "Female_Mainchute", "Passing Laundry chute" },
        { "femaleward", "Female_2ndFloor", "Reaching 2nd floor" },
        { "femaleward", "Female_2ndfloorChute", "Before fuses" },
        { "femaleward", "Female_ChuteActivated", "After fuses" },
        { "femaleward", "Female_Keypickedup", "Picked up key" },
        { "femaleward", "Female_3rdFloor", "Reaching 3rd floor" },
        { "femaleward", "Female_3rdFloorHole", "Before falling through floor" },
        { "femaleward", "Female_3rdFloorPostHole", "Encountering the twins" },
        { "femaleward", "Female_Tobigjump", "Before losing camera" },
        { "femaleward", "Female_LostCam", "Lost camera" },
        { "femaleward", "Female_FoundCam", "Pick up Camera" },
        { "femaleward", "Female_Chasedone", "End of variant chase" },
        { "femaleward", "Female_Exit", "Return to 3rd floor" },
        { "femaleward", "Female_Jump", "Before big jump" },

      { "Outlast", "return", "Return to the Admin Block" },
        { "return", "Revisit_Soldier1", "Entering Return to Admin" },
        { "return", "Revisit_Mezzanine", "Dropping down from first vent" },
        { "return", "Revisit_ToRH", "Before ladder" },
        { "return", "Revisit_RH", "Entering theater" },
        { "return", "Revisit_FoundKey", "Picked up key" },
        { "return", "Revisit_To3rdfloor", "Leaving theater" },
        { "return", "Revisit_3rdFloor", "Reaching 3rd floor" },
        { "return", "Revisit_RoomCrack", "After slipping through crack in the wall" },
        { "return", "Revisit_ToChapel", "Before entering chapel" },
        { "return", "Revisit_PriestDead", "After Father Martin death" },
        { "return", "Revisit_Soldier3", "Before second Chris encounter" },
        { "return", "Revisit_ToLab", "After escaping Chris" },

      { "Outlast", "lab", "Underground Lab" },
        { "lab", "Lab_Start", "Entering lab" },
        { "lab", "Lab_PremierAirlock", "Lab front desk" },
        { "lab", "Lab_SwarmIntro", "Bush skip checkpoint" },
        { "lab", "Lab_SwarmIntro2", "Turnaround" },
        { "lab", "Lab_Soldierdead", "After Chris dies" },
        { "lab", "Lab_SpeachDone", "After Wernicke cutscene" },
        { "lab", "Lab_SwarmCafeteria", "Before decontamination" },
        { "lab", "Lab_EBlock", "After decontamination" },
        { "lab", "Lab_ToBilly", "Big room" },
        { "lab", "Lab_BigRoom", "Valve room" },
        { "lab", "Lab_BigRoomDone", "After valve turn" },
        { "lab", "Lab_BigTower", "Enter tall room" },
        { "lab", "Lab_BigTowerMid", "After wires" },
        { "lab", "Lab_BigTowerDone", "After Wallrider cutscene" },

    { null, "Whistleblower", "Whistleblower" },
      { "Whistleblower", "hospital", "Hospital" },
        { "hospital", "Hospital_1stFloor_ChaseStart", "First chase" },
        { "hospital", "Hospital_1stFloor_ChaseEnd", "After first chase" },
        { "hospital", "Hospital_1stFloor_dropairvent", "Drop from vent" },
        { "hospital", "Hospital_1stFloor_SAS", "After alarm" },
        { "hospital", "Hospital_1stFloor_Lobby", "Before Frank" },
        { "hospital", "Hospital_1stFloor_NeedHandCuff", "Open door after Frank" },
        { "hospital", "Hospital_1stFloor_GotKey", "Got handcuff key" },
        { "hospital", "Hospital_1stFloor_Chase", "Leave room with key" },
        { "hospital", "Hospital_1stFloor_Crema", "Unlocking handcuffs" },
        { "hospital", "Hospital_1stFloor_Bake", "Inside oven" },
        { "hospital", "Hospital_1stFloor_Crema2", "Outside oven" },
        { "hospital", "Hospital_2ndFloor_Crema", "Reached 2nd floor" },
        { "hospital", "Hospital_2ndFloor_Canibalrun", "Run from Frank" },
        { "hospital", "Hospital_2ndFloor_Canibalgone", "Escaped Frank" },
        { "hospital", "Hospital_2ndFloor_ExitIsLocked", "Find main valve" },
        { "hospital", "Hospital_2ndFloor_RoomsCoorridor", "Hallway after jumpscare guy" },
        { "hospital", "Hospital_2ndFloor_ToLab", "Run to laboratory" },
        { "hospital", "Hospital_2ndFloor_Start_Lab_2nd", "Enter laboratory" },
        { "hospital", "Hospital_2ndFloor_GazOff", "Turning Valve" },
        { "hospital", "Hospital_2ndFloor_LabDone", "Exit laboratory" },
        { "hospital", "Hospital_2ndFloor_Exit", "Exit Hospital" },

      { "Whistleblower", "rec", "Recreation Area" },
        { "rec", "Courtyard1_Start", "Start of Rec Area" },
        { "rec", "Courtyard1_RecreationArea", "Turnaround" },
        { "rec", "Courtyard1_DupontIntro", "Top of 1st ladder" },
        { "rec", "Courtyard1_Basketball", "In basketball area" },
        { "rec", "Courtyard1_SecurityTower", "Top of 2nd ladder" },

      { "Whistleblower", "prison", "Prison" },
        { "prison", "PrisonRevisit_Start", "Start of Prison" },
        { "prison", "PrisonRevisit_Radio", "After Jeremy cutscene" },
        { "prison", "PrisonRevisit_Priest", "To Father Martin" },
        { "prison", "PrisonRevisit_ToChase", "Down the drain" },
        { "prison", "PrisonRevisit_Chase", "Chris chase" },

      { "Whistleblower", "drying", "Drying Ground" },
        { "drying", "Courtyard2_Start", "Start of Drying Ground" },
        { "drying", "Courtyard2_FrontBuilding2", "Run to lever" },
        { "drying", "Courtyard2_ElecrticityOff", "1st interact with lever" },
        { "drying", "Courtyard2_ElectricityOff_2", " 2nd interact with lever" },
        { "drying", "Courtyard2_ToWaterTower", "Long Hallway" },
        { "drying", "Courtyard2_WaterTower", "Inside water tower" },
        { "drying", "Courtyard2_TopWaterTower", "Top water tower" },

      { "Whistleblower", "vocation", "Vocational Block" },
        { "vocation", "Building2_Start", "Start of Voc Block" },
        { "vocation", "Building2_Attic_Mid", "Before push object" },
        { "vocation", "Building2_Attic_Denis", "Varient chase" },
        { "vocation", "Building2_Floor3_1", "Room with a lot of tables" },
        { "vocation", "Building2_Floor3_2", "Meeting Eddie" },
        { "vocation", "Building2_Floor3_3", "Escape Eddie" },
        { "vocation", "Building2_Floor3_4", "Before push object 2nd time" },
        { "vocation", "Building2_Floor3_Elevator", "After elevator cutscene" },
        { "vocation", "Building2_Floor3_Post_Elevator", "Leave elevator" },
        { "vocation", "Building2_Torture", "Before Eddie torture cutscene" },
        { "vocation", "Building2_TortureDone", "After Eddie torture cutscene" },
        { "vocation", "Building2_Garden", "Escaping Eddie" },
        { "vocation", "Building2_Floor1_1", "Find key" },
        { "vocation", "Building2_Floor1_2", "Enter gym" },
        { "vocation", "Building2_Floor1_3", "When I was a boy" },
        { "vocation", "Building2_Floor1_4", "Eddie behind you" },
        { "vocation", "Building2_Floor1_5", "Drop from vent" },
        { "vocation", "Building2_Floor1_5b", "Eddie punches you" },
        { "vocation", "Building2_Floor1_6", "Eddie death cutscene" },

      { "Whistleblower", "exit", "Exit" },
        { "exit", "MaleRevisit_Start", "Start of Exit" },
        { "exit", "AdminBlock_Start", "Long hallway" },
  };

  for (int i = 0; i < mySettings.GetLength(0); ++i)
    settings.Add(mySettings[i, 1], true, mySettings[i, 2], mySettings[i, 0]);

  if (timer.CurrentTimingMethod == TimingMethod.RealTime) {
    var mbox = MessageBox.Show(
      "Removing loads from Outlast (+ Whistleblower) requires comparing against Game Time.\nWould you like to switch to it?",
      "LiveSplit | Outlast (+ Whistleblower)",
      MessageBoxButtons.YesNo);

    if (mbox == DialogResult.Yes)
      timer.CurrentTimingMethod = TimingMethod.GameTime;
  }
}

init {
  vars.olCheck = false;
  vars.wbCheck = false;
  vars.canStart = false; // Used for the starting check just so everything can just stay in Update
  vars.endSplit = false; // Used to do the final split
  vars.didFinalSplit = false; // After the game finishes the end split returns true so I added this to make it split once
  vars.doneMaps = new List<string> { current.map }; // Test to see if we split for a setting already

  // Checking the games memory size to determine version
  switch (modules.First().ModuleMemorySize) {
    case 0x222C000: version = "Patch2, 64bit"; break;
    case 0x1A23000: version = "Patch2, 32bit"; break;
  }
}

onStart {
  vars.olCheck = false;
  vars.wbCheck = false;
  vars.canStart = false;
  vars.endSplit = false;
  vars.didFinalSplit = false;
  vars.doneMaps = new List<string> { current.map };
}

update {
  if (string.IsNullOrEmpty(current.map))
    current.map = old.map;

  // for outlast to be able to not have it endlessly start if you're resetting from the start of the game
  if (current.isLoading == 1 && current.map == "Admin_Gates" && current.xcoord < -16422.93)
    vars.olCheck = true;

  // for WB
  if (!vars.canStart && current.xcoord < 9544 && current.map == "Hospital_Free" && old.isLoading == 1)
    vars.wbCheck = true;

  // outlast starter, ik it doesn't work if you start from new game
  if (vars.olCheck && current.xcoord > -16422.93 && current.inControl == 1)
    vars.canStart = true;

  // For whistleblower starter
  if (vars.wbCheck && current.xcoord > 9543.71 && current.inControl == 1)
    vars.canStart = true;

  // For outlast to end split
  if (Math.Abs(-4098.51 - current.ycoord) < 0.01 && current.inControl == 0 && current.map == "Lab_BigTowerDone") {
    Thread.Sleep(50); // sleeping UI thread, shame on you
    vars.endSplit = true;
  }

  // For whistleblower to end split
  if ((Math.Abs(-550.00 - current.ycoord) < 0.01) && current.inControl == 0 && current.map == "AdminBlock_Start") {
    Thread.Sleep(100); // sleeping UI thread, shame on you
    vars.endSplit = true;
  }
}

start {
  return vars.canStart;
}

split {
  if (settings[current.map] && !vars.doneMaps.Contains(current.map)) {
    vars.doneMaps.Add(current.map);
    return true;
  }

  if (vars.endSplit && !vars.didFinalSplit) {
    vars.didFinalSplit = true;
    return true;
  }
}

isLoading {
  return current.isLoading == 1;
}
