/*
    -------------------------------------------Outlast/ Outlast Whistleblower ASL -------------------------------------------
                        Major credits to Gelly, AlexisDR and the main mods for stress testing
                        Original codes (isloading, xcord, ycord, zcord, incontrol) all found by MattMatt
                        Splitter and logical changes made by Kuno Demetries
                        End timing and 32bit implementation by Anti
                        Additional checkpoint settings by Anti and Alexis
                        Any problems contact aiden#2345
*/
state("OLGame", "Patch2, 64bit") {
  int isLoading: 0x01FFBCC8, 0x118; // Generic Loading string
  float xcoord: 0x02020F38, 0x278, 0x40, 0x454, 0x80;
  float zcoord: 0x2020F38, 0x278, 0x40, 0x454, 0x84;
  float ycoord: 0x2020F38, 0x278, 0x40, 0x454, 0x88;
  string100 map: 0x02006F00, 0x6F4, 0x40, 0xAB4, 0x80, 0x0; // Thanks to cheat mods for the game you can find current checkpoint
  int inControl: 0x02020F38, 0x248, 0x60, 0x30, 0x278, 0x54; // In control == 1
}

state("OLGame", "Patch2, 32bit") {
  int isLoading: "OLGame.exe", 0x017E5B30, 0xD8; // Generic Loading string
  float xcoord: "OLGame.exe", 0x017E7764, 0x1D4, 0x38C, 0x78, 0x4, 0x50;
  float zcoord: "OLGame.exe", 0x017E7764, 0x1D4, 0x38C, 0x78, 0x4, 0x54;
  float ycoord: "OLGame.exe", 0x017E7764, 0x1D4, 0x38C, 0x78, 0x4, 0x58;
  string100 map: "OLGame.exe", 0x0178C598, 0x7D4, 0x58, 0x0;
  int inControl: "OLGame.exe", 0x017E7764, 0x1D4, 0x38C, 0x1F4, 0x68, 0x60; // In control == 1
}

init {
  vars.doneMaps = new List < string > (); // Test to see if we split for a setting already
  vars.starter = 0; // Used for the starting check just so everything can just stay in Update
  vars.endsplit = 0; // Used to do the final split
  vars.OnceFinalSplit = 0; // After the game finishes the end split returns true so I added this to make it split once
  vars.mapcomparison = current.map; // For whatever reason map returns Null and livesplit likes to linger on it so this is the easiest fix without changing addresses for something minor
  vars.Checker1 = 0;
  vars.Checker2 = 0;

  // Checking the games memory size to determine version
  switch (modules.First().ModuleMemorySize) {
    case 35831808:
      version = "Patch2, 64bit";
      break;
    case 27406336:
      version = "Patch2, 32bit";
      break;
  }
}

startup {
  settings.Add("OL", true, "Outlast"); // Grouping all the Outlast splits together
  settings.Add("adminblock", true, "Admin Block", "OL"); // Each Chapter is related to one of these
  settings.Add("prisonblock", true, "Prison Block", "OL");
  settings.Add("sewers", true, "Sewers", "OL");
  settings.Add("maleward", true, "Male Ward", "OL");
  settings.Add("courtyard", true, "Courtyard", "OL");
  settings.Add("femaleward", true, "Female Ward", "OL");
  settings.Add("return", true, "Return to the Admin Block", "OL");
  settings.Add("lab", true, "Underground Lab", "OL");

  settings.Add("WB", true, "Whistleblower");
  settings.Add("hospital", true, "Hospital", "WB");
  settings.Add("rec", true, "Recreation Area", "WB");
  settings.Add("prision", true, "Prison", "WB");
  settings.Add("drying", true, "Drying Ground", "WB");
  settings.Add("vocation", true, "Vocational Block", "WB");
  settings.Add("exit", true, "Exit", "WB");
  //zeko's Code, basically works like how my dictionaries work for other ASLs just only one big dictionary and a definer at the bottom sorting it in a order that livesplit will read because of
  // C# 7.0 or whatever, really the order doesn't seem to matter lol as long as you sort it at the bottom
  var tB = (Func < string, string, string, Tuple < string, string, string >> )((elmt1, elmt2, elmt3) => {
    return Tuple.Create(elmt1, elmt2, elmt3);
  });
  var sB = new List < Tuple < string,
    string, string >> {
      tB("adminblock", "Admin_Garden", "Entering garden"),
      tB("adminblock", "Admin_Explosion", "Entering asylum window"),
      tB("adminblock", "Admin_Mezzanine", "Drop down from vent"),
      tB("adminblock", "Admin_MainHall", "After first cutscene"),
      tB("adminblock", "Admin_WheelChair", "Picked up keycard"),
      tB("adminblock", "Admin_SecurityRoom", "Power shuts off"),
      tB("adminblock", "Admin_Basement", "Entering basement"),
      tB("adminblock", "Admin_Electricity", "Power back on"),
      tB("adminblock", "Admin_PostBasement", "Leaving basement"),
      tB("prisonblock", "Prison_Start", "Prison start"),
      tB("prisonblock", "Prison_IsolationCells01_Mid", "Leaving cell"),
      tB("prisonblock", "Prison_ToPrisonFloor", "After first decontamination"),
      tB("prisonblock", "Prison_PrisonFloor_3rdFloor", "Down the drain"),
      tB("prisonblock", "Prison_PrisonFloor_SecurityRoom1", "Pressed first button"),
      tB("prisonblock", "Prison_PrisonFloor02_IsolationCells01", "After variant chase"),
      tB("prisonblock", "Prison_Showers_2ndFloor", "Entering showers 2nd floor"),
      tB("prisonblock", "Prison_PrisonFloor02_PostShowers", "Leaving showers 2nd floor"),
      tB("prisonblock", "Prison_PrisonFloor02_SecurityRoom2", "Pressed second button"),
      tB("prisonblock", "Prison_IsolationCells02_Soldier", "After Fire"),
      tB("prisonblock", "Prison_IsolationCells02_PostSoldier", "Escaped Chris"),
      tB("prisonblock", "Prison_OldCells_PreStruggle", "Before variant jumps onto you"),
      tB("prisonblock", "Prison_OldCells_PreStruggle2", "Before variant grabs you through bars"),
      tB("sewers", "Sewer_start", "Entering Sewers"),
      tB("sewers", "Sewer_FlushWater", "Before Flushing Water"),
      tB("sewers", "Sewer_WaterFlushed", "Turning 2nd valve"),
      tB("sewers", "Sewer_Ladder", "After climbing 2nd ladder"),
      tB("sewers", "Sewer_ToCitern", "After climbing down 3rd ladder"),
      tB("sewers", "Sewer_Citern1", "Before cistern"),
      tB("sewers", "Sewer_Citern2", "Before waterhops"),
      tB("sewers", "Sewer_PostCitern", "After escaping Chris"),
      tB("sewers", "Sewer_ToMaleWard", "After variant attack"),
      tB("maleward", "Male_Start", "Entering Male Ward"),
      tB("maleward", "Male_Chase", "Chase start"),
      tB("maleward", "Male_ChasePause", "Jumping the gap"),
      tB("maleward", "Male_Torture", "Trager cutscene start"),
      tB("maleward", "Male_TortureDone", "Trager cutscene end (lol)"),
      tB("maleward", "Male_surgeon", "Drop down from first vent after cutscene"),
      tB("maleward", "Male_GetTheKey", "Drop down from second vent after cutscene"),
      tB("maleward", "Male_GetTheKey2", "Found the key"),
      tB("maleward", "Male_Elevator", "Unlocked elevator"),
      tB("maleward", "Male_ElevatorDone", "Trager death"),
      tB("maleward", "Male_Priest", "Father Martin reunion"),
      tB("maleward", "Male_Cafeteria", "Entering cafeteria"),
      tB("maleward", "Male_SprinklerOff", "Sprinklers off"),
      tB("maleward", "Male_SprinklerOn", "Sprinklers turned on"),
      tB("courtyard", "Courtyard_Start", "Entering Courtyard"),
      tB("courtyard", "Courtyard_Corridor", "Unlocked corridor"),
      tB("courtyard", "Courtyard_Chapel", "Upper Courtyard"),
      tB("courtyard", "Courtyard_Soldier1", "Before first Chris encounter"),
      tB("courtyard", "Courtyard_Soldier2", "Before second Chris encounter (Do not use in Glitchless)"),
      tB("courtyard", "Courtyard_FemaleWard", "Escaped Chris"),
      tB("femaleward", "Female_Start", "Entering Female Ward"),
      tB("femaleward", "Female_Mainchute", "Passing Laundry chute"),
      tB("femaleward", "Female_2ndFloor", "Reaching 2nd floor"),
      tB("femaleward", "Female_2ndfloorChute", "Before fuses"),
      tB("femaleward", "Female_ChuteActivated", "After fuses"),
      tB("femaleward", "Female_Keypickedup", "Picked up key"),
      tB("femaleward", "Female_3rdFloor", "Reaching 3rd floor"),
      tB("femaleward", "Female_3rdFloorHole", "Before falling through floor"),
      tB("femaleward", "Female_3rdFloorPostHole", "Encountering the twins"),
      tB("femaleward", "Female_Tobigjump", "Before losing camera"),
      tB("femaleward", "Female_LostCam", "Lost camera"),
      tB("femaleward", "Female_FoundCam", "Pick up Camera"),
      tB("femaleward", "Female_Chasedone", "End of variant chase"),
      tB("femaleward", "Female_Exit", "Return to 3rd floor"),
      tB("femaleward", "Female_Jump", "Before big jump"),
      tB("return", "Revisit_Soldier1", "Entering Return to Admin"),
      tB("return", "Revisit_Mezzanine", "Dropping down from first vent"),
      tB("return", "Revisit_ToRH", "Before ladder"),
      tB("return", "Revisit_RH", "Entering theater"),
      tB("return", "Revisit_FoundKey", "Picked up key"),
      tB("return", "Revisit_To3rdfloor", "Leaving theater"),
      tB("return", "Revisit_3rdFloor", "Reaching 3rd floor"),
      tB("return", "Revisit_RoomCrack", "After slipping through crack in the wall"),
      tB("return", "Revisit_ToChapel", "Before entering chapel"),
      tB("return", "Revisit_PriestDead", "After Father Martin death"),
      tB("return", "Revisit_Soldier3", "Before second Chris encounter"),
      tB("return", "Revisit_ToLab", "After escaping Chris"),
      tB("lab", "Lab_Start", "Entering lab"),
      tB("lab", "Lab_PremierAirlock", "Lab front desk"),
      tB("lab", "Lab_SwarmIntro", "Bush skip checkpoint"),
      tB("lab", "Lab_SwarmIntro2", "Turnaround"),
      tB("lab", "Lab_Soldierdead", "After Chris dies"),
      tB("lab", "Lab_SpeachDone", "After Wernicke cutscene"),
      tB("lab", "Lab_SwarmCafeteria", "Before decontamination"),
      tB("lab", "Lab_EBlock", "After decontamination"),
      tB("lab", "Lab_ToBilly", "Big room"),
      tB("lab", "Lab_BigRoom", "Valve room"),
      tB("lab", "Lab_BigRoomDone", "After valve turn"),
      tB("lab", "Lab_BigTower", "Enter tall room"),
      tB("lab", "Lab_BigTowerMid", "After wires"),
      tB("lab", "Lab_BigTowerDone", "After Wallrider cutscene"),
      tB("hospital", "Hospital_1stFloor_ChaseStart", "First chase"),
      tB("hospital", "Hospital_1stFloor_ChaseEnd", "After first chase"),
      tB("hospital", "Hospital_1stFloor_dropairvent", "Drop from vent"),
      tB("hospital", "Hospital_1stFloor_SAS", "After alarm"),
      tB("hospital", "Hospital_1stFloor_Lobby", "Before Frank"),
      tB("hospital", "Hospital_1stFloor_NeedHandCuff", "Open door after Frank"),
      tB("hospital", "Hospital_1stFloor_GotKey", "Got handcuff key"),
      tB("hospital", "Hospital_1stFloor_Chase", "Leave room with key"),
      tB("hospital", "Hospital_1stFloor_Crema", "Unlocking handcuffs"),
      tB("hospital", "Hospital_1stFloor_Bake", "Inside oven"),
      tB("hospital", "Hospital_1stFloor_Crema2", "Outside oven"),
      tB("hospital", "Hospital_2ndFloor_Crema", "Reached 2nd floor"),
      tB("hospital", "Hospital_2ndFloor_Canibalrun", "Run from Frank"),
      tB("hospital", "Hospital_2ndFloor_Canibalgone", "Escaped Frank"),
      tB("hospital", "Hospital_2ndFloor_ExitIsLocked", "Find main valve"),
      tB("hospital", "Hospital_2ndFloor_RoomsCoorridor", "Hallway after jumpscare guy"),
      tB("hospital", "Hospital_2ndFloor_ToLab", "Run to laboratory"),
      tB("hospital", "Hospital_2ndFloor_Start_Lab_2nd", "Enter laboratory"),
      tB("hospital", "Hospital_2ndFloor_GazOff", "Turning Valve"),
      tB("hospital", "Hospital_2ndFloor_LabDone", "Exit laboratory"),
      tB("hospital", "Hospital_2ndFloor_Exit", "Exit Hospital"),
      tB("rec", "Courtyard1_Start", "Start of Rec Area"),
      tB("rec", "Courtyard1_RecreationArea", "Turnaround"),
      tB("rec", "Courtyard1_DupontIntro", "Top of 1st ladder"),
      tB("rec", "Courtyard1_Basketball", "In basketball area"),
      tB("rec", "Courtyard1_SecurityTower", "Top of 2nd ladder"),
      tB("prision", "PrisonRevisit_Start", "Start of Prison"),
      tB("prision", "PrisonRevisit_Radio", "After Jeremy cutscene"),
      tB("prision", "PrisonRevisit_Priest", "To Father Martin"),
      tB("prision", "PrisonRevisit_ToChase", "Down the drain"),
      tB("prision", "PrisonRevisit_Chase", "Chris chase"),
      tB("drying", "Courtyard2_Start", "Start of Drying Ground"),
      tB("drying", "Courtyard2_FrontBuilding2", "Run to lever"),
      tB("drying", "Courtyard2_ElecrticityOff", "1st interact with lever"),
      tB("drying", "Courtyard2_ElectricityOff_2", " 2nd interact with lever"),
      tB("drying", "Courtyard2_ToWaterTower", "Long Hallway"),
      tB("drying", "Courtyard2_WaterTower", "Inside water tower"),
      tB("drying", "Courtyard2_TopWaterTower", "Top water tower"),
      tB("vocation", "Building2_Start", "Start of Voc Block"),
      tB("vocation", "Building2_Attic_Mid", "Before push object"),
      tB("vocation", "Building2_Attic_Denis", "Varient chase"),
      tB("vocation", "Building2_Floor3_1", "Room with a lot of tables"),
      tB("vocation", "Building2_Floor3_2", "Meeting Eddie"),
      tB("vocation", "Building2_Floor3_3", "Escape Eddie"),
      tB("vocation", "Building2_Floor3_4", "Before push object 2nd time"),
      tB("vocation", "Building2_Floor3_Elevator", "After elevator cutscene"),
      tB("vocation", "Building2_Floor3_Post_Elevator", "Leave elevator"),
      tB("vocation", "Building2_Torture", "Before Eddie torture cutscene"),
      tB("vocation", "Building2_TortureDone", "After Eddie torture cutscene (lol)"),
      tB("vocation", "Building2_Garden", "Escaping Eddie"),
      tB("vocation", "Building2_Floor1_1", "Find key"),
      tB("vocation", "Building2_Floor1_2", "Enter gym"),
      tB("vocation", "Building2_Floor1_3", "When I was a boy"),
      tB("vocation", "Building2_Floor1_4", "Eddie behind you"),
      tB("vocation", "Building2_Floor1_5", "Drop from vent"),
      tB("vocation", "Building2_Floor1_5b", "Eddie punches you"),
      tB("vocation", "Building2_Floor1_6", "Eddie death cutscene"),
      tB("exit", "MaleRevisit_Start", "Start of Exit"),
      tB("exit", "AdminBlock_Start", "Long hallway"),
    };
  foreach(var s in sB) settings.Add(s.Item2, true, s.Item3, s.Item1);

  vars.onStart = (EventHandler)((s, e) => // thanks gelly for this, it's basically making sure it always clears the vars no matter how livesplit starts
    {
      vars.Checker1 = 0;
      vars.Checker2 = 0;
      vars.starter = 0; // Generic starting split
      vars.endsplit = 0; // generic end split
      vars.OnceFinalSplit = 0; // So it doesn't split more than once for the end split
      vars.doneMaps.Clear(); // Needed because checkpoints bad in game
      vars.doneMaps.Add(current.map.ToString()); // Adding for the starting map because it's also bad
    });
  // subsequently fixed issues with certain splits as well, so double bonus points
  timer.OnStart += vars.onStart;

  vars.onReset = (LiveSplit.Model.Input.EventHandlerT < LiveSplit.Model.TimerPhase > )((s, e) => {
    vars.doneMaps.Clear(); // Needed because checkpoints bad in game
    vars.OnceFinalSplit = 0; // So it doesn't split more than once for the end split
  });
  timer.OnReset += vars.onReset;

  if (timer.CurrentTimingMethod == TimingMethod.RealTime) // stolen from dude simulator 3, basically asks the runner to set their livesplit to game time
  {
    var timingMessage = MessageBox.Show(
      "This game uses Time without Loads (Game Time) as the main timing method.\n" +
      "LiveSplit is currently set to show Real Time (RTA).\n" +
      "Would you like to set the timing method to Game Time? This will make verification easier",
      "LiveSplit | Outlast / WB",
      MessageBoxButtons.YesNo, MessageBoxIcon.Question
    );

    if (timingMessage == DialogResult.Yes) {
      timer.CurrentTimingMethod = TimingMethod.GameTime;
    }
  }
}

update {
  vars.mapcomparison = current.map;

  // for outlast to be able to not have it endlessly start if you're resetting from the start of the game
  if ((current.isLoading == 1) && (current.map == "Admin_Gates") && (current.xcoord > -16422.93)) {
    vars.Checker1 = 1;
  }
  // for WB
  if ((vars.starter == 0) && (current.xcoord < 9550) && (current.map == "Hospital_Free") && (old.isLoading == 1)) {
    vars.Checker2 = 1;
  }
  // For outlast to end split
  if (Math.Abs(-4098.51 - current.ycoord) < 0.01 && (current.inControl == 0) && (vars.OnceFinalSplit != 1) && (current.map == "Lab_BigTowerDone")) {
    System.Threading.Thread.Sleep(50);
    vars.endsplit = 1;
  }
  // For whistleblower to end split
  if ((current.xcoord < -16380) && (current.inControl == 0) && (vars.OnceFinalSplit != 1) && (current.map == "AdminBlock_Start")) {
    vars.endsplit = 1;
  }
  // outlast starter, ik it doesn't work if you start from new game
  if ((vars.Checker1 == 1) && (current.xcoord > -16422.93) && (current.xcoord < -16200) && (current.inControl == 1)) {
    vars.starter = 1;
  }
  // For whistleblower starter
  if ((vars.Checker2 == 1) && (current.xcoord > 9550) && (current.inControl == 1)) {
    vars.starter = 1;
  }

  /*if ((vars.OnceFinalSplit != 1)) {
    print(current.ycoord.ToString());
  }*/
}

start {
  if (vars.starter == 1) {
    vars.starter = 0;
    vars.endsplit = 0;
    vars.OnceFinalSplit = 0;
    vars.Checker1 = 0;
    vars.Checker2 = 0;
    vars.doneMaps.Clear();
    vars.doneMaps.Add(current.map.ToString());
    return true;
  }
}

split {
  if ((settings[(vars.mapcomparison)]) && (!vars.doneMaps.Contains(vars.mapcomparison))) {
    vars.doneMaps.Add(vars.mapcomparison);
    return true;
  }

  if ((vars.endsplit == 1) && (vars.OnceFinalSplit == 0)) {
    vars.OnceFinalSplit = 1;
    return true;
  }
}

isLoading {
  return (current.isLoading == 1);
}

shutdown {
  timer.OnStart -= vars.onStart;
}
