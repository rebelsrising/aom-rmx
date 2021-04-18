/*
** WATERING HOLE MIRROR
** RebelsRising
** Last edit: 09/03/2021
*/

include "rmx.xs";

void main() {
	progress(0.0);

	// Initial map setup.
	rmxInit("Watering Hole X");

	// Set mirror mode.
	setMirrorMode(cMirrorPoint);

	// Perform mirror check.
	if(mirrorConfigIsInvalid()) {
		injectMirrorGenError();

		// Invalid configuration, quit.
		return;
	}

	// Set size.
	int mapSize = getStandardMapDimInMeters(9450);

	// Initialize water.
	rmSetSeaLevel(1.0);
	rmSetSeaType("Savannah Water Hole");

	// Initialize map.
	initializeMap("Water", mapSize);

	// Place players.
	if(cNonGaiaPlayers < 9) {
		placePlayersInCircle(0.4, 0.45);
	} else {
		placePlayersInCircle(0.4);
	}

	// Initialize areas.
	float centerRadius = 22.5;

	int classCenter = initializeCenter(centerRadius);
	int classCorner = initializeCorners(25.0);

	// Define classes.
	int classPlayerCore = rmDefineClass("player core");
	int classLargeCenter = rmDefineClass("actual center");
	int classPlayer = rmDefineClass("player");
	int classIsland = rmDefineClass("island");
	int classStartingSettlement = rmDefineClass("starting settlement");
	int classConnection = rmDefineClass("connection");

	// General.
	int avoidAll = createTypeDistConstraint("All", 7.0);
	int avoidEdge = createSymmetricBoxConstraint(rmXTilesToFraction(4), rmZTilesToFraction(4));
	int avoidCenter = createClassDistConstraint(classCenter, 1.0);
	int shortAvoidLargeCenter = createClassDistConstraint(classLargeCenter, 1.0);
	int farAvoidLargeCenter = createClassDistConstraint(classLargeCenter, 20.0);
	int shortAvoidPlayer = createClassDistConstraint(classPlayer, 1.0);
	int farAvoidPlayer = createClassDistConstraint(classPlayer, 20.0);
	int avoidConnection = createClassDistConstraint(classConnection, 1.0);
	int shortAvoidIsland = createClassDistConstraint(classIsland, 20.0);
	int avoidPlayerCore = createClassDistConstraint(classPlayerCore, 0.1);
	if(cNonGaiaPlayers > 2) {
		avoidPlayerCore = createClassDistConstraint(classPlayerCore, 70.0);
	}

	// Terrain.
	int shortAvoidWater = createTerrainDistConstraint("Land", false, 1.0);
	int mediumAvoidWater = createTerrainDistConstraint("Land", false, 5.0);
	int farAvoidWater = createTerrainDistConstraint("Land", false, 10.0);
	int nearShore = createTerrainMaxDistConstraint("Water", true, 6.0);

	// Settlements.
	int avoidStartingSettlement = createClassDistConstraint(classStartingSettlement, 20.0);
	int avoidSettlement = createTypeDistConstraint("AbstractSettlement", 15.0);
	int goldAvoidSettlement = createTypeDistConstraint("AbstractSettlement", 15.0);

	// Gold.
	int shortAvoidGold = createTypeDistConstraint("Gold", 10.0);
	int farAvoidGold = createTypeDistConstraint("Gold", 30.0);

	// Food.
	int avoidFood = createTypeDistConstraint("Food", 20.0);
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
	int startingSettlementID = rmCreateObjectDef("starting settlement");
	rmAddObjectDefItem(startingSettlementID, "Settlement Level 1", 1, 0.0);
	rmAddObjectDefToClass(startingSettlementID, classStartingSettlement);

	// Towers.
	int startingTowerID = rmCreateObjectDef("starting tower");
	rmAddObjectDefItem(startingTowerID, "Tower", 1, 0.0);
	rmAddObjectDefConstraint(startingTowerID, avoidAll);
	rmAddObjectDefConstraint(startingTowerID, farAvoidWater);
	rmAddObjectDefConstraint(startingTowerID, farAvoidTower);

	int startingTowerBackupID = rmCreateObjectDef("starting tower backup");
	rmAddObjectDefItem(startingTowerBackupID, "Tower", 1, 0.0);
	rmAddObjectDefConstraint(startingTowerBackupID, avoidAll);
	rmAddObjectDefConstraint(startingTowerBackupID, farAvoidWater);
	rmAddObjectDefConstraint(startingTowerBackupID, shortAvoidTower);

	// Starting hunt.
	int startingHuntID = rmCreateObjectDef("starting hunt");
	rmAddObjectDefItem(startingHuntID, "Gazelle", rmRandInt(3, 8), 2.0);
	rmAddObjectDefConstraint(startingHuntID, avoidAll);
	rmAddObjectDefConstraint(startingHuntID, avoidEdge);
	rmAddObjectDefConstraint(startingHuntID, shortAvoidGold);
	rmAddObjectDefConstraint(startingHuntID, avoidFood);
	rmAddObjectDefConstraint(startingHuntID, farAvoidWater);

	// Starting herdables.
	int startingHerdablesID = rmCreateObjectDef("starting herdables");
	rmAddObjectDefItem(startingHerdablesID, "Pig", rmRandInt(0, 2), 2.0);
	rmAddObjectDefConstraint(startingHerdablesID, avoidAll);
	rmAddObjectDefConstraint(startingHerdablesID, avoidEdge);

	// Straggler trees.
	int stragglerTreeID = rmCreateObjectDef("straggler tree");
	rmAddObjectDefItem(stragglerTreeID, "Savannah Tree", 1, 0.0);
	rmAddObjectDefConstraint(stragglerTreeID, avoidAll);
	rmAddObjectDefConstraint(stragglerTreeID, farAvoidWater);

	// Gold.
	// Medium gold.
	int mediumGoldID = rmCreateObjectDef("medium gold");
	rmAddObjectDefItem(mediumGoldID, "Gold Mine", 1, 0.0);
	rmAddObjectDefConstraint(mediumGoldID, avoidAll);
	rmAddObjectDefConstraint(mediumGoldID, avoidEdge);
	rmAddObjectDefConstraint(mediumGoldID, createClassDistConstraint(classStartingSettlement, 50.0));
	rmAddObjectDefConstraint(mediumGoldID, goldAvoidSettlement);
	rmAddObjectDefConstraint(mediumGoldID, farAvoidGold);
	rmAddObjectDefConstraint(mediumGoldID, shortAvoidLargeCenter);
	rmAddObjectDefConstraint(mediumGoldID, farAvoidWater);
	rmAddObjectDefConstraint(mediumGoldID, avoidConnection);

	// Far gold.
	int farGoldID = rmCreateObjectDef("far gold");
	rmAddObjectDefItem(farGoldID, "Gold Mine", 1, 0.0);
	rmAddObjectDefConstraint(farGoldID, avoidAll);
	rmAddObjectDefConstraint(farGoldID, avoidEdge);
	rmAddObjectDefConstraint(farGoldID, createClassDistConstraint(classStartingSettlement, 80.0));
	rmAddObjectDefConstraint(farGoldID, goldAvoidSettlement);
	rmAddObjectDefConstraint(farGoldID, farAvoidGold);
	rmAddObjectDefConstraint(farGoldID, shortAvoidLargeCenter);
	rmAddObjectDefConstraint(farGoldID, farAvoidWater);
	rmAddObjectDefConstraint(farGoldID, avoidConnection);

	// Bonus gold.
	int bonusGoldID = rmCreateObjectDef("bonus gold");
	rmAddObjectDefItem(bonusGoldID, "Gold Mine", 1, 0.0);
	rmAddObjectDefConstraint(bonusGoldID, avoidAll);
	rmAddObjectDefConstraint(bonusGoldID, avoidEdge);
	rmAddObjectDefConstraint(bonusGoldID, avoidCenter);
	rmAddObjectDefConstraint(bonusGoldID, goldAvoidSettlement);
	rmAddObjectDefConstraint(bonusGoldID, farAvoidPlayer);
	rmAddObjectDefConstraint(bonusGoldID, farAvoidGold);
	rmAddObjectDefConstraint(bonusGoldID, farAvoidWater);
	rmAddObjectDefConstraint(bonusGoldID, avoidConnection);

	// Hunt, berries and predators.
	// Close hunt.
	float closeHuntFloat = rmRandFloat(0.0, 1.0);

	int closeHuntID = rmCreateObjectDef("close hunt");
	if(closeHuntFloat < 0.3) {
		rmAddObjectDefItem(closeHuntID, "Hippo", 2, 2.0);
	} else if(closeHuntFloat < 0.6) {
		rmAddObjectDefItem(closeHuntID, "Hippo", 3, 2.0);
	} else {
		rmAddObjectDefItem(closeHuntID, "Rhinocerous", 2, 2.0);
	}
	rmAddObjectDefConstraint(closeHuntID, avoidAll);
	rmAddObjectDefConstraint(closeHuntID, avoidEdge);
	rmAddObjectDefConstraint(closeHuntID, avoidFood);
	rmAddObjectDefConstraint(closeHuntID, farAvoidLargeCenter);
	rmAddObjectDefConstraint(closeHuntID, shortAvoidWater);

	// Medium hunt.
	int numMediumHunt = rmRandInt(6, 10);

	// Medium hunt 1.
	int mediumHunt1ID = rmCreateObjectDef("medium hunt 1");
	rmAddObjectDefItem(mediumHunt1ID, "Gazelle", numMediumHunt, 4.0);
	rmAddObjectDefConstraint(mediumHunt1ID, avoidAll);
	rmAddObjectDefConstraint(mediumHunt1ID, avoidEdge);
	rmAddObjectDefConstraint(mediumHunt1ID, avoidFood);
	rmAddObjectDefConstraint(mediumHunt1ID, farAvoidLargeCenter);
	rmAddObjectDefConstraint(mediumHunt1ID, createClassDistConstraint(classStartingSettlement, 50.0));
	rmAddObjectDefConstraint(mediumHunt1ID, shortAvoidWater);
	rmAddObjectDefConstraint(mediumHunt1ID, avoidTowerLOS);

	// Medium hunt 2.
	int mediumHunt2ID = rmCreateObjectDef("medium hunt 2");
	rmAddObjectDefItem(mediumHunt2ID, "Zebra", numMediumHunt, 4.0);
	rmAddObjectDefConstraint(mediumHunt2ID, avoidAll);
	rmAddObjectDefConstraint(mediumHunt2ID, avoidEdge);
	rmAddObjectDefConstraint(mediumHunt2ID, avoidFood);
	rmAddObjectDefConstraint(mediumHunt2ID, shortAvoidLargeCenter);
	rmAddObjectDefConstraint(mediumHunt2ID, createClassDistConstraint(classStartingSettlement, 50.0));
	rmAddObjectDefConstraint(mediumHunt2ID, shortAvoidWater);
	rmAddObjectDefConstraint(mediumHunt2ID, avoidTowerLOS);

	// Far crane.
	int farCraneID = rmCreateObjectDef("far crane");
	rmAddObjectDefItem(farCraneID, "Crowned Crane", rmRandInt(6, 8), 2.0);
	rmAddObjectDefConstraint(farCraneID, avoidAll);
	rmAddObjectDefConstraint(farCraneID, avoidEdge);
	rmAddObjectDefConstraint(farCraneID, shortAvoidWater);
	rmAddObjectDefConstraint(farCraneID, avoidFood);
	rmAddObjectDefConstraint(farCraneID, shortAvoidLargeCenter);
	rmAddObjectDefConstraint(farCraneID, createClassDistConstraint(classStartingSettlement, 70.0));
	rmAddObjectDefConstraint(farCraneID, nearShore);

	// Bonus hunt 1.
	float bonusHunt1Float = rmRandFloat(0.0, 1.0);

	int bonusHunt1ID = rmCreateObjectDef("bonus hunt 1");
	if(bonusHunt1Float < 0.5) {
		rmAddObjectDefItem(bonusHunt1ID, "Elephant", 2, 2.0);
	} else if(bonusHunt1Float < 0.75) {
		rmAddObjectDefItem(bonusHunt1ID, "Giraffe", rmRandInt(3, 4), 2.0);
	} else {
		rmAddObjectDefItem(bonusHunt1ID, "Hippo", rmRandInt(3, 5), 2.0);
	}
	rmAddObjectDefConstraint(bonusHunt1ID, avoidAll);
	rmAddObjectDefConstraint(bonusHunt1ID, avoidEdge);
	rmAddObjectDefConstraint(bonusHunt1ID, shortAvoidLargeCenter);
	rmAddObjectDefConstraint(bonusHunt1ID, createClassDistConstraint(classStartingSettlement, 70.0));
	rmAddObjectDefConstraint(bonusHunt1ID, avoidFood);
	rmAddObjectDefConstraint(bonusHunt1ID, farAvoidWater);

	// Bonus hunt 2.
	float bonusHunt2Float = rmRandFloat(0.0, 1.0);

	int bonusHunt2ID = rmCreateObjectDef("bonus hunt 2");
	if(bonusHunt2Float < 0.5) {
		rmAddObjectDefItem(bonusHunt2ID, "Elephant", 2, 2.0);
	} else if(bonusHunt2Float < 0.75) {
		rmAddObjectDefItem(bonusHunt2ID, "Water Buffalo", rmRandInt(5, 6), 4.0);

		if(randChance()) {
			rmAddObjectDefItem(bonusHunt2ID, "Zebra", rmRandInt(2, 4), 4.0);
		}
	} else {
		rmAddObjectDefItem(bonusHunt2ID, "Gazelle", rmRandInt(6, 9), 2.0);
	}
	rmAddObjectDefConstraint(bonusHunt2ID, avoidAll);
	rmAddObjectDefConstraint(bonusHunt2ID, avoidEdge);
	// rmAddObjectDefConstraint(bonusHunt2ID, avoidCenter);
	rmAddObjectDefConstraint(bonusHunt2ID, farAvoidPlayer);
	if(cNonGaiaPlayers < 3) {
		rmAddObjectDefConstraint(bonusHunt2ID, nearShore);
	}
	rmAddObjectDefConstraint(bonusHunt2ID, avoidFood);
	rmAddObjectDefConstraint(bonusHunt2ID, shortAvoidWater);

	// Bonus hunt 3.
	float bonusHunt3Float = rmRandFloat(0.0, 1.0);

	int bonusHunt3ID = rmCreateObjectDef("bonus hunt 3");
	if(bonusHunt3Float < 0.5) {
		rmAddObjectDefItem(bonusHunt3ID, "Hippo", 3, 2.0);
	} else if(bonusHunt3Float < 0.75) {
		rmAddObjectDefItem(bonusHunt3ID, "Zebra", rmRandInt(4, 6), 4.0);

		if(randChance()) {
			rmAddObjectDefItem(bonusHunt3ID, "Giraffe", rmRandInt(2, 4), 4.0);
		}
	} else {
		rmAddObjectDefItem(bonusHunt3ID, "Rhinocerous", 4, 2.0);
	}
	rmAddObjectDefConstraint(bonusHunt3ID, avoidAll);
	rmAddObjectDefConstraint(bonusHunt3ID, avoidEdge);
	// rmAddObjectDefConstraint(bonusHunt3ID, avoidCenter);
	rmAddObjectDefConstraint(bonusHunt3ID, farAvoidPlayer);
	rmAddObjectDefConstraint(bonusHunt3ID, avoidFood);
	rmAddObjectDefConstraint(bonusHunt3ID, farAvoidWater);

	// Far predators 1.
	int farPredators1ID = rmCreateObjectDef("far predators 1");
	rmAddObjectDefItem(farPredators1ID, "Crocodile", 1, 4.0);
	rmAddObjectDefConstraint(farPredators1ID, avoidAll);
	rmAddObjectDefConstraint(farPredators1ID, avoidEdge);
	rmAddObjectDefConstraint(farPredators1ID, shortAvoidLargeCenter);
	rmAddObjectDefConstraint(farPredators1ID, createClassDistConstraint(classStartingSettlement, 80.0));
	rmAddObjectDefConstraint(farPredators1ID, avoidSettlement);
	rmAddObjectDefConstraint(farPredators1ID, avoidPredator);
	rmAddObjectDefConstraint(farPredators1ID, nearShore);

	// Far predators 2.
	int farPredators2ID = rmCreateObjectDef("far predators 2");
	rmAddObjectDefItem(farPredators2ID, "Lion", rmRandInt(1, 2), 4.0);
	rmAddObjectDefConstraint(farPredators2ID, avoidAll);
	rmAddObjectDefConstraint(farPredators2ID, avoidEdge);
	rmAddObjectDefConstraint(farPredators2ID, avoidCenter);
	rmAddObjectDefConstraint(farPredators2ID, createClassDistConstraint(classStartingSettlement, 80.0));
	rmAddObjectDefConstraint(farPredators2ID, avoidSettlement);
	rmAddObjectDefConstraint(farPredators2ID, avoidPredator);
	rmAddObjectDefConstraint(farPredators2ID, shortAvoidWater);

	// Medium herdables.
	int mediumHerdablesID = rmCreateObjectDef("medium herdables");
	rmAddObjectDefItem(mediumHerdablesID, "Pig", rmRandInt(2, 3), 4.0);
	rmAddObjectDefConstraint(mediumHerdablesID, avoidAll);
	rmAddObjectDefConstraint(mediumHerdablesID, avoidEdge);
	rmAddObjectDefConstraint(mediumHerdablesID, createClassDistConstraint(classStartingSettlement, 50.0));
	rmAddObjectDefConstraint(mediumHerdablesID, avoidTowerLOS);
	rmAddObjectDefConstraint(mediumHerdablesID, farAvoidWater);
	rmAddObjectDefConstraint(mediumHerdablesID, shortAvoidLargeCenter);

	// Far herdables.
	int farHerdablesID = rmCreateObjectDef("far herdables");
	rmAddObjectDefItem(farHerdablesID, "Pig", rmRandInt(1, 2), 4.0);
	rmAddObjectDefConstraint(farHerdablesID, avoidAll);
	rmAddObjectDefConstraint(farHerdablesID, avoidEdge);
	rmAddObjectDefConstraint(farHerdablesID, createClassDistConstraint(classStartingSettlement, 70.0));
	rmAddObjectDefConstraint(farHerdablesID, avoidFood);
	rmAddObjectDefConstraint(farHerdablesID, farAvoidPlayer);
	rmAddObjectDefConstraint(farHerdablesID, farAvoidWater);

	// Other objects.
	// Random trees 1.
	int randomTree1ID = rmCreateObjectDef("random tree 1");
	rmAddObjectDefItem(randomTree1ID, "Savannah Tree", 1, 0.0);
	setObjectDefDistanceToMax(randomTree1ID);
	rmAddObjectDefConstraint(randomTree1ID, avoidAll);
	rmAddObjectDefConstraint(randomTree1ID, avoidStartingSettlement);
	rmAddObjectDefConstraint(randomTree1ID, avoidSettlement);
	rmAddObjectDefConstraint(randomTree1ID, shortAvoidWater);

	// Random trees 2.
	int randomTree2ID = rmCreateObjectDef("random tree 2");
	rmAddObjectDefItem(randomTree2ID, "Palm", 1, 0.0);
	setObjectDefDistanceToMax(randomTree2ID);
	rmAddObjectDefConstraint(randomTree2ID, avoidAll);
	rmAddObjectDefConstraint(randomTree2ID, avoidStartingSettlement);
	rmAddObjectDefConstraint(randomTree2ID, avoidSettlement);
	rmAddObjectDefConstraint(randomTree2ID, shortAvoidWater);

	// Relics.
	int relicID = rmCreateObjectDef("relic");
	rmAddObjectDefItem(relicID, "Relic", 1, 0.0);
	rmAddObjectDefConstraint(relicID, avoidAll);
	rmAddObjectDefConstraint(relicID, avoidEdge);
	rmAddObjectDefConstraint(relicID, createClassDistConstraint(classStartingSettlement, 80.0));
	rmAddObjectDefConstraint(relicID, avoidRelic);
	rmAddObjectDefConstraint(relicID, shortAvoidWater);

	progress(0.1);

	// Define player connections.
	int shallowsID = rmCreateConnection("shallows");
	if(cNonGaiaPlayers < 3) {
		rmSetConnectionType(shallowsID, cConnectAreas, false);
	} else {
		rmSetConnectionType(shallowsID, cConnectAllies, false);
	}
	rmSetConnectionWidth(shallowsID, rmRandFloat(25.0, 40.0), 0);
	rmAddConnectionTerrainReplacement(shallowsID, "RiverSandyA", "SavannahC");
	rmSetConnectionCoherence(shallowsID, 1.0);
	rmSetConnectionBaseHeight(shallowsID, 2.0);
	rmSetConnectionHeightBlend(shallowsID, 2);
	rmSetConnectionSmoothDistance(shallowsID, 3);
	rmAddConnectionToClass(shallowsID, classConnection);
	rmSetConnectionWarnFailure(shallowsID, false);

	// Set up fake player areas.
	for(i = 1; < cPlayers) {
		int fakePlayerAreaID = rmCreateArea("fake player area " + i);
		if(cNonGaiaPlayers < 3) {
			rmSetAreaSize(fakePlayerAreaID, rmAreaTilesToFraction(3000));
		} else {
			rmSetAreaSize(fakePlayerAreaID, rmAreaTilesToFraction(200));
		}
		rmSetAreaLocPlayer(fakePlayerAreaID, getPlayer(i));
		//rmSetAreaTerrainType(fakePlayerAreaID, "SavannahB");
		rmSetAreaCoherence(fakePlayerAreaID, 1.0);
		//rmSetAreaBaseHeight(fakePlayerAreaID, 2.0);
		rmSetAreaHeightBlend(fakePlayerAreaID, 2);
		rmAddAreaToClass(fakePlayerAreaID, classPlayerCore);
		rmSetAreaWarnFailure(fakePlayerAreaID, false);
		rmBuildArea(fakePlayerAreaID);
	}

	// Center.
	int bonusIslandID = 0;
	int numBonusIsland = 4;

	float islandEdgeDist = rmXTilesToFraction(20);

	if(cNonGaiaPlayers > 2) {
		islandEdgeDist = rmXTilesToFraction(30);
		numBonusIsland = 0;
	}

	int islandAvoidEdge = createSymmetricBoxConstraint(islandEdgeDist, islandEdgeDist);

	for(i = 0; < numBonusIsland) {
		float randX = rmRandFloat(0.325, 0.675);
		float randZ = rmRandFloat(0.325, 0.675);

		bonusIslandID = rmCreateArea("bonus island 1 " + i);
		rmSetAreaSize(bonusIslandID, rmAreaTilesToFraction(3000));
		rmSetAreaLocation(bonusIslandID, randX, randZ);
		rmSetAreaTerrainType(bonusIslandID, "SavannahB");
		rmAddAreaTerrainLayer(bonusIslandID, "SavannahC", 0, 6);
		rmSetAreaCoherence(bonusIslandID, 1.0);
		rmSetAreaBaseHeight(bonusIslandID, 2.0);
		rmSetAreaHeightBlend(bonusIslandID, 2);
		rmSetAreaSmoothDistance(bonusIslandID, 12);
		rmAddAreaToClass(bonusIslandID, classIsland);
		rmAddAreaConstraint(bonusIslandID, avoidPlayerCore);
		rmAddAreaConstraint(bonusIslandID, islandAvoidEdge);
		rmSetAreaWarnFailure(bonusIslandID, false);
		rmBuildArea(bonusIslandID);

		bonusIslandID = rmCreateArea("bonus island 2 " + i);
		rmSetAreaSize(bonusIslandID, rmAreaTilesToFraction(3000));
		rmSetAreaLocation(bonusIslandID, 1.0 - randX, 1.0 - randZ);
		rmSetAreaTerrainType(bonusIslandID, "SavannahB");
		rmAddAreaTerrainLayer(bonusIslandID, "SavannahC", 0, 6);
		rmSetAreaCoherence(bonusIslandID, 1.0);
		rmSetAreaBaseHeight(bonusIslandID, 2.0);
		rmSetAreaHeightBlend(bonusIslandID, 2);
		rmSetAreaSmoothDistance(bonusIslandID, 12);
		rmAddAreaToClass(bonusIslandID, classIsland);
		rmAddAreaConstraint(bonusIslandID, avoidPlayerCore);
		rmAddAreaConstraint(bonusIslandID, islandAvoidEdge);
		rmSetAreaWarnFailure(bonusIslandID, false);
		rmBuildArea(bonusIslandID);
	}

	if(cNonGaiaPlayers > 2) {
		bonusIslandID = rmCreateArea("center bonus island");
		rmSetAreaSize(bonusIslandID, rmAreaTilesToFraction(3500 * cNonGaiaPlayers));
		rmSetAreaLocation(bonusIslandID, 0.5, 0.5);
		rmSetAreaTerrainType(bonusIslandID, "SavannahB");
		rmAddAreaTerrainLayer(bonusIslandID, "SavannahC", 0, 6);
		rmSetAreaCoherence(bonusIslandID, 1.0);
		rmSetAreaBaseHeight(bonusIslandID, 2.0);
		rmSetAreaHeightBlend(bonusIslandID, 2);
		rmSetAreaSmoothDistance(bonusIslandID, 12);
		rmAddAreaToClass(bonusIslandID, classIsland);
		rmAddAreaConstraint(bonusIslandID, avoidPlayerCore);
		rmAddAreaConstraint(bonusIslandID, islandAvoidEdge);
		rmAddConnectionArea(shallowsID, bonusIslandID);
		rmSetAreaWarnFailure(bonusIslandID, false);
		rmBuildArea(bonusIslandID);
	}

	// Set up player areas.
	for(i = 1; < cPlayers) {
		int playerAreaID = rmCreateArea("player area " + i);
		rmSetAreaSize(playerAreaID, 1.0);
		rmSetPlayerArea(getPlayer(i), playerAreaID); // Needed for ally connections because we don't create splits.
		rmSetAreaLocPlayer(playerAreaID, getPlayer(i));
		rmSetAreaTerrainType(playerAreaID, "SavannahB");
		rmAddAreaTerrainLayer(playerAreaID, "SavannahC", 0, 12);
		rmSetAreaCoherence(playerAreaID, 0.6);
		rmSetAreaBaseHeight(playerAreaID, 2.0);
		rmSetAreaHeightBlend(playerAreaID, 2);
		rmSetAreaSmoothDistance(playerAreaID, 10);
		rmAddAreaToClass(playerAreaID, classPlayer);
		rmAddAreaConstraint(playerAreaID, shortAvoidIsland);
		rmAddAreaConstraint(playerAreaID, farAvoidPlayer);
		rmAddConnectionArea(shallowsID, playerAreaID);
		rmSetAreaWarnFailure(playerAreaID, false);
	}

	rmBuildAllAreas();
	rmBuildConnection(shallowsID);

	// Rebuild center.
	int fakeCenterID = rmCreateArea("fake center");
	rmSetAreaSize(fakeCenterID, 0.5);
	// rmSetAreaTerrainType(fakeCenterID, "SnowA");
	rmAddAreaToClass(fakeCenterID, classLargeCenter);
	rmSetAreaLocation(fakeCenterID, 0.5, 0.5);
	rmAddAreaConstraint(fakeCenterID, shortAvoidWater);
	rmAddAreaConstraint(fakeCenterID, shortAvoidPlayer);
	rmSetAreaWarnFailure(fakeCenterID, false);
	rmBuildArea(fakeCenterID);

	// Center pond.
	int classPond = initAreaClass();

	if(cNonGaiaPlayers > 2) {
		setAreaWaterType("Savannah Water Hole", 15.0, 6.0);

		setAreaBlobs(10 * cNonGaiaPlayers / 2);
		setAreaCoherence(0.0);
		setAreaSearchRadius(10.0, 10.0);

		buildAreas(1, 0.0);
	}

	progress(0.2);

	// Build connections.
	int connectionAvoidPond = createClassDistConstraint(classPond, 10.0);
	int numConnections = 2;

	if(cNonGaiaPlayers > 2) {
		numConnections = getNumberPlayersOnTeam(0);
	}

	float centerConnectionChance = 0.5;

	if(cNonGaiaPlayers > 9) {
		centerConnectionChance = 1.0;
	}

	for(n = 1; <= numConnections) {
		if(getPlayerTeamPos(n) == cPosCenter && randChance(1.0 - centerConnectionChance)) {
			continue;
		}

		// Create random connection.
		int numAreas = 100;

		float offset = rmRandFloat(0.25, 0.75) * PI;

		// Offset variation.
		if(randChance()) {
			offset = 2.0 * PI - offset;
		}

		float a = getTeamAngle(0) + offset;
		float b = getTeamAngle(1) + offset;
		float r = 0.5;

		if(cNonGaiaPlayers > 2) {
			a = getPlayerAngle(n);
			b = a + PI;
		}

		float x1 = getXFromPolar(r, a, 0.5);
		float z1 = getZFromPolar(r, a, 0.5);
		float x2 = getXFromPolar(r, b, 0.5);
		float z2 = getZFromPolar(r, b, 0.5);

		float incrX = (x2 - x1) / (numAreas - 1);
		float incrZ = (z2 - z1) / (numAreas - 1);

		for(i = 0; < numAreas) {
			int bonusConnectionID = rmCreateArea("random connection " + n + " " + i);
			if(cNonGaiaPlayers < 3) {
				rmSetAreaSize(bonusConnectionID, rmRandFloat(0.005, 0.0075));
			} else {
				rmSetAreaSize(bonusConnectionID, rmXMetersToFraction(rmRandFloat(1.9, 2.1)));
			}
			rmSetAreaBaseHeight(bonusConnectionID, 2.0);
			rmSetAreaCoherence(bonusConnectionID, 1.0);
			rmSetAreaHeightBlend(bonusConnectionID, 2);
			rmSetAreaWarnFailure(bonusConnectionID, false);
			rmAddAreaConstraint(bonusConnectionID, connectionAvoidPond);
			// rmAddAreaToClass(bonusConnectionID, classConnection);
			rmSetAreaTerrainType(bonusConnectionID, "SavannahB");

			rmSetAreaLocation(bonusConnectionID, incrX * i + x1, incrZ * i + z1);
		}
	}

	rmBuildAllAreas();

	// TCs.
	placeObjectAtPlayerLocs(startingSettlementID, true);

	// Towers.
	placeAndStoreObjectMirrored(startingTowerID, true, 4, 23.0, 27.0, true, -1, startingTowerBackupID);

	// Embellishment.
	int beautificationID = 0;

	for(i = 0; < 50 * cPlayers) {
		beautificationID = rmCreateArea("beautification 1 " + i);
		rmSetAreaSize(beautificationID, rmAreaTilesToFraction(20), rmAreaTilesToFraction(40));
		rmSetAreaTerrainType(beautificationID, "SavannahA");
		rmSetAreaMinBlobs(beautificationID, 1);
		rmSetAreaMaxBlobs(beautificationID, 5);
		rmSetAreaMinBlobDistance(beautificationID, 16.0);
		rmSetAreaMaxBlobDistance(beautificationID, 40.0);
		rmAddAreaConstraint(beautificationID, shortAvoidWater);
		rmSetAreaWarnFailure(beautificationID, false);
		rmBuildArea(beautificationID);
	}

	for(i = 0; < 15 * cPlayers) {
		beautificationID = rmCreateArea("beautification 2 " + i);
		rmSetAreaSize(beautificationID, rmAreaTilesToFraction(10), rmAreaTilesToFraction(50));
		rmSetAreaTerrainType(beautificationID, "SandA");
		rmSetAreaMinBlobs(beautificationID, 1);
		rmSetAreaMaxBlobs(beautificationID, 5);
		rmSetAreaMinBlobDistance(beautificationID, 16.0);
		rmSetAreaMaxBlobDistance(beautificationID, 40.0);
		rmAddAreaConstraint(beautificationID, shortAvoidWater);
		rmSetAreaWarnFailure(beautificationID, false);
		rmBuildArea(beautificationID);
	}

	progress(0.3);

	// Settlements.
	int settlementID = rmCreateObjectDef("settlements");
	rmAddObjectDefItem(settlementID, "Settlement", 1, 0.0);

	float tcDist = 65.0;
	int settlementAvoidCenter = createClassDistConstraint(classCenter, 10.0 + 0.5 * (tcDist - 2.0 * centerRadius));

	// Close settlement.
	addFairLocConstraint(farAvoidWater);
	addFairLocConstraint(avoidConnection);
	addFairLocConstraint(avoidTowerLOS);

	if(cNonGaiaPlayers < 9) {
		addFairLoc(60.0, 100.0, false, true, 50.0, 12.0, 12.0, true);
	} else {
		addFairLoc(40.0, 100.0, false, true, 50.0, 12.0, 12.0, true);
	}

	placeObjectAtNewFairLocs(settlementID, false, "close settlement");

	// Far settlement.
	addFairLocConstraint(settlementAvoidCenter);
	addFairLocConstraint(farAvoidWater);
	addFairLocConstraint(shortAvoidPlayer);

	if(cNonGaiaPlayers < 5) {
		addFairLoc(90.0, 130.0, true, randChance(), 65.0, 12.0, 12.0, false, true);
	} else if(cNonGaiaPlayers < 7) {
		addFairLoc(100.0, 140.0, true, randChance(), 70.0, 12.0, 12.0, false, randChance());
	} else {
		addFairLoc(100.0, 160.0, true, true, 60.0, 12.0, 12.0);
	}

	placeObjectAtNewFairLocs(settlementID, false, "far settlement");

	progress(0.4);

	// Forests.
	initForestClass();

	addForestConstraint(avoidCenter);
	addForestConstraint(avoidStartingSettlement);
	addForestConstraint(avoidAll);
	addForestConstraint(mediumAvoidWater);

	addForestType("Savannah Forest", 0.5);
	addForestType("Palm Forest", 0.5);

	setForestBlobs(9);
	setForestBlobParams(4.5, 4.5);
	setForestCoherence(-0.75, 0.75);

	// Original 16.0, but difficult to balance.
	setForestAvoidSelf(20.0);

	// Player forests.
	setForestSearchRadius(35.0, 40.0);
	setForestMinRatio(2.0 / 3.0);

	int numPlayerForests = 2;

	buildPlayerForests(numPlayerForests, 0.1);

	progress(0.5);

	// Inner forests.
	int numInnerForests = 3 * cNonGaiaPlayers / 2;

	setForestSearchRadius(20.0, rmXFractionToMeters(0.35));
	setForestMinRatio(2.0 / 3.0);

	buildForests(numInnerForests, 0.1);

	progress(0.6);

	// Outer forests.
	int numOuterForests = 9 * cNonGaiaPlayers / 2;

	setForestSearchRadius(rmXFractionToMeters(0.3), -1.0);
	setForestMinRatio(2.0 / 3.0);

	buildForests(numOuterForests, 0.2);

	progress(0.8);

	// Object placement.
	// Starting gold close to tower.
	storeObjectDefItem("Gold Mine Small", 1, 0.0);
	storeObjectConstraint(createTypeDistConstraint("Tower", rmRandFloat(8.0, 10.0))); // Don't get too close.
	storeObjectConstraint(avoidAll);
	storeObjectConstraint(avoidEdge);
	storeObjectConstraint(farAvoidWater);
	placeStoredObjectMirroredNearStoredLocs(4, false, 24.0, 25.0, 12.5);

	resetObjectStorage();

	// Medium gold.
	placeObjectMirrored(mediumGoldID, false, 1, 55.0, 75.0);

	// Far gold.
	placeFarObjectMirrored(farGoldID, false, rmRandInt(1, 2));

	// Bonus gold.
	placeFarObjectMirrored(bonusGoldID, false, rmRandInt(1, 2));

	// Close hunt.
	placeObjectMirrored(closeHuntID, false, 1, 30.0, 50.0);

	// Medium hunt.
	if(randChance()) {
		placeObjectMirrored(mediumHunt1ID, false, 1, 50.0, 80.0);
	} else if(randChance(0.2)) {
		placeObjectMirrored(mediumHunt1ID, false, 1, 50.0, 90.0);
		placeObjectMirrored(mediumHunt2ID, false, 1, 50.0, 90.0);
	} else {
		placeObjectMirrored(mediumHunt2ID, false, 1, 50.0, 80.0);
	}

	// Crane.
	placeFarObjectMirrored(farCraneID);

	// Bonus hunt.
	placeFarObjectMirrored(bonusHunt1ID);

	placeFarObjectMirrored(bonusHunt2ID, false, 1, 20.0);
	placeFarObjectMirrored(bonusHunt3ID, false, 1, 20.0);

	// Starting food.
	placeObjectMirrored(startingHuntID, false, 1, 22.0, 27.0, true);

	// Straggler trees.
	placeObjectMirrored(stragglerTreeID, false, rmRandInt(2, 5), 13.5, 13.5, true);

	// Medium herdables.
	placeObjectMirrored(mediumHerdablesID, false, 1, 55.0, 75.0);

	// Far herdables.
	placeFarObjectMirrored(farHerdablesID, false, rmRandInt(1, 2), 15.0);

	// Starting herdables.
	placeObjectMirrored(startingHerdablesID, true, 1, 20.0, 30.0);

	// Far predators.
	placeFarObjectMirrored(farPredators1ID, false, 2);
	placeFarObjectMirrored(farPredators2ID);

	progress(0.9);

	// Center forest.
	int centerForestID = rmCreateArea("center forest");
	if(randChance()) {
		rmSetAreaForestType(centerForestID, "Savannah Forest");
	} else {
		rmSetAreaForestType(centerForestID, "Palm Forest");
	}
	rmSetAreaSize(centerForestID, areaRadiusMetersToFraction(rmRandFloat(2.0, 3.0)));
	rmSetAreaLocation(centerForestID, 0.5, 0.5);
	rmSetAreaCoherence(centerForestID, 1.0);
	rmBuildArea(centerForestID);

	// Relics (non mirrored).
	placeObjectInPlayerSplits(relicID);

	// Random trees.
	placeObjectAtPlayerLocs(randomTree1ID, false, 5);
	placeObjectAtPlayerLocs(randomTree2ID, false, 5);

	// Embellishment.
	// Bushes.
	int bush1ID = rmCreateObjectDef("bush 1");
	rmAddObjectDefItem(bush1ID, "Bush", 4, 4.0);
	setObjectDefDistanceToMax(bush1ID);
	rmAddObjectDefConstraint(bush1ID, embellishmentAvoidAll);
	rmAddObjectDefConstraint(bush1ID, farAvoidWater);
	rmPlaceObjectDefAtLoc(bush1ID, 0, 0.5, 0.5, 10 * cNonGaiaPlayers);

	int bush2ID = rmCreateObjectDef("bush 2");
	rmAddObjectDefItem(bush2ID, "Bush", 3, 2.0);
	rmAddObjectDefItem(bush2ID, "Rock Sandstone Sprite", 1, 2.0);
	setObjectDefDistanceToMax(bush2ID);
	rmAddObjectDefConstraint(bush2ID, embellishmentAvoidAll);
	rmAddObjectDefConstraint(bush2ID, farAvoidWater);
	rmPlaceObjectDefAtLoc(bush2ID, 0, 0.5, 0.5, 10 * cNonGaiaPlayers);

	// Rocks.
	int rock1ID = rmCreateObjectDef("rock small");
	rmAddObjectDefItem(rock1ID, "Rock Sandstone Small", 3, 2.0);
	rmAddObjectDefItem(rock1ID, "Rock Limestone Sprite", 4, 3.0);
	setObjectDefDistanceToMax(rock1ID);
	rmAddObjectDefConstraint(rock1ID, embellishmentAvoidAll);
	rmAddObjectDefConstraint(rock1ID, farAvoidWater);
	rmPlaceObjectDefAtLoc(rock1ID, 0, 0.5, 0.5, 5 * cNonGaiaPlayers);

	int rock2ID = rmCreateObjectDef("rock sprite");
	rmAddObjectDefItem(rock2ID, "Rock Sandstone Sprite", 1, 0.0);
	setObjectDefDistanceToMax(rock2ID);
	rmAddObjectDefConstraint(rock2ID, embellishmentAvoidAll);
	rmAddObjectDefConstraint(rock2ID, farAvoidWater);
	rmPlaceObjectDefAtLoc(rock2ID, 0, 0.5, 0.5, 10 * cNonGaiaPlayers);

	// Skeletons.
	int skeletonID = rmCreateObjectDef("skeleton");
	rmAddObjectDefItem(skeletonID, "Skeleton Animal", 1, 0.0);
	setObjectDefDistanceToMax(skeletonID);
	rmAddObjectDefConstraint(skeletonID, embellishmentAvoidAll);
	rmAddObjectDefConstraint(skeletonID, farAvoidWater);
	rmPlaceObjectDefAtLoc(skeletonID, 0, 0.5, 0.5, 3 * cNonGaiaPlayers);

	// Water embellishment.
	int lilly1ID = rmCreateObjectDef("lilly 1");
	rmAddObjectDefItem(lilly1ID, "Water Lilly", 1, 0.0);
	setObjectDefDistanceToMax(lilly1ID);
	rmAddObjectDefConstraint(lilly1ID, embellishmentAvoidAll);
	rmPlaceObjectDefAtLoc(lilly1ID, 0, 0.5, 0.5, 5 * cNonGaiaPlayers);

	int lilly2ID = rmCreateObjectDef("lilly 2");
	rmAddObjectDefItem(lilly2ID, "Water Lilly", 4, 2.0);
	setObjectDefDistanceToMax(lilly2ID);
	rmAddObjectDefConstraint(lilly2ID, embellishmentAvoidAll);
	rmPlaceObjectDefAtLoc(lilly2ID, 0, 0.5, 0.5, 5 * cNonGaiaPlayers);

	int waterEmbellishmentID = rmCreateObjectDef("water embellishment");
	rmAddObjectDefItem(waterEmbellishmentID, "Water Decoration", 3, 6.0);
	setObjectDefDistanceToMax(waterEmbellishmentID);
	rmAddObjectDefConstraint(waterEmbellishmentID, embellishmentAvoidAll);
	rmPlaceObjectDefAtLoc(waterEmbellishmentID, 0, 0.5, 0.5, 10 * cNonGaiaPlayers);

	// Birds.
	int birdsID = rmCreateObjectDef("birds");
	rmAddObjectDefItem(birdsID, "Vulture", 1, 0.0);
	setObjectDefDistanceToMax(birdsID);
	rmPlaceObjectDefAtLoc(birdsID, 0, 0.5, 0.5, 2 * cNonGaiaPlayers);

	// Finalize RM X.
	rmxFinalize();

	progress(1.0);
}
