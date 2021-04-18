/*
** RM X Framework.
** RebelsRising
** Last edit: 14/04/2021
**
** Lowest library file in the hierarchy - include this in your random map script.
** Check core.xs for more details about the RM X framework.
**
** Use rmxInit() before using any of the functionality of the framework.
** Use rmxFinalize() to inject the triggers and placement checks at the end of your script.
*/

include "rmx_triggers.xs"; // Contains all the other files in the hierarchy so we only have to include this one.

/*
** Initializes core RM X functionality. Should be called at the beginning of your random map script.
**
** @param mapName: sets the name of the map for trigger-related calls
** @param shuffle: whether to shuffle players within teams or not
** @param toggleMerge: whether to allow merge mode or not (set to false for original ES maps that do not use RM X placement functions), disable for ES maps
** @param toggleObs: whether to make the last team observing for > 2 teams present, disable for ES maps
** @param initNote: whether to print the initial message
*/
void rmxInit(string mapName = "", bool shuffle = true, bool toggleMerge = true, bool toggleObs = true, bool initNote = true) {
	// Set map name.
	setMap(mapName);

	// Enabling merge mode has to occur before players are initialized.
	if(toggleMerge) {
		enableMergeMode();
	}

	// Enabling additional obs has to occur before players are initialized.
	if(toggleObs && cVersion != cVersionEE) {
		enableAddObs();
	}

	// Initialize players.
	initPlayers(shuffle);

	// Inject the initial note if set to true.
	if(initNote) {
		injectInitNote(toggleObs, toggleMerge);
	}

	// Always inject constants, must happen after initPlayers().
	injectPlayerConstants();
	injectGameConstants();

	// If we're debugging, do stuff here.
	if(cDebugMode == cDebugFull) {
		injectTestMode();
		injectFlareOnCompile();
	}
}

/*
** Executes things that have to be done at the end of a random map script. Should be called last.
*/
void rmxFinalize() {
	// Inject observer code and rain fix.
	if(cVersion == cVersionAoT) {
		if(hasAnyObs()) {
			injectObsRules();
		}

		// Inject Rain fix for AoT.
		if(cVBPEnabled) {
			injectRainFix();
		}
	}

	// Adjust observers and run custom victory conditions.
	if(isMergeModeOn() || hasAddObs()) {
		injectNonPlayerSetup();
		injectVC();
	}

	// Pause the game immediately and start recording after some time.
	if(isMergeModeOn()) {
		injectMergePause();
		injectMergeRecGame();
	}

	// Execute object check.
	if(cDebugMode >= cDebugTest) {
		injectObjectCheck(false, 12); // Check for every possible configuration if we're debugging.
	} else if(cDebugMode >= cDebugCompetitive) {
		injectObjectCheck(true, 12); // Only check for two teams of equal players.
	}
}
