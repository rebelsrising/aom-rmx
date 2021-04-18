/*
** MEDITERRANEAN MIRROR
** RebelsRising
** Last edit: 09/03/2021
*/

include "rmx.xs";

void main() {
	progress(0.0);

	// Initial map setup.
	rmxInit("Mediterranean X");

	// Set size.
	int mapSize = getStandardMapDimInMeters(8250);

	// Set mirror mode.
	setMirrorMode(cMirrorPoint);

	// Perform mirror check.
	if(mirrorConfigIsInvalid()) {
		injectMirrorGenError();

		// Invalid configuration, quit.
		return;
	}

	// Initialize map.
	initializeMap("GrassDirt25", mapSize);

	// Place players.
	if(cNonGaiaPlayers < 7) {
		placePlayersInCircle(0.385, 0.4, 0.825);
	} else {
		float offset = 0.01 * (cNonGaiaPlayers / 2 - 4);
		placePlayersInCircle(0.4 + offset, 0.4 + offset, 0.9);
	}

	// Initialize areas.
	int classCenter = initializeCenter(15.0);
	int classCorner = initializeCorners(25.0);

	// Define classes.
	int classStartingSettlement = rmDefineClass("starting settlement");
	int classPlayer = rmDefineClass("player");

	// Define global constraints.
	// General.
	int avoidAll = createTypeDistConstraint("All", 7.0);
	int avoidEdge = createSymmetricBoxConstraint(rmXTilesToFraction(4), rmZTilesToFraction(4));
	int avoidCenter = createClassDistConstraint(classCenter, 1.0);
	int avoidCorner = createClassDistConstraint(classCorner, 1.0);
	int avoidPlayer = createClassDistConstraint(classPlayer, 30.0);

	// Terrain.
	int avoidWater = createTerrainDistConstraint("Land", false, 10.0);

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
	int avoidRelic = createTypeDistConstraint("Relic", 80.0);

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
	if(randChance(0.7)) {
		rmAddObjectDefItem(closeHuntID, "Boar", rmRandInt(1, 3), 2.0);
	} else {
		rmAddObjectDefItem(closeHuntID, "Aurochs", rmRandInt(1, 2), 2.0);
	}
	rmAddObjectDefConstraint(closeHuntID, avoidAll);
	rmAddObjectDefConstraint(closeHuntID, avoidEdge);
	rmAddObjectDefConstraint(closeHuntID, avoidWater);

	// Starting food.
	int startingFoodID = rmCreateObjectDef("starting food");
	if(randChance(0.8)) {
		rmAddObjectDefItem(startingFoodID, "Chicken", rmRandInt(6, 10), 4.0);
	} else {
		rmAddObjectDefItem(startingFoodID, "Berry Bush", rmRandInt(4, 6), 2.0);
	}
	rmAddObjectDefConstraint(startingFoodID, avoidAll);
	rmAddObjectDefConstraint(startingFoodID, avoidEdge);
	rmAddObjectDefConstraint(startingFoodID, shortAvoidGold);
	rmAddObjectDefConstraint(startingFoodID, avoidFood);

	// Starting herdables.
	int startingHerdablesID = rmCreateObjectDef("starting herdables");
	rmAddObjectDefItem(startingHerdablesID, "Pig", rmRandInt(2, 4), 2.0);
	rmAddObjectDefConstraint(startingHerdablesID, avoidAll);
	rmAddObjectDefConstraint(startingHerdablesID, avoidEdge);

	// Straggler trees.
	int stragglerTreeID = rmCreateObjectDef("straggler tree");
	rmAddObjectDefItem(stragglerTreeID, "Oak Tree", 1, 0.0);
	rmAddObjectDefConstraint(stragglerTreeID, avoidAll);

	// Gold.
	// Medium gold.
	int mediumGoldID = rmCreateObjectDef("medium gold");
	rmAddObjectDefItem(mediumGoldID, "Gold Mine", 1, 0.0);
	rmAddObjectDefConstraint(mediumGoldID, avoidAll);
	rmAddObjectDefConstraint(mediumGoldID, avoidEdge);
	rmAddObjectDefConstraint(mediumGoldID, avoidCorner);
	rmAddObjectDefConstraint(mediumGoldID, createClassDistConstraint(classStartingSettlement, 50.0));
	rmAddObjectDefConstraint(mediumGoldID, goldAvoidSettlement);
	rmAddObjectDefConstraint(mediumGoldID, farAvoidGold);
	rmAddObjectDefConstraint(mediumGoldID, avoidWater);

	// Bonus gold.
	int bonusGoldID = rmCreateObjectDef("bonus gold");
	rmAddObjectDefItem(bonusGoldID, "Gold Mine", 1, 0.0);
	rmAddObjectDefConstraint(bonusGoldID, avoidAll);
	rmAddObjectDefConstraint(bonusGoldID, avoidEdge);
	rmAddObjectDefConstraint(bonusGoldID, createClassDistConstraint(classStartingSettlement, 70.0));
	rmAddObjectDefConstraint(bonusGoldID, goldAvoidSettlement);
	rmAddObjectDefConstraint(bonusGoldID, farAvoidGold);
	rmAddObjectDefConstraint(bonusGoldID, avoidWater);

	// Food.
	// Bonus huntable.
	float bonusHuntFloat = rmRandFloat(0.0, 1.0);

	int bonusHuntID = rmCreateObjectDef("bonus hunt");
	if(bonusHuntFloat < 0.5) {
		rmAddObjectDefItem(bonusHuntID, "Boar", rmRandInt(2, 3), 2.0);
	} else if(bonusHuntFloat < 0.8) {
		rmAddObjectDefItem(bonusHuntID, "Deer", rmRandInt(2, 5), 2.0);
	} else {
		rmAddObjectDefItem(bonusHuntID, "Aurochs", rmRandInt(1, 3), 2.0);
	}
	rmAddObjectDefConstraint(bonusHuntID, avoidAll);
	rmAddObjectDefConstraint(bonusHuntID, avoidEdge);
	rmAddObjectDefConstraint(bonusHuntID, createClassDistConstraint(classStartingSettlement, 50.0));
	rmAddObjectDefConstraint(bonusHuntID, avoidHuntable);
	rmAddObjectDefConstraint(bonusHuntID, avoidWater);

	// Medium herdables.
	int mediumHerdablesID = rmCreateObjectDef("medium herdables");
	rmAddObjectDefItem(mediumHerdablesID, "Pig", 2, 4.0);
	rmAddObjectDefConstraint(mediumHerdablesID, avoidAll);
	rmAddObjectDefConstraint(mediumHerdablesID, avoidEdge);
	rmAddObjectDefConstraint(mediumHerdablesID, createClassDistConstraint(classStartingSettlement, 50.0));
	rmAddObjectDefConstraint(mediumHerdablesID, avoidHerdable);
	rmAddObjectDefConstraint(mediumHerdablesID, avoidTowerLOS);
	rmAddObjectDefConstraint(mediumHerdablesID, avoidWater);

	// Far herdables.
	int farHerdablesID = rmCreateObjectDef("far herdables");
	rmAddObjectDefItem(farHerdablesID, "Pig", 2, 4.0);
	rmAddObjectDefConstraint(farHerdablesID, avoidAll);
	rmAddObjectDefConstraint(farHerdablesID, avoidEdge);
	rmAddObjectDefConstraint(farHerdablesID, createClassDistConstraint(classStartingSettlement, 70.0));
	rmAddObjectDefConstraint(farHerdablesID, avoidHerdable);
	rmAddObjectDefConstraint(farHerdablesID, avoidWater);

	// Far predators.
	int farPredatorsID = rmCreateObjectDef("far predators");
	if(randChance()) {
		rmAddObjectDefItem(farPredatorsID, "Lion", 2, 4.0);
	} else {
		rmAddObjectDefItem(farPredatorsID, "Bear", 1, 4.0);
	}
	rmAddObjectDefConstraint(farPredatorsID, avoidAll);
	rmAddObjectDefConstraint(farPredatorsID, avoidEdge);
	rmAddObjectDefConstraint(farPredatorsID, createClassDistConstraint(classStartingSettlement, 80.0));
	rmAddObjectDefConstraint(farPredatorsID, avoidSettlement);
	rmAddObjectDefConstraint(farPredatorsID, avoidPredator);
	rmAddObjectDefConstraint(farPredatorsID, avoidWater);

	// Far berries.
	int farBerriesID = rmCreateObjectDef("far berries");
	rmAddObjectDefItem(farBerriesID, "Berry Bush", rmRandInt(4, 10), 4.0);
	rmAddObjectDefConstraint(farBerriesID, avoidAll);
	rmAddObjectDefConstraint(farBerriesID, avoidEdge);
	rmAddObjectDefConstraint(farBerriesID, createClassDistConstraint(classStartingSettlement, 70.0));
	rmAddObjectDefConstraint(farBerriesID, avoidSettlement);
	rmAddObjectDefConstraint(farBerriesID, avoidFood);
	rmAddObjectDefConstraint(farBerriesID, avoidWater);

	// Other objects.
	// Random trees.
	int randomTreeID = rmCreateObjectDef("random tree");
	rmAddObjectDefItem(randomTreeID, "Oak Tree", 1, 0.0);
	setObjectDefDistanceToMax(randomTreeID);
	rmAddObjectDefConstraint(randomTreeID, avoidAll);
	rmAddObjectDefConstraint(randomTreeID, avoidStartingSettlement);
	rmAddObjectDefConstraint(randomTreeID, avoidSettlement);
	rmAddObjectDefConstraint(randomTreeID, avoidWater);

	// Relics.
	int relicID = rmCreateObjectDef("relic");
	rmAddObjectDefItem(relicID, "Relic", 1, 0.0);
	rmAddObjectDefConstraint(relicID, avoidAll);
	rmAddObjectDefConstraint(relicID, avoidEdge);
	rmAddObjectDefConstraint(relicID, createClassDistConstraint(classStartingSettlement, 80.0));
	rmAddObjectDefConstraint(relicID, avoidRelic);
	rmAddObjectDefConstraint(relicID, avoidWater);

	progress(0.1);

	// Create mediterranean sea.
	float seaEdgeDist = rmXMetersToFraction(40.0);

	int seaID = rmCreateArea("sea");
	rmSetAreaSize(seaID, 0.25 + 0.02 * cNonGaiaPlayers);
	rmSetAreaLocation(seaID, 0.5, 0.5);
	rmSetAreaWaterType(seaID, "Mediterranean Sea");
	rmSetAreaCoherence(seaID, 1.0);
	rmSetAreaBaseHeight(seaID, 2.0);
	rmAddAreaConstraint(seaID, createSymmetricBoxConstraint(seaEdgeDist, seaEdgeDist));
	rmSetAreaWarnFailure(seaID, false);
	rmBuildArea(seaID);

	// Set up player areas.
	float playerAreaSize = rmRandFloat(0.9, 1.1) * rmAreaTilesToFraction(2100 + min(200 * cNonGaiaPlayers, 1200));

	for(i = 1; < cPlayers) {
		int playerAreaID = rmCreateArea("player area " + i);
		rmSetAreaSize(playerAreaID, playerAreaSize);
		rmSetAreaLocPlayer(playerAreaID, getPlayer(i));
		rmSetAreaTerrainType(playerAreaID, "GrassA");
		rmSetAreaCoherence(playerAreaID, 1.0);
		rmSetAreaBaseHeight(playerAreaID, 2.0);
		rmSetAreaHeightBlend(playerAreaID, 2);
		rmAddAreaToClass(playerAreaID, classPlayer);
		rmAddAreaConstraint(playerAreaID, avoidPlayer);
		rmSetAreaWarnFailure(playerAreaID, false);
	}

	rmBuildAllAreas();

	// Rebuild center (sea).
	int fakeCenterID = rmCreateArea("fake center");
	rmSetAreaLocation(fakeCenterID, 0.5, 0.5);
	rmSetAreaSize(fakeCenterID, 1.0, 1.0);
	rmSetAreaCoherence(fakeCenterID, 1.0);
	rmAddAreaConstraint(fakeCenterID, createTerrainDistConstraint("Land", true, 1.0));
	rmSetAreaWarnFailure(fakeCenterID, false);
	rmBuildArea(fakeCenterID);

	// TCs.
	placeObjectAtPlayerLocs(startingSettlementID, true);

	// Towers.
	placeAndStoreObjectMirrored(startingTowerID, true, 4, 23.0, 27.0, true, -1, startingTowerBackupID);

	// Beautification.
	int beautificationID = 0;

	for(i = 1; < cPlayers) {
		beautificationID = rmCreateArea("player area beautification " + i, rmAreaID("player area " + i));
		rmSetAreaSize(beautificationID, rmAreaTilesToFraction(400), rmAreaTilesToFraction(600));
		rmSetAreaLocPlayer(beautificationID, getPlayer(i));
		rmSetAreaTerrainType(beautificationID, "GrassDirt50");
		rmSetAreaMinBlobs(beautificationID, 1);
		rmSetAreaMaxBlobs(beautificationID, 5);
		rmSetAreaMinBlobDistance(beautificationID, 16.0);
		rmSetAreaMaxBlobDistance(beautificationID, 40.0);
		rmAddAreaConstraint(beautificationID, avoidWater);
		rmSetAreaWarnFailure(beautificationID, false);
		rmBuildArea(beautificationID);
	}

	for(i = 1; < 10 * cPlayers) {
		beautificationID = rmCreateArea("beautification 1 " + i);
		rmSetAreaSize(beautificationID, rmAreaTilesToFraction(50), rmAreaTilesToFraction(100));
		rmSetAreaTerrainType(beautificationID, "GrassA");
		rmSetAreaMinBlobs(beautificationID, 1);
		rmSetAreaMaxBlobs(beautificationID, 5);
		rmSetAreaMinBlobDistance(beautificationID, 16.0);
		rmSetAreaMaxBlobDistance(beautificationID, 40.0);
		rmAddAreaConstraint(beautificationID, avoidWater);
		rmSetAreaWarnFailure(beautificationID, false);
		rmBuildArea(beautificationID);
	}

	progress(0.2);

	// Settlements.
	int settlementID = rmCreateObjectDef("settlements");
	rmAddObjectDefItem(settlementID, "Settlement", 1, 0.0);

	int tcAvoidWater = createTerrainDistConstraint("Land", false, 15.0);

	// Close settlement.
	addFairLocConstraint(tcAvoidWater);

	if(cNonGaiaPlayers < 3) {
		addFairLocConstraint(avoidCorner);
		addFairLoc(60.0, 80.0, false, true, 65.0, 12.0, 12.0);
	} else {
		addFairLocConstraint(avoidTowerLOS);
		addFairLoc(60.0, 80.0, false, true, 50.0, 12.0, 12.0, false, false, false);
	}

	// Far settlement.
	addFairLocConstraint(avoidTowerLOS);
	addFairLocConstraint(tcAvoidWater);

	if(cNonGaiaPlayers < 3) {
		addFairLoc(70.0, 120.0, true, false, 65.0, 12.0, 12.0);
	} else if(cNonGaiaPlayers < 9) {
		addFairLoc(80.0, 120.0, true, false, 75.0, 12.0, 12.0, false, false, true);
	} else {
		addFairLoc(80.0, 120.0, true, false, 40.0, 12.0, 12.0);
	}

	// Inter fair loc dist.
	if(cNonGaiaPlayers == 2) {
		setFairLocInterDistMin(100.0);
	}

	placeObjectAtNewFairLocs(settlementID, false, "settlements");

	progress(0.3);

	// Forests.
	initForestClass();

	addForestConstraint(avoidStartingSettlement);
	addForestConstraint(avoidAll);
	addForestConstraint(avoidWater);

	addForestType("Oak Forest", 0.5);
	addForestType("Pine Forest", 0.5);

	setForestAvoidSelf(20.0);

	setForestBlobs(9);
	setForestBlobParams(4.75, 4.5);
	setForestCoherence(-0.75, 0.75);
	setForestSearchRadius(rmXFractionToMeters(0.15), -1.0);

	// Player forests.
	setForestSearchRadius(40.0, 40.0);
	setForestMinRatio(1.0);

	int numPlayerForests = 2;

	buildPlayerForests(numPlayerForests, 0.1);

	progress(0.4);

	// Normal forests.
	setForestSearchRadius(rmXFractionToMeters(0.2), -1.0);
	setForestMinRatio(2.0 / 3.0);

	int numForests = 7 * cNonGaiaPlayers / 2;

	if(cNonGaiaPlayers == 2) {
		numForests = 9 * cNonGaiaPlayers / 2;
	}

	buildForests(numForests, 0.3);

	progress(0.7);

	// Object placement.
	// Starting gold close to tower.
	storeObjectDefItem("Gold Mine Small", 1, 0.0);
	storeObjectConstraint(createTypeDistConstraint("Tower", rmRandFloat(8.0, 10.0))); // Don't get too close.
	storeObjectConstraint(avoidAll);
	storeObjectConstraint(avoidEdge);
	storeObjectConstraint(avoidWater);
	placeStoredObjectMirroredNearStoredLocs(4, false, 24.0, 25.0, 12.5);

	resetObjectStorage();

	// Medium gold.
	placeObjectMirrored(mediumGoldID, false, 1, 55.0, 70.0);

	// Far gold.
	placeFarObjectMirrored(bonusGoldID, false, rmRandInt(2, 3));

	// Close hunt.
	placeObjectMirrored(closeHuntID, false, 1, 30.0, 50.0);

	// Bonus hunt.
	placeFarObjectMirrored(bonusHuntID);

	// Starting food.
	placeObjectMirrored(startingFoodID, false, 1, 21.0, 27.0, true);

	// Berries.
	placeFarObjectMirrored(farBerriesID);

	// Straggler trees.
	placeObjectMirrored(stragglerTreeID, false, rmRandInt(2, 5), 13.0, 13.5, true);

	// Medium herdables.
	placeObjectMirrored(mediumHerdablesID, false, 2, 55.0, 75.0);

	// Far herdables.
	placeFarObjectMirrored(farHerdablesID, false, 3);

	// Starting herdables.
	placeObjectMirrored(startingHerdablesID, true, 1, 20.0, 30.0);

	// Far predators.
	placeFarObjectMirrored(farPredatorsID);

	progress(0.8);

	// Create bonus island.
	if(cNonGaiaPlayers > 2) {
		int bonusIslandID = rmCreateArea("bonus island");
		rmSetAreaSize(bonusIslandID, rmAreaTilesToFraction(500));
		rmSetAreaLocation(bonusIslandID, 0.5, 0.5);
		rmSetAreaTerrainType(bonusIslandID, "ShorelineMediterraneanB");
		rmSetAreaBaseHeight(bonusIslandID, 2.0);
		rmSetAreaSmoothDistance(bonusIslandID, 10);
		rmSetAreaHeightBlend(bonusIslandID, 2);
		rmSetAreaCoherence(bonusIslandID, 1.0);
		rmSetAreaWarnFailure(bonusIslandID, false);
		rmBuildArea(bonusIslandID);

		int islandEmbellishmentID = rmCreateObjectDef("island embellishment");
		rmAddObjectDefItem(islandEmbellishmentID, "Baboon", 1, 2.0);
		rmAddObjectDefItem(islandEmbellishmentID, "Palm", 1, 8.0);
		rmAddObjectDefItem(islandEmbellishmentID, "Gold Mine", 1, 8.0);
		setObjectDefDistance(islandEmbellishmentID, 0.0, 20.0);
		rmPlaceObjectDefAtLoc(islandEmbellishmentID, 0, 0.5, 0.5);
	}

	// Fish.
	int fishLandMin = createTerrainDistConstraint("Land", true, 15.0);
	int farAvoidFish = createTypeDistConstraint("Fish", 20.0);
	int shortAvoidFish = createTypeDistConstraint("Fish", 17.0);

	// Close fish.
	int numPlayerFish = 4;

	int playerFishID = rmCreateObjectDef("player fish");
	rmAddObjectDefItem(playerFishID, "Fish - Mahi", 3, 5.0);
	rmAddObjectDefConstraint(playerFishID, fishLandMin);
	rmAddObjectDefConstraint(playerFishID, farAvoidFish);
	rmAddObjectDefConstraint(playerFishID, avoidCenter);

	// Alt object without constraints so it's guaranteed to mirror correctly.
	int altFishID = rmCreateObjectDef("player fish alt");
	rmAddObjectDefItem(altFishID, "Fish - Mahi", 3, 5.0);

	float fishMinDist = 50.0;
	setObjectAngleInterval(0.9 * PI, 1.1 * PI, false);

	for(f = 0; < numPlayerFish) {

		// Find location for first pair of mirrored players.
		for(i = 1; < 50) {
			if(placeObjectForMirroredPlayers(1, playerFishID, false, 1, fishMinDist, fishMinDist + 10.0, false, altFishID) == 1) {
				break;
			}

			fishMinDist = fishMinDist + 10.0;
		}

		// Place for rest.
		for(i = 2; <= getNumberPlayersOnTeam(0)) {
			placeObjectForMirroredPlayers(i, playerFishID, false, 1, fishMinDist + 2.5, fishMinDist + 12.5, false, altFishID);
		}

		if(f == 0) {
			// Reset angle bias after first iteration.
			setObjectAngleInterval();

			// Adjust fishMinDist after first iteration.
			fishMinDist = fishMinDist + 5.0;
		}

	}

	// Far fish.
	int numFarFish = 1;

	int farFishID = rmCreateObjectDef("far fish");
	rmAddObjectDefItem(farFishID, "Fish - Mahi", 3, 5.0);
	rmAddObjectDefConstraint(farFishID, fishLandMin);
	rmAddObjectDefConstraint(farFishID, farAvoidFish);
	rmAddObjectDefConstraint(farFishID, avoidCenter);

	// Alt object without constraints so it's guaranteed to mirror correctly.
	int altFarFishID = rmCreateObjectDef("far fish alt");
	rmAddObjectDefItem(altFarFishID, "Fish - Mahi", 3, 5.0);

	placeFarObjectMirrored(farFishID, false, numFarFish, 10.0, altFarFishID);

	// Bonus fish.
	int numBonusFish = 1 + cNonGaiaPlayers / 2;

	int bonusFishID = rmCreateObjectDef("bonus fish");
	rmAddObjectDefItem(bonusFishID, "Fish - Perch", 2, 4.0);
	rmAddObjectDefConstraint(bonusFishID, fishLandMin);
	rmAddObjectDefConstraint(bonusFishID, shortAvoidFish);

	// Alt object without constraints so it's guaranteed to mirror correctly.
	int altBonusFishID = rmCreateObjectDef("bonus fish alt");
	rmAddObjectDefItem(altBonusFishID, "Fish - Perch", 2, 4.0);

	placeFarObjectMirrored(bonusFishID, false, numBonusFish, 10.0, altBonusFishID);

	// Center fish.
	int centerFishID = rmCreateObjectDef("center fish");
	rmAddObjectDefItem(centerFishID, "Fish - Perch", 1, 6.0);

	if(cNonGaiaPlayers == 2) {
		rmPlaceObjectDefAtLoc(centerFishID, 0, 0.5, 0.5);
	}

	progress(0.9);

	// Relics (non mirrored).
	placeObjectInPlayerSplits(relicID);

	// Random trees.
	placeObjectAtPlayerLocs(randomTreeID, false, 10);

	// Beautification.
	int stayInBeautification = createEdgeDistConstraint(beautificationID, 4.0);

	// Flower beautification. This has to be placed later than the other terrain embellishment due to objects avoiding flowers.
	for(i = 1; < 10 * cPlayers) {
		beautificationID = rmCreateArea("flower beautification " + i);
		rmSetAreaSize(beautificationID, rmAreaTilesToFraction(5), rmAreaTilesToFraction(20));
		rmSetAreaTerrainType(beautificationID, "GrassB");
		rmSetAreaMinBlobs(beautificationID, 1);
		rmSetAreaMaxBlobs(beautificationID, 5);
		rmSetAreaMinBlobDistance(beautificationID, 16.0);
		rmSetAreaMaxBlobDistance(beautificationID, 40.0);
		rmAddAreaConstraint(beautificationID, avoidWater);
		rmAddAreaConstraint(beautificationID, avoidAll);
		rmSetAreaWarnFailure(beautificationID, false);
		rmBuildArea(beautificationID);

		int insideBeautificationID = rmCreateObjectDef("grass" + i);
		rmAddObjectDefItem(insideBeautificationID, "Grass", rmRandInt(2, 4), 5.0);
		rmAddObjectDefItem(insideBeautificationID, "Flowers", rmRandInt(0, 6), 5.0);
		rmAddObjectDefConstraint(insideBeautificationID, stayInBeautification);
		rmAddObjectDefConstraint(insideBeautificationID, avoidAll);
		rmPlaceObjectDefInArea(insideBeautificationID, 0, beautificationID);
	}

	// Grass.
	int grassID = rmCreateObjectDef("grass");
	rmAddObjectDefItem(grassID, "Grass", 3, 4.0);
	setObjectDefDistanceToMax(grassID);
	rmAddObjectDefConstraint(grassID, embellishmentAvoidAll);
	rmAddObjectDefConstraint(grassID, avoidWater);
	rmAddObjectDefConstraint(grassID, createTypeDistConstraint("Grass", 12.0));
	rmPlaceObjectDefAtLoc(grassID, 0, 0.5, 0.5, 20 * cNonGaiaPlayers);

	// Rocks.
	int avoidRock = createTypeDistConstraint("Rock Limestone Sprite", 8.0);

	int rockGrassID = rmCreateObjectDef("rock sprite and grass");
	rmAddObjectDefItem(rockGrassID, "Rock Sandstone Sprite", 1, 1.0);
	rmAddObjectDefItem(rockGrassID, "Grass", 2, 1.0);
	setObjectDefDistanceToMax(rockGrassID);
	rmAddObjectDefConstraint(rockGrassID, embellishmentAvoidAll);
	rmAddObjectDefConstraint(rockGrassID, avoidWater);
	rmAddObjectDefConstraint(rockGrassID, avoidRock);
	rmPlaceObjectDefAtLoc(rockGrassID, 0, 0.5, 0.5, 15 * cNonGaiaPlayers);

	int rockGroupID = rmCreateObjectDef("rock group");
	rmAddObjectDefItem(rockGroupID, "Rock Sandstone Sprite", 3, 2.0);
	setObjectDefDistanceToMax(rockGroupID);
	rmAddObjectDefConstraint(rockGroupID, embellishmentAvoidAll);
	rmAddObjectDefConstraint(rockGroupID, avoidWater);
	rmAddObjectDefConstraint(rockGroupID, avoidRock);
	rmPlaceObjectDefAtLoc(rockGroupID, 0, 0.5, 0.5, 9 * cNonGaiaPlayers);

	// Seaweed.
	int seaweedShoreMin = createTerrainDistConstraint("Land", true, 10.0);
	int seaweedShoreMax = createTerrainMaxDistConstraint("Land", true, 14.0);

	int seaweed1ID = rmCreateObjectDef("seaweed 1");
	rmAddObjectDefItem(seaweed1ID, "Seaweed", 12, 6.0);
	setObjectDefDistanceToMax(seaweed1ID);
	rmAddObjectDefConstraint(seaweed1ID, embellishmentAvoidAll);
	rmAddObjectDefConstraint(seaweed1ID, seaweedShoreMin);
	rmAddObjectDefConstraint(seaweed1ID, seaweedShoreMax);
	rmPlaceObjectDefAtLoc(seaweed1ID, 0, 0.5, 0.5, 3 * cNonGaiaPlayers);

	int seaweed2ID = rmCreateObjectDef("seaweed 2");
	rmAddObjectDefItem(seaweed2ID, "Seaweed", 5, 3.0);
	setObjectDefDistanceToMax(seaweed2ID);
	rmAddObjectDefConstraint(seaweed2ID, embellishmentAvoidAll);
	rmAddObjectDefConstraint(seaweed2ID, seaweedShoreMin);
	rmAddObjectDefConstraint(seaweed2ID, seaweedShoreMax);
	rmPlaceObjectDefAtLoc(seaweed2ID, 0, 0.5, 0.5, 6 * cNonGaiaPlayers);

	// Birds.
	int birdsID = rmCreateObjectDef("birds");
	rmAddObjectDefItem(birdsID, "Hawk", 1, 0.0);
	setObjectDefDistanceToMax(birdsID);
	rmPlaceObjectDefAtLoc(birdsID, 0, 0.5, 0.5, 2 * cNonGaiaPlayers);

	// Finalize RM X.
	rmxFinalize();

	progress(1.0);
}
