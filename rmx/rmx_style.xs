/*
** RM X Style Generation.
** If you don't need this, just include rmx.xs directly instead.
** RebelsRising
** Last edit: 13/05/2022
*/

include "rmx.xs";

// Empty type.
extern const string cTextureNone = "";

// Terrain types.
extern const string cBlack = "Black";
extern const string cBlackRock = "BlackRock";
extern const string cCityTileA = "CityTileA";
extern const string cCityTileAtlantis = "CityTileAtlantis";
extern const string cCityTileAtlantisCoral = "CityTileAtlantisCoral";  // AoT.
extern const string cCityTileWaterCornerA = "CityTileWaterCornerA";
extern const string cCityTileWaterCornerB = "CityTileWaterCornerB";
extern const string cCityTileWaterCornerC = "CityTileWaterCornerC";
extern const string cCityTileWaterCornerD = "CityTileWaterCornerD";
extern const string cCityTileWaterEdgeA = "CityTileWaterEdgeA";
extern const string cCityTileWaterEdgeB = "CityTileWaterEdgeB";
extern const string cCityTileWaterEdgeEndA = "CityTileWaterEdgeEndA";
extern const string cCityTileWaterEdgeEndB = "CityTileWaterEdgeEndB";
extern const string cCityTileWaterEdgeEndC = "CityTileWaterEdgeEndC";
extern const string cCityTileWaterEdgeEndD = "CityTileWaterEdgeEndD";
extern const string cCityTileWaterPool = "CityTileWaterPool";
extern const string cCliffA = "CliffA";
extern const string cCliffEgyptianA = "CliffEgyptianA";
extern const string cCliffEgyptianB = "CliffEgyptianB";
extern const string cCliffGreekA = "CliffGreekA";
extern const string cCliffGreekB = "CliffGreekB";
extern const string cCliffNorseA = "CliffNorseA";
extern const string cCliffNorseB = "CliffNorseB";
extern const string cCoralA = "CoralA";
extern const string cCoralB = "CoralB";
extern const string cCoralC = "CoralC";
extern const string cCoralD = "CoralD";
extern const string cCoralE = "CoralE";
extern const string cCoralF = "CoralF";
// extern const string cDirtA = "DirtA"; // Same as SandA.
extern const string cEgyptianRoadA = "EgyptianRoadA";
extern const string cForestFloorDeadPine = "ForestFloorDeadPine";
extern const string cForestFloorGaia = "ForestFloorGaia"; // AoT.
extern const string cForestFloorMarsh = "ForestFloorMarsh"; // AoT.
extern const string cForestFloorOak = "ForestFloorOak";
extern const string cForestFloorPalm = "ForestFloorPalm";
extern const string cForestFloorPine = "ForestFloorPine";
extern const string cForestFloorPineSnow = "ForestFloorPineSnow";
extern const string cForestFloorSavannah = "ForestFloorSavannah";
extern const string cForestFloorTundra = "ForestFloorTundra"; // AoT.
extern const string cGaiaCreepA = "GaiaCreepA"; // AoT.
extern const string cGaiaCreepASand = "GaiaCreepASand"; // AoT.
extern const string cGaiaCreepASnow = "GaiaCreepASnow"; // AoT.
extern const string cGaiaCreepB = "GaiaCreepB"; // AoT.
extern const string cGaiaCreepBorder = "GaiaCreepBorder"; // AoT.
extern const string cGaiaCreepBorderSand = "GaiaCreepBorderSand"; // AoT.
extern const string cGaiaCreepBorderSnow = "GaiaCreepBorderSnow"; // AoT.
extern const string cGrassA = "GrassA";
extern const string cGrassB = "GrassB";
extern const string cGrassDirt25 = "GrassDirt25";
extern const string cGrassDirt50 = "GrassDirt50";
extern const string cGrassDirt75 = "GrassDirt75";
extern const string cGreekRoadBurnt = "GreekRoadBurnt"; // AoT.
extern const string cGreekRoadBurntB = "GreekRoadBurntB"; // AoT.
extern const string cGreekRoadA = "GreekRoadA";
extern const string cHades1 = "Hades1";
extern const string cHades2 = "Hades3";
extern const string cHades3 = "Hades2";
extern const string cHades4 = "Hades4";
extern const string cHades5 = "Hades5";
extern const string cHades6 = "Hades6";
extern const string cHades7 = "Hades7";
extern const string cHades8 = "Hades8";
extern const string cHades9 = "Hades9";
extern const string cHadesBuildable1 = "HadesBuildable1";
extern const string cHadesBuildable2 = "HadesBuildable2";
extern const string cHadesCliff = "HadesCliff";
extern const string cIceA = "IceA";
extern const string cIceB = "IceB";
extern const string cIceC = "IceC";
extern const string cMarshA = "MarshA"; // AoT.
extern const string cMarshB = "MarshB"; // AoT.
extern const string cMarshC = "MarshC"; // AoT.
extern const string cMarshD = "MarshD"; // AoT.
extern const string cMarshE = "MarshE"; // AoT.
extern const string cMarshF = "MarshF"; // AoT.
extern const string cMiningGround = "MiningGround";
extern const string cNorseRoadA = "NorseRoadA";
extern const string cOlympusA = "OlympusA"; // AoT.
extern const string cOlympusB = "OlympusB"; // AoT.
extern const string cOlympusC = "OlympusC"; // AoT.
extern const string cOlympusTile = "OlympusTile"; // AoT.
extern const string cRiverGrassyA = "RiverGrassyA";
extern const string cRiverGrassyB = "RiverGrassyB";
extern const string cRiverGrassyC = "RiverGrassyC";
extern const string cRiverIcyA = "RiverIcyA";
extern const string cRiverIcyB = "RiverIcyB";
extern const string cRiverIcyC = "RiverIcyC";
extern const string cRiverMarshA = "RiverMarshA"; // AoT.
extern const string cRiverMarshB = "RiverMarshB"; // AoT.
extern const string cRiverMarshC = "RiverMarshC"; // AoT.
extern const string cRiverSandyA = "RiverSandyA";
extern const string cRiverSandyB = "RiverSandyB";
extern const string cRiverSandyC = "RiverSandyC";
extern const string cRiverSandyShallowA = "RiverSandyShallowA";
extern const string cSandA = "SandA";
extern const string cSandB = "SandB";
extern const string cSandC = "SandC";
extern const string cSandD = "SandD";
extern const string cSandDirt50 = "SandDirt50";
extern const string cSandDirt50b = "SandDirt50b";
extern const string cSavannahA = "SavannahA";
extern const string cSavannahB = "SavannahB";
extern const string cSavannahC = "SavannahC";
extern const string cSavannahD = "SavannahD";
extern const string cShorelineAegeanA = "ShorelineAegeanA";
extern const string cShorelineAegeanB = "ShorelineAegeanB";
extern const string cShorelineAegeanC = "ShorelineAegeanC";
extern const string cShorelineAtlanticA = "ShorelineAtlanticA";
extern const string cShorelineAtlanticB = "ShorelineAtlanticB";
extern const string cShorelineAtlanticC = "ShorelineAtlanticC";
extern const string cShorelineMediterraneanA = "ShorelineMediterraneanA";
extern const string cShorelineMediterraneanB = "ShorelineMediterraneanB";
extern const string cShorelineMediterraneanC = "ShorelineMediterraneanC";
extern const string cShorelineMediterraneanD = "ShorelineMediterraneanD";
extern const string cShorelineNorwegianA = "ShorelineNorwegianA";
extern const string cShorelineNorwegianB = "ShorelineNorwegianB";
extern const string cShorelineNorwegianC = "ShorelineNorwegianC";
extern const string cShorelineRedSeaA = "ShorelineRedSeaA";
extern const string cShorelineRedSeaB = "ShorelineRedSeaB";
extern const string cShorelineRedSeaC = "ShorelineRedSeaC";
extern const string cShorelineSandA = "ShorelineSandA";
extern const string cShorelineTundraA = "ShorelineTundraA"; // AoT.
extern const string cShorelineTundraB = "ShorelineTundraB"; // AoT.
extern const string cShorelineTundraC = "ShorelineTundraC"; // AoT.
extern const string cShorelineTundraD = "ShorelineTundraD"; // AoT.
extern const string cSnowA = "SnowA";
extern const string cSnowB = "SnowB";
extern const string cSnowGrass25 = "SnowGrass25";
extern const string cSnowGrass50 = "SnowGrass50";
extern const string cSnowGrass75 = "SnowGrass75";
extern const string cSnowSand25 = "SnowSand25";
extern const string cSnowSand50 = "SnowSand50";
extern const string cSnowSand75 = "SnowSand75";
extern const string cTundraGrassA = "TundraGrassA"; // AoT.
extern const string cTundraGrassB = "TundraGrassB"; // AoT.
extern const string cTundraRockA = "TundraRockA"; // AoT.
extern const string cTundraRockB = "TundraRockB"; // AoT.
extern const string cUnderwaterIceA = "UnderwaterIceA";
extern const string cUnderwaterIceB = "UnderwaterIceB";
extern const string cUnderwaterIceC = "UnderwaterIceC";
extern const string cUnderwaterRockA = "UnderwaterRockA";
extern const string cUnderwaterRockB = "UnderwaterRockB";
extern const string cUnderwaterRockC = "UnderwaterRockC";
extern const string cUnderwaterRockD = "UnderwaterRockD";
extern const string cUnderwaterRockE = "UnderwaterRockE";
extern const string cUnderwaterRockF = "UnderwaterRockF";

// Styles.
extern const int cStyleNone = -1;
extern const int cStyleGrass = 0;
extern const int cStyleSand = 1;
extern const int cStyleSnow = 2;
extern const int cStyleSavannah = 3;
extern const int cStyleMarsh = 4;
extern const int cStyleTundra = 5;
extern const int cStyleErebus = 6;
extern const int cStyleOlympus = 7;

// Variations.
extern const int cNumVariations = 16;

// None (undefined).
extern const int cVariationNone = -1;

// 0. Grass.
extern const int cVariationGrass = 0;
extern const int cVariationGrassMarsh = 1;

// 1. Sand.
extern const int cVariationSand = 2;
extern const int cVariationSandGrass = 3;
extern const int cVariationSandSavannah = 4;
extern const int cVariationSandSavannahGrass = 5;

// 2. Snow.
extern const int cVariationSnow = 6;
extern const int cVariationSnowSand = 7;
extern const int cVariationSnowGrass = 8;
extern const int cVariationSnowSandGrass = 9;
extern const int cVariationSnowTundra = 10;

// 3. Savannah.
extern const int cVariationSavannah = 11;

// 4. Marsh.
extern const int cVariationMarsh = 12;

// 5. Tundra.
extern const int cVariationTundra = 13;

// 6. Divine.
extern const int cVariationErebus = 14;
extern const int cVariationOlympus = 15;

// Actual variation used.
extern int cVariation = cVariationNone;

// All of the default texture sets defined here can have two styles that can be used to determine cliff/decoration/forest/... textures.
extern int cVariationStyle1 = cStyleNone;
extern int cVariationStyle2 = cStyleNone;

// Texture sets.
const int cMaxTextures = 12;

int textureCount = 0;

// For some reason constants cannot be used for global initialization for strings (but for all other types).
string texture0 = ""; string texture1 = ""; string texture2  = ""; string texture3  = "";
string texture4 = ""; string texture5 = ""; string texture6  = ""; string texture7  = "";
string texture8 = ""; string texture9 = ""; string texture10 = ""; string texture11 = "";

string getTexture(int i = -1) {
	if(i == 0) return(texture0); if(i == 1) return(texture1); if(i == 2)  return(texture2);  if(i == 3)  return(texture3);
	if(i == 4) return(texture4); if(i == 5) return(texture5); if(i == 6)  return(texture6);  if(i == 7)  return(texture7);
	if(i == 8) return(texture8); if(i == 9) return(texture9); if(i == 10) return(texture10); if(i == 11) return(texture11);
	return(cTextureNone);
}

void setTexture(int i = -1, string s = "") {
	if(i == 0) texture0 = s; if(i == 1) texture1 = s; if(i == 2)  texture2  = s; if(i == 3)  texture3  = s;
	if(i == 4) texture4 = s; if(i == 5) texture5 = s; if(i == 6)  texture6  = s; if(i == 7)  texture7  = s;
	if(i == 8) texture8 = s; if(i == 9) texture9 = s; if(i == 10) texture10 = s; if(i == 11) texture11 = s;
}

int getTextureCount() {
	return(textureCount);
}

void resetTextures() {
	for(i = 0; < cMaxTextures) {
		setTexture(i, "");
	}

	textureCount = 0;
}

void addTexture(string texture = "") {
	setTexture(textureCount, texture);
	textureCount++;
}

int findTexture(string texture = "") {
	for(i = 0; < textureCount) {
		if(getTexture(i) == texture) {
			return(i);
		}
	}

	return(-1);
}

bool deleteTextureById(int id = -1) {
	if(id == -1) {
		return(false);
	}

	// Reduce array size.
	textureCount--;

	for(i = id; < textureCount) {
		setTexture(i, getTexture(i + 1));
	}

	// Reset last slot.
	setTexture(textureCount);

	return(true);
}

bool deleteTexture(string texture = "") {
	int id = findTexture(texture);
	return(deleteTextureById(id));
}

void shuffleTextures(int start = 0, int end = -1) {
	if(end < 0) {
		end = textureCount - 1;
	}

	for(p = start; <= end) {
		// Swap each slot at least once.
		int r = rmRandInt(p, end);
		string s = getTexture(p);

		// Do swap.
		setTexture(p, getTexture(r));
		setTexture(r, s);
	}
}

string getRandomTerrain(string referenceTexture = "") {
	if(referenceTexture == cTextureNone || textureCount <= 1) {
		return(getTexture(rmRandInt(0, textureCount - 1)));
	}

	string texture = getTexture(rmRandInt(0, textureCount - 1));

	// This will terminate because we have 1 constraint and at least 2 textures in the array.
	while(texture == referenceTexture) {
		texture = getTexture(rmRandInt(0, textureCount - 1));
	}

	return(texture);
}

string getRandomTerrainFromLeftSplit(int end = 0, int minDistance = 0, int maxDistance = -1) {
	if(maxDistance < 0) {
		maxDistance = end;
	}

	int randInt = rmRandInt(max(0, end - maxDistance), max(0, end - minDistance));
	return(getTexture(randInt));
}

string getRandomTerrainFromRightSplit(int start = 0, int minDistance = 0, int maxDistance = -1) {
	if(maxDistance < 0) {
		maxDistance = textureCount;
	}

	int randInt = rmRandInt(min(textureCount - 1, start + minDistance), min(textureCount - 1, start + maxDistance));
	return(getTexture(randInt));
}

extern const int cForceSplitSmaller = -1;
extern const int cForceSplitEither = 0;
extern const int cForceSplitGreater = 1;

string getRandomTerrainWithDistanceForceSplit(string referenceTexture = "", int forceSplitInt = cForceSplitEither, int minDistance = 1, int maxDistance = -1) {
	int idx = findTexture(referenceTexture);

	if(idx == -1 || textureCount == 0) {
		return(cTextureNone);
	}

	if(textureCount == 1) {
		return(getTexture(0));
	}

	if(maxDistance <= 0) {
		maxDistance = textureCount;
	}

	// At least 2 textures (-> one of the following counts must be at least 1).
	int leftCount = idx; // Redundant, but way easier to understand.
	int rightCount = textureCount - idx - 1;

	if(rightCount == 0 || (forceSplitInt == cForceSplitSmaller && leftCount < rightCount) || (forceSplitInt == cForceSplitGreater && leftCount > rightCount)) {
		return(getRandomTerrainFromLeftSplit(idx - 1, minDistance - 1, maxDistance - 1));
	} else if(leftCount == 0 || (forceSplitInt == cForceSplitSmaller && leftCount > rightCount) || (forceSplitInt == cForceSplitGreater && leftCount < rightCount)) {
		return(getRandomTerrainFromRightSplit(idx + 1, minDistance - 1, maxDistance - 1));
	}

	// We get here if neither of them is 0 and there is no force split (or they're equal, i.e., forcing doesn't matter).
	// Apply minDistance constraint, taking the larger if either of them is smaller than the constraint.
	if(minDistance > leftCount || minDistance > rightCount) {
		if(leftCount > rightCount || (leftCount == rightCount && randChance())) {
			return(getRandomTerrainFromLeftSplit(idx - 1, minDistance - 1, maxDistance - 1));
		} else {
			return(getRandomTerrainFromRightSplit(idx + 1, minDistance - 1, maxDistance - 1));
		}
	}

	// Randomize either side as it doesn't matter at this point.
	if(randChance()) {
		return(getRandomTerrainFromLeftSplit(idx - 1, minDistance - 1, maxDistance - 1));
	} else {
		return(getRandomTerrainFromRightSplit(idx + 1, minDistance - 1, maxDistance - 1));
	}
}

string getRandomTerrainWithDistance(string referenceTexture = "", int minDistance = 1, int maxDistance = -1) {
	return(getRandomTerrainWithDistanceForceSplit(referenceTexture, cForceSplitEither, minDistance, maxDistance));
}

// Layering.
const int cMaxLayers = 12;

int layerCount = 0;

string layer0 = ""; string layer1 = ""; string layer2  = ""; string layer3  = "";
string layer4 = ""; string layer5 = ""; string layer6  = ""; string layer7  = "";
string layer8 = ""; string layer9 = ""; string layer10 = ""; string layer11 = "";

string getLayer(int i = -1) {
	if(i == 0) return(layer0); if(i == 1) return(layer1); if(i == 2)  return(layer2);  if(i == 3)  return(layer3);
	if(i == 4) return(layer4); if(i == 5) return(layer5); if(i == 6)  return(layer6);  if(i == 7)  return(layer7);
	if(i == 8) return(layer8); if(i == 9) return(layer9); if(i == 10) return(layer10); if(i == 11) return(layer11);
	return(cTextureNone);
}

void setLayer(int i = -1, string s = "") {
	if(i == 0) layer0 = s; if(i == 1) layer1 = s; if(i == 2)  layer2  = s; if(i == 3)  layer3  = s;
	if(i == 4) layer4 = s; if(i == 5) layer5 = s; if(i == 6)  layer6  = s; if(i == 7)  layer7  = s;
	if(i == 8) layer8 = s; if(i == 9) layer9 = s; if(i == 10) layer10 = s; if(i == 11) layer11 = s;
}

int getLayerCount() {
	return(layerCount);
}

void resetLayers() {
	for(i = 0; < cMaxLayers) {
		setLayer(i, cTextureNone);
	}

	layerCount = 0;
}

void addLayer(string layer = "") {
	setLayer(layerCount, layer);
	layerCount++;
}

void invertLayerArray() {
	for(i = 0; < layerCount / 2) {
		string tempLayer = getLayer(i);

		setLayer(i, getLayer(layerCount - i - 1));
		setLayer(layerCount - i - 1, tempLayer);
	}
}

void setLayerFromTextureSet(string inner = "", string outer = "") {
	resetLayers();

	int innerIdx = findTexture(inner);
	int outerIdx = findTexture(outer);

	printDebug("inner: " + inner + " outer: " + outer);

	if(innerIdx == -1 || outerIdx == -1) {
		return;
	}

	if(innerIdx < outerIdx) {
		for(i = outerIdx - 1; > innerIdx) {
			addLayer(getTexture(i));
		}
	} else {
		for(i = outerIdx + 1; < innerIdx) {
			addLayer(getTexture(i));
		}
	}

	for(i = 0; < layerCount) {
		printDebug("layer " + i + ": " + getLayer(i));
	}
}

// Texture sets.
void addRandomSandTexture() {
	int sandInt = rmRandInt(0, 3);

	if(sandInt == 0) 	  addTexture(cSandA);
	else if(sandInt == 1) addTexture(cSandB);
	else if(sandInt == 2) addTexture(cSandC);
	else if(sandInt == 3) addTexture(cSandD);
}

void addTundraRocks() {
	if(randChance()) {
		addTexture(cTundraRockA);
		addTexture(cTundraRockB);
	} else {
		addTexture(cTundraRockB);
		addTexture(cTundraRockA);
	}
}

void useTexturesGrass() {
	cVariationStyle1 = cStyleGrass;

	addTexture(cGrassB);
	addTexture(cGrassA);
	addTexture(cGrassDirt25);
	addTexture(cGrassDirt50);
	// addTexture(cGrassDirt75); // Too sandy, don't use here.

	// Chance to randomly delete one of the 4 textures.
	if(randChance()) {
		deleteTextureById(rmRandInt(0, textureCount - 1));
	}
}

void useTexturesGrassMarsh() {
	cVariationStyle1 = cStyleMarsh;
	// cVariationStyle2 = cStyleGrass;

	// Uses non-vanilla textures.
	// Grass order probably can be shuffled.
	addTexture(cGrassDirt25);
	addTexture(cGrassB);
	addTexture(cGrassA);

	// Chance to randomly remove one of the above.
	if(randChance()) {
		deleteTextureById(rmRandInt(0, textureCount - 1));
	}

	// Shuffle them for variation.
	shuffleTextures();

	addTexture(cMarshD);
	addTexture(cMarshE);
	addTexture(cMarshA);
	if(randChance()) {
		addTexture(cMarshB);
	}
	addTexture(cMarshC);
}

void useTexturesSand() {
	cVariationStyle1 = cStyleSand;

	addTexture(cSandA);
	addTexture(cSandB);
	addTexture(cSandC);
	addTexture(cSandD);
	addTexture(cSandDirt50);

	// Shuffle sands for variation.
	shuffleTextures();
}

void useTexturesSandGrass() {
	cVariationStyle1 = cStyleSand;
	// cVariationStyle2 = cStyleGrass;

	// At least one of those.
	addTexture(cGrassB);
	addTexture(cGrassA);

	if(randChance(0.75)) {
		deleteTextureById(rmRandInt(0, textureCount - 1));
	}

	// Always have these.
	addTexture(cGrassDirt25);
	addTexture(cGrassDirt50);
	addTexture(cGrassDirt75);

	addRandomSandTexture();

	if(randChance(0.25)) {
		// Random chance to add another sandy one.
		if(randChance(0.75)) {
			addTexture(cSandDirt50);
		} else {
			addRandomSandTexture();
		}
	}
}

void useTexturesSandSavannah() {
	cVariationStyle1 = cStyleSand;
	cVariationStyle2 = cStyleSavannah;

	// Add 1-2 random sands for texture balance.
	addRandomSandTexture();

	if(randChance()) {
		addRandomSandTexture();
	}

	addTexture(cSandDirt50);
	if(randChance()) {
		addTexture(cSavannahB);
		addTexture(cSavannahA);
	} else {
		addTexture(cSavannahC);
		addTexture(cSavannahD);
	}
}

void useTexturesSandSavannahGrass() {
	cVariationStyle1 = cStyleSand;
	cVariationStyle2 = cStyleSavannah;
	// Consider adding a 3rd style here (Grass) if we end up adding the grass textures.

	// At least one of those.
	// addTexture(cGrassB);
	// addTexture(cGrassA);

	// if(randChance(0.75)) {
		// deleteTextureById(rmRandInt(0, textureCount - 1));
	// }

	// Always have these.
	addTexture(cGrassDirt25);
	addTexture(cGrassDirt50);
	addTexture(cGrassDirt75);

	addRandomSandTexture();

	addTexture(cSandDirt50);

	// Either of the Savannah textures.
	if(randChance()) {
		addTexture(cSavannahB);
		addTexture(cSavannahA);
	} else {
		addTexture(cSavannahC);
		addTexture(cSavannahD);
	}
}

void useTexturesSnow() {
	cVariationStyle1 = cStyleSnow;

	addTexture(cSnowA);
	addTexture(cSnowB);
}

void useTexturesSnowGrass() {
	cVariationStyle1 = cStyleSnow;

	if(randChance()) {
		addTexture(cGrassB); // 50% chance for this to be around.
	}
	addTexture(cGrassA);
	addTexture(cSnowGrass75);
	addTexture(cSnowGrass50);
	addTexture(cSnowGrass25);
	addTexture(cSnowA);
	addTexture(cSnowB);

	// 50% chance to remove either of the snow ones.
	if(randChance()) {
		// Refer by offset from array end since we don't know if GrassB has been added or not.
		deleteTextureById(rmRandInt(textureCount - 2, textureCount - 1));
	}
}

void useTexturesSnowSand() {
	cVariationStyle1 = cStyleSnow;
	// cVariationStyle2 = cStyleSand;

	addRandomSandTexture();
	addTexture(cSandDirt50);
	addTexture(cSnowSand75);
	addTexture(cSnowSand50);
	addTexture(cSnowSand25);
	addTexture(cSnowA);
	addTexture(cSnowB);
}

void useTexturesSnowSandGrass() {
	cVariationStyle1 = cStyleSnow;

	// addTexture(cSandDirt50);
	addTexture(cSnowSand75);
	addTexture(cSnowSand50);
	addTexture(cSnowSand25);

	addTexture(cSnowA);
	addTexture(cSnowB);
	shuffleTextures(textureCount - 2, textureCount - 1);

	addTexture(cSnowGrass25);
	addTexture(cSnowGrass50);
	addTexture(cSnowGrass75);
	// addTexture(cGrassA);
}

void useTexturesSnowTundra() {
	cVariationStyle1 = cStyleSnow;
	cVariationStyle2 = cStyleTundra;

	// Uses non-vanilla textures.
	// Order doesn't matter too much, but TundraRockA/B have to be next to each other.
	if(randChance()) {
		// This one is probably better, but both work.
		addTexture(cTundraGrassB);
		addTundraRocks();
	} else {
		addTundraRocks();
		addTexture(cTundraGrassB);
	}
	addTexture(cTundraGrassA);

	addTexture(cSnowB);
	addTexture(cSnowA);
}

void useTexturesSavannah() {
	cVariationStyle1 = cStyleSavannah;

	addTexture(cSandDirt50);

	if(randChance()) {
		addTexture(cSavannahB);
		addTexture(cSavannahA);
	} else {
		addTexture(cSavannahC);
		addTexture(cSavannahD);
	}
}

void useTexturesMarsh() {
	cVariationStyle1 = cStyleMarsh;

	// Uses non-vanilla textures.
	addTexture(cMarshD);
	addTexture(cMarshE);
	addTexture(cMarshA);
	if(randChance()) {
		addTexture(cMarshB);
	}
	addTexture(cMarshC);
}

void useTexturesTundra() {
	cVariationStyle1 = cStyleTundra;

	// Uses non-vanilla textures.
	// Order doesn't matter too much, but TundraRockA/B have to be next to each other.
	if(randChance()) {
		// This one is probably better, but both work.
		addTexture(cTundraGrassB);
		addTundraRocks();
	} else {
		addTundraRocks();
		addTexture(cTundraGrassB);
	}
	addTexture(cTundraGrassA);
}

void useTexturesErebus() {
	cVariationStyle1 = cStyleErebus;

	addTexture(cHadesBuildable1);
	addTexture(cHadesBuildable2);
}

void useTexturesOlympus() {
	cVariationStyle1 = cStyleOlympus;

	// Uses non-vanilla textures.
	addTexture(cOlympusTile);
	addTexture(cOlympusA);
	addTexture(cOlympusC);
	// addTexture(cOlympusB);
}

void createTextureSet(int variation = cVariationNone) {
	if(variation == cVariationGrass) 			 useTexturesGrass();
	if(variation == cVariationGrassMarsh) 		 useTexturesGrassMarsh();
	if(variation == cVariationSand) 			 useTexturesSand();
	if(variation == cVariationSandGrass) 		 useTexturesSandGrass();
	if(variation == cVariationSandSavannah) 	 useTexturesSandSavannah();
	if(variation == cVariationSandSavannahGrass) useTexturesSandSavannahGrass();
	if(variation == cVariationSnow) 			 useTexturesSnow();
	if(variation == cVariationSnowSand) 		 useTexturesSnowSand();
	if(variation == cVariationSnowGrass)		 useTexturesSnowGrass();
	if(variation == cVariationSnowSandGrass) 	 useTexturesSnowSandGrass();
	if(variation == cVariationSnowTundra) 		 useTexturesSnowTundra();
	if(variation == cVariationSavannah) 		 useTexturesSavannah();
	if(variation == cVariationMarsh) 			 useTexturesMarsh();
	if(variation == cVariationTundra) 			 useTexturesTundra();
	if(variation == cVariationErebus)	 		 useTexturesErebus();
	if(variation == cVariationOlympus) 			 useTexturesOlympus();
}

int getRandomGrassTextureSet() {
	int randInt = rmRandInt(0, 1);

	if(cVersion == cVersionVanilla) {
		randInt = 0;
	}

	if(randInt == 0) return(cVariationGrass);
	if(randInt == 1) return(cVariationGrassMarsh);
}

int getRandomSandTextureSet() {
	int randInt = rmRandInt(0, 3);

	if(randInt == 0) return(cVariationSand);
	if(randInt == 1) return(cVariationSandSavannah);
	if(randInt == 2) return(cVariationSandGrass);
	if(randInt == 3) return(cVariationSandSavannahGrass);
}

int getRandomSnowTextureSet() {
	int randInt = rmRandInt(0, 4);

	if(cVersion == cVersionVanilla) {
		randInt = rmRandInt(0, 3);
	}

	if(randInt == 0) return(cVariationSnow);
	if(randInt == 1) return(cVariationSnowGrass);
	if(randInt == 2) return(cVariationSnowSand);
	if(randInt == 3) return(cVariationSnowSandGrass);
	if(randInt == 4) return(cVariationSnowTundra);
}

int getRandomSavannahTextureSet() {
	int randInt = rmRandInt(0, 2);
	if(randInt == 0) return(cVariationSavannah);
	if(randInt == 1) return(cVariationSandSavannahGrass);
	if(randInt == 2) return(cVariationSandSavannah);
}

int getRandomMarshTextureSet() {
	if(cVersion == cVersionVanilla) {
		return(getRandomGrassTextureSet());
	}

	int randInt = rmRandInt(0, 1);
	if(randInt == 0) return(cVariationMarsh);
	if(randInt == 1) return(cVariationGrassMarsh);
}

int getRandomTundraTextureSet() {
	if(cVersion == cVersionVanilla) {
		return(getRandomSnowTextureSet());
	}

	int randInt = rmRandInt(0, 1);
	if(randInt == 0) return(cVariationTundra);
	if(randInt == 1) return(cVariationSnowTundra);
}

int getRandomDivineTextureSet() {
	if(cVersion == cVersionVanilla) {
		return(cVariationErebus);
	}

	int randInt = rmRandInt(0, 1);
	if(randInt == 0) return(cVariationErebus);
	if(randInt == 1) return(cVariationOlympus);
}

int getRandomTextureSet() {
	float textureFloat = rmRandFloat(0.0, 1.0);

	if(textureFloat < 0.2) {
		return(getRandomGrassTextureSet());
	} else if(textureFloat < 0.5) {
		// Slight bias towards sand over grass/snow.
		return(getRandomSandTextureSet());
	} else if(textureFloat < 0.7) {
		return(getRandomSnowTextureSet());
	} else if(textureFloat < 0.775) {
		return(getRandomSavannahTextureSet());
	} else if(textureFloat < 0.85) {
		return(getRandomMarshTextureSet());
	} else if(textureFloat < 0.925) {
		return(getRandomTundraTextureSet());
	} else {
		return(getRandomDivineTextureSet());
	}
}

int randomizeTextureSet() {
	int textureSet = getRandomTextureSet();

	createTextureSet(textureSet);

	return(textureSet);
}

// Unbuildable texture types.
string getRandomGrassUnbuildableTexture() {
	return(cTextureNone);
}

string getRandomSandUnbuildableTexture() {
	return(cMiningGround);
}

string getRandomSnowUnbuildableTexture() {
	int randInt = rmRandInt(0, 2);
	if(randInt == 0) return(cIceA);
	if(randInt == 1) return(cIceB);
	if(randInt == 2) return(cIceC);
}

string getRandomSavannahUnbuildableTexture() {
	return(cMiningGround);
}

string getRandomMarshUnbuildableTexture() {
	return(cTextureNone);
}

string getRandomTundraUnbuildableTexture() {
	return(cTextureNone);
}

string getRandomErebusUnbuildableTexture() {
	int randInt = rmRandInt(0, 1);
	if(randInt == 0) return(cHades8);
	if(randInt == 1) return(cHades9);
}

string getRandomOlympusUnbuildableTexture() {
	int randInt = rmRandInt(0, 2);
	if(randInt == 0) return(cIceA);
	if(randInt == 1) return(cIceB);
	if(randInt == 2) return(cIceC);
}

string getRandomUnbuildableTextureByStyle( int variationStyle1 = cStyleNone) {
	// This is an exception and only uses primary, as many styles don't have this kind of texture.
	if(variationStyle1 == cStyleNone) {
		variationStyle1 = cVariationStyle1;
	}

	if(variationStyle1 == cStyleGrass)	  return(getRandomGrassUnbuildableTexture());
	if(variationStyle1 == cStyleSand) 	  return(getRandomSandUnbuildableTexture());
	if(variationStyle1 == cStyleSnow) 	  return(getRandomSnowUnbuildableTexture());
	if(variationStyle1 == cStyleSavannah) return(getRandomSavannahUnbuildableTexture());
	if(variationStyle1 == cStyleMarsh)	  return(getRandomMarshUnbuildableTexture());
	if(variationStyle1 == cStyleTundra)   return(getRandomTundraUnbuildableTexture());
	if(variationStyle1 == cStyleErebus)   return(getRandomErebusUnbuildableTexture());
	if(variationStyle1 == cStyleOlympus)  return(getRandomOlympusUnbuildableTexture());
}

// Unbuildable surrounding (decoration; any style without an unbuildable texture also returns none here).
string getRandomGrassUnbuildableSurroundTexture() {
	return(cTextureNone);
}

string getRandomSandUnbuildableSurroundTexture() {
	return(cSandDirt50);
}

string getRandomSnowUnbuildableSurroundTexture() {
	int randInt = rmRandInt(0, 1);
	if(randInt == 0) return(cSnowA);
	if(randInt == 1) return(cSnowB);
}

string getRandomSavannahUnbuildableSurroundTexture() {
	return(cSandDirt50);
}

string getRandomMarshUnbuildableSurroundTexture() {
	return(cTextureNone);
}

string getRandomTundraUnbuildableSurroundTexture() {
	return(cTextureNone);
}

string getRandomErebusUnbuildableSurroundTexture() {
	int randInt = rmRandInt(0, 1);
	if(randInt == 0) return(cHadesBuildable1);
	if(randInt == 1) return(cHadesBuildable2);
}

string getRandomOlympusUnbuildableSurroundTexture() {
	int randInt = rmRandInt(0, 1);
	if(randInt == 0) return(cSnowA);
	if(randInt == 1) return(cSnowB);
}

string getRandomUnbuildableSurroundTextureByStyle( int variationStyle1 = cStyleNone) {
	// This is an exception and only uses primary, as many styles don't have this kind of texture.
	if(variationStyle1 == cStyleNone) {
		variationStyle1 = cVariationStyle1;
	}

	if(variationStyle1 == cStyleGrass)	  return(getRandomGrassUnbuildableSurroundTexture());
	if(variationStyle1 == cStyleSand) 	  return(getRandomSandUnbuildableSurroundTexture());
	if(variationStyle1 == cStyleSnow) 	  return(getRandomSnowUnbuildableSurroundTexture());
	if(variationStyle1 == cStyleSavannah) return(getRandomSavannahUnbuildableSurroundTexture());
	if(variationStyle1 == cStyleMarsh)	  return(getRandomMarshUnbuildableSurroundTexture());
	if(variationStyle1 == cStyleTundra)   return(getRandomTundraUnbuildableSurroundTexture());
	if(variationStyle1 == cStyleErebus)   return(getRandomErebusUnbuildableSurroundTexture());
	if(variationStyle1 == cStyleOlympus)  return(getRandomOlympusUnbuildableSurroundTexture());
}

// Cliff texture types.
string getRandomGrassCliffTexture(bool isImpassable = false) {
	if(isImpassable) {
		return(cCliffGreekA);
	}

	int randInt = rmRandInt(0, 3);
	if(randInt == 0) return(cGrassB);
	if(randInt == 1) return(cGrassA);
	if(randInt == 2) return(cGrassDirt25);
	if(randInt == 3) return(cGrassDirt50);
}

string getRandomSandCliffTexture(bool isImpassable = false) {
	if(isImpassable) {
		return(cCliffEgyptianA);
	}

	int randInt = rmRandInt(0, 4);
	if(randInt == 0) return(cSandA);
	if(randInt == 1) return(cSandB);
	if(randInt == 2) return(cSandC);
	if(randInt == 3) return(cSandD);
	if(randInt == 4) return(cSandDirt50);
}

string getRandomSnowCliffTexture(bool isImpassable = false) {
	if(isImpassable) {
		return(cCliffNorseA);
	}

	int randInt = rmRandInt(0, 1);
	if(randInt == 0) return(cSnowA);
	if(randInt == 1) return(cSnowB);
}

string getRandomSavannahCliffTexture(bool isImpassable = false) {
	if(isImpassable) {
		return(cCliffEgyptianA);
	}

	int randInt = rmRandInt(0, 3);
	if(randInt == 0) return(cSavannahA);
	if(randInt == 1) return(cSavannahB);
	if(randInt == 2) return(cSavannahC);
	if(randInt == 3) return(cSavannahD);
}

string getRandomMarshCliffTexture(bool isImpassable = false) {
	if(isImpassable) {
		return(cCliffGreekA);
	}

	int randInt = rmRandInt(0, 4);
	if(randInt == 0) return(cMarshA);
	if(randInt == 1) return(cMarshB);
	if(randInt == 2) return(cMarshC);
	if(randInt == 3) return(cMarshD);
	if(randInt == 4) return(cMarshE);
}

string getRandomTundraCliffTexture(bool isImpassable = false) {
	if(isImpassable) {
		return(cCliffNorseA);
	}

	// TODO Probably use snow here instead.
	int randInt = rmRandInt(0, 3);
	if(randInt == 0) return(cTundraGrassA);
	if(randInt == 1) return(cTundraGrassB);
	if(randInt == 2) return(cTundraRockA);
	if(randInt == 3) return(cTundraRockB);
}

string getRandomErebusCliffTexture(bool isImpassable = false) {
	if(isImpassable) {
		return(cHadesCliff);
	}

	int randInt = rmRandInt(0, 1);
	if(randInt == 0) return(cHadesBuildable1);
	if(randInt == 1) return(cHadesBuildable2);
}

string getRandomOlympusCliffTexture(bool isImpassable = false) {
	if(isImpassable) {
		return(cCliffNorseA);
	}

	int randInt = rmRandInt(0, 1);
	if(randInt == 0) return(cSnowA);
	if(randInt == 1) return(cSnowB);
}

string getRandomCliffByStyle(bool isImpassable = false, int variationStyle1 = cStyleNone, int variationStyle2 = cStyleNone) {
	if(variationStyle1 == cStyleNone) {
		variationStyle1 = cVariationStyle1;
	}

	if(variationStyle2 == cStyleNone) {
		variationStyle2 = cVariationStyle2;
	}

	if(variationStyle2 != cStyleNone && randChance()) {
		variationStyle1 = variationStyle2;
	}

	if(variationStyle1 == cStyleGrass)	  return(getRandomGrassCliffTexture(isImpassable));
	if(variationStyle1 == cStyleSand) 	  return(getRandomSandCliffTexture(isImpassable));
	if(variationStyle1 == cStyleSnow) 	  return(getRandomSnowCliffTexture(isImpassable));
	if(variationStyle1 == cStyleSavannah) return(getRandomSavannahCliffTexture(isImpassable));
	if(variationStyle1 == cStyleMarsh)	  return(getRandomMarshCliffTexture(isImpassable));
	if(variationStyle1 == cStyleTundra)   return(getRandomTundraCliffTexture(isImpassable));
	if(variationStyle1 == cStyleErebus)   return(getRandomErebusCliffTexture(isImpassable));
	if(variationStyle1 == cStyleOlympus)  return(getRandomOlympusCliffTexture(isImpassable));
}

// Cliff types.
extern const string cCliffTypeGreek = "Greek";
extern const string cCliffTypeEgyptian = "Egyptian";
extern const string cCliffTypeNorse = "Norse";
extern const string cCliffTypeHades = "Hades";

string getRandomCliffTypeByStyle(int variationStyle1 = cStyleNone, int variationStyle2 = cStyleNone) {
	if(variationStyle1 == cStyleNone) {
		variationStyle1 = cVariationStyle1;
	}

	if(variationStyle2 == cStyleNone) {
		variationStyle2 = cVariationStyle2;
	}

	if(variationStyle2 != cStyleNone && randChance()) {
		variationStyle1 = variationStyle2;
	}

	if(variationStyle1 == cStyleGrass)	  return(cCliffTypeGreek);
	if(variationStyle1 == cStyleSand) 	  return(cCliffTypeEgyptian);
	if(variationStyle1 == cStyleSnow) 	  return(cCliffTypeNorse);
	if(variationStyle1 == cStyleSavannah) return(cCliffTypeEgyptian);
	if(variationStyle1 == cStyleMarsh)	  return(cCliffTypeGreek);
	if(variationStyle1 == cStyleTundra)   return(cCliffTypeNorse);
	if(variationStyle1 == cStyleErebus)   return(cCliffTypeHades);
	if(variationStyle1 == cStyleOlympus)  return(cCliffTypeNorse);
}

// Water types.
extern const string cWaterAegeanSea = "Aegean Sea";
extern const string cWaterEgyptianNile = "Egyptian Nile";
extern const string cWaterEgyptianNileShallow = "Egyptian Nile Shallow";
extern const string cWaterGreekRiver = "Greek River";
extern const string cWaterMarshPool = "Marsh Pool";
extern const string cWaterMediterraneanSea = "Mediterranean Sea";
extern const string cWaterNorseRiver = "Norse River";
extern const string cWaterNorthAtlanticOcean = "North Atlantic Ocean";
extern const string cWaterNorwegianSea = "Norwegian Sea";
extern const string cWaterRedSea = "Red Sea";
extern const string cWaterSavannahWaterHole = "Savannah Water Hole";
extern const string cWaterWateringHole =  "Watering Hole";
extern const string cWaterStyxRiver = "Styx River";
extern const string cWaterTundra = "Tundra";
extern const string cWaterTundraPool = "Tundra Pool";

string getRandomGrassWater() {
	int randInt = rmRandInt(0, 2);
	if(randInt == 0) return(cWaterAegeanSea);
	if(randInt == 1) return(cWaterGreekRiver);
	if(randInt == 2) return(cWaterMediterraneanSea);
}

string getRandomSandWater() {
	int randInt = rmRandInt(0, 2);
	if(randInt == 0) return(cWaterEgyptianNile);
	if(randInt == 1) return(cWaterRedSea);
	if(randInt == 2) return(cWaterWateringHole);
}

string getRandomSnowWater() {
	int randInt = rmRandInt(0, 2);
	if(randInt == 0) return(cWaterNorseRiver);
	if(randInt == 1) return(cWaterNorthAtlanticOcean);
	if(randInt == 2) return(cWaterNorwegianSea);
}

string getRandomSavannahWater() {
	return(cWaterSavannahWaterHole);
}

string getRandomMarshWater() {
	int randInt = rmRandInt(0, 1);
	if(randInt == 0) return(cWaterGreekRiver);
	if(randInt == 1) return(cWaterMarshPool);
}

string getRandomTundraWater() {
	int randInt = rmRandInt(0, 1);
	if(randInt == 0) return(cWaterTundra);
	if(randInt == 1) return(cWaterTundraPool);
}

string getRandomErebusWater() {
	return(cWaterStyxRiver);
}

string getRandomOlympusWater() {
	return(cWaterNorseRiver);
}

string getRandomWaterByStyle(int variationStyle1 = cStyleNone, int variationStyle2 = cStyleNone) {
	if(variationStyle1 == cStyleNone) {
		variationStyle1 = cVariationStyle1;
	}

	if(variationStyle2 == cStyleNone) {
		variationStyle2 = cVariationStyle2;
	}

	if(variationStyle2 != cStyleNone && randChance()) {
		variationStyle1 = variationStyle2;
	}

	if(variationStyle1 == cStyleGrass)	  return(getRandomGrassWater());
	if(variationStyle1 == cStyleSand) 	  return(getRandomSandWater());
	if(variationStyle1 == cStyleSnow) 	  return(getRandomSnowWater());
	if(variationStyle1 == cStyleSavannah) return(getRandomSavannahWater());
	if(variationStyle1 == cStyleMarsh)	  return(getRandomMarshWater());
	if(variationStyle1 == cStyleTundra)   return(getRandomTundraWater());
	if(variationStyle1 == cStyleErebus)   return(getRandomErebusWater());
	if(variationStyle1 == cStyleOlympus)  return(getRandomOlympusWater());
}

// Connection override.
void addAllConnectionTerrainReplacements(int connectionID = -1, string replacement = "") {
	// TODO Add AoT replacements.
	// Extend these if more are required.
	rmAddConnectionTerrainReplacement(connectionID, cBlack, replacement);
	rmAddConnectionTerrainReplacement(connectionID, cCliffEgyptianA, replacement);
	rmAddConnectionTerrainReplacement(connectionID, cCliffGreekA, replacement);
	rmAddConnectionTerrainReplacement(connectionID, cCliffNorseA, replacement);
	rmAddConnectionTerrainReplacement(connectionID, cHades2, replacement);
	rmAddConnectionTerrainReplacement(connectionID, cHades6, replacement);
	rmAddConnectionTerrainReplacement(connectionID, cHades8, replacement);
	rmAddConnectionTerrainReplacement(connectionID, cHades9, replacement);
	rmAddConnectionTerrainReplacement(connectionID, cHadesCliff, replacement);
	rmAddConnectionTerrainReplacement(connectionID, cIceA, replacement);
	rmAddConnectionTerrainReplacement(connectionID, cIceB, replacement);
	rmAddConnectionTerrainReplacement(connectionID, cIceC, replacement);
	rmAddConnectionTerrainReplacement(connectionID, cMiningGround, replacement);
	rmAddConnectionTerrainReplacement(connectionID, cRiverGrassyA, replacement);
	rmAddConnectionTerrainReplacement(connectionID, cRiverIcyA, replacement);
	rmAddConnectionTerrainReplacement(connectionID, cRiverSandyA, replacement);
	rmAddConnectionTerrainReplacement(connectionID, cShorelineAtlanticA, replacement);
	rmAddConnectionTerrainReplacement(connectionID, cShorelineMediterraneanB, replacement);
	rmAddConnectionTerrainReplacement(connectionID, cShorelineNorwegianA, replacement);
	rmAddConnectionTerrainReplacement(connectionID, cShorelineRedSeaA, replacement);
}

// Forest types.
extern const string cForestAutumnOak = "Autumn Oak Forest";
extern const string cForestHades = "Hades Forest";
extern const string cForestMarsh = "Marsh Forest"; // AoT.
extern const string cForestMixedOak = "Mixed Oak Forest";
extern const string cForestMixedPalm = "Mixed Palm Forest";
extern const string cForestMixedPine = "Mixed Pine Forest";
extern const string cForestOak = "Oak Forest";
extern const string cForestPalm = "Palm Forest";
extern const string cForestPine = "Pine Forest";
extern const string cForestSavannah = "Savannah Forest";
extern const string cForestSnowPine = "Snow Pine Forest";
extern const string cForestTundra = "Tundra Forest"; // AoT.

string getRandomGrassForest() {
	int randInt = rmRandInt(0, 4);
	if(randInt == 0) return(cForestAutumnOak);
	if(randInt == 1) return(cForestMixedOak);
	if(randInt == 2) return(cForestMixedPalm);
	if(randInt == 3) return(cForestOak);
	if(randInt == 4) return(cForestPine);
}

string getRandomSandForest() {
	int randInt = rmRandInt(0, 1);
	if(randInt == 0) return(cForestPalm);
	if(randInt == 1) return(cForestSavannah);
}

string getRandomSnowForest() {
	int randInt = rmRandInt(0, 2);
	if(randInt == 0) return(cForestMixedPine);
	if(randInt == 1) return(cForestPine);
	if(randInt == 2) return(cForestSnowPine);
}

string getRandomSavannahForest() {
	if(randChance(2.0 / 3.0)) {
		// 67% chance for typical Savannah forest.
		return(cForestSavannah);
	}

	return(cForestPalm);
}

string getRandomMarshForest() {
	if(randChance()) {
		// 50% chance for typical Marsh forest.
		return(cForestMarsh);
	}

	int randInt = rmRandInt(0, 1);
	if(randInt == 0) return(cForestMixedOak);
	if(randInt == 1) return(cForestOak);
}

string getRandomTundraForest() {
	if(randChance(0.4)) {
		// 40% chance for typical Tundra forest.
		return(cForestTundra);
	}

	int randInt = rmRandInt(0, 2);
	if(randInt == 0) return(cForestMixedPine);
	if(randInt == 1) return(cForestPine);
	if(randInt == 2) return(cForestSnowPine);
}

string getRandomErebusForest() {
	return(cForestHades);
}

string getRandomOlympusForest() {
	int randInt = rmRandInt(0, 2);
	if(randInt == 0) return(cForestMixedPine);
	if(randInt == 1) return(cForestPine);
	if(randInt == 2) return(cForestSnowPine);
}

string getRandomForestByStyle(int variationStyle1 = cStyleNone, int variationStyle2 = cStyleNone) {
	if(variationStyle1 == cStyleNone) {
		variationStyle1 = cVariationStyle1;
	}

	if(variationStyle2 == cStyleNone) {
		variationStyle2 = cVariationStyle2;
	}

	if(variationStyle2 != cStyleNone && randChance()) {
		variationStyle1 = variationStyle2;
	}

	if(variationStyle1 == cStyleGrass)	  return(getRandomGrassForest());
	if(variationStyle1 == cStyleSand) 	  return(getRandomSandForest());
	if(variationStyle1 == cStyleSnow) 	  return(getRandomSnowForest());
	if(variationStyle1 == cStyleSavannah) return(getRandomSavannahForest());
	if(variationStyle1 == cStyleMarsh)	  return(getRandomMarshForest());
	if(variationStyle1 == cStyleTundra)   return(getRandomTundraForest());
	if(variationStyle1 == cStyleErebus)   return(getRandomErebusForest());
	if(variationStyle1 == cStyleOlympus)  return(getRandomOlympusForest());
}

// Decorative trees.
extern const string cDecoPineDeadBurning = "Pine Dead Burning"; // Don't randomize this here, but can be used (manually) in Erebus variations.
extern const string cTreeErebus = "Pine Dead";
extern const string cTreeMarsh = "Marsh Tree";
extern const string cTreeOak = "Oak Tree";
extern const string cTreeOakAutumn = "Oak Autumn";
extern const string cTreePalm = "Palm";
extern const string cTreePine = "Pine";
extern const string cTreePineSnow = "Pine Snow";
extern const string cTreeSavannah = "Savannah Tree";
extern const string cTreeTundra = "Tundra Tree";

string getRandomGrassTree() {
	int randInt = rmRandInt(0, 2);
	if(randInt == 0) return(cTreeOak);
	if(randInt == 1) return(cTreeOakAutumn);
	if(randInt == 2) return(cTreePine);
}

string getRandomSandTree() {
	int randInt = rmRandInt(0, 1);
	if(randInt == 0) return(cTreePalm);
	if(randInt == 1) return(cTreeSavannah);
}

string getRandomSnowTree() {
	int randInt = rmRandInt(0, 1);
	if(randInt == 0) return(cTreePine);
	if(randInt == 1) return(cTreePineSnow);
}

string getRandomSavannahTree() {
	if(randChance(2.0 / 3.0)) {
		// 67% chance for typical Savannah tree.
		return(cTreeSavannah);
	}

	return(cTreePalm);
}

string getRandomMarshTree() {
	if(randChance(2.0 / 3.0)) {
		// 67% chance for typical Marsh tree.
		return(cTreeMarsh);
	}

	return(cTreeOak);
}

string getRandomTundraTree() {
	if(randChance()) {
		// 50% chance for typical Tundra tree.
		return(cTreeTundra);
	}

	int randInt = rmRandInt(0, 1);
	if(randInt == 0) return(cTreePine);
	if(randInt == 1) return(cTreePineSnow);
}

string getRandomErebusTree() {
	return(cTreeErebus);
}

string getRandomOlympusTree() {
	int randInt = rmRandInt(0, 1);
	if(randInt == 0) return(cTreePine);
	if(randInt == 1) return(cTreePineSnow);
}

string getRandomTreeByStyle(int variationStyle1 = cStyleNone, int variationStyle2 = cStyleNone) {
	if(variationStyle1 == cStyleNone) {
		variationStyle1 = cVariationStyle1;
	}

	if(variationStyle2 == cStyleNone) {
		variationStyle2 = cVariationStyle2;
	}

	if(variationStyle2 != cStyleNone && randChance()) {
		variationStyle1 = variationStyle2;
	}

	if(variationStyle1 == cStyleGrass)	  return(getRandomGrassTree());
	if(variationStyle1 == cStyleSand) 	  return(getRandomSandTree());
	if(variationStyle1 == cStyleSnow) 	  return(getRandomSnowTree());
	if(variationStyle1 == cStyleSavannah) return(getRandomSavannahTree());
	if(variationStyle1 == cStyleMarsh)	  return(getRandomMarshTree());
	if(variationStyle1 == cStyleTundra)   return(getRandomTundraTree());
	if(variationStyle1 == cStyleErebus)   return(getRandomErebusTree());
	if(variationStyle1 == cStyleOlympus)  return(getRandomOlympusTree());
}

// Huntable types and food values.
extern const string cHuntAurochs = "Aurochs";
extern const int cHuntAurochsFood = 400;
extern const string cHuntBaboon = "Baboon";
extern const int cHuntBaboonFood = 100;
extern const string cHuntBoar = "Boar";
extern const int cHuntBoarFood = 300;
extern const string cHuntCaribou = "Caribou";
extern const int cHuntCaribouFood = 150;
extern const string cHuntCrownedCrane = "Crowned Crane";
extern const int cHuntCrownedCraneFood = 100;
extern const string cHuntDeer = "Deer";
extern const int cHuntDeerFood = 150;
extern const string cHuntElephant = "Elephant";
extern const int cHuntElephantFood = 750;
extern const string cHuntElk = "Elk";
extern const int cHuntElkFood = 150;
extern const string cHuntGazelle = "Gazelle";
extern const int cHuntGazelleFood = 150;
extern const string cHuntGiraffe = "Giraffe";
extern const int cHuntGiraffeFood = 300;
extern const string cHuntHippo = "Hippo";
extern const int cHuntHippoFood = 400;
extern const string cHuntMonkey = "Monkey";
extern const int cHuntMonkeyFood = 100;
extern const string cHuntRhinoceros = "Rhinocerous"; // This one has a typo in the proto.
extern const int cHuntRhinocerosFood = 500;
extern const string cHuntWalrus = "Walrus";
extern const int cHuntWalrusFood = 400;
extern const string cHuntWaterBuffalo = "Water Buffalo";
extern const int cHuntWaterBuffaloFood = 400;
extern const string cHuntZebra = "Zebra";
extern const int cHuntZebraFood = 200;

// Other food sources.
extern const string cFoodBerryBush = "Berry Bush";
extern const int cFoodBerryBushFood = 100;
extern const string cFoodChicken = "Chicken";
extern const int cFoodChickenFood = 75;

int getFoodForType(string type = "") {
	if(type == cHuntAurochs) 	  return(cHuntAurochsFood);
	if(type == cHuntBaboon) 	  return(cHuntBaboonFood);
	if(type == cHuntBoar)		  return(cHuntBoarFood);
	if(type == cHuntCaribou)	  return(cHuntCaribouFood);
	if(type == cHuntCrownedCrane) return(cHuntCrownedCraneFood);
	if(type == cHuntDeer) 		  return(cHuntDeerFood);
	if(type == cHuntElephant) 	  return(cHuntElephantFood);
	if(type == cHuntElk) 		  return(cHuntElkFood);
	if(type == cHuntGazelle) 	  return(cHuntGazelleFood);
	if(type == cHuntGiraffe) 	  return(cHuntGiraffeFood);
	if(type == cHuntHippo)		  return(cHuntHippoFood);
	if(type == cHuntMonkey) 	  return(cHuntMonkeyFood);
	if(type == cHuntRhinoceros)	  return(cHuntRhinocerosFood);
	if(type == cHuntWalrus)		  return(cHuntWalrusFood);
	if(type == cHuntWaterBuffalo) return(cHuntWaterBuffaloFood);
	if(type == cHuntZebra)		  return(cHuntZebraFood);
	if(type == cFoodBerryBush)    return(cFoodBerryBushFood);
	if(type == cFoodChicken)	  return(cFoodChickenFood);
}

/*
 * GrassSnow: Snow.
 * GrassSand: Sand.
 * SandSnow: Snow.
 * Marsh: Grass.
 * Savannah: Sand.
 * Tundra: Snow.
 * Olympus: Snow.
 * Erebus: Grass.
*/

string getRandomGrassHunt(bool mapHasWater = false) {
	int randInt = rmRandInt(0, 3);

	// if(mapHasWater && isStartingHunt == false) {
		// Since we only have 1 (exclusive) water hunt here, just extend this.
		// randInt = rmRandInt(0, 4);
	// }

	if(randInt == 0) return(cHuntAurochs);
	if(randInt == 1) return(cHuntBoar);
	if(randInt == 2) return(cHuntDeer);
	if(randInt == 3) return(cHuntElk);
	// if(randInt == 4) return(cHuntMonkey);
	// if(randInt == 5) return(cHuntCrownedCrane);
}

string getRandomSandHunt(bool mapHasWater = false) {
	int randInt = rmRandInt(0, 6);

	if(mapHasWater && randChance()) {
		// Chance to pick one of those on maps with water.
		randInt = rmRandInt(9, 10);
	}

	if(randInt == 0) return(cHuntAurochs);
	if(randInt == 1) return(cHuntBoar);
	if(randInt == 2) return(cHuntElephant);
	if(randInt == 3) return(cHuntGazelle);
	if(randInt == 4) return(cHuntGiraffe);
	if(randInt == 5) return(cHuntRhinoceros);
	if(randInt == 6) return(cHuntZebra);
	// if(randInt == 7) return(cHuntBaboon);
	// if(randInt == 8) return(cHuntMonkey);
	if(randInt == 9) return(cHuntHippo);
	if(randInt == 10) return(cHuntWaterBuffalo);
	// if(randInt == 11) return(cHuntCrownedCrane);
}

string getRandomSnowHunt(bool mapHasWater = false) {
	int randInt = rmRandInt(0, 4);

	if(mapHasWater) {
		// Since we only have 1 (exclusive) water hunt here, just extend this.
		randInt = rmRandInt(0, 5);
	}

	if(randInt == 0) return(cHuntAurochs);
	if(randInt == 1) return(cHuntBoar);
	if(randInt == 2) return(cHuntCaribou);
	if(randInt == 3) return(cHuntDeer);
	if(randInt == 4) return(cHuntElk);
	if(randInt == 5) return(cHuntWalrus);
}

string getRandomHuntByStyle(bool mapHasWater = false, int variationStyle1 = cStyleNone, int variationStyle2 = cStyleNone) {
	if(variationStyle1 == cStyleNone) {
		variationStyle1 = cVariationStyle1;
	}

	if(variationStyle2 == cStyleNone) {
		variationStyle2 = cVariationStyle2;
	}

	if(variationStyle2 != cStyleNone && randChance()) {
		variationStyle1 = variationStyle2;
	}

	if(variationStyle1 == cStyleGrass)	  return(getRandomGrassHunt(mapHasWater));
	if(variationStyle1 == cStyleSand) 	  return(getRandomSandHunt(mapHasWater));
	if(variationStyle1 == cStyleSnow) 	  return(getRandomSnowHunt(mapHasWater));
	if(variationStyle1 == cStyleSavannah) return(getRandomSandHunt(mapHasWater));
	if(variationStyle1 == cStyleMarsh)	  return(getRandomGrassHunt(mapHasWater));
	if(variationStyle1 == cStyleTundra)   return(getRandomSnowHunt(mapHasWater));
	if(variationStyle1 == cStyleErebus)   return(getRandomGrassHunt(mapHasWater));
	if(variationStyle1 == cStyleOlympus)  return(getRandomSnowHunt(mapHasWater));
}

string getRandomFoodByStyle(float huntChance = 0.9, bool mapHasWater = false, int variationStyle1 = cStyleNone, int variationStyle2 = cStyleNone) {
	if(randChance(huntChance)) {
		return(getRandomHuntByStyle(mapHasWater, variationStyle1, variationStyle2));
	}

	return(cFoodBerryBush);
}

int addFoodToObject(int objectID = -1, string huntType = "", int minFood = 0, int maxFood = -1, int minObjs = 1, int maxObjs = 12, bool verify = true) {
	if(objectID < 0 || huntType == "") {
		return(0);
	}

	if(maxFood < 0 || maxFood < minFood) {
		maxFood = minFood;
	}

	if(maxObjs < 0) {
		maxObjs = INF;
	}

	int huntFood = getFoodForType(huntType);

	// No less than minObjs, but no more than maxObjs.
	int minAmount = max(minObjs, min(maxObjs, 0 + ceil((0.0 + minFood) / huntFood)));

	// At least one, but no more than maxObjs.
	int maxAmount = min(maxObjs, max(minAmount, 0 + floor(maxFood / huntFood))); // Floor is redundant if maxFood is an int.

	int amount = rmRandInt(minAmount, maxAmount);

	// Cluster distance formula: 2.0-3.0 -> up to 9 objects, 4.0-5.0 -> up to 25 objects, 6.0-7.0 -> up to 49 objects.
	float dist = getClusterDist(amount);

	if(verify) {
		addObjectDefItemVerify(objectID, huntType, amount, dist);
	} else {
		rmAddObjectDefItem(objectID, huntType, amount, dist);
	}

	return(amount);
}

// Predator types.
extern const string cPredBear = "Bear";
extern const string cPredCrocodile = "Crocodile";
extern const string cPredHyena = "Hyena";
extern const string cPredLion = "Lion";
extern const string cPredPolarBear = "Polar Bear";
extern const string cPredWolf = "Wolf";
extern const string cPredWolfArctic1 = "Wolf Arctic 1";
extern const string cPredWolfArctic2 = "Wolf Arctic 2";

string getRandomGrassPredator(bool mapHasWater = false) {
	int randInt = rmRandInt(0, 1);

	if(mapHasWater) {
		randInt = rmRandInt(0, 2);
	}

	if(randInt == 0) return(cPredBear);
	if(randInt == 1) return(cPredWolf);
	if(randInt == 2) return(cPredCrocodile);
}

string getRandomSandPredator(bool mapHasWater = false) {
	int randInt = rmRandInt(0, 1);

	if(mapHasWater) {
		randInt = rmRandInt(0, 2);
	}

	if(randInt == 0) return(cPredHyena);
	if(randInt == 1) return(cPredLion);
	if(randInt == 2) return(cPredCrocodile);
}

string getRandomSnowPredator(bool mapHasWater = false) {
	int randInt = 0;

	if(cVersion == cVersionVanilla) {
		if(mapHasWater) {
			randInt = rmRandInt(2, 4);
		} else {
			randInt = rmRandInt(2, 3);
		}
	} else {
		if(mapHasWater) {
			randInt = rmRandInt(0, 4);
		} else {
			randInt = rmRandInt(0, 3);
		}
	}

	if(randInt == 0) return(cPredWolfArctic1);
	if(randInt == 1) return(cPredWolfArctic2);
	if(randInt == 2) return(cPredBear);
	if(randInt == 3) return(cPredWolf);
	if(randInt == 4) return(cPredPolarBear);
}

string getRandomPredatorByStyle(int variationStyle1 = cStyleNone, int variationStyle2 = cStyleNone) {
	if(variationStyle1 == cStyleNone) {
		variationStyle1 = cVariationStyle1;
	}

	if(variationStyle2 == cStyleNone) {
		variationStyle2 = cVariationStyle2;
	}

	if(variationStyle2 != cStyleNone && randChance()) {
		variationStyle1 = variationStyle2;
	}

	if(variationStyle1 == cStyleGrass)	  return(getRandomGrassPredator());
	if(variationStyle1 == cStyleSand) 	  return(getRandomSandPredator());
	if(variationStyle1 == cStyleSnow) 	  return(getRandomSnowPredator());
	if(variationStyle1 == cStyleSavannah) return(getRandomSandPredator());
	if(variationStyle1 == cStyleMarsh)	  return(getRandomGrassPredator());
	if(variationStyle1 == cStyleTundra)   return(getRandomSnowPredator());
	if(variationStyle1 == cStyleErebus)   return(getRandomGrassPredator());
	if(variationStyle1 == cStyleOlympus)  return(getRandomSnowPredator());
}

// Herdable types.
extern const string cHerdCow = "Cow";
extern const string cHerdGoat = "Goat";
extern const string cHerdPig = "Pig";

string getRandomGrassHerdable() {
	int randInt = rmRandInt(0, 2);
	if(randInt == 0) return(cHerdCow);
	if(randInt == 1) return(cHerdGoat);
	if(randInt == 2) return(cHerdPig);
}

string getRandomSandHerdable() {
	int randInt = rmRandInt(0, 2);
	if(randInt == 0) return(cHerdCow);
	if(randInt == 1) return(cHerdGoat);
	if(randInt == 2) return(cHerdPig);
}

string getRandomSnowHerdable() {
	int randInt = rmRandInt(0, 1);
	if(randInt == 0) return(cHerdCow);
	if(randInt == 1) return(cHerdGoat);
}

string getRandomHerdableByStyle(int variationStyle1 = cStyleNone, int variationStyle2 = cStyleNone) {
	if(variationStyle1 == cStyleNone) {
		variationStyle1 = cVariationStyle1;
	}

	if(variationStyle2 == cStyleNone) {
		variationStyle2 = cVariationStyle2;
	}

	if(variationStyle2 != cStyleNone && randChance()) {
		variationStyle1 = variationStyle2;
	}

	if(variationStyle1 == cStyleGrass)	  return(getRandomGrassHerdable());
	if(variationStyle1 == cStyleSand) 	  return(getRandomSandHerdable());
	if(variationStyle1 == cStyleSnow) 	  return(getRandomSnowHerdable());
	if(variationStyle1 == cStyleSavannah) return(getRandomSandHerdable());
	if(variationStyle1 == cStyleMarsh)	  return(getRandomGrassHerdable());
	if(variationStyle1 == cStyleTundra)   return(getRandomSnowHerdable());
	if(variationStyle1 == cStyleErebus)   return(getRandomGrassHerdable());
	if(variationStyle1 == cStyleOlympus)  return(getRandomSnowHerdable());
}

// Fish types.
extern const string cFishMahi = "Fish - Mahi";
extern const string cFishPerch = "Fish - Perch";
extern const string cFishSalmon = "Fish - Salmon";

string getRandomGrassFish() {
	int randInt = rmRandInt(0, 1);
	if(randInt == 0) return(cFishPerch);
	if(randInt == 1) return(cFishSalmon);
}

string getRandomSandFish() {
	return(cFishMahi);
}

string getRandomSnowFish() {
	int randInt = rmRandInt(0, 1);
	if(randInt == 0) return(cFishPerch);
	if(randInt == 1) return(cFishSalmon);
}

string getRandomFishByStyle(int variationStyle1 = cStyleNone, int variationStyle2 = cStyleNone) {
	if(variationStyle1 == cStyleNone) {
		variationStyle1 = cVariationStyle1;
	}

	if(variationStyle2 == cStyleNone) {
		variationStyle2 = cVariationStyle2;
	}

	if(variationStyle2 != cStyleNone && randChance()) {
		variationStyle1 = variationStyle2;
	}

	if(variationStyle1 == cStyleGrass)	  return(getRandomGrassFish());
	if(variationStyle1 == cStyleSand) 	  return(getRandomSandFish());
	if(variationStyle1 == cStyleSnow) 	  return(getRandomSnowFish());
	if(variationStyle1 == cStyleSavannah) return(getRandomSandFish());
	if(variationStyle1 == cStyleMarsh)	  return(getRandomGrassFish());
	if(variationStyle1 == cStyleTundra)   return(getRandomSnowFish());
	if(variationStyle1 == cStyleErebus)   return(getRandomGrassFish());
	if(variationStyle1 == cStyleOlympus)  return(getRandomSnowFish());
}

// Gold.
extern const string cGoldLarge = "Gold Mine";
extern const string cGoldSmall = "Gold Mine Small";
extern const string cGoldTiny = "Gold Mine Tiny";

// Relics.
extern const string cRelic = "Relic";

// Embellishment.
// Non-blocking, common (can occur in groups).
extern const string cDecoBush = "Bush";
extern const string cDecoGrass = "Grass";

string getRandomNonBlockingCommonGrass() {
	int randInt = rmRandInt(0, 1);
	if(randInt == 0) return(cDecoBush);
	if(randInt == 1) return(cDecoGrass);
}

string getRandomNonBlockingCommonSand() {
	int randInt = rmRandInt(0, 1);
	if(randInt == 0) return(cDecoBush);
	if(randInt == 1) return(cDecoGrass);
}

string getRandomNonBlockingCommonSnow() {
	return(cDecoGrass);
}

string getRandomNonBlockingCommonSavannah() {
	int randInt = rmRandInt(0, 1);
	if(randInt == 0) return(cDecoBush);
	if(randInt == 1) return(cDecoGrass);
}

string getRandomNonBlockingCommonTundra() {
	return(cDecoGrass);
}

string getRandomNonBlockingCommonMarsh() {
	int randInt = rmRandInt(0, 1);
	if(randInt == 0) return(cDecoBush);
	if(randInt == 1) return(cDecoGrass);
}

string getRandomNonBlockingCommonErebus() {
	return(cTextureNone);
}

string getRandomNonBlockingCommonOlympus() {
	return(cTextureNone);
}

string getRandomNonBlockingCommonByStyle(int variationStyle1 = cStyleNone, int variationStyle2 = cStyleNone) {
	if(variationStyle1 == cStyleNone) {
		variationStyle1 = cVariationStyle1;
	}

	if(variationStyle2 == cStyleNone) {
		variationStyle2 = cVariationStyle2;
	}

	if(variationStyle2 != cStyleNone && randChance()) {
		variationStyle1 = variationStyle2;
	}

	if(variationStyle1 == cStyleGrass)	  return(getRandomNonBlockingCommonGrass());
	if(variationStyle1 == cStyleSand) 	  return(getRandomNonBlockingCommonSand());
	if(variationStyle1 == cStyleSnow) 	  return(getRandomNonBlockingCommonSnow());
	if(variationStyle1 == cStyleSavannah) return(getRandomNonBlockingCommonSavannah());
	if(variationStyle1 == cStyleMarsh)	  return(getRandomNonBlockingCommonMarsh());
	if(variationStyle1 == cStyleTundra)   return(getRandomNonBlockingCommonTundra());
	if(variationStyle1 == cStyleErebus)   return(getRandomNonBlockingCommonErebus());
	if(variationStyle1 == cStyleOlympus)  return(getRandomNonBlockingCommonOlympus());
}

// Non-blocking, uncommon (can occur in groups and with common textures).
extern const string cDecoFlowers = "Flowers";
extern const string cDecoRottingLog = "Rotting Log";
extern const string cDecoStalagmite = "Stalagmite"; // This is blocking, but can be built over.

string getRandomNonBlockingUncommonGrass() {
	int randInt = rmRandInt(1, 1);
	if(randInt == 0) return(cDecoFlowers);
	if(randInt == 1) return(cDecoRottingLog);
}

string getRandomNonBlockingUncommonSand() {
	return(cDecoFlowers);
}

string getRandomNonBlockingUncommonSnow() {
	return(cTextureNone);
}

string getRandomNonBlockingUncommonSavannah() {
	return(cDecoFlowers);
}

string getRandomNonBlockingUncommonMarsh() {
	int randInt = rmRandInt(0, 1);
	if(randInt == 0) return(cDecoFlowers);
	if(randInt == 1) return(cDecoRottingLog);
}

string getRandomNonBlockingUncommonTundra() {
	return(cTextureNone);
}

string getRandomNonBlockingUncommonErebus() {
	return(cDecoStalagmite);
}

string getRandomNonBlockingUncommonOlympus() {
	return(cTextureNone);
}

string getRandomNonBlockingUncommonByStyle(int variationStyle1 = cStyleNone, int variationStyle2 = cStyleNone) {
	if(variationStyle1 == cStyleNone) {
		variationStyle1 = cVariationStyle1;
	}

	if(variationStyle2 == cStyleNone) {
		variationStyle2 = cVariationStyle2;
	}

	if(variationStyle2 != cStyleNone && randChance()) {
		variationStyle1 = variationStyle2;
	}

	if(variationStyle1 == cStyleGrass)	  return(getRandomNonBlockingUncommonGrass());
	if(variationStyle1 == cStyleSand) 	  return(getRandomNonBlockingUncommonSand());
	if(variationStyle1 == cStyleSnow) 	  return(getRandomNonBlockingUncommonSnow());
	if(variationStyle1 == cStyleSavannah) return(getRandomNonBlockingUncommonSavannah());
	if(variationStyle1 == cStyleMarsh)	  return(getRandomNonBlockingUncommonMarsh());
	if(variationStyle1 == cStyleTundra)   return(getRandomNonBlockingUncommonTundra());
	if(variationStyle1 == cStyleErebus)   return(getRandomNonBlockingUncommonErebus());
	if(variationStyle1 == cStyleOlympus)  return(getRandomNonBlockingUncommonOlympus());
}

// Blocking (those are all depending on gaia civ, so make sure to always set that).
extern const string cDecoColumnsBroken = "Columns Broken";
extern const string cDecoColumns = "Columns";
extern const string cDecoFountain = "Fountain";
extern const string cDecoRuins = "Ruins";
extern const string cDecoRunestone = "Runestone";
extern const string cDecoTorch = "Torch";

string getRandomBlocking() {
	int randInt = rmRandInt(0, 5);
	if(randInt == 0) return(cDecoColumnsBroken);
	if(randInt == 1) return(cDecoColumns);
	if(randInt == 2) return(cDecoFountain);
	if(randInt == 3) return(cDecoRuins);
	if(randInt == 4) return(cDecoRunestone);
	if(randInt == 5) return(cDecoTorch);
}

// Rocks small (non-blocking).
extern const string cDecoRockGraniteSmall = "Rock Granite Small";
extern const string cDecoRockGraniteSprite = "Rock Granite Sprite";
extern const string cDecoRockLimestoneSmall = "Rock Limestone Small";
extern const string cDecoRockLimestoneSprite = "Rock Limestone Sprite";
extern const string cDecoRockSandstoneSmall = "Rock Sandstone Small";
extern const string cDecoRockSandstoneSprite = "Rock Sandstone Sprite";

string getRandomRockSpriteByStyle(int variationStyle1 = cStyleNone, int variationStyle2 = cStyleNone) {
	if(variationStyle1 == cStyleNone) {
		variationStyle1 = cVariationStyle1;
	}

	if(variationStyle2 == cStyleNone) {
		variationStyle2 = cVariationStyle2;
	}

	if(variationStyle2 != cStyleNone && randChance()) {
		variationStyle1 = variationStyle2;
	}

	if(variationStyle1 == cStyleGrass)	  return(cDecoRockLimestoneSprite);
	if(variationStyle1 == cStyleSand) 	  return(cDecoRockSandstoneSprite);
	if(variationStyle1 == cStyleSnow) 	  return(cDecoRockGraniteSprite);
	if(variationStyle1 == cStyleSavannah) return(cDecoRockSandstoneSprite);
	if(variationStyle1 == cStyleMarsh)	  return(cDecoRockLimestoneSprite);
	if(variationStyle1 == cStyleTundra)   return(cDecoRockGraniteSprite);
	if(variationStyle1 == cStyleErebus)   return(cDecoRockLimestoneSprite);
	if(variationStyle1 == cStyleOlympus)  return(cDecoRockGraniteSprite);
}

string getRandomRockSmallByStyle(int variationStyle1 = cStyleNone, int variationStyle2 = cStyleNone) {
	if(variationStyle1 == cStyleNone) {
		variationStyle1 = cVariationStyle1;
	}

	if(variationStyle2 == cStyleNone) {
		variationStyle2 = cVariationStyle2;
	}

	if(variationStyle2 != cStyleNone && randChance()) {
		variationStyle1 = variationStyle2;
	}

	if(variationStyle1 == cStyleGrass)	  return(cDecoRockLimestoneSmall);
	if(variationStyle1 == cStyleSand) 	  return(cDecoRockSandstoneSmall);
	if(variationStyle1 == cStyleSnow) 	  return(cDecoRockGraniteSmall);
	if(variationStyle1 == cStyleSavannah) return(cDecoRockSandstoneSmall);
	if(variationStyle1 == cStyleMarsh)	  return(cDecoRockLimestoneSmall);
	if(variationStyle1 == cStyleTundra)   return(cDecoRockGraniteSmall);
	if(variationStyle1 == cStyleErebus)   return(cDecoRockLimestoneSmall);
	if(variationStyle1 == cStyleOlympus)  return(cDecoRockGraniteSmall);
}

// Rocks big (blocking).
extern const string cDecoRockGraniteBig = "Rock Granite Big";
extern const string cDecoRockLimestoneBig = "Rock Limestone Big";
extern const string cDecoRockSandstoneBig = "Rock Sandstone Big";
extern const string cDecoRockRiverGrassy = "Rock River Grassy";
extern const string cDecoRockRiverIcy = "Rock River Icy";
extern const string cDecoRockRiverSandy = "Rock River Sandy";

string getRandomRockBigGrass() {
	int randInt = rmRandInt(0, 1);
	if(randInt == 0) return(cDecoRockLimestoneBig);
	if(randInt == 1) return(cDecoRockRiverGrassy);
}

string getRandomRockBigSand() {
	int randInt = rmRandInt(0, 1);
	if(randInt == 0) return(cDecoRockSandstoneBig);
	if(randInt == 1) return(cDecoRockRiverSandy);
}

string getRandomRockBigSnow() {
	int randInt = rmRandInt(0, 1);
	if(randInt == 0) return(cDecoRockGraniteBig);
	if(randInt == 1) return(cDecoRockRiverIcy);
}

string getRandomRockBigSavannah() {
	int randInt = rmRandInt(0, 1);
	if(randInt == 0) return(cDecoRockSandstoneBig);
	if(randInt == 1) return(cDecoRockRiverSandy);
}

string getRandomRockBigMarsh() {
	int randInt = rmRandInt(0, 1);
	if(randInt == 0) return(cDecoRockLimestoneBig);
	if(randInt == 1) return(cDecoRockRiverGrassy);
}

string getRandomRockBigTundra() {
	int randInt = rmRandInt(0, 1);
	if(randInt == 0) return(cDecoRockGraniteBig);
	if(randInt == 1) return(cDecoRockRiverIcy);
}

string getRandomRockBigErebus() {
	int randInt = rmRandInt(0, 1);
	if(randInt == 0) return(cDecoRockLimestoneBig);
	if(randInt == 1) return(cDecoRockRiverGrassy);
}

string getRandomRockBigOlympus() {
	int randInt = rmRandInt(0, 1);
	if(randInt == 0) return(cDecoRockGraniteBig);
	if(randInt == 1) return(cDecoRockRiverIcy);
}

string getRandomRockBigByStyle(int variationStyle1 = cStyleNone, int variationStyle2 = cStyleNone) {
	if(variationStyle1 == cStyleNone) {
		variationStyle1 = cVariationStyle1;
	}

	if(variationStyle2 == cStyleNone) {
		variationStyle2 = cVariationStyle2;
	}

	if(variationStyle2 != cStyleNone && randChance()) {
		variationStyle1 = variationStyle2;
	}

	if(variationStyle1 == cStyleGrass)	  return(getRandomRockBigGrass());
	if(variationStyle1 == cStyleSand) 	  return(getRandomRockBigSand());
	if(variationStyle1 == cStyleSnow) 	  return(getRandomRockBigSnow());
	if(variationStyle1 == cStyleSavannah) return(getRandomRockBigSavannah());
	if(variationStyle1 == cStyleMarsh)	  return(getRandomRockBigMarsh());
	if(variationStyle1 == cStyleTundra)   return(getRandomRockBigTundra());
	if(variationStyle1 == cStyleErebus)   return(getRandomRockBigErebus());
	if(variationStyle1 == cStyleOlympus)  return(getRandomRockBigOlympus());
}

// Environmental.
extern const string cDecoBlowingLeaves = "Blowing Leaves"; // Too distracting. Don't use this, but have it here anyway.
extern const string cDecoDustDevil = "Dust Devil";
extern const string cDecoFire = "Fire Object";
extern const string cDecoFireHades = "Fire Hades";
extern const string cDecoLavaBubbling = "Lava Bubbling"; // Don't use this, but have it here anyway.
extern const string cDecoMist = "Mist"; // AoT only.
extern const string cDecoSandDrift = "Sand Drift Dune";

string getRandomEnvGrass() {
	return(cDecoMist);
}

string getRandomEnvSand() {
	int randInt = rmRandInt(0, 1);
	if(randInt == 0) return(cDecoDustDevil);
	if(randInt == 1) return(cDecoSandDrift);
}

string getRandomEnvSnow() {
	return(cTextureNone);
}

string getRandomEnvSavannah() {
	int randInt = rmRandInt(0, 1);
	if(randInt == 0) return(cDecoDustDevil);
	if(randInt == 1) return(cDecoSandDrift);
}

string getRandomEnvMarsh() {
	return(cDecoMist);
}

string getRandomEnvTundra() {
	return(cTextureNone);
}

string getRandomEnvErebus() {
	int randInt = rmRandInt(0, 1);
	if(randInt == 0) return(cDecoFire);
	if(randInt == 1) return(cDecoFireHades);
}

string getRandomEnvOlympus() {
	return(cDecoMist);
}

string getRandomEnvByStyle(int variationStyle1 = cStyleNone, int variationStyle2 = cStyleNone) {
	if(variationStyle1 == cStyleNone) {
		variationStyle1 = cVariationStyle1;
	}

	if(variationStyle2 == cStyleNone) {
		variationStyle2 = cVariationStyle2;
	}

	if(variationStyle2 != cStyleNone && randChance()) {
		variationStyle1 = variationStyle2;
	}

	if(variationStyle1 == cStyleGrass)	  return(getRandomEnvGrass());
	if(variationStyle1 == cStyleSand) 	  return(getRandomEnvSand());
	if(variationStyle1 == cStyleSnow) 	  return(getRandomEnvSnow());
	if(variationStyle1 == cStyleSavannah) return(getRandomEnvSavannah());
	if(variationStyle1 == cStyleMarsh)	  return(getRandomEnvMarsh());
	if(variationStyle1 == cStyleTundra)   return(getRandomEnvTundra());
	if(variationStyle1 == cStyleErebus)   return(getRandomEnvErebus());
	if(variationStyle1 == cStyleOlympus)  return(getRandomEnvOlympus());
}

// Water (flora).
extern const string cDecoWaterDecoration = "Water Decoration"; // This is boring, but we'll use it anyway for variation.
extern const string cDecoWaterLily = "Water Lilly"; // Has a typo.
extern const string cDecoWaterPapyrus = "Papyrus";
extern const string cDecoWaterReeds = "Water Reeds"; // Could be placed close to water (but not in water).
extern const string cDecoWaterSeaweed = "Seaweed";

string getRandomWaterFloraGrass() {
	int randInt = rmRandInt(0, 2);
	if(randInt == 0) return(cDecoWaterDecoration);
	if(randInt == 1) return(cDecoWaterLily);
	if(randInt == 2) return(cDecoWaterSeaweed);
}

string getRandomWaterFloraSand() {
	int randInt = rmRandInt(0, 3);
	if(randInt == 0) return(cDecoWaterDecoration);
	if(randInt == 1) return(cDecoWaterLily);
	if(randInt == 2) return(cDecoWaterPapyrus);
	if(randInt == 3) return(cDecoWaterSeaweed);
}

string getRandomWaterFloraSnow() {
	int randInt = rmRandInt(0, 1);
	if(randInt == 0) return(cDecoWaterDecoration);
	if(randInt == 1) return(cDecoWaterSeaweed);
}

string getRandomWaterFloraSavannah() {
	int randInt = rmRandInt(0, 3);
	if(randInt == 0) return(cDecoWaterDecoration);
	if(randInt == 1) return(cDecoWaterLily);
	if(randInt == 2) return(cDecoWaterPapyrus);
	if(randInt == 3) return(cDecoWaterSeaweed);
}

string getRandomWaterFloraMarsh() {
	int randInt = rmRandInt(0, 2);
	if(randInt == 0) return(cDecoWaterDecoration);
	if(randInt == 1) return(cDecoWaterLily);
	if(randInt == 2) return(cDecoWaterSeaweed);
}

string getRandomWaterFloraTundra() {
	return(cTextureNone);
}

string getRandomWaterFloraErebus() {
	return(cTextureNone); // No decoration here.
}

string getRandomWaterFloraOlympus() {
	return(cTextureNone); // No decoration here.
}

string getRandomWaterFloraByStyle(int variationStyle1 = cStyleNone, int variationStyle2 = cStyleNone) {
	if(variationStyle1 == cStyleNone) {
		variationStyle1 = cVariationStyle1;
	}

	if(variationStyle2 == cStyleNone) {
		variationStyle2 = cVariationStyle2;
	}

	if(variationStyle2 != cStyleNone && randChance()) {
		variationStyle1 = variationStyle2;
	}

	if(variationStyle1 == cStyleGrass)	  return(getRandomWaterFloraGrass());
	if(variationStyle1 == cStyleSand) 	  return(getRandomWaterFloraSand());
	if(variationStyle1 == cStyleSnow) 	  return(getRandomWaterFloraSnow());
	if(variationStyle1 == cStyleSavannah) return(getRandomWaterFloraSavannah());
	if(variationStyle1 == cStyleMarsh)	  return(getRandomWaterFloraMarsh());
	if(variationStyle1 == cStyleTundra)   return(getRandomWaterFloraTundra());
	if(variationStyle1 == cStyleErebus)   return(getRandomWaterFloraErebus());
	if(variationStyle1 == cStyleOlympus)  return(getRandomWaterFloraOlympus());
}

// Water (fauna).
extern const string cDecoWaterOrca = "Orca";
extern const string cDecoWaterSeagull = "Seagull"; // Places a weird white thing on the floor, don't use.
extern const string cDecoWaterShark = "Shark";
extern const string cDecoWaterTurtle = "Hawksbill";
extern const string cDecoWaterWhale = "Whale";

string getRandomWaterFaunaGrass() {
	int randInt = rmRandInt(0, 2);
	if(randInt == 0) return(cDecoWaterOrca);
	if(randInt == 1) return(cDecoWaterShark);
	if(randInt == 2) return(cDecoWaterWhale);
}

string getRandomWaterFaunaSand() {
	int randInt = rmRandInt(0, 2);
	if(randInt == 0) return(cDecoWaterOrca);
	if(randInt == 1) return(cDecoWaterShark);
	// if(randInt == 2) return(cDecoWaterTurtle);
	if(randInt == 2) return(cDecoWaterWhale);
}

string getRandomWaterFaunaSnow() {
	int randInt = rmRandInt(0, 2);
	if(randInt == 0) return(cDecoWaterOrca);
	if(randInt == 1) return(cDecoWaterShark);
	if(randInt == 2) return(cDecoWaterWhale);
}

string getRandomWaterFaunaSavannah() {
	int randInt = rmRandInt(0, 2);
	if(randInt == 0) return(cDecoWaterOrca);
	if(randInt == 1) return(cDecoWaterShark);
	// if(randInt == 2) return(cDecoWaterTurtle);
	if(randInt == 2) return(cDecoWaterWhale);
}

string getRandomWaterFaunaMarsh() {
	return(cTextureNone);
}

string getRandomWaterFaunaTundra() {
	int randInt = rmRandInt(0, 2);
	if(randInt == 0) return(cDecoWaterOrca);
	if(randInt == 1) return(cDecoWaterShark);
	if(randInt == 2) return(cDecoWaterWhale);
}

string getRandomWaterFaunaErebus() {
	return(cTextureNone); // No decoration here.
}

string getRandomWaterFaunaOlympus() {
	return(cTextureNone); // No decoration here.
}

string getRandomWaterFaunaByStyle(int variationStyle1 = cStyleNone, int variationStyle2 = cStyleNone) {
	if(variationStyle1 == cStyleNone) {
		variationStyle1 = cVariationStyle1;
	}

	if(variationStyle2 == cStyleNone) {
		variationStyle2 = cVariationStyle2;
	}

	if(variationStyle2 != cStyleNone && randChance()) {
		variationStyle1 = variationStyle2;
	}

	if(variationStyle1 == cStyleGrass)	  return(getRandomWaterFaunaGrass());
	if(variationStyle1 == cStyleSand) 	  return(getRandomWaterFaunaSand());
	if(variationStyle1 == cStyleSnow) 	  return(getRandomWaterFaunaSnow());
	if(variationStyle1 == cStyleSavannah) return(getRandomWaterFaunaSavannah());
	if(variationStyle1 == cStyleMarsh)	  return(getRandomWaterFaunaMarsh());
	if(variationStyle1 == cStyleTundra)   return(getRandomWaterFaunaTundra());
	if(variationStyle1 == cStyleErebus)   return(getRandomWaterFaunaErebus());
	if(variationStyle1 == cStyleOlympus)  return(getRandomWaterFaunaOlympus());
}

// Birds.
extern const string cDecoHawk = "Hawk";
extern const string cDecoVulture = "Vulture";
extern const string cDecoHarpy = "Harpy";

string getRandomBirdByStyle(int variationStyle1 = cStyleNone, int variationStyle2 = cStyleNone) {
	if(variationStyle1 == cStyleNone) {
		variationStyle1 = cVariationStyle1;
	}

	if(variationStyle2 == cStyleNone) {
		variationStyle2 = cVariationStyle2;
	}

	if(variationStyle2 != cStyleNone && randChance()) {
		variationStyle1 = variationStyle2;
	}

	if(variationStyle1 == cStyleGrass)	  return(cDecoHawk);
	if(variationStyle1 == cStyleSand) 	  return(cDecoVulture);
	if(variationStyle1 == cStyleSnow) 	  return(cDecoHawk);
	if(variationStyle1 == cStyleSavannah) return(cDecoVulture);
	if(variationStyle1 == cStyleMarsh)	  return(cDecoHawk);
	if(variationStyle1 == cStyleTundra)   return(cDecoHawk);
	if(variationStyle1 == cStyleErebus)   return(cDecoHarpy);
	if(variationStyle1 == cStyleOlympus)  return(cDecoHawk);
}

int getRandomGreekGod() {
	int randInt = rmRandInt(0, 2);
	if(randInt == 0) return(cCivZeusID);
	if(randInt == 1) return(cCivPoseidonID);
	if(randInt == 2) return(cCivHadesID);
}

int getRandomEgyptianGod() {
	int randInt = rmRandInt(0, 1);
	if(randInt == 0) return(cCivRaID);
	if(randInt == 1) return(cCivIsisID);
	// if(randInt == 2) return(cCivSetID); // Don't use Set, animals get the Set HP penalty.
}

int getRandomNorseGod() {
	int randInt = rmRandInt(0, 2);
	if(randInt == 0) return(cCivOdinID);
	if(randInt == 1) return(cCivThorID);
	if(randInt == 2) return(cCivLokiID);
}

int getRandomCivByStyle(int variationStyle1 = cStyleNone, int variationStyle2 = cStyleNone) {
	if(variationStyle1 == cStyleNone) {
		variationStyle1 = cVariationStyle1;
	}

	if(variationStyle2 == cStyleNone) {
		variationStyle2 = cVariationStyle2;
	}

	if(variationStyle2 != cStyleNone && randChance()) {
		variationStyle1 = variationStyle2;
	}

	if(variationStyle1 == cStyleGrass)	  return(getRandomGreekGod());
	if(variationStyle1 == cStyleSand) 	  return(getRandomEgyptianGod());
	if(variationStyle1 == cStyleSnow) 	  return(getRandomNorseGod());
	if(variationStyle1 == cStyleSavannah) return(getRandomEgyptianGod());
	if(variationStyle1 == cStyleMarsh)	  return(getRandomGreekGod());
	if(variationStyle1 == cStyleTundra)   return(getRandomNorseGod());
	if(variationStyle1 == cStyleErebus)   return(cCivHades);
	if(variationStyle1 == cStyleOlympus)  return(cCivZeus);
}
