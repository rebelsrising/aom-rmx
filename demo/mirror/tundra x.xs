/*
** TUNDRA MIRROR
** RebelsRising
** Last edit: 09/03/2021
*/

include "rmx.xs";

string terrainTundraPool = "Tundra Pool";
string objectTundraTree = "Tundra Tree";
string objectTundraWolf = "Wolf Arctic 2";
string forestTundraForest = "Tundra Forest";
string terrainTundraA = "TundraRockA";
string terrainTundraB = "TundraGrassA";
string terrainTundraC = "TundraGrassB";

/*
** Vanilla textures.
*/
void useVanillaTextures() {
	terrainTundraPool = "Norwegian Sea";
	objectTundraTree = "Pine Snow";
	objectTundraWolf = "Wolf";
	forestTundraForest = "Snow Pine Forest";
	terrainTundraA = "SnowA";
	terrainTundraB = "SnowB";
	terrainTundraC = "SnowC";
}

void main() {
	progress(0.0);

	// Initial map setup.
	if(cVersion == cVersionVanilla) {
		useVanillaTextures();
		rmxInit("Tundra X (Vanilla)");
	} else {
		rmxInit("Tundra X");
	}

	// Set mirror mode.
	setMirrorMode(cMirrorPoint);

	// Perform mirror check.
	if(mirrorConfigIsInvalid()) {
		injectMirrorGenError();

		// Invalid configuration, quit.
		return;
	}

	// Set size.
	int mapSize = getStandardMapDimInMeters();

	// Initialize map.
	initializeMap(terrainTundraA, mapSize);

	// Place players.
	if(cNonGaiaPlayers < 9) {
		placePlayersInCircle(0.3, 0.4, 0.75);
	} else {
		placePlayersInCircle(0.35, 0.4, 0.85);
	}

	// Initialize areas.
	float centerRadius = 22.5;

	int classCenter = initializeCenter(centerRadius);
	int classCorner = initializeCorners(25.0);

	// Define classes.
	int classStartingSettlement = rmDefineClass("starting settlement");
	int classBonusHuntable = rmDefineClass("bonus huntable");

	// Define global constraints.
	// General.
	int avoidAll = createTypeDistConstraint("All", 7.0);
	int avoidEdge = createSymmetricBoxConstraint(rmXTilesToFraction(4), rmZTilesToFraction(4));
	int avoidCenter = createClassDistConstraint(classCenter, 1.0);
	int avoidCorner = createClassDistConstraint(classCorner, 1.0);

	// Terrain.
	int shortAvoidPond = createTerrainDistConstraint("Land", false, 1.0);
	int mediumAvoidPond = createTerrainDistConstraint("Land", false, 5.0);
	int farAvoidPond = createTerrainDistConstraint("Land", false, 10.0);

	// Settlements.
	int avoidStartingSettlement = createClassDistConstraint(classStartingSettlement, 20.0);
	int avoidSettlement = createTypeDistConstraint("AbstractSettlement", 15.0);
	int goldAvoidSettlement = createTypeDistConstraint("AbstractSettlement", 15.0);

	// Gold.
	int shortAvoidGold = createTypeDistConstraint("Gold", 10.0);
	int farAvoidGold = createTypeDistConstraint("Gold", 40.0);

	// Food.
	int avoidFood = createTypeDistConstraint("Food", 20.0);
	int avoidHuntable = createTypeDistConstraint("Huntable", 40.0);
	int avoidBonusHuntable = createClassDistConstraint(classBonusHuntable, 40.0);
	int avoidHerdable = createTypeDistConstraint("Herdable", 30.0);
	int avoidPredator = createTypeDistConstraint("AnimalPredator", 40.0);

	// Relics.
	int avoidRelic = createTypeDistConstraint("Relic", 80.0);

	// Buildings.
	int avoidTowerLOS = createTypeDistConstraint("Tower", 35.0);
	int avoidBuildings = createTypeDistConstraint("Building", 22.5);
	int farAvoidTower = createTypeDistConstraint("Tower", 25.0);
	int shortAvoidTower = createTypeDistConstraint("Tower", 15.0);

	// Embellishment.
	int embellishmentAvoidAll = createTypeDistConstraint("All", 3.0);

	// Define objects.
	// Starting objects.
	// Starting settlement.
	int startingSettlementID = rmCreateObjectDef("starting settlement");
	rmAddObjectDefItem(startingSettlementID, "Settlement Level 1", 1, 0.0);
	rmAddObjectDefToClass(startingSettlementID, classStartingSettlement);

	// Towers.
	int startingTowerID = rmCreateObjectDef("starting tower");
	rmAddObjectDefItem(startingTowerID, "Tower", 1, 0.0);
	rmAddObjectDefConstraint(startingTowerID, avoidAll);
	rmAddObjectDefConstraint(startingTowerID, farAvoidTower);

	int startingTowerBackupID = rmCreateObjectDef("starting tower backup");
	rmAddObjectDefItem(startingTowerBackupID, "Tower", 1, 0.0);
	rmAddObjectDefConstraint(startingTowerBackupID, avoidAll);
	rmAddObjectDefConstraint(startingTowerBackupID, shortAvoidTower);

	// Starting hunt.
	int startingHuntID = rmCreateObjectDef("starting hunt");
	rmAddObjectDefItem(startingHuntID, "Caribou", 6, 2.0);
	rmAddObjectDefConstraint(startingHuntID, avoidAll);
	rmAddObjectDefConstraint(startingHuntID, avoidEdge);
	rmAddObjectDefConstraint(startingHuntID, shortAvoidGold);
	rmAddObjectDefConstraint(startingHuntID, avoidFood);

	// Starting food.
	int startingFoodID = rmCreateObjectDef("starting food");
	if(randChance(0.8)) {
		rmAddObjectDefItem(startingFoodID, "Goat", rmRandInt(6, 8), 4.0);
	} else {
		rmAddObjectDefItem(startingFoodID, "Berry Bush", rmRandInt(6, 8), 2.0);
	}
	rmAddObjectDefConstraint(startingFoodID, avoidAll);
	rmAddObjectDefConstraint(startingFoodID, avoidEdge);
	rmAddObjectDefConstraint(startingFoodID, shortAvoidGold);
	rmAddObjectDefConstraint(startingFoodID, avoidFood);

	// Straggler trees.
	int stragglerTreeID = rmCreateObjectDef("straggler tree");
	rmAddObjectDefItem(stragglerTreeID, objectTundraTree, 1, 0.0);
	rmAddObjectDefConstraint(stragglerTreeID, avoidAll);

	// Gold.
	// Medium gold.
	int mediumGoldID = rmCreateObjectDef("medium gold");
	rmAddObjectDefItem(mediumGoldID, "Gold Mine", 1, 0.0);
	rmAddObjectDefConstraint(mediumGoldID, avoidAll);
	rmAddObjectDefConstraint(mediumGoldID, avoidEdge);
	rmAddObjectDefConstraint(mediumGoldID, createClassDistConstraint(classStartingSettlement, 50.0));
	rmAddObjectDefConstraint(mediumGoldID, goldAvoidSettlement);
	rmAddObjectDefConstraint(mediumGoldID, avoidCorner);
	rmAddObjectDefConstraint(mediumGoldID, farAvoidGold);
	rmAddObjectDefConstraint(mediumGoldID, mediumAvoidPond);
	rmAddObjectDefConstraint(mediumGoldID, avoidTowerLOS);

	// Bonus gold.
	int bonusGoldID = rmCreateObjectDef("bonus gold");
	rmAddObjectDefItem(bonusGoldID, "Gold Mine", 1, 0.0);
	rmAddObjectDefConstraint(bonusGoldID, avoidAll);
	rmAddObjectDefConstraint(bonusGoldID, avoidEdge);
	rmAddObjectDefConstraint(bonusGoldID, avoidCenter);
	rmAddObjectDefConstraint(bonusGoldID, createClassDistConstraint(classStartingSettlement, 80.0));
	rmAddObjectDefConstraint(bonusGoldID, goldAvoidSettlement);
	rmAddObjectDefConstraint(bonusGoldID, avoidCorner);
	rmAddObjectDefConstraint(bonusGoldID, farAvoidGold);
	rmAddObjectDefConstraint(bonusGoldID, mediumAvoidPond);

	// Hunt, berries and predators.
	// Close hunt.
	float closeHuntFloat = rmRandFloat(0.0, 1.0);

	int closeHuntID = rmCreateObjectDef("close hunt");
	if(closeHuntFloat < 0.1) {
		rmAddObjectDefItem(closeHuntID, "Elk", rmRandInt(5, 6), 4.0);
		rmAddObjectDefItem(closeHuntID, "Caribou", rmRandInt(5, 6), 4.0);
	} else if(closeHuntFloat < 0.3) {
		rmAddObjectDefItem(closeHuntID, "Elk", rmRandInt(5, 6), 2.0);
	} else if(closeHuntFloat < 0.6) {
		rmAddObjectDefItem(closeHuntID, "Aurochs", 1, 2.0);
	} else if(closeHuntFloat < 0.9) {
		rmAddObjectDefItem(closeHuntID, "Aurochs", 2, 2.0);
	} else {
		rmAddObjectDefItem(closeHuntID, "Aurochs", 4, 2.0);
	}
	rmAddObjectDefConstraint(closeHuntID, avoidAll);
	rmAddObjectDefConstraint(closeHuntID, avoidEdge);
	rmAddObjectDefConstraint(closeHuntID, avoidFood);

	// Medium hunt 1.
	int mediumHunt1ID = rmCreateObjectDef("medium hunt 1");
	rmAddObjectDefItem(mediumHunt1ID, "Elk", rmRandInt(4, 9), 2.0);
	rmAddObjectDefConstraint(mediumHunt1ID, avoidAll);
	rmAddObjectDefConstraint(mediumHunt1ID, avoidEdge);
	rmAddObjectDefConstraint(mediumHunt1ID, avoidCenter);
	rmAddObjectDefConstraint(mediumHunt1ID, avoidFood);
	rmAddObjectDefConstraint(mediumHunt1ID, createClassDistConstraint(classStartingSettlement, 50.0));
	rmAddObjectDefConstraint(mediumHunt1ID, shortAvoidPond);

	// Medium hunt 2.
	int mediumHunt2ID = rmCreateObjectDef("medium hunt 2");
	rmAddObjectDefItem(mediumHunt2ID, "Caribou", rmRandInt(4, 5), 2.0);
	rmAddObjectDefConstraint(mediumHunt2ID, avoidAll);
	rmAddObjectDefConstraint(mediumHunt2ID, avoidEdge);
	rmAddObjectDefConstraint(mediumHunt2ID, avoidCenter);
	rmAddObjectDefConstraint(mediumHunt2ID, avoidFood);
	rmAddObjectDefConstraint(mediumHunt2ID, createClassDistConstraint(classStartingSettlement, 50.0));
	rmAddObjectDefConstraint(mediumHunt2ID, shortAvoidPond);

	// Far hunt.
	int farHuntID = rmCreateObjectDef("bonus hunt 3");
	rmAddObjectDefItem(farHuntID, "Aurochs", rmRandInt(2, 3), 2.0);
	rmAddObjectDefConstraint(farHuntID, avoidAll);
	rmAddObjectDefConstraint(farHuntID, avoidEdge);
	rmAddObjectDefConstraint(farHuntID, avoidCenter);
	rmAddObjectDefConstraint(farHuntID, createClassDistConstraint(classStartingSettlement, 70.0));
	rmAddObjectDefConstraint(farHuntID, avoidFood);
	rmAddObjectDefConstraint(farHuntID, shortAvoidPond);

	// Bonus hunt 1.
	float bonusHunt1Float = rmRandFloat(0.0, 1.0);

	int bonusHunt1ID = rmCreateObjectDef("bonus hunt 1");
	if(bonusHunt1Float < 0.2) {
		rmAddObjectDefItem(bonusHunt1ID, "Caribou", rmRandInt(4, 5), 2.0);
		rmAddObjectDefItem(bonusHunt1ID, "Aurochs", rmRandInt(0, 2), 2.0);
	} else if(bonusHunt1Float < 0.5) {
		rmAddObjectDefItem(bonusHunt1ID, "Elk", rmRandInt(4, 6), 2.0);
	} else if (bonusHunt1Float < 0.9) {
		rmAddObjectDefItem(bonusHunt1ID, "Aurochs", rmRandInt(2, 3), 2.0);
	} else {
		rmAddObjectDefItem(bonusHunt1ID, "Caribou", rmRandInt(4, 7), 2.0);
	}
	rmAddObjectDefToClass(bonusHunt1ID, classBonusHuntable);
	rmAddObjectDefConstraint(bonusHunt1ID, avoidAll);
	rmAddObjectDefConstraint(bonusHunt1ID, avoidEdge);
	rmAddObjectDefConstraint(bonusHunt1ID, avoidCenter);
	rmAddObjectDefConstraint(bonusHunt1ID, createClassDistConstraint(classStartingSettlement, 70.0));
	rmAddObjectDefConstraint(bonusHunt1ID, avoidFood);
	rmAddObjectDefConstraint(bonusHunt1ID, shortAvoidPond);

	// Bonus hunt 2.
	int bonusHunt2ID = rmCreateObjectDef("bonus hunt 2");
	if(randChance(0.2)) {
		rmAddObjectDefItem(bonusHunt2ID, "Aurochs", 3, 2.0);
	} else {
		rmAddObjectDefItem(bonusHunt2ID, "Aurochs", 2, 2.0);
	}
	rmAddObjectDefToClass(bonusHunt2ID, classBonusHuntable);
	rmAddObjectDefConstraint(bonusHunt2ID, avoidAll);
	rmAddObjectDefConstraint(bonusHunt2ID, avoidEdge);
	rmAddObjectDefConstraint(bonusHunt2ID, avoidCenter);
	rmAddObjectDefConstraint(bonusHunt2ID, createClassDistConstraint(classStartingSettlement, 70.0));
	rmAddObjectDefConstraint(bonusHunt2ID, avoidFood);
	rmAddObjectDefConstraint(bonusHunt2ID, shortAvoidPond);

	// Far berries.
	int farBerriesID = rmCreateObjectDef("far berries");
	rmAddObjectDefItem(farBerriesID, "Berry Bush", 10, 4.0);
	rmAddObjectDefConstraint(farBerriesID, avoidAll);
	rmAddObjectDefConstraint(farBerriesID, avoidEdge);
	rmAddObjectDefConstraint(farBerriesID, avoidCenter);
	rmAddObjectDefConstraint(farBerriesID, createClassDistConstraint(classStartingSettlement, 70.0));
	rmAddObjectDefConstraint(farBerriesID, avoidFood);
	rmAddObjectDefConstraint(farBerriesID, shortAvoidPond);
	rmAddObjectDefConstraint(farBerriesID, avoidSettlement);

	// Far predators.
	int farPredatorsID = rmCreateObjectDef("far predators");
	rmAddObjectDefItem(farPredatorsID, objectTundraWolf, rmRandInt(1, 2), 4.0);
	rmAddObjectDefConstraint(farPredatorsID, avoidAll);
	rmAddObjectDefConstraint(farPredatorsID, avoidEdge);
	rmAddObjectDefConstraint(farPredatorsID, avoidCenter);
	rmAddObjectDefConstraint(farPredatorsID, createClassDistConstraint(classStartingSettlement, 80.0));
	rmAddObjectDefConstraint(farPredatorsID, avoidSettlement);
	rmAddObjectDefConstraint(farPredatorsID, avoidPredator);
	rmAddObjectDefConstraint(farPredatorsID, shortAvoidPond);

	// Other objects.
	// Random trees.
	int randomTreeID = rmCreateObjectDef("random tree");
	rmAddObjectDefItem(randomTreeID, objectTundraTree, 1, 0.0);
	setObjectDefDistanceToMax(randomTreeID);
	rmAddObjectDefConstraint(randomTreeID, avoidAll);
	rmAddObjectDefConstraint(randomTreeID, avoidStartingSettlement);
	rmAddObjectDefConstraint(randomTreeID, avoidSettlement);
	rmAddObjectDefConstraint(randomTreeID, shortAvoidPond);

	// Relics.
	int relicID = rmCreateObjectDef("relic");
	rmAddObjectDefItem(relicID, "Relic", 1, 0.0);
	rmAddObjectDefConstraint(relicID, avoidAll);
	rmAddObjectDefConstraint(relicID, avoidEdge);
	rmAddObjectDefConstraint(relicID, createClassDistConstraint(classStartingSettlement, 80.0));
	rmAddObjectDefConstraint(relicID, avoidRelic);
	rmAddObjectDefConstraint(relicID, shortAvoidPond);

	progress(0.1);

	// TCs.
	placeObjectAtPlayerLocs(startingSettlementID, true);

	// Towers.
	placeAndStoreObjectMirrored(startingTowerID, true, 4, 23.0, 27.0, true, -1, startingTowerBackupID);

	// Beautification.
	int beautificationID = 0;

	for(i = 0; < 100 * cNonGaiaPlayers) {
		beautificationID = rmCreateArea("beautification 1 " + i);
		rmSetAreaTerrainType(beautificationID, terrainTundraC);
		rmSetAreaSize(beautificationID, rmAreaTilesToFraction(20), rmAreaTilesToFraction(40));
		rmSetAreaMinBlobs(beautificationID, 1);
		rmSetAreaMaxBlobs(beautificationID, 5);
		rmSetAreaMinBlobDistance(beautificationID, 16.0);
		rmSetAreaMaxBlobDistance(beautificationID, 40.0);
		rmSetAreaWarnFailure(beautificationID, false);
		rmBuildArea(beautificationID);
	}

	for(i = 0; < 30 * cNonGaiaPlayers) {
		beautificationID = rmCreateArea("beautification 2 " + i);
		rmSetAreaTerrainType(beautificationID, terrainTundraB);
		rmSetAreaSize(beautificationID, rmAreaTilesToFraction(10), rmAreaTilesToFraction(50));
		rmSetAreaMinBlobs(beautificationID, 1);
		rmSetAreaMaxBlobs(beautificationID, 5);
		rmSetAreaMinBlobDistance(beautificationID, 16.0);
		rmSetAreaMaxBlobDistance(beautificationID, 40.0);
		rmSetAreaWarnFailure(beautificationID, false);
		rmBuildArea(beautificationID);
	}

	progress(0.2);

	// Areas.
	initAreaClass();

	setAreaWaterType(terrainTundraPool, 17.0, 9.0);

	setAreaBlobs(4, 4);

	setAreaAvoidSelf(60.0);
	setAreaCoherence(-0.25);
	setAreaSearchRadius(60.0, -1.0);

	addAreaConstraint(createClassDistConstraint(classStartingSettlement, 70.0));
	addAreaConstraint(avoidCenter);
	addAreaConstraint(avoidBuildings);

	buildAreas(min(cNonGaiaPlayers / 2, 2), 0.1);

	progress(0.3);

	// Settlements.
	int settlementID = rmCreateObjectDef("settlements");
	rmAddObjectDefItem(settlementID, "Settlement", 1, 0.0);

	float tcDist = 65.0;
	int settlementAvoidCenter = createClassDistConstraint(classCenter, 10.0 + 0.5 * (tcDist - 2.0 * centerRadius));

	// Close settlement.
	if(cNonGaiaPlayers < 3) {
		addFairLocConstraint(avoidCorner);
	} else {
		addFairLocConstraint(avoidTowerLOS);
	}
	addFairLocConstraint(farAvoidPond);

	addFairLoc(60.0, 80.0, false, true, 50.0, 12.0, 12.0);

	// Far settlement.
	addFairLocConstraint(farAvoidPond);
	addFairLocConstraint(avoidTowerLOS);
	addFairLocConstraint(settlementAvoidCenter);

	if(cNonGaiaPlayers < 3) {
		setFairLocInterDistMin(75.0);
		addFairLoc(60.0, 100.0, true, false, 65.0, 60.0, 60.0);
	} else if(cNonGaiaPlayers < 5) {
		addFairLoc(70.0, 80.0, true, false, 75.0, 24.0, 24.0);
	} else {
		addFairLoc(80.0, 90.0, true, false, 75.0, 24.0, 24.0);
	}

	placeObjectAtNewFairLocs(settlementID, false, "settlements");

	progress(0.4);

	// Forests.
	initForestClass();

	addForestConstraint(avoidCenter);
	addForestConstraint(avoidStartingSettlement);
	addForestConstraint(avoidAll);
	addForestConstraint(shortAvoidPond);

	addForestType(forestTundraForest, 1.0);

	setForestAvoidSelf(25.0);

	setForestBlobs(9);
	setForestBlobParams(4.625, 4.25);
	setForestCoherence(-0.75, 0.75);

	// Player forests.
	setForestSearchRadius(30.0, 40.0);
	setForestMinRatio(2.0 / 3.0);

	int numPlayerForests = 2;

	buildForests(numPlayerForests, 0.1, 1);

	progress(0.5);

	// Normal forests.
	setForestSearchRadius(20.0, -1.0);
	setForestMinRatio(2.0 / 3.0);

	int numForests = 11 * cNonGaiaPlayers / 2;

	buildForests(numForests, 0.3);

	progress(0.8);

	// Object placement.
	// Starting gold close to tower.
	storeObjectDefItem("Gold Mine Small", 1, 0.0);
	storeObjectConstraint(createTypeDistConstraint("Tower", rmRandFloat(8.0, 10.0))); // Don't get too close.
	storeObjectConstraint(avoidAll);
	storeObjectConstraint(avoidEdge);
	storeObjectConstraint(farAvoidPond);
	placeStoredObjectMirroredNearStoredLocs(4, false, 24.0, 25.0, 12.5);

	resetObjectStorage();

	// Medium gold.
	placeObjectMirrored(mediumGoldID, false, rmRandInt(1, 2), 50.0, 70.0);

	// Far gold.
	placeObjectMirrored(bonusGoldID, false, rmRandInt(2, 4), 80.0, 150.0);

	// Close hunt.
	placeObjectMirrored(closeHuntID, false, 1, 30.0, 50.0);

	// Medium hunt.
	placeObjectMirrored(mediumHunt1ID, false, 1, 60.0, 80.0);
	placeObjectMirrored(mediumHunt2ID, false, 1, 50.0, 70.0);

	// Far hunt.
	placeObjectMirrored(farHuntID, false, 1, 70.0, 120.0);

	// Bonus hunt.
	placeFarObjectMirrored(bonusHunt1ID);
	placeFarObjectMirrored(bonusHunt2ID);

	// Starting hunt.
	placeObjectMirrored(startingHuntID, false, 1, 22.0, 27.0, true);

	// Starting food.
	placeObjectMirrored(startingFoodID, true, 1, 22.0, 27.0, true);

	// Berries.
	if(randChance(0.6)) {
		placeFarObjectMirrored(farBerriesID);
	}

	// Straggler trees.
	placeObjectMirrored(stragglerTreeID, false, rmRandInt(2, 5), 13.0, 13.5, true);

	// Far predators.
	placeFarObjectMirrored(farPredatorsID);

	progress(0.9);

	// Center forest.
	int centerForestID = rmCreateArea("center forest");
	rmSetAreaForestType(centerForestID, forestTundraForest);
	rmSetAreaSize(centerForestID, areaRadiusMetersToFraction(rmRandFloat(2.0, 3.0)));
	rmSetAreaLocation(centerForestID, 0.5, 0.5);
	rmSetAreaCoherence(centerForestID, 1.0);
	rmBuildArea(centerForestID);

	// Relics (non mirrored).
	placeObjectInPlayerSplits(relicID);

	// Random trees.
	placeObjectAtPlayerLocs(randomTreeID, false, 20);

	// Embellishment.
	// Rocks.
	int rock1ID = rmCreateObjectDef("rock small");
	rmAddObjectDefItem(rock1ID, "Rock Sandstone Small", 1, 0.0);
	setObjectDefDistanceToMax(rock1ID);
	rmAddObjectDefConstraint(rock1ID, embellishmentAvoidAll);
	rmAddObjectDefConstraint(rock1ID, shortAvoidPond);
	rmPlaceObjectDefAtLoc(rock1ID, 0, 0.5, 0.5, 20 * cNonGaiaPlayers);

	int rock2ID = rmCreateObjectDef("rock sprite");
	rmAddObjectDefItem(rock2ID, "Rock Limestone Sprite", 1, 0.0);
	setObjectDefDistanceToMax(rock2ID);
	rmAddObjectDefConstraint(rock2ID, embellishmentAvoidAll);
	rmAddObjectDefConstraint(rock2ID, shortAvoidPond);
	rmPlaceObjectDefAtLoc(rock2ID, 0, 0.5, 0.5, 40 * cNonGaiaPlayers);

	// Birds.
	int birdsID = rmCreateObjectDef("birds");
	rmAddObjectDefItem(birdsID, "Hawk", 1, 0.0);
	setObjectDefDistanceToMax(birdsID);
	rmPlaceObjectDefAtLoc(birdsID, 0, 0.5, 0.5, 2 * cNonGaiaPlayers);

	// Finalize RM X.
	injectSnow(0.1);
	rmxFinalize();

	progress(1.0);
}
