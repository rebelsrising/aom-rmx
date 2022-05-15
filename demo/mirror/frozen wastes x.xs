/*
** MIDGARD MIRROR
** RebelsRising
** Last edit: 14/05/2022
*/

include "rmx.xs";

// Override backward town center angles because we can't place backwards.

mutable float randBackInsideFirst(float tol = 0.0) {
	return(rmRandFloat(-0.05 - 0.95 * tol, 0.3 + 0.7 * tol) * PI);
}

mutable float randBackOutsideFirst(float tol = 0.0) {
	return(rmRandFloat(1.7 - 0.7 * tol, 2.05 + 0.95 * tol) * PI);
}

mutable float randBackInsideLast(float tol = 0.0) {
	return(rmRandFloat(1.7 - 0.7 * tol, 2.05 + 0.95 * tol) * PI);
}

mutable float randBackOutsideLast(float tol = 0.0) {
	return(rmRandFloat(-0.05 - 0.95 * tol, 0.3 + 0.7 * tol) * PI);
}

mutable float randBackCenter(float tol = 0.0) {
	if(tol == 0.0) {
		return(rmRandFloat(-0.3, 0.3) * PI);
	} else {
		return(randFromIntervals(-0.3 - tol * 0.7, -0.3, 0.3, 0.3 + tol * 0.7) * PI);
	}
}

mutable float randBackInsideSingle(float tol = 0.0) {
	return(rmRandFloat(-0.4 - 0.6 * tol, 0.4 + 0.6 * tol) * PI);

}

mutable float randBackOutsideSingle(float tol = 0.0) {
	return(rmRandFloat(-0.4 - 0.6 * tol, 0.4 + 0.6 * tol) * PI);
}

void main() {
	progress(0.0);

	// Initial map setup.
	rmxInit("Frozen Wastes X");

	// Set mirror mode.
	setMirrorMode(cMirrorPoint);

	// Perform mirror check.
	if(mirrorConfigIsInvalid()) {
		injectMirrorGenError();

		// Invalid configuration, quit.
		return;
	}

	// Set size.
	int axisLength = getStandardMapDimInMeters(9600);

	// Initialize map.
	initializeMap("IceA", axisLength);

	// Set lighting.
	rmSetLightingSet("Alfheim");

	// Player placement.
	if(gameIs1v1()) {
		if(randChance()) {
			placePlayersInLine(0.25, 0.25, 0.75, 0.75);
		} else {
			placePlayersInLine(0.25, 0.75, 0.75, 0.25);
		}
	} else if(cNonGaiaPlayers < 5) {
		placePlayersInCircle(0.3, 0.3, 0.9);
	} else {
		placePlayersInCircle(0.35, 0.35, 0.9);
	}

	// Create fake center area.
	float blobSizeMeters = 0.5 * axisLength / 6; // Educated guess, 1 + 8 + 12 + 16 + 20 = 57, -> ~6 layers with 64 blobs.

	int classFakeContinent = initAreaClass();

	setAreaTerrainType("SnowA", blobSizeMeters, blobSizeMeters);
	setAreaParams(2.0, 2);
	setAreaBlobs(64);
	setAreaCoherence(1.0, 1.0);
	setAreaSearchRadius(0.0, 0.0); // Set tiny search radius so it gets placed at the center.
	setAreaRequiredRatio(0.0); // This will work just fine (we will always end up with a reasonable shape with a coherence of 1.0).

	addAreaConstraint(createSymmetricBoxConstraint(rmXTilesToFraction(12), rmXTilesToFraction(12), 0.01));

	setAreaEnforceConstraints(true);

	buildAreas(1, 0.0);

	// Setup fake player areas so we have enough space for towers.
	float fakePlayerAreaSize = areaRadiusMetersToFraction(45.0);

	for(i = 1; < cPlayers) {
		int fakePlayerAreaID = rmCreateArea("fake player area " + i);
		rmSetAreaSize(fakePlayerAreaID, fakePlayerAreaSize, fakePlayerAreaSize);
		rmSetAreaLocPlayer(fakePlayerAreaID, getPlayer(i));
		rmSetAreaTerrainType(fakePlayerAreaID, "SnowB");
		rmSetAreaCoherence(fakePlayerAreaID, 1.0);
		rmSetAreaWarnFailure(fakePlayerAreaID, false);
	}

	rmBuildAllAreas();

	// Build surrounding areas (1 from each side to avoid enclosing) as stencil for the actual continent.
	int classSurrounding = rmDefineClass("surrounding");
	int avoidFakeContinent = createClassDistConstraint(classFakeContinent, 1.0);
	int avoidSurrounding = createClassDistConstraint(classSurrounding, 1.0);

	for(i = 0; < 2) {
		int surroundingAreaID = rmCreateArea("surrounding area " + i);
		rmSetAreaSize(surroundingAreaID, 1.0);
		if(i == 0) {
			rmSetAreaLocation(surroundingAreaID, 0.0, 1.0);
		} else if(i == 1) {
			rmSetAreaLocation(surroundingAreaID, 1.0, 0.0);
		}
		// rmSetAreaTerrainType(surroundingAreaID, "IceA");
		rmSetAreaCoherence(surroundingAreaID, 1.0);
		rmAddAreaToClass(surroundingAreaID, classSurrounding);
		rmAddAreaConstraint(surroundingAreaID, avoidFakeContinent);
		rmAddAreaConstraint(surroundingAreaID, avoidSurrounding);
		rmSetAreaWarnFailure(surroundingAreaID, false);
	}

	rmBuildAllAreas();

	// Rebuild continent based on the surroundings to end up with the actual area.
	int classContinent = rmDefineClass("continent");

	int continentID = rmCreateArea("continent");
	rmSetAreaSize(continentID, 1.0);
	rmSetAreaLocation(continentID, 0.5, 0.5);
	rmSetAreaTerrainType(continentID, "SnowB");
	rmSetAreaCoherence(continentID, 1.0);
	rmAddAreaToClass(continentID, classContinent);
	rmAddAreaConstraint(continentID, avoidSurrounding);
	rmSetAreaWarnFailure(continentID, false);
	rmBuildArea(continentID);

	progress(0.1);

	// Initialize areas.
	float centerRadius = 22.5;

	int classCenter = initializeCenter(centerRadius);
	int classCorner = initializeCorners();

	// Define classes.
	int classPlayer = rmDefineClass("player");
	int classStartingSettlement = rmDefineClass("starting settlement");

	// Global constraints.
	// General.
	int avoidAll = createTypeDistConstraint("All", 7.0);
	int avoidEdge = createSymmetricBoxConstraint(rmXTilesToFraction(1), rmZTilesToFraction(1)); // Bare minimum.
	int avoidCenter = createClassDistConstraint(classCenter, 1.0);
	int avoidCorner = createClassDistConstraint(classCorner, 1.0);
	int avoidPlayer = createClassDistConstraint(classPlayer, 1.0);

	// Settlements.
	int avoidStartingSettlement = createClassDistConstraint(classStartingSettlement, 20.0);
	int shortAvoidSettlement = createTypeDistConstraint("AbstractSettlement", 15.0);
	int farAvoidSettlement = createTypeDistConstraint("AbstractSettlement", 20.0);

	// Terrain.
	int forceOnContinent = createAreaConstraint(continentID);
	int shortAvoidContinentEdge = createEdgeDistConstraint(continentID, 5.0);
	int farAvoidContinentEdge = createEdgeDistConstraint(continentID, 7.5);
	int avoidContinent = createClassDistConstraint(classContinent, 1.0);

	// Gold.
	int shortAvoidGold = createTypeDistConstraint("Gold", 10.0);
	int mediumAvoidGold = createTypeDistConstraint("Gold", 25.0);
	int farAvoidGold = createTypeDistConstraint("Gold", 40.0);
	int goldEdgeMinDist = createEdgeDistConstraint(continentID, 7.5);
	int goldEdgeMaxDist = createEdgeMaxDistConstraint(continentID, 15.0);

	// Food.
	int avoidHuntable = createTypeDistConstraint("Huntable", 40.0);
	int avoidHerdable = createTypeDistConstraint("Herdable", 40.0); // Higher than on other maps.
	int avoidFood = createTypeDistConstraint("Food", 20.0);
	int avoidPredator = createTypeDistConstraint("AnimalPredator", 40.0);

	// Relics.
	int avoidRelic = createTypeDistConstraint("Relic", 70.0);

	// Buildings.
	int avoidBuildings = createTypeDistConstraint("Building", 25.0);
	int avoidTowerLOS = createTypeDistConstraint("Tower", 35.0);
	int farAvoidTower = createTypeDistConstraint("Tower", 25.0);
	int shortAvoidTower = createTypeDistConstraint("Tower", 15.0);

	// Embellishment.
	int embellishmentAvoidAll = createTypeDistConstraint("All", 3.0);

	// Define objects.
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

	// Starting gold.
	int startingGoldID = rmCreateObjectDef("starting gold");
	rmAddObjectDefItem(startingGoldID, "Gold Mine Small", 1, 0.0);
	rmAddObjectDefConstraint(startingGoldID, avoidAll);
	rmAddObjectDefConstraint(startingGoldID, mediumAvoidGold);

	// Starting food.
	int startingFoodID = createObjectDefVerify("starting food");
	addObjectDefItemVerify(startingFoodID, "Berry Bush", rmRandInt(5, 8), 2.0);
	rmAddObjectDefConstraint(startingFoodID, avoidAll);
	rmAddObjectDefConstraint(startingFoodID, avoidFood);
	rmAddObjectDefConstraint(startingFoodID, shortAvoidGold);

	// Starting hunt.
	int startingHuntID = createObjectDefVerify("close hunt");
	addObjectDefItemVerify(startingHuntID, "Caribou", rmRandInt(4, 8), 2.0);
	rmAddObjectDefConstraint(startingHuntID, avoidAll);
	rmAddObjectDefConstraint(startingHuntID, shortAvoidGold);

	// Starting herdables.
	int startingHerdablesID = createObjectDefVerify("starting herdables");
	addObjectDefItemVerify(startingHerdablesID, "Goat", 2, 2.0);
	rmAddObjectDefConstraint(startingHerdablesID, avoidAll);

	// Straggler trees.
	int stragglerTreeID = rmCreateObjectDef("straggler tree");
	rmAddObjectDefItem(stragglerTreeID, "Pine Snow", 1, 0.0);
	rmAddObjectDefConstraint(stragglerTreeID, avoidAll);

	// Gold.
	int goldID = createObjectDefVerify("gold");
	addObjectDefItemVerify(goldID, "Gold Mine", 1, 0.0);
	rmAddObjectDefConstraint(goldID, avoidAll);
	rmAddObjectDefConstraint(goldID, avoidEdge);
	// rmAddObjectDefConstraint(goldID, avoidCenter);
	rmAddObjectDefConstraint(goldID, forceOnContinent);
	rmAddObjectDefConstraint(goldID, goldEdgeMinDist);
	rmAddObjectDefConstraint(goldID, goldEdgeMaxDist);
	rmAddObjectDefConstraint(goldID, createClassDistConstraint(classStartingSettlement, 50.0));
	rmAddObjectDefConstraint(goldID, farAvoidSettlement);
	rmAddObjectDefConstraint(goldID, avoidTowerLOS);
	rmAddObjectDefConstraint(goldID, farAvoidGold);

	// Food.
	// Medium hunt.
	int mediumHuntID = createObjectDefVerify("medium hunt");
	if(randChance()) {
		addObjectDefItemVerify(mediumHuntID, "Elk", rmRandInt(5, 8), 2.0);
	} else {
		addObjectDefItemVerify(mediumHuntID, "Caribou", rmRandInt(5, 8), 2.0);
	}
	rmAddObjectDefConstraint(mediumHuntID, avoidAll);
	rmAddObjectDefConstraint(mediumHuntID, avoidCenter);
	rmAddObjectDefConstraint(mediumHuntID, forceOnContinent);
	rmAddObjectDefConstraint(mediumHuntID, shortAvoidContinentEdge);
	rmAddObjectDefConstraint(mediumHuntID, createClassDistConstraint(classStartingSettlement, 65.0));
	rmAddObjectDefConstraint(mediumHuntID, avoidHuntable);
	rmAddObjectDefConstraint(mediumHuntID, avoidTowerLOS);
	rmAddObjectDefConstraint(mediumHuntID, shortAvoidSettlement);
	rmAddObjectDefConstraint(mediumHuntID, shortAvoidGold);

	// Bonus walrus.
	int bonusHuntID = createObjectDefVerify("bonus hunt");
	addObjectDefItemVerify(bonusHuntID, "Walrus", rmRandInt(3, 4), 2.0);
	rmAddObjectDefConstraint(bonusHuntID, avoidAll);
	rmAddObjectDefConstraint(bonusHuntID, avoidCenter);
	rmAddObjectDefConstraint(bonusHuntID, forceOnContinent);
	rmAddObjectDefConstraint(bonusHuntID, createClassDistConstraint(classStartingSettlement, 65.0));
	rmAddObjectDefConstraint(bonusHuntID, createTypeDistConstraint("Huntable", 30.0));
	rmAddObjectDefConstraint(bonusHuntID, avoidTowerLOS);
	rmAddObjectDefConstraint(bonusHuntID, shortAvoidGold);
	rmAddObjectDefConstraint(bonusHuntID, createEdgeDistConstraint(continentID, 50.0));

	// Far berries.
	int farBerriesID = createObjectDefVerify("far berries");
	addObjectDefItemVerify(farBerriesID, "Berry Bush", rmRandInt(6, 10), 4.0);
	rmAddObjectDefConstraint(farBerriesID, avoidAll);
	rmAddObjectDefConstraint(farBerriesID, avoidCenter);
	rmAddObjectDefConstraint(farBerriesID, forceOnContinent);
	rmAddObjectDefConstraint(farBerriesID, shortAvoidContinentEdge);
	rmAddObjectDefConstraint(farBerriesID, createClassDistConstraint(classStartingSettlement, 70.0));
	rmAddObjectDefConstraint(farBerriesID, shortAvoidSettlement);
	rmAddObjectDefConstraint(farBerriesID, shortAvoidGold);
	rmAddObjectDefConstraint(farBerriesID, avoidFood);

	// Medium herdables (only verify for 1v1 because there are so many).
	int mediumHerdablesID = createObjectDefVerify("medium herdables", gameIs1v1());
	addObjectDefItemVerify(mediumHerdablesID, "Goat", 2, 4.0);
	rmAddObjectDefConstraint(mediumHerdablesID, avoidAll);
	rmAddObjectDefConstraint(mediumHerdablesID, avoidEdge);
	// rmAddObjectDefConstraint(mediumHerdablesID, avoidCenter);
	rmAddObjectDefConstraint(mediumHerdablesID, avoidContinent);
	rmAddObjectDefConstraint(mediumHerdablesID, shortAvoidContinentEdge);
	rmAddObjectDefConstraint(mediumHerdablesID, avoidTowerLOS);
	rmAddObjectDefConstraint(mediumHerdablesID, createClassDistConstraint(classStartingSettlement, 50.0));
	rmAddObjectDefConstraint(mediumHerdablesID, createTypeDistConstraint("Herdable", 50.0));

	// Far herdables.
	int farHerdablesID = createObjectDefVerify("far herdables");
	addObjectDefItemVerify(farHerdablesID, "Goat", rmRandInt(2, 3), 4.0);
	rmAddObjectDefConstraint(farHerdablesID, avoidAll);
	rmAddObjectDefConstraint(farHerdablesID, avoidCenter);
	rmAddObjectDefConstraint(farHerdablesID, forceOnContinent);
	rmAddObjectDefConstraint(farHerdablesID, createEdgeDistConstraint(continentID, 10.0));
	rmAddObjectDefConstraint(farHerdablesID, createClassDistConstraint(classStartingSettlement, 70.0));
	rmAddObjectDefConstraint(farHerdablesID, avoidHerdable);

	// Far predators.
	int farPredatorsID = createObjectDefVerify("far predators");
	addObjectDefItemVerify(farPredatorsID, "Polar Bear", 1, 0.0);
	rmAddObjectDefConstraint(farPredatorsID, avoidAll);
	rmAddObjectDefConstraint(farPredatorsID, avoidCenter);
	rmAddObjectDefConstraint(farPredatorsID, forceOnContinent);
	rmAddObjectDefConstraint(farPredatorsID, shortAvoidContinentEdge);
	rmAddObjectDefConstraint(farPredatorsID, createClassDistConstraint(classStartingSettlement, 70.0));
	rmAddObjectDefConstraint(farPredatorsID, farAvoidSettlement);
	rmAddObjectDefConstraint(farPredatorsID, avoidFood);
	rmAddObjectDefConstraint(farPredatorsID, avoidPredator);

	// Other objects.
	// Random trees.
	int randomTreeID = rmCreateObjectDef("random tree");
	rmAddObjectDefItem(randomTreeID, "Pine Snow", 1, 0.0);
	setObjectDefDistanceToMax(randomTreeID);
	rmAddObjectDefConstraint(randomTreeID, avoidAll);
	rmAddObjectDefConstraint(randomTreeID, forceOnContinent);
	rmAddObjectDefConstraint(randomTreeID, shortAvoidContinentEdge);
	rmAddObjectDefConstraint(randomTreeID, avoidStartingSettlement);
	
	// Relics.
	int relicID = createObjectDefVerify("relic");
	addObjectDefItemVerify(relicID, "Relic", 1, 0.0);
	rmAddObjectDefConstraint(relicID, avoidAll);
	rmAddObjectDefConstraint(relicID, forceOnContinent);
	rmAddObjectDefConstraint(relicID, shortAvoidContinentEdge);
	rmAddObjectDefConstraint(relicID, avoidCorner);
	rmAddObjectDefConstraint(relicID, createClassDistConstraint(classStartingSettlement, 70.0));
	rmAddObjectDefConstraint(relicID, avoidRelic);

	progress(0.2);

	// Set up player areas.
	float playerAreaSize = rmAreaTilesToFraction(1500);

	for(i = 1; < cPlayers) {
		int playerAreaID = rmCreateArea("player area " + i);
		rmSetAreaSize(playerAreaID, playerAreaSize);
		rmSetAreaLocPlayer(playerAreaID, getPlayer(i));
		rmSetAreaTerrainType(playerAreaID, "SnowA");
		// rmSetAreaTerrainType(playerAreaID, "HadesBuildable1");
		rmSetAreaCoherence(playerAreaID, 0.8);
		rmSetAreaSmoothDistance(playerAreaID, 5);
		rmAddAreaToClass(playerAreaID, classPlayer);
		rmSetAreaWarnFailure(playerAreaID, false);
	}

	rmBuildAllAreas();

	// Beautification.
	int beautificationID = 0;

	for(i = 0; < 20 * cPlayers) {
		beautificationID = rmCreateArea("beautification 1 " + i);
		rmSetAreaTerrainType(beautificationID, "SnowA");
		rmSetAreaSize(beautificationID, rmAreaTilesToFraction(75), rmAreaTilesToFraction(150));
		rmSetAreaMinBlobs(beautificationID, 1);
		rmSetAreaMaxBlobs(beautificationID, 5);
		rmSetAreaMinBlobDistance(beautificationID, 16.0);
		rmSetAreaMaxBlobDistance(beautificationID, 40.0);
		rmAddAreaConstraint(beautificationID, forceOnContinent);
		rmSetAreaWarnFailure(beautificationID, false);
		rmBuildArea(beautificationID);
	}

	for(i = 0; < 20 * cPlayers) {
		beautificationID = rmCreateArea("beautification 2 " + i);
		rmSetAreaTerrainType(beautificationID, "IceB");
		rmSetAreaSize(beautificationID, rmAreaTilesToFraction(75), rmAreaTilesToFraction(150));
		rmSetAreaMinBlobs(beautificationID, 1);
		rmSetAreaMaxBlobs(beautificationID, 5);
		rmSetAreaMinBlobDistance(beautificationID, 16.0);
		rmSetAreaMaxBlobDistance(beautificationID, 40.0);
		rmAddAreaConstraint(beautificationID, avoidPlayer);
		rmAddAreaConstraint(beautificationID, avoidContinent);
		rmSetAreaWarnFailure(beautificationID, false);
		rmBuildArea(beautificationID);
	}

	progress(0.3);

	// Starting settlement.
	placeObjectAtPlayerLocs(startingSettlementID, true);

	// Towers.
	placeAndStoreObjectMirrored(startingTowerID, true, 4, 23.0, 27.0, true, -1, startingTowerBackupID);

	// Settlements.
	int settlementID = rmCreateObjectDef("settlements");
	rmAddObjectDefItem(settlementID, "Settlement", 1, 0.0);

	float tcDist = 65.0;
	int settlementAvoidCenter = createClassDistConstraint(classCenter, 10.0 + 0.5 * (tcDist - 2.0 * centerRadius));

	// Close settlement.
	enableFairLocTwoPlayerCheck();

	if(gameIs1v1() == false) {
		addFairLocConstraint(avoidTowerLOS);
	}

	addFairLocConstraint(settlementAvoidCenter);
	addFairLocConstraint(forceOnContinent);
	addFairLocConstraint(createEdgeDistConstraint(continentID, 40.0));

	if(gameIs1v1()) {
		addFairLoc(60.0, 70.0, false, true, 70.0, 0.0, 0.0, true);
	} else if(cNonGaiaPlayers < 5 ) {
		addFairLocConstraint(createEdgeDistConstraint(continentID, 40.0));
		addFairLoc(60.0, 80.0, false, true, 55.0, 0.0, 0.0, false, false, false, true);
	} else {
		addFairLoc(60.0, 80.0, false, true, 55.0, 0.0, 0.0, false, false, false, true);
	}

	// Far settlement.
	addFairLocConstraint(settlementAvoidCenter);
	addFairLocConstraint(avoidTowerLOS);
	addFairLocConstraint(forceOnContinent);
	addFairLocConstraint(createTypeDistConstraint("AbstractSettlement", 60.0));
	addFairLocConstraint(createEdgeDistConstraint(continentID, 40.0));

	enableFairLocTwoPlayerCheck();

	// For anything but 1v1, the forward/backward variation has no impact because the map is so small.
	if(gameIs1v1()) {
		addFairLoc(80.0, 120.0, true, false, 70.0);
	} else if(cNonGaiaPlayers < 5) {
		addFairLoc(70.0, 85.0, true, randChance(), 70.0, 0.0, 0.0, false, gameHasTwoEqualTeams());
	} else {
		addFairLoc(75.0, 90.0, true, true, 70.0, 0.0, 0.0, false, gameHasTwoEqualTeams());
	}

	placeObjectAtNewFairLocs(settlementID, false, "settlements");

	progress(0.4);

	// Gold first as it's on the sides.
	int numMediumGold = 2;
	int numBonusGold = rmRandInt(1, 2);

	// Medium gold.
	placeObjectMirrored(goldID, false, numMediumGold, 50.0, 50.0 + 10.0 * numMediumGold);

	// Bonus gold.
	placeFarObjectMirrored(goldID, false, numBonusGold);

	// Forests.
	initForestClass();

	addForestConstraint(createClassDistConstraint(classCenter, 2.5));
	addForestConstraint(avoidAll);
	addForestConstraint(avoidStartingSettlement);
	addForestConstraint(forceOnContinent);
	addForestConstraint(farAvoidContinentEdge);

	addForestType("Snow Pine Forest", 1.0);

	setForestAvoidSelf(20.0);

	setForestBlobs(8, 10);
	setForestBlobParams(4.625, 4.25);
	setForestSearchRadius(rmXFractionToMeters(0.15), -1.0);

	// Player forests.
	setForestCoherence(0.5, 1.0);
	setForestSearchRadius(30.0, 40.0);
	setForestMinRatio(2.0 / 3.0);

	int numPlayerForests = 3;

	buildPlayerForests(numPlayerForests, 0.1);

	progress(0.5);

	// Normal forests.
	setForestCoherence(0.0, 1.0);
	setForestSearchRadius(25.0, -1.0);
	setForestMinRatio(2.0 / 3.0);

	int numForests = 8 * cNonGaiaPlayers / 2;

	if(gameIs1v1()) {
		numForests = rmRandInt(7, 8);
	}

	buildForests(numForests, 0.3);

	progress(0.8);

	// Object placement.
	// Starting gold. Place 1 close to a tower, the other one random.
	storeObjectDefItem("Gold Mine Small", 1, 0.0);
	storeObjectConstraint(createTypeDistConstraint("Tower", rmRandFloat(8.0, 10.0))); // Don't get too close.
	storeObjectConstraint(avoidAll);
	storeObjectConstraint(avoidEdge);
	placeStoredObjectMirroredNearStoredLocs(4, false, 24.0, 25.0, 12.5);

	if(randChance() && gameIs1v1()) {
		placeObjectMirrored(startingGoldID, false, 1, 21.0, 26.0, true);
	}

	resetObjectStorage();

	// Bonus hunt.
	placeFarObjectMirrored(bonusHuntID, false, 2);

	// Medium hunt.
	int numMediumHunt = rmRandInt(2, 2);

	placeObjectMirrored(mediumHuntID, false, numMediumHunt, 65.0, 60.0 + 15.0 * numMediumHunt);

	// Starting hunt.
	placeObjectMirrored(startingHuntID, false, 1, 21.0, 27.0, true);

	// Starting food.
	placeObjectMirrored(startingFoodID, false, 1, 21.0, 27.0, true);

	// Berries.
	placeFarObjectMirrored(farBerriesID);

	// Straggler trees.
	placeObjectMirrored(stragglerTreeID, false, rmRandInt(2, 5), 13.0, 13.5, true);

	// Medium herdables.
	placeObjectMirrored(mediumHerdablesID, false, 4, 50.0, 150.0);

	// Far herdables.
	placeFarObjectMirrored(farHerdablesID, false, rmRandInt(1, 2));

	// Starting herdables.
	placeObjectMirrored(startingHerdablesID, true, 1, 20.0, 30.0, false);

	// Far predators.
	placeFarObjectMirrored(farPredatorsID, false, 2);

	progress(0.9);

	// Center forest.
	int centerForestID = rmCreateArea("center forest");
	rmSetAreaForestType(centerForestID, "Snow Pine Forest");
	rmSetAreaSize(centerForestID, areaRadiusMetersToFraction(rmRandFloat(2.0, 3.0)));
	rmSetAreaLocation(centerForestID, 0.5, 0.5);
	rmSetAreaCoherence(centerForestID, 1.0);
	rmBuildArea(centerForestID);

	// Relics (non-mirrored).
	placeObjectInPlayerSplits(relicID);

	// Random trees.
	placeObjectAtPlayerLocs(randomTreeID, false, 10);

	// Embellishment.
	// Rocks
	int rock1ID = rmCreateObjectDef("rock small");
	rmAddObjectDefItem(rock1ID, "Rock Granite Small", 1, 0.0);
	setObjectDefDistanceToMax(rock1ID);
	rmAddObjectDefConstraint(rock1ID, embellishmentAvoidAll);
	rmAddObjectDefConstraint(rock1ID, forceOnContinent);
	rmPlaceObjectDefAtLoc(rock1ID, 0, 0.5, 0.5, 20 * cNonGaiaPlayers);

	int rock2ID = rmCreateObjectDef("rock sprite");
	rmAddObjectDefItem(rock2ID, "Rock Granite Sprite", 1, 0.0);
	setObjectDefDistanceToMax(rock2ID);
	rmAddObjectDefConstraint(rock2ID, embellishmentAvoidAll);
	rmAddObjectDefConstraint(rock2ID, forceOnContinent);
	rmPlaceObjectDefAtLoc(rock2ID, 0, 0.5, 0.5, 30 * cNonGaiaPlayers);

	// Drifts
	int driftID = rmCreateObjectDef("drift");
	rmAddObjectDefItem(driftID, "Snow Drift", 1, 0.0);
	setObjectDefDistanceToMax(driftID);
	rmAddObjectDefConstraint(driftID, embellishmentAvoidAll);
	rmAddObjectDefConstraint(driftID, forceOnContinent);
	rmAddObjectDefConstraint(driftID, shortAvoidContinentEdge);
	rmAddObjectDefConstraint(driftID, avoidBuildings);
	rmAddObjectDefConstraint(driftID, createTypeDistConstraint("Snow Drift", 25.0));
	rmPlaceObjectDefAtLoc(driftID, 0, 0.5, 0.5, 4 * cNonGaiaPlayers);

	// Birds
	int birdsID = rmCreateObjectDef("birds");
	rmAddObjectDefItem(birdsID, "Hawk", 1, 0.0);
	setObjectDefDistanceToMax(birdsID);
	rmPlaceObjectDefAtLoc(birdsID, 0, 0.5, 0.5, 2 * cNonGaiaPlayers);

	// Finalize RM X.
	injectSnow(0.1);
	rmxFinalize();

	progress(1.0);
}
