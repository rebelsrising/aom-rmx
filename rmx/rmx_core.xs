/*
** RM X Framework
** RebelsRising
** Last edit: 24/09/2021
**
** The purpose of the RM X framework is to serve as the ultimate random map scripting library for competitive Age of Mythology maps.
**
** The following components are included:
** - Enhanced fair location generation
** - Similar location algorithm to generate a set of locations that allows for the atomic placement of an object for all players
** - Placement checking: Verify that your objects were successfully placed to avoid players playing faulty maps
** - Mirroring functionality for objects and areas (forests, cliffs, ponds, ...) for 1v1 and team games (!) with equal teams
** - Observer mode: A variety of informative observer commands are available (AoT only)
** - Additional observers: If more than 2 teams are present, the last team will not get placed and observe the game instead;
**   this is particularily useful for AoM/AoT where recorded games with more than a single observer can get corrupted
** - Merge mode: If two players have the exact same name, they can play as a single player (after saving/restoring the game)
** - A variety of other useful functions and shortcuts for random map generation
**
** Note that any map that you build on the commands of this framework will automatically come with support for observer and merge mode.
**
** ----- Minimal Setup -----
**
** The very least you have to do to make your map compatible with this framework are the following things:
** 1. Include rmx.xs in your random map script
** 2. Call rmxInit("Your Map Name") at the beginning of your script
** 3. Initialize the map via initializeMap("YourMapTerrain", xDimInMeters, zDimInMeters);
** 4. Place the players using the provided functions (e.g., placePlayersInCircle())
** 5. Replace cNumberPlayers, cNumberNonGaiaPlayers and cNumberTeams with cPlayers, cNonGaiaPlayers and cTeams
** 6. Use the provided fair location functionality (check one of the maps included for an example)
** 7. Use the provided placement functions for object placement, e.g., placeObjectAtPlayerLocs() or placeObjectInPlayerSplits()
** 8. Call rmxFinalize() at the end of your map script to inject observer/merge triggers.
**
** I'm aware that if you're not familiar with random map scripting, it may be rather confusing to use all of this.
** However, if you spend some time into looking at my map scripts or the documentation of the function signatures,
** most of the concepts should become clearer.
**
** ----- Credits -----
**
** Major:
** - To SlySherZ for a great data structure for random area generation and simple placement concepts
** - To Loggy for a very nice way for storing and updating tech states for observer mode
**
** Minor:
** - To whoever figured out that it is possible to inject custom triggers
** - Fophuxake for the ideas regarding map reveal and displaying all stats for observers
** - Some random Reddit post about how "restoring a game with same name will merge the players" (which resulted in the merge mode in this framework)
**
** Special:
** - GrandMonster for helping me test weird/random stuff so often and always listening to me complain about the million things that didn't work
*/

/***********
* SETTINGS *
***********/

// Platform options.
extern const int cVersionVanilla = 0;
extern const int cVersionAoT = 1;
extern const int cVersionEE = 2;

// Debug modes.
extern const int cDebugNone = 0;
extern const int cDebugCompetitive = 1;
extern const int cDebugTest = 2;
extern const int cDebugFull = 3;

// This determines the active platform.
extern const int cVersion = cVersionAoT;

// Debugging, set to cDebugNone or cDebugCompetitive for release.
extern const int cDebugMode = cDebugCompetitive;

// Name of the patch displayed in the initial message.
extern const string cPatch = "Voobly Balance Patch 5.0";

// Patch info message displayed below the patch string if set.
extern const string cPatchInfo = "";

// Set to false if running on AoT, but without VBP.
extern const bool cVBPEnabled = true;

/*********
* GLOBAL *
*********/

/*
 * Usage:
 * Whenever you use a regular random map function to place something for a specific player, make sure you use getPlayer(i) instead of i.
 * To iterate over playing players, use 1 < cPlayers or 1 <= cNonGaiaPlayers.
 * To iterate over the players that were merged, use cPlayers < cPlayersMerged.
 * To iterate over additional observers (e.g., to subtract resources), use cPlayersMerged < cNumberPlayers.
 * To iterate over regular observers, use cNumberPlayers < cPlayersObs.
 * To iterate over all observers (regular & additional), use cPlayers < cPlayersObs.
*/

extern int cTeams = 0; // Actual number of playing teams.
extern int cNonGaiaPlayers = 0; // Actual number of playing players.
extern int cPlayers = 0; // Actual number of playing players + 1.
extern int cPlayersMerged = 0; // Actual number of playing players, including the merged players, + 1. Used mostly for triggers regarding observers.
extern int cPlayersObs = 0; // Number of players and observers (regular and additional) + 1.

// Constants.
// Atlantean and Chinese gods IDs for vanilla/titans compatibility (so we can avoid using cCivGaia etc).
extern const int cCivKronosID = 9;
extern const int cCivOranosID = 10;
extern const int cCivGaiaID = 11;
extern const int cCivFuxiID = 12;
extern const int cCivNuwaID = 13;
extern const int cCivShennongID = 14;

extern const int cCultureAtlanteanID = 3;
extern const int cCultureChineseID = 4;

// Mirror type.
extern const int cMirrorNone = -1;
extern const int cMirrorPoint = 0;
extern const int cMirrorAxisX = 1;
extern const int cMirrorAxisZ = 2;
extern const int cMirrorAxisH = 3; // Horizontally.
extern const int cMirrorAxisV = 4; // Vertically.

// Player position within team.
extern const int cNumTeamPos = 4;
extern const int cPosSingle = 0;
extern const int cPosLast = 1;
extern const int cPosFirst = 2;
extern const int cPosCenter = 3;

// Messages.
extern const string cInfoLine = "##################################################";

// Colors.
extern const string cColorRed = "<color=1.0,0.2,0.2>";
extern const string cColorWhite = "<color=1.0,1.0,1.0>";
extern const string cColorChat = "<color=0.906,0.778,0.157>";
extern const string cColorOff = "</color>";

/*********
* ARRAYS *
*********/

// Players start from 1 by convention (0 = Mother Nature).
int player1 = 1; int player2  = 2;  int player3  = 3;  int player4  = 4;
int player5 = 5; int player6  = 6;  int player7  = 7;  int player8  = 8;
int player9 = 9; int player10 = 10; int player11 = 11; int player12 = 12;

int getPlayer(int i = 0) {
	if(i == 1) return(player1); if(i == 2)  return(player2);  if(i == 3)  return(player3);  if(i == 4)  return(player4);
	if(i == 5) return(player5); if(i == 6)  return(player6);  if(i == 7)  return(player7);  if(i == 8)  return(player8);
	if(i == 9) return(player9); if(i == 10) return(player10); if(i == 11) return(player11); if(i == 12) return(player12);
	return(0);
}

void setPlayer(int i = 0, int id = 0) {
	if(i == 1) player1 = id; if(i == 2)  player2  = id; if(i == 3)  player3  = id; if(i == 4)  player4  = id;
	if(i == 5) player5 = id; if(i == 6)  player6  = id; if(i == 7)  player7  = id; if(i == 8)  player8  = id;
	if(i == 9) player9 = id; if(i == 10) player10 = id; if(i == 11) player11 = id; if(i == 12) player12 = id;
}

// Teams start from 0 by convention.
int numberPlayersOnTeam0 = 0; int numberPlayersOnTeam1 = 0; int numberPlayersOnTeam2  = 0; int numberPlayersOnTeam3  = 0;
int numberPlayersOnTeam4 = 0; int numberPlayersOnTeam5 = 0; int numberPlayersOnTeam6  = 0; int numberPlayersOnTeam7  = 0;
int numberPlayersOnTeam8 = 0; int numberPlayersOnTeam9 = 0; int numberPlayersOnTeam10 = 0; int numberPlayersOnTeam11 = 0;

int getNumberPlayersOnTeam(int i = -1) {
	if(i == 0) return(numberPlayersOnTeam0); if(i == 1) return(numberPlayersOnTeam1); if(i == 2)  return(numberPlayersOnTeam2);  if(i == 3)  return(numberPlayersOnTeam3);
	if(i == 4) return(numberPlayersOnTeam4); if(i == 5) return(numberPlayersOnTeam5); if(i == 6)  return(numberPlayersOnTeam6);  if(i == 7)  return(numberPlayersOnTeam7);
	if(i == 8) return(numberPlayersOnTeam8); if(i == 9) return(numberPlayersOnTeam9); if(i == 10) return(numberPlayersOnTeam10); if(i == 11) return(numberPlayersOnTeam11);
	return(0);
}

void setNumberPlayersOnTeam(int i = -1, int n = 0) {
	if(i == 0) numberPlayersOnTeam0 = n; if(i == 1) numberPlayersOnTeam1 = n; if(i == 2)  numberPlayersOnTeam2  = n; if(i == 3)  numberPlayersOnTeam3  = n;
	if(i == 4) numberPlayersOnTeam4 = n; if(i == 5) numberPlayersOnTeam5 = n; if(i == 6)  numberPlayersOnTeam6  = n; if(i == 7)  numberPlayersOnTeam7  = n;
	if(i == 8) numberPlayersOnTeam8 = n; if(i == 9) numberPlayersOnTeam9 = n; if(i == 10) numberPlayersOnTeam10 = n; if(i == 11) numberPlayersOnTeam11 = n;
}

int playerTeamPos1 = 0; int playerTeamPos2  = 0; int playerTeamPos3  = 0; int playerTeamPos4  = 0;
int playerTeamPos5 = 0; int playerTeamPos6  = 0; int playerTeamPos7  = 0; int playerTeamPos8  = 0;
int playerTeamPos9 = 0; int playerTeamPos10 = 0; int playerTeamPos11 = 0; int playerTeamPos12 = 0;

int getPlayerTeamPos(int i = 0) {
	if(i == 1) return(playerTeamPos1); if(i == 2)  return(playerTeamPos2);  if(i == 3)  return(playerTeamPos3);  if(i == 4)  return(playerTeamPos4);
	if(i == 5) return(playerTeamPos5); if(i == 6)  return(playerTeamPos6);  if(i == 7)  return(playerTeamPos7);  if(i == 8)  return(playerTeamPos8);
	if(i == 9) return(playerTeamPos9); if(i == 10) return(playerTeamPos10); if(i == 11) return(playerTeamPos11); if(i == 12) return(playerTeamPos12);
	return(-1);
}

void setPlayerTeamPos(int i = 0, int pos = 0) {
	if(i == 1) playerTeamPos1 = pos; if(i == 2)  playerTeamPos2  = pos; if(i == 3)  playerTeamPos3  = pos; if(i == 4)  playerTeamPos4  = pos;
	if(i == 5) playerTeamPos5 = pos; if(i == 6)  playerTeamPos6  = pos; if(i == 7)  playerTeamPos7  = pos; if(i == 8)  playerTeamPos8  = pos;
	if(i == 9) playerTeamPos9 = pos; if(i == 10) playerTeamPos10 = pos; if(i == 11) playerTeamPos11 = pos; if(i == 12) playerTeamPos12 = pos;
}

// Player colors.
string getPlayerColor(int id = -1) {
	if(id == 0)  return("<color=0.6,0.4,0.0>"); // Mother Nature.
	if(id == 1)  return("<color=0.2,0.2,1.0>");  if(id == 2)  return("<color=1.0,0.2,0.2>");    if(id == 3)  return("<color=0.0,0.59,0.0>");
	if(id == 4)  return("<color=0.2,0.92,1.0>"); if(id == 5)  return("<color=0.87,0.2,0.93>");  if(id == 6)  return("<color=1.0,1.0,0.0>");
	if(id == 7)  return("<color=1.0,0.4,0.0>");  if(id == 8)  return("<color=0.5,0.0,0.25>");   if(id == 9)  return("<color=0.2,1.0,0.2>");
	if(id == 10) return("<color=0.7,1.0,0.73>"); if(id == 11) return("<color=0.31,0.31,0.31>"); if(id == 12) return("<color=1.0,0.0,0.4>");
	return("<color=1.0,1.0,1.0>"); // White as default.
}

// Debug levels.
string getDebugLevelLabel(int level = -1) {
	if(level == cDebugNone)	return("None");    if(level == cDebugCompetitive) return("Tournament");
	if(level == cDebugTest) return("Testing"); if(level == cDebugFull)		 return("Full");
	return("Unspecified");
}

/********
* LOCAL *
********/

// Set default mirroring to none.
int mirrorType = cMirrorNone;

// Used to indicate whether real observers are present.
bool realObs = false;

// Determines whether additional observers are enabled and present for a particular map.
bool addObs = false;

// Name of the map to be displayed in the chat (if used).
string map = "";

// Convenience variables (essentially also constants) so we don't have to recalculate them every time.

// Easy way to check if the game is competitive (1v1, 2v2, 3v3, ...).
bool twoEqualTeams = false;

// Determines if any observers are present at all (additional or real).
bool anyObs = false;

// Determines whether merge more is enabled and merged players are present for a particular map.
bool mergeModeOn = false;

/*
** Getter for mirror type.
**
** @returns: the mirror type currently set
*/
int getMirrorMode() {
	return(mirrorType);
}

/*
** Sets the mirror type.
**
** @param type: the mirror type
*/
void setMirrorMode(int type = cMirrorNone) {
	mirrorType = type;
}

/*
** Getter for map name.
**
** @returns: the string containing the currently set name of the map
*/
string getMap() {
	return(map);
}

/*
** Sets the name of the map (displayed in the initial message).
**
** @param m: the name of the map
*/
void setMap(string m = "") {
	map = m;
}

/*
** Getter for the current state of additional obs.
**
** @returns: true if additional observers are enabled, false otherwise
*/
bool hasAddObs() {
	return(addObs);
}

/*
** Enables observer mode for the last team if supported by the platform. Requires at least 3 teams.
*/
void enableAddObs() {
	if(cNumberTeams > 2) {
		addObs = true;
	}
}

/*
** Getter for the current state of real obs.
**
** @returns: true if real observers are present, false otherwise
*/
bool hasRealObs() {
	return(realObs);
}

/*
** Convenience function to check if any observers are present.
**
** @returns: true if any observers (real or additional) are present, false otherwise
*/
bool hasAnyObs() {
	return(anyObs);
}

/*
** Checks whether merge mode has been triggered.
**
** @returns: true if any players were merged, false otherwise
*/
bool isMergeModeOn() {
	return(mergeModeOn);
}

/*
** Enables merge mode.
*/
void enableMergeMode() {
	mergeModeOn = true;
}

/*
** Checks whether exactly two teams with equal numbers of players are present.
**
** @returns: true if there are two equal teams with the same number of players, false otherwise
*/
bool gameHasTwoEqualTeams() {
	return(twoEqualTeams);
}

/*******
* UTIL *
*******/

/*
** Shortcut to check if the map script is (when this is called) set up for mirroring.
**
** @returns: true if mirroring is currently enabled
*/
bool isMirrorOn() {
	return(mirrorType != cMirrorNone);
}

/*
** Shortcut to check if the map script is (when this is called) set up for mirroring and two equally sized teams are present.
**
** @returns: true if mirroring is currently enabled and the configuration is valid, false otherwise
*/
bool isMirrorOnAndValidConfig() {
	return(mirrorType != cMirrorNone && gameHasTwoEqualTeams());
}

/*
** Negated version of gameHasTwoEqualTeams() for convenience.
**
** @returns: true if the configuration for mirroring is invalid, false otherwise
*/
bool mirrorConfigIsInvalid() {
	return(gameHasTwoEqualTeams() == false);
}

/*
** Returns the previous player with respect to cNonGaiaPlayers.
**
** @param p: the player
**
** @returns: the previous player
*/
int getPrevPlayer(int p = 0) {
	if(p > 1) {
		return(p - 1);
	}

	return(cNonGaiaPlayers);

	// return((p - 2 + cNonGaiaPlayers) % cNonGaiaPlayers + 1);
}

/*
** Returns the next player with respect to cNonGaiaPlayers.
**
** @param p: the player
**
** @returns: the next player
*/
int getNextPlayer(int p = 0) {
	if(p < cNonGaiaPlayers) {
		return(p + 1);
	}

	return(1);

	// return(p % cNonGaiaPlayers + 1);
}

/*
** Returns the number of players in the team with the most players.
**
** @returns: the size of the largest team
*/
int getLargestTeamSize() {
	int max = 0;

	for(i = 0; < cTeams) {
		if(getNumberPlayersOnTeam(i) > max) {
			max = getNumberPlayersOnTeam(i);
		}
	}

	return(max);
}

/*
** Returns the corresponding mirrored player of a given player.
** The only difference here to getOpposingPlayer really is that we have to consider mirroring by point separately.
**
** @param p: the player
**
** @returns: the mirrored player
*/
int getMirroredPlayer(int p = 0) {
	if(p < 1 || gameHasTwoEqualTeams() == false) {
		return(0);
	}

	if(getMirrorMode() == cMirrorPoint) {
		return((p + getNumberPlayersOnTeam(0) - 1) % cNonGaiaPlayers + 1);
	}

	return(cPlayers - p);
}

/*
** Checks if a player is to be merged with a preceeding player.
**
** @param p: the player
**
** @returns: true if the player has the same name and is in the same team as one of the preceeding players, false otherwise
*/
bool isMergedPlayer(int p = -1) {
	if(isMergeModeOn() == false) {
		return(false);
	}

	for(i = 1; < p) {
		if(rmGetPlayerName(p) == rmGetPlayerName(i) && rmGetPlayerTeam(p) == rmGetPlayerTeam(i)) {
			return(true);
		}
	}

	return(false);
}

/*
** Checks if a player is to be merged with a succeeding player.
**
** @param p: the player
**
** @returns: true if the player has the same name and is in the same team as one of the succeeding players, false otherwise
*/
bool hasMergedPlayer(int p = -1) {
	if(isMergeModeOn() == false) {
		return(false);
	}

	for(i = p + 1; < cNumberPlayers) {
		if(rmGetPlayerName(p) == rmGetPlayerName(i) && rmGetPlayerTeam(p) == rmGetPlayerTeam(i)) {
			return(true);
		}
	}

	return(false);
}

/*
** Gets the god name of a player as a string.
**
** @param player: the player to get the name of the major god for
** @param map: whether to apply getPlayer() to the given player or not
**
** @returns: the name of the god as string
*/
string getGodName(int player = 0, bool map = true) {
	int civ = rmGetPlayerCiv(getPlayer(player));

	if(map == false) {
		civ = rmGetPlayerCiv(player);
	}

	if(civ == cCivZeus) {
		return("Zeus");
	} else if(civ == cCivPoseidon) {
		return("Poseidon");
	} else if(civ == cCivHades) {
		return("Hades");
	} else if(civ == cCivRa) {
		return("Ra");
	} else if(civ == cCivIsis) {
		return("Isis");
	} else if(civ == cCivSet) {
		return("Set");
	} else if(civ == cCivOdin) {
		return("Odin");
	} else if(civ == cCivThor) {
		return("Thor");
	} else if(civ == cCivLoki) {
		return("Loki");
	} else if(civ == cCivOranosID) {
		return("Oranos");
	} else if(civ == cCivKronosID) {
		return("Kronos");
	} else if(civ == cCivGaiaID) {
		return("Gaia");
	} else if(civ == cCivFuxiID) {
		return("Fu Xi");
	} else if(civ == cCivNuwaID) {
		return("Nu Wa");
	} else if(civ == cCivShennongID) {
		return("Shennong");
	}

	return("?");
}

/**********
* XS UTIL *
**********/

float totalProgress = 0.0;

/*
** Advances the progress bar.
**
** @param percent: new percentage of the progress bar (1.0 = 100%)
*/
void progress(float percent = 0.0) {
	totalProgress = percent;
	rmSetStatusText("", totalProgress);
}

/*
** Increments the progress bar.
**
** @param percent: the increment as float (1.0 = 100%)
*/
void addProgress(float incr = 0.0) {
	progress(totalProgress + incr);
}

/*****************
* INJECTION CORE *
*****************/

/*
** Injects code into the trigtemp.xs file.
**
** @param xs: code to be injected
*/
bool codeInit = false;

void code(string xs = "") {
	if(codeInit == false) {
		rmCreateTrigger("injection");
		rmSetTriggerActive(false);

		// Inject comment start.
		rmAddTriggerEffect("SetIdleProcessing");
		rmSetTriggerEffectParam("IdleProc", "); xsDisableSelf(); } } /*");

		codeInit = true;
	}

	rmAddTriggerEffect("Send Chat");
	rmSetTriggerEffectParam("Message", "*/" + xs + "/*", false);
}

/*
** Injects a cooldown for a repeating rule so that it only is executed every x milliseconds.
**
** @param interval: the interval between executions in milliseconds
** @param initialDelay: the initial delay in milliseconds before allowing to execute the trigger
*/
void injectRuleInterval(int interval = 250, int initialDelay = 5000) {
	code("static int last = 0;");

	// code("int real = trTimeMS();");
	code("int now = trTimeMS() - " + initialDelay + ";");

	code("if(now - last < " + interval + ")");
	code("{");
		code("return();");
	code("}");

	// code("trChatSendSpoofed(0, \"\" + real);");

	code("last = now;");
}

/****************
* UTIL TRIGGERS *
****************/

/*
** Sends a message to all players (without the bubble icon) in normal (gold-ish) color.
** Must be injected inside a rule (!).
**
** @param msg: the message to send
*/
void sendChat(string msg = "") {
	code("trChatSend(0, \"" + msg + "\");");
}

/*
** Sends a message to all players (without the bubble icon) in white color.
** Must be injected inside a rule (!).
**
** @param msg: the message to send
*/
void sendChatWhite(string msg = "") {
	code("trChatSend(0, \"" + cColorWhite + msg + cColorOff + "\");");
}

/*
** Sends a message to all players (without the bubble icon) in red color.
** Must be injected inside a rule (!).
**
** @param msg: the message to send
*/
void sendChatRed(string msg = "") {
	code("trChatSend(0, \"" + cColorRed + msg + cColorOff + "\");");
}

/*
** Injects code to pause the game immediately.
** Must be injected inside a rule (!).
*/
void pauseGame() {
	// Only call for p1.
	code("if(trCurrentPlayer() == 1)");
	code("{");
		code("trGamePause(true);");
	code("}");
}

/*
** Prints a message in chat after initialization.
** This doesn't follow the inject...() naming convention as the function is used for debugging only.
**
** @param s: the string to be printed
*/
void print(string s = "") {
	static int printCount = 0;

	code("rule _print_" + printCount);
	code("highFrequency");
	code("active");
	code("{");
		code("trChatSendSpoofed(0, \"" + s + "\");");
		code("xsDisableSelf();");
	code("}");

	printCount++;
}

/*
** Prints a message in red text.
**
** @param s: the string to be printed
*/
void printRed(string s = "") {
	print(cColorRed + s + cColorOff);
}

/*********************
* DEBUGGING VIA CHAT *
*********************/

bool debugInit = false;

/*
** Initial debug message to run once if triggered.
*/
void debugRunOnce() {
	if(debugInit || cDebugMode <= cDebugCompetitive) {
		return;
	}

	print("Debug level: " + getDebugLevelLabel(cDebugMode));

	debugInit = true;
}

/*
** Prints a debug message in red text after loading.
**
** @param msg: the message to print
** @param minLevel: the minimum debug level that has to be active at the time of the call for the message to be printed
*/
void printDebugRed(string msg = "", int minLevel = cDebugFull) {
	if(cDebugMode < minLevel) {
		return;
	}

	debugRunOnce();

	printRed(msg);
}

/*
** Prints a debug message after loading.
**
** @param msg: the message to print
** @param minLevel: the minimum debug level that has to be active at the time of the call for the message to be printed
*/
void printDebug(string msg = "", int minLevel = cDebugFull) {
	if(cDebugMode < minLevel) {
		return;
	}

	debugRunOnce();

	print(msg);
}

/********************
* GENERIC RMX RULES *
********************/

/*
** Should be called upon encountering an invalid mirroring configuration.
** Creates a black map, error messages and pauses the game to encourage players to quit the map.
*/
void injectMirrorGenError() {
	// Initialize black map to indicate failure.
	rmTerrainInitialize("Black");

	code("rule _mirror_error");
	code("highFrequency");
	code("active");
	code("{");
		injectRuleInterval(0, 500); // Run after 0.5 seconds to give time for other initialization.

		if(cVersion != cVersionVanilla) {
			code("trChatHistoryClear();");
		}

		sendChatRed(cInfoLine);
		sendChatRed("");
		sendChatRed("Error: Invalid mirror configuration detected!");
		sendChatRed("");
		sendChatRed("Mirroring requires two teams with the same number of players!");
		sendChatRed("");
		sendChatRed("The game has been paused for saving.");
		sendChatRed("");
		sendChatRed(cInfoLine);

		pauseGame();

		code("xsDisableRule(\"_post_initial_note\");"); // This works even if the rule doesn't exist.
		code("xsDisableRule(\"BasicVC1\");");

		code("xsDisableSelf();");
	code("}");

	// Advance progress to 1.0 as the map script should return after this call.
	progress(1.0);
}

/*
** Sends player and map information with regards to merged mode after ~5 seconds.
**
** @param addObsAllowed: whether additional observers are allowed on this map (printed if any observers are present)
** @param mergeModeAllowed: whether additional observers are allowed on this map (currently not used)
*/
void injectInitNote(bool addObsAllowed = true, bool mergeModeAllowed = true) {
	code("rule _post_initial_note");
	code("highFrequency");
	code("active");
	code("{");
		injectRuleInterval();

		// Clear chat if not playing or merge mode is on.
		if(cVersion != cVersionVanilla) {
			string clearString = "false";

			// Always clear if merge mode or debugging.
			if(isMergeModeOn() || cDebugMode >= cDebugTest) {
				clearString = "true";
			}

			// Always clear for observers.
			for(i = cPlayersMerged; < cPlayersObs) {
				clearString = clearString + " || " + "trCurrentPlayer() == " + getPlayer(i);
			}

			code("if(" + clearString + ")");
			code("{");
				code("trChatHistoryClear();");
			code("}");
		}

		// Patch, patch info and map info.
		code("trChatSend(0, \"" + getPlayerColor(-1) + cPatch + cColorOff + "\");");
		if(cPatchInfo != "") {
			code("trChatSend(0, \"" + getPlayerColor(-1) + cPatchInfo + cColorOff + "\");");
		}

		if(getMap() != "") {
			code("trChatSend(0, \"" + getPlayerColor(-1) + getMap() + cColorOff + "\");");
		}

		int playerCount = 1;

		for(i = 0; < cTeams) {
			for(j = 1; < cNumberPlayers) {
				if(rmGetPlayerTeam(j) == i && isMergedPlayer(j) == false) {
					// Create 1 line per player.
					if(hasMergedPlayer(j)) {
						code("trChatSendSpoofed(" + j + ", \"" + getPlayerColor(j) + rmGetPlayerName(j) + " (" + getGodName(j, false) + "/merged)" + cColorOff + "\");");
					} else {
						code("trChatSendSpoofed(" + j + ", \"" + getPlayerColor(j) + rmGetPlayerName(j) + " (" + getGodName(j, false) + ")" + cColorOff + "\");");
					}

					playerCount++;
				}
			}

			// Don't print vs after last team.
			if(i != (cTeams - 1)) {
				code("trChatSend(0, \"" + getPlayerColor(-1) + "----- vs. -----" + cColorOff + "\");");
			}
		}

		// List observers if present at all.
		if(hasAnyObs()) {
			string obsString = "Observer:";

			if(cPlayersObs - cPlayersMerged > 1) {
				obsString = "Observers:";
			}

			// We have at least 1 observer.
			playerCount = cPlayersMerged;

			code("trChatSend(0, \"" + getPlayerColor(-1) + obsString + cColorOff + "\");");

			// List all additional observers.
			for(i = 1; <= rmGetNumberPlayersOnTeam(cTeams)) { // List all here, regardless if merged or not.
				code("trChatSendSpoofed(" + getPlayer(playerCount) + ", \"" + getPlayerColor(getPlayer(playerCount)) + rmGetPlayerName(getPlayer(playerCount)) + cColorOff + "\");");
				playerCount++;
			}

			// List all regular observers.
			for(i = cNumberPlayers; < cPlayersObs) {
				code("trChatSendSpoofed(" + i + ", \"" + getPlayerColor(getPlayer(playerCount)) + "Regular Observer" + cColorOff + "\");");
				playerCount++;
			}

			// Init note.
			sendChatWhite("Observer commands available (!h for help)");

			// Print info if the map supports additional observers.
			if(addObsAllowed) {
				sendChatWhite("Additional observers supported (team 3)");
			}
		}

		code("trSoundPlayFN(\"\chatreceived.wav\", \"1\", -1,\"\", \"\");");
		code("xsDisableSelf();");
	code("}");
}

/*
** Enables snowing.
**
** @param percent: % of snow to be rendered (1.0 = very dense, 0.0 = no snow)
*/
void injectSnow(float percent = 0.1) {
	code("rule _snow");
	code("highFrequency");
	code("active");
	code("{");
		code("trRenderSnow(" + percent + ");");
		code("xsDisableSelf();");
	code("}");
}

/*
** Casts ceasefire for Mother Nature.
**
** @param delay: the time (in milliseconds) before the cast
*/
void injectCeasefire(int delay = 5000) {
	code("rule _ceasefire");
	code("highFrequency");
	code("active");
	code("{");
		injectRuleInterval(0, delay);

		code("trTechGodPower(0, \"Cease Fire\", 1);");
		code("trTechInvokeGodPower(0, \"Cease Fire\", vector(0.5, 0, 0.5), vector(0.5, 0, 0.5));");

		code("xsDisableSelf();");
	code("}");
}

/*
** Initializes additional observers by granting omniscience and removing resources.
*/
void injectNonPlayerSetup() {
	// Initialize observer mode.
	code("rule _kill_gps_res");
	code("highFrequency");
	code("active");
	code("{");
		// Do this also for merged players to remove their gps and resources.
		for(i = cPlayers; < cNumberPlayers) {
			// Only give omniscience to actual observers, but not to merged players; this is not necessary, but do it for consistency.
			if(i >= cPlayersMerged) {
				code("trTechSetStatus(" + getPlayer(i) + ", 305, 4);"); // Omniscience.
			}

			code("trPlayerKillAllGodPowers(" + getPlayer(i) + ");");
			code("trPlayerGrantResources(" + getPlayer(i) + ", \"Food\", -1000);");
			code("trPlayerGrantResources(" + getPlayer(i) + ", \"Wood\", -1000);");
			code("trPlayerGrantResources(" + getPlayer(i) + ", \"Gold\", -1000);");
			code("trPlayerGrantResources(" + getPlayer(i) + ", \"Favor\", -15);"); // For Zeus.
		}

		code("xsDisableSelf();");
	code("}");
}

/*
** Creates triggers to grant a lot of resources, 300 population and fast buildrates to all players.
*/
void injectTestMode() {
	code("rule _testmode");
	code("highFrequency");
	code("active");
	code("{");
		code("trRateConstruction(10.0);");
		code("trRateResearch(10.0);");
		code("trRateTrain(10.0);");

		for(i = 1; < cPlayers) {
			int p = getPlayer(i);

			code("trPlayerGrantResources(" + p + ", \"Food\", -1000);");
			code("trPlayerGrantResources(" + p + ", \"Wood\", -1000);");
			code("trPlayerGrantResources(" + p + ", \"Gold\", -1000);");
			code("trPlayerGrantResources(" + p + ", \"Favor\", -1000);");
			code("trPlayerGrantResources(" + p + ", \"Food\", 99999);");
			code("trPlayerGrantResources(" + p + ", \"Wood\", 99999);");
			code("trPlayerGrantResources(" + p + ", \"Gold\", 99999);");
			code("trPlayerGrantResources(" + p + ", \"Favor\", 99999);");

			// Omniscience.
			code("trTechSetStatus(" + p + ", 305, 4);");

			if(cVersion != cVersionVanilla) {
				code("trModifyProtounit(\"Settlement Level 1\", " + p + ", 7, 300);");
			}
		}

		code("xsDisableSelf();");
	code("}");
}

/*
** Sends a flare after loading the map if the trigger code has been successfully compiled.
*/
void injectFlareOnCompile() {
	code("rule _check");
	code("highFrequency");
	code("active");
	code("{");
		code("trSoundPlayFN(\"\flare.wav\",\"1\",-1,\"\",\"\");");
		code("xsDisableSelf();");
	code("}");
}

/********
* SETUP *
********/

/*
** Shuffles player order, may get called by initPlayers().
*/
void shufflePlayers() {
	int minCount = 1;
	int maxCount = 0;

	for(t = 0; < cTeams) { // Don't shuffle observers.
		maxCount = maxCount + getNumberPlayersOnTeam(t);

		for(p = 1; <= getNumberPlayersOnTeam(t)) {
			// Players to swap.
			int r = rmRandInt(minCount, maxCount);
			int s = getPlayer(minCount);

			// Do swap.
			setPlayer(minCount, getPlayer(r));
			setPlayer(r, s);

			minCount = minCount + 1;
		}
	}
}

/*
** Calculates the position of the player in the team (needed for fair location placement), called by initPlayers().
*/
void calcInsideOutside() {
	/*
	 * Find out which side is inside/outside of a player in regards to team placement.
	 * 0 = either (team of 1 player)
	 * 1 = left
	 * 2 = right (from center)
	 * 3 = either (center in team of 3+)
	*/
	for(i = 1; < cPlayers) {
		int insideInt = 0;
		int t = rmGetPlayerTeam(getPlayer(i));

		if(getNumberPlayersOnTeam(t) > 1) { // Leave teams of size 1 at int value 0.
			// Check teams of previous and next player.
			if(rmGetPlayerTeam(getPlayer(getPrevPlayer(i))) == t) { // getPrevPlayer() does NOT return the mapped player!
				// Previous player in same team -> option for inside.
				insideInt = insideInt + cPosLast;
			}

			if(rmGetPlayerTeam(getPlayer(getNextPlayer(i))) == t) {
				// Next player in same team -> option for inside.
				insideInt = insideInt + cPosFirst;
			}
		}

		setPlayerTeamPos(i, insideInt);
	}
}

/*
** The heart of the entire engine.
** Arranging the players ourselves is necessary so we know who is placed where.
** This is crucial for any sort of player placement, fair locations, triggers, or mirroring.
**
** @param shuffle: whether to shuffle players within teams of not (defaults to true)
*/
void initPlayers(bool shuffle = true) {
	if(hasAddObs() == false) {
		// No obs, use normal values.
		cTeams = cNumberTeams;
	} else {
		// Obs, adjust counts.
		cTeams = cNumberTeams - 1;
	}

	// Count all non-merged, non-observing players.
	for(i = 1; < cNumberPlayers) {
		if(rmGetPlayerTeam(i) < cTeams && isMergedPlayer(i) == false) {
			cNonGaiaPlayers++;
		}
	}

	cPlayers = cNonGaiaPlayers + 1;
	cPlayersObs = cNumberPlayers;

	int currPlayer = 0;

	// 1. Order actually playing players.
	for(t = 0; < cTeams) {
		for(p = 1; < cNumberPlayers) {
			if(rmGetPlayerTeam(p) == t && isMergedPlayer(p) == false) {
				currPlayer++;
				setPlayer(currPlayer, p);
				setNumberPlayersOnTeam(t, getNumberPlayersOnTeam(t) + 1);
			}
		}
	}

	// 2. Add merged players.
	for(t = 0; < cTeams) {
		for(p = 1; < cNumberPlayers) {
			if(rmGetPlayerTeam(p) == t && isMergedPlayer(p)) {
				currPlayer++;
				setPlayer(currPlayer, p);
			}
		}
	}

	// Increment cPlayersMerged by 1 because it's the number of playing players + 1.
	cPlayersMerged = currPlayer + 1;

	// 3. Add observing players.
	for(p = 1; < cNumberPlayers) { // Start from 3 as we must have at least 2 playing players.
		if(rmGetPlayerTeam(p) == cTeams) {
			currPlayer++;
			setPlayer(currPlayer, p);
			setNumberPlayersOnTeam(cTeams, getNumberPlayersOnTeam(cTeams) + 1);
		}
	}

	// Add regular observers to observer counter if they exist.
	while(rmGetPlayerName(cPlayersObs) != "") {
		realObs = true;
		cPlayersObs++;
	}

	// Set additional information regarding the player setup.
	anyObs = realObs || addObs;
	mergeModeOn = cPlayers != cPlayersMerged; // Overrides merge mode settings if no merged players are present.
	twoEqualTeams = getNumberPlayersOnTeam(0) == getNumberPlayersOnTeam(1) && cTeams == 2;

	// Shuffle if requested.
	if(shuffle) {
		shufflePlayers();
	}

	// Determine position within the team.
	calcInsideOutside();
}
