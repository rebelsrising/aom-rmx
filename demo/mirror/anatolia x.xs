/*
** ANATOLIA MIRROR
** RebelsRising
** Last edit: 09/03/2021
*/

include "rmx.xs";

void main() {
	progress(0.0);

	// Initial map setup.
	rmxInit("Anatolia X");

	// Set mirror mode.
	setMirrorMode(cMirrorPoint);

	// Perform mirror check.
	if(mirrorConfigIsInvalid()) {
		injectMirrorGenError();

		// Invalid configuration, quit.
		return;
	}

	// Adjust angle for line spawn.
	setFarObjectAngleSlice(1.0 * PI, false);

	// Set size.
	int mapSize = getStandardMapDimInMeters();

	// Initialize map.
	initializeMap("SandA", mapSize);

	// Set lighting.
	rmSetLightingSet("Anatolia");

	// Player placement.
	if(cNonGaiaPlayers < 3) {
		placePlayersInLine(0.12, 0.5, 0.88, 0.5);
	} else {
		int teamInt = rmRandInt(0, 1);
		// It's absolutely CRUCIAL to still place players in a counter clock-wise fashion!
		placeTeamInLine(teamInt, 0.16, 0.8, 0.16, 0.2);
		placeTeamInLine(1 - teamInt, 0.84, 0.2, 0.84, 0.8);
	}

	// Initialize areas.
	float centerRadius = 22.5;

	int classCenter = initializeCenter(centerRadius);

	// Define classes.
	int classStartingSettlement = rmDefineClass("starting settlement");
	int classPlayer = rmDefineClass("player");
	int classBeautification = rmDefineClass("beautification");

	// Define global constraints.
	// General.
	int avoidAll = createTypeDistConstraint("All", 7.0);
	int avoidEdge = createSymmetricBoxConstraint(rmXTilesToFraction(4), rmZTilesToFraction(4));
	int avoidCenter = createClassDistConstraint(classCenter, 1.0);
	int avoidPlayer = createClassDistConstraint(classPlayer, 1.0);

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
	rmAddObjectDefConstraint(startingTowerID, avoidEdge);
	rmAddObjectDefConstraint(startingTowerID, farAvoidTower);

	int startingTowerBackupID = rmCreateObjectDef("starting tower backup");
	rmAddObjectDefItem(startingTowerBackupID, "Tower", 1, 0.0);
	rmAddObjectDefConstraint(startingTowerBackupID, avoidAll);
	rmAddObjectDefConstraint(startingTowerBackupID, shortAvoidTower);

	// Starting gold.
	int startingGoldID = rmCreateObjectDef("starting gold");
	rmAddObjectDefItem(startingGoldID, "Gold Mine Small", 1, 0.0);
	rmAddObjectDefConstraint(startingGoldID, avoidAll);
	rmAddObjectDefConstraint(startingGoldID, farAvoidGold);

	// Close hunt.
	float closeHuntFloat = rmRandFloat(0.0, 1.0);

	int closeHuntID = rmCreateObjectDef("close hunt");
	if(closeHuntFloat < 0.3) {
		rmAddObjectDefItem(closeHuntID, "Boar", 3, 2.0);
	} else if(closeHuntFloat < 0.9) {
		rmAddObjectDefItem(closeHuntID, "Boar", 4, 2.0);
	} else {
		rmAddObjectDefItem(closeHuntID, "Boar", 1, 0.0);
	}
	rmAddObjectDefConstraint(closeHuntID, avoidAll);
	rmAddObjectDefConstraint(closeHuntID, avoidEdge);
	rmAddObjectDefConstraint(closeHuntID, avoidWater);
	rmAddObjectDefConstraint(closeHuntID, shortAvoidGold);

	// Starting food.
	float startingFoodFloat = rmRandFloat(0.0, 1.0);
	float startingFoodDist = 4.0;
	int numChickens = 12;
	int numBerries = 9;

	if(startingFoodFloat < 0.25) {
		numChickens = 4;
		numBerries = 3;
		startingFoodDist = 2.0;
	} else if(startingFoodFloat < 0.75) {
		numChickens = 8;
		numBerries = 6;
		startingFoodDist = 2.0;
	}

	int startingFoodID = rmCreateObjectDef("starting food");
	if(randChance()) {
		rmAddObjectDefItem(startingFoodID, "Chicken", numChickens, startingFoodDist);
	} else {
		rmAddObjectDefItem(startingFoodID, "Berry Bush", numBerries, startingFoodDist);
	}
	rmAddObjectDefConstraint(startingFoodID, avoidAll);
	rmAddObjectDefConstraint(startingFoodID, avoidEdge);
	rmAddObjectDefConstraint(startingFoodID, avoidFood);
	rmAddObjectDefConstraint(startingFoodID, shortAvoidGold);

	// Starting herdables.
	int startingHerdablesID = rmCreateObjectDef("starting herdables");
	rmAddObjectDefItem(startingHerdablesID, "Goat", rmRandInt(2, 5), 2.0);
	rmAddObjectDefConstraint(startingHerdablesID, avoidAll);
	rmAddObjectDefConstraint(startingHerdablesID, avoidEdge);

	// Straggler trees.
	int stragglerTreeID = rmCreateObjectDef("straggler tree");
	rmAddObjectDefItem(stragglerTreeID, "Pine", 1, 0.0);
	rmAddObjectDefConstraint(stragglerTreeID, avoidAll);

	// Gold.
	// Bonus gold.
	int bonusGoldID = rmCreateObjectDef("bonus gold");
	rmAddObjectDefItem(bonusGoldID, "Gold Mine", 1, 0.0);
	rmAddObjectDefConstraint(bonusGoldID, avoidAll);
	rmAddObjectDefConstraint(bonusGoldID, avoidEdge);
	rmAddObjectDefConstraint(bonusGoldID, goldAvoidSettlement);
	rmAddObjectDefConstraint(bonusGoldID, farAvoidGold);
	rmAddObjectDefConstraint(bonusGoldID, avoidWater);
	rmAddObjectDefConstraint(bonusGoldID, avoidCenter);

	// Food.
	// Bonus huntable.
	int bonusHuntID = rmCreateObjectDef("bonus hunt");
	rmAddObjectDefItem(bonusHuntID, "Deer", rmRandInt(8, 10), 4.0);
	rmAddObjectDefConstraint(bonusHuntID, avoidAll);
	rmAddObjectDefConstraint(bonusHuntID, avoidEdge);
	rmAddObjectDefConstraint(bonusHuntID, createClassDistConstraint(classStartingSettlement, 60.0));
	rmAddObjectDefConstraint(bonusHuntID, avoidHuntable);
	rmAddObjectDefConstraint(bonusHuntID, avoidWater);
	rmAddObjectDefConstraint(bonusHuntID, avoidCenter);

	// Medium herdables.
	int mediumHerdablesID = rmCreateObjectDef("medium herdables");
	rmAddObjectDefItem(mediumHerdablesID, "Goat", 2, 4.0);
	rmAddObjectDefConstraint(mediumHerdablesID, avoidAll);
	rmAddObjectDefConstraint(mediumHerdablesID, avoidEdge);
	rmAddObjectDefConstraint(mediumHerdablesID, createClassDistConstraint(classStartingSettlement, 50.0));
	rmAddObjectDefConstraint(mediumHerdablesID, avoidHerdable);
	rmAddObjectDefConstraint(mediumHerdablesID, avoidTowerLOS);
	rmAddObjectDefConstraint(mediumHerdablesID, avoidWater);
	rmAddObjectDefConstraint(mediumHerdablesID, avoidCenter);

	// Far herdables.
	int farHerdablesID = rmCreateObjectDef("far herdables");
	rmAddObjectDefItem(farHerdablesID, "Goat", 2, 4.0);
	rmAddObjectDefConstraint(farHerdablesID, avoidAll);
	rmAddObjectDefConstraint(farHerdablesID, avoidEdge);
	rmAddObjectDefConstraint(farHerdablesID, createClassDistConstraint(classStartingSettlement, 70.0));
	rmAddObjectDefConstraint(farHerdablesID, avoidHerdable);
	rmAddObjectDefConstraint(farHerdablesID, avoidWater);
	rmAddObjectDefConstraint(farHerdablesID, avoidCenter);

	// Far predators.
	int farPredatorsID = rmCreateObjectDef("far predators");
	rmAddObjectDefItem(farPredatorsID, "Wolf", 2, 4.0);
	rmAddObjectDefConstraint(farPredatorsID, avoidAll);
	rmAddObjectDefConstraint(farPredatorsID, avoidEdge);
	rmAddObjectDefConstraint(farPredatorsID, createClassDistConstraint(classStartingSettlement, 80.0));
	rmAddObjectDefConstraint(farPredatorsID, avoidSettlement);
	rmAddObjectDefConstraint(farPredatorsID, avoidPredator);
	rmAddObjectDefConstraint(farPredatorsID, avoidWater);
	rmAddObjectDefConstraint(farPredatorsID, avoidCenter);

	// Far berries.
	int farBerriesID = rmCreateObjectDef("far berries");
	rmAddObjectDefItem(farBerriesID, "Berry Bush", rmRandInt(8, 10), 4.0);
	rmAddObjectDefConstraint(farBerriesID, avoidAll);
	rmAddObjectDefConstraint(farBerriesID, avoidEdge);
	rmAddObjectDefConstraint(farBerriesID, createClassDistConstraint(classStartingSettlement, 70.0));
	rmAddObjectDefConstraint(farBerriesID, avoidSettlement);
	rmAddObjectDefConstraint(farBerriesID, avoidFood);
	rmAddObjectDefConstraint(farBerriesID, avoidWater);
	rmAddObjectDefConstraint(farBerriesID, avoidCenter);

	// Other objects.
	// Random trees.
	int randomTreeID = rmCreateObjectDef("random tree");
	rmAddObjectDefItem(randomTreeID, "Pine", 1, 0.0);
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

	// Create oceans.
	int oceanID = 0;
	int numAreas = 5 + 2 * cNonGaiaPlayers;
	float oceanSize = max(0.0285 - 0.003 * cNonGaiaPlayers, 0.0105);
	float fishStart = 0.01;

	// Special case for 2v2.
	if(cNonGaiaPlayers == 4) {
		numAreas = numAreas + 2;
	}

	float incrX = (1.0 - 2.0 * fishStart) / (numAreas - 1);
	float incrZ = (0.0 - 0.0) / (numAreas - 1); // = 0.
	float baseX = fishStart;
	float baseZ = 0.0;

	// Place and mirror ponds.
	for(i = 0; < numAreas / 2) {
		// Water.
		float currX = baseX + 1.0 * i * incrX;
		float currZ = 1.0 * i * incrZ + rmRandFloat(0.00, 0.05); // Add random z offset.
		float sizeMod = 1.0;

		// Modify size of first and last pond so it doesn't randomly get larger to reach tile count.
		if(i == 0 || i == numAreas - 1) {
			sizeMod = 0.5;
		}

		// Build all 4 halves of the 2 rivers equally.
		oceanID = rmCreateArea("ocean 1 1 " + i);
		rmSetAreaSize(oceanID, oceanSize * sizeMod);
		rmSetAreaCoherence(oceanID, 1.0);
		rmSetAreaWaterType(oceanID, "Red Sea");

		rmSetAreaLocation(oceanID, currX, currZ);

		oceanID = rmCreateArea("ocean 1 2 " + i);
		rmSetAreaSize(oceanID, oceanSize * sizeMod);
		rmSetAreaCoherence(oceanID, 1.0);
		rmSetAreaWaterType(oceanID, "Red Sea");

		rmSetAreaLocation(oceanID, 1.0 - currX, currZ);

		oceanID = rmCreateArea("ocean 2 1 " + i);
		rmSetAreaSize(oceanID, oceanSize * sizeMod);
		rmSetAreaCoherence(oceanID, 1.0);
		rmSetAreaWaterType(oceanID, "Red Sea");

		rmSetAreaLocation(oceanID, currX, 1.0 - currZ);

		oceanID = rmCreateArea("ocean 2 2 " + i);
		rmSetAreaSize(oceanID, oceanSize * sizeMod);
		rmSetAreaCoherence(oceanID, 1.0);
		rmSetAreaWaterType(oceanID, "Red Sea");

		rmSetAreaLocation(oceanID, 1.0 - currX, 1.0 - currZ);
	}

	// Fill up middle of lakes if numPonds % 2 == 1.
	if(numAreas % 2 == 1) {
		float centerOceanOffset = rmRandFloat(0.0, 0.05);

		oceanID = rmCreateArea("ocean 1 m");
		rmSetAreaSize(oceanID, oceanSize);
		rmSetAreaCoherence(oceanID, 1.0);
		rmSetAreaWaterType(oceanID, "Red Sea");

		rmSetAreaLocation(oceanID, 0.5, centerOceanOffset);

		oceanID = rmCreateArea("ocean 2 m");
		rmSetAreaSize(oceanID, oceanSize);
		rmSetAreaCoherence(oceanID, 1.0);
		rmSetAreaWaterType(oceanID, "Red Sea");

		rmSetAreaLocation(oceanID, 0.5, 1.0 - centerOceanOffset);
	}

	rmBuildAllAreas();

	// Define fish.
	int numFish = 6;

	int fishID = rmCreateObjectDef("close fish");
	rmAddObjectDefItem(fishID, "Fish - Mahi", 3, 5.0);

	if(cNonGaiaPlayers > 2) {
		int fishAvoidEdge = createSymmetricBoxConstraint(rmXTilesToFraction(2), rmZTilesToFraction(2));
		int fishAvoidLand = createTerrainDistConstraint("Land", true, 8.0);
		int avoidFish = createTypeDistConstraint("Fish", 20.0);

		rmAddObjectDefConstraint(fishID, fishAvoidEdge);
		rmAddObjectDefConstraint(fishID, fishAvoidLand);
		rmAddObjectDefConstraint(fishID, avoidFish);

		// Guiding the algorithm with a large radius and angle because the fish is on the side greatly increases performance.
		placeFarObjectMirrored(fishID, false, numFish, rmXFractionToMeters(0.4));
	} else {
		// Place fish after building areas (overlapping areas delete when placed).
		float fishStartX = rmRandFloat(0.05, 0.125);
		float fishPosZ = 0.03;

		for(i = 0; < numFish) {
			float fishOffset = rmRandFloat(-0.02, 0.02);
			rmPlaceObjectDefAtLoc(fishID, 0, fishStartX + fishOffset + (1.0 - 2.0 * fishStartX) * i / (numFish - 1), fishPosZ + fishOffset);
			rmPlaceObjectDefAtLoc(fishID, 0, 1.0 - fishStartX - fishOffset - (1.0 - 2.0 * fishStartX) * i / (numFish - 1), 1.0 - fishPosZ + fishOffset);
		}
	}

	progress(0.2);

	// Set up player areas.
	float playerAreaSize = rmAreaTilesToFraction(1600);

	for(i = 1; < cPlayers) {
		int playerAreaID = rmCreateArea("player area " + i);
		rmSetAreaSize(playerAreaID, 0.9 * playerAreaSize, 1.1 * playerAreaSize);
		rmSetAreaLocPlayer(playerAreaID, getPlayer(i));
		rmSetAreaTerrainType(playerAreaID, "SnowB");
		rmAddAreaTerrainLayer(playerAreaID, "SnowSand25", 6, 10);
		rmAddAreaTerrainLayer(playerAreaID, "SnowSand50", 2, 6);
		rmAddAreaTerrainLayer(playerAreaID, "SnowSand75", 0, 2);
		rmSetAreaMinBlobs(playerAreaID, 1);
		rmSetAreaMaxBlobs(playerAreaID, 5);
		rmSetAreaMinBlobDistance(playerAreaID, 16.0);
		rmSetAreaMaxBlobDistance(playerAreaID, 40.0);
		rmAddAreaToClass(playerAreaID, classPlayer);
		rmSetAreaWarnFailure(playerAreaID, false);
		rmBuildArea(playerAreaID);
	}

	// TCs.
	placeObjectAtPlayerLocs(startingSettlementID, true);

	// Towers.
	placeObjectMirrored(startingTowerID, true, 4, 23.0, 27.0, true, -1, startingTowerBackupID);

	// Beautification.
	int beautificationID = 0;
	int avoidBeautification = createClassDistConstraint(classBeautification, 10.0);

	for(i = 0; < 5 * cNonGaiaPlayers) {
		beautificationID = rmCreateArea("beautification 1 " + i);
		rmSetAreaSize(beautificationID, rmAreaTilesToFraction(100), rmAreaTilesToFraction(200));
		rmSetAreaTerrainType(beautificationID, "SnowB");
		rmAddAreaTerrainLayer(beautificationID, "SnowSand25", 2, 3);
		rmAddAreaTerrainLayer(beautificationID, "SnowSand50", 1, 2);
		rmAddAreaTerrainLayer(beautificationID, "SnowSand75", 0, 1);
		rmSetAreaCoherence(beautificationID, 0.3);
		rmSetAreaSmoothDistance(beautificationID, 8);
		rmSetAreaMinBlobs(beautificationID, 1);
		rmSetAreaMaxBlobs(beautificationID, 5);
		rmSetAreaMinBlobDistance(beautificationID, 16.0);
		rmSetAreaMaxBlobDistance(beautificationID, 40.0);
		rmAddAreaToClass(beautificationID, classBeautification);
		rmAddAreaConstraint(beautificationID, avoidPlayer);
		rmAddAreaConstraint(beautificationID, avoidWater);
		rmAddAreaConstraint(beautificationID, avoidBeautification);
		rmSetAreaWarnFailure(beautificationID, false);
		rmBuildArea(beautificationID);
	}

	progress(0.3);

	// Settlements.
	int settlementID = rmCreateObjectDef("settlements");
	rmAddObjectDefItem(settlementID, "Settlement", 1, 0.0);

	float tcDist = 65.0;
	int settlementAvoidCenter = createClassDistConstraint(classCenter, 10.0 + 0.5 * (tcDist - 2.0 * centerRadius));
	int farAvoidImpassableLand = createTerrainDistConstraint("Land", false, 25.0);

	// Close settlement.
	addFairLocConstraint(farAvoidImpassableLand);

	if(cNonGaiaPlayers > 2) {
		addFairLocConstraint(avoidTowerLOS);
	}

	addFairLoc(60.0, 80.0, false, true, 50.0, 12.0, 12.0);

	placeObjectAtNewFairLocs(settlementID, false, "close settlement");

	// Far settlement.
	addFairLocConstraint(settlementAvoidCenter);
	addFairLocConstraint(farAvoidImpassableLand);
	addFairLocConstraint(createTypeDistConstraint("AbstractSettlement", 70.0));

	if(cNonGaiaPlayers < 3) {
		addFairLoc(80.0, 100.0, true, false, 65.0, 12.0, 12.0);
	} else if(cNonGaiaPlayers < 9) {
		addFairLoc(90.0, 120.0, true, randChance(), 75.0, 12.0, 12.0);
	} else {
		addFairLoc(90.0, 120.0, true, randChance(), 65.0, 12.0, 12.0);
	}

	placeObjectAtNewFairLocs(settlementID, false, "far settlement");

	progress(0.4);

	// Forests.
	initForestClass();

	// Avoid center a bit more due to usually having cliffs.
	addForestConstraint(createClassDistConstraint(classCenter, 5.0));
	addForestConstraint(avoidStartingSettlement);
	addForestConstraint(avoidAll);
	addForestConstraint(avoidWater);

	addForestType("Mixed Pine Forest", 0.5);
	addForestType("Pine Forest", 0.5);

	setForestAvoidSelf(20.0);

	setForestBlobs(9);
	setForestBlobParams(5.0, 4.75);
	setForestCoherence(-0.75, 0.75);

	// Player forests.
	setForestSearchRadius(30.0, 40.0);
	setForestMinRatio(2.0 / 3.0);

	int numPlayerForests = 2;

	buildPlayerForests(numPlayerForests, 0.1);

	progress(0.5);

	// Normal forests.
	setForestSearchRadius(35.0, rmXFractionToMeters(0.65));
	setForestMinRatio(2.0 / 3.0);

	int numForests = 9 * cNonGaiaPlayers / 2;

	buildForests(numForests, 0.3);

	progress(0.8);

	// Build gold center.
	int goldAreaID = rmCreateArea("center gold area");
	rmSetAreaSize(goldAreaID, 1.0);
	rmAddAreaConstraint(goldAreaID, createBoxConstraint(0.375, 0.15, 0.625, 0.85));
	rmSetAreaWarnFailure(goldAreaID, false);
	rmBuildArea(goldAreaID);

	// Add constraint to gold.
	rmAddObjectDefConstraint(bonusGoldID, createAreaConstraint(goldAreaID));

	// Object placement.
	// Far gold.
	placeFarObjectMirrored(bonusGoldID, false, rmRandInt(2, 3));

	// Starting gold. Since we place 2, we don't care if it gets close to towers or not.
	placeObjectMirrored(startingGoldID, false, 2, 21.0, 26.0, true);

	// Close hunt.
	placeObjectMirrored(closeHuntID, false, 1, 30.0, 50.0);

	// Bonus hunt.
	placeObjectMirrored(bonusHuntID, false, 1, 60.0, 100.0);

	// Starting food.
	placeObjectMirrored(startingFoodID, false, 1, 21.0, 27.0, true);

	// Berries.
	placeFarObjectMirrored(farBerriesID);

	// Straggler trees.
	placeObjectMirrored(stragglerTreeID, false, rmRandInt(2, 5), 13.0, 13.5, true);

	// Medium herdables.
	placeObjectMirrored(mediumHerdablesID, false, rmRandInt(1, 2), 55.0, 75.0);

	// Far herdables.
	placeFarObjectMirrored(farHerdablesID, false, rmRandInt(1, 2));

	// Starting herdables.
	placeObjectMirrored(startingHerdablesID, true, 1, 20.0, 30.0);

	// Far predators.
	placeFarObjectMirrored(farPredatorsID);

	progress(0.9);

	// Center forest.
	int centerForestID = rmCreateArea("center forest");
	if(randChance()) {
		rmSetAreaForestType(centerForestID, "Pine Forest");
	} else {
		rmSetAreaForestType(centerForestID, "Mixed Pine Forest");
	}
	rmSetAreaSize(centerForestID, areaRadiusMetersToFraction(rmRandFloat(2.0, 3.0)));
	rmSetAreaLocation(centerForestID, 0.5, 0.5);
	rmSetAreaCoherence(centerForestID, 1.0);
	rmBuildArea(centerForestID);

	// Relics (non mirrored).
	placeObjectInPlayerSplits(relicID);

	// Random trees.
	placeObjectAtPlayerLocs(randomTreeID, false, 10);

	// Embellishment.
	// Rocks.
	int rockID = rmCreateObjectDef("rock sprite");
	rmAddObjectDefItem(rockID, "Rock Sandstone Sprite", 3, 2.0);
	setObjectDefDistanceToMax(rockID);
	rmAddObjectDefConstraint(rockID, avoidPlayer);
	rmAddObjectDefConstraint(rockID, avoidWater);
	rmAddObjectDefConstraint(rockID, createTypeDistConstraint("All", 3.0));
	rmAddObjectDefConstraint(rockID, avoidBeautification);
	rmPlaceObjectDefAtLoc(rockID, 0, 0.5, 0.5, 10 * cNonGaiaPlayers);

	// Birds.
	int birdsID = rmCreateObjectDef("birds");
	rmAddObjectDefItem(birdsID, "Vulture", 1, 0.0);
	setObjectDefDistanceToMax(birdsID);
	rmPlaceObjectDefAtLoc(birdsID, 0, 0.5, 0.5, 2 * cNonGaiaPlayers);

	// Finalize RM X.
	rmxFinalize();

	progress(1.0);
}
