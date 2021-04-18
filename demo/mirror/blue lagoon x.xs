/*
** BLUE LAGOON MIRROR
** RebelsRising
** Last edit: 09/03/2021
*/

include "rmx.xs";

void main() {
	progress(0.0);

	// Initial map setup.
	rmxInit("Blue Lagoon X");

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
	initializeMap("SandA", mapSize);

	// Place players.
	if(cNonGaiaPlayers < 9) {
		placePlayersInCircle(0.35, 0.4, 0.875);
	} else {
		placePlayersInCircle(0.4, 0.4, 0.9);
	}

	// Initialize areas.
	float centerRadius = 22.5;

	int classCenter = initializeCenter(centerRadius);
	int classCorner = initializeCorners(25.0);

	// Define classes.
	int classCliff = initCliffClass();
	int classStartingSettlement = rmDefineClass("starting settlement");
	int classPlayer = rmDefineClass("player");

	// Define global constraints.
	// General.
	int avoidAll = createTypeDistConstraint("All", 7.0);
	int avoidEdge = createSymmetricBoxConstraint(rmXTilesToFraction(4), rmZTilesToFraction(4));
	int avoidCenter = createClassDistConstraint(classCenter, 1.0);
	int avoidCorner = createClassDistConstraint(classCorner, 1.0);
	int avoidPlayer = createClassDistConstraint(classPlayer, 1.0);

	// Terrain.
	int shortAvoidImpassableLand = createTerrainDistConstraint("Land", false, 1.0);
	int mediumAvoidImpassableLand = createTerrainDistConstraint("Land", false, 5.0);
	int farAvoidImpassableLand = createTerrainDistConstraint("Land", false, 10.0);
	int avoidCliff = createClassDistConstraint(classCliff, 1.0);

	// Settlements.
	int avoidStartingSettlement = createClassDistConstraint(classStartingSettlement, 20.0);
	int avoidSettlement = createTypeDistConstraint("AbstractSettlement", 15.0);
	int goldAvoidSettlement = createTypeDistConstraint("AbstractSettlement", 15.0);

	// Gold.
	int shortAvoidGold = createTypeDistConstraint("Gold", 10.0);
	int farAvoidGold = createTypeDistConstraint("Gold", 35.0);

	// Food.
	int avoidFood = createTypeDistConstraint("Food", 20.0);
	int avoidHuntable = createTypeDistConstraint("Huntable", 40.0);
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

	// Close hunt.
	int closeHuntID = rmCreateObjectDef("close hunt");
	rmAddObjectDefItem(closeHuntID, "Giraffe", rmRandInt(2, 3), 2.0);
	rmAddObjectDefConstraint(closeHuntID, avoidAll);
	rmAddObjectDefConstraint(closeHuntID, avoidEdge);
	rmAddObjectDefConstraint(closeHuntID, shortAvoidGold);
	rmAddObjectDefConstraint(closeHuntID, avoidFood);
	rmAddObjectDefConstraint(closeHuntID, farAvoidImpassableLand);

	// Starting food.
	int startingFoodID = rmCreateObjectDef("starting food");
	rmAddObjectDefItem(startingFoodID, "Berry Bush", rmRandInt(5, 8), 2.0);
	rmAddObjectDefConstraint(startingFoodID, avoidAll);
	rmAddObjectDefConstraint(startingFoodID, avoidEdge);
	rmAddObjectDefConstraint(startingFoodID, avoidFood);
	rmAddObjectDefConstraint(startingFoodID, shortAvoidGold);
	rmAddObjectDefConstraint(startingFoodID, farAvoidImpassableLand);

	// Starting herdables.
	int startingHerdablesID = rmCreateObjectDef("starting herdables");
	rmAddObjectDefItem(startingHerdablesID, "Pig", rmRandInt(2, 3), 2.0);
	rmAddObjectDefConstraint(startingHerdablesID, avoidAll);
	rmAddObjectDefConstraint(startingHerdablesID, avoidEdge);
	rmAddObjectDefConstraint(startingHerdablesID, farAvoidImpassableLand);

	// Straggler trees.
	int stragglerTreeID = rmCreateObjectDef("straggler tree");
	rmAddObjectDefItem(stragglerTreeID, "Savannah Tree", 1, 0.0);
	rmAddObjectDefConstraint(stragglerTreeID, avoidAll);

	// Gold.
	// Medium gold.
	int mediumGoldID = rmCreateObjectDef("medium gold");
	rmAddObjectDefItem(mediumGoldID, "Gold Mine", 1, 0.0);
	rmAddObjectDefConstraint(mediumGoldID, avoidAll);
	rmAddObjectDefConstraint(mediumGoldID, avoidEdge);
	rmAddObjectDefConstraint(mediumGoldID, avoidCenter);
	rmAddObjectDefConstraint(mediumGoldID, createClassDistConstraint(classStartingSettlement, 50.0));
	rmAddObjectDefConstraint(mediumGoldID, goldAvoidSettlement);
	rmAddObjectDefConstraint(mediumGoldID, avoidCorner);
	rmAddObjectDefConstraint(mediumGoldID, farAvoidGold);
	rmAddObjectDefConstraint(mediumGoldID, mediumAvoidImpassableLand);
	rmAddObjectDefConstraint(mediumGoldID, avoidCliff);

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
	rmAddObjectDefConstraint(bonusGoldID, mediumAvoidImpassableLand);
	rmAddObjectDefConstraint(bonusGoldID, avoidCliff);

	// Hunt and berries.
	// Medium hunt 1.
	float mediumHunt1Float = rmRandFloat(0.0, 1.0);

	int mediumHunt1ID = rmCreateObjectDef("medium hunt 1");
	if(mediumHunt1Float < 1.0 / 3.0) {
		rmAddObjectDefItem(mediumHunt1ID, "Zebra", rmRandInt(3, 6), 2.0);
	} else if(mediumHunt1Float < 2.0 / 3.0) {
		rmAddObjectDefItem(mediumHunt1ID, "Gazelle", rmRandInt(4, 8), 2.0);
	} else {
		rmAddObjectDefItem(mediumHunt1ID, "Giraffe", rmRandInt(2, 4), 2.0);
	}
	rmAddObjectDefConstraint(mediumHunt1ID, avoidAll);
	rmAddObjectDefConstraint(mediumHunt1ID, avoidEdge);
	rmAddObjectDefConstraint(mediumHunt1ID, avoidCenter);
	rmAddObjectDefConstraint(mediumHunt1ID, createClassDistConstraint(classStartingSettlement, 50.0));
	rmAddObjectDefConstraint(mediumHunt1ID, avoidHuntable);
	rmAddObjectDefConstraint(mediumHunt1ID, mediumAvoidImpassableLand);
	rmAddObjectDefConstraint(mediumHunt1ID, avoidCliff);

	// Medium hunt 2.
	int mediumHunt2ID = rmCreateObjectDef("medium hunt 2");
	if(randChance()) {
		rmAddObjectDefItem(mediumHunt2ID, "Elephant", 1, 2.0);
	} else {
		rmAddObjectDefItem(mediumHunt2ID, "Rhinocerous", rmRandInt(1, 2), 2.0);
	}
	rmAddObjectDefItem(mediumHunt2ID, "Gazelle", rmRandInt(0, 3), 2.0);
	rmAddObjectDefConstraint(mediumHunt2ID, avoidAll);
	rmAddObjectDefConstraint(mediumHunt2ID, avoidEdge);
	rmAddObjectDefConstraint(mediumHunt2ID, avoidCenter);
	rmAddObjectDefConstraint(mediumHunt2ID, createClassDistConstraint(classStartingSettlement, 50.0));
	rmAddObjectDefConstraint(mediumHunt2ID, avoidHuntable);
	rmAddObjectDefConstraint(mediumHunt2ID, mediumAvoidImpassableLand);
	rmAddObjectDefConstraint(mediumHunt2ID, avoidCliff);

	// Far hunt 1.
	float farHunt1Float = rmRandFloat(0.0, 1.0);

	int farHunt1ID = rmCreateObjectDef("bonus hunt 1");
	if(farHunt1Float < 1.0 / 3.0) {
		rmAddObjectDefItem(farHunt1ID, "Gazelle", rmRandInt(0, 4), 4.0);
		rmAddObjectDefItem(farHunt1ID, "Zebra", rmRandInt(3, 6), 4.0);
	} else if(farHunt1Float < 2.0 / 3.0) {
		rmAddObjectDefItem(farHunt1ID, "Gazelle", rmRandInt(1, 3), 2.0);
		rmAddObjectDefItem(farHunt1ID, "Giraffe", rmRandInt(2, 5), 2.0);
	} else {
		rmAddObjectDefItem(farHunt1ID, "Zebra", rmRandInt(3, 9), 2.0);
	}
	rmAddObjectDefConstraint(farHunt1ID, avoidAll);
	rmAddObjectDefConstraint(farHunt1ID, avoidEdge);
	rmAddObjectDefConstraint(farHunt1ID, avoidCenter);
	rmAddObjectDefConstraint(farHunt1ID, createClassDistConstraint(classStartingSettlement, 50.0));
	rmAddObjectDefConstraint(farHunt1ID, avoidHuntable);
	rmAddObjectDefConstraint(farHunt1ID, mediumAvoidImpassableLand);
	rmAddObjectDefConstraint(farHunt1ID, avoidCliff);

	// Far hunt 2.
	int farHunt2ID = rmCreateObjectDef("bonus hunt 2");
	if(randChance()) {
		rmAddObjectDefItem(farHunt2ID, "Elephant", rmRandInt(1, 2), 2.0);
	} else {
		rmAddObjectDefItem(farHunt2ID, "Rhinocerous", rmRandInt(1, 3), 2.0);
	}
	rmAddObjectDefConstraint(farHunt2ID, avoidAll);
	rmAddObjectDefConstraint(farHunt2ID, avoidEdge);
	rmAddObjectDefConstraint(farHunt2ID, avoidCenter);
	rmAddObjectDefConstraint(farHunt2ID, createClassDistConstraint(classStartingSettlement, 50.0));
	rmAddObjectDefConstraint(farHunt2ID, avoidHuntable);
	rmAddObjectDefConstraint(farHunt2ID, mediumAvoidImpassableLand);
	rmAddObjectDefConstraint(farHunt2ID, avoidCliff);

	// Herdables and predators.
	// Medium herdables.
	int mediumHerdablesID = rmCreateObjectDef("medium herdables");
	rmAddObjectDefItem(mediumHerdablesID, "Pig", rmRandInt(1, 2), 4.0);
	rmAddObjectDefConstraint(mediumHerdablesID, avoidAll);
	rmAddObjectDefConstraint(mediumHerdablesID, avoidEdge);
	rmAddObjectDefConstraint(mediumHerdablesID, avoidCenter);
	rmAddObjectDefConstraint(mediumHerdablesID, createClassDistConstraint(classStartingSettlement, 50.0));
	rmAddObjectDefConstraint(mediumHerdablesID, avoidHerdable);
	rmAddObjectDefConstraint(mediumHerdablesID, avoidTowerLOS);
	rmAddObjectDefConstraint(mediumHerdablesID, shortAvoidImpassableLand);

	// Far herdables.
	int farHerdablesID = rmCreateObjectDef("far herdables");
	rmAddObjectDefItem(farHerdablesID, "Pig", rmRandInt(2, 3), 4.0);
	rmAddObjectDefConstraint(farHerdablesID, avoidAll);
	rmAddObjectDefConstraint(farHerdablesID, avoidEdge);
	rmAddObjectDefConstraint(farHerdablesID, avoidCenter);
	rmAddObjectDefConstraint(farHerdablesID, createClassDistConstraint(classStartingSettlement, 70.0));
	rmAddObjectDefConstraint(farHerdablesID, avoidHerdable);
	rmAddObjectDefConstraint(farHerdablesID, shortAvoidImpassableLand);

	// Far predators.
	int farPredatorsID = rmCreateObjectDef("far predators");
	if(randChance()) {
		rmAddObjectDefItem(farPredatorsID, "Lion", rmRandInt(1, 2), 4.0);
	} else {
		rmAddObjectDefItem(farPredatorsID, "Hyena", 2, 4.0);
	}
	rmAddObjectDefConstraint(farPredatorsID, avoidAll);
	rmAddObjectDefConstraint(farPredatorsID, avoidEdge);
	rmAddObjectDefConstraint(farPredatorsID, avoidCenter);
	rmAddObjectDefConstraint(farPredatorsID, createClassDistConstraint(classStartingSettlement, 80.0));
	rmAddObjectDefConstraint(farPredatorsID, avoidSettlement);
	rmAddObjectDefConstraint(farPredatorsID, avoidPredator);
	rmAddObjectDefConstraint(farPredatorsID, shortAvoidImpassableLand);
	rmAddObjectDefConstraint(farPredatorsID, avoidCliff);

	// Other objects.
	// Random trees.
	int randomTreeID = rmCreateObjectDef("random tree");
	rmAddObjectDefItem(randomTreeID, "Savannah Tree", 1, 0.0);
	setObjectDefDistanceToMax(randomTreeID);
	rmAddObjectDefConstraint(randomTreeID, avoidAll);
	rmAddObjectDefConstraint(randomTreeID, avoidStartingSettlement);
	rmAddObjectDefConstraint(randomTreeID, avoidSettlement);
	rmAddObjectDefConstraint(randomTreeID, mediumAvoidImpassableLand);
	rmAddObjectDefConstraint(randomTreeID, avoidCliff);

	// Relics.
	int relicID = rmCreateObjectDef("relic");
	rmAddObjectDefItem(relicID, "Relic", 1, 0.0);
	rmAddObjectDefConstraint(relicID, avoidAll);
	rmAddObjectDefConstraint(relicID, avoidEdge);
	rmAddObjectDefConstraint(relicID, createClassDistConstraint(classStartingSettlement, 80.0));
	rmAddObjectDefConstraint(relicID, avoidRelic);
	rmAddObjectDefConstraint(relicID, shortAvoidImpassableLand);

	progress(0.1);

	// Set up player areas.
	float playerAreaSize = rmAreaTilesToFraction(1000);

	for(i = 1; < cPlayers) {
		int playerAreaID = rmCreateArea("player area " + i);
		rmSetAreaSize(playerAreaID, 0.9 * playerAreaSize, 1.1 * playerAreaSize);
		rmSetAreaLocPlayer(playerAreaID, getPlayer(i));
		rmSetAreaTerrainType(playerAreaID, "GrassDirt25");
		rmAddAreaTerrainLayer(playerAreaID, "GrassDirt50", 3, 6);
		rmAddAreaTerrainLayer(playerAreaID, "GrassDirt75", 0, 3);
		rmSetAreaMinBlobs(playerAreaID, 1);
		rmSetAreaMaxBlobs(playerAreaID, 3);
		rmSetAreaMinBlobDistance(playerAreaID, 16.0);
		rmSetAreaMaxBlobDistance(playerAreaID, 40.0);
		rmAddAreaToClass(playerAreaID, classPlayer);
		rmAddAreaConstraint(playerAreaID, avoidPlayer);
		rmSetAreaWarnFailure(playerAreaID, false);
	}

	rmBuildAllAreas();

	// TCs.
	placeObjectAtPlayerLocs(startingSettlementID, true);

	// Towers.
	placeAndStoreObjectMirrored(startingTowerID, true, 4, 23.0, 27.0, true, -1, startingTowerBackupID);

	// Beautification.
	int beautificationID = 0;

	for(i = 0; < 25 * cPlayers) {
		beautificationID = rmCreateArea("beautification 1 " + i);
		rmSetAreaTerrainType(beautificationID, "GrassDirt50");
		rmAddAreaTerrainLayer(beautificationID, "GrassDirt75", 0, 2);
		rmSetAreaSize(beautificationID, rmAreaTilesToFraction(75), rmAreaTilesToFraction(150));
		rmSetAreaMinBlobs(beautificationID, 1);
		rmSetAreaMaxBlobs(beautificationID, 5);
		rmSetAreaMinBlobDistance(beautificationID, 16.0);
		rmSetAreaMaxBlobDistance(beautificationID, 40.0);
		rmAddAreaConstraint(beautificationID, avoidPlayer);
		rmAddAreaConstraint(beautificationID, mediumAvoidImpassableLand);
		rmSetAreaWarnFailure(beautificationID, false);
		rmBuildArea(beautificationID);
	}

	progress(0.2);

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

	addFairLoc(60.0, 80.0, false, true, 50.0, 12.0, 12.0);

	// Far settlement.
	addFairLocConstraint(avoidTowerLOS);
	addFairLocConstraint(settlementAvoidCenter);

	if(cNonGaiaPlayers < 3) {
		setFairLocInterDistMin(75.0);
		addFairLoc(65.0, 80.0, true, false, 65.0, 60.0, 60.0);
	} else if (cNonGaiaPlayers < 5) {
		addFairLoc(70.0, 90.0, true, randChance(), 75.0, 50.0, 50.0);
	} else {
		addFairLoc(65.0, 80.0, true, false, 75.0, 60.0, 60.0);
	}

	placeObjectAtNewFairLocs(settlementID, false, "settlements");

	progress(0.3);

	// Forests.
	int classForest = initForestClass();

	addForestConstraint(avoidCenter);
	addForestConstraint(avoidStartingSettlement);
	addForestConstraint(avoidAll);

	addForestType("Savannah Forest", 1.0);

	setForestAvoidSelf(20.0);

	setForestBlobs(9);
	setForestBlobParams(4.5, 4.25);
	setForestCoherence(-0.75, 0.75);

	// Player forests.
	setForestSearchRadius(30.0, 40.0);
	setForestMinRatio(2.0 / 3.0);

	int numPlayerForests = 3;

	buildPlayerForests(numPlayerForests, 0.1);

	progress(0.4);

	int avoidForest = createClassDistConstraint(classForest, 15.0);

	// Cliffs.
	setOuterCliff("CliffEgyptianA", 5.5, 4.0);
	setOuterCliffParams(1.5);

	setInnerCliff("SandA", 5.5, 4.5);
	setInnerCliffParams(4.0);

	setCliffRamp("SandA", 5.5, 4.5);
	setCliffRampParams(4.0);
	setCliffNumRamps(2, 3);

	setCliffBlobs(3, 7);
	setCliffAvoidSelf(40.0);
	setCliffRequiredRatio(1.0);
	setCliffCoherence(-1.0, 0.0);
	setCliffSearchRadius(30.0, -1.0);

	addCliffConstraint(avoidCenter);
	addCliffConstraint(avoidBuildings);
	addCliffConstraint(avoidForest);

	int numCliffs = rmRandInt(3, 4) * cNonGaiaPlayers / 2;

	if(cNonGaiaPlayers == 2) {
		numCliffs = 4;
	}

	buildCliffs(numCliffs, 0.1);

	progress(0.5);

	// Ponds.
	initAreaClass();

	setAreaWaterType("Egyptian Nile", 17.0, 11.0);

	setAreaBlobs(4, 6);
	setAreaAvoidSelf(60.0);
	setAreaCoherence(0.0, 1.0);
	setAreaSearchRadius(50.0, -1.0);

	addAreaConstraint(createClassDistConstraint(classCliff, 20.0));
	addAreaConstraint(createClassDistConstraint(classStartingSettlement, 45.0));
	addAreaConstraint(avoidCenter);
	addAreaConstraint(avoidForest);
	addAreaConstraint(avoidBuildings);

	int numPonds = 1 + cNonGaiaPlayers / 2;

	buildAreas(numPonds, 0.1);

	progress(0.6);

	// Normal forests.
	addForestConstraint(farAvoidImpassableLand); // Additional constraint.

	setForestSearchRadius(20.0, -1.0);

	int numForests = 9 * cNonGaiaPlayers / 2;

	if(cNonGaiaPlayers > 2) {
		setForestMinRatio(0.5);
	}

	buildForests(numForests, 0.2);

	progress(0.8);

	// Object placement.
	// Starting gold close to tower.
	storeObjectDefItem("Gold Mine Small", 1, 0.0);
	storeObjectConstraint(createTypeDistConstraint("Tower", rmRandFloat(8.0, 10.0))); // Don't get too close.
	storeObjectConstraint(avoidAll);
	storeObjectConstraint(avoidEdge);
	storeObjectConstraint(mediumAvoidImpassableLand);
	placeStoredObjectMirroredNearStoredLocs(4, false, 24.0, 25.0, 12.5);

	resetObjectStorage();

	// Medium gold.
	placeObjectMirrored(mediumGoldID, false, rmRandInt(1, 2), 60.0, 80.0);

	// Far gold.
	placeObjectMirrored(bonusGoldID, false, 3, 80.0, 150.0);

	// Close hunt.
	placeObjectMirrored(closeHuntID, false, 1, 20.0, 25.0, true);

	// Medium hunt.
	placeObjectMirrored(mediumHunt1ID, false, 1, 50.0, 70.0);
	placeObjectMirrored(mediumHunt2ID, false, 1, 60.0, 70.0);

	// Bonus hunt.
	placeObjectMirrored(farHunt1ID, false, 1, 70.0, 80.0);
	placeObjectMirrored(farHunt2ID, false, 1, 70.0, 100.0);

	// Starting food.
	placeObjectMirrored(startingFoodID, false, 1, 21.0, 27.0, true);

	// Straggler trees.
	placeObjectMirrored(stragglerTreeID, false, rmRandInt(2, 5), 13.0, 13.5, true);

	// Medium herdables.
	placeObjectMirrored(mediumHerdablesID, false, 1, 50.0, 70.0);

	// Far herdables.
	placeFarObjectMirrored(farHerdablesID);

	// Starting herdables.
	placeObjectMirrored(startingHerdablesID, true, 1, 20.0, 30.0);

	// Far predators.
	placeFarObjectMirrored(farPredatorsID);

	progress(0.9);

	// Small center forest.
	int centerForestID = rmCreateArea("center forest");
	rmSetAreaForestType(centerForestID, "Savannah Forest");
	rmSetAreaSize(centerForestID, areaRadiusMetersToFraction(3.0));
	rmSetAreaLocation(centerForestID, 0.5, 0.5);
	rmSetAreaCoherence(centerForestID, 1.0);
	rmBuildArea(centerForestID);

	// Relics (non mirrored).
	placeObjectInPlayerSplits(relicID);

	// Random trees.
	placeObjectAtPlayerLocs(randomTreeID, false, 10);

	// Embellishment.
	// Rocks.
	int rock1ID = rmCreateObjectDef("rock small");
	rmAddObjectDefItem(rock1ID, "Rock Sandstone Small", 1, 0.0);
	setObjectDefDistanceToMax(rock1ID);
	rmAddObjectDefConstraint(rock1ID, shortAvoidImpassableLand);
	rmPlaceObjectDefAtLoc(rock1ID, 0, 0.5, 0.5, 10 * cNonGaiaPlayers);

	int rock2ID = rmCreateObjectDef("rock sprite");
	rmAddObjectDefItem(rock2ID, "Rock Sandstone Sprite", 1, 0.0);
	setObjectDefDistanceToMax(rock2ID);
	rmAddObjectDefConstraint(rock2ID, embellishmentAvoidAll);
	rmAddObjectDefConstraint(rock2ID, shortAvoidImpassableLand);
	rmPlaceObjectDefAtLoc(rock2ID, 0, 0.5, 0.5, 30 * cNonGaiaPlayers);

	// Bushes.
	int bush1ID = rmCreateObjectDef("bush 1");
	rmAddObjectDefItem(bush1ID, "Bush", 4, 4.0);
	setObjectDefDistanceToMax(bush1ID);
	rmAddObjectDefConstraint(bush1ID, embellishmentAvoidAll);
	rmAddObjectDefConstraint(bush1ID, shortAvoidImpassableLand);
	rmPlaceObjectDefAtLoc(bush1ID, 0, 0.5, 0.5, 10 * cNonGaiaPlayers);

	int bush2ID = rmCreateObjectDef("bush 2");
	rmAddObjectDefItem(bush2ID, "Bush", 3, 2.0);
	rmAddObjectDefItem(bush2ID, "Rock Sandstone Sprite", 1, 2.0);
	setObjectDefDistanceToMax(bush2ID);
	rmAddObjectDefConstraint(bush2ID, embellishmentAvoidAll);
	rmAddObjectDefConstraint(bush2ID, shortAvoidImpassableLand);
	rmPlaceObjectDefAtLoc(bush2ID, 0, 0.5, 0.5, 10 * cNonGaiaPlayers);

	// Grass.
	int grassID = rmCreateObjectDef("grass");
	rmAddObjectDefItem(grassID, "Grass", 1, 0.0);
	setObjectDefDistanceToMax(grassID);
	rmAddObjectDefConstraint(grassID, embellishmentAvoidAll);
	rmAddObjectDefConstraint(grassID, shortAvoidImpassableLand);
	rmPlaceObjectDefAtLoc(grassID, 0, 0.5, 0.5, 30 * cNonGaiaPlayers);

	// Drifts.
	int driftID = rmCreateObjectDef("drift");
	rmAddObjectDefItem(driftID, "Sand Drift Patch", 1, 0.0);
	setObjectDefDistanceToMax(driftID);
	rmAddObjectDefConstraint(driftID, embellishmentAvoidAll);
	rmAddObjectDefConstraint(driftID, avoidEdge);
	rmAddObjectDefConstraint(driftID, shortAvoidImpassableLand);
	rmAddObjectDefConstraint(driftID, avoidBuildings);
	rmAddObjectDefConstraint(driftID, createTypeDistConstraint("Sand Drift Patch", 25.0));
	rmPlaceObjectDefAtLoc(driftID, 0, 0.5, 0.5, 3 * cNonGaiaPlayers);

	// Birds.
	int birdsID = rmCreateObjectDef("birds");
	rmAddObjectDefItem(birdsID, "Vulture", 1, 0.0);
	setObjectDefDistanceToMax(birdsID);
	rmPlaceObjectDefAtLoc(birdsID, 0, 0.5, 0.5, 2 * cNonGaiaPlayers);

	// Finalize RM X.
	rmxFinalize();

	progress(1.0);
}
