/*
** MARSH MIRROR
** RebelsRising
** Last edit: 14/05/2022
*/

include "rmx.xs";

mutable float randFwdOutsideFirst(float tol = 0.0) {
	return(rmRandFloat(0.95 - 0.45 * tol, 1.4 + 0.1 * tol) * PI);
}

mutable float randFwdOutsideLast(float tol = 0.0) {
	return(rmRandFloat(0.6 - 0.1 * tol, 1.05 + 0.45 * tol) * PI);
}

string terrainMarshPool = "Marsh Pool";
string objectMarshTree = "Marsh Tree";
string forestMarshForest = "Marsh Forest";
string terrainMarshA = "MarshA";
string terrainMarshB = "MarshB";
string terrainMarshC = "MarshC";
string terrainMarshD = "MarshD";
string terrainMarshE = "MarshE";

/*
** Vanilla textures.
*/
void useVanillaTextures() {
	terrainMarshPool = "Greek River";
	objectMarshTree = "Oak Tree";
	forestMarshForest = "Autumn Oak Forest";
	terrainMarshA = "GrassA";
	terrainMarshB = "GrassB";
	terrainMarshC = "GrassDirt25";
	terrainMarshD = "GrassDirt50";
	terrainMarshE = "GrassDirt25";
}

void main() {
	progress(0.0);

	// Initial map setup.
	if(cVersion == cVersionVanilla) {
		useVanillaTextures();
		rmxInit("Marsh X (Vanilla)");
	} else {
		rmxInit("Marsh X");
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
	int axisLength = getStandardMapDimInMeters(9000, 0.9, 1.8);

	// Initialize water.
	rmSetSeaLevel(1.0);
	rmSetSeaType(terrainMarshPool);

	// Initialize map.
	initializeMap("Water", axisLength);

	// Set lighting.
	//rmSetLightingSet("Fimbulwinter");

	// Place players.
	if(cNonGaiaPlayers < 9) {
		placePlayersInCircle(0.38, 0.4);
	} else {
		placePlayersInCircle(0.375);
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
	int avoidCorner = createClassDistConstraint(classCorner, 1.0);
	int avoidLargeCenter = createClassDistConstraint(classLargeCenter, 1.0);
	int shortAvoidPlayer = createClassDistConstraint(classPlayer, 1.0);
	int farAvoidPlayer = createClassDistConstraint(classPlayer, 22.5);
	int avoidConnection = createClassDistConstraint(classConnection, 1.0);
	int shortAvoidIsland = createClassDistConstraint(classIsland, 20.0);
	int avoidPlayerCore = createClassDistConstraint(classPlayerCore, 0.1);
	if(gameIs1v1() == false) {
		avoidPlayerCore = createClassDistConstraint(classPlayerCore, 60.0);
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
	int avoidRelic = createTypeDistConstraint("Relic", 30.0);

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
	rmAddObjectDefConstraint(startingTowerID, farAvoidTower);

	int startingTowerBackupID = rmCreateObjectDef("starting tower backup");
	rmAddObjectDefItem(startingTowerBackupID, "Tower", 1, 0.0);
	rmAddObjectDefConstraint(startingTowerBackupID, avoidAll);
	rmAddObjectDefConstraint(startingTowerBackupID, shortAvoidTower);

	// Starting hunt.
	int startingHuntID = rmCreateObjectDef("starting hunt");
	rmAddObjectDefItem(startingHuntID, "Deer", rmRandInt(6, 8), 2.0);
	rmAddObjectDefConstraint(startingHuntID, avoidAll);
	rmAddObjectDefConstraint(startingHuntID, avoidEdge);
	rmAddObjectDefConstraint(startingHuntID, shortAvoidGold);
	rmAddObjectDefConstraint(startingHuntID, avoidFood);
	rmAddObjectDefConstraint(startingHuntID, mediumAvoidWater);

	// Starting herdables.
	int startingHerdablesID = rmCreateObjectDef("starting herdables");
	rmAddObjectDefItem(startingHerdablesID, "Pig", 4, 2.0);
	rmAddObjectDefConstraint(startingHerdablesID, avoidAll);
	rmAddObjectDefConstraint(startingHerdablesID, avoidEdge);

	// Straggler trees 1.
	int stragglerTree1ID = rmCreateObjectDef("straggler tree 1");
	rmAddObjectDefItem(stragglerTree1ID, "Oak Tree", 1, 0.0);
	rmAddObjectDefConstraint(stragglerTree1ID, avoidAll);
	rmAddObjectDefConstraint(stragglerTree1ID, mediumAvoidWater);

	// Straggler trees 2.
	int stragglerTree2ID = rmCreateObjectDef("straggler tree 2");
	rmAddObjectDefItem(stragglerTree2ID, objectMarshTree, 1, 0.0);
	rmAddObjectDefConstraint(stragglerTree2ID, avoidAll);
	rmAddObjectDefConstraint(stragglerTree2ID, mediumAvoidWater);

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
	rmAddObjectDefConstraint(mediumGoldID, avoidLargeCenter);
	rmAddObjectDefConstraint(mediumGoldID, mediumAvoidWater);

	// Far gold.
	int farGoldID = rmCreateObjectDef("far gold");
	rmAddObjectDefItem(farGoldID, "Gold Mine", 1, 0.0);
	rmAddObjectDefConstraint(farGoldID, avoidAll);
	rmAddObjectDefConstraint(farGoldID, avoidEdge);
	rmAddObjectDefConstraint(farGoldID, createClassDistConstraint(classStartingSettlement, 70.0));
	rmAddObjectDefConstraint(farGoldID, goldAvoidSettlement);
	rmAddObjectDefConstraint(farGoldID, farAvoidGold);
	rmAddObjectDefConstraint(farGoldID, avoidLargeCenter);
	rmAddObjectDefConstraint(farGoldID, mediumAvoidWater);

	// Bonus gold.
	int bonusGoldID = rmCreateObjectDef("bonus gold");
	rmAddObjectDefItem(bonusGoldID, "Gold Mine", 1, 0.0);
	rmAddObjectDefConstraint(bonusGoldID, avoidAll);
	rmAddObjectDefConstraint(bonusGoldID, avoidEdge);
	rmAddObjectDefConstraint(bonusGoldID, avoidCenter);
	rmAddObjectDefConstraint(bonusGoldID, goldAvoidSettlement);
	rmAddObjectDefConstraint(bonusGoldID, farAvoidPlayer);
	rmAddObjectDefConstraint(bonusGoldID, farAvoidGold);
	rmAddObjectDefConstraint(bonusGoldID, mediumAvoidWater);

	// Hunt, berries and predators.
	// Close hunt.
	float closeHuntFloat = rmRandFloat(0.0, 1.0);

	int closeHuntID = rmCreateObjectDef("close hunt");
	if(closeHuntFloat < 0.3) {
		rmAddObjectDefItem(closeHuntID, "Hippo", 2, 2.0);
	} else if(closeHuntFloat < 0.6) {
		rmAddObjectDefItem(closeHuntID, "Hippo", 3, 2.0);
	} else {
		rmAddObjectDefItem(closeHuntID, "Water Buffalo", 2, 2.0);
	}
	rmAddObjectDefConstraint(closeHuntID, avoidAll);
	rmAddObjectDefConstraint(closeHuntID, avoidEdge);
	rmAddObjectDefConstraint(closeHuntID, avoidFood);
	rmAddObjectDefConstraint(closeHuntID, createClassDistConstraint(classLargeCenter, 20.0));
	rmAddObjectDefConstraint(closeHuntID, shortAvoidWater);

	// Far crane.
	int farCraneID = rmCreateObjectDef("far crane");
	rmAddObjectDefItem(farCraneID, "Crowned Crane", rmRandInt(6, 8), 2.0);
	rmAddObjectDefConstraint(farCraneID, avoidAll);
	rmAddObjectDefConstraint(farCraneID, avoidEdge);
	rmAddObjectDefConstraint(farCraneID, shortAvoidWater);
	rmAddObjectDefConstraint(farCraneID, avoidFood);
	rmAddObjectDefConstraint(farCraneID, avoidLargeCenter);
	rmAddObjectDefConstraint(farCraneID, createClassDistConstraint(classStartingSettlement, 70.0));
	rmAddObjectDefConstraint(farCraneID, nearShore);

	// Bonus hunt 1.
	float bonusHunt1Float = rmRandFloat(0.0, 1.0);

	int bonusHunt1ID = rmCreateObjectDef("bonus hunt 1");
	if(bonusHunt1Float < 0.5) {
		rmAddObjectDefItem(bonusHunt1ID, "Water Buffalo", 2, 2.0);
	} else if(bonusHunt1Float < 0.75) {
		rmAddObjectDefItem(bonusHunt1ID, "Deer", rmRandInt(5, 6), 2.0);
	} else {
		rmAddObjectDefItem(bonusHunt1ID, "Hippo", rmRandInt(3, 5), 2.0);
	}
	rmAddObjectDefConstraint(bonusHunt1ID, avoidAll);
	rmAddObjectDefConstraint(bonusHunt1ID, avoidEdge);
	rmAddObjectDefConstraint(bonusHunt1ID, avoidLargeCenter);
	rmAddObjectDefConstraint(bonusHunt1ID, avoidFood);
	rmAddObjectDefConstraint(bonusHunt1ID, mediumAvoidWater);
	rmAddObjectDefConstraint(bonusHunt1ID, avoidTowerLOS);

	// Bonus hunt 2.
	float bonusHunt2Float = rmRandFloat(0.0, 1.0);

	int bonusHunt2ID = rmCreateObjectDef("bonus hunt 2");
	if(bonusHunt2Float < 0.5) {
		rmAddObjectDefItem(bonusHunt2ID, "Hippo", 2, 2.0);
	} else if(bonusHunt2Float < 0.75) {
		rmAddObjectDefItem(bonusHunt2ID, "Water Buffalo", rmRandInt(5, 6), 4.0);

		if(randChance()) {
			rmAddObjectDefItem(bonusHunt2ID, "Deer", rmRandInt(2, 4), 4.0);
		}
	} else {
		rmAddObjectDefItem(bonusHunt2ID, "Deer", rmRandInt(6, 9), 2.0);
	}
	rmAddObjectDefConstraint(bonusHunt2ID, avoidAll);
	rmAddObjectDefConstraint(bonusHunt2ID, avoidEdge);
	rmAddObjectDefConstraint(bonusHunt2ID, avoidLargeCenter);
	rmAddObjectDefConstraint(bonusHunt2ID, avoidFood);
	rmAddObjectDefConstraint(bonusHunt2ID, mediumAvoidWater);
	rmAddObjectDefConstraint(bonusHunt2ID, avoidTowerLOS);

	// Bonus hunt 3.
	float bonusHunt3Float = rmRandFloat(0.0, 1.0);

	int bonusHunt3ID = rmCreateObjectDef("bonus hunt 3");
	if(bonusHunt3Float < 0.5) {
		rmAddObjectDefItem(bonusHunt3ID, "Boar", 4, 2.0);
	} else if(bonusHunt3Float < 0.75) {
		rmAddObjectDefItem(bonusHunt3ID, "Boar", 6, 4.0);

		if(randChance()) {
			rmAddObjectDefItem(bonusHunt3ID, "Crowned Crane", rmRandInt(4, 6), 4.0);
		}
	} else {
		rmAddObjectDefItem(bonusHunt3ID, "Water Buffalo", rmRandInt(4, 5), 2.0);
	}
	rmAddObjectDefConstraint(bonusHunt3ID, avoidAll);
	rmAddObjectDefConstraint(bonusHunt3ID, avoidEdge);
	rmAddObjectDefConstraint(bonusHunt3ID, shortAvoidPlayer);
	rmAddObjectDefConstraint(bonusHunt3ID, avoidTowerLOS);
	rmAddObjectDefConstraint(bonusHunt3ID, avoidFood);
	rmAddObjectDefConstraint(bonusHunt3ID, mediumAvoidWater);

	// Bonus hunt 4.
	float bonusHunt4Float = rmRandFloat(0.0, 1.0);

	int bonusHunt4ID = rmCreateObjectDef("bonus hunt 4");
	if(bonusHunt4Float < 0.5) {
		rmAddObjectDefItem(bonusHunt4ID, "Boar", 4, 2.0);
	} else if(bonusHunt4Float < 0.75) {
		rmAddObjectDefItem(bonusHunt4ID, "Boar", 6, 3.0);

		if(randChance()) {
			rmAddObjectDefItem(bonusHunt4ID, "Crowned Crane", rmRandInt(4, 6), 3.0);
		}
	} else {
		rmAddObjectDefItem(bonusHunt4ID, "Water Buffalo", rmRandInt(2, 3), 4.0);
	}
	rmAddObjectDefConstraint(bonusHunt4ID, avoidAll);
	rmAddObjectDefConstraint(bonusHunt4ID, avoidEdge);
	rmAddObjectDefConstraint(bonusHunt4ID, shortAvoidPlayer);
	rmAddObjectDefConstraint(bonusHunt4ID, avoidTowerLOS);
	rmAddObjectDefConstraint(bonusHunt4ID, avoidFood);
	rmAddObjectDefConstraint(bonusHunt4ID, mediumAvoidWater);

	// Far predators 1.
	int farPredators1ID = rmCreateObjectDef("far predators 1");
	rmAddObjectDefItem(farPredators1ID, "Crocodile", 1, 4.0);
	rmAddObjectDefConstraint(farPredators1ID, avoidAll);
	rmAddObjectDefConstraint(farPredators1ID, avoidEdge);
	rmAddObjectDefConstraint(farPredators1ID, avoidLargeCenter);
	rmAddObjectDefConstraint(farPredators1ID, createClassDistConstraint(classStartingSettlement, 80.0));
	rmAddObjectDefConstraint(farPredators1ID, avoidSettlement);
	rmAddObjectDefConstraint(farPredators1ID, avoidPredator);
	rmAddObjectDefConstraint(farPredators1ID, nearShore);

	// Far predators 2.
	int farPredators2ID = rmCreateObjectDef("far predators 2");
	rmAddObjectDefItem(farPredators2ID, "Crocodile", 1, 4.0);
	rmAddObjectDefConstraint(farPredators2ID, avoidAll);
	rmAddObjectDefConstraint(farPredators2ID, avoidEdge);
	rmAddObjectDefConstraint(farPredators2ID, avoidCenter);
	rmAddObjectDefConstraint(farPredators2ID, createClassDistConstraint(classStartingSettlement, 80.0));
	rmAddObjectDefConstraint(farPredators2ID, avoidSettlement);
	rmAddObjectDefConstraint(farPredators2ID, avoidPredator);
	rmAddObjectDefConstraint(farPredators2ID, nearShore);

	// Medium herdables.
	int mediumHerdablesID = rmCreateObjectDef("medium herdables");
	rmAddObjectDefItem(mediumHerdablesID, "Pig", rmRandInt(2, 3), 4.0);
	rmAddObjectDefConstraint(mediumHerdablesID, avoidAll);
	rmAddObjectDefConstraint(mediumHerdablesID, avoidEdge);
	rmAddObjectDefConstraint(mediumHerdablesID, createClassDistConstraint(classStartingSettlement, 50.0));
	rmAddObjectDefConstraint(mediumHerdablesID, avoidTowerLOS);
	rmAddObjectDefConstraint(mediumHerdablesID, mediumAvoidWater);
	rmAddObjectDefConstraint(mediumHerdablesID, avoidLargeCenter);

	// Far herdables.
	int farHerdablesID = rmCreateObjectDef("far herdables");
	rmAddObjectDefItem(farHerdablesID, "Pig", rmRandInt(1, 2), 4.0);
	rmAddObjectDefConstraint(farHerdablesID, avoidAll);
	rmAddObjectDefConstraint(farHerdablesID, avoidEdge);
	rmAddObjectDefConstraint(farHerdablesID, createClassDistConstraint(classStartingSettlement, 70.0));
	rmAddObjectDefConstraint(farHerdablesID, avoidFood);
	rmAddObjectDefConstraint(farHerdablesID, farAvoidPlayer);
	rmAddObjectDefConstraint(farHerdablesID, mediumAvoidWater);

	// Other objects.
	// Random trees 1.
	int randomTree1ID = rmCreateObjectDef("random tree 1");
	rmAddObjectDefItem(randomTree1ID, "Oak Tree", 1, 0.0);
	setObjectDefDistanceToMax(randomTree1ID);
	rmAddObjectDefConstraint(randomTree1ID, avoidAll);
	rmAddObjectDefConstraint(randomTree1ID, avoidLargeCenter);
	rmAddObjectDefConstraint(randomTree1ID, avoidStartingSettlement);
	rmAddObjectDefConstraint(randomTree1ID, avoidSettlement);
	rmAddObjectDefConstraint(randomTree1ID, shortAvoidWater);

	// Random trees 2.
	int randomTree2ID = rmCreateObjectDef("random tree 2");
	rmAddObjectDefItem(randomTree2ID, objectMarshTree, 1, 0.0);
	setObjectDefDistanceToMax(randomTree2ID);
	rmAddObjectDefConstraint(randomTree2ID, avoidAll);
	rmAddObjectDefConstraint(randomTree2ID, farAvoidPlayer);
	rmAddObjectDefConstraint(randomTree2ID, avoidStartingSettlement);
	rmAddObjectDefConstraint(randomTree2ID, avoidSettlement);
	rmAddObjectDefConstraint(randomTree2ID, shortAvoidWater);

	// Relics.
	int relicID = rmCreateObjectDef("relic");
	rmAddObjectDefItem(relicID, "Relic", 1, 0.0);
	rmAddObjectDefConstraint(relicID, avoidAll);
	rmAddObjectDefConstraint(relicID, avoidEdge);
	rmAddObjectDefConstraint(relicID, avoidRelic);
	rmAddObjectDefConstraint(relicID, createClassDistConstraint(classPlayer, 20.0));
	rmAddObjectDefConstraint(relicID, shortAvoidWater);

	progress(0.1);

	// Define player connections.
	int shallowsID = rmCreateConnection("shallows");
	if(gameIs1v1()) {
		rmSetConnectionType(shallowsID, cConnectAreas, false);
	} else {
		rmSetConnectionType(shallowsID, cConnectAllies, false);
	}
	rmSetConnectionWidth(shallowsID, 40.0, 0);
	if(cVersion == cVersionVanilla) {
		rmAddConnectionTerrainReplacement(shallowsID, "RiverGrassyA", terrainMarshA);
		rmAddConnectionTerrainReplacement(shallowsID, "RiverGrassyB", terrainMarshC);
	}
	rmSetConnectionCoherence(shallowsID, 1.0);
	rmSetConnectionBaseHeight(shallowsID, 2.0);
	rmSetConnectionHeightBlend(shallowsID, 2);
	rmSetConnectionSmoothDistance(shallowsID, 3);
	rmAddConnectionToClass(shallowsID, classConnection);
	rmSetConnectionWarnFailure(shallowsID, false);

	// Set up fake player areas.
	for(i = 1; < cPlayers) {
		int fakePlayerAreaID = rmCreateArea("fake player area " + i);
		if(gameIs1v1()) {
			rmSetAreaSize(fakePlayerAreaID, rmAreaTilesToFraction(3000));
		} else {
			rmSetAreaSize(fakePlayerAreaID, rmAreaTilesToFraction(200));
		}
		rmSetAreaLocPlayer(fakePlayerAreaID, getPlayer(i));
		rmSetAreaCoherence(fakePlayerAreaID, 1.0);
		rmSetAreaHeightBlend(fakePlayerAreaID, 2);
		rmAddAreaToClass(fakePlayerAreaID, classPlayerCore);
		rmSetAreaWarnFailure(fakePlayerAreaID, false);
		rmBuildArea(fakePlayerAreaID);
	}

	// Center.
	int bonusIslandID = 0;
	int numBonusIsland = 4;

	float islandEdgeDist = rmXTilesToFraction(20);

	if(gameIs1v1() == false) {
		islandEdgeDist = rmXTilesToFraction(30);
		numBonusIsland = 0;
	}

	int islandAvoidEdge = createSymmetricBoxConstraint(islandEdgeDist, islandEdgeDist);

	for(i = 0; < numBonusIsland) {
		float randX = rmRandFloat(0.35, 0.65);
		float randZ = rmRandFloat(0.35, 0.65);

		bonusIslandID = rmCreateArea("bonus island 1 " + i);
		rmSetAreaSize(bonusIslandID, rmAreaTilesToFraction(3000));
		rmSetAreaLocation(bonusIslandID, randX, randZ);
		rmSetAreaTerrainType(bonusIslandID, terrainMarshA);
		rmAddAreaTerrainLayer(bonusIslandID, terrainMarshB, 0, 6);
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
		rmSetAreaTerrainType(bonusIslandID, terrainMarshA);
		rmAddAreaTerrainLayer(bonusIslandID, terrainMarshB, 0, 6);
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

	if(gameIs1v1() == false) {
		bonusIslandID = rmCreateArea("center bonus island");
		rmSetAreaSize(bonusIslandID, rmAreaTilesToFraction(3500 * cNonGaiaPlayers));
		rmSetAreaLocation(bonusIslandID, 0.5, 0.5);
		rmSetAreaTerrainType(bonusIslandID, terrainMarshA);
		rmAddAreaTerrainLayer(bonusIslandID, terrainMarshB, 0, 6);
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
		rmSetAreaTerrainType(playerAreaID, terrainMarshD);
		rmAddAreaTerrainLayer(playerAreaID, terrainMarshD, 4, 7);
		rmAddAreaTerrainLayer(playerAreaID, terrainMarshD, 2, 4);
		rmAddAreaTerrainLayer(playerAreaID, terrainMarshE, 0, 2);
		rmSetAreaCoherence(playerAreaID, 1.0);
		rmSetAreaBaseHeight(playerAreaID, 6.0);
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
	rmAddAreaToClass(fakeCenterID, classLargeCenter);
	rmSetAreaLocation(fakeCenterID, 0.5, 0.5);
	rmAddAreaConstraint(fakeCenterID, shortAvoidWater);
	rmAddAreaConstraint(fakeCenterID, shortAvoidPlayer);
	rmSetAreaWarnFailure(fakeCenterID, false);
	rmBuildArea(fakeCenterID);

	progress(0.2);

	// Build connections.
	int numConnections = 3;

	if(gameIs1v1() == false) {
		numConnections = getNumberPlayersOnTeam(0);
	}

	for(n = 1; <= numConnections) {
		// Create random connection.
		int numAreas = 100;

		float offset = rmRandFloat(0.1, 0.5) * PI;

		// Offset variation.
		if(randChance()) {
			offset = 2.0 * PI - offset;
		}

		float a = getTeamAngle(0) + offset;
		float b = getTeamAngle(1) + offset;
		float r = 0.5;

		if(gameIs1v1() == false) {
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
			if(gameIs1v1()) {
				rmSetAreaSize(bonusConnectionID, rmRandFloat(0.005, 0.0075));
			} else {
				rmSetAreaSize(bonusConnectionID, rmXMetersToFraction(rmRandFloat(3.0, 4.0)));
			}
			rmSetAreaBaseHeight(bonusConnectionID, 2.0);
			rmSetAreaCoherence(bonusConnectionID, 1.0);
			rmSetAreaHeightBlend(bonusConnectionID, 2);
			rmSetAreaWarnFailure(bonusConnectionID, false);
			// rmAddAreaToClass(bonusConnectionID, classConnection);
			rmSetAreaTerrainType(bonusConnectionID, terrainMarshA);
			rmAddAreaTerrainLayer(bonusConnectionID, terrainMarshB, 0, 6);

			rmSetAreaLocation(bonusConnectionID, incrX * i + x1, incrZ * i + z1);
		}
	}

	rmBuildAllAreas();

	// TCs.
	placeObjectAtPlayerLocs(startingSettlementID, true);

	// Towers.
	placeAndStoreObjectMirrored(startingTowerID, true, 4, 23.0, 27.0, true, -1, startingTowerBackupID);

	// Beautification.
	int beautificationID = 0;

	for(i = 0; < 20 * cPlayers) {
		beautificationID = rmCreateArea("beautification 1 " + i);
		rmSetAreaSize(beautificationID, rmAreaTilesToFraction(20), rmAreaTilesToFraction(40));
		rmSetAreaTerrainType(beautificationID, terrainMarshC);
		rmSetAreaMinBlobs(beautificationID, 1);
		rmSetAreaMaxBlobs(beautificationID, 5);
		rmSetAreaMinBlobDistance(beautificationID, 16.0);
		rmSetAreaMaxBlobDistance(beautificationID, 40.0);
		rmAddAreaConstraint(beautificationID, shortAvoidPlayer);
		rmAddAreaConstraint(beautificationID, shortAvoidWater);
		rmSetAreaWarnFailure(beautificationID, false);
		rmBuildArea(beautificationID);
	}

	for(i = 0; < 20 * cPlayers) {
		beautificationID = rmCreateArea("beautification 2 " + i);
		rmSetAreaSize(beautificationID, rmAreaTilesToFraction(10), rmAreaTilesToFraction(40));
		rmSetAreaTerrainType(beautificationID, "GrassB");
		rmSetAreaMinBlobs(beautificationID, 1);
		rmSetAreaMaxBlobs(beautificationID, 5);
		rmSetAreaMinBlobDistance(beautificationID, 16.0);
		rmSetAreaMaxBlobDistance(beautificationID, 40.0);
		rmAddAreaConstraint(beautificationID, shortAvoidWater);
		rmAddAreaConstraint(beautificationID, shortAvoidIsland);
		rmSetAreaWarnFailure(beautificationID, false);
		rmBuildArea(beautificationID);
	}

	for(i = 0; < 20 * cPlayers) {
		beautificationID = rmCreateArea("beautification 3 " + i);
		rmSetAreaSize(beautificationID, rmAreaTilesToFraction(10), rmAreaTilesToFraction(50));
		rmSetAreaTerrainType(beautificationID, "GrassDirt50");
		rmAddAreaTerrainLayer(beautificationID, "GrassDirt25", 0, 2);
		rmSetAreaMinBlobs(beautificationID, 1);
		rmSetAreaMaxBlobs(beautificationID, 5);
		rmSetAreaMinBlobDistance(beautificationID, 16.0);
		rmSetAreaMaxBlobDistance(beautificationID, 40.0);
		rmAddAreaConstraint(beautificationID, shortAvoidWater);
		rmAddAreaConstraint(beautificationID, shortAvoidIsland);
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

	addFairLoc(60.0, 100.0, false, true, 50.0, 12.0, 12.0, true);

	placeObjectAtNewFairLocs(settlementID, false, "close settlement");

	// Far settlement.
	int numFairLocTries = 3;

	// 3 attempts.
	for(i = 0; < numFairLocTries) {
		addFairLocConstraint(avoidTowerLOS);
		addFairLocConstraint(settlementAvoidCenter);
		addFairLocConstraint(farAvoidWater);
		addFairLocConstraint(shortAvoidPlayer);

		if(gameIs1v1()) {
			addFairLocConstraint(createTypeDistConstraint("AbstractSettlement", 65.0));
			addFairLoc(60.0, 100.0, true, false, 65.0, 12.0, 12.0);
		} else if(cNonGaiaPlayers < 5) {
			addFairLoc(60.0, 100.0, true, randChance(), 65.0, 12.0, 12.0);
		} else if(cNonGaiaPlayers < 7) {
			addFairLocConstraint(createClassDistConstraint(classStartingSettlement, 70.0));
			addFairLoc(70.0, 150.0, true, randChance(), 60.0 - 5.0 * i, 12.0, 12.0);
		} else {
			addFairLoc(70.0, 150.0, true, randChance(), 55.0, 12.0, 12.0);
		}

		if(placeObjectAtNewFairLocs(settlementID, false, "far settlement " + i, (i - 1) == numFairLocTries)) {
			break;
		}
	}

	resetFairLocs();

	progress(0.4);

	// Forest.
	initForestClass();

	addForestConstraint(avoidCenter);
	addForestConstraint(avoidStartingSettlement);
	addForestConstraint(avoidAll);
	addForestConstraint(mediumAvoidWater);

	// Player forests.
	addForestType("Mixed Oak Forest", 1.0);

	setForestAvoidSelf(30.0);

	setForestBlobs(9);
	setForestBlobParams(6.0, 4.25);
	setForestCoherence(-0.8, 0.2);

	setForestSearchRadius(30.0, 40.0);
	setForestMinRatio(2.0 / 3.0);

	int numPlayerForests = 3;

	buildPlayerForests(numPlayerForests, 0.1);

	progress(0.5);

	// Inner forests.
	resetForestTypes();

	addForestType(forestMarshForest, 1.0);

	setForestAvoidSelf(24.0);

	setForestBlobs(8);
	setForestBlobParams(4.75, 4.25);
	setForestCoherence(-0.75, 0.0);
	setForestSearchRadius(20.0, rmXFractionToMeters(0.3));
	setForestMinRatio(0.5);

	int numInnerForests = 3 * cNonGaiaPlayers / 2;

	buildForests(numInnerForests, 0.1);

	progress(0.6);

	// Normal forests.
	resetForestTypes();

	addForestType("Mixed Oak Forest", 1.0);

	setForestAvoidSelf(30.0);

	setForestBlobs(9);
	setForestBlobParams(6.0, 4.25);
	setForestCoherence(-0.75, 0.0);

	setForestSearchRadius(rmXFractionToMeters(0.3), -1.0);
	setForestMinRatio(0.5);

	int numOuterForests = 6 * cNonGaiaPlayers / 2;

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
	placeObjectMirrored(mediumGoldID, false, rmRandInt(1, 2), 50.0, 70.0);

	// Far gold.
	placeFarObjectMirrored(farGoldID, false, rmRandInt(1, 2));

	// Bonus gold.
	placeFarObjectMirrored(bonusGoldID, false, rmRandInt(1, 2));

	// Starting food.
	placeObjectMirrored(startingHuntID, false, 1, 22.0, 27.0, true);

	// Close hunt.
	placeObjectMirrored(closeHuntID, false, 1, 30.0, 50.0);

	// Bonus hunt for player.
	placeObjectMirrored(bonusHunt1ID, false, 1, 50.0, 120.0);
	placeObjectMirrored(bonusHunt2ID, false, 1, 50.0, 120.0);

	// Bonus hunt in center.
	placeFarObjectMirrored(bonusHunt3ID, false, 2, 10.0);
	placeFarObjectMirrored(bonusHunt4ID, false, 2, 10.0);

	// Crane.
	placeFarObjectMirrored(farCraneID);

	// Straggler trees.
	placeObjectMirrored(stragglerTree1ID, false, rmRandInt(1, 3), 13.0, 13.5, true);
	placeObjectMirrored(stragglerTree2ID, false, rmRandInt(1, 3), 13.0, 13.5, true);

	// Medium herdables.
	placeObjectMirrored(mediumHerdablesID, false, 1, 55.0, 75.0);

	// Far herdables.
	placeFarObjectMirrored(farHerdablesID, false, rmRandInt(1, 2), 15.0);

	// Starting herdables.
	placeObjectMirrored(startingHerdablesID, true, 1, 20.0, 30.0);

	// Far predators.
	placeFarObjectMirrored(farPredators1ID, false, 2);

	// Far predators.
	placeFarObjectMirrored(farPredators2ID);

	progress(0.9);

	// Center forest.
	int centerForestID = rmCreateArea("center forest");
	rmSetAreaForestType(centerForestID, forestMarshForest);
	rmSetAreaSize(centerForestID, areaRadiusMetersToFraction(rmRandFloat(2.0, 3.0)));
	rmSetAreaLocation(centerForestID, 0.5, 0.5);
	rmSetAreaCoherence(centerForestID, 1.0);
	rmBuildArea(centerForestID);

	// Relics (non-mirrored).
	placeObjectInPlayerSplits(relicID, false, 2);

	// Random trees.
	placeObjectAtPlayerLocs(randomTree1ID, false, 10);
	placeObjectAtPlayerLocs(randomTree2ID, false, 6);

	// Embellishment.
	// Logs.
	int logID = rmCreateObjectDef("log");
	rmAddObjectDefItem(logID, "Rotting Log", rmRandInt(1, 2), 0.0);
	rmAddObjectDefItem(logID, "Bush", 1, 2.0);
	rmAddObjectDefItem(logID, "Grass", rmRandInt(3, 5), 2.0);
	setObjectDefDistanceToMax(logID);
	rmAddObjectDefConstraint(logID, embellishmentAvoidAll);
	rmAddObjectDefConstraint(logID, shortAvoidPlayer);
	rmAddObjectDefConstraint(logID, mediumAvoidWater);
	rmPlaceObjectDefAtLoc(logID, 0, 0.5, 0.5, 5 * cNonGaiaPlayers);

	// Grass.
	int grassID = rmCreateObjectDef("grass");
	rmAddObjectDefItem(grassID, "Grass", rmRandInt(3, 5), 5.0);
	rmAddObjectDefItem(grassID, "Bush", rmRandInt(1, 3), 2.0);
	rmAddObjectDefItem(grassID, "Rock Limestone Sprite", rmRandInt(2, 4), 10.0);
	setObjectDefDistanceToMax(grassID);
	rmAddObjectDefConstraint(grassID, embellishmentAvoidAll);
	rmAddObjectDefConstraint(grassID, mediumAvoidWater);
	rmAddObjectDefConstraint(grassID, shortAvoidIsland);
	rmPlaceObjectDefAtLoc(grassID, 0, 0.5, 0.5, 15 * cNonGaiaPlayers);

	// Reeds.
	int reedsID = rmCreateObjectDef("reeds");
	rmAddObjectDefItem(reedsID, "Water Reeds", rmRandInt(4, 6), 2.0);
	rmAddObjectDefItem(reedsID, "Rock Granite Big", rmRandInt(1, 3), 3.0);
	setObjectDefDistanceToMax(reedsID);
	rmAddObjectDefConstraint(reedsID, embellishmentAvoidAll);
	rmAddObjectDefConstraint(reedsID, nearShore);
	rmPlaceObjectDefAtLoc(reedsID, 0, 0.5, 0.5, 5 * cNonGaiaPlayers);

	// Lillies.
	int lillyID = rmCreateObjectDef("lilly");
	rmAddObjectDefItem(lillyID, "Water Lilly", rmRandInt(3, 5), 4.0);
	setObjectDefDistanceToMax(lillyID);
	rmAddObjectDefConstraint(lillyID, embellishmentAvoidAll);
	rmPlaceObjectDefAtLoc(lillyID, 0, 0.5, 0.5, 5 * cNonGaiaPlayers);

	// Mist.
	int mistID = rmCreateObjectDef("mist");
	rmAddObjectDefItem(mistID, "Mist", 1, 0.0);
	setObjectDefDistance(mistID, 0.0, 600.0);
	rmAddObjectDefConstraint(mistID, embellishmentAvoidAll);
	rmAddObjectDefConstraint(mistID, shortAvoidPlayer);
	rmAddObjectDefConstraint(mistID, mediumAvoidWater);
	rmPlaceObjectDefAtLoc(mistID, 0, 0.5, 0.5, 3 * cNonGaiaPlayers);

	// Birds.
	int birdsID = rmCreateObjectDef("birds");
	rmAddObjectDefItem(birdsID, "Hawk", 1, 0.0);
	setObjectDefDistanceToMax(birdsID);
	rmPlaceObjectDefAtLoc(birdsID, 0, 0.5, 0.5, 2 * cNonGaiaPlayers);

	// Finalize RM X.
	rmxFinalize();

	progress(1.0);
}
