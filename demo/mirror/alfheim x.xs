/*
** ALFHEIM MIRROR
** RebelsRising
** Last edit: 09/03/2021
*/

include "rmx.xs";

void main() {
	progress(0.0);

	// Initial map setup.
	rmxInit("Alfheim X");

	// Set mirror mode.
	setMirrorMode(cMirrorPoint);

	// Perform mirror check.
	if(mirrorConfigIsInvalid()) {
		injectMirrorGenError();

		// Invalid configuration, quit.
		return;
	}

	// Set size.
	int mapSize = getStandardMapDimInMeters(7500, 1.0);

	// Initialize map.
	initializeMap("GrassA", mapSize);

	// Set lighting.
	rmSetLightingSet("Alfheim");

	// Place players.
	if(cNonGaiaPlayers < 9) {
		placePlayersInCircle(0.3, 0.4, 0.75);
	} else {
		placePlayersInCircle(0.35, 0.4, 0.9);
	}

	// Initialize areas.
	float centerRadius = 22.5;

	int classCenter = initializeCenter(centerRadius);
	int classCorner = initializeCorners(25.0);

	// Define classes.
	int classStartingSettlement = rmDefineClass("starting settlement");
	int classCliff = rmDefineClass("cliff");

	// Define global constraints.
	// General.
	int avoidAll = createTypeDistConstraint("All", 7.0);
	int avoidEdge = createSymmetricBoxConstraint(rmXTilesToFraction(4), rmZTilesToFraction(4));
	int avoidCenter = createClassDistConstraint(classCenter, 1.0);
	int avoidCorner = createClassDistConstraint(classCorner, 1.0);

	// Terrain.
	int avoidCliff = createTerrainDistConstraint("Land", false, 6.0);

	// Settlements.
	int avoidStartingSettlement = createClassDistConstraint(classStartingSettlement, 20.0);
	int avoidSettlement = createTypeDistConstraint("AbstractSettlement", 15.0);
	int goldAvoidSettlement = createTypeDistConstraint("AbstractSettlement", 20.0);

	// Gold.
	int shortAvoidGold = createTypeDistConstraint("Gold", 10.0);
	int farAvoidGold = createTypeDistConstraint("Gold", 30.0);

	// Food.
	int avoidFood = createTypeDistConstraint("Food", 20.0);
	int avoidHuntable = createTypeDistConstraint("Huntable", 40.0);
	int avoidHerdable = createTypeDistConstraint("Herdable", 30.0);
	int avoidPredator = createTypeDistConstraint("AnimalPredator", 40.0);

	// Relics.
	int avoidRelic = createTypeDistConstraint("Relic", 60.0);

	// Buildings.
	int avoidTowerLOS = createTypeDistConstraint("Tower", 35.0);
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
	// Prefer smaller numbers for randomizing.
	if(randChance(0.75)) {
		rmAddObjectDefItem(closeHuntID, "Elk", rmRandInt(3, 5), 2.0);
	} else {
		rmAddObjectDefItem(closeHuntID, "Elk", 2, 2.0);
	}
	rmAddObjectDefConstraint(closeHuntID, avoidAll);
	rmAddObjectDefConstraint(closeHuntID, avoidEdge);
	rmAddObjectDefConstraint(closeHuntID, avoidFood);
	rmAddObjectDefConstraint(closeHuntID, shortAvoidGold);
	rmAddObjectDefConstraint(closeHuntID, avoidCliff);

	// Starting food.
	int numStartingFood = rmRandInt(6, 10);

	// Starting berries.
	int startingBerriesID = rmCreateObjectDef("starting berries");
	rmAddObjectDefItem(startingBerriesID, "Berry Bush", numStartingFood, 4.0);
	rmAddObjectDefConstraint(startingBerriesID, avoidAll);
	rmAddObjectDefConstraint(startingBerriesID, avoidEdge);
	rmAddObjectDefConstraint(startingBerriesID, avoidFood);
	rmAddObjectDefConstraint(startingBerriesID, shortAvoidGold);
	rmAddObjectDefConstraint(startingBerriesID, avoidCliff);

	// Starting chicken.
	int startingChickenID = rmCreateObjectDef("starting chicken");
	rmAddObjectDefItem(startingChickenID, "Chicken", numStartingFood, 4.0);
	rmAddObjectDefConstraint(startingChickenID, avoidAll);
	rmAddObjectDefConstraint(startingChickenID, avoidEdge);
	rmAddObjectDefConstraint(startingChickenID, avoidFood);
	rmAddObjectDefConstraint(startingChickenID, shortAvoidGold);
	rmAddObjectDefConstraint(startingChickenID, avoidCliff);

	// Starting herdables.
	int startingHerdablesID = rmCreateObjectDef("starting herdables");
	rmAddObjectDefItem(startingHerdablesID, "Cow", rmRandInt(2, 4), 2.0);
	rmAddObjectDefConstraint(startingHerdablesID, avoidAll);
	rmAddObjectDefConstraint(startingHerdablesID, avoidEdge);
	rmAddObjectDefConstraint(startingHerdablesID, avoidCliff);

	// Straggler trees.
	int stragglerTreeID = rmCreateObjectDef("straggler tree");
	rmAddObjectDefItem(stragglerTreeID, "Pine", 1, 0.0);
	rmAddObjectDefConstraint(stragglerTreeID, avoidAll);
	rmAddObjectDefConstraint(stragglerTreeID, avoidCliff);

	// Gold.
	// Medium gold.
	int mediumGoldID = rmCreateObjectDef("medium gold");
	rmAddObjectDefItem(mediumGoldID, "Gold Mine", 1, 0.0);
	rmAddObjectDefConstraint(mediumGoldID, avoidAll);
	rmAddObjectDefConstraint(mediumGoldID, avoidEdge);
	rmAddObjectDefConstraint(mediumGoldID, avoidCenter);
	rmAddObjectDefConstraint(mediumGoldID, avoidCorner);
	rmAddObjectDefConstraint(mediumGoldID, createClassDistConstraint(classStartingSettlement, 50.0));
	rmAddObjectDefConstraint(mediumGoldID, goldAvoidSettlement);
	rmAddObjectDefConstraint(mediumGoldID, farAvoidGold);
	rmAddObjectDefConstraint(mediumGoldID, avoidCliff);

	// Bonus gold.
	int bonusGoldID = rmCreateObjectDef("bonus gold");
	rmAddObjectDefItem(bonusGoldID, "Gold Mine", 1, 0.0);
	rmAddObjectDefConstraint(bonusGoldID, avoidAll);
	rmAddObjectDefConstraint(bonusGoldID, avoidEdge);
	rmAddObjectDefConstraint(bonusGoldID, avoidCenter);
	rmAddObjectDefConstraint(bonusGoldID, createClassDistConstraint(classStartingSettlement, 80.0));
	rmAddObjectDefConstraint(bonusGoldID, goldAvoidSettlement);
	rmAddObjectDefConstraint(bonusGoldID, farAvoidGold);
	rmAddObjectDefConstraint(bonusGoldID, avoidCliff);

	// Hunt.
	// Medium hunt.
	int mediumHuntID = rmCreateObjectDef("medium hunt");
	rmAddObjectDefItem(mediumHuntID, "Deer", rmRandInt(2, 8), 2.0);
	rmAddObjectDefConstraint(mediumHuntID, avoidAll);
	rmAddObjectDefConstraint(mediumHuntID, avoidEdge);
	rmAddObjectDefConstraint(mediumHuntID, avoidCenter);
	rmAddObjectDefConstraint(mediumHuntID, createClassDistConstraint(classStartingSettlement, 60.0));
	rmAddObjectDefConstraint(mediumHuntID, avoidHuntable);
	rmAddObjectDefConstraint(mediumHuntID, avoidCliff);

	// Bonus hunt.
	float bonusHuntFloat = rmRandFloat(0.0, 1.0);

	int bonusHuntID = rmCreateObjectDef("bonus hunt");
	if(bonusHuntFloat < 1.0 / 3.0) {
		rmAddObjectDefItem(bonusHuntID, "Elk", rmRandInt(2, 8), 2.0);
	} else if(bonusHuntFloat < 2.0 / 3.0) {
		rmAddObjectDefItem(bonusHuntID, "Caribou", rmRandInt(2, 6), 2.0);
	} else {
		rmAddObjectDefItem(bonusHuntID, "Aurochs", rmRandInt(2, 3), 2.0);
	}
	rmAddObjectDefConstraint(bonusHuntID, avoidAll);
	rmAddObjectDefConstraint(bonusHuntID, avoidEdge);
	rmAddObjectDefConstraint(bonusHuntID, avoidCenter);
	rmAddObjectDefConstraint(bonusHuntID, createClassDistConstraint(classStartingSettlement, 50.0));
	rmAddObjectDefConstraint(bonusHuntID, avoidHuntable);
	rmAddObjectDefConstraint(bonusHuntID, avoidCliff);

	// Herdables and predators.
	// Medium herdables.
	int mediumHerdablesID = rmCreateObjectDef("medium herdables");
	rmAddObjectDefItem(mediumHerdablesID, "Cow", rmRandInt(1, 2), 4.0);
	rmAddObjectDefConstraint(mediumHerdablesID, avoidAll);
	rmAddObjectDefConstraint(mediumHerdablesID, avoidEdge);
	rmAddObjectDefConstraint(mediumHerdablesID, avoidCenter);
	rmAddObjectDefConstraint(mediumHerdablesID, createClassDistConstraint(classStartingSettlement, 50.0));
	rmAddObjectDefConstraint(mediumHerdablesID, avoidHerdable);
	rmAddObjectDefConstraint(mediumHerdablesID, avoidTowerLOS);
	rmAddObjectDefConstraint(mediumHerdablesID, avoidCliff);

	// Far herdables.
	int farHerdablesID = rmCreateObjectDef("far herdables");
	rmAddObjectDefItem(farHerdablesID, "Cow", rmRandInt(1, 2), 4.0);
	rmAddObjectDefConstraint(farHerdablesID, avoidAll);
	rmAddObjectDefConstraint(farHerdablesID, avoidEdge);
	rmAddObjectDefConstraint(farHerdablesID, avoidCenter);
	rmAddObjectDefConstraint(farHerdablesID, createClassDistConstraint(classStartingSettlement, 70.0));
	rmAddObjectDefConstraint(farHerdablesID, avoidHerdable);
	rmAddObjectDefConstraint(farHerdablesID, avoidCliff);

	// Far predators.
	int farPredatorsID = rmCreateObjectDef("far predators");
	if(randChance()) {
		rmAddObjectDefItem(farPredatorsID, "Wolf", rmRandInt(1, 2), 4.0);
	} else {
		rmAddObjectDefItem(farPredatorsID, "Bear", 2, 4.0);
	}
	rmAddObjectDefConstraint(farPredatorsID, avoidAll);
	rmAddObjectDefConstraint(farPredatorsID, avoidEdge);
	rmAddObjectDefConstraint(farPredatorsID, avoidCenter);
	rmAddObjectDefConstraint(farPredatorsID, createClassDistConstraint(classStartingSettlement, 80.0));
	rmAddObjectDefConstraint(farPredatorsID, avoidSettlement);
	rmAddObjectDefConstraint(farPredatorsID, avoidPredator);
	rmAddObjectDefConstraint(farPredatorsID, avoidCliff);

	// Other objects.
	// Random trees.
	int randomTreeID = rmCreateObjectDef("random tree");
	rmAddObjectDefItem(randomTreeID, "Pine", 1, 0.0);
	setObjectDefDistanceToMax(randomTreeID);
	rmAddObjectDefConstraint(randomTreeID, avoidAll);
	rmAddObjectDefConstraint(randomTreeID, avoidStartingSettlement);
	rmAddObjectDefConstraint(randomTreeID, avoidSettlement);
	rmAddObjectDefConstraint(randomTreeID, avoidCliff);

	progress(0.1);

	// Set up player areas.
	float playerAreaSize = rmAreaTilesToFraction(4000);

	for(i = 1; < cPlayers) {
		int playerAreaID = rmCreateArea("player area " + i);
		rmSetAreaSize(playerAreaID, 0.9 * playerAreaSize, 1.1 * playerAreaSize);
		rmSetAreaLocPlayer(playerAreaID, getPlayer(i));
		rmSetAreaTerrainType(playerAreaID, "GrassDirt50");
		rmAddAreaTerrainLayer(playerAreaID, "GrassDirt25", 8, 20);
		rmSetAreaMinBlobs(playerAreaID, 1);
		rmSetAreaMaxBlobs(playerAreaID, 5);
		rmSetAreaMinBlobDistance(playerAreaID, 16.0);
		rmSetAreaMaxBlobDistance(playerAreaID, 40.0);
		rmSetAreaWarnFailure(playerAreaID, false);
	}

	rmBuildAllAreas();

	// TCs.
	placeObjectAtPlayerLocs(startingSettlementID, true);

	// Towers.
	placeAndStoreObjectMirrored(startingTowerID, true, 4, 23.0, 27.0, true, -1, startingTowerBackupID);

	// Beautification.
	int beautificationID = 0;

	for(i = 1; < cPlayers) {
		beautificationID = rmCreateArea("beautification 1 " + i, rmAreaID("player area " + i));
		rmSetAreaTerrainType(beautificationID, "GrassDirt25");
		rmSetAreaSize(beautificationID, rmAreaTilesToFraction(200), rmAreaTilesToFraction(300));
		rmSetAreaMinBlobs(beautificationID, 1);
		rmSetAreaMaxBlobs(beautificationID, 5);
		rmSetAreaMinBlobDistance(beautificationID, 16.0);
		rmSetAreaMaxBlobDistance(beautificationID, 40.0);
		rmSetAreaWarnFailure(beautificationID, false);
		rmBuildArea(beautificationID);
	}

	for(i = 0; < 20 * cNonGaiaPlayers) {
		beautificationID = rmCreateArea("beautification 2 " + i);
		rmSetAreaTerrainType(beautificationID, "GrassB");
		rmSetAreaSize(beautificationID, rmAreaTilesToFraction(5), rmAreaTilesToFraction(20));
		rmSetAreaMinBlobs(beautificationID, 1);
		rmSetAreaMaxBlobs(beautificationID, 5);
		rmSetAreaMinBlobDistance(beautificationID, 16.0);
		rmSetAreaMaxBlobDistance(beautificationID, 40.0);
		rmSetAreaWarnFailure(beautificationID, false);
		rmBuildArea(beautificationID);
	}

	for(i = 0; < 20 * cNonGaiaPlayers) {
		beautificationID = rmCreateArea("beautification 3 " + i);
		rmSetAreaTerrainType(beautificationID, "GrassDirt50");
		rmSetAreaSize(beautificationID, rmAreaTilesToFraction(5), rmAreaTilesToFraction(20));
		rmSetAreaMinBlobs(beautificationID, 1);
		rmSetAreaMaxBlobs(beautificationID, 5);
		rmSetAreaMinBlobDistance(beautificationID, 16.0);
		rmSetAreaMaxBlobDistance(beautificationID, 40.0);
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

	addFairLocConstraint(settlementAvoidCenter);

	addFairLoc(60.0, 80.0, false, true, 50.0, 12.0, 12.0);

	placeObjectAtNewFairLocs(settlementID, false, "close settlement");

	// Far settlement.
	addFairLocConstraint(settlementAvoidCenter);
	addFairLocConstraint(avoidTowerLOS);
	addFairLocConstraint(createTypeDistConstraint("AbstractSettlement", 60.0));

	if(cNonGaiaPlayers < 3) {
		addFairLoc(60.0, 100.0, true, false, 65.0, 12.0, 12.0);
	} else {
		addFairLoc(60.0, 100.0, true, false, 75.0, 30.0, 30.0, false, randChance());
	}

	placeObjectAtNewFairLocs(settlementID, false, "far settlement");

	progress(0.3);

	// Cliffs.
	int numCliffs = rmRandInt(3, 4) * cNonGaiaPlayers / 2;
	initCliffClass();

	setInnerCliff("CliffGreekA", 7.0, 7.0, "Greek");
	setInnerCliffParams(5.0);

	setCliffAvoidSelf(50.0);
	setCliffEnforceConstraints(true);

	setCliffBlobs(4, 9);
	setCliffCoherence(-0.5, 0.5);
	setCliffSearchRadius(25.0, -1.0);
	setCliffRequiredRatio(0.5);
	setCliffNumRamps(0);

	// Avoid center by a bit more for cliffs.
	addCliffConstraint(createClassDistConstraint(classCenter, 2.5));
	addCliffConstraint(createTypeDistConstraint("Building", 12.5));
	addCliffConstraint(avoidStartingSettlement);
	addCliffConstraint(avoidAll);

	buildCliffs(numCliffs, 0.1);

	progress(0.4);

	// Forest.
	initForestClass();

	addForestConstraint(avoidCenter);
	addForestConstraint(avoidStartingSettlement);
	addForestConstraint(avoidAll);
	addForestConstraint(avoidCliff);

	addForestType("Pine Forest", 1.0);
	setForestAvoidSelf(20.0);

	setForestBlobs(9);
	setForestBlobParams(4.625, 4.25);
	setForestCoherence(-0.75, 0.75);

	// Player forests.
	setForestSearchRadius(30.0, 40.0);
	setForestMinRatio(2.0 / 3.0);

	int numPlayerForests = 2;

	buildPlayerForests(numPlayerForests, 0.1);

	progress(0.5);

	// Normal forests.
	setForestSearchRadius(20.0, -1.0);
	setForestMinRatio(2.0 / 3.0);

	int numForests = 9 * cNonGaiaPlayers / 2;

	buildForests(numForests, 0.3);

	progress(0.8);

	// Object placement.
	// Starting gold close to tower.
	storeObjectDefItem("Gold Mine Small", 1, 0.0);
	storeObjectConstraint(createTypeDistConstraint("Tower", rmRandFloat(8.0, 10.0))); // Don't get too close.
	storeObjectConstraint(avoidAll);
	storeObjectConstraint(avoidEdge);
	storeObjectConstraint(avoidCliff);
	placeStoredObjectMirroredNearStoredLocs(4, false, 24.0, 25.0, 12.5);

	resetObjectStorage();

	// Medium gold.
	placeObjectMirrored(mediumGoldID, false, rmRandInt(1, 2), 50.0, 60.0);

	// Far gold.
	placeFarObjectMirrored(bonusGoldID, false, rmRandInt(3, 4));

	// Close hunt.
	if(randChance(0.9)) {
		placeObjectMirrored(closeHuntID, false, 1, 30.0, 50.0);
	} else {
		placeObjectMirrored(closeHuntID, false, rmRandInt(3, 6), 30.0, 50.0);
	}

	// Medium hunt.
	placeObjectMirrored(mediumHuntID, false, 1, 60.0, 80.0);

	// Bonus hunt.
	placeFarObjectMirrored(bonusHuntID, false, rmRandInt(1, 2));

	// Close food.
	placeObjectMirrored(startingChickenID, false, 1, 21.0, 27.0, true);
	placeObjectMirrored(startingBerriesID, false, 1, 21.0, 27.0, true);

	// Straggler trees.
	placeObjectMirrored(stragglerTreeID, false, rmRandInt(2, 5), 13.0, 13.5, true);

	// Medium herdables.
	placeObjectMirrored(mediumHerdablesID, false, 1, 50.0, 70.0);

	// Far herdables.
	placeFarObjectMirrored(farHerdablesID, false, rmRandInt(1, 2));

	// Starting herdables.
	placeObjectMirrored(startingHerdablesID, true, 1, 20.0, 30.0);

	// Far predators.
	placeFarObjectMirrored(farPredatorsID);

	progress(0.9);

	// Small center forest.
	int centerForestID = rmCreateArea("center forest");
	rmSetAreaForestType(centerForestID, "Pine Forest");
	rmSetAreaSize(centerForestID, areaRadiusMetersToFraction(3.0));
	rmSetAreaLocation(centerForestID, 0.5, 0.5);
	rmSetAreaCoherence(centerForestID, 1.0);
	rmBuildArea(centerForestID);

	// Relics (non-mirrored).
	initializeSplit(); // Initialize split because we need it here.

	int relicsAvoidStartingSettlement = createClassDistConstraint(classStartingSettlement, 50.0);

	for(i = 1; < cPlayers) {
		for(j = 0; < 2) {
			int ruinID = rmCreateArea("ruins " + i + " " + j, rmAreaID(cSplitName + " " + i));
			rmSetAreaSize(ruinID, rmAreaTilesToFraction(120), rmAreaTilesToFraction(180));
			rmSetAreaTerrainType(ruinID, "GreekRoadA");
			rmAddAreaTerrainLayer(ruinID, "GrassDirt25", 0, 1);
			rmSetAreaCoherence(ruinID, 0.8);
			rmSetAreaMinBlobs(ruinID, 1);
			rmSetAreaMaxBlobs(ruinID, 4);
			rmSetAreaMinBlobDistance(ruinID, 16.0);
			rmSetAreaMaxBlobDistance(ruinID, 40.0);
			rmAddAreaConstraint(ruinID, avoidAll);
			rmAddAreaConstraint(ruinID, avoidEdge);
			rmAddAreaConstraint(ruinID, avoidCliff);
			rmAddAreaConstraint(ruinID, relicsAvoidStartingSettlement);
			rmAddAreaConstraint(ruinID, avoidRelic);
			rmSetAreaWarnFailure(ruinID, false);
			rmBuildArea(ruinID);

			int stayInRuins = rmCreateEdgeDistanceConstraint("stay in ruins " + i + " " + j, ruinID, 1.0);

			int decorationID = rmCreateObjectDef("decoration " + i + " " + j);
			rmAddObjectDefItem(decorationID, "Rock Limestone Small", rmRandInt(2, 4), 4.0);
			rmAddObjectDefItem(decorationID, "Rock Limestone Sprite", rmRandInt(8, 12), 6.0);
			rmAddObjectDefItem(decorationID, "Grass", rmRandFloat(4, 8), 4.0);
			rmPlaceObjectDefInArea(decorationID, 0, ruinID);

			int relicID = rmCreateObjectDef("relics " + i + " " + j);
			rmAddObjectDefItem(relicID, "Relic", 1, 1.0);
			rmSetObjectDefMinDistance(relicID, 0.0);
			rmSetObjectDefMaxDistance(relicID, 0.0);
			rmAddObjectDefConstraint(relicID, stayInRuins);
			rmPlaceObjectDefInArea(relicID, 0, ruinID);

			if(rmGetNumberUnitsPlaced(relicID) < 1) {
				int backupRelicID = rmCreateObjectDef("backup relics " + i + " " + j);
				rmAddObjectDefItem(backupRelicID, "Relic", 1, 1.0);
				rmAddObjectDefConstraint(backupRelicID, avoidAll);
				rmAddObjectDefConstraint(backupRelicID, avoidEdge);
				rmAddObjectDefConstraint(backupRelicID, avoidCliff);
				rmAddObjectDefConstraint(backupRelicID, relicsAvoidStartingSettlement);
				rmAddObjectDefConstraint(backupRelicID, avoidRelic);
				rmPlaceObjectDefInArea(backupRelicID, 0, rmAreaID(cSplitName + " " + i));
			}
		}
	}

	// Random trees.
	placeObjectAtPlayerLocs(randomTreeID, false, 20);

	// Embellishment.
	// Rocks.
	int rockID = rmCreateObjectDef("rocks");
	rmAddObjectDefItem(rockID, "Rock Limestone Sprite", 1, 0.0);
	setObjectDefDistanceToMax(rockID);
	rmAddObjectDefConstraint(rockID, embellishmentAvoidAll);
	rmAddObjectDefConstraint(rockID, avoidCliff);
	rmPlaceObjectDefAtLoc(rockID, 0, 0.5, 0.5, 50 * cNonGaiaPlayers);

	// Logs.
	int logID = rmCreateObjectDef("logs");
	rmAddObjectDefItem(logID, "Rotting Log", 1, 0.0);
	setObjectDefDistanceToMax(logID);
	rmAddObjectDefConstraint(logID, embellishmentAvoidAll);
	rmAddObjectDefConstraint(logID, avoidCliff);
	rmAddObjectDefConstraint(logID, avoidTowerLOS);
	rmPlaceObjectDefAtLoc(logID, 0, 0.5, 0.5, 5 * cNonGaiaPlayers);

	// Birds.
	int birdsID = rmCreateObjectDef("birds");
	rmAddObjectDefItem(birdsID, "Hawk", 1, 0.0);
	setObjectDefDistanceToMax(birdsID);
	rmPlaceObjectDefAtLoc(birdsID, 0, 0.5, 0.5, 2 * cNonGaiaPlayers);

	// Finalize RM X.
	rmxFinalize();

	progress(1.0);
}
