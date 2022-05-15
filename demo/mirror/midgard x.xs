/*
** MIDGARD MIRROR
** RebelsRising
** Last edit: 14/05/2022
*/

include "rmx.xs";

// Override forward/inside town center angles for better variations.

mutable float randFwdInsideFirst(float tol = 0.0) {
	if(cNonGaiaPlayers < 5) {
		return(rmRandFloat(0.7 - 0.3 * tol, 1.0 + 0.5 * tol) * PI);
	}

	return(rmRandFloat(0.5 - 0.25 * tol, 0.65 + 0.15 * tol) * PI);
}

mutable float randFwdInsideLast(float tol = 0.0) {
	if(cNonGaiaPlayers < 5) {
		return(rmRandFloat(1.0 - 0.5 * tol, 1.3 + 0.2 * tol) * PI);
	}

	return(rmRandFloat(1.35 - 0.15 * tol, 1.5 + 0.25 * tol) * PI);
}

mutable float randFwdCenter(float tol = 0.0) {
	if(cNonGaiaPlayers < 5) {
		if(tol == 0.0) {
			return(rmRandFloat(0.8, 1.2) * PI);
		} else {
			return(randFromIntervals(0.8 - 0.6 * tol, 0.8, 1.2, 1.2 + 0.6 * tol) * PI);
		}
	}

	return(rmRandFloat(0.65 - 0.1 * tol, 1.35 + 0.1 * tol) * PI);
}

void main() {
	progress(0.0);

	// Initial map setup.
	rmxInit("Midgard X");

	// Set mirror mode.
	setMirrorMode(cMirrorPoint);

	// Perform mirror check.
	if(mirrorConfigIsInvalid()) {
		injectMirrorGenError();

		// Invalid configuration, quit.
		return;
	}

	// Set size.
	int axisLength = getStandardMapDimInMeters(12750);

	// Randomize water type.
	float waterType = rmRandFloat(0.0, 1.0); // Needed later for embellishment.

	if(waterType < 0.5) {
		rmSetSeaType("North Atlantic Ocean");
	} else {
		rmSetSeaType("Norwegian Sea");
	}

	rmSetSeaLevel(1.0);

	// Initialize map.
	initializeMap("Water", axisLength);

	// Place players.
	float playerRadius = 0.25 + 0.0125 * cNonGaiaPlayers;
	placePlayersInCircle(playerRadius, playerRadius);

	// Initialize areas.
	float centerRadius = 22.5;

	int classCenter = initializeCenter(centerRadius);
	int classCorner = initializeCorners(25.0);

	// Define classes.
	int classStartingSettlement = rmDefineClass("starting settlement");

	// Global constraints.
	// General.
	int avoidAll = createTypeDistConstraint("All", 7.0);
	int avoidEdge = createSymmetricBoxConstraint(rmXTilesToFraction(20), rmZTilesToFraction(20));
	int avoidCenter = createClassDistConstraint(classCenter, 1.0);
	int avoidCorner = createClassDistConstraint(classCorner, 1.0);

	// Settlements.
	int avoidStartingSettlement = createClassDistConstraint(classStartingSettlement, 20.0);
	int shortAvoidSettlement = createTypeDistConstraint("AbstractSettlement", 15.0);
	int farAvoidSettlement = createTypeDistConstraint("AbstractSettlement", 20.0);

	// Terrain.
	int avoidImpassableLand = createTerrainDistConstraint("Land", false, 10.0);

	// Gold.
	int shortAvoidGold = createTypeDistConstraint("Gold", 10.0);
	int farAvoidGold = createTypeDistConstraint("Gold", 40.0);

	// Food.
	int avoidHuntable = createTypeDistConstraint("Huntable", 40.0);
	int avoidHerdable = createTypeDistConstraint("Herdable", 30.0);
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
	// Starting objects.
	// Starting settlement.
	int startingSettlementID = rmCreateObjectDef("starting settlement");
	rmAddObjectDefItem(startingSettlementID, "Settlement Level 1", 1, 0.0);
	rmAddObjectDefToClass(startingSettlementID, classStartingSettlement);

	// Towers.
	int startingTowerID = rmCreateObjectDef("starting tower");
	rmAddObjectDefItem(startingTowerID, "Tower", 1, 0.0);
	rmAddObjectDefConstraint(startingTowerID, avoidAll);
	rmAddObjectDefConstraint(startingTowerID, avoidImpassableLand);
	rmAddObjectDefConstraint(startingTowerID, farAvoidTower);

	int startingTowerBackupID = rmCreateObjectDef("starting tower backup");
	rmAddObjectDefItem(startingTowerBackupID, "Tower", 1, 0.0);
	rmAddObjectDefConstraint(startingTowerBackupID, avoidAll);
	rmAddObjectDefConstraint(startingTowerBackupID, avoidImpassableLand);
	rmAddObjectDefConstraint(startingTowerBackupID, shortAvoidTower);

	// Starting food.
	int startingFoodID = createObjectDefVerify("starting food");
	addObjectDefItemVerify(startingFoodID, "Berry Bush", rmRandInt(4, 7), 2.0);
	rmAddObjectDefConstraint(startingFoodID, avoidAll);
	rmAddObjectDefConstraint(startingFoodID, avoidImpassableLand);
	rmAddObjectDefConstraint(startingFoodID, avoidFood);
	rmAddObjectDefConstraint(startingFoodID, shortAvoidGold);

	// Starting herdables.
	int startingHerdablesID = createObjectDefVerify("starting herdables");
	addObjectDefItemVerify(startingHerdablesID, "Cow", rmRandInt(1, 2), 2.0);
	rmAddObjectDefConstraint(startingHerdablesID, avoidAll);
	rmAddObjectDefConstraint(startingHerdablesID, avoidImpassableLand);

	// Straggler trees.
	int stragglerTreeID = rmCreateObjectDef("straggler tree");
	rmAddObjectDefItem(stragglerTreeID, "Pine Snow", 1, 0.0);
	rmAddObjectDefConstraint(stragglerTreeID, avoidAll);

	// Gold.
	// Medium gold.
	int mediumGoldID = createObjectDefVerify("medium gold");
	addObjectDefItemVerify(mediumGoldID, "Gold Mine", 1, 0.0);
	rmAddObjectDefConstraint(mediumGoldID, avoidAll);
	rmAddObjectDefConstraint(mediumGoldID, avoidCenter);
	rmAddObjectDefConstraint(mediumGoldID, avoidImpassableLand);
	rmAddObjectDefConstraint(mediumGoldID, farAvoidSettlement);
	rmAddObjectDefConstraint(mediumGoldID, createClassDistConstraint(classStartingSettlement, 50.0));
	rmAddObjectDefConstraint(mediumGoldID, avoidTowerLOS);
	rmAddObjectDefConstraint(mediumGoldID, farAvoidGold);

	// Bonus gold.
	int bonusGoldID = createObjectDefVerify("far gold");
	addObjectDefItemVerify(bonusGoldID, "Gold Mine", 1, 0.0);
	rmAddObjectDefConstraint(bonusGoldID, avoidAll);
	rmAddObjectDefConstraint(bonusGoldID, avoidCenter);
	rmAddObjectDefConstraint(bonusGoldID, avoidImpassableLand);
	rmAddObjectDefConstraint(bonusGoldID, farAvoidSettlement);
	rmAddObjectDefConstraint(bonusGoldID, createClassDistConstraint(classStartingSettlement, 70.0));
	rmAddObjectDefConstraint(bonusGoldID, avoidTowerLOS);
	rmAddObjectDefConstraint(bonusGoldID, farAvoidGold);

	// Food.
	// Medium walrus.
	int mediumWalrusID = createObjectDefVerify("medium walrus");
	addObjectDefItemVerify(mediumWalrusID, "Walrus", rmRandInt(3, 6), 2.0);
	rmAddObjectDefConstraint(mediumWalrusID, avoidAll);
	// rmAddObjectDefConstraint(mediumWalrusID, avoidCenter);
	rmAddObjectDefConstraint(mediumWalrusID, farAvoidSettlement);
	rmAddObjectDefConstraint(mediumWalrusID, createClassDistConstraint(classStartingSettlement, 60.0));
	rmAddObjectDefConstraint(mediumWalrusID, createTerrainDistConstraint("Land", false, 1.0));
	rmAddObjectDefConstraint(mediumWalrusID, createTerrainMaxDistConstraint("Water", true, 12.0));
	rmAddObjectDefConstraint(mediumWalrusID, avoidHuntable);

	// Bonus walrus.
	int bonusWalrusID = createObjectDefVerify("bonus walrus");
	addObjectDefItemVerify(bonusWalrusID, "Walrus", rmRandInt(2, 5), 2.0);
	rmAddObjectDefConstraint(bonusWalrusID, avoidAll);
	// rmAddObjectDefConstraint(bonusWalrusID, avoidCenter);
	rmAddObjectDefConstraint(bonusWalrusID, shortAvoidSettlement);
	rmAddObjectDefConstraint(bonusWalrusID, createClassDistConstraint(classStartingSettlement, 60.0));
	rmAddObjectDefConstraint(bonusWalrusID, createTerrainDistConstraint("Land", false, 1.0));
	rmAddObjectDefConstraint(bonusWalrusID, createTerrainMaxDistConstraint("Water", true, 12.0));
	rmAddObjectDefConstraint(bonusWalrusID, shortAvoidGold);
	rmAddObjectDefConstraint(bonusWalrusID, avoidHuntable);

	// Medium hunt.
	int mediumHuntID = createObjectDefVerify("medium hunt");
	addObjectDefItemVerify(mediumHuntID, "Deer", rmRandInt(4, 8), 2.0);
	rmAddObjectDefConstraint(mediumHuntID, avoidAll);
	rmAddObjectDefConstraint(mediumHuntID, avoidCenter);
	rmAddObjectDefConstraint(mediumHuntID, createClassDistConstraint(classStartingSettlement, 70.0));
	rmAddObjectDefConstraint(mediumHuntID, avoidImpassableLand);
	rmAddObjectDefConstraint(mediumHuntID, farAvoidSettlement);
	rmAddObjectDefConstraint(mediumHuntID, avoidHuntable);

	// Bonus hunt.
	int bonusHuntID = createObjectDefVerify("bonus hunt");
	if(randChance()) {
		addObjectDefItemVerify(bonusHuntID, "Elk", rmRandInt(4, 9), 2.0);
	} else {
		addObjectDefItemVerify(bonusHuntID, "Caribou", rmRandInt(4, 9), 2.0);
	}
	rmAddObjectDefConstraint(bonusHuntID, avoidAll);
	rmAddObjectDefConstraint(bonusHuntID, avoidCenter);
	rmAddObjectDefConstraint(bonusHuntID, createClassDistConstraint(classStartingSettlement, 70.0));
	rmAddObjectDefConstraint(bonusHuntID, avoidImpassableLand);
	rmAddObjectDefConstraint(bonusHuntID, farAvoidSettlement);
	rmAddObjectDefConstraint(bonusHuntID, avoidHuntable);

	// Far herdables.
	int farHerdablesID = createObjectDefVerify("far herdables");
	addObjectDefItemVerify(farHerdablesID, "Cow", rmRandInt(1, 2), 4.0);
	rmAddObjectDefConstraint(farHerdablesID, avoidAll);
	rmAddObjectDefConstraint(farHerdablesID, avoidCenter);
	rmAddObjectDefConstraint(farHerdablesID, avoidImpassableLand);
	rmAddObjectDefConstraint(farHerdablesID, avoidTowerLOS);
	rmAddObjectDefConstraint(farHerdablesID, createClassDistConstraint(classStartingSettlement, 70.0));
	rmAddObjectDefConstraint(farHerdablesID, avoidHerdable);

	// Far predators.
	int farPredatorsID = createObjectDefVerify("far predators");
	if(randChance()) {
		addObjectDefItemVerify(farPredatorsID, "Wolf", 2, 4.0);
	} else {
		addObjectDefItemVerify(farPredatorsID, "Bear", 1, 0.0);
	}
	rmAddObjectDefConstraint(farPredatorsID, avoidAll);
	rmAddObjectDefConstraint(farPredatorsID, avoidCenter);
	rmAddObjectDefConstraint(farPredatorsID, avoidImpassableLand);
	rmAddObjectDefConstraint(farPredatorsID, avoidTowerLOS);
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
	rmAddObjectDefConstraint(randomTreeID, avoidImpassableLand);
	rmAddObjectDefConstraint(randomTreeID, farAvoidSettlement);
	
	// Relics.
	int relicID = createObjectDefVerify("relic");
	addObjectDefItemVerify(relicID, "Relic", 1, 0.0);
	rmAddObjectDefConstraint(relicID, avoidAll);
	rmAddObjectDefConstraint(relicID, avoidImpassableLand);
	rmAddObjectDefConstraint(relicID, createClassDistConstraint(classStartingSettlement, 70.0));
	rmAddObjectDefConstraint(relicID, avoidRelic);

	progress(0.1);

	// Create center.
	initAreaClass();

	setAreaEnforceConstraints(true);

	addAreaConstraint(createSymmetricBoxConstraint(0.075, 0.075, 0.01));

	float blobSizeMeters = 0.5 * axisLength / 6; // Educated guess, 1 + 8 + 12 + 16 + 20 = 57, -> ~6 layers with 64 blobs.

	setAreaTerrainType("SnowA", blobSizeMeters, blobSizeMeters);
	setAreaParams(2.0, 2);

	// Center area (don't change this unless we add more blobs).
	setAreaBlobs(64);
	setAreaCoherence(1.0, 1.0);
	setAreaSearchRadius(0.0, 0.0); // Set tiny search radius so it gets placed at the center.
	setAreaRequiredRatio(0.0); // This will work just fine (we will always end up with a reasonable shape).

	buildAreas(1, 0.0);

	progress(0.2);

	// Setup fake player areas so we have enough space for towers.
	float fakePlayerAreaSize = areaRadiusMetersToFraction(45.0);

	for(i = 1; < cPlayers) {
		int fakePlayerAreaID = rmCreateArea("fake player area " + i);
		rmSetAreaSize(fakePlayerAreaID, fakePlayerAreaSize, fakePlayerAreaSize);
		rmSetAreaLocPlayer(fakePlayerAreaID, getPlayer(i));
		rmSetAreaTerrainType(fakePlayerAreaID, "SnowA");
		rmSetAreaHeightBlend(fakePlayerAreaID, 2);
		rmSetAreaCoherence(fakePlayerAreaID, 1.0);
		rmSetAreaBaseHeight(fakePlayerAreaID, 2.0);
		rmSetAreaWarnFailure(fakePlayerAreaID, false);
	}

	rmBuildAllAreas();

	// Set up actual player areas
	float playerAreaSize = rmAreaTilesToFraction(3000);

	for(i = 1; < cPlayers) {
		int playerAreaID = rmCreateArea("player area " + i);
		rmSetAreaSize(playerAreaID, 0.9 * playerAreaSize, 1.1 * playerAreaSize);
		rmSetAreaLocPlayer(playerAreaID, getPlayer(i));
		rmSetAreaTerrainType(playerAreaID, "SnowGrass50");
		rmAddAreaTerrainLayer(playerAreaID, "SnowGrass25", 0, 12);
		rmSetAreaMinBlobs(playerAreaID, 1);
		rmSetAreaMaxBlobs(playerAreaID, 5);
		rmSetAreaMinBlobDistance(playerAreaID, 16.0);
		rmSetAreaMaxBlobDistance(playerAreaID, 40.0);
		rmAddAreaConstraint(playerAreaID, avoidImpassableLand);
		rmSetAreaWarnFailure(playerAreaID, false);
	}

	rmBuildAllAreas();

	progress(0.3);

	// TCs.
	placeObjectAtPlayerLocs(startingSettlementID, true);

	// Towers.
	placeAndStoreObjectMirrored(startingTowerID, true, 4, 23.0, 27.0, true, -1, startingTowerBackupID);

	// Settlements.
	int settlementID = rmCreateObjectDef("settlements");
	rmAddObjectDefItem(settlementID, "Settlement", 1, 0.0);

	int settlementAvoidImpassableLand = createTerrainDistConstraint("Land", false, 20.0); // 35.0 and more to avoid water range.

	float tcDist = 65.0;
	int settlementAvoidCenter = createClassDistConstraint(classCenter, 10.0 + 0.5 * (tcDist - 2.0 * centerRadius));

	// Try twice (should not be necessary but just in case).
	int numFairLocTries = 2;
	bool settleBool = randChance(0.75);

	for(i = 0; < numFairLocTries) {

		if(gameIs1v1() == false) {
			addFairLocConstraint(avoidTowerLOS);
		}

		addFairLocConstraint(settlementAvoidCenter);
		addFairLocConstraint(settlementAvoidImpassableLand);

		if(gameIs1v1()) {
			addFairLoc(60.0, 80.0, false, true, 70.0);
		} else {
			addFairLoc(60.0, 80.0, false, true, 55.0);
		}

		// Far settlement.
		addFairLocConstraint(settlementAvoidCenter);
		addFairLocConstraint(createClassDistConstraint(classStartingSettlement, 60.0));
		addFairLocConstraint(settlementAvoidImpassableLand);

		// For anything but 1v1, the forward/backward variation has no impact because the map is so small.
		if(gameIs1v1()) {
			if(settleBool) {
				addFairLoc(70.0, 120.0, true, true, 70.0);
			} else {
				addFairLoc(65.0, 100.0, false, true, 70.0);
			}
		} else if(cNonGaiaPlayers < 5) {
			addFairLoc(70.0, 80.0, true, settleBool, rmRandFloat(70.0, 80.0));
		} else {
			addFairLoc(70.0, 90.0, true, settleBool, 65.0);
		}

		if(placeObjectAtNewFairLocs(settlementID, false, "settlements " + i, i == numFairLocTries - 1)) {
			// The above call resets fair locs when done so we don't have to do it manually.
			break;
		}

		if(settleBool) {
			settleBool = false;
		} else {
			settleBool = true;
		}
	}

	progress(0.4);

	// Forests.
	initForestClass();

	addForestConstraint(createClassDistConstraint(classCenter, 2.5));
	addForestConstraint(avoidAll);
	addForestConstraint(avoidStartingSettlement);
	addForestConstraint(avoidImpassableLand);

	addForestType("Snow Pine Forest", 1.0);

	setForestAvoidSelf(20.0);

	setForestBlobs(10, 12);
	setForestBlobParams(4.75, 4.25);
	setForestSearchRadius(rmXFractionToMeters(0.15), -1.0);

	// Player forests.
	setForestCoherence(0.5, 1.0);
	setForestSearchRadius(30.0, 40.0);
	setForestMinRatio(2.0 / 3.0);

	int numPlayerForests = 2;

	buildPlayerForests(numPlayerForests, 0.1);

	progress(0.5);

	// Normal forests.
	setForestCoherence(0.0, 1.0);
	setForestSearchRadius(25.0, -1.0);
	setForestMinRatio(2.0 / 3.0);

	int numForests = 15 * cNonGaiaPlayers / 2;

	buildForests(numForests, 0.3);

	progress(0.8);

	// Object placement.
	// Starting gold close to tower.
	storeObjectDefItem("Gold Mine Small", 1, 0.0);
	storeObjectConstraint(createTypeDistConstraint("Tower", rmRandFloat(8.0, 10.0))); // Don't get too close.
	storeObjectConstraint(avoidAll);
	storeObjectConstraint(avoidEdge);
	storeObjectConstraint(avoidImpassableLand);
	placeStoredObjectMirroredNearStoredLocs(4, false, 24.0, 25.0, 12.5);

	// Gold.
	int numMediumGold = 0;
	int numBonusGold = 0;
	float goldFloat = rmRandFloat(0.0, 1.0);

	if(goldFloat < 1.0 / 3.0) {
		numMediumGold = 2;
		numBonusGold = 1;
	} else if(goldFloat < 2.0 / 3.0) {
		if(randChance()) {
			numMediumGold = 2;
			numBonusGold = 2;
		} else {
			numMediumGold = 1;
			numBonusGold = 3;
		}
	} else {
		numMediumGold = 2;
		numBonusGold = 3;
	}

	// Medium gold.
	placeObjectMirrored(mediumGoldID, false, numMediumGold, 50.0, 50.0 + 10.0 * numMediumGold);

	// Bonus gold.
	placeFarObjectMirrored(bonusGoldID, false, numBonusGold);

	// Medium walrus.
	placeObjectMirrored(mediumWalrusID, false, 1, 60.0, 90.0);

	// Bonus walrus.
	placeFarObjectMirrored(bonusWalrusID, false, 2);

	// Medium hunt.
	placeObjectMirrored(mediumHuntID, false, 1, 70.0, 80.0, true);

	// Bonus hunt.
	placeFarObjectMirrored(bonusHuntID, false, 1);

	// Starting food.
	placeObjectMirrored(startingFoodID, false, 1, 22.0, 26.0);

	// Straggler trees.
	placeObjectMirrored(stragglerTreeID, false, rmRandInt(2, 5), 13.0, 13.5, true);

	// Far herdables.
	placeFarObjectMirrored(farHerdablesID, false, rmRandInt(1, 2));

	// Starting herdables.
	placeObjectMirrored(startingHerdablesID, true, 1, 20.0, 30.0);

	// Far predators.
	placeFarObjectMirrored(farPredatorsID, false, 2);

	// Fish.
	int numFish = rmRandInt(8, 9);
	int avoidFish = createTypeDistConstraint("Fish", 24.0);
	int fishLandMin = createTerrainDistConstraint("Land", true, 17.0);
	int fishLandMax = createTerrainMaxDistConstraint("Land", true, 23.0);
	int fishEdgeConstraint = createSymmetricBoxConstraint(0.01, 0.01);

	int fishID = rmCreateObjectDef("fish");
	rmAddObjectDefItem(fishID, "Fish - Salmon", 3, 8.0);
	rmAddObjectDefConstraint(fishID, avoidTowerLOS);
	rmAddObjectDefConstraint(fishID, fishLandMin);
	rmAddObjectDefConstraint(fishID, fishLandMax);
	rmAddObjectDefConstraint(fishID, avoidFish);
	rmAddObjectDefConstraint(fishID, fishEdgeConstraint);
	placeFarObjectMirrored(fishID, false, numFish, rmXFractionToMeters(0.325));

	// Lone fish.
	int numLoneFish = 5;

	if(cNonGaiaPlayers > 4) {
		numLoneFish = 3;
	}

	int loneFishID = rmCreateObjectDef("lone fish");
	rmAddObjectDefItem(loneFishID, "Fish - Perch", 1, 0.0);
	rmAddObjectDefConstraint(loneFishID, fishLandMin);
	rmAddObjectDefConstraint(loneFishID, avoidFish);
	// rmAddObjectDefConstraint(loneFishID, fishEdgeConstraint);

	// Backup without constraints to make sure it always places.
	int loneFishBackupID = rmCreateObjectDef("lone fish backup");
	rmAddObjectDefItem(loneFishBackupID, "Fish - Perch", 1, 0.0);

	placeFarObjectMirrored(loneFishID, false, numLoneFish, rmXFractionToMeters(0.325), -1.0, loneFishBackupID);

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
	// Rocks.
	int rockID = rmCreateObjectDef("rock sprite");
	rmAddObjectDefItem(rockID, "Rock Granite Sprite", 1, 1.0);
	setObjectDefDistanceToMax(rockID);
	rmAddObjectDefConstraint(rockID, embellishmentAvoidAll);
	rmAddObjectDefConstraint(rockID, avoidImpassableLand);
	rmPlaceObjectDefAtLoc(rockID, 0, 0.5, 0.5, 30 * cNonGaiaPlayers);

	// Orcas.
	int orcaID = rmCreateObjectDef("orca");
	rmAddObjectDefItem(orcaID, "Orca", 1, 0.0);
	setObjectDefDistanceToMax(orcaID);
	rmAddObjectDefConstraint(orcaID, createTerrainDistConstraint("Land", true, 20.0));
	rmAddObjectDefConstraint(orcaID, createTypeDistConstraint("Orca", 20.0));
	rmAddObjectDefConstraint(orcaID, avoidEdge);
	rmPlaceObjectDefAtLoc(orcaID, 0, 0.5, 0.5, cNonGaiaPlayers);

	// Seaweed.
	if(waterType >= 0.5) {
		int seaweedShoreMin = createTerrainDistConstraint("Land", true, 8.0);
		int seaweedShoreMax = createTerrainMaxDistConstraint("Land", true, 12.0);

		int seaweed1ID = rmCreateObjectDef("seaweed 1");
		rmAddObjectDefItem(seaweed1ID, "Seaweed", 5, 3.0);
		setObjectDefDistanceToMax(seaweed1ID);
		rmAddObjectDefConstraint(seaweed1ID, embellishmentAvoidAll);
		rmAddObjectDefConstraint(seaweed1ID, seaweedShoreMin);
		rmAddObjectDefConstraint(seaweed1ID, seaweedShoreMax);
		rmPlaceObjectDefAtLoc(seaweed1ID, 0, 0.5, 0.5, 8 * cNonGaiaPlayers);

		int seaweed2ID = rmCreateObjectDef("seaweed 2");
		rmAddObjectDefItem(seaweed2ID, "Seaweed", 2, 3.0);
		setObjectDefDistanceToMax(seaweed2ID);
		rmAddObjectDefConstraint(seaweed2ID, embellishmentAvoidAll);
		rmAddObjectDefConstraint(seaweed2ID, seaweedShoreMin);
		rmAddObjectDefConstraint(seaweed2ID, seaweedShoreMax);
		rmPlaceObjectDefAtLoc(seaweed2ID, 0, 0.5, 0.5, 12 * cNonGaiaPlayers);
	}

	// Birds.
	int birdsID = rmCreateObjectDef("birds");
	rmAddObjectDefItem(birdsID, "Hawk", 1, 0.0);
	setObjectDefDistanceToMax(birdsID);
	rmPlaceObjectDefAtLoc(birdsID, 0, 0.5, 0.5, 2 * cNonGaiaPlayers);


	// Finalize RM X.
	rmxFinalize();

	progress(1.0);
}
