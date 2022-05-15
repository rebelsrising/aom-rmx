/*
** COMPETITIVE MEGA RANDOM
** RebelsRising
** Last edit: 23/04/2022
*/

include "rmx_style.xs";

/************
** GLOBALS **
************/

int cMapType = -1; // Technically not a constant, but should only be set once.

const int cNumMapTypes = 10;

const int cMapTypePlain = 0; // Can still have cliffs, ponds, etc.
const int cMapTypePlateau = 1;
const int cMapTypeOases = 2;
const int cMapTypePlayerIslands = 3; // Erebus/Highland/River Nile style (water/forest/ice/cliff, no fish).
const int cMapTypeCenterIslands = 4; // Marsh/WH style (water only, fish only tg).
const int cMapTypeSmallCenterIsland = 5; // Single small island vs player areas (water center, water/forest side, fish 1v1 & tg).
const int cMapTypeContinent = 6; // Midgard style (water/forest/ice/cliff, fish 1v1 & tg).
const int cMapTypeLake = 7; // Mediterranean/Ghost Lake/Sacred Pond style (water/ice, fish 1v1 & tg).
const int cMapTypeRivers = 8; // Anatolia (but not with side rivers)/Lumber Camp style (water/forest, fish 1v1 & tg).
const int cMapTypeSeparator = 9; // Borderlands style (water/forest/cliff, fish 1v1 & tg).

// Initialization type constants.
const int cInitTypeTerrain = 0;
const int cInitTypeWater = 1;
const int cInitTypeCliff = 2;

// Map initalization stuff.
string cPrimaryTerrainTexture = "";
string cPrimaryUnbuildableTexture = "";
string cPrimaryUnbuildableSurroundTexture = "";
string cPrimaryPassableCliffTexture = "";
string cPrimaryImpassableCliffTexture = "";
string cPrimaryCliffType = "";
string cPrimaryWaterTexture = "";
string cPrimaryForestTexture = "";
string cPrimaryHerdableType = "";

int cNumPlayerTiles = 0; // Should be set at map initialization time.
int cInitType = -1;

// Global parameters.
const int cMapSettlementsWaterRuleNone = 0;
const int cMapSettlementsWaterRuleEither = 1;
const int cMapSettlementsWaterRuleForceAvoidFar = 2;
const int cMapSettlementsWaterRuleForceClose = 3;

int cMapFirstSettlementWaterRule = cMapSettlementsWaterRuleForceAvoidFar; // Avoid far by default (!).
int cMapSecondSettlementWaterRule = cMapSettlementsWaterRuleNone;

const int cMapSettlementsInsideRuleNone = 0; // Randomize, but alternate upon failing.
const int cMapSettlementsInsideRuleInside = 1; // Force inside.
const int cMapSettlementsInsideRuleOutside = 2; // Force outside.

int cMapFirstSettlementInsideRule = cMapSettlementsInsideRuleNone;
int cMapSecondSettlementInsideRule = cMapSettlementsInsideRuleNone;

bool cMapHasCustomSecondSettlement = false; // Whether second (far) settlements are placed by the terrain generation or not.
bool cMapForceSecondSettlementOnPlayerArea = false; // Whether second settlements should be forced into player areas in teamgames (use carefully).
bool cMapHasMirroredSettlements = false; // If set to true, settlement placement will be mirrored (only required for very specific variations).
bool cMapMirrorInBonusArea = false; // If set to true, a larger amount of resources will be placed in the bonus area.
bool cMapPlaceBonusInTeamArea = false; // If set to true, bonus stuff will be placed in team splits instead of player splits.
bool cMapHasSmallPlayerAreas = false; // Force hunt and gold to be placed in the player area instead via similar location.
bool cMapHasSmallBeautificationAreas = false; // Set this to true if (small) bodies of water get close to the players during terrain generation to prevent override from beautification terrain.
bool cMapIsUnbuildableBuildable = false; // If this is true, the terrain from cPrimaryUnbuildableTexture is not actually unbuildable (some texture sets have no unbuildable type).
bool cMapDoesNotAllowPonds = false; // Whether the map does allow ponds as terrain feature.
bool cMapDoesNotAllowCliffs = false; // Whether the map does allow cliffs as terrain feature.
bool cMapHasWater = false; // Whether the map has any water (for decoration and hunt styles).
bool cMapHasLargeWaterBody = false; // If true, additional water decoration will be placed.
bool cMapHasFish = false; // Whether fish can be placed.
bool cMapHasNonMirroredFish = false; // Whether fish is mirrored or not.
bool cMapCanHaveTwoCenterRelics = false; // Whether the map can have two relics in its center.

const int cFeatureRestrictionNone = 0; // No feature restrictions on the entire map (cliffs/ponds).
const int cFeatureRestrictionPlayer = 1; // No features in player areas.
const int cFeatureRestrictionNonPlayer = 2; // No features in center/non-player areas.
const int cFeatureRestrictionEverywhere = 3; // No features at all.

int cMapFeatureRestriction = cFeatureRestrictionNone;

const int cForceFeatureNone = 0;
const int cForceFeatureCliffs = 1;
const int cForceFeaturePonds = 2;
const int cForceFeatureAll = 3;

int cMapForceFeatures = cForceFeatureNone;

const int cBonusAreaSizeNone = 0;
const int cBonusAreaSizeSmall = 1;
const int cBonusAreaSizeMedium = 2;
const int cBonusAreaSizeLarge = 3;

int cMapBonusAreaSize = cBonusAreaSizeNone;

// Global classes.
int classMirrorCenter = -1; // Center to avoid for the few variations cMapHasMirroredSettlements is true.
int classCornerBlock = -1;
int classFirstSettlementBlock = -1;
int classSecondSettlementBlock = -1;
int classMediumResourceBlock = -1;
int classBonusResourceBlock = -1;
int classForestResourceBlock = -1;
int classFishResourceBlock = -1;
int classMiscResourceBlock = -1;
int classUnbuildable = -1;
int classPlayerCore = -1;
int classSettleArea = -1;
int classTower = -1;
int classCliff = -1;
int classPond = -1;

// Global constraints.
int avoidAll = -1;
int avoidEdge = -1;
int avoidTowerLOS = -1;

// Connection array.
int connectionID1 = -1; int connectionID2  = -1; int connectionID3  = -1; int connectionID4  = -1;
int connectionID5 = -1; int connectionID6  = -1; int connectionID7  = -1; int connectionID8  = -1;
int connectionID9 = -1; int connectionID10 = -1; int connectionID11 = -1; int connectionID12 = -1;

int getConnectionID(int n = 0) {
	if(n == 1) return(connectionID1); if(n == 2)  return(connectionID2);  if(n == 3)  return(connectionID3);  if(n == 4)  return(connectionID4);
	if(n == 5) return(connectionID5); if(n == 6)  return(connectionID6);  if(n == 7)  return(connectionID7);  if(n == 8)  return(connectionID8);
	if(n == 9) return(connectionID9); if(n == 10) return(connectionID10); if(n == 11) return(connectionID11); if(n == 12) return(connectionID12);
	return(-1);
}

void setConnectionID(int i = 0, int id = -1) {
	if(i == 1) connectionID1 = id; if(i == 2)  connectionID2  = id; if(i == 3)  connectionID3  = id; if(i == 4)  connectionID4  = id;
	if(i == 5) connectionID5 = id; if(i == 6)  connectionID6  = id; if(i == 7)  connectionID7  = id; if(i == 8)  connectionID8  = id;
	if(i == 9) connectionID9 = id; if(i == 10) connectionID10 = id; if(i == 11) connectionID11 = id; if(i == 12) connectionID12 = id;
}

const string fishIcon = "<icon=(24)(icons/fish)>";

void injectFishHint() {
	code("rule _fish_hint");
	code("active");
	code("highFrequency");
	code("{");
		code("trChatSend(0, \"" + fishIcon + " " + cColorRed + "This map contains fish!" + cColorOff + "\");");
		code("xsDisableSelf();");
	code("}");
}

void initMapGeneric(int initType = 0, int playerTiles = 7500, bool forceSquare = false, float baseHeight = NINF) {
	float axisScaleFloat = rmRandFloat(0.0, 1.0);
	float xAxisLength = 0.0;
	float zAxisLength = 1.0;

	if(axisScaleFloat < 0.8 || forceSquare) {
		// Square.
		xAxisLength = getStandardMapDimInMeters(playerTiles);
		zAxisLength = xAxisLength;
	} else if(axisScaleFloat < 0.9) {
		// Rectangular (x stretch).
		xAxisLength = getStandardMapDimInMeters(playerTiles, 0.9, 2.22);
		zAxisLength = getStandardMapDimInMeters(playerTiles, 0.9, 1.8);
	} else {
		// Rectangular (z stretch).
		xAxisLength = getStandardMapDimInMeters(playerTiles, 0.9, 1.8);
		zAxisLength = getStandardMapDimInMeters(playerTiles, 0.9, 2.22);
	}

	// Randomize primary textures.
	cPrimaryTerrainTexture = getRandomTerrain();
	cPrimaryUnbuildableTexture = getRandomUnbuildableTextureByStyle();
	cPrimaryUnbuildableSurroundTexture = getRandomUnbuildableSurroundTextureByStyle();
	cPrimaryPassableCliffTexture = getRandomCliffByStyle(false);
	cPrimaryImpassableCliffTexture = getRandomCliffByStyle(true);
	cPrimaryCliffType = getRandomCliffTypeByStyle();
	cPrimaryWaterTexture = getRandomWaterByStyle();
	cPrimaryForestTexture = getRandomForestByStyle();
	cPrimaryHerdableType = getRandomHerdableByStyle();

	cMapIsUnbuildableBuildable = cPrimaryUnbuildableTexture == cTextureNone;

	// Random variation for unbuildable (which may now be buildable if cMapIsUnbuildableBuildable == true).
	if(cMapIsUnbuildableBuildable || randChance()) {
		cPrimaryUnbuildableTexture = getRandomTerrainWithDistance(cPrimaryTerrainTexture, 1, 2);
		cPrimaryUnbuildableSurroundTexture = getRandomTerrainWithDistance(cPrimaryUnbuildableTexture, 1, 2);

		// Will always be true, even if we got in here randomly, as we randomize from buildable terrain.
		cMapIsUnbuildableBuildable = true;
	}

	if(initType == cInitTypeTerrain) {
		initializeMap(cPrimaryTerrainTexture, xAxisLength, zAxisLength, false, baseHeight);
	} else if(initType == cInitTypeWater) {
		initializeMap(cPrimaryWaterTexture, xAxisLength, zAxisLength, true, baseHeight);
	} else if(initType == cInitTypeCliff) {
		initializeMap(cPrimaryImpassableCliffTexture, xAxisLength, zAxisLength, false, baseHeight);
	}

	cNumPlayerTiles = playerTiles;
	cInitType = initType;
}

// Player placement.
// Minimum player radius from the center (especially useful if players weren't placed via circle/square).
float cMinPlayerRadiusMeters = 0.0; // Should be set after placing players via updateMinPlayerMetersFromCenter().

void updateMinPlayerMetersFromCenter() {
	float minDist = INF;

	float xCenterMeters = rmXFractionToMeters(0.5);
	float zCenterMeters = rmZFractionToMeters(0.5);

	for(i = 1; < cPlayers) {
		float x = rmXFractionToMeters(getPlayerLocXFraction(i));
		float z = rmZFractionToMeters(getPlayerLocZFraction(i));

		float dist = sqrt(sq(xCenterMeters - x) + sq(zCenterMeters - z));

		if(dist < minDist) {
			minDist = dist;
		}
	}

	cMinPlayerRadiusMeters = minDist;
}

void placePlayersGeneric() {
	float placementFloat = rmRandFloat(0.0, 1.0);

	if(placementFloat < 0.1 && gameHasTwoEqualTeams() && cNonGaiaPlayers > 5) {
		// Line placement (not for 1v1 and 2v2).
		float backDistFraction = rmRandFloat(0.15, 0.25);
		float sideDistFraction = 0.0;

		if(cNonGaiaPlayers < 9) {
			sideDistFraction = rmRandFloat(0.1, 0.2);
		} else {
			sideDistFraction = 0.1;
		}

		int teamInt = rmRandInt(0, 1);

		if(randChance()) {
			// Bottom left to top right.
			placeTeamInLine(teamInt, backDistFraction, 1.0 - sideDistFraction, backDistFraction, sideDistFraction);
			placeTeamInLine(1 - teamInt, 1.0 - backDistFraction, sideDistFraction, 1.0 - backDistFraction, 1.0 - sideDistFraction);
		} else {
			// Bottom right to top left.
			placeTeamInLine(teamInt, sideDistFraction, backDistFraction, 1.0 - sideDistFraction, backDistFraction);
			placeTeamInLine(1 - teamInt, 1.0 - sideDistFraction, 1.0 - backDistFraction, sideDistFraction, 1.0 - backDistFraction);
		}
	} else if(placementFloat < 0.2) {
		// Square placement.
		// Biased to larger int, otherwise players frequently get placed very close.
		int squareInt = randLargeInt(0, 4);
		float squareTeamModifier = 0.0;
		float squareMinRadius = 0.275 + 0.025 * squareInt;
		float squareMaxRadius = 0.3 + 0.025 * squareInt;

		if(cNonGaiaPlayers < 9 && gameHasTwoEqualTeams()) {
			squareTeamModifier = rmRandFloat(0.75 + 0.05 * squareInt, 0.8 + 0.05 * squareInt);
		} else {
			squareTeamModifier = rmRandFloat(0.9, 1.0);
		}

		placePlayersInSquare(squareMinRadius, squareMaxRadius, squareTeamModifier);
	} else {
		// Circular placement.
		// Bias to smaller team modifier by default as most maps have spacing modifiers < 1.0.
		float circularTeamModifier = randSmallFloat(0.75, 1.0);
		float circularMinRadius = 0.325;
		float circularMaxRadius = 0.4;

		if(cNonGaiaPlayers < 9 && gameHasTwoEqualTeams()) {
			circularTeamModifier = randSmallFloat(0.75, 1.0);
		} else {
			circularTeamModifier = randSmallFloat(0.9, 1.0);
		}

		placePlayersInCircle(circularMinRadius, circularMaxRadius, circularTeamModifier);
	}
}

// Player cores.
const string cPlayerCoreAreaLabel = "player core";

void createPlayerCores() {
	// Block player areas.
	float fakePlayerAreaSize = areaRadiusMetersToFraction(6.0); // Size of a settlement.

	for(i = 1; < cPlayers) {
		int fakePlayerAreaID = createArea(cPlayerCoreAreaLabel + " " + i);
		rmSetAreaSize(fakePlayerAreaID, fakePlayerAreaSize);
		rmSetAreaLocPlayer(fakePlayerAreaID, getPlayer(i));

		rmSetAreaCoherence(fakePlayerAreaID, 1.0);

		rmAddAreaToClass(fakePlayerAreaID, classPlayerCore);
		rmSetAreaWarnFailure(fakePlayerAreaID, false);
	}

	rmBuildAllAreas();
}

int fakePlayerVsCenterCount = 0;

void buildFakePlayerAreasVsCenterBlock(int centerID = -1, int blockClassID = -1) {
	// Bonus stuff into center, build player areas against the center and add them to the class.
	int classFakePlayer = defineClass();
	int avoidFakeCenter = createAreaDistConstraint(centerID, 1.0);
	int avoidFakePlayer = createClassDistConstraint(classFakePlayer, 1.0);

	for(i = 1; < cPlayers) {
		int fakePlayerAreaID = createArea();
		rmSetAreaSize(fakePlayerAreaID, 1.0 / cNonGaiaPlayers);
		rmSetAreaLocPlayer(fakePlayerAreaID, getPlayer(i));

		rmSetAreaCoherence(fakePlayerAreaID, 1.0);

		rmAddAreaToClass(fakePlayerAreaID, classFakePlayer);
		rmAddAreaToClass(fakePlayerAreaID, blockClassID);
		rmAddAreaConstraint(fakePlayerAreaID, avoidFakePlayer);
		rmAddAreaConstraint(fakePlayerAreaID, avoidFakeCenter);
		rmSetAreaWarnFailure(fakePlayerAreaID, false);
	}

	rmBuildAllAreas();

	fakePlayerVsCenterCount++;
}

void genMapPlain() {
	cMapFirstSettlementInsideRule = cMapSettlementsInsideRuleNone;
	cMapSecondSettlementInsideRule = cMapSettlementsInsideRuleNone;
	cMapFirstSettlementWaterRule = cMapSettlementsWaterRuleForceAvoidFar;
	cMapSecondSettlementWaterRule = cMapSettlementsWaterRuleForceAvoidFar;

	// Chance for bonus center.
	if(randChance(1.0 / 3.0)) {
		float centerAreaFraction = 0.0;
		float centerFloat = rmRandFloat(0.0, 1.0);

		if(centerFloat < 1.0 / 3.0) {
			cMapBonusAreaSize = cBonusAreaSizeSmall;
			centerAreaFraction = rmRandFloat(0.075, 0.1);
		} else if(centerFloat < 2.0 / 3.0) {
			cMapBonusAreaSize = cBonusAreaSizeMedium;
			centerAreaFraction = rmRandFloat(0.125, 0.15);
		} else {
			cMapBonusAreaSize = cBonusAreaSizeLarge;
			centerAreaFraction = rmRandFloat(0.175, 0.2);
		}

		int fakeCenterID = createArea();
		rmSetAreaSize(fakeCenterID, centerAreaFraction);
		// rmSetAreaTerrainType(fakeCenterID, cHadesBuildable1);
		rmSetAreaLocation(fakeCenterID, 0.5, 0.5);

		rmSetAreaCoherence(fakeCenterID, 1.0);

		rmAddAreaConstraint(fakeCenterID, createClassDistConstraint(classPlayerCore, 42.5));
		rmSetAreaWarnFailure(fakeCenterID, false);
		rmBuildArea(fakeCenterID);

		// Force bonus stuff into the center.
		buildFakePlayerAreasVsCenterBlock(fakeCenterID, classBonusResourceBlock);

		// Make player resources avoid the center.
		rmAddAreaToClass(fakeCenterID, classMediumResourceBlock);
		rmAddAreaToClass(fakeCenterID, classSecondSettlementBlock);

		if(randChance()) {
			rmAddAreaToClass(fakeCenterID, classForestResourceBlock);
		}

		// No features in the center, mirror resources if only 1 of each.
		cMapFeatureRestriction = cFeatureRestrictionNonPlayer;
		cMapMirrorInBonusArea = true;
	}
}

void genMapPlateau() {
	// Second settlement rules defined after building center.
	cMapFirstSettlementInsideRule = cMapSettlementsInsideRuleNone;

	cMapFirstSettlementWaterRule = cMapSettlementsWaterRuleForceAvoidFar;
	cMapSecondSettlementWaterRule = cMapSettlementsWaterRuleForceAvoidFar;

	cMapHasSmallBeautificationAreas = true;
	cMapMirrorInBonusArea = gameIs1v1();

	float plateauAreaFraction = 0.0;
	float plateauFloat = rmRandFloat(0.0, 1.0);

	if(plateauFloat < 1.0 / 3.0) {
		cMapBonusAreaSize = cBonusAreaSizeSmall;
		plateauAreaFraction = 0.075;
	} else if(plateauFloat < 2.0 / 3.0) {
		cMapBonusAreaSize = cBonusAreaSizeMedium;
		plateauAreaFraction = 0.125;
	} else {
		cMapBonusAreaSize = cBonusAreaSizeLarge;
		plateauAreaFraction = 0.175;
	}

	printDebug("plateauAreaFraction: " + plateauAreaFraction, cDebugFull);

	// Get number of ramps.
	int numPlateauRamps = 0;

	if(gameIs1v1()) {
		numPlateauRamps = 6 - 2 * rmRandInt(0, 1);
	} else {
		if(plateauAreaFraction < areaRadiusMetersToFraction(40.0)) {
			numPlateauRamps = rmRandInt(2, 4);
		} else {
			numPlateauRamps = cNonGaiaPlayers;
		}
	}

	// Center area.
	float plateauHeight = 6.0;

	int plateauID = createArea();
	rmSetAreaSize(plateauID, plateauAreaFraction);
	rmSetAreaLocation(plateauID, 0.5, 0.5);

	rmSetAreaCliffType(plateauID, cPrimaryCliffType);
	rmSetAreaCliffHeight(plateauID, plateauHeight, 1.0, 0.5);
	rmSetAreaCliffEdge(plateauID, numPlateauRamps, 0.75 / numPlateauRamps, 0.0, 1.0, 0);
	rmSetAreaCliffPainting(plateauID, false, true, true, 1.5, true);

	rmSetAreaCoherence(plateauID, 0.6);
	rmSetAreaSmoothDistance(plateauID, 20);

	rmAddAreaToClass(plateauID, classCliff); // Add to cliff so elevation avoids this.
	rmAddAreaToClass(plateauID, classMediumResourceBlock); // Don't allow medium resources on the plateau.
	rmAddAreaConstraint(plateauID, createClassDistConstraint(classPlayerCore, 37.5));
	rmSetAreaWarnFailure(plateauID, false);
	rmBuildArea(plateauID);

	// Force bonus resources onto the plateau.
	cMapPlaceBonusInTeamArea = true;
	buildFakePlayerAreasVsCenterBlock(plateauID, classBonusResourceBlock);

	// 50% chance to allow settlements on the plateau or not.
	if(randChance()) {
		cMapSecondSettlementInsideRule = cMapSettlementsInsideRuleInside;
		cMapHasMirroredSettlements = true;
	} else {
		cMapSecondSettlementInsideRule = cMapSettlementsInsideRuleOutside;
		rmAddAreaToClass(plateauID, classSecondSettlementBlock);
	}

	// Build fake player areas as counterpart for resource placement.
	// Set up player areas.
	int avoidPlayer = createClassDistConstraint(classBonusResourceBlock, 1.0);
	int avoidCenter = createAreaDistConstraint(plateauID, 1.0);

	for(i = 1; < cPlayers) {
		int playerAreaID = createArea();
		rmSetAreaSize(playerAreaID, 1.0 / cNonGaiaPlayers);
		rmSetAreaLocPlayer(playerAreaID, getPlayer(i));

		rmSetAreaCoherence(playerAreaID, 1.0);

		rmAddAreaToClass(playerAreaID, classBonusResourceBlock);
		rmAddAreaConstraint(playerAreaID, avoidPlayer);
		rmAddAreaConstraint(playerAreaID, avoidCenter);
		rmSetAreaWarnFailure(playerAreaID, false);
	}

	rmBuildAllAreas();

	// Hacky solution to try and force second settlement either on cliffs or not on cliffs for 1v1.
	if(gameIs1v1()) {
		if(plateauAreaFraction >= 0.175 && randChance()) {
			addFairLocConstraint(createAreaConstraint(plateauID), 2);
		} else {
			addFairLocConstraint(createAreaDistConstraint(plateauID, 1.0), 2);
		}
	}

	// Decoration.
	if(randChance(1.0 / 3.0)) {
		// Not much space for bonus stuff on the plateau.
		float plateauEdgeConstraintDistMeters = 12.5;

		if(randChance() || gameIs1v1()) {
			float plateauForestAreaFraction = rmRandFloat(0.05, 0.1) * plateauAreaFraction;

			// Center forest.
			int plateauForestID = createArea();
			rmSetAreaForestType(plateauForestID, cPrimaryForestTexture);
			rmSetAreaSize(plateauForestID, plateauForestAreaFraction);
			rmSetAreaLocation(plateauForestID, 0.5, 0.5);

			rmSetAreaCoherence(plateauForestID, 0.5);
			rmSetAreaSmoothDistance(plateauForestID, 10);

			// Avoid impassable land (the cliff).
			rmAddAreaConstraint(plateauForestID, createTerrainDistConstraint("Land", false, plateauEdgeConstraintDistMeters));

			rmSetAreaWarnFailure(plateauForestID, false);
			rmBuildArea(plateauForestID);
		} else {
			cMapHasWater = true;

			float plateauPondAreaFraction = 0.15 * plateauAreaFraction;

			// Center pond.
			int plateauPondID = createArea();
			rmSetAreaWaterType(plateauPondID, cPrimaryWaterTexture);
			rmSetAreaSize(plateauPondID, plateauPondAreaFraction);
			rmSetAreaLocation(plateauPondID, 0.5, 0.5);

			rmSetAreaCoherence(plateauPondID, 0.7);
			rmSetAreaBaseHeight(plateauPondID, plateauHeight + 1.0);
			rmSetAreaSmoothDistance(plateauPondID, 10);
			rmSetAreaHeightBlend(plateauPondID, 2);

			// Avoid impassable land (the cliff).
			rmAddAreaConstraint(plateauPondID, createTerrainDistConstraint("Land", false, plateauEdgeConstraintDistMeters));

			rmSetAreaWarnFailure(plateauPondID, false);
			rmBuildArea(plateauPondID);
		}
	}
}

void genMapOases() {
	cMapFirstSettlementInsideRule = cMapSettlementsInsideRuleNone;
	cMapSecondSettlementInsideRule = cMapSettlementsInsideRuleNone;
	cMapFirstSettlementWaterRule = cMapSettlementsWaterRuleForceAvoidFar;
	cMapSecondSettlementWaterRule = cMapSettlementsWaterRuleForceAvoidFar;

	// Small player decoration to avoid surrounding and overriding small cliffs/forests.
	cMapHasSmallBeautificationAreas = gameIs1v1();

	int numOases = 0;
	float numOasesFloat = rmRandFloat(0.0, 1.0);

	// 3 and 5 oases currently disabled!
	if(numOasesFloat < 0.25) {
		numOases = 1;
	} else if(numOasesFloat < 0.625) {
		numOases = 2;
	} else {
		numOases = 4;
	}

	// Parameters (fractions!).
	// Maximum radius as seen from the center without getting too close to player areas.
	float oasisMaxRadiusMeters = cMinPlayerRadiusMeters - (35.0 + 5.0 * rmRandInt(0, 1)); // Keep distance from player spawns.
	float oasisMaxRadiusFraction = min(smallerMetersToFraction(oasisMaxRadiusMeters), 0.3);

	// Distance between oases.
	float interOasisDistFraction = 0.0;

	if(numOases == 2) {
		interOasisDistFraction = 0.1 + 0.025 * rmRandInt(0, 1);
	} else if(numOases == 4) {
		interOasisDistFraction = 0.075 + 0.025 * rmRandInt(0, 1);
	} else {
		interOasisDistFraction = 0.075 + 0.025 * rmRandInt(0, 1);
	}

	// Calculated parameters.
	float oasisAreaFraction = 0.0;
	float oasisCircleRadiusFraction = 0.0;
	float oasisAreaRadiusFraction = 0.0;
	float oasisAngle = 0.0;

	int oasisAreaID = -1;

	if(numOases == 1) {
		// Limit upper bound for teamgames to avoid getting too close.
		if(gameIs1v1() == false) {
			oasisMaxRadiusFraction = min(0.275, oasisMaxRadiusFraction);
		}

		// Minimum/Maximum area fraction.
		float largeOasisMinFrac = 0.05;
		float largeOasisMaxFrac = areaRadiusMetersToFraction(smallerFractionToMeters(oasisMaxRadiusFraction));

		// Smaller bias should be good here, at least for 1v1.
		oasisAreaFraction = randSmallFloat(largeOasisMaxFrac, largeOasisMaxFrac);

		int oasisAvoidPlayer = createClassDistConstraint(classPlayerCore, 25.0);

		if(randChance(0.75)) {
			// Center oasis.
			oasisAreaID = createArea();
			rmSetAreaForestType(oasisAreaID, cPrimaryForestTexture);
			rmSetAreaSize(oasisAreaID, oasisAreaFraction);
			rmSetAreaLocation(oasisAreaID, 0.5, 0.5);

			rmSetAreaCoherence(oasisAreaID, 0.6);
			rmSetAreaSmoothDistance(oasisAreaID, 10);

			rmAddAreaConstraint(oasisAreaID, oasisAvoidPlayer);
			rmSetAreaWarnFailure(oasisAreaID, false);
			rmBuildArea(oasisAreaID);

			// Center pond.
			if(gameIs1v1() == false || oasisAreaFraction > 0.075) {
				cMapHasWater = true;

				oasisAreaID = createArea();
				rmSetAreaWaterType(oasisAreaID, cPrimaryWaterTexture);
				rmSetAreaSize(oasisAreaID, oasisAreaFraction / PI); // Scale accordingly.
				rmSetAreaLocation(oasisAreaID, 0.5, 0.5);

				rmSetAreaCoherence(oasisAreaID, 1.0);
				rmSetAreaBaseHeight(oasisAreaID, 2.0);

				rmSetAreaWarnFailure(oasisAreaID, false);
				rmBuildArea(oasisAreaID);
			}
		} else {
			// Center cliff.
			oasisAreaID = createArea();
			rmSetAreaTerrainType(oasisAreaID, cPrimaryImpassableCliffTexture);
			rmSetAreaSize(oasisAreaID, HALF_SQRT_2 * oasisAreaFraction); // Scale accordingly.
			rmSetAreaLocation(oasisAreaID, 0.5, 0.5);

			rmSetAreaCoherence(oasisAreaID, 0.5);
			rmSetAreaCliffType(oasisAreaID, cPrimaryCliffType);
			rmSetAreaCliffEdge(oasisAreaID, 1, 1.0, 0.0, 1.0, 0);
			rmSetAreaCliffPainting(oasisAreaID, true, true, true, 1.5, false);
			rmSetAreaCliffHeight(oasisAreaID, 6.0, 1.0, 1.0);
			rmSetAreaSmoothDistance(oasisAreaID, 10);

			rmAddAreaConstraint(oasisAreaID, oasisAvoidPlayer);
			rmSetAreaWarnFailure(oasisAreaID, false);
			rmBuildArea(oasisAreaID);

			// Mini-cliffs as decoration.
			for(i = 0; < 20 * cNonGaiaPlayers) {
				int oasisMiniCliffID = createAreaWithSuperArea(oasisAreaID);
				rmSetAreaTerrainType(oasisMiniCliffID, cPrimaryImpassableCliffTexture);
				rmSetAreaSize(oasisMiniCliffID, 0.1 * oasisAreaFraction);

				rmSetAreaCoherence(oasisMiniCliffID, 0.0);
				rmSetAreaCliffType(oasisMiniCliffID, cPrimaryCliffType);
				rmSetAreaCliffEdge(oasisMiniCliffID, 1, 1.0, 0.0, 1.0, 0);
				rmSetAreaCliffPainting(oasisMiniCliffID, true, false, true, 1.5, false);
				rmSetAreaCliffHeight(oasisMiniCliffID, 1.0, 1.0, 1.0);

				rmSetAreaWarnFailure(oasisMiniCliffID, false);
				rmBuildArea(oasisMiniCliffID);
			}
		}
	}

	// Two oases.
	if(numOases == 2) {
		oasisAngle = 0.25 * PI + 0.5 * PI * rmRandInt(0, 1);

		// Half of the diameter that results when subtracting half of the interOasisDistFraction from oasisMaxRadiusFraction.
		oasisAreaRadiusFraction = 0.5 * (oasisMaxRadiusFraction - 0.5 * interOasisDistFraction);
		oasisCircleRadiusFraction = 0.5 * interOasisDistFraction + oasisAreaRadiusFraction;

		placeLocationsInCircle(numOases, oasisCircleRadiusFraction, oasisAngle);
	}

	// Three or five oases.
	if(numOases == 3 || numOases == 5) {
		oasisAngle = 0.25 * PI + 0.5 * PI * rmRandInt(0, 1);

		// 2 * oasisMaxRadiusFraction = 2 * interOasisDistFraction + 6 * oasisAreaRadiusFraction.
		oasisAreaRadiusFraction = (oasisMaxRadiusFraction - interOasisDistFraction) / 3.0;
		// 2.0 * radius (half of both center and corner circle) + interOasisDistFraction.
		oasisCircleRadiusFraction = interOasisDistFraction + 2.0 * oasisAreaRadiusFraction;

		placeLocationsInCircle(numOases - 1, oasisCircleRadiusFraction, oasisAngle);

		// Add center oasis to storage so it gets built later.
		forceAddLocToStorage(0.5, 0.5);
	}

	// Four oases.
	if(numOases == 4) {
		oasisAngle = 0.25 * PI * rmRandInt(0, 1);

		// oasisMaxRadiusFraction = oasisCircleRadiusFraction + oasisAreaRadiusFraction, then Pythagoras with 0.5 * interOasisDistFraction.
		oasisAreaRadiusFraction = (oasisMaxRadiusFraction - HALF_SQRT_2 * interOasisDistFraction) / (SQRT_2 + 1.0);
		oasisCircleRadiusFraction = oasisMaxRadiusFraction - oasisAreaRadiusFraction;

		placeLocationsInCircle(numOases, oasisCircleRadiusFraction, oasisAngle);
	}

	printDebug("oasisMaxRadiusFraction: " + oasisMaxRadiusFraction, cDebugFull);

	if(numOases > 1) {
		oasisAreaFraction = areaRadiusMetersToFraction(smallerFractionToMeters(oasisAreaRadiusFraction));

		float oasisVariation = rmRandFloat(0.0, 1.0);

		// Don't allow water for very small areas.
		if(smallerFractionToMeters(oasisAreaRadiusFraction) < 22.5) {
			oasisVariation = rmRandFloat(0.0, 2.0 / 3.0);
		}

		if(oasisVariation < 1.0 / 3.0) {
			// Default variation: Oases with ponds.
			// Oases.
			for(i = 1; <= numOases) {
				oasisAreaID = createArea();
				rmSetAreaForestType(oasisAreaID, cPrimaryForestTexture);
				rmSetAreaSize(oasisAreaID, oasisAreaFraction);
				rmSetAreaLocation(oasisAreaID, getLocX(i), getLocZ(i));

				rmSetAreaCoherence(oasisAreaID, 0.6);
				rmSetAreaSmoothDistance(oasisAreaID, 10);

				rmSetAreaWarnFailure(oasisAreaID, false);

				// Ponds.
				if(smallerFractionToMeters(oasisAreaRadiusFraction) > 25.0) {
					cMapHasWater = true;

					oasisAreaID = createArea();
					rmSetAreaWaterType(oasisAreaID, cPrimaryWaterTexture);
					rmSetAreaSize(oasisAreaID, 0.2 * oasisAreaFraction);
					rmSetAreaLocation(oasisAreaID, getLocX(i), getLocZ(i));

					rmSetAreaCoherence(oasisAreaID, 1.0);
					rmSetAreaBaseHeight(oasisAreaID, 2.0);

					rmSetAreaWarnFailure(oasisAreaID, false);
				}
			}
		} else if(oasisVariation < 2.0 / 3.0) {
			// Cliffs.
			for(i = 1; <= numOases) {
				oasisAreaID = createArea();
				rmSetAreaTerrainType(oasisAreaID, cPrimaryImpassableCliffTexture);
				rmSetAreaSize(oasisAreaID, HALF_SQRT_2 * oasisAreaFraction);
				rmSetAreaLocation(oasisAreaID, getLocX(i), getLocZ(i));

				rmSetAreaCoherence(oasisAreaID, 0.6);
				rmSetAreaCliffType(oasisAreaID, cPrimaryCliffType);
				rmSetAreaCliffEdge(oasisAreaID, 1, 1.0, 0.0, 1.0, 0);
				rmSetAreaCliffPainting(oasisAreaID, true, true, true, 1.5, false);
				rmSetAreaCliffHeight(oasisAreaID, 6.0, 1.0, 1.0);
				rmSetAreaSmoothDistance(oasisAreaID, 10);

				rmSetAreaWarnFailure(oasisAreaID, false);
			}
		} else {
			// Ponds.
			for(i = 1; <= numOases) {
				cMapHasWater = true;

				oasisAreaID = createArea();
				rmSetAreaWaterType(oasisAreaID, cPrimaryWaterTexture);
				rmSetAreaSize(oasisAreaID, oasisAreaFraction);
				rmSetAreaLocation(oasisAreaID, getLocX(i), getLocZ(i));

				rmSetAreaCoherence(oasisAreaID, 0.6);
				rmSetAreaBaseHeight(oasisAreaID, 2.0);
				rmSetAreaSmoothDistance(oasisAreaID, 10);

				rmSetAreaWarnFailure(oasisAreaID, false);
			}
		}

		rmBuildAllAreas();

		resetLocStorage();

		// Random variation to block settlements from center or not for > 1 oases.
		if(randChance()) {
			float fullOasisArea = areaRadiusMetersToFraction(oasisMaxRadiusMeters);

			oasisAreaID = createArea();
			rmSetAreaSize(oasisAreaID, areaRadiusMetersToFraction(oasisMaxRadiusMeters));
			rmSetAreaLocation(oasisAreaID, 0.5, 0.5);

			rmSetAreaCoherence(oasisAreaID, 1.0);

			rmAddAreaToClass(oasisAreaID, classFirstSettlementBlock);
			rmAddAreaToClass(oasisAreaID, classSecondSettlementBlock);
			// rmAddAreaToClass(oasisAreaID, classBonusResourceBlock);
			// rmAddAreaToClass(oasisAreaID, classMediumResourceBlock);
			rmSetAreaWarnFailure(oasisAreaID, false);
			rmBuildArea(oasisAreaID);

			// Random chance for center resources.
			if(randChance() && fullOasisArea > 0.1 && gameIs1v1()) {
				if(fullOasisArea < 0.175) {
					cMapBonusAreaSize = cBonusAreaSizeSmall;
				} else {
					cMapBonusAreaSize = cBonusAreaSizeMedium;
				}

				int fakeCenterID = createArea();
				rmSetAreaSize(fakeCenterID, areaRadiusMetersToFraction(oasisMaxRadiusMeters));
				rmSetAreaLocation(fakeCenterID, 0.5, 0.5);
				rmSetAreaCoherence(fakeCenterID, 1.0);
				rmSetAreaWarnFailure(fakeCenterID, false);
				rmBuildArea(fakeCenterID);

				buildFakePlayerAreasVsCenterBlock(fakeCenterID, classBonusResourceBlock);
				rmAddAreaToClass(fakeCenterID, classMediumResourceBlock);

			}
		}
	}
}

void placePlayersPlayerIslands() {
	float playerRadiusMin = 0.35;
	float playerRadiusMax = 0.4;
	float teamModifier = 1.0;

	// Only use circular placement here.
	placePlayersInCircle(playerRadiusMin, playerRadiusMax, teamModifier);
}

void genMapPlayerIslands() {
	cMapFirstSettlementInsideRule = cMapSettlementsInsideRuleNone;
	cMapSecondSettlementInsideRule = cMapSettlementsInsideRuleNone;

	if(cInitType == cInitTypeWater) {
		cMapHasWater = true;
		cMapFirstSettlementWaterRule = cMapSettlementsWaterRuleEither;
		cMapSecondSettlementWaterRule = cMapSettlementsWaterRuleEither;
	} else {
		cMapFirstSettlementWaterRule = cMapSettlementsWaterRuleNone;
		cMapSecondSettlementWaterRule = cMapSettlementsWaterRuleNone;
	}

	int classConnection = defineClass();
	int classPlayer = defineClass();

	float playerConnectionWidth = 0.0;
	float extraConnectionWidth = 25.0;

	if(gameIs1v1()) {
		playerConnectionWidth = 30.0;
	} else {
		playerConnectionWidth = 35.0 + 10.0 * rmRandInt(0, 1);
	}

	// Player connection.
	int playerConnectionID = createConnection();
	addAllConnectionTerrainReplacements(playerConnectionID, cPrimaryTerrainTexture);
	rmSetConnectionType(playerConnectionID, cConnectPlayers, false, 1.0);

	rmSetConnectionWidth(playerConnectionID, playerConnectionWidth);
	rmSetConnectionBaseHeight(playerConnectionID, 2.0);
	rmSetConnectionSmoothDistance(playerConnectionID, 10);
	if(cInitType == cInitTypeWater) {
		rmSetConnectionHeightBlend(playerConnectionID, 2);
	} else if(cInitType == cInitTypeCliff) {
		rmSetConnectionHeightBlend(playerConnectionID, 1);
	}
	// rmSetConnectionPositionVariance(playerConnectionID, 0.0);

	rmAddConnectionToClass(playerConnectionID, classConnection);
	rmSetConnectionWarnFailure(playerConnectionID, false);

	// Extra connection 1.
	int extraConnection1ID = createConnection();
	addAllConnectionTerrainReplacements(extraConnection1ID, cPrimaryTerrainTexture);
	rmSetConnectionType(extraConnection1ID, cConnectAreas, true, 1.0);

	rmSetConnectionWidth(extraConnection1ID, extraConnectionWidth);
	rmSetConnectionBaseHeight(extraConnection1ID, 2.0);
	rmSetConnectionSmoothDistance(extraConnection1ID, 10);
	if(cInitType == cInitTypeWater) {
		rmSetConnectionHeightBlend(extraConnection1ID, 2);
	} else if(cInitType == cInitTypeCliff) {
		rmSetConnectionHeightBlend(extraConnection1ID, 1);
	}
	rmSetConnectionPositionVariance(extraConnection1ID, -1.0);

	rmAddConnectionToClass(extraConnection1ID, classConnection);
	rmSetConnectionWarnFailure(extraConnection1ID, false);

	// Extra connection 2 (only for 1v1).
	int extraConnection2ID = createConnection();
	addAllConnectionTerrainReplacements(extraConnection2ID, cPrimaryTerrainTexture);
	rmSetConnectionType(extraConnection2ID, cConnectAreas, false, 1.0);

	rmSetConnectionWidth(extraConnection2ID, extraConnectionWidth);
	rmSetConnectionBaseHeight(extraConnection2ID, 2.0);
	rmSetConnectionSmoothDistance(extraConnection2ID, 10);
	if(cInitType == cInitTypeWater) {
		rmSetConnectionHeightBlend(extraConnection2ID, 2);
	} else if(cInitType == cInitTypeCliff) {
		rmSetConnectionHeightBlend(extraConnection2ID, 1);
	}
	rmSetConnectionPositionVariance(extraConnection2ID, -1.0);

	rmAddConnectionToClass(extraConnection2ID, classConnection);
	rmSetConnectionWarnFailure(extraConnection2ID, false);

	// Center area to block (Highland-style, water only).
	int avoidCenterArea = -1;
	bool buildCenterArea = randChance() && cInitType == cInitTypeWater && gameIs1v1() == false;

	if(buildCenterArea) {
		int centerID = createArea();
		rmSetAreaTerrainType(centerID, cPrimaryTerrainTexture);
		rmSetAreaSize(centerID, 0.0125 * rmRandInt(1, 2));
		rmSetAreaLocation(centerID, 0.5, 0.5);

		rmSetAreaCoherence(centerID, 1.0);
		rmSetAreaBaseHeight(centerID, 2.0);
		rmSetAreaHeightBlend(centerID, 2);

		rmAddAreaToClass(centerID, classFirstSettlementBlock);
		rmAddAreaToClass(centerID, classSecondSettlementBlock);
		rmAddAreaToClass(centerID, classUnbuildable); // Block most things from getting placed there.
		rmAddAreaToClass(centerID, classMiscResourceBlock); // Block everything else.
		rmSetAreaWarnFailure(centerID, false);
		rmBuildArea(centerID);

		avoidCenterArea = createAreaDistConstraint(centerID, smallerFractionToMeters(0.075));

		// Allow fishing (currently guaranteed).
		cMapHasFish = randChance(1.0);
	}

	// Set up player areas.
	int avoidPlayer = createClassDistConstraint(classPlayer, 27.5);

	for(i = 1; < cPlayers) {
		int playerAreaID = createArea();
		rmSetAreaTerrainType(playerAreaID, cPrimaryTerrainTexture);
		rmSetAreaSize(playerAreaID, 1.0 / cNonGaiaPlayers);
		rmSetAreaLocPlayer(playerAreaID, getPlayer(i));

		rmSetAreaTerrainLayerVariance(playerAreaID, false);
		rmSetAreaCoherence(playerAreaID, 0.5);
		rmSetAreaBaseHeight(playerAreaID, 2.0);

		rmAddAreaToClass(playerAreaID, classPlayer);
		rmAddConnectionArea(playerConnectionID, playerAreaID);
		rmAddConnectionArea(extraConnection1ID, playerAreaID);
		rmAddConnectionArea(extraConnection2ID, playerAreaID);
		rmAddAreaConstraint(playerAreaID, avoidPlayer);
		rmSetAreaWarnFailure(playerAreaID, false);

		// Terrain-based parameters.
		if(cInitType == cInitTypeWater) {
			// Water: Blend and avoid center island for teamgames.
			rmSetAreaHeightBlend(playerAreaID, 2);

			if(gameIs1v1() == false && avoidCenterArea != -1) {
				rmAddAreaConstraint(playerAreaID, avoidCenterArea);
			}
		} else if(cInitType == cInitTypeCliff) {
			// Cliff: Add cliff terrain layer at the edge for nicer looks.
			rmAddAreaTerrainLayer(playerAreaID, cPrimaryImpassableCliffTexture, 0, 1);
		}
	}

	rmBuildAllAreas();

	rmBuildConnection(playerConnectionID);

	if(gameIs1v1()) {
		rmBuildConnection(extraConnection1ID);
		rmBuildConnection(extraConnection2ID);
	} else if(buildCenterArea == false) {
		rmBuildConnection(extraConnection1ID);
	} else {
		// TODO Build decoration for center island.
	}

	if(cInitType == cInitTypeTerrain) {
		int classPlayerIslandsForest = defineClass();
		int avoidPlayerIslandsForest = createClassDistConstraint(classPlayerIslandsForest, 1.0);
		int avoidConnections = createClassDistConstraint(classConnection, 1.0);
		int avoidPlayers = createClassDistConstraint(classPlayer, 1.0);

		for(i = 0; < 3 * cNonGaiaPlayers) {
			int playerIslandsForestID = createArea();
			rmSetAreaForestType(playerIslandsForestID, cPrimaryForestTexture);
			rmSetAreaSize(playerIslandsForestID, 0.2);

			rmSetAreaCoherence(playerIslandsForestID, 1.0);
			rmSetAreaBaseHeight(playerIslandsForestID, 2.0);
			rmSetAreaHeightBlend(playerIslandsForestID, 2);

			rmAddAreaConstraint(playerIslandsForestID, avoidPlayerIslandsForest);
			rmAddAreaConstraint(playerIslandsForestID, avoidConnections);
			rmAddAreaConstraint(playerIslandsForestID, avoidPlayers);
			rmAddAreaToClass(playerIslandsForestID, classPlayerIslandsForest);
			rmAddAreaToClass(playerIslandsForestID, classFirstSettlementBlock);
			rmAddAreaToClass(playerIslandsForestID, classSecondSettlementBlock);
			rmSetAreaWarnFailure(playerIslandsForestID, false);
			rmBuildArea(playerIslandsForestID);
		}
	}
}

const string cCenterIslandsPlayerAreaLabel = "center island player area";

void placePlayersCenterIslands() {
	float playerRadiusMin = 0.0;
	float playerRadiusMax = 0.0;
	float teamModifier = 1.0;

	if(cNonGaiaPlayers < 9) {
		playerRadiusMin = 0.4;
		playerRadiusMax = 0.4;
	} else {
		playerRadiusMin = 0.45;
		playerRadiusMax = 0.45;
	}

	// Only use circular placement here.
	placePlayersInCircle(playerRadiusMin, playerRadiusMax, teamModifier);
}

const int cCenterIslandsMarsh = 0;
const int cCenterIslandsWh = 1;

void genMapCenterIslands() {
	cMapHasWater = true;
	if(randChance()) {
		// This is only used for decoration, randomize it here.
		cMapHasLargeWaterBody = true;
	}

	cMapFirstSettlementInsideRule = cMapSettlementsInsideRuleNone;
	cMapSecondSettlementInsideRule = cMapSettlementsInsideRuleNone;

	// Small player areas, place stuff in player areas for teamgames.
	cMapHasSmallPlayerAreas = gameIs1v1() == false;
	cMapMirrorInBonusArea = true;
	cMapBonusAreaSize = cBonusAreaSizeLarge;

	int centerIslandsType = rmRandInt(0, 1); // 0 Marsh, 1 WH.

	if(gameIs1v1()) {
		if(centerIslandsType == cCenterIslandsMarsh || gameIs1v1()) {
			cMapFirstSettlementWaterRule = cMapSettlementsWaterRuleEither;
			cMapSecondSettlementWaterRule = cMapSettlementsWaterRuleEither;
		} else if(centerIslandsType == cCenterIslandsWh) {
			cMapFirstSettlementWaterRule = cMapSettlementsWaterRuleForceAvoidFar;
			cMapSecondSettlementWaterRule = cMapSettlementsWaterRuleForceAvoidFar;
		}
	} else {
		cMapFirstSettlementWaterRule = cMapSettlementsWaterRuleNone;
		cMapSecondSettlementWaterRule = cMapSettlementsWaterRuleNone;
	}

	printDebug("centerIslandsType: " + centerIslandsType, cDebugFull);

	float playerBaseRadiusMeters = 60.0;

	// Player cores have a radius of 6 meters, so the total base area will be around 66 meters.
	int avoidPlayerCore = createClassDistConstraint(classPlayerCore, playerBaseRadiusMeters);

	// Marsh: 28 everywhere, WH: 20, 16, 16, 10.
	// Probably truncated to int so just go for +1 max here.
	float connectionWidth = rmRandFloat(15.0, 31.0);
	float allyConnectionWidth = rmRandFloat(15.0, 31.0);
	float settlementConnectionWidth = rmRandFloat(15.0, 31.0);

	// This is by far the most important factor for 1v1 variations.
	float extraConnectionWidth = 0.0;

	if(randChance(1.0 / 3.0)) {
		// Chance for random override.
		extraConnectionWidth = rmRandFloat(15.0, 26.0);
	} else if(centerIslandsType == cCenterIslandsMarsh) {
		extraConnectionWidth = rmRandFloat(25.0, 31.0);
	} else if(centerIslandsType == cCenterIslandsWh) {
		extraConnectionWidth = rmRandFloat(12.0, 19.0);
	}

	printDebug("extraConnectionWidth: " + extraConnectionWidth, cDebugFull);

	int classIsland = defineClass();
	int classPlayer = defineClass();

	// Connections.
	// Create player connections.
	int playerConnectionID = createConnection();
	addAllConnectionTerrainReplacements(playerConnectionID, cPrimaryTerrainTexture);
	rmSetConnectionType(playerConnectionID, cConnectAreas, false, 1.0);

	rmSetConnectionWidth(playerConnectionID, connectionWidth);
	rmSetConnectionBaseHeight(playerConnectionID, 2.0);
	rmSetConnectionHeightBlend(playerConnectionID, 2);

	rmAddConnectionToClass(playerConnectionID, classMediumResourceBlock);
	rmSetConnectionWarnFailure(playerConnectionID, false);

	// Create extra connections (1v1).
	int extraConnectionID = createConnection();
	addAllConnectionTerrainReplacements(extraConnectionID, cPrimaryTerrainTexture);
	rmSetConnectionType(extraConnectionID, cConnectAreas, false, 1.0);

	rmSetConnectionWidth(extraConnectionID, extraConnectionWidth);
	rmSetConnectionBaseHeight(extraConnectionID, 2.0);
	rmSetConnectionHeightBlend(extraConnectionID, 2);
	rmSetConnectionPositionVariance(extraConnectionID, -1.0);

	rmAddConnectionToClass(extraConnectionID, classMediumResourceBlock);
	rmAddConnectionStartConstraint(extraConnectionID, avoidPlayerCore);
	rmAddConnectionEndConstraint(extraConnectionID, avoidPlayerCore);
	rmSetConnectionWarnFailure(extraConnectionID, false);

	// Create team connections.
	int teamConnectionID = createConnection();
	addAllConnectionTerrainReplacements(teamConnectionID, cPrimaryTerrainTexture);
	rmSetConnectionType(teamConnectionID, cConnectAllies, false, 1.0);

	rmSetConnectionWidth(teamConnectionID, allyConnectionWidth);
	rmSetConnectionBaseHeight(teamConnectionID, 2.0);
	rmSetConnectionHeightBlend(teamConnectionID, 2);

	rmAddConnectionToClass(teamConnectionID, classMediumResourceBlock);
	rmSetConnectionWarnFailure(teamConnectionID, false);

	// Define 3rd settlement connections.
	if(gameIs1v1() == false || centerIslandsType == cCenterIslandsMarsh) {
		for(i = 1; < cPlayers) {
			int connectionID = createConnection();
			addAllConnectionTerrainReplacements(connectionID, cPrimaryTerrainTexture);
			rmSetConnectionType(connectionID, cConnectAreas, false, 1.0);

			rmSetConnectionWidth(connectionID, settlementConnectionWidth);
			rmSetConnectionBaseHeight(connectionID, 2.0);
			rmSetConnectionHeightBlend(connectionID, 2);

			rmSetConnectionWarnFailure(connectionID, false);

			// Store in array.
			setConnectionID(i, connectionID);
		}
	}

	// Center.
	float bonusIslandSize = areaRadiusMetersToFraction(65.0);
	float separatorWidthMeters = 20.0;
	float islandEdgeDist = 0.0;

	if(cNumPlayerTiles <= 7500 && gameIs1v1()) {
		// 1v1 with smaller variation.
		islandEdgeDist = smallerMetersToFraction(70.0);
	} else {
		// Teamgames or larger variation.
		if(randChance()) {
			cMapCanHaveTwoCenterRelics = true;
			islandEdgeDist = smallerMetersToFraction(70.0);
		} else {
			if(gameIs1v1() && centerIslandsType == cCenterIslandsWh) {
			}
			islandEdgeDist = smallerMetersToFraction(rmRandFloat(75.0, 85.0));
		}
	}

	printDebug("islandEdgeDist: " + islandEdgeDist, cDebugFull);

	int islandAvoidEdge = createSymmetricBoxConstraint(islandEdgeDist);
	int avoidIsland = createClassDistConstraint(classIsland, separatorWidthMeters);

	if(centerIslandsType == cCenterIslandsMarsh) {
		// Place center islands in a circle to make sure every player has space for the forward settlement.
		float areaCircleRadius = 0.5 * (0.5 * getFullXMeters() - 60.0);

		placeLocationsInCircle(max(4, cNonGaiaPlayers), smallerMetersToFraction(areaCircleRadius), getPlayerAngle(1));

		for(i = 1; <= max(4, cNonGaiaPlayers)) {
			int bonusIslandID = createArea();
			rmSetAreaTerrainType(bonusIslandID, cPrimaryTerrainTexture);
			rmSetAreaSize(bonusIslandID, bonusIslandSize);
			rmSetAreaLocation(bonusIslandID, getLocX(i), getLocZ(i));

			rmSetAreaCoherence(bonusIslandID, 0.0);
			rmSetAreaBaseHeight(bonusIslandID, 2.0);
			rmSetAreaHeightBlend(bonusIslandID, 2);

			rmAddAreaToClass(bonusIslandID, classFirstSettlementBlock);
			rmAddAreaToClass(bonusIslandID, classMediumResourceBlock);
			rmAddAreaToClass(bonusIslandID, classIsland);
			rmAddAreaConstraint(bonusIslandID, avoidIsland);
			rmAddAreaConstraint(bonusIslandID, islandAvoidEdge);
			rmAddAreaConstraint(bonusIslandID, avoidPlayerCore);
			rmAddConnectionArea(playerConnectionID, bonusIslandID);
			rmAddConnectionArea(extraConnectionID, bonusIslandID);
			rmSetAreaWarnFailure(bonusIslandID, false);
		}

		resetLocStorage();
	} else if(centerIslandsType == cCenterIslandsWh) {
		// Keep distance from edge as sum of minimum player area width, separator (river) width, and a buffer.
		float centerEdgeFraction = islandEdgeDist + smallerMetersToFraction(separatorWidthMeters + 5.0);

		if(gameIs1v1()) {
			int numBonusIsland = rmRandInt(4, 5);

			// 1v1.
			for(i = 0; < numBonusIsland) {
				float randX = rmRandFloat(centerEdgeFraction, 1.0 - centerEdgeFraction);
				float randZ = rmRandFloat(centerEdgeFraction, 1.0 - centerEdgeFraction);

				for(j = 0; < 2) {
					bonusIslandID = createArea();
					rmSetAreaTerrainType(bonusIslandID, cPrimaryTerrainTexture);
					rmSetAreaSize(bonusIslandID, bonusIslandSize);
					if(j == 0) {
						rmSetAreaLocation(bonusIslandID, randX, randZ);
					} else if(j == 1) {
						rmSetAreaLocation(bonusIslandID, 1.0 - randX, 1.0 - randZ);
					}

					rmSetAreaCoherence(bonusIslandID, 1.0);
					rmSetAreaBaseHeight(bonusIslandID, 2.0);
					rmSetAreaHeightBlend(bonusIslandID, 2);

					rmAddAreaToClass(bonusIslandID, classFirstSettlementBlock);
					rmAddAreaToClass(bonusIslandID, classMediumResourceBlock);
					rmAddAreaToClass(bonusIslandID, classIsland);
					rmAddAreaConstraint(bonusIslandID, islandAvoidEdge);
					rmAddAreaConstraint(bonusIslandID, avoidPlayerCore);
					rmAddConnectionArea(playerConnectionID, bonusIslandID);
					rmAddConnectionArea(extraConnectionID, bonusIslandID);
					rmSetAreaWarnFailure(bonusIslandID, false);
					rmBuildArea(bonusIslandID);
				}
			}
		} else {
			// Anything but 1v1.
			bonusIslandID = createArea();
			rmSetAreaTerrainType(bonusIslandID, cPrimaryTerrainTexture);
			rmSetAreaSize(bonusIslandID, 0.5);
			rmSetAreaLocation(bonusIslandID, 0.5, 0.5);

			rmSetAreaCoherence(bonusIslandID, 1.0);
			rmSetAreaBaseHeight(bonusIslandID, 2.0);
			rmSetAreaHeightBlend(bonusIslandID, 2);

			rmAddAreaToClass(bonusIslandID, classFirstSettlementBlock);
			rmAddAreaToClass(bonusIslandID, classMediumResourceBlock);
			rmAddAreaToClass(bonusIslandID, classIsland);
			rmAddAreaConstraint(bonusIslandID, avoidPlayerCore);
			rmAddAreaConstraint(bonusIslandID, islandAvoidEdge);
			rmAddConnectionArea(playerConnectionID, bonusIslandID);
			rmAddConnectionArea(extraConnectionID, bonusIslandID);
			rmSetAreaWarnFailure(bonusIslandID, false);
			rmBuildArea(bonusIslandID);
		}
	}

	rmBuildAllAreas();

	// Set up player areas.
	int avoidPlayer = createClassDistConstraint(classPlayer, separatorWidthMeters);

	for(i = 1; < cPlayers) {
		int playerAreaID = createArea(cCenterIslandsPlayerAreaLabel + " " + i);
		rmSetAreaTerrainType(playerAreaID, cPrimaryTerrainTexture);
		rmSetAreaSize(playerAreaID, 0.5);
		rmSetAreaLocPlayer(playerAreaID, getPlayer(i));

		rmSetAreaCoherence(playerAreaID, 0.5);
		rmSetAreaBaseHeight(playerAreaID, 2.0);
		rmSetAreaHeightBlend(playerAreaID, 2);

		rmAddAreaToClass(playerAreaID, classPlayer);
		rmAddAreaToClass(playerAreaID, classSecondSettlementBlock);
		rmAddAreaToClass(playerAreaID, classBonusResourceBlock);
		rmAddAreaConstraint(playerAreaID, avoidIsland);
		rmAddAreaConstraint(playerAreaID, avoidPlayer);
		rmSetAreaWarnFailure(playerAreaID, false);
	}

	// Add the previously defined areas in a new order to the connection.
	int currPlayer = 0;

	for(i = 1; < cPlayers) {
		int nextPlayer = INF;
		int nextPlayerID = -1;

		// Go through all players and pick the one with the lowest ID that is larger than the current one.
		for(j = 1; < cPlayers) {
			int tempPlayer = getPlayer(j);

			if(tempPlayer < nextPlayer && tempPlayer > currPlayer) {
				nextPlayer = tempPlayer;
				nextPlayerID = j;
			}
		}

		// Get player areas defined above.
		int tempPlayerAreaID = rmAreaID(cCenterIslandsPlayerAreaLabel + " " + nextPlayerID);

		rmAddConnectionArea(playerConnectionID, tempPlayerAreaID);
		rmAddConnectionArea(extraConnectionID, tempPlayerAreaID);
		if(getConnectionID(nextPlayerID) != -1) {
			rmAddConnectionArea(getConnectionID(nextPlayerID), tempPlayerAreaID);
		}

		currPlayer = nextPlayer;
	}

	// Build the fake player areas.
	rmBuildAllAreas();

	// Build connections.
	rmBuildConnection(playerConnectionID);
	rmBuildConnection(teamConnectionID);
	if(gameIs1v1()) {
		rmBuildConnection(extraConnectionID);
	}

	// Variation tha only leaves 2 rivers on the sides (usually like a T with the root from the map edge).
	if(randChance() && gameIs1v1() == false) {
		int classTeam = defineClass();

		// Since we're not building the splits with coherence 1.0, they are different and we have to avoid further.
		int avoidTeam = createClassDistConstraint(classTeam, 4.0 * separatorWidthMeters);

		float fakeCenterFraction = areaRadiusMetersToFraction(cMinPlayerRadiusMeters - playerBaseRadiusMeters);

		int fakeCenterID = createArea();
		rmSetAreaSize(fakeCenterID, fakeCenterFraction);
		rmSetAreaLocation(fakeCenterID, 0.5, 0.5);
		rmSetAreaCoherence(fakeCenterID, 1.0);
		rmSetAreaWarnFailure(fakeCenterID, false);
		rmBuildArea(fakeCenterID);

		int avoidFakeCenter = createAreaDistConstraint(fakeCenterID, 1.0);

		for(i = 0; < cTeams) {
			int teamAreaID = createArea();
			rmSetAreaTerrainType(teamAreaID, cPrimaryTerrainTexture);
			rmSetAreaSize(teamAreaID, 0.5);
			rmSetAreaLocTeam(teamAreaID, i);

			rmSetAreaCoherence(teamAreaID, 0.0);
			rmSetAreaBaseHeight(teamAreaID, 2.0);
			rmSetAreaHeightBlend(teamAreaID, 2);

			rmAddAreaToClass(teamAreaID, classTeam);
			rmAddAreaConstraint(teamAreaID, avoidTeam);
			rmAddAreaConstraint(teamAreaID, avoidFakeCenter);
			rmSetAreaWarnFailure(teamAreaID, false);
		}

		rmBuildAllAreas();

		// Chance to force features.
		if(randChance(2.0 / 3.0)) {
			if(randChance(1.0 / 3.0)) {
				cMapForceFeatures = cForceFeatureAll;
			} else {
				if(randChance()) {
					cMapForceFeatures = cForceFeatureCliffs;
				} else {
					cMapForceFeatures = cForceFeaturePonds;
				}
			}
		}
	} else {
		// Allow fishing for WH-style teamgames.
		cMapHasFish = randChance() && gameIs1v1() == false && centerIslandsType == cCenterIslandsWh;

		// Don't mirror fish for random matchups.
		cMapHasNonMirroredFish = cMapHasFish && gameHasTwoEqualTeams() == false;

		// Don't allow cliffs and ponds anywhere.
		cMapFeatureRestriction = cFeatureRestrictionEverywhere;
	}
}

void placePlayersSmallCenterIsland() {
	float playerRadiusMin = 0.4;
	float playerRadiusMax = 0.4;
	float teamModifier = 1.0;

	// Only use circular placement here.
	placePlayersInCircle(playerRadiusMin, playerRadiusMax, teamModifier);
}

void genMapSmallCenterIsland() {
	cMapHasWater = true;
	cMapFeatureRestriction = cFeatureRestrictionEverywhere; // Too little terrain for features.

	cMapFirstSettlementInsideRule = cMapSettlementsInsideRuleNone;
	cMapSecondSettlementInsideRule = cMapSettlementsInsideRuleNone;

	cMapFirstSettlementWaterRule = cMapSettlementsWaterRuleNone;
	cMapSecondSettlementWaterRule = cMapSettlementsWaterRuleNone;

	// Block features if too small.
	if(cNumPlayerTiles < 9000) {
		cMapHasSmallPlayerAreas = gameIs1v1() == false;
		cMapHasMirroredSettlements = gameIs1v1() == false;
	}

	int classConnection = defineClass();
	int classPlayer = defineClass();

	// Build small center.
	float centerAreaFraction = 0.0;

	if(gameIs1v1()) {
		centerAreaFraction = 0.05;
	} else {
		cMapMirrorInBonusArea = true;
		centerAreaFraction = 0.1;
		cMapBonusAreaSize = cBonusAreaSizeSmall;
	}

	int centerID = createArea();
	rmSetAreaTerrainType(centerID, cPrimaryTerrainTexture);
	rmSetAreaSize(centerID, centerAreaFraction);
	rmSetAreaLocation(centerID, 0.5, 0.5);

	rmSetAreaCoherence(centerID, 1.0);
	rmSetAreaBaseHeight(centerID, 2.0);
	rmSetAreaHeightBlend(centerID, 2);

	rmAddAreaToClass(centerID, classMediumResourceBlock);
	rmSetAreaWarnFailure(centerID, false);
	rmBuildArea(centerID);

	if(gameIs1v1()) {
		// Don't allow anything into the tiny center in 1v1.
		rmAddAreaToClass(centerID, classBonusResourceBlock);
		rmAddAreaToClass(centerID, classMiscResourceBlock);
	} else {
		// Allow stuff into the center in team games.
		buildFakePlayerAreasVsCenterBlock(centerID, classBonusResourceBlock);
	}

	// Build player/team continents.
	float mapWaterFraction = 0.175;
	int avoidCenter = createAreaDistConstraint(centerID, 17.5);
	int playerAreaID = -1;

	if(randChance()) {
		// Players.
		for(i = 1; < cPlayers) {
			playerAreaID = createArea();
			rmSetAreaTerrainType(playerAreaID, cPrimaryTerrainTexture);
			rmSetAreaSize(playerAreaID, (1.0 - centerAreaFraction - mapWaterFraction) / cNonGaiaPlayers);
			rmSetAreaLocPlayer(playerAreaID, getPlayer(i));

			rmSetAreaCoherence(playerAreaID, 1.0);
			rmSetAreaBaseHeight(playerAreaID, 2.0);
			rmSetAreaHeightBlend(playerAreaID, 2);

			rmAddAreaToClass(playerAreaID, classPlayer);
			rmAddAreaConstraint(playerAreaID, avoidCenter);
			rmSetAreaWarnFailure(playerAreaID, false);
		}
	} else {
		// Teams.
		for(i = 0; < cTeams) {
			playerAreaID = createArea();
			rmSetAreaTerrainType(playerAreaID, cPrimaryTerrainTexture);
			rmSetAreaSize(playerAreaID, (1.0 - centerAreaFraction - mapWaterFraction) / cTeams);
			rmSetAreaLocTeam(playerAreaID, i);

			rmSetAreaTerrainLayerVariance(playerAreaID, false);
			rmSetAreaCoherence(playerAreaID, 1.0);
			rmSetAreaBaseHeight(playerAreaID, 2.0);
			rmSetAreaHeightBlend(playerAreaID, 2);

			// rmAddAreaToClass(playerAreaID, classTeam);
			rmAddAreaToClass(playerAreaID, classPlayer);
			rmAddAreaConstraint(playerAreaID, avoidCenter);
			rmSetAreaWarnFailure(playerAreaID, false);
		}
	}

	// Build player connections in teamgames just in case.
	if(gameIs1v1() == false) {
		// Player connection.
		int playerConnectionID = createConnection();
		addAllConnectionTerrainReplacements(playerConnectionID, cPrimaryTerrainTexture);
		rmSetConnectionType(playerConnectionID, cConnectPlayers, false, 1.0);

		rmSetConnectionWidth(playerConnectionID, 30.0);
		rmSetConnectionBaseHeight(playerConnectionID, 2.0);
		rmSetConnectionSmoothDistance(playerConnectionID, 10);
		if(cInitType == cInitTypeWater) {
			rmSetConnectionHeightBlend(playerConnectionID, 2);
		} else if(cInitType == cInitTypeCliff) {
			rmSetConnectionHeightBlend(playerConnectionID, 1);
		}
		// rmSetConnectionPositionVariance(playerConnectionID, 0.0);

		rmAddConnectionToClass(playerConnectionID, classConnection);
		rmSetConnectionWarnFailure(playerConnectionID, false);

		// Connect to tiny fake player areas.
		for(i = 1; < cPlayers) {
			rmAddConnectionArea(playerConnectionID, rmAreaID(cPlayerCoreAreaLabel + " " + i));
		}

		rmBuildConnection(playerConnectionID);
	}

	rmBuildAllAreas();

	// Always build connections for teamgames, randomize for 1v1.
	bool buildConnections = gameHasTwoEqualTeams() && (gameIs1v1() == false || randChance() || cNumPlayerTiles >= 9000);
	bool buildInner = false;
	bool buildOuter = false;

	// Build connections for team games with equal teams.
	if(buildConnections) {
		float lakeConnectionFloat = rmRandFloat(0.0, 1.0);

		if(lakeConnectionFloat < 0.5) {
			buildInner = true;
			buildOuter = true;
		} else if(lakeConnectionFloat < 0.75) {
			buildInner = true;
		} else {
			buildOuter = true;
		}

		int numPlayersPerTeam = getNumberPlayersOnTeam(0);
		float connectionWidthMeters = rmRandFloat(20.0, 30.0);

		for(i = 1; <= numPlayersPerTeam) {
			// Always build all if > 2 players on team.
			if(numPlayersPerTeam > 2) {
				if(buildOuter == false && (i == 1 || i == numPlayersPerTeam)) {
					continue;
				}

				if(buildInner == false && (i != 1 && i != numPlayersPerTeam)) {
					continue;
				}
			}

			int lakeConnectionID = createConnection();
			addAllConnectionTerrainReplacements(lakeConnectionID, cPrimaryTerrainTexture);
			rmSetConnectionType(lakeConnectionID, cConnectAreas, false);
			rmAddConnectionArea(lakeConnectionID, rmAreaID(cPlayerCoreAreaLabel + " " + i));
			rmAddConnectionArea(lakeConnectionID, rmAreaID(cPlayerCoreAreaLabel + " " + (i + numPlayersPerTeam)));

			rmSetConnectionWidth(lakeConnectionID, connectionWidthMeters, 2);
			rmSetConnectionBaseHeight(lakeConnectionID, 2.0);
			rmSetConnectionHeightBlend(lakeConnectionID, 2);
			rmSetConnectionSmoothDistance(lakeConnectionID, 5);

			// rmAddConnectionToClass(lakeConnectionID, classMediumResourceBlock);
			rmAddConnectionToClass(lakeConnectionID, classConnection);
			rmSetConnectionWarnFailure(lakeConnectionID, false);
			rmBuildConnection(lakeConnectionID);
		}
	}

	bool buildSeparator = gameHasTwoEqualTeams() && randChance(1.0 / 3.0);

	// Chance for connection between the players (a wall basically, but land instead of water).
	if(buildSeparator) {
		float fractionDist = 0.5;

		placeLocationsInCircle(2, 0.5 * fractionDist, getTeamAngle(0) + 0.5 * PI);

		float lineWidth = 40.0;
		float lineFraction = (lineWidth * smallerFractionToMeters(fractionDist)) / getMapAreaInMeters();

		int lineID = createArea();
		rmSetAreaTerrainType(lineID, cPrimaryTerrainTexture);
		rmSetAreaSize(lineID, lineFraction);
		rmSetAreaLocation(lineID, 0.5, 0.5);
		rmAddAreaInfluenceSegment(lineID, getLocX(1), getLocZ(1), getLocX(2), getLocZ(2));

		rmSetAreaCoherence(lineID, 0.5);
		rmSetAreaBaseHeight(lineID, 2.0);
		rmSetAreaHeightBlend(lineID, 2);

		// rmAddAreaToClass(lineID, classMediumResourceBlock);
		rmSetAreaWarnFailure(lineID, false);
		rmBuildArea(lineID);

		resetLocStorage();
	}

	// Side-water replacement.
	if(randChance(1.0 / 3.0)) {
		int classPlayerIslandsForest = defineClass();
		int avoidPlayerIslandsForest = createClassDistConstraint(classPlayerIslandsForest, 1.0);
		int avoidConnections = createClassDistConstraint(classConnection, 1.0);
		int avoidPlayers = createClassDistConstraint(classPlayer, 1.0);
		avoidCenter = createAreaDistConstraint(centerID, 20.0);

		// Only do forests, cliffs won't work here (would require cliff init and separate center river generation).

		for(i = 0; < 3 * cNonGaiaPlayers) {
			int playerIslandsForestID = createArea();
			rmSetAreaForestType(playerIslandsForestID, cPrimaryForestTexture);
			rmSetAreaSize(playerIslandsForestID, 0.2);

			rmSetAreaCoherence(playerIslandsForestID, 1.0);
			rmSetAreaBaseHeight(playerIslandsForestID, 2.0);
			rmSetAreaHeightBlend(playerIslandsForestID, 2);

			rmAddAreaConstraint(playerIslandsForestID, avoidPlayerIslandsForest);
			rmAddAreaConstraint(playerIslandsForestID, avoidConnections);
			rmAddAreaConstraint(playerIslandsForestID, avoidPlayers);
			rmAddAreaConstraint(playerIslandsForestID, avoidCenter);
			rmAddAreaToClass(playerIslandsForestID, classPlayerIslandsForest);
			rmAddAreaToClass(playerIslandsForestID, classFirstSettlementBlock);
			rmAddAreaToClass(playerIslandsForestID, classSecondSettlementBlock);
			rmSetAreaWarnFailure(playerIslandsForestID, false);
			rmBuildArea(playerIslandsForestID);
		}
	} else {
		if(randChance()) {
			// This is only used for decoration, randomize it here.
			cMapHasLargeWaterBody = true;
		}
	}

	// Allow fishing (currently guaranteed), but not if we build both passages.
	cMapHasFish = (buildConnections && buildSeparator) == false;

	if(buildConnections == false && buildSeparator == false) {
		// If we have no connections, make the center island unbuildable (no resources).
		rmAddAreaToClass(centerID, classUnbuildable);

		// TODO Potentially add some decoration here for the island (1 gold, small hunt, ...).
	}
}

const int cContinentSurroundingsWater = 0;
const int cContinentSurroundingsEmptyLand = 1;
const int cContinentSurroundingsForest = 2;
const int cContinentSurroundingsCliff = 3;

// Technically not constants, but should only be set once upon initialization.
int cContinentSurroundings = -1;
float cContinentEdgeDist = 0.0;
float cContinentPlayerAreaRadius = 0.0;

void placePlayersContinent(int surroundings = cContinentSurroundingsWater, float edgeDist = 30.0, float playerAreaRadius = 40.0) {
	cContinentSurroundings = surroundings;
	cContinentEdgeDist = edgeDist;
	cContinentPlayerAreaRadius = playerAreaRadius;

	float playerRadiusMin = 0.0;
	float playerRadiusMax = 0.0;
	float teamModifier = 0.0;

	if(gameIs1v1()) {
		// Calculate those to make sure placement is correct, also for rectangular maps.
		playerRadiusMax = 0.5 - largerMetersToFraction(cContinentEdgeDist + cContinentPlayerAreaRadius);
		playerRadiusMin = min(playerRadiusMax, smallerMetersToFraction(85.0)); // Second value: Minimum meters between players.

		if(isMapSquare() == false && gameIs1v1()) {
			// Adjust placement angle for 1v1 to make sure players don't spawn too close on rectangular maps.
			float angle = 0.0;

			if(isXLargerZ()) {
				angle = rmRandFloat(-0.25, 0.25) * PI  + rmRandInt(0, 1) * PI;
			} else {
				angle = rmRandFloat(0.25, 0.75) * PI  + rmRandInt(0, 1) * PI;
			}

			placePlayersInCircle(playerRadiusMin, playerRadiusMax, 1.0, 1.0, angle);
		} else if(randChance()) {
			placePlayersInCircle(playerRadiusMin, playerRadiusMax);
		} else {
			// This allows for corner spawns with larger distances between players and more variation.
			placePlayersInSquare(playerRadiusMin, playerRadiusMax);
		}
	} else {
		if(cNonGaiaPlayers < 9 && gameHasTwoEqualTeams()) {
			teamModifier = randLargeFloat(0.75, 1.0);
		} else {
			teamModifier = randLargeFloat(0.85, 1.0);
		}
		playerRadiusMin = 0.325;
		playerRadiusMax = max(playerRadiusMin, 0.5 - smallerMetersToFraction(cContinentEdgeDist + cContinentPlayerAreaRadius));

		placePlayersInCircle(playerRadiusMin, playerRadiusMax, teamModifier);
	}
}

void genMapContinent() {
	cMapFirstSettlementInsideRule = cMapSettlementsInsideRuleNone;
	cMapSecondSettlementInsideRule = cMapSettlementsInsideRuleNone;

	if(cContinentSurroundings == cContinentSurroundingsWater && gameHasTwoEqualTeams() && cNonGaiaPlayers < 7) {
		// Forcing to water is impossible for 4v4 and beyond, this will reduce the loadtime.
		cMapFirstSettlementWaterRule = cMapSettlementsWaterRuleEither;
		cMapSecondSettlementWaterRule = cMapSettlementsWaterRuleEither;
	} else {
		cMapFirstSettlementWaterRule = cMapSettlementsWaterRuleForceAvoidFar;
		cMapSecondSettlementWaterRule = cMapSettlementsWaterRuleForceAvoidFar;
	}

	int classCenter = defineClass();
	int classPlayer = defineClass();

	float playerIslandFraction = 0.0;
	float blobFraction = 0.0;
	int continentHeightBlend = 0;

	if(cContinentSurroundings == cContinentSurroundingsWater) {
		cMapHasWater = true;
		cMapHasLargeWaterBody = true;
		cMapHasFish = true; // Allow fishing.
		continentHeightBlend = 2;
	}

	if(cContinentSurroundings != cContinentSurroundingsForest) {
		playerIslandFraction = areaRadiusMetersToFraction(cContinentPlayerAreaRadius + 7.5);
		blobFraction = areaRadiusMetersToFraction(cContinentPlayerAreaRadius + 10.0);
	} else {
		playerIslandFraction = areaRadiusMetersToFraction(cContinentPlayerAreaRadius);
		blobFraction = areaRadiusMetersToFraction(cContinentPlayerAreaRadius);
	}

	int continentBoxConstraint = createSymmetricBoxConstraint(rmXMetersToFraction(cContinentEdgeDist), rmZMetersToFraction(cContinentEdgeDist), 0.01);

	// Player areas.
	for(i = 1; < cPlayers) {
		int playerIslandAreaID = createArea();
		if(cContinentSurroundings == cContinentSurroundingsEmptyLand) {
			rmSetAreaTerrainType(playerIslandAreaID, cPrimaryUnbuildableSurroundTexture);
		} else {
			rmSetAreaTerrainType(playerIslandAreaID, cPrimaryTerrainTexture);
		}
		rmSetAreaSize(playerIslandAreaID, playerIslandFraction);
		rmSetAreaLocPlayer(playerIslandAreaID, getPlayer(i));

		rmSetAreaCoherence(playerIslandAreaID, 1.0);
		rmSetAreaBaseHeight(playerIslandAreaID, 2.0);
		rmSetAreaHeightBlend(playerIslandAreaID, continentHeightBlend);
		rmSetAreaSmoothDistance(playerIslandAreaID, 10);

		rmAddAreaToClass(playerIslandAreaID, classCenter);
		rmAddAreaToClass(playerIslandAreaID, classPlayer);
		rmAddAreaConstraint(playerIslandAreaID, continentBoxConstraint);
		rmSetAreaWarnFailure(playerIslandAreaID, false);
	}

	rmBuildAllAreas();

	// Decorate continent with additional areas.
	float continentPlayerRadius = smallerMetersToFraction(cMinPlayerRadiusMeters);

	int continentBlobID = -1;
	int numBlobs = 12 * cNonGaiaPlayers;
	int blobAvoidPlayer = createClassDistConstraint(classPlayer, 1.0);

	float currAngle = 0.0;
	float angleIncrement = PI / numBlobs;

	float minVariance = 0.0;
	float maxVariance = 0.0;

	if(randChance()) {
		// Rather big continent.
		minVariance = -0.025;
		maxVariance = 0.025;
	} else {
		// Rather small continent.
		minVariance = -0.1;
		maxVariance = 0.0;
	}

	for(i = 0; < numBlobs) {
		float radiusVariance = rmRandFloat(minVariance, maxVariance);
		float x = getXFromPolarForPlayer(0, continentPlayerRadius + radiusVariance, currAngle);
		float z = getZFromPolarForPlayer(0, continentPlayerRadius + radiusVariance, currAngle);

		for(j = 0; < 2) {
			continentBlobID = createArea();
			if(cContinentSurroundings == cContinentSurroundingsEmptyLand) {
				rmSetAreaTerrainType(continentBlobID, cPrimaryUnbuildableSurroundTexture);
			} else {
				rmSetAreaTerrainType(continentBlobID, cPrimaryTerrainTexture);
			}
			rmSetAreaSize(continentBlobID, blobFraction);
			if(j == 0) {
				rmSetAreaLocation(continentBlobID, x, z);
			} else if(j == 1) {
				rmSetAreaLocation(continentBlobID, 1.0 - x, 1.0 - z);
			}

			rmSetAreaCoherence(continentBlobID, 1.0);
			rmSetAreaBaseHeight(continentBlobID, 2.0);
			rmSetAreaHeightBlend(continentBlobID, continentHeightBlend);
			rmSetAreaSmoothDistance(continentBlobID, 10);

			rmAddAreaToClass(continentBlobID, classCenter);
			rmAddAreaConstraint(continentBlobID, continentBoxConstraint);
			rmAddAreaConstraint(continentBlobID, blobAvoidPlayer);
			rmSetAreaWarnFailure(continentBlobID, false);
			rmBuildArea(continentBlobID);
		}

		currAngle = currAngle + angleIncrement;
	}

	if(cContinentSurroundings == cContinentSurroundingsForest || cContinentSurroundings == cContinentSurroundingsEmptyLand) {
		int classSurroundings = defineClass();
		int avoidCenterArea = createClassDistConstraint(classCenter, 1.0);
		int avoidSurroundingAreas = createClassDistConstraint(classUnbuildable, 1.0);

		for(i = 0; < 4) {
			int surroundingsID = createArea();
			if(cContinentSurroundings == cContinentSurroundingsForest) {
				rmSetAreaForestType(surroundingsID, cPrimaryForestTexture);
				rmSetAreaSize(surroundingsID, 0.1);
			} else if(cContinentSurroundings == cContinentSurroundingsEmptyLand) {
				rmSetAreaTerrainType(surroundingsID, cPrimaryUnbuildableTexture);
				rmAddAreaToClass(surroundingsID, classUnbuildable);
				rmSetAreaSize(surroundingsID, 0.15);
			}

			if(i == 0) {
				rmSetAreaLocation(surroundingsID, 0.0, 0.0);
			} else if(i == 1) {
				rmSetAreaLocation(surroundingsID, 0.0, 1.0);
			} else if(i == 2) {
				rmSetAreaLocation(surroundingsID, 1.0, 0.0);
			} else if(i == 3) {
				rmSetAreaLocation(surroundingsID, 1.0, 1.0);
			}

			rmSetAreaCoherence(surroundingsID, 1.0);
			rmSetAreaBaseHeight(surroundingsID, 2.0);
			rmSetAreaHeightBlend(surroundingsID, continentHeightBlend);

			rmAddAreaToClass(surroundingsID, classSurroundings);
			rmAddAreaConstraint(surroundingsID, avoidCenterArea);
			rmAddAreaConstraint(surroundingsID, avoidSurroundingAreas);
			rmSetAreaWarnFailure(surroundingsID, false);
		}

		rmBuildAllAreas();
	}

	// Build continent.
	setLayerFromTextureSet(cPrimaryTerrainTexture, cPrimaryUnbuildableSurroundTexture);

	int centerID = createArea();
	rmSetAreaTerrainType(centerID, cPrimaryTerrainTexture);
	if(cContinentSurroundings == cContinentSurroundingsEmptyLand) {
		int centerLayedWidthCount = 0;

		for(i = 0; < getLayerCount()) {
			// Randomize layer width.
			int centerLayerWidth = rmRandInt(3, 6);

			// Load layer and apply width (we're starting from the outermost layer with 0 area edge distance)!
			rmAddAreaTerrainLayer(centerID, getLayer(i), centerLayedWidthCount, centerLayedWidthCount + centerLayerWidth);

			// Increment width.
			centerLayedWidthCount = centerLayedWidthCount + centerLayerWidth;
		}
	}
	rmSetAreaSize(centerID, areaRadiusMetersToFraction(cMinPlayerRadiusMeters));
	rmSetAreaLocation(centerID, 0.5, 0.5);

	rmSetAreaCoherence(centerID, 1.0);
	rmSetAreaBaseHeight(centerID, 2.0);
	rmSetAreaHeightBlend(centerID, continentHeightBlend);
	rmSetAreaSmoothDistance(centerID, 10);

	rmAddAreaToClass(centerID, classCenter);
	rmAddAreaConstraint(centerID, continentBoxConstraint);
	rmSetAreaWarnFailure(centerID, false);
	rmBuildArea(centerID);

	// Draw random lines across the map to separate the edge areas.
	if(randChance(2.0 / 3.0) && cContinentSurroundings == cContinentSurroundingsWater) {
		int numLines = 0;
		float lineFraction = 0.0;

		if(gameIs1v1()) {
			numLines = rmRandInt(1, 2);
			lineFraction = rmRandFloat(0.15, 0.25);
		} else {
			numLines = 1;
			lineFraction = 0.2;
		}

		bool drawCornerLines = randChance(1.0 / 3.0);

		if(drawCornerLines) {
			// Stretch for corner.
			lineFraction = lineFraction * SQRT_2;
		}

		int lineRandomizer = rmRandInt(0, 1);

		for(i = (2 - numLines); < 2) {
			int lineID = createArea();
			rmSetAreaTerrainType(lineID, cPrimaryTerrainTexture);
			rmSetAreaSize(lineID, lineFraction);
			rmSetAreaLocation(lineID, 0.5, 0.5);
			if(drawCornerLines) {
				if(lineRandomizer % 2 == 0) {
					rmAddAreaInfluenceSegment(lineID, 0.0, 1.0, 1.0, 0.0);
				} else {
					rmAddAreaInfluenceSegment(lineID, 0.0, 0.0, 1.0, 1.0);
				}
			} else {
				if(lineRandomizer % 2 == 0) {
					rmAddAreaInfluenceSegment(lineID, 0.0, 0.5, 1.0, 0.5);
				} else {
					rmAddAreaInfluenceSegment(lineID, 0.5, 0.0, 0.5, 1.0);
				}
			}
			rmAddAreaRemoveType(lineID, "Tree");

			rmSetAreaCoherence(lineID, 0.5);
			rmSetAreaBaseHeight(lineID, 2.0);
			rmSetAreaHeightBlend(lineID, 2);
			rmSetAreaSmoothDistance(lineID, 10);

			rmSetAreaWarnFailure(lineID, false);
			rmBuildArea(lineID);

			lineRandomizer++;
		}
	}
}

const int cLakeTypeSmall = 0;
const int cLakeTypeBig = 1;
const int cLakeTypePassages = 2;
const int cLakeTypeIslands = 3;
const int cLakeTypeIslandsPassages = 4;

void genMapLake() {
	bool lakeIsGhostLake = randChance(1.0 / 3.0);

	float lakeTypeChance = rmRandFloat(0.0, 1.0);
	float lakeAreaFraction = 0.0;
	int cLakeType = -1;

	if(lakeIsGhostLake) {
		if(lakeTypeChance < 0.5) {
			cLakeType = cLakeTypeSmall;
			lakeAreaFraction = rmRandFloat(0.05, 0.075);
		} else if(lakeTypeChance < 0.75 || cMapIsUnbuildableBuildable) {
			cLakeType = cLakeTypeBig;
			lakeAreaFraction = rmRandFloat(0.1, 0.15);
		} else {
			cLakeType = cLakeTypeIslands;
			lakeAreaFraction = 0.15;
		}
	} else {
		cMapHasWater = true;

		if(gameIs1v1()) {
			if(lakeTypeChance < 0.5) {
				cLakeType = cLakeTypeSmall;
				lakeAreaFraction = rmRandFloat(0.075, 0.125);
				// lakeAreaFraction = areaRadiusMetersToFraction(cMinPlayerRadiusMeters - 45.0);
			} else if(lakeTypeChance < 5.0 / 6.0) {
				cMapHasLargeWaterBody = true;
				cLakeType = cLakeTypeBig;
				lakeAreaFraction = rmRandFloat(0.15, 0.3);
			} else {
				cLakeType = cLakeTypeIslands;
				lakeAreaFraction = 0.225;
			}
		} else {
			if(lakeTypeChance < 0.2 || (isMapSquare() == false && cNonGaiaPlayers > 4)) {
				// Rectangular maps are too small for larger lakes due to TCs with > 4 players.
				cLakeType = cLakeTypeSmall;
				lakeAreaFraction = rmRandFloat(0.075, 0.125);
				// lakeAreaFraction = areaRadiusMetersToFraction(cMinPlayerRadiusMeters - 45.0);
			} else if(lakeTypeChance < 0.4) {
				cMapHasLargeWaterBody = true;
				cLakeType = cLakeTypeBig;
				lakeAreaFraction = rmRandFloat(0.15, 0.3);
			} else if(lakeTypeChance < 0.6) {
				cLakeType = cLakeTypePassages;
				lakeAreaFraction = 0.3;
			} else if(lakeTypeChance < 0.8) {
				cLakeType = cLakeTypeIslands;
				if(gameIs1v1()) {
					lakeAreaFraction = 0.225;
				} else {
					lakeAreaFraction = rmRandFloat(0.1, 0.225);
				}
			} else {
				cLakeType = cLakeTypeIslandsPassages;
				lakeAreaFraction = 0.225;
			}
		}

		cMapFirstSettlementInsideRule = cMapSettlementsInsideRuleNone;
		cMapSecondSettlementInsideRule = cMapSettlementsInsideRuleNone;

		cMapFirstSettlementWaterRule = cMapSettlementsWaterRuleForceAvoidFar;
		if(gameHasTwoEqualTeams() && cNonGaiaPlayers < 7) {
			if(cLakeType == cLakeTypeIslandsPassages) {
				cMapSecondSettlementWaterRule = cMapSettlementsWaterRuleForceAvoidFar;
			} else {
				cMapSecondSettlementWaterRule = cMapSettlementsWaterRuleEither;
			}
		} else {
			cMapSecondSettlementWaterRule = cMapSettlementsWaterRuleNone;
		}
	}

	// Prevent features if lake gets too big.
	if(lakeAreaFraction > 0.2) {
		cMapFeatureRestriction = cFeatureRestrictionEverywhere;
	}

	printDebug("lakeAreaFraction: " + lakeAreaFraction, cDebugFull);

	int classLakeIsland = defineClass();
	int classPlayer = defineClass();

	// Create lake.
	int lakeID = createArea();
	if(lakeIsGhostLake) {
		rmSetAreaTerrainType(lakeID, cPrimaryUnbuildableTexture);

		if(cPrimaryUnbuildableSurroundTexture != cTextureNone) {
			rmAddAreaTerrainLayer(lakeID, cPrimaryUnbuildableSurroundTexture, 0, 2);
		}

		rmSetAreaBaseHeight(lakeID, 0.0);
	} else {
		rmSetAreaWaterType(lakeID, cPrimaryWaterTexture);
		rmSetAreaBaseHeight(lakeID, 1.0);
	}
	rmSetAreaSize(lakeID, lakeAreaFraction);
	rmSetAreaLocation(lakeID, 0.5, 0.5);

	rmSetAreaCoherence(lakeID, 0.5);
	rmSetAreaSmoothDistance(lakeID, 50);

	rmAddAreaConstraint(lakeID, createSymmetricBoxConstraint(rmXMetersToFraction(35.0), rmZMetersToFraction(35.0)));
	rmSetAreaWarnFailure(lakeID, false);
	rmBuildArea(lakeID);

	// Set up player areas.
	float playerAreaFraction = areaRadiusMetersToFraction(50.0);
	int avoidPlayer = createClassDistConstraint(classPlayer, 1.0);

	for(i = 1; < cPlayers) {
		int playerAreaID = createArea();
		rmSetAreaTerrainType(playerAreaID, cPrimaryTerrainTexture);
		rmSetAreaSize(playerAreaID, playerAreaFraction);
		rmSetAreaLocPlayer(playerAreaID, getPlayer(i));

		rmSetAreaCoherence(playerAreaID, 1.0);
		rmSetAreaBaseHeight(playerAreaID, 2.0);
		rmSetAreaHeightBlend(playerAreaID, 2);
		rmSetAreaSmoothDistance(playerAreaID, 20);

		rmAddAreaToClass(playerAreaID, classPlayer);
		rmAddAreaConstraint(playerAreaID, avoidPlayer);
		rmSetAreaWarnFailure(playerAreaID, false);
	}

	rmBuildAllAreas();

	// Island(s) in the center.
	int numLakeIslands = 0;

	if(cLakeType == cLakeTypeIslands || cLakeType == cLakeTypeIslandsPassages) {
		float lakeIslandDistMeters = 0.0;

		if(lakeIsGhostLake) {
			lakeIslandDistMeters = rmRandFloat(15.0, 25.0);
			numLakeIslands = 10 * cNonGaiaPlayers;
		} else {
			lakeIslandDistMeters = 30.0;
			numLakeIslands = 1;
		}

		bool isForestIsland = false;

		if(cLakeType == cLakeTypeIslands) {
			// Ghost Lake always has forest islands, the passage variation always has terrain islands.
			isForestIsland = randChance();
		}

		int lakeIslandAvoidPlayer = createClassDistConstraint(classPlayer, lakeIslandDistMeters);
		int lakeIslandAvoidSelf = createClassDistConstraint(classLakeIsland, lakeIslandDistMeters);
		int lakeIslandAvoidLake = createEdgeDistConstraint(lakeID, lakeIslandDistMeters);
		int islandFailCount = 0;

		for(i = 0; < numLakeIslands) {
			int lakeIslandID = createAreaWithSuperArea(lakeID); // Sub-area of lakeID.

			if(lakeIsGhostLake) {
				float ghostLakeForestFraction = areaRadiusMetersToFraction(rmRandFloat(7.5, 9.0 + 0.5 * cNonGaiaPlayers));

				rmSetAreaForestType(lakeIslandID, cPrimaryForestTexture);
				rmSetAreaSize(lakeIslandID, ghostLakeForestFraction);
			} else {
				if(isForestIsland) {
					rmSetAreaForestType(lakeIslandID, cPrimaryForestTexture);
				} else {
					rmSetAreaTerrainType(lakeIslandID, cPrimaryTerrainTexture);
				}
				rmSetAreaSize(lakeIslandID, 0.5);

				// Elevate for water islands.
				rmSetAreaBaseHeight(lakeIslandID, 4.0);

				if(cLakeType == cLakeTypeIslands) {
					rmAddAreaToClass(lakeIslandID, classMiscResourceBlock);
				}
			}

			rmSetAreaCoherence(lakeIslandID, 0.5);
			rmSetAreaHeightBlend(lakeIslandID, 2);

			rmAddAreaToClass(lakeIslandID, classLakeIsland);
			rmAddAreaConstraint(lakeIslandID, lakeIslandAvoidPlayer);
			rmAddAreaConstraint(lakeIslandID, lakeIslandAvoidSelf);
			rmAddAreaConstraint(lakeIslandID, lakeIslandAvoidLake);

			rmSetAreaWarnFailure(lakeIslandID, false);

			if(rmBuildArea(lakeIslandID)) {
				islandFailCount = 0;
			} else {
				islandFailCount++;

				if(islandFailCount > 3) {
					break;
				}
			}
		}
	}

	// Rebuild center.
	int fakeLakeID = createAreaWithSuperArea(lakeID);
	rmSetAreaSize(fakeLakeID, 1.0);

	rmSetAreaCoherence(fakeLakeID, 1.0);

	rmAddAreaConstraint(fakeLakeID, createClassDistConstraint(classPlayer, 1.0)); // This will fit the area to the actual shape of the lake.
	rmSetAreaWarnFailure(fakeLakeID, false);
	rmBuildArea(fakeLakeID);

	if(cLakeType == cLakeTypeIslandsPassages && lakeIsGhostLake == false) {
		cMapHasMirroredSettlements = true;

		// No settlements towards the center if we have passages.
		if(gameIs1v1() || gameHasTwoEqualTeams()) {
			rmAddAreaToClass(fakeLakeID, classFirstSettlementBlock);
			// rmAddAreaToClass(fakeLakeID, classSecondSettlementBlock);
			rmAddAreaToClass(fakeLakeID, classMediumResourceBlock);
		}

		if(randChance(1.0)) {
			// Currently always do this, I don't think it makes sense to have no resources in the center if one exists.
			cMapPlaceBonusInTeamArea = true;
			buildFakePlayerAreasVsCenterBlock(fakeLakeID, classBonusResourceBlock);
		} else {
			rmAddAreaToClass(fakeLakeID, classBonusResourceBlock);
		}

	} else {
		// If we don't have passages, block the center for everything.
		if(lakeIsGhostLake) {
			rmAddAreaToClass(fakeLakeID, classUnbuildable);
		} else {
			rmAddAreaToClass(fakeLakeID, classFirstSettlementBlock);
			rmAddAreaToClass(fakeLakeID, classSecondSettlementBlock);
			rmAddAreaToClass(fakeLakeID, classMediumResourceBlock);
			rmAddAreaToClass(fakeLakeID, classBonusResourceBlock);
		}
	}

	// Connections (bugs for non-square maps since the longer dimension is not properly stretched).
	if((cLakeType == cLakeTypePassages || cLakeType == cLakeTypeIslandsPassages) && gameHasTwoEqualTeams() && isMapSquare()) {
		float lakeConnectionFloat = rmRandFloat(0.0, 1.0);
		bool buildInner = false;
		bool buildOuter = false;

		if(lakeConnectionFloat < 0.5) {
			buildInner = true;
			buildOuter = true;
		} else if(lakeConnectionFloat < 0.75) {
			buildInner = true;
		} else {
			buildOuter = true;
		}

		int numPlayersPerTeam = getNumberPlayersOnTeam(0);
		float connectionWidthMeters = 0.0;

		if(cLakeType == cLakeTypePassages) {
			connectionWidthMeters = rmRandFloat(35.0, 40.0);
		} else {
			connectionWidthMeters = rmRandFloat(30.0, 35.0);
		}

		for(i = 1; <= numPlayersPerTeam) {
			// Always build all if > 2 players on team.
			if(numPlayersPerTeam > 2) {
				if(buildOuter == false && (i == 1 || i == numPlayersPerTeam)) {
					continue;
				}

				if(buildInner == false && (i != 1 && i != numPlayersPerTeam)) {
					continue;
				}
			}

			int lakeConnectionID = createConnection();
			addAllConnectionTerrainReplacements(lakeConnectionID, cPrimaryTerrainTexture);
			rmSetConnectionType(lakeConnectionID, cConnectAreas, false);
			rmAddConnectionArea(lakeConnectionID, rmAreaID(cPlayerCoreAreaLabel + " " + i));
			rmAddConnectionArea(lakeConnectionID, rmAreaID(cPlayerCoreAreaLabel + " " + (i + numPlayersPerTeam)));

			rmSetConnectionWidth(lakeConnectionID, connectionWidthMeters, 2);
			rmSetConnectionBaseHeight(lakeConnectionID, 2.0);
			rmSetConnectionHeightBlend(lakeConnectionID, 2);
			rmSetConnectionSmoothDistance(lakeConnectionID, 5);

			rmSetConnectionWarnFailure(lakeConnectionID, false);
			rmBuildConnection(lakeConnectionID);
		}
	}

	// Traditional small island (like on Mediterranean) in the center.
	if(lakeIsGhostLake == false && cLakeType == cLakeTypeBig && gameIs1v1() == false && randChance(2.0 / 3.0)) {
		lakeIslandID = createArea();
		rmSetAreaTerrainType(lakeIslandID, cPrimaryTerrainTexture);
		rmSetAreaSize(lakeIslandID, 0.01);
		rmSetAreaLocation(lakeIslandID, 0.5, 0.5);

		rmSetAreaCoherence(lakeIslandID, 0.5);
		rmSetAreaBaseHeight(lakeIslandID, 4.0);
		rmSetAreaHeightBlend(lakeIslandID, 2);

		rmAddAreaToClass(lakeIslandID, classLakeIsland);
		rmAddAreaToClass(lakeIslandID, classMiscResourceBlock);
		rmAddAreaConstraint(lakeIslandID, createEdgeDistConstraint(lakeID, 30.0));
		rmAddAreaConstraint(lakeIslandID, createClassDistConstraint(classPlayer, 30.0));
		rmSetAreaWarnFailure(lakeIslandID, false);
		rmBuildArea(lakeIslandID);
	}

	// Chance to spawn small forests around the water.
	if(cLakeType == cLakeTypeSmall && randChance()) {
		// They may get erased otherwise.
		cMapHasSmallBeautificationAreas = true;

		// Parameters.
		float surroundingsAreaFraction = areaRadiusMetersToFraction(8.0);
		float surroundingsAvoidSelfMeters = 15.0;
		float surroundingsMinLakeDistMeters = 12.0;
		float surroundingsMaxLakeDistMeters = surroundingsMinLakeDistMeters + 12.0;
		float surroundingsAvoidPlayersMeters = 25.0;

		// Constraints.
		int surroundingsNearLake = createEdgeMaxDistConstraint(fakeLakeID, surroundingsMaxLakeDistMeters);
		int surroundingsAvoidLake = createAreaDistConstraint(fakeLakeID, surroundingsMinLakeDistMeters);
		int surroundingsAvoidForest = createTypeDistConstraint("Tree", surroundingsAvoidSelfMeters);
		int surroundingsAvoidPlayer = createClassDistConstraint(classPlayerCore, surroundingsAvoidPlayersMeters);
		int surroundingsFailCount = 0;

		for(i = 0; < 10 * cNonGaiaPlayers) {
			// Forests.
			int lakeForestID = createArea();
			rmSetAreaForestType(lakeForestID, cPrimaryForestTexture);
			rmSetAreaSize(lakeForestID, surroundingsAreaFraction);

			rmSetAreaCoherence(lakeForestID, 1.0);

			rmAddAreaConstraint(lakeForestID, surroundingsNearLake);
			rmAddAreaConstraint(lakeForestID, surroundingsAvoidLake);
			rmAddAreaConstraint(lakeForestID, surroundingsAvoidForest);
			rmAddAreaConstraint(lakeForestID, surroundingsAvoidPlayer);
			rmSetAreaWarnFailure(lakeForestID, false);

			if(rmBuildArea(lakeForestID)) {
				surroundingsFailCount = 0;
			} else {
				surroundingsFailCount++;

				if(surroundingsFailCount > 3) {
					break;
				}
			}
		}
	}

	// Allow fishing.
	cMapHasFish = lakeIsGhostLake == false;
}

int cRiverVariation = -1;

const int cNumRiverVariations = 3;

const int cRiverVariationCross = 0;
const int cRiverVariationOpposing = 1;
const int cRiverVariationBetween = 2;

int cRiverType = -1;

const int cNumRiverTypes = 2;

const int cRiverTypeWater = 0;
const int cRiverTypeForest = 1;

void placePlayersRivers() {
	if(gameIs1v1()) {
		placePlayersInCircle(0.325, 0.375);
	} else {
		placePlayersInCircle(0.35, 0.4, 0.85 + 0.025 * rmRandInt(0, 3));
	}
}

void genMapRivers() {
	// Currently only works for 2 teams with equal players, could randomly rotate a single river for other matchups if desired.
	if(gameHasTwoEqualTeams() == false) {
		return;
	}

	cRiverType = rmRandInt(0, cNumRiverTypes - 1);

	// 0: Opposing players. 1: Cross-players. 2: Between players (1v1: 2 rivers).
	if(cNonGaiaPlayers < 9) {
		cRiverVariation = rmRandInt(0, cNumRiverVariations - 1);
	} else {
		cRiverVariation = cRiverVariationBetween;
	}

	// Don't allow cross rivers for forests.
	if(cRiverType == cRiverTypeForest) {
		cRiverVariation = rmRandInt(1, cNumRiverVariations - 1);
	}

	cMapFirstSettlementInsideRule = cMapSettlementsInsideRuleNone;
	cMapSecondSettlementInsideRule = cMapSettlementsInsideRuleNone;

	if(cRiverType == cRiverTypeWater) {
		cMapHasWater = true;

		cMapFirstSettlementWaterRule = cMapSettlementsWaterRuleForceAvoidFar;
		cMapSecondSettlementWaterRule = cMapSettlementsWaterRuleEither;

		// Allow fishing.
		cMapHasFish = randChance(2.0 / 3.0);
	} else {
		cMapFirstSettlementWaterRule = cMapSettlementsWaterRuleNone;
		cMapSecondSettlementWaterRule = cMapSettlementsWaterRuleNone;
	}

	int riverID = -1;

	float riverWidthMeters = 0.0;
	float riverLengthMeters = 0.0;
	float riverAreaFraction = 0.0;
	float playerDist = 0.0;

	float startX = 0.0;
	float startZ = 0.0;
	float endX = 0.0;
	float endZ = 0.0;

	int numSteps = 0;
	float xStep = 0.0;
	float zStep = 0.0;

	if(cRiverVariation == cRiverVariationOpposing || cRiverVariation == cRiverVariationCross) {
		// Player-connected rivers.
		if(gameIs1v1()) {
			riverWidthMeters = 25.0 + 5.0 * rmRandInt(0, 0); // 1-2 fish packs for 1v1.
		} else {
			riverWidthMeters = 22.5;
		}
		riverAreaFraction = areaRadiusMetersToFraction(riverWidthMeters);
		playerDist = smallerMetersToFraction(80.0);

		int opposingPlayer = -1;

		for(i = 1; <= getNumberPlayersOnTeam(0)) {
			if(cRiverVariation == cRiverVariationOpposing) {
				opposingPlayer = cPlayers - i;
			} else if(cRiverVariation == cRiverVariationCross) {
				opposingPlayer = (i + getNumberPlayersOnTeam(0) - 1) % cNonGaiaPlayers + 1;
			}

			float firstAngle = PI + getPlayerTeamOffsetAngle(i);
			float secondAngle = PI + getPlayerTeamOffsetAngle(opposingPlayer);

			startX = getXFromPolarForPlayer(i, playerDist, firstAngle, false);
			startZ = getZFromPolarForPlayer(i, playerDist, firstAngle, false);

			endX = getXFromPolarForPlayer(opposingPlayer, playerDist, secondAngle, false);
			endZ = getZFromPolarForPlayer(opposingPlayer, playerDist, secondAngle, false);

			riverLengthMeters = pointsGetDist(rmXFractionToMeters(startX), rmZFractionToMeters(startZ), rmXFractionToMeters(endX), rmZFractionToMeters(endZ));

			// At least 2 steps.
			numSteps = max(2, riverLengthMeters / (0.5 * riverWidthMeters));
			xStep = (endX - startX) / (numSteps - 1);
			zStep = (endZ - startZ) / (numSteps - 1);

			for(j = 0; < numSteps) {
				riverID = createArea();
				if(cRiverType == cRiverTypeWater) {
					rmSetAreaWaterType(riverID, cPrimaryWaterTexture);
				} else if(cRiverType == cRiverTypeForest) {
					rmSetAreaForestType(riverID, cPrimaryForestTexture);
				}
				rmSetAreaSize(riverID, riverAreaFraction);
				rmSetAreaLocation(riverID, startX + xStep * j, startZ + zStep * j);

				rmSetAreaCoherence(riverID, 0.5);
				rmSetAreaBaseHeight(riverID, 1.0);
				rmSetAreaSmoothDistance(riverID, 5);
				rmSetAreaHeightBlend(riverID, 2);

				rmSetAreaWarnFailure(riverID, false);
			}
		}
	} else if(cRiverVariation == cRiverVariationBetween && gameIs1v1()) {
		// Two center rivers for 1v1.
		riverWidthMeters = 20.0; // 1 pack per pond if separator is built.
		riverAreaFraction = areaRadiusMetersToFraction(riverWidthMeters);

		float angleOffset = 1.25 * PI;
		playerDist = smallerMetersToFraction(50.0 + 0.5 * riverWidthMeters);

		for(i = -1; <= 1) {
			if(i == 0) {
				// We only need 2 rivers and use -1/1 for shifting angles.
				continue;
			}

			startX = getXFromPolarForPlayer(1, playerDist, angleOffset * i);
			startZ = getZFromPolarForPlayer(1, playerDist, angleOffset * i);

			endX = getXFromPolarForPlayer(2, playerDist, 0.0 - angleOffset * i);
			endZ = getZFromPolarForPlayer(2, playerDist, 0.0 - angleOffset * i);

			riverLengthMeters = pointsGetDist(rmXFractionToMeters(startX), rmZFractionToMeters(startZ), rmXFractionToMeters(endX), rmZFractionToMeters(endZ));

			// At least 2 steps.
			numSteps = max(2, riverLengthMeters / (0.5 * riverWidthMeters));
			xStep = (endX - startX) / (numSteps - 1);
			zStep = (endZ - startZ) / (numSteps - 1);

			for(j = 0; < numSteps) {
				riverID = createArea();
				if(cRiverType == cRiverTypeWater) {
					rmSetAreaWaterType(riverID, cPrimaryWaterTexture);
				} else if(cRiverType == cRiverTypeForest) {
					rmSetAreaForestType(riverID, cPrimaryForestTexture);
				}
				rmSetAreaSize(riverID, riverAreaFraction);
				rmSetAreaLocation(riverID, startX + xStep * j, startZ + zStep * j);

				rmSetAreaCoherence(riverID, 0.5);
				rmSetAreaBaseHeight(riverID, 1.0);
				rmSetAreaSmoothDistance(riverID, 5);
				rmSetAreaHeightBlend(riverID, 2);

				rmSetAreaWarnFailure(riverID, false);
			}
		}
	} else if(cRiverVariation == cRiverVariationBetween) { // 1v1 check is redundant.
		// Rivers between allies, connecting to respective enemies.
		placeLocationsBetweenAllies(smallerMetersToFraction(cMinPlayerRadiusMeters) - 0.1);

		int opposingLocID = -1;
		riverWidthMeters = 25.0;
		riverAreaFraction = areaRadiusMetersToFraction(riverWidthMeters);

		for(i = 1; <= getNumberPlayersOnTeam(0) - 1) {
			opposingLocID = cPlayers - i - 2; // No locations between teams -> -2.

			startX = getLocX(i);
			startZ = getLocZ(i);

			endX = getLocX(opposingLocID);
			endZ = getLocZ(opposingLocID);

			riverLengthMeters = pointsGetDist(rmXFractionToMeters(startX), rmZFractionToMeters(startZ), rmXFractionToMeters(endX), rmZFractionToMeters(endZ));

			numSteps = riverLengthMeters / (0.5 * riverWidthMeters);
			xStep = (endX - startX) / (numSteps - 1);
			zStep = (endZ - startZ) / (numSteps - 1);

			for(j = 0; < numSteps) {
				riverID = createArea();
				if(cRiverType == cRiverTypeWater) {
					rmSetAreaWaterType(riverID, cPrimaryWaterTexture);
				} else if(cRiverType == cRiverTypeForest) {
					rmSetAreaForestType(riverID, cPrimaryForestTexture);
				}
				rmSetAreaSize(riverID, riverAreaFraction);
				rmSetAreaLocation(riverID, startX + xStep * j, startZ + zStep * j);

				rmSetAreaCoherence(riverID, 0.5);
				rmSetAreaBaseHeight(riverID, 1.0);
				rmSetAreaSmoothDistance(riverID, 5);
				rmSetAreaHeightBlend(riverID, 2);

				rmSetAreaWarnFailure(riverID, false);
			}
		}

		resetLocStorage();
	}

	rmBuildAllAreas();

	// Chance for land separator between players.
	// Possibility 1: For 1v1, require the cRiverVariationBetween variation.
	bool separator1v1Check = gameIs1v1() && cRiverVariation == cRiverVariationBetween;
	// Possibility 2: For non-1v1, require cRiverVariationBetween variation or square map.
	bool separatorTgCheck = gameIs1v1() == false && (cRiverVariation == cRiverVariationBetween || isMapSquare());
	// Possibility 3: Always allow the separator for the cRiverVariationCross variation for 4 players.
	bool separatorTgFourPlayerCheck = cNonGaiaPlayers == 4 && cRiverVariation == cRiverVariationCross;

	bool buildSeparator = randChance() && (separator1v1Check || separatorTgCheck || separatorTgFourPlayerCheck);

	// Set small player area decoration when building separator.
	cMapHasSmallBeautificationAreas = buildSeparator || (gameIs1v1() && cRiverVariation != cRiverVariationBetween);

	if(buildSeparator) {
		if(cRiverVariation == cRiverVariationCross) {
			// Cross: Build vertically to team axes.
			placeLocationsAtTeamAngle(0.5);
		} else {
			// Non-cross: Build horizontally to team axes.
			placeLocationsBetweenTeams(0.5);
		}

		startX = getLocX(1);
		startZ = getLocZ(1);
		endX = getLocX(2);
		endZ = getLocZ(2);

		int passageLengthMeters = pointsGetDist(rmXFractionToMeters(startX), rmZFractionToMeters(startZ), rmXFractionToMeters(endX), rmZFractionToMeters(endZ));
		float passageWidthMeters = 15.0;

		if(cRiverType != cRiverTypeWater) {
			passageWidthMeters = 15.0 + 5.0 * rmRandInt(0, 1);
		}

		float passageAreaFraction = areaRadiusMetersToFraction(passageWidthMeters);

		numSteps = passageLengthMeters / (0.5 * passageWidthMeters);
		xStep = (endX - startX) / (numSteps - 1);
		zStep = (endZ - startZ) / (numSteps - 1);

		for(j = 0; < numSteps) {
			riverID = createArea();
			rmSetAreaTerrainType(riverID, cPrimaryTerrainTexture);
			rmSetAreaSize(riverID, passageAreaFraction);
			rmSetAreaLocation(riverID, startX + xStep * j, startZ + zStep * j);
			rmAddAreaRemoveType(riverID, "Tree");

			rmSetAreaCoherence(riverID, 0.5);
			rmSetAreaBaseHeight(riverID, 2.0);
			rmSetAreaSmoothDistance(riverID, 5);
			rmSetAreaHeightBlend(riverID, 2);

			rmSetAreaWarnFailure(riverID, false);
		}

		resetLocStorage();

		rmBuildAllAreas();
	}
}

int cSeparatorType = -1;

const int cNumSeparatorTypes = 3;

const int cSeparatorTypeForest = 0;
const int cSeparatorTypeWater = 1;
const int cSeparatorTypeCliff = 2;

void placePlayersSeparators() {
	// Anything else would already indicate the variation upon spawning.
	float playerRadiusMin = 0.3;
	float playerRadiusMax = 0.3;
	float teamModifier = 1.0;

	// Only use circular placement here.
	placePlayersInCircle(playerRadiusMin, playerRadiusMax, teamModifier);
}

void genMapSeparators() {
	cSeparatorType = rmRandInt(0, cNumSeparatorTypes - 1);

	float splitDistMeters = 0.0;

	if(cSeparatorType == cSeparatorTypeForest) {
		if(randChance(0.25)) {
			splitDistMeters = 10.0; // Small forest, 2-3 trees thick.
		} else {
			splitDistMeters = rmRandFloat(10.0, 30.0);
		}
	} else if(cSeparatorType == cSeparatorTypeWater) {
		// Map has water.
		cMapHasWater = true;

		// Allow fishing.
		cMapHasFish = randChance();

		splitDistMeters = rmRandFloat(35.0, 45.0);
	} else if(cSeparatorType == cSeparatorTypeCliff) {
		splitDistMeters = rmRandFloat(10.0, 20.0);
	}

	// Always have second settlements on player areas.
	cMapForceSecondSettlementOnPlayerArea = true;

	if(gameIs1v1()) {
		cMapFirstSettlementInsideRule = cMapSettlementsInsideRuleNone;
		cMapSecondSettlementInsideRule = cMapSettlementsInsideRuleNone;
	} else {
		cMapFirstSettlementInsideRule = cMapSettlementsInsideRuleOutside;
		cMapSecondSettlementInsideRule = cMapSettlementsInsideRuleOutside;
		cMapBonusAreaSize = cBonusAreaSizeSmall;
	}

	if(cSeparatorType == cSeparatorTypeWater && gameIs1v1()) {
		// Only do this for 1v1, team games are too random.
		cMapFirstSettlementWaterRule = cMapSettlementsWaterRuleForceAvoidFar;
		cMapSecondSettlementWaterRule = cMapSettlementsWaterRuleEither;
	} else {
		cMapFirstSettlementWaterRule = cMapSettlementsWaterRuleNone;
		cMapSecondSettlementWaterRule = cMapSettlementsWaterRuleNone;
	}

	int classSeparator = defineClass();
	int classCenter = defineClass();
	int classPlayer = defineClass();

	int avoidPlayer = createClassDistConstraint(classPlayer, splitDistMeters);
	int avoidCenter = createClassDistConstraint(classCenter, 0.1);
	int separatorAvoidPlayer = createClassDistConstraint(classPlayer, 0.1);

	int avoidSeparator = -1;
	if(gameIs1v1()) {
		// 1v1: 1 separator in the center, chance for 2 passages (avoiding center separator).
		avoidSeparator = createClassDistConstraint(classSeparator, 50.0);
	} else {
		// 2v2: 1 separator between each pair of players, make sure only 1 is built per location.
		avoidSeparator = createClassDistConstraint(classSeparator, 0.1);
	}

	// 1. Block center for teamgames.
	if(gameIs1v1() == false) {
		float separatorBlockFraction = rmRandFloat(0.05, 0.075);

		int separatorCenterBlockID = createArea();
		rmSetAreaSize(separatorCenterBlockID, separatorBlockFraction);
		rmSetAreaLocation(separatorCenterBlockID, 0.5, 0.5);

		rmSetAreaCoherence(separatorCenterBlockID, 1.0);

		rmAddAreaToClass(separatorCenterBlockID, classCenter);
		rmSetAreaWarnFailure(separatorCenterBlockID, false);
		rmBuildArea(separatorCenterBlockID);

		// Fake center area to make sure gold/food doesn't get too close to the center.
		int separatorBonusCenterID = createArea();
		rmSetAreaSize(separatorBonusCenterID, 0.1);
		rmSetAreaLocation(separatorBonusCenterID, 0.5, 0.5);

		rmSetAreaCoherence(separatorBonusCenterID, 1.0);

		rmAddAreaToClass(separatorBonusCenterID, classMediumResourceBlock);
		rmSetAreaWarnFailure(separatorBonusCenterID, false);
		rmBuildArea(separatorBonusCenterID);

		cMapHasCustomSecondSettlement = randChance(1.0 / 3.0) && cNonGaiaPlayers < 7 && isMapSquare() == true;

		if(cMapHasCustomSecondSettlement) {
			// Center settlements in teamgames.
			int settlementID = createObjectDef();
			addObjectDefItemVerify(settlementID, "Settlement", 1, 0.0);

			placeLocationsInCircle(cNonGaiaPlayers, smallerMetersToFraction(cMinPlayerRadiusMeters - 65.0), getPlayerAngle(1));

			for(i = 1; < cPlayers) {
				placeObjectDefAtLoc(settlementID, 0, getLocX(i), getLocZ(i));
			}

			// Don't allow ponds here as they may delete the settlements (unless you make them avoid 50.0 + meters.
			cMapDoesNotAllowPonds = true;
		} else {
			// No center settlements (block).
			float settlementBlockFraction = areaRadiusMetersToFraction(cMinPlayerRadiusMeters);

			int settlementBlockID = createArea();
			rmSetAreaSize(settlementBlockID, settlementBlockFraction);
			rmSetAreaLocation(settlementBlockID, 0.5, 0.5);

			rmSetAreaCoherence(settlementBlockID, 1.0);

			rmAddAreaToClass(settlementBlockID, classFirstSettlementBlock);
			rmAddAreaToClass(settlementBlockID, classSecondSettlementBlock);
			rmSetAreaWarnFailure(settlementBlockID, false);
			rmBuildArea(settlementBlockID);
		}

		// Force bonus stuff into center.
		cMapPlaceBonusInTeamArea = true;
		buildFakePlayerAreasVsCenterBlock(separatorBonusCenterID, classBonusResourceBlock);
	}

	// 2. Build (fake) player areas.
	for(i = 1; < cPlayers) {
		int fakePlayerAreaID = createArea();
		rmSetAreaSize(fakePlayerAreaID, 1.0 / cNonGaiaPlayers);
		rmSetAreaLocPlayer(fakePlayerAreaID, getPlayer(i));
		rmSetPlayerArea(getPlayer(i), fakePlayerAreaID);

		rmSetAreaCoherence(fakePlayerAreaID, 1.0);

		rmAddAreaToClass(fakePlayerAreaID, classPlayer);
		rmAddAreaConstraint(fakePlayerAreaID, avoidPlayer);
		rmSetAreaWarnFailure(fakePlayerAreaID, false);
	}

	rmBuildAllAreas();

	// 3. Fills: Avoid split.
	int separatorFillerID = -1;

	// a) Inner fill: Apply box constraint to not let it grow until the edge.
	if(gameIs1v1()) {
		float fillRangeMinMeters = smallerFractionToMeters(0.175);
		float fillRangeMaxMeters = smallerFractionToMeters(0.225);
		float fillRangeMeters = rmRandFloat(fillRangeMinMeters, fillRangeMaxMeters);

		printDebug("fillRangeMeters: " + fillRangeMeters);

		// Width of the separator is splitDistMeters.
		float fillFraction = (2.0 * fillRangeMeters * splitDistMeters) / getMapAreaInMeters();

		separatorFillerID = createArea();
		if(cSeparatorType == cSeparatorTypeForest) {
			rmSetAreaForestType(separatorFillerID, cPrimaryForestTexture);
		} else if(cSeparatorType == cSeparatorTypeWater) {
			rmSetAreaWaterType(separatorFillerID, cPrimaryWaterTexture);
		} else if(cSeparatorType == cSeparatorTypeCliff) {
			rmSetAreaTerrainType(separatorFillerID, cPrimaryImpassableCliffTexture);
			rmSetAreaCliffType(separatorFillerID, cPrimaryCliffType);

			rmSetAreaCliffEdge(separatorFillerID, 1, 1.0, 0.0, 1.0, 0);
			rmSetAreaCliffPainting(separatorFillerID, true, false, true, 1.5, false);
			rmSetAreaCliffHeight(separatorFillerID, 4.0, 1.0, 1.0);
		}
		rmSetAreaSize(separatorFillerID, fillFraction);
		rmSetAreaLocation(separatorFillerID, 0.5, 0.5);

		rmSetAreaCoherence(separatorFillerID, 0.75);
		rmSetAreaSmoothDistance(separatorFillerID, 10);

		rmAddAreaToClass(separatorFillerID, classSeparator);
		rmAddAreaConstraint(separatorFillerID, separatorAvoidPlayer);
		rmSetAreaWarnFailure(separatorFillerID, false);
		rmBuildArea(separatorFillerID);
	}

	// b) Outer fills.
	if(randChance() || gameIs1v1() == false) {
		int separatorEdgeConstraint = createSymmetricBoxConstraint(0.125);

		for(i = 0; < 2 * cNonGaiaPlayers) { // * 2 to make sure they are always built.
			separatorFillerID = createArea();

			if(cSeparatorType == cSeparatorTypeForest) {
				rmSetAreaForestType(separatorFillerID, cPrimaryForestTexture);
			} else if(cSeparatorType == cSeparatorTypeWater) {
				rmSetAreaWaterType(separatorFillerID, cPrimaryWaterTexture);
			} else if(cSeparatorType == cSeparatorTypeCliff) {
				rmSetAreaTerrainType(separatorFillerID, cPrimaryImpassableCliffTexture);
				rmSetAreaCliffType(separatorFillerID, cPrimaryCliffType);

				rmSetAreaCliffEdge(separatorFillerID, 1, 1.0, 0.0, 1.0, 0);
				rmSetAreaCliffPainting(separatorFillerID, true, false, true, 1.5, false);
				rmSetAreaCliffHeight(separatorFillerID, 4.0, 1.0, 1.0);
			}
			rmSetAreaSize(separatorFillerID, 1.0);

			rmSetAreaCoherence(separatorFillerID, 0.75);
			rmSetAreaSmoothDistance(separatorFillerID, 10);

			rmAddAreaToClass(separatorFillerID, classSeparator);
			if(gameIs1v1() == false) {
				rmAddAreaConstraint(separatorFillerID, separatorEdgeConstraint);
			}
			rmAddAreaConstraint(separatorFillerID, separatorAvoidPlayer);
			rmAddAreaConstraint(separatorFillerID, avoidSeparator);
			rmAddAreaConstraint(separatorFillerID, avoidCenter);
			rmSetAreaWarnFailure(separatorFillerID, false);
			rmBuildArea(separatorFillerID);
		}
	}
}

void initMap() {
	switch(cMapType) {
		case cMapTypePlain: {
			initMapGeneric();
			placePlayersGeneric();
			break;
		}
		case cMapTypePlateau: {
			initMapGeneric();
			placePlayersGeneric();
			break;
		}
		case cMapTypeOases: {
			initMapGeneric();
			placePlayersGeneric();
			break;
		}
		case cMapTypePlayerIslands: {
			int numPlayerIslandPlayerTiles = 7500;

			if(gameIs1v1() == false && randChance()) {
				numPlayerIslandPlayerTiles = 9000;
			}

			float playerIslandsFloat = rmRandFloat(0.0, 1.0);

			if(playerIslandsFloat < 1.0 / 3.0) {
				initMapGeneric(cInitTypeTerrain, numPlayerIslandPlayerTiles);
			} else if(playerIslandsFloat < 2.0 / 3.0) {
				initMapGeneric(cInitTypeWater, numPlayerIslandPlayerTiles); // Water init.
			} else {
				initMapGeneric(cInitTypeCliff, numPlayerIslandPlayerTiles, false, 6.0); // Cliff init (-4.0 would also work).
			}
			placePlayersPlayerIslands();

			break;
		}
		case cMapTypeCenterIslands: {
			// For more than 6 players, force the larger map to make sure (close) settlements always place.
			if(cNonGaiaPlayers < 7) {
				initMapGeneric(cInitTypeWater, 7500 + 1500 * rmRandInt(0, 1), true); // Water init, force square.
			} else {
				initMapGeneric(cInitTypeWater, 9000, true); // Water init, force square.
			}
			placePlayersCenterIslands();
			break;
		}
		case cMapTypeSmallCenterIsland: {
			initMapGeneric(cInitTypeWater, 7500 + 1500 * rmRandInt(0, 1), true); // Water init, force square.
			placePlayersSmallCenterIsland();
			break;
		}
		case cMapTypeContinent: {
			float continentFloat = rmRandFloat(0.0, 1.0);

			if(continentFloat < 0.25) {
				initMapGeneric(cInitTypeWater, 11250); // Water init.
				placePlayersContinent(cContinentSurroundingsWater, 30.0, 40.0);
			} else if(continentFloat < 0.75) {
				initMapGeneric(cInitTypeTerrain, 11250); // Land init (for forest or ice side).

				if(randChance()) {
					placePlayersContinent(cContinentSurroundingsForest, 15.0, 45.0 + 5.0 * randLargeInt(0, 2));
				} else {
					// Remember that this may actually be buildable.
					placePlayersContinent(cContinentSurroundingsEmptyLand, 30.0, 40.0);
				}
			} else {
				initMapGeneric(cInitTypeCliff, 11250, false, 4.0); // Cliff init.
				placePlayersContinent(cContinentSurroundingsCliff, 15.0, 45.0 + 5.0 * randLargeInt(0, 2));
			}

			break;
		}
		case cMapTypeLake: {
			initMapGeneric();
			placePlayersGeneric();
			break;
		}
		case cMapTypeRivers: {
			initMapGeneric(cInitTypeTerrain, 7500, cNonGaiaPlayers > 8); // Force square map for many players.
			placePlayersRivers();
			break;
		}
		case cMapTypeSeparator: {
			if(gameIs1v1()) {
				initMapGeneric(cInitTypeTerrain, 7500);
			} else {
				initMapGeneric(cInitTypeTerrain, 7500 + 1500 * rmRandInt(0, 1));
			}
			placePlayersSeparators();
			break;
		}
	}

	updateMinPlayerMetersFromCenter();
}

void generateMapLayout() {
	switch(cMapType) {
		case cMapTypePlain: {
			genMapPlain();
			break;
		}
		case cMapTypePlateau: {
			genMapPlateau();
			break;
		}
		case cMapTypeOases: {
			genMapOases();
			break;
		}
		case cMapTypePlayerIslands: {
			genMapPlayerIslands();
			break;
		}
		case cMapTypeCenterIslands: {
			genMapCenterIslands();
			break;
		}
		case cMapTypeSmallCenterIsland: {
			genMapSmallCenterIsland();
			break;
		}
		case cMapTypeContinent: {
			genMapContinent();
			break;
		}
		case cMapTypeLake: {
			genMapLake();
			break;
		}
		case cMapTypeRivers: {
			genMapRivers();
			break;
		}
		case cMapTypeSeparator: {
			genMapSeparators();
			break;
		}
	}
}

void createTowerLocations() {
	resetLocStorage();

	int numTries = 3;

	for(i = 0; < numTries) {
		addLocConstraint(avoidAll);
		// Small edge constraint since the area may get built anyway, but the object won't get placed after.
		addLocConstraint(createSymmetricBoxConstraint(rmXMetersToFraction(2.0), rmZMetersToFraction(2.0)));
		addLocConstraint(createTerrainDistConstraint("Land", false, 5.0));
		addLocConstraint(createClassDistConstraint(classTower, 25.0 - 2.5 * i));

		if(placeLocPerPlayer(4, 23.0, 27.0, classTower, true)) {
			break;
		}

		resetLocStorage();
		resetLocs();
	}

	resetLocs();
}

void createSettlementLocations() {
	// Add starting location to settle area.
	for(i = 1; < cPlayers) {
		int startingSettleAreaID = createArea();
		rmSetAreaSize(startingSettleAreaID, areaRadiusMetersToFraction(6.0));
		rmSetAreaLocation(startingSettleAreaID, getPlayerLocXFraction(i), getPlayerLocZFraction(i));

		rmSetAreaCoherence(startingSettleAreaID, 1.0);

		rmAddAreaToClass(startingSettleAreaID, classSettleArea);
		rmBuildArea(startingSettleAreaID);
	}

	// Additional settlements.
	int settlementAvoidAll = createTypeDistConstraint("All", 12.0); // Larger due to fair loc not using settlement size.
	int avoidMirrorCenter = createClassDistConstraint(classMirrorCenter, 1.0);
	int avoidCorner = createClassDistConstraint(classCornerBlock, 1.0);
	int avoidSettlement = createTypeDistConstraint("Settlement", 80.0);
	int avoidImpassableLand = createTerrainDistConstraint("Land", false, 12.0);
	int avoidImpassableWater = createTerrainDistConstraint("Water", true, 17.0);
	int nearImpassableWater = createTerrainMaxDistConstraint("Water", true, 23.0);
	int avoidWaterSiegeRange = createTerrainDistConstraint("Water", true, 30.0);
	int avoidUnbuildableAreas = createClassDistConstraint(classUnbuildable, 15.0);
	int avoidAreasFirstSettlement = createClassDistConstraint(classFirstSettlementBlock, 1.0);
	int avoidAreasSecondSettlement = createClassDistConstraint(classSecondSettlementBlock, 1.0);

	/*
	 * Water maps:
	 * 1. Try to force into siege range or make all avoid siege range.
	 * 2. Try the method not used in 1.
	 * 3. Make them avoid water by a shorter distance if both of the above fail (e.g., 12.0 - 20.0).
	*/

	int firstSettlementWaterInt = rmRandInt(0, 1);
	int secondSettlementWaterInt = rmRandInt(0, 1);

	bool firstSettlementInside = false;

	if(cMapFirstSettlementInsideRule == cMapSettlementsInsideRuleNone) {
		firstSettlementInside = randChance();
	} else if(cMapFirstSettlementInsideRule == cMapSettlementsInsideRuleInside) {
		firstSettlementInside = true;
	} else if(cMapFirstSettlementInsideRule == cMapSettlementsInsideRuleOutside) {
		firstSettlementInside = false;
	}

	bool secondSettlementInside = false;

	if(cMapSecondSettlementInsideRule == cMapSettlementsInsideRuleNone) {
		secondSettlementInside = randChance();
	} else if(cMapSecondSettlementInsideRule == cMapSettlementsInsideRuleInside) {
		secondSettlementInside = true;
	} else if(cMapSecondSettlementInsideRule == cMapSettlementsInsideRuleOutside) {
		secondSettlementInside = false;
	}

	int numTries = 6;
	int numForceTries = 4;

	if(cMapHasMirroredSettlements && gameHasTwoEqualTeams()) {
		setMirrorMode(cMirrorPoint);
	}

	for(i = 0; < numTries) {
		// Close settlement.
		addFairLocConstraint(settlementAvoidAll);
		addFairLocConstraint(avoidCorner);
		addFairLocConstraint(avoidTowerLOS);
		addFairLocConstraint(avoidSettlement);
		addFairLocConstraint(avoidAreasFirstSettlement);
		addFairLocConstraint(avoidUnbuildableAreas);
		addFairLocConstraint(avoidImpassableLand);

		if(i < numForceTries) {
			if(cMapFirstSettlementWaterRule == cMapSettlementsWaterRuleEither) {
				// Switch each iteration so we have all combinations for first/second settlement.
				if(i % 2 == firstSettlementWaterInt) {
					addFairLocConstraint(avoidImpassableWater);
					addFairLocConstraint(nearImpassableWater);
				} else {
					addFairLocConstraint(avoidWaterSiegeRange);
				}
			} else if(cMapFirstSettlementWaterRule == cMapSettlementsWaterRuleForceAvoidFar) {
				addFairLocConstraint(avoidWaterSiegeRange);
			} else if(cMapFirstSettlementWaterRule == cMapSettlementsWaterRuleForceClose) {
				addFairLocConstraint(avoidImpassableWater);
				addFairLocConstraint(nearImpassableWater);
			}
		}

		if(gameIs1v1()) {
			enableFairLocTwoPlayerCheck();
		}

		if(i < numTries - 1 && cMapHasSmallPlayerAreas == false) {
			if(randChance()) {
				addFairLoc(60.0, 80.0, false, firstSettlementInside, 55.0, 12.0, 12.0, false, true);
			} else {
				addFairLoc(80.0, 100.0, false, firstSettlementInside, 55.0, 12.0, 12.0, false, true);
			}
		} else {
			// Larger range for last try or small player areas.
			addFairLoc(60.0, 100.0, false, firstSettlementInside, 55.0, 12.0, 12.0, false, true);
		}

		// Far settlement.
		if(cMapHasCustomSecondSettlement == false) {
			addFairLocConstraint(settlementAvoidAll);
			addFairLocConstraint(avoidTowerLOS);
			addFairLocConstraint(avoidSettlement);
			addFairLocConstraint(avoidAreasSecondSettlement);
			addFairLocConstraint(avoidUnbuildableAreas);
			addFairLocConstraint(avoidImpassableLand);

			if(i < numForceTries) {
				if(cMapSecondSettlementWaterRule == cMapSettlementsWaterRuleEither) {
					if(secondSettlementWaterInt == 0) {
						addFairLocConstraint(avoidImpassableWater);
						addFairLocConstraint(nearImpassableWater);
					} else {
						addFairLocConstraint(avoidWaterSiegeRange);
					}
				} else if(cMapSecondSettlementWaterRule == cMapSettlementsWaterRuleForceAvoidFar) {
					addFairLocConstraint(avoidWaterSiegeRange);
				} else if(cMapSecondSettlementWaterRule == cMapSettlementsWaterRuleForceClose) {
					addFairLocConstraint(avoidImpassableWater);
					addFairLocConstraint(nearImpassableWater);
				}

				// Switch after 2 iterations so we have all combinations for first/second settlement.
				if(i > 1) {
					secondSettlementWaterInt = 1 - secondSettlementWaterInt;
				}
			}

			if(cMapHasMirroredSettlements && gameHasTwoEqualTeams()) {
				addFairLocConstraint(avoidMirrorCenter);
			}

			if(gameIs1v1()) {
				enableFairLocTwoPlayerCheck();
				setFairLocInterDistMin(75.0);
				addFairLoc(50.0, 120.0, true, secondSettlementInside, 75.0, 12.0, 12.0, true);
			} else if(cNonGaiaPlayers < 5 && gameHasTwoEqualTeams()) {
				addFairLoc(70.0, 100.0, true, secondSettlementInside, 75.0, 12.0, 12.0, cMapForceSecondSettlementOnPlayerArea, true);
			} else if(cNonGaiaPlayers < 7 && gameHasTwoEqualTeams()) {
				addFairLoc(70.0, 120.0, true, secondSettlementInside, 75.0, 12.0, 12.0, cMapForceSecondSettlementOnPlayerArea, true);
			} else {
				addFairLoc(70.0, 120.0, true, secondSettlementInside, 60.0, 12.0, 12.0, cMapForceSecondSettlementOnPlayerArea, gameHasTwoEqualTeams());
			}
		}

		if(createFairLocs("settlements (i = " + i + ")", i == numTries - 1, 2500, 200)) {
			break;
		}

		resetFairLocs();

		// Re-roll inside if required.
		if(cMapFirstSettlementInsideRule == cMapSettlementsInsideRuleNone) {
			firstSettlementInside = randChance();
		}
		if(cMapSecondSettlementInsideRule == cMapSettlementsInsideRuleNone) {
			secondSettlementInside = randChance();
		}
	}

	// Reset mirror mode.
	setMirrorMode(cMirrorNone);

	if(getNumFairLocs() == 0) {
		// Only true if we didn't break in the previous loop and reset the fair locs.
		return;
	}

	for(i = 1; <= getNumFairLocs()) {
		for(j = 1; < cPlayers) {
			int settleAreaID = createArea();
			rmSetAreaSize(settleAreaID, areaRadiusMetersToFraction(6.0));
			rmSetAreaLocation(settleAreaID, getFairLocX(i, j), getFairLocZ(i, j));

			rmSetAreaCoherence(settleAreaID, 1.0);

			rmAddAreaToClass(settleAreaID, classSettleArea);
			rmBuildArea(settleAreaID);

			int connectionID = getConnectionID(j);

			if(i == getNumFairLocs() && connectionID != -1) {
				rmAddConnectionArea(connectionID, settleAreaID);
				rmBuildConnection(connectionID);
			}
		}
	}
}

void generatePonds() {
	if(cMapDoesNotAllowPonds) {
		return;
	}

	// This may not always work out because ponds may not get placed (often due to other bodies of water, meaning this is already true).
	cMapHasWater = true;

	float minPondFraction = areaSquareMetersToFraction(1600);
	float maxPondFraction = areaSquareMetersToFraction(1600);

	int numPondsPerPlayer = rmRandInt(1, 2);

	int forceToCenter = createClassDistConstraint(classBonusResourceBlock, 1.0);
	int forceToPlayer = createClassDistConstraint(classMediumResourceBlock, 1.0);
	int avoidPlayer = createClassDistConstraint(classPlayerCore, 40.0);
	int avoidTower = createClassDistConstraint(classTower, 25.0);
	int avoidImpassableLand = createTerrainDistConstraint("Land", false, 20.0);
	int avoidUnbuildableAreas = createClassDistConstraint(classUnbuildable, 10.0);
	int avoidPond = createClassDistConstraint(classPond, 30.0);
	int avoidSettleArea = createClassDistConstraint(classSettleArea, 30.0);
	int avoidForest = createTypeDistConstraint("Tree", 20.0);

	for(p = 1; < cPlayers) {
		for(i = 0; < numPondsPerPlayer) {
			int pondID = createAreaWithSuperArea(rmAreaID(cTeamSplitName + " " + rmGetPlayerTeam(getPlayer(p))));
			rmSetAreaWaterType(pondID, cPrimaryWaterTexture);
			rmSetAreaSize(pondID, minPondFraction, maxPondFraction);

			rmSetAreaCoherence(pondID, 1.0);
			rmSetAreaBaseHeight(pondID, 2.0);

			rmAddAreaToClass(pondID, classPond);
			rmAddAreaToClass(pondID, classFishResourceBlock);
			if(cMapFeatureRestriction == cFeatureRestrictionPlayer || cMapFeatureRestriction == cFeatureRestrictionEverywhere) {
				rmAddAreaConstraint(pondID, forceToCenter);
			} else if(cMapFeatureRestriction == cFeatureRestrictionNonPlayer || cMapFeatureRestriction == cFeatureRestrictionEverywhere) {
				rmAddAreaConstraint(pondID, forceToPlayer);
			}
			rmAddAreaConstraint(pondID, avoidAll);
			rmAddAreaConstraint(pondID, avoidEdge);
			rmAddAreaConstraint(pondID, avoidTower);
			rmAddAreaConstraint(pondID, avoidPlayer);
			rmAddAreaConstraint(pondID, avoidImpassableLand);
			rmAddAreaConstraint(pondID, avoidUnbuildableAreas);
			rmAddAreaConstraint(pondID, avoidPond);
			rmAddAreaConstraint(pondID, avoidSettleArea);
			rmAddAreaConstraint(pondID, avoidForest);
			rmSetAreaWarnFailure(pondID, false);
		    rmBuildArea(pondID);
		}
	}
}

int generateCliffs(float impassableDist = 20.0) {
	if(cMapDoesNotAllowCliffs) {
		return(0);
	}

	// Avoids beautification overwriting cliffs.
	cMapHasSmallBeautificationAreas = true;

	bool isCliffImpassable = randChance(1.0 / 3.0) && cMapType == cMapTypePlain; // Only for plain maps.
	float cliffSizeFloat = rmRandFloat(0.0, 1.0);
	float minCliffFraction = 0.0;
	float maxCliffFraction = 0.0;

	if(isCliffImpassable) {
		minCliffFraction = areaSquareMetersToFraction(600);
		maxCliffFraction = areaSquareMetersToFraction(800);
	} else if(randChance()) {
		minCliffFraction = areaSquareMetersToFraction(600);
		maxCliffFraction = areaSquareMetersToFraction(700);
	} else {
		minCliffFraction = areaSquareMetersToFraction(700);
		maxCliffFraction = areaSquareMetersToFraction(800);
	}

	int numCliffsPerPlayer = 0;

	if(isCliffImpassable) {
		numCliffsPerPlayer = rmRandInt(1, 3);
	} else if(cMapType == cMapTypePlain) {
		if(randChance()) {
			numCliffsPerPlayer = rmRandInt(4, 6);
		} else {
			numCliffsPerPlayer = rmRandInt(1, 6);
		}
	} else {
		numCliffsPerPlayer = rmRandInt(1, 3);
	}

	int forceToCenter = createClassDistConstraint(classBonusResourceBlock, 1.0);
	int forceToPlayer = createClassDistConstraint(classMediumResourceBlock, 1.0);
	int avoidTower = createClassDistConstraint(classTower, 25.0);
	int avoidImpassableLand = createTerrainDistConstraint("Land", false, impassableDist);
	int avoidUnbuildableAreas = createClassDistConstraint(classUnbuildable, 10.0);
	int avoidCliff = createClassDistConstraint(classCliff, 40.0);
	int avoidSettleArea = createClassDistConstraint(classSettleArea, 20.0);
	int avoidForest = createTypeDistConstraint("Tree", 20.0);

	for(p = 1; < cPlayers) {
		for(i = 0; < numCliffsPerPlayer) {
			int cliffID = createAreaWithSuperArea(rmAreaID(cTeamSplitName + " " + rmGetPlayerTeam(getPlayer(p))));
			rmSetAreaCliffType(cliffID, cPrimaryCliffType);
			rmSetAreaSize(cliffID, minCliffFraction, maxCliffFraction);

			rmSetAreaCoherence(cliffID, 1.0);
			if(isCliffImpassable) {
				rmSetAreaTerrainType(cliffID, getRandomCliffByStyle(true));
				rmSetAreaCliffEdge(cliffID, 2, 1.0, 0.0, 1.0, 1);
				rmSetAreaCliffPainting(cliffID, true, true, true, 1.5, false);
			} else {
				rmSetAreaTerrainType(cliffID, cPrimaryTerrainTexture);
				rmSetAreaCliffEdge(cliffID, 2, 0.25, 0.0, 1.0, 1);
				rmSetAreaCliffPainting(cliffID, true, true, true, 1.5, true);
			}
			rmSetAreaCliffHeight(cliffID, 4.0, 0.0, 1.0); // -2.0 would also be an option, but sometimes looks weird.
			rmSetAreaHeightBlend(cliffID, 1);

			rmAddAreaToClass(cliffID, classCliff);
			rmAddAreaToClass(cliffID, classBonusResourceBlock);
			rmAddAreaToClass(cliffID, classMediumResourceBlock);
			if(cMapFeatureRestriction == cFeatureRestrictionPlayer || cMapFeatureRestriction == cFeatureRestrictionEverywhere) {
				rmAddAreaConstraint(cliffID, forceToCenter);
			} else if(cMapFeatureRestriction == cFeatureRestrictionNonPlayer || cMapFeatureRestriction == cFeatureRestrictionEverywhere) {
				rmAddAreaConstraint(cliffID, forceToPlayer);
			}
			rmAddAreaConstraint(cliffID, avoidAll);
			rmAddAreaConstraint(cliffID, avoidEdge);
			rmAddAreaConstraint(cliffID, avoidTower);
			rmAddAreaConstraint(cliffID, avoidImpassableLand);
			rmAddAreaConstraint(cliffID, avoidUnbuildableAreas);
			rmAddAreaConstraint(cliffID, avoidCliff);
			rmAddAreaConstraint(cliffID, avoidSettleArea);
			rmAddAreaConstraint(cliffID, avoidForest);
			rmSetAreaWarnFailure(cliffID, false);
			rmBuildArea(cliffID);
		}
	}

	return(numCliffsPerPlayer);
}

void generateTerrainFeatures() {
	if(cMapFeatureRestriction == cFeatureRestrictionEverywhere) {
		return;
	}

	float terrainFeatureFloat = rmRandFloat(0.0, 1.0);

	// This is the sole exception for type-specific stuff down here to avoid even more parameters.
	if(cMapForceFeatures != cForceFeatureNone) {
		if(cMapForceFeatures == cForceFeatureAll) {
			generatePonds();
			generateCliffs();
		} else if(cMapForceFeatures == cForceFeatureCliffs) {
			generateCliffs();
		} else if(cMapForceFeatures == cForceFeaturePonds) {
			generatePonds();
		}
	} else if(cMapType == cMapTypePlain) {
		if(terrainFeatureFloat < 0.2) {
			generatePonds();
		} else if(terrainFeatureFloat < 0.4) {
			generateCliffs(20.0);
		} else if(terrainFeatureFloat < 0.6 && cMapBonusAreaSize != cBonusAreaSizeLarge) {
			generatePonds();

			if(randChance(2.0 / 3.0)) {
				generateCliffs(8.0);
			} else {
				// Only for plain.
				generateCliffs(20.0);
			}
		}
	} else {
		if(terrainFeatureFloat < 0.2) {
			generatePonds();
		} else if(terrainFeatureFloat < 0.4) {
			generateCliffs(20.0);
		}
	}
}

void beautifyTerrain() {
	// Classes.
	int classPlayer = defineClass();
	int classBeautification = defineClass();

	int avoidAll = createTypeDistConstraint("All", 1.0);
	int farAvoidImpassableLand = createTerrainDistConstraint("Land", false, 10.0);
	int mediumAvoidImpassableLand = createTerrainDistConstraint("Land", false, 5.0);
	int shortAvoidImpassableLand = createTerrainDistConstraint("Land", false, 1.0);
	int avoidUnbuildableAreas = createClassDistConstraint(classUnbuildable, 10.0);
	int avoidCliff = createClassDistConstraint(classCliff, 1.0);

	// Player areas.
	string playerTerrainTexture = getRandomTerrainWithDistance(cPrimaryTerrainTexture, INF);
	setLayerFromTextureSet(playerTerrainTexture, cPrimaryTerrainTexture);

	float playerAreaRadiusMetersMax = 0.0;

	if(cMapHasSmallBeautificationAreas) {
		playerAreaRadiusMetersMax = 22.5;
	} else {
		playerAreaRadiusMetersMax = 67.5;
	}

	float playerAreaFraction = areaRadiusMetersToFraction(min(playerAreaRadiusMetersMax, 15.0 * (getLayerCount() + 1)));

	for(i = 1; < cPlayers) {
		int playerLayerWidthCount = 0;

		int playerAreaID = createArea();
		rmSetAreaTerrainType(playerAreaID, playerTerrainTexture);
		for(j = 0; < getLayerCount()) {
			// Randomize layer width.
			int playerLayerWidth = rmRandInt(3, 6);

			// Load layer and apply width (we're starting from the outermost layer with 0 area edge distance)!
			rmAddAreaTerrainLayer(playerAreaID, getLayer(j), playerLayerWidthCount, playerLayerWidthCount + playerLayerWidth);

			// Increment width.
			playerLayerWidthCount = playerLayerWidthCount + playerLayerWidth;
		}
		rmSetAreaSize(playerAreaID, playerAreaFraction);
		rmSetAreaLocPlayer(playerAreaID, getPlayer(i));

		rmSetAreaMinBlobs(playerAreaID, 1);
		rmSetAreaMaxBlobs(playerAreaID, 4);
		rmSetAreaMinBlobDistance(playerAreaID, 16.0);
		rmSetAreaMaxBlobDistance(playerAreaID, 32.0);

		rmAddAreaToClass(playerAreaID, classPlayer);
		rmAddAreaConstraint(playerAreaID, avoidAll);
		rmAddAreaConstraint(playerAreaID, shortAvoidImpassableLand);
		rmAddAreaConstraint(playerAreaID, avoidUnbuildableAreas);
		rmAddAreaConstraint(playerAreaID, avoidCliff);
		rmSetAreaWarnFailure(playerAreaID, false);
		rmBuildArea(playerAreaID);
	}

	// Other embellishment.
	int avoidPlayer = createClassDistConstraint(classPlayer, 1.0);
	int avoidBeautification = createClassDistConstraint(classBeautification, 1.0);

	string beautifyTerrainTexture = getRandomTerrain(cPrimaryTerrainTexture);

	while(getTextureCount() > 2 && beautifyTerrainTexture == cPrimaryTerrainTexture && beautifyTerrainTexture == playerTerrainTexture) {
		beautifyTerrainTexture = getRandomTerrain(cPrimaryTerrainTexture);
	}

	setLayerFromTextureSet(beautifyTerrainTexture, cPrimaryTerrainTexture);

	float beautifyAreaRadiusMetersMax = 0.0;

	if(cMapHasSmallBeautificationAreas) {
		beautifyAreaRadiusMetersMax = 22.5;
	} else {
		beautifyAreaRadiusMetersMax = 67.5;
	}

	float beautifyFraction = areaRadiusMetersToFraction(min(beautifyAreaRadiusMetersMax, 10.0 * (getLayerCount() + 1)));

	// Always avoid player, avoid embellishment if at least 2 layers (at least 3 total as outer texture is + 1).
	bool selfAvoid = getLayerCount() > 2;
	bool playerAvoid = true;
	int beautifyFailCount = 0;

	for(i = 0; < 40 * cNonGaiaPlayers) {
		int beautifyLayerWidthCount = 0;

		int beautifyID = createArea();
		rmSetAreaTerrainType(beautifyID, beautifyTerrainTexture);
		for(j = 0; < getLayerCount()) {
			int beautifyLayerWidth = rmRandInt(2, 4);
			rmAddAreaTerrainLayer(beautifyID, getLayer(j), beautifyLayerWidthCount, beautifyLayerWidthCount + beautifyLayerWidth);
			beautifyLayerWidthCount = beautifyLayerWidthCount + beautifyLayerWidth;
		}
		rmSetAreaSize(beautifyID, beautifyFraction);

		rmSetAreaMinBlobs(beautifyID, 1);
		rmSetAreaMaxBlobs(beautifyID, 4);
		rmSetAreaMinBlobDistance(beautifyID, 16.0);
		rmSetAreaMaxBlobDistance(beautifyID, 32.0);

		rmAddAreaToClass(beautifyID, classBeautification);
		rmAddAreaConstraint(beautifyID, avoidAll);
		rmAddAreaConstraint(beautifyID, shortAvoidImpassableLand);
		rmAddAreaConstraint(beautifyID, avoidUnbuildableAreas);
		rmAddAreaConstraint(beautifyID, avoidCliff);

		if(playerAvoid) {
			rmAddAreaConstraint(beautifyID, avoidPlayer);
		}
		if(selfAvoid) {
			rmAddAreaConstraint(beautifyID, avoidBeautification);
		}
		rmSetAreaWarnFailure(beautifyID, false);

		if(rmBuildArea(beautifyID)) {
			beautifyFailCount = 0;
		} else {
			beautifyFailCount++;

			if(beautifyFailCount == 3) {
				break;
			}
		}
	}

	int avoidBuildings = createTypeDistConstraint("Building", 20.0);

	// Elevation.
	for(i = 0; < 40 * cNonGaiaPlayers) {
		int elevationID = createArea();
		rmSetAreaSize(elevationID, rmAreaTilesToFraction(50), rmAreaTilesToFraction(100));

		rmSetAreaBaseHeight(elevationID, rmRandFloat(1.0, 3.0));
		rmSetAreaHeightBlend(elevationID, 1);
		rmSetAreaMinBlobs(elevationID, 1);
		rmSetAreaMaxBlobs(elevationID, 5);
		rmSetAreaMinBlobDistance(elevationID, 16.0);
		rmSetAreaMaxBlobDistance(elevationID, 40.0);

		rmAddAreaConstraint(elevationID, avoidAll);
		rmAddAreaConstraint(elevationID, avoidBuildings);
		rmAddAreaConstraint(elevationID, mediumAvoidImpassableLand);
		rmAddAreaConstraint(elevationID, avoidUnbuildableAreas);
		rmAddAreaConstraint(elevationID, avoidCliff);
		rmSetAreaWarnFailure(elevationID, false);
		rmBuildArea(elevationID);
	}

	// Chance for road texture below starting settlement.
}

void placeSettlements() {
	// Starting settlement.
	int startingSettlementID = createObjectDefVerify("starting settlement");
	addObjectDefItemVerify(startingSettlementID, "Settlement Level 1", 1, 0.0);

	placeObjectAtPlayerLocs(startingSettlementID, true);

	// Towers.
	int startingTowerID = createObjectDefVerify("starting tower");
	addObjectDefItemVerify(startingTowerID, "Tower", 1, 0.0);

	for(i = 1; <= getLocStorageSize()) {
		placeObjectDefAtLoc(startingTowerID, getLocOwner(i), getLocX(i), getLocZ(i));
	}

	// Settlements.
	int settlementID = createObjectDefVerify("settlements");
	addObjectDefItemVerify(settlementID, "Settlement", 1, 0.0);

	placeObjectAtAllFairLocs(settlementID);
}

void addGoldSimLocConstraints(float avoidGoldDist = 45.0) {
	int avoidCorner = createClassDistConstraint(classCornerBlock, 1.0);
	int avoidImpassableLand = createTerrainDistConstraint("Land", false, 10.0);
	int avoidUnbuildableAreas = createClassDistConstraint(classUnbuildable, 10.0);
	int avoidMediumResourceBlock = createClassDistConstraint(classMediumResourceBlock, 8.0);
	int avoidSettlement = createTypeDistConstraint("AbstractSettlement", 20.0);
	int avoidGold = createTypeDistConstraint("Gold", avoidGoldDist);

	// Soft bias for forward gold; may not be followed if impossible to do so.
	// setSimLocBias(cBiasForward);

	addSimLocConstraint(avoidAll);
	addSimLocConstraint(avoidCorner);
	addSimLocConstraint(avoidImpassableLand);
	addSimLocConstraint(avoidUnbuildableAreas);
	addSimLocConstraint(createClassDistConstraint(classPlayerCore, 55.0));
	addSimLocConstraint(avoidMediumResourceBlock);
	addSimLocConstraint(avoidTowerLOS);
	addSimLocConstraint(avoidSettlement);
	addSimLocConstraint(avoidGold);
}

int placeSimLocGold(string goldLabel = "", int numGold = 0, float startingDistMeters = 0.0, float endingDistMeters = 0.0, bool isCritical = true) {
	int goldID = createObjectDefVerify(goldLabel);
	addObjectDefItemVerify(goldID, cGoldLarge, 1, 0.0);

	float avoidGoldDist = 45.0;

	for(i = numGold; > 0) {
		addGoldSimLocConstraints(avoidGoldDist);

		enableSimLocTwoPlayerCheck();
		addSimLoc(startingDistMeters, endingDistMeters, avoidGoldDist, 8.0, 8.0);

		for(j = 1; < numGold) {
			enableSimLocTwoPlayerCheck();
			addSimLocWithPrevConstraints(startingDistMeters, endingDistMeters, avoidGoldDist, 8.0, 8.0);
		}

		if(placeObjectAtNewSimLocs(goldID, false, goldLabel + " (" + numGold + ")", numGold == 1 && isCritical, 2500)) {
			return(numGold);
		} else {
			numGold--;
		}
	}

	// Failed to place, numGold has to be 0.
	return(numGold);
}

int placePlayerGold(int numPlayerGold = 0, bool doVerify = true) {
	int avoidCorner = createClassDistConstraint(classCornerBlock, 1.0);
	int avoidImpassableLand = createTerrainDistConstraint("Land", false, 5.0);
	int avoidUnbuildableAreas = createClassDistConstraint(classUnbuildable, 10.0);
	int avoidMediumResourceBlock = createClassDistConstraint(classMediumResourceBlock, 8.0);
	int avoidSettlement = createTypeDistConstraint("AbstractSettlement", 10.0);
	int avoidGold = createTypeDistConstraint("Gold", 45.0);

	int goldID = createObjectDefVerify("player gold", doVerify);
	addObjectDefItemVerify(goldID, cGoldLarge, 1, 0.0);
	rmAddObjectDefConstraint(goldID, avoidAll);
	rmAddObjectDefConstraint(goldID, avoidEdge);
	rmAddObjectDefConstraint(goldID, avoidCorner);
	rmAddObjectDefConstraint(goldID, avoidImpassableLand);
	rmAddObjectDefConstraint(goldID, avoidUnbuildableAreas);
	rmAddObjectDefConstraint(goldID, avoidMediumResourceBlock);
	rmAddObjectDefConstraint(goldID, createClassDistConstraint(classPlayerCore, 65.0));
	rmAddObjectDefConstraint(goldID, avoidSettlement);
	rmAddObjectDefConstraint(goldID, avoidGold);

	placeObjectInPlayerSplits(goldID, false, numPlayerGold);

	return(numPlayerGold);
}

int placeBonusGold(int numBonusGold = 0, float avoidDist = 45.0, bool doVerify = true) {
	int avoidMirrorCenter = createClassDistConstraint(classMirrorCenter, 1.0);
	int avoidCorner = createClassDistConstraint(classCornerBlock, 1.0);
	int avoidImpassableLand = createTerrainDistConstraint("Land", false, 5.0);
	int avoidUnbuildableAreas = createClassDistConstraint(classUnbuildable, 10.0);
	int avoidBonusResourceBlock = createClassDistConstraint(classBonusResourceBlock, 8.0);
	int avoidSettlement = createTypeDistConstraint("AbstractSettlement", 20.0);
	int avoidGold = createTypeDistConstraint("Gold", avoidDist);

	int goldID = createObjectDefVerify("bonus gold", doVerify);
	addObjectDefItemVerify(goldID, cGoldLarge, 1, 0.0);
	rmAddObjectDefConstraint(goldID, avoidAll);
	rmAddObjectDefConstraint(goldID, avoidEdge);
	rmAddObjectDefConstraint(goldID, avoidCorner);
	rmAddObjectDefConstraint(goldID, avoidImpassableLand);
	rmAddObjectDefConstraint(goldID, avoidUnbuildableAreas);
	rmAddObjectDefConstraint(goldID, avoidTowerLOS);
	rmAddObjectDefConstraint(goldID, avoidBonusResourceBlock);
	rmAddObjectDefConstraint(goldID, avoidSettlement);
	rmAddObjectDefConstraint(goldID, avoidGold);

	if(cMapMirrorInBonusArea && gameHasTwoEqualTeams() && numBonusGold <= 1) {
		rmAddObjectDefConstraint(goldID, avoidMirrorCenter);

		setMirrorMode(cMirrorPoint);
		placeFarObjectMirrored(goldID, false, numBonusGold);
		setMirrorMode(cMirrorNone);
	} else {
		if(cMapPlaceBonusInTeamArea) {
			placeObjectInTeamSplits(goldID, false, numBonusGold);
		} else {
			placeObjectInPlayerSplits(goldID, false, numBonusGold);
		}
	}

	return(numBonusGold);
}

void addHuntSimLocConstraints(float avoidFoodDist = 30.0) {
	int avoidCorner = createClassDistConstraint(classCornerBlock, 1.0);
	int avoidImpassableLand = createTerrainDistConstraint("Land", false, 5.0);
	int avoidUnbuildableAreas = createClassDistConstraint(classUnbuildable, 10.0);
	int avoidMediumResourceBlock = createClassDistConstraint(classMediumResourceBlock, 8.0);
	int avoidSettlement = createTypeDistConstraint("AbstractSettlement", 20.0);
	int avoidFood = createTypeDistConstraint("Food", avoidFoodDist);

	addSimLocConstraint(avoidAll);
	addSimLocConstraint(avoidCorner);
	addSimLocConstraint(avoidImpassableLand);
	addSimLocConstraint(avoidUnbuildableAreas);
	addSimLocConstraint(createClassDistConstraint(classPlayerCore, 55.0));
	addSimLocConstraint(avoidMediumResourceBlock);
	addSimLocConstraint(avoidTowerLOS);
	addSimLocConstraint(avoidSettlement);
	addSimLocConstraint(avoidFood);
}

int placeSimLocFood(string foodLabel = "", int numFood = 0, float startingDistMeters = 0.0, float endingDistMeters = 0.0, bool isCritical = true) {
	float avoidFoodDist = 35.0;

	for(i = numFood; > 0) {
		addHuntSimLocConstraints(avoidFoodDist);
		enableSimLocTwoPlayerCheck();
		addSimLoc(startingDistMeters, endingDistMeters, avoidFoodDist, 8.0, 8.0);

		for(j = 1; < numFood) {
			enableSimLocTwoPlayerCheck();
			addSimLocWithPrevConstraints(startingDistMeters, endingDistMeters, avoidFoodDist, 8.0, 8.0, false, true, true);
		}

		if(createSimLocs(foodLabel + " (" + numFood + ")", numFood == 1 && isCritical, 2500)) {
			for(k = 1; <= getNumSimLocs()) {
				int foodID = createObjectDefVerify(foodLabel + " " + k);
				addFoodToObject(foodID, getRandomFoodByStyle(0.9, cMapHasWater), 450, 2250);

				placeObjectAtSimLoc(foodID, false, k);
			}

			resetSimLocs();
			return(numFood);
		} else {
			resetSimLocs();
			numFood--;
		}
	}

	// Failed to place, numFood has to be 0.
	return(numFood);
}

int placePlayerFood(int numPlayerFood = 0, bool doVerify = true) {
	int avoidImpassableLand = createTerrainDistConstraint("Land", false, 5.0);
	int avoidUnbuildableAreas = createClassDistConstraint(classUnbuildable, 10.0);
	int avoidMediumResourceBlock = createClassDistConstraint(classMediumResourceBlock, 8.0);
	int avoidSettlement = createTypeDistConstraint("AbstractSettlement", 10.0);
	int avoidFood = createTypeDistConstraint("Food", 35.0);

	int foodID = createObjectDefVerify("player food", doVerify);
	addFoodToObject(foodID, getRandomFoodByStyle(0.9, cMapHasWater), 450, 2250);
	rmAddObjectDefConstraint(foodID, avoidAll);
	rmAddObjectDefConstraint(foodID, avoidEdge);
	rmAddObjectDefConstraint(foodID, avoidImpassableLand);
	rmAddObjectDefConstraint(foodID, avoidUnbuildableAreas);
	rmAddObjectDefConstraint(foodID, avoidMediumResourceBlock);
	rmAddObjectDefConstraint(foodID, createClassDistConstraint(classPlayerCore, 65.0));
	rmAddObjectDefConstraint(foodID, avoidSettlement);
	rmAddObjectDefConstraint(foodID, avoidFood);

	placeObjectInPlayerSplits(foodID, false, numPlayerFood);

	return(numPlayerFood);
}

int placeBonusFood(int numBonusFood = 0, float avoidDist = 35.0, bool doVerify = true) {
	int avoidMirrorCenter = createClassDistConstraint(classMirrorCenter, 1.0);
	int avoidImpassableLand = createTerrainDistConstraint("Land", false, 5.0);
	int avoidUnbuildableAreas = createClassDistConstraint(classUnbuildable, 10.0);
	int avoidBonusResourceBlock = createClassDistConstraint(classBonusResourceBlock, 8.0);
	int avoidSettlement = createTypeDistConstraint("AbstractSettlement", 15.0);
	int avoidFood = createTypeDistConstraint("Food", avoidDist);

	for(i = 0; < numBonusFood) {
		int foodID = createObjectDefVerify("bonus food " + i, doVerify);
		addFoodToObject(foodID, getRandomFoodByStyle(0.9, cMapHasWater), 450, 2250);
		rmAddObjectDefConstraint(foodID, avoidAll);
		rmAddObjectDefConstraint(foodID, avoidEdge);
		rmAddObjectDefConstraint(foodID, avoidImpassableLand);
		rmAddObjectDefConstraint(foodID, avoidUnbuildableAreas);
		rmAddObjectDefConstraint(foodID, avoidTowerLOS);
		rmAddObjectDefConstraint(foodID, avoidBonusResourceBlock);
		rmAddObjectDefConstraint(foodID, avoidSettlement);
		rmAddObjectDefConstraint(foodID, avoidFood);

		if(cMapMirrorInBonusArea && gameHasTwoEqualTeams() && numBonusFood <= 1) {
			rmAddObjectDefConstraint(foodID, avoidMirrorCenter);

			setMirrorMode(cMirrorPoint);
			placeFarObjectMirrored(foodID);
			setMirrorMode(cMirrorNone);
		} else {
			if(cMapPlaceBonusInTeamArea) {
				placeObjectInTeamSplits(foodID);
			} else {
				placeObjectInPlayerSplits(foodID);
			}
		}
	}

	return(numBonusFood);
}

void placeBonusBerries(int numBerries = 0, bool doVerify = true) {
	int avoidImpassableLand = createTerrainDistConstraint("Land", false, 5.0);
	int avoidUnbuildableAreas = createClassDistConstraint(classUnbuildable, 10.0);
	int avoidBonusResourceBlock = createClassDistConstraint(classBonusResourceBlock, 8.0);
	int avoidSettlement = createTypeDistConstraint("AbstractSettlement", 20.0);
	int avoidFood = createTypeDistConstraint("Food", 20.0);

	int berryCount = rmRandInt(4, 12);

	int foodID = createObjectDefVerify("bonus berries", doVerify);
	addObjectDefItemVerify(foodID, cFoodBerryBush, berryCount, getClusterDist(berryCount));
	rmAddObjectDefConstraint(foodID, avoidAll);
	rmAddObjectDefConstraint(foodID, avoidEdge);
	rmAddObjectDefConstraint(foodID, avoidImpassableLand);
	rmAddObjectDefConstraint(foodID, avoidUnbuildableAreas);
	rmAddObjectDefConstraint(foodID, createClassDistConstraint(classPlayerCore, 75.0));
	// rmAddObjectDefConstraint(foodID, avoidBonusResourceBlock);
	rmAddObjectDefConstraint(foodID, avoidSettlement);
	rmAddObjectDefConstraint(foodID, avoidFood);

	if(cMapPlaceBonusInTeamArea) {
		placeObjectInTeamSplits(foodID, false, numBerries);
	} else {
		placeObjectInPlayerSplits(foodID, false, numBerries);
	}
}

void placeStartingResources() {
	int avoidImpassableLand = createTerrainDistConstraint("Land", false, 10.0);
	int avoidUnbuildableAreas = createClassDistConstraint(classUnbuildable, 10.0);

	// First starting gold near one of the towers (set last parameter to true to use square placement).
	storeObjectDefItem(cGoldSmall, 1, 0.0);
	storeObjectConstraint(avoidAll);
	storeObjectConstraint(avoidEdge);
	storeObjectConstraint(createTypeDistConstraint("Tower", rmRandFloat(8.0, 8.0))); // Don't get too close.
	storeObjectConstraint(avoidImpassableLand);

	placeStoredObjectNearStoredLocs(4, false, 21.0, 24.0, 10.0);

	resetObjectStorage();

	// Chance for additional starting gold.
	int startingGoldID = createObjectDefVerify("bonus starting gold");
	addObjectDefItemVerify(startingGoldID, cGoldSmall, 1, 0.0);
	setObjectDefDistance(startingGoldID, 21.0, 24.0);
	rmAddObjectDefConstraint(startingGoldID, avoidAll);
	rmAddObjectDefConstraint(startingGoldID, avoidEdge);
	rmAddObjectDefConstraint(startingGoldID, avoidImpassableLand);
	rmAddObjectDefConstraint(startingGoldID, avoidUnbuildableAreas);
	rmAddObjectDefConstraint(startingGoldID, createTypeDistConstraint("Gold", 30.0));

	if(randChance(1.0 / 12.0)) {
		placeObjectAtPlayerLocs(startingGoldID);
	}

	// Starting hunt 1.
	int startingHunt1ID = createObjectDefVerify("starting hunt 1");
	addFoodToObject(startingHunt1ID, getRandomHuntByStyle(cMapHasWater), 450, 1500);
	if(randChance()) {
		setObjectDefDistance(startingHunt1ID, 23.0, 27.0);
	} else {
		setObjectDefDistance(startingHunt1ID, 17.0, 23.0);
	}
	rmAddObjectDefConstraint(startingHunt1ID, avoidAll);
	rmAddObjectDefConstraint(startingHunt1ID, avoidEdge);
	rmAddObjectDefConstraint(startingHunt1ID, avoidImpassableLand);
	rmAddObjectDefConstraint(startingHunt1ID, avoidUnbuildableAreas);
	rmAddObjectDefConstraint(startingHunt1ID, createTypeDistConstraint("Gold", 10.0));
	rmAddObjectDefConstraint(startingHunt1ID, createTypeDistConstraint("Huntable", 30.0));

	if(randChance(2.0 / 3.0)) {
		placeObjectAtPlayerLocs(startingHunt1ID);

		// Starting hunt 2.
		int startingHunt2ID = createObjectDefVerify("starting hunt 2");
		addFoodToObject(startingHunt2ID, getRandomHuntByStyle(cMapHasWater), 450, 1500);
		setObjectDefDistance(startingHunt2ID, 23.0, 27.0);
		rmAddObjectDefConstraint(startingHunt2ID, avoidAll);
		rmAddObjectDefConstraint(startingHunt2ID, avoidEdge);
		rmAddObjectDefConstraint(startingHunt2ID, avoidImpassableLand);
		rmAddObjectDefConstraint(startingHunt2ID, avoidUnbuildableAreas);
		rmAddObjectDefConstraint(startingHunt2ID, createTypeDistConstraint("Gold", 10.0));
		rmAddObjectDefConstraint(startingHunt2ID, createTypeDistConstraint("Huntable", 30.0));

		if(randChance(0.2)) {
			placeObjectAtPlayerLocs(startingHunt2ID);
		}
	}

	// Berries & chicken.
	int startingFood1ID = createObjectDefVerify("starting food 1");
	addObjectDefItemVerify(startingFood1ID, cFoodBerryBush, rmRandInt(4, 9), 2.0);
	setObjectDefDistance(startingFood1ID, 23.0, 27.0);
	rmAddObjectDefConstraint(startingFood1ID, avoidAll);
	rmAddObjectDefConstraint(startingFood1ID, avoidEdge);
	rmAddObjectDefConstraint(startingFood1ID, avoidImpassableLand);
	rmAddObjectDefConstraint(startingFood1ID, avoidUnbuildableAreas);
	rmAddObjectDefConstraint(startingFood1ID, createTypeDistConstraint("Gold", 10.0));
	rmAddObjectDefConstraint(startingFood1ID, createTypeDistConstraint("Food", 15.0));

	placeObjectAtPlayerLocs(startingFood1ID);

	int startingFood2ID = createObjectDefVerify("starting food 2");
	addObjectDefItemVerify(startingFood2ID, cFoodChicken, rmRandInt(4, 9), 2.0);
	setObjectDefDistance(startingFood2ID, 20.0, 30.0);
	rmAddObjectDefConstraint(startingFood2ID, avoidAll);
	rmAddObjectDefConstraint(startingFood2ID, avoidEdge);
	rmAddObjectDefConstraint(startingFood2ID, avoidImpassableLand);
	rmAddObjectDefConstraint(startingFood2ID, avoidUnbuildableAreas);
	rmAddObjectDefConstraint(startingFood2ID, createTypeDistConstraint("Gold", 10.0));
	rmAddObjectDefConstraint(startingFood2ID, createTypeDistConstraint("Food", 15.0));

	if(randChance(0.1)) {
		placeObjectAtPlayerLocs(startingFood2ID);
	}
}

void placeForests() {
	// Forest avoidance between 20 and 26, averaging at 23.
	int avoidForest = createTypeDistConstraint("Tree", 20.0 + 2.0 * rmRandInt(0, 4));
	int forestAvoidStartingSettlement = createClassDistConstraint(classPlayerCore, 20.0);
	int avoidImpassableLand = createTerrainDistConstraint("Land", false, 10.0);
	int avoidUnbuildableAreas = createClassDistConstraint(classUnbuildable, 10.0);
	int avoidForestBlock = createClassDistConstraint(classForestResourceBlock, 1.0);

	int numPlayerForests = 2;
	float playerAreaFraction = areaRadiusMetersToFraction(55.0);

	float forestMinFraction = areaRadiusMetersToFraction(8.0); // About rmAreaTilesToFraction(50.0).
	float forestMaxFraction = areaRadiusMetersToFraction(12.0); // About rmAreaTilesToFraction(110.0).

	for(i = 1; < cPlayers) {
		int playerForestAreaID = createArea();
		rmSetAreaSize(playerForestAreaID, playerAreaFraction);
		rmSetAreaLocPlayer(playerForestAreaID, getPlayer(i));
		// rmSetAreaTerrainType(playerForestAreaID, cHadesBuildable1);

		rmSetAreaCoherence(playerForestAreaID, 1.0);

		rmSetAreaWarnFailure(playerForestAreaID, false);
		rmBuildArea(playerForestAreaID);

		for(j = 0; < numPlayerForests) {
			int playerForestID = createAreaWithSuperArea(playerForestAreaID);
			rmSetAreaForestType(playerForestID, cPrimaryForestTexture);
			rmSetAreaSize(playerForestID, forestMinFraction, forestMaxFraction);

			rmAddAreaConstraint(playerForestID, avoidAll);
			rmAddAreaConstraint(playerForestID, forestAvoidStartingSettlement);
			rmAddAreaConstraint(playerForestID, avoidForest);
			rmAddAreaConstraint(playerForestID, avoidImpassableLand);
			rmAddAreaConstraint(playerForestID, avoidUnbuildableAreas);
			rmAddAreaConstraint(playerForestID, avoidForestBlock);
			rmSetAreaWarnFailure(playerForestID, false);
			rmBuildArea(playerForestID);
		}
	}


	int forestFailCount = 0;

	// We basically continue until we failed 3 times in a row, forest density is controlled via avoidance.
	while(true) {
		int forestID = createArea();
		rmSetAreaForestType(forestID, cPrimaryForestTexture);
		rmSetAreaSize(forestID, forestMinFraction, forestMaxFraction);

		rmAddAreaConstraint(forestID, avoidAll);
		rmAddAreaConstraint(forestID, forestAvoidStartingSettlement);
		rmAddAreaConstraint(forestID, avoidForest);
		rmAddAreaConstraint(forestID, avoidImpassableLand);
		rmAddAreaConstraint(forestID, avoidUnbuildableAreas);
		rmAddAreaConstraint(forestID, avoidForestBlock);
		rmSetAreaWarnFailure(forestID, false);

		if(rmBuildArea(forestID)) {
			forestFailCount = 0;
		} else {
			forestFailCount++;

			if(forestFailCount == 3) {
				break;
			}
		}
	}
}

void addHerdableSimLocConstraints(float avoidHerdableDist = 35.0) {
	int avoidImpassableLand = createTerrainDistConstraint("Land", false, 5.0);
	int avoidMediumResourceBlock = createClassDistConstraint(classMediumResourceBlock, 8.0);
	int avoidHerdable = createTypeDistConstraint("Herdable", avoidHerdableDist);

	addSimLocConstraint(avoidAll);
	addSimLocConstraint(avoidImpassableLand);
	// addSimLocConstraint(createClassDistConstraint(classPlayerCore, 55.0));
	addSimLocConstraint(avoidMediumResourceBlock);
	addSimLocConstraint(avoidTowerLOS);
	addSimLocConstraint(avoidHerdable);
}

int placeSimLocHerdable(string herdableLabel = "", int numHerdable = 0, float startingDistMeters = 0.0, float endingDistMeters = 0.0, bool isCritical = true) {
	float avoidHerdableDist = 35.0;

	for(i = numHerdable; > 0) {
		resetSimLocs();

		addHerdableSimLocConstraints(avoidHerdableDist);
		enableSimLocTwoPlayerCheck();
		addSimLoc(startingDistMeters, endingDistMeters, avoidHerdableDist, 8.0, 8.0);

		for(j = 1; < numHerdable) {
			enableSimLocTwoPlayerCheck();
			addSimLocWithPrevConstraints(startingDistMeters, endingDistMeters, avoidHerdableDist, 8.0, 8.0);
		}

		if(createSimLocs(herdableLabel + " (" + numHerdable + ")", numHerdable == 1 && isCritical, 2500)) {
			for(k = 1; <= getNumSimLocs()) {
				int herdableID = createObjectDefVerify(herdableLabel + " " + k);
				addObjectDefItemVerify(herdableID, cPrimaryHerdableType, rmRandInt(1, 3), 4.0);
				placeObjectAtSimLoc(herdableID, false, k);
			}

			resetSimLocs();
			return(numHerdable);
		} else {
			resetSimLocs();
			numHerdable--;
		}
	}

	// Failed to place, numHerdable has to be 0.
	return(numHerdable);
}

int placePlayerHerdable(int minPlayerHerdable = 0, int maxPlayerHerdable = 0, bool doVerify = true) {
	int avoidImpassableLand = createTerrainDistConstraint("Land", false, 5.0);
	int avoidHerdable = createTypeDistConstraint("Herdable", 25.0);
	int avoidMediumResourceBlock = createClassDistConstraint(classMediumResourceBlock, 8.0);

	int numPlayerHerdable = rmRandInt(minPlayerHerdable, maxPlayerHerdable);

	int herdableID = createObjectDefVerify("player herdable", doVerify);
	addObjectDefItemVerify(herdableID, cPrimaryHerdableType, rmRandInt(1, 3), 4.0);
	rmAddObjectDefConstraint(herdableID, avoidAll);
	rmAddObjectDefConstraint(herdableID, avoidEdge);
	rmAddObjectDefConstraint(herdableID, avoidTowerLOS);
	rmAddObjectDefConstraint(herdableID, avoidImpassableLand);
	rmAddObjectDefConstraint(herdableID, avoidHerdable);
	rmAddObjectDefConstraint(herdableID, avoidMediumResourceBlock);

	placeObjectInPlayerSplits(herdableID, false, numPlayerHerdable);

	return(numPlayerHerdable);
}

int placeBonusHerdable(int numBonusHerdable = 0, bool doVerify = true) {
	int avoidImpassableLand = createTerrainDistConstraint("Land", false, 5.0);
	int avoidBonusResourceBlock = createClassDistConstraint(classBonusResourceBlock, 8.0);
	int avoidHerdable = createTypeDistConstraint("Herdable", 25.0);

	int herdableID = createObjectDefVerify("bonus herdable", doVerify);
	addObjectDefItemVerify(herdableID, cPrimaryHerdableType, rmRandInt(1, 3), 2.0);
	rmAddObjectDefConstraint(herdableID, avoidAll);
	rmAddObjectDefConstraint(herdableID, avoidEdge);
	rmAddObjectDefConstraint(herdableID, avoidImpassableLand);
	rmAddObjectDefConstraint(herdableID, avoidTowerLOS);
	rmAddObjectDefConstraint(herdableID, avoidHerdable);
	rmAddObjectDefConstraint(herdableID, avoidBonusResourceBlock);

	if(cMapPlaceBonusInTeamArea) {
		placeObjectInTeamSplits(herdableID, false, numBonusHerdable);
	} else {
		placeObjectInPlayerSplits(herdableID, false, numBonusHerdable);
	}

	return(numBonusHerdable);
}

void placeStartingHerdable() {
	int avoidImpassableLand = createTerrainDistConstraint("Land", false, 10.0);
	int avoidUnbuildableAreas = createClassDistConstraint(classUnbuildable, 10.0);

	// Starting herdable (place close if we have a fish spawn).
	int startingHerdableID = createObjectDefVerify("starting herdable");
	if(randChance(0.9)) {
		addObjectDefItemVerify(startingHerdableID, cPrimaryHerdableType, rmRandInt(1, 4), 2.0);
	} else {
		addObjectDefItemVerify(startingHerdableID, cPrimaryHerdableType, rmRandInt(5, 8), 2.0);
	}
	rmAddObjectDefConstraint(startingHerdableID, createTypeDistConstraint("All", 4.0));
	rmAddObjectDefConstraint(startingHerdableID, avoidEdge);
	rmAddObjectDefConstraint(startingHerdableID, avoidImpassableLand);
	rmAddObjectDefConstraint(startingHerdableID, avoidUnbuildableAreas);

	// Place close or far to indicate whether map has fishing or not.
	if(cMapHasFish) {
		placeObjectDefPerPlayer(startingHerdableID, true, 1, 12.0, 13.0, true);
	} else {
		placeObjectDefPerPlayer(startingHerdableID, true, 1, 27.0, 32.0, true);
	}
}

void placeFish() {
	if(cVariationStyle1 == cStyleErebus) {
		cMapHasFish = false;
		cMapHasLargeWaterBody = false;
		return;
	}

	int fishPerPack = 3;
	float fishDist = rmRandFloat(18.0, 26.0);

	// TODO Consider a parameter for shore distance; either bool or float (close: 5.0, far: 12.0).
	int fishLandMin = createTerrainDistConstraint("Land", true, 5.0);
	int fishLandMax = createTerrainMaxDistConstraint("Land", true, 50.0);
	int avoidFish = createTypeDistConstraint("Fish", fishDist);
	int avoidFishResourceBlock = createClassDistConstraint(classFishResourceBlock, 1.0);

	string fishTexture = getRandomFishByStyle();

	int fishID = createObjectDef();
	rmAddObjectDefItem(fishID, fishTexture, fishPerPack, 6.0);
	rmAddObjectDefConstraint(fishID, fishLandMin);
	rmAddObjectDefConstraint(fishID, fishLandMax);
	rmAddObjectDefConstraint(fishID, avoidFish);
	rmAddObjectDefConstraint(fishID, avoidFishResourceBlock);

	if(cMapHasNonMirroredFish) {
		setObjectDefDistanceToMax(fishID);
		placeObjectDefAtLoc(fishID, 0, 0.5, 0.5, 4 * cNonGaiaPlayers);
	} else {
		// Define alternative fish with no avoidance constraint to make sure they get placed (mirrored) properly.
		int altFishID = createObjectDef();
		rmAddObjectDefItem(altFishID, fishTexture, fishPerPack, 6.0);
		rmAddObjectDefConstraint(altFishID, fishLandMin);

		setMirrorMode(cMirrorPoint);
		// > 0.5 * fishDist distance from center to make sure they spawn properly.
		placeFarObjectMirrored(fishID, false, 10, 0.55 * fishDist, -1.0, altFishID);
		setMirrorMode(cMirrorNone);
	}

	// Notify players.
	injectFishHint();
}

void placeMisc() {
	int avoidCorner = createClassDistConstraint(classCornerBlock, 1.0);
	int avoidImpassableLand = createTerrainDistConstraint("Land", false, 5.0);
	int avoidBonusResourceBlock = createClassDistConstraint(classBonusResourceBlock, 1.0);
	int avoidSettlement = createTypeDistConstraint("Settlement", 40.0);
	int avoidRelic = createTypeDistConstraint("Relic", 40.0);
	int avoidPredator = createTypeDistConstraint("AnimalPredator", 40.0);
	int avoidMiscBlock = createClassDistConstraint(classMiscResourceBlock, 1.0);

	// Predators.
	int predator1ID = createObjectDefVerify("predator 1", cDebugMode == cDebugFull);
	addObjectDefItemVerify(predator1ID, getRandomPredatorByStyle(), 1, 0.0);
	rmAddObjectDefConstraint(predator1ID, avoidAll);
	rmAddObjectDefConstraint(predator1ID, avoidEdge);
	rmAddObjectDefConstraint(predator1ID, avoidImpassableLand);
	rmAddObjectDefConstraint(predator1ID, createClassDistConstraint(classPlayerCore, 70.0));
	rmAddObjectDefConstraint(predator1ID, avoidSettlement);
	rmAddObjectDefConstraint(predator1ID, avoidPredator);
	rmAddObjectDefConstraint(predator1ID, avoidMiscBlock);

	placeObjectInPlayerSplits(predator1ID, false, 1);

	int predator2ID = createObjectDefVerify("predator 2", cDebugMode == cDebugFull);
	addObjectDefItemVerify(predator2ID, getRandomPredatorByStyle(), 1, 0.0);
	rmAddObjectDefConstraint(predator2ID, avoidAll);
	rmAddObjectDefConstraint(predator2ID, avoidEdge);
	rmAddObjectDefConstraint(predator2ID, avoidImpassableLand);
	rmAddObjectDefConstraint(predator2ID, createClassDistConstraint(classPlayerCore, 70.0));
	rmAddObjectDefConstraint(predator2ID, avoidSettlement);
	rmAddObjectDefConstraint(predator2ID, avoidPredator);
	rmAddObjectDefConstraint(predator2ID, avoidMiscBlock);

	placeObjectInPlayerSplits(predator2ID, false, 1);

	// Relics.
	int relicID = createObjectDefVerify("relic");
	addObjectDefItemVerify(relicID, cRelic, 1, 0.0);
	rmAddObjectDefConstraint(relicID, avoidAll);
	rmAddObjectDefConstraint(relicID, avoidEdge);
	rmAddObjectDefConstraint(relicID, avoidCorner);
	rmAddObjectDefConstraint(relicID, avoidImpassableLand);
	rmAddObjectDefConstraint(relicID, createClassDistConstraint(classPlayerCore, 70.0));
	rmAddObjectDefConstraint(relicID, avoidRelic);
	rmAddObjectDefConstraint(relicID, avoidMiscBlock);
	if(cMapCanHaveTwoCenterRelics && randChance()) {
		rmAddObjectDefConstraint(relicID, avoidBonusResourceBlock);
	}

	bool hasDoubleRelic = false;

	if(cMapCanHaveTwoCenterRelics) {
		hasDoubleRelic = randChance();
	} else {
		hasDoubleRelic = randChance(0.15);
	}

	if(hasDoubleRelic) {
		placeObjectInPlayerSplits(relicID, false, 2);
	} else {
		placeObjectInPlayerSplits(relicID, false, 1);
	}

	// Straggler trees.
	int stragglerTreeID = createObjectDefVerify("straggler tree");
	addObjectDefItemVerify(stragglerTreeID, getRandomTreeByStyle(), 1, 0.0);
	setObjectDefDistance(stragglerTreeID, 13.0, 14.0); // 13.0/13.0 doesn't place towards the upper X axis when using rmPlaceObjectDefPerPlayer().
	rmAddObjectDefConstraint(stragglerTreeID, avoidAll);

	placeObjectAtPlayerLocs(stragglerTreeID, false, rmRandInt(2, 5));
}

void placeResources(float progressFrac = 0.0) {
	int progressSteps = 11;
	float progressPerStep = progressFrac / progressSteps;

	// Gold.
	int numMediumGold = 0;
	int numFarGold = 0;
	int numBonusGold = 0;

	if(cMapBonusAreaSize != cBonusAreaSizeNone) {
		if(cMapBonusAreaSize == cBonusAreaSizeSmall) {
			numBonusGold = rmRandInt(0, 1);
		} else if(cMapBonusAreaSize == cBonusAreaSizeMedium) {
			numBonusGold = rmRandInt(0, 2);
		} else if(cMapBonusAreaSize == cBonusAreaSizeLarge) {
			numBonusGold = rmRandInt(0, 3);
		}

		int maxSimLocGold = 3; // Maximum mines per sim loc.
		int maxPlayerGold = 5;
		int minGold = 3;
		int numPlayerGold = rmRandInt(max(1, minGold - numBonusGold), maxPlayerGold - numBonusGold);

		numMediumGold = rmRandInt(max(1, numPlayerGold - maxSimLocGold), min(maxSimLocGold, numPlayerGold));
		numFarGold = min(maxSimLocGold, numPlayerGold - numMediumGold);
	} else {
		numMediumGold = rmRandInt(1, 2);

		float goldFloat = rmRandFloat(0.0, 1.0);
		if(goldFloat < 0.3) {
			numFarGold = 3 - numMediumGold;
		} else if(goldFloat < 0.9) {
			numFarGold = 4 - numMediumGold;
		} else {
			numFarGold = 5 - numMediumGold;
		}
	}

	int numPlacedGold = 0;

	if(cMapHasSmallPlayerAreas) {
		numPlacedGold = numPlacedGold + placePlayerGold(rmRandInt(1, 2));

		// Add this because we're skipping one.
		addProgress(progressPerStep);

		// Override numBonusGold (at least 1 since we already have small player areas).
		numBonusGold = max(1, numBonusGold);
	} else {
		numPlacedGold = numPlacedGold + placeSimLocGold("medium gold", numMediumGold, 55.0, 70.0 + 10.0 * numMediumGold, cDebugMode == cDebugFull);

		addProgress(progressPerStep);

		numPlacedGold = numPlacedGold + placeSimLocGold("far gold", numFarGold, 90.0, 115.0 + 10.0 * numFarGold, cDebugMode == cDebugFull);
	}

	addProgress(progressPerStep);

	placeBonusGold(numBonusGold, 30.0, cDebugMode == cDebugFull);

	addProgress(progressPerStep);

	// Food.
	int maxSimLocFood = 3;
	int numPlayerFood = 0;
	int numMediumFood = 0;
	int numFarFood = 0;
	int numBonusFood = 0;

	if(cMapBonusAreaSize != cBonusAreaSizeNone) {
		if(cMapBonusAreaSize == cBonusAreaSizeSmall) {
			numBonusFood = rmRandInt(0, 2);
		} else if(cMapBonusAreaSize == cBonusAreaSizeMedium) {
			numBonusFood = rmRandInt(0, 3);
		} else if(cMapBonusAreaSize == cBonusAreaSizeLarge) {
			numBonusFood = rmRandInt(0, 4);
		}

		int maxPlayerFood = 4;
		numPlayerFood = rmRandInt(0, maxPlayerFood - min(2, numBonusFood));
	} else {
		numPlayerFood = rmRandInt(0, 6);
	}

	numMediumFood = rmRandInt(max(0, numPlayerFood - maxSimLocFood), min(maxSimLocFood, numPlayerFood));
	numFarFood = min(maxSimLocFood, numPlayerFood - numMediumFood);

	int numPlacedFood = 0;

	if(cMapHasSmallPlayerAreas) {
		numPlacedFood = numPlacedFood + placePlayerFood(rmRandInt(1, 2));

		// Add this because we're skipping one.
		addProgress(progressPerStep);

		// Override numBonusFood (at least 1 since we already have small player areas).
		numBonusFood = max(1, numBonusFood);
	} else {
		numPlacedFood = numPlacedFood + placeSimLocFood("medium food", numMediumFood, 55.0, 70.0 + 10.0 * numMediumFood, cDebugMode == cDebugFull);

		addProgress(progressPerStep);

		numPlacedFood = numPlacedFood + placeSimLocFood("far food", numFarFood, 90.0, 105.0 + 10.0 * numFarFood, cDebugMode == cDebugFull);
	}

	addProgress(progressPerStep);

	placeBonusFood(numBonusFood, 20.0, cDebugMode == cDebugFull);

	// Bonus berries.
	if(randChance() || numPlacedFood <= 1) {
		if(randChance(0.75)) {
			placeBonusBerries(1);
		} else {
			placeBonusBerries(2);
		}
	}

	// Starting resources.
	placeStartingResources();

	addProgress(progressPerStep);

	// Forests.
	placeForests();

	addProgress(progressPerStep);

	// Herdables.
	int maxSimLocHerdable = 3;
	int numPlayerHerdable = 0;
	int numBonusHerdable = 0;

	if(cMapBonusAreaSize != cBonusAreaSizeNone) {
		if(cMapBonusAreaSize == cBonusAreaSizeSmall) {
			numBonusHerdable = rmRandInt(0, 1);
		} else if(cMapBonusAreaSize == cBonusAreaSizeMedium) {
			numBonusHerdable = rmRandInt(0, 2);
		} else if(cMapBonusAreaSize == cBonusAreaSizeLarge) {
			numBonusHerdable = rmRandInt(0, 2);
		}

		numPlayerHerdable = rmRandInt(1, 4);
	} else {
		numPlayerHerdable = rmRandInt(1, 6);
	}

	int numMediumHerdable = rmRandInt(max(1, numPlayerHerdable - maxSimLocHerdable), min(maxSimLocHerdable, numPlayerHerdable));
	int numFarHerdable = min(maxSimLocHerdable, numPlayerHerdable - numMediumHerdable);

	int numPlacedHerdable = 0;

	if(cMapHasSmallPlayerAreas) {
		numPlacedHerdable = numPlacedHerdable + placePlayerHerdable(rmRandInt(1, 2));

		// Add this because we're skipping one.
		addProgress(progressPerStep);

		// Override numBonusHerdable (at least 1 since we already have small player areas).
		numBonusHerdable = max(1, numBonusHerdable);
	} else {
		numPlacedHerdable = numPlacedHerdable + placeSimLocHerdable("medium herdable", numMediumHerdable, 55.0, 100.0, cDebugMode == cDebugFull);

		addProgress(progressPerStep);

		// Verify if we didn't place any medium herdable.
		numPlacedHerdable = numPlacedHerdable + placeSimLocHerdable("far herdable", numFarHerdable, 90.0, 135.0, cDebugMode == cDebugFull);
	}

	addProgress(progressPerStep);

	placeBonusHerdable(numBonusHerdable, cDebugMode == cDebugFull);
	placeStartingHerdable();

	addProgress(progressPerStep);

	// Fish and other stuff.
	if(cMapHasFish) {
		placeFish();
	}
	placeMisc();
}

void placeEmbellishment() {
	// Embellishment.
	int embellishmentAvoidAll = createTypeDistConstraint("All", 5.0);
	int avoidImpassableLand = createTerrainDistConstraint("Land", false, 5.0);
	int avoidSettlement = createTypeDistConstraint("AbstractSettlement", 14.0);
	int avoidPlayer = createClassDistConstraint(classPlayerCore, 25.0);

	int embID = -1;
	string texture1 = cTextureNone;
	string texture2 = cTextureNone;
	string texture3 = cTextureNone;

	int numRandomTreeObjs = rmRandInt(1, 2);
	int numUncommonObjs = rmRandInt(0, 1);
	int numCommonObjs = rmRandInt(1, 2);
	int numSpriteObjs = 1;
	int numRockObjs = 1;
	int numEnvObjs = rmRandInt(0, 2);

	// Random trees and plants.
	for(i = 0; < numRandomTreeObjs) {
		texture1 = getRandomTreeByStyle();
		texture2 = getRandomNonBlockingCommonByStyle();

		if(randChance()) {
			texture3 = getRandomNonBlockingCommonByStyle();
		} else {
			texture3 = getRandomNonBlockingUncommonByStyle();
		}

		if(texture1 == cTextureNone) {
			break;
		}

		// Random chance for override in Erebus.
		if(cVariationStyle1 == cStyleErebus && randChance()) {
			texture1 = cDecoPineDeadBurning;
		}

		embID = createObjectDef();
		rmAddObjectDefItem(embID, texture1, 1, 0.0);
		if(randChance() && texture2 != cTextureNone) {
			rmAddObjectDefItem(embID, texture2, randSingleOrRange(1, 5), 4.0);
			if(randChance() && texture3 != cTextureNone && texture2 != texture3) {
				rmAddObjectDefItem(embID, texture3, randSingleOrRange(1, 3), 4.0);
			}
		}

		setObjectDefDistanceToMax(embID);
		rmAddObjectDefConstraint(embID, avoidAll);
		rmAddObjectDefConstraint(embID, avoidImpassableLand);
		rmAddObjectDefConstraint(embID, avoidSettlement);
		rmAddObjectDefConstraint(embID, avoidPlayer);
		rmPlaceObjectDefAtLoc(embID, 0, 0.5, 0.5, rmRandInt(3, 7) * cNonGaiaPlayers);
	}

	// Uncommon embellishment (flowers/rotting log/stalagmite).
	for(i = 0; < numUncommonObjs) {
		texture1 = getRandomNonBlockingUncommonByStyle();
		texture2 = getRandomNonBlockingCommonByStyle();

		if(texture1 == cTextureNone) {
			break;
		}

		embID = createObjectDef();
		rmAddObjectDefItem(embID, texture1, randSingleOrRange(1, 3), 5.0);
		if(randChance() && texture2 != cTextureNone) {
			rmAddObjectDefItem(embID, texture2, randSingleOrRange(1, 3), 5.0);
		}
		setObjectDefDistanceToMax(embID);
		rmAddObjectDefConstraint(embID, embellishmentAvoidAll);
		rmAddObjectDefConstraint(embID, avoidImpassableLand);
		rmPlaceObjectDefAtLoc(embID, 0, 0.5, 0.5, rmRandInt(3, 7) * cNonGaiaPlayers);
	}

	// Common embellishment (grass, rock sprites, rocks, ...).
	for(i = 0; < numCommonObjs) {
		texture1 = getRandomNonBlockingCommonByStyle();
		texture2 = getRandomNonBlockingCommonByStyle();
		texture3 = getRandomRockSpriteByStyle();

		if(texture1 == cTextureNone) {
			break;
		}

		embID = createObjectDef();
		rmAddObjectDefItem(embID, texture1, randSingleOrRange(1, 3), 5.0);
		if(randChance() && texture1 != texture2 && texture2 != cTextureNone) {
			rmAddObjectDefItem(embID, texture2, randSingleOrRange(1, 3), 5.0);
		}
		if(randChance() && texture3 != cTextureNone) {
			rmAddObjectDefItem(embID, texture3, randSingleOrRange(1, 3), 5.0);
		}
		setObjectDefDistanceToMax(embID);
		rmAddObjectDefConstraint(embID, embellishmentAvoidAll);
		rmAddObjectDefConstraint(embID, avoidImpassableLand);
		rmPlaceObjectDefAtLoc(embID, 0, 0.5, 0.5, 10 * rmRandInt(1, 5) * cNonGaiaPlayers);
	}

	for(i = 0; < numSpriteObjs) {
		texture1 = getRandomRockSpriteByStyle();

		if(texture1 == cTextureNone) {
			break;
		}

		embID = createObjectDef();
		rmAddObjectDefItem(embID, texture1, randSingleOrRange(1, 3), 4.0);
		setObjectDefDistanceToMax(embID);
		rmAddObjectDefConstraint(embID, embellishmentAvoidAll);
		rmAddObjectDefConstraint(embID, avoidImpassableLand);
		rmPlaceObjectDefAtLoc(embID, 0, 0.5, 0.5, 10 * rmRandInt(0, 5) * cNonGaiaPlayers);
	}

	for(i = 0; < numRockObjs) {
		texture1 = getRandomRockSmallByStyle();

		if(texture1 == cTextureNone) {
			break;
		}

		embID = createObjectDef();
		rmAddObjectDefItem(embID, texture1, randSingleOrRange(1, 3), 4.0);
		setObjectDefDistanceToMax(embID);
		rmAddObjectDefConstraint(embID, embellishmentAvoidAll);
		rmAddObjectDefConstraint(embID, avoidImpassableLand);
		rmPlaceObjectDefAtLoc(embID, 0, 0.5, 0.5, 5 * rmRandInt(0, 5) * cNonGaiaPlayers);
	}

	// Water decoration.
	if(cMapHasWater) {
		int forceNearShore = createTerrainMaxDistConstraint("Land", true, 10.0);
		int avoidShore = createTerrainDistConstraint("Land", true, 20.0);

		int numDecoWaterFlora = rmRandInt(2, 3);
		int numDecoWaterFauna = rmRandInt(1, 2);
		int numWaterBush = rmRandInt(1, 1); // Only use this for grass/sand/savannah.

		// Flora.
		for(i = 0; < numDecoWaterFlora) {
			texture1 = getRandomWaterFloraByStyle();

			if(texture1 == cTextureNone) {
				break;
			}

			embID = createObjectDef();
			setObjectDefDistanceToMax(embID);
			rmAddObjectDefConstraint(embID, embellishmentAvoidAll);

			if(texture1 == cDecoWaterDecoration) {
				rmAddObjectDefItem(embID, texture1, rmRandInt(1, 4), 6.0);
				rmAddObjectDefConstraint(embID, forceNearShore);
			} else {
				rmAddObjectDefItem(embID, texture1, rmRandInt(1, 4), 4.0);
				rmAddObjectDefConstraint(embID, forceNearShore);
			}

			// if(cMapHasLargeWaterBody) {
				// rmPlaceObjectDefAtLoc(embID, 0, 0.5, 0.5, randRanges(3, 7, 7, 13) * cNonGaiaPlayers);
			// } else {
				rmPlaceObjectDefAtLoc(embID, 0, 0.5, 0.5, rmRandInt(3, 7) * cNonGaiaPlayers);
			// }
		}

		// Bush/Grass near shore.
		if(randChance(0.25) && cVariationStyle1 == cStyleGrass || cVariationStyle1 == cStyleSand || cVariationStyle1 == cStyleSavannah) {
			for(i = 0; < numWaterBush) {
				if(texture1 == cTextureNone) {
					break;
				}

				texture1 = cDecoBush;
				texture2 = cDecoGrass;

				embID = createObjectDef();
				rmAddObjectDefItem(embID, texture1, rmRandInt(2, 4), 5.0);
				rmAddObjectDefItem(embID, texture2, rmRandInt(2, 4), 5.0);
				setObjectDefDistanceToMax(embID);
				rmAddObjectDefConstraint(embID, embellishmentAvoidAll);
				rmAddObjectDefConstraint(embID, createTerrainDistConstraint("Land", false, 1.0));
				rmAddObjectDefConstraint(embID, createTerrainMaxDistConstraint("Land", false, 5.0));
				// if(cMapHasLargeWaterBody) {
					// rmPlaceObjectDefAtLoc(embID, 0, 0.5, 0.5, 5 * randRanges(3, 7, 7, 13) * cNonGaiaPlayers);
				// } else {
					rmPlaceObjectDefAtLoc(embID, 0, 0.5, 0.5, 5 * rmRandInt(3, 7) * cNonGaiaPlayers);
				// }
			}
		}

		if(cMapHasLargeWaterBody) {
			// Fauna.
			for(i = 0; < numDecoWaterFauna) {
				texture1 = getRandomWaterFaunaByStyle();

				if(texture1 == cTextureNone) {
					break;
				}

				embID = createObjectDef();
				rmAddObjectDefItem(embID, texture1, 1, 0.0);
				setObjectDefDistanceToMax(embID);
				rmAddObjectDefConstraint(embID, avoidShore);
				rmAddObjectDefConstraint(embID, embellishmentAvoidAll);
				rmAddObjectDefConstraint(embID, avoidEdge);
				rmAddObjectDefConstraint(embID, createTypeDistConstraint(texture1, 20.0)); // Avoid self.

				rmPlaceObjectDefAtLoc(embID, 0, 0.5, 0.5, rmRandInt(1, 3) * cNonGaiaPlayers);
			}
		}
	}

	int classEnv = defineClass();
	int avoidEnv = createClassDistConstraint(classEnv, 25.0);

	for(i = 0; < numEnvObjs) {
		if(cVariationStyle1 != cStyleSand) {
			// Only place this for sand variations.
			break;
		}

		texture1 = getRandomEnvByStyle();

		if(texture1 == cTextureNone) {
			break;
		}

		embID = createObjectDef();
		rmAddObjectDefItem(embID, texture1, 1, 0.0);
		setObjectDefDistanceToMax(embID);
		rmAddObjectDefToClass(embID, classEnv);
		rmAddObjectDefConstraint(embID, embellishmentAvoidAll);
		rmAddObjectDefConstraint(embID, avoidImpassableLand);
		rmAddObjectDefConstraint(embID, avoidPlayer);
		rmAddObjectDefConstraint(embID, avoidEnv);
		rmPlaceObjectDefAtLoc(embID, 0, 0.5, 0.5, rmRandInt(2, 4) * cNonGaiaPlayers);
	}
}

void setupGlobals() {
	int classSplit = initializeSplit();
	int classTeamSplit = initializeTeamSplit();

	// Classes.
	classMirrorCenter = initializeCenter(22.5);
	classCornerBlock = initializeCorners(45.0);
	classFirstSettlementBlock = defineClass();
	classSecondSettlementBlock = defineClass();
	classMediumResourceBlock = defineClass();
	classBonusResourceBlock = defineClass();
	classForestResourceBlock = defineClass();
	classFishResourceBlock = defineClass();
	classMiscResourceBlock = defineClass();
	classUnbuildable = defineClass();
	classPlayerCore = defineClass();
	classSettleArea = defineClass();
	classTower = defineClass();
	classCliff = defineClass();
	classPond = defineClass();

	// Constraints.
	avoidAll = createTypeDistConstraint("All", 8.0);
	// Use tiles instead of meters here because we run this before map initialization.
	avoidEdge = createSymmetricBoxConstraint(rmXTilesToFraction(4), rmZTilesToFraction(4)); // 8 meters.
	avoidTowerLOS = createClassDistConstraint(classTower, 35.0);
}

void setGaia() {
	rmSetGaiaCiv(getRandomCivByStyle());
}

void setMapType() {
	float mapFloat = rmRandFloat(0.0, 1.0);
	float totalChance = 13.0;

	if(mapFloat < 2.0 / totalChance) {
		cMapType = cMapTypePlain;
	} else if(mapFloat < 3.0 / totalChance) {
		cMapType = cMapTypePlateau;
	} else if(mapFloat < 4.0 / totalChance) {
		cMapType = cMapTypeOases;
	} else if(mapFloat < 5.0 / totalChance) {
		cMapType = cMapTypePlayerIslands;
	} else if(mapFloat < 6.0 / totalChance) {
		cMapType = cMapTypeCenterIslands;
	} else if(mapFloat < 7.0 / totalChance) {
		cMapType = cMapTypeSmallCenterIsland;
	} else if(mapFloat < 9.0 / totalChance) {
		cMapType = cMapTypeContinent;
	} else if(mapFloat < 11.0 / totalChance) {
		cMapType = cMapTypeLake;
	} else if(mapFloat < 12.0 / totalChance) {
		if(gameHasTwoEqualTeams()) {
			cMapType = cMapTypeRivers;
		} else {
			// Recursively set this until we have something other than the river variation.
			setMapType();
		}
	} else {
		cMapType = cMapTypeSeparator;
	}

	// Use this override for testing.
	// cMapType = cMapTypePlain;
}

void main() {
	progress(0.0);

	// Initial map setup.
	rmxInit("Competitive Mega Random (Alpha)");

	// Set texture set.
	randomizeTextureSet();

	// Randomize map type.
	setMapType();

	// Set gaia.
	setGaia();

	// Initialize map and place players.
	initMap();

	// Generic setup for global classes, constraints, etc.
	setupGlobals();

	// Create player cores.
	createPlayerCores();

	progress(0.1);

	// Generate rough layout (this also has to initialize the map and place players).
	generateMapLayout();

	progress(0.2);

	// Create tower locations.
	createTowerLocations();

	// Create fair settlement locations.
	createSettlementLocations();

	progress(0.3);

	// Generate additional stuff (cliffs, ponds, ...).
	generateTerrainFeatures();

	// Beautify terrain.
	beautifyTerrain();

	progress(0.4);

	// Actually place the settlements and towers (prevents them from being deleted by the buggy water generation).
	placeSettlements();

	// Place resources.
	placeResources(0.5);

	progress(0.9);

	// Decorative stuff.
	placeEmbellishment();

	// Placement checks.
	for(i = 1; < cPlayers) {
		addProtoPlacementCheck("Settlement Level 1", 1, i);
		addProtoPlacementCheck("Tower", 4, i);
	}
	addProtoPlacementCheck("Settlement", 2 * cNonGaiaPlayers, 0);
	// No additional checks should be required, otherwise add them here.

	// Finalize RM X.
	rmxFinalize();

	progress(1.0);
}
