/*
** GHOST LAKE MIRROR
** RebelsRising
** Last edit: 09/03/2021
*/

include "rmx.xs";

void main() {
	progress(0.0);

	// Initial map setup.
	rmxInit("Ghost Lake X");

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
	initializeMap("SnowB", mapSize);

	// Set lighting.
	rmSetLightingSet("Ghost Lake X");

	// Place players.
	float radius = rmRandFloat(0.35, 0.4);

	if(cNonGaiaPlayers < 9) {
		placePlayersInCircle(radius, radius, 0.7);
	} else {
		placePlayersInCircle(radius, radius, 0.9);
	}

	// Initialize areas.
	int classCorner = initializeCorners(25.0);

	// Define classes.
	int classCliff = initCliffClass();
	int classStartingSettlement = rmDefineClass("starting settlement");
	int classPlayer = rmDefineClass("player");
	int classCenter = rmDefineClass("center");

	// Define global constraints.
	// General.
	int avoidAll = createTypeDistConstraint("All", 7.0);
	int avoidEdge = createSymmetricBoxConstraint(rmXTilesToFraction(4), rmZTilesToFraction(4));
	int avoidCorner = createClassDistConstraint(classCorner, 1.0);
	int avoidPlayer = createClassDistConstraint(classPlayer, 1.0);

	// Terrain.
	int shortAvoidCenter = createClassDistConstraint(classCenter, 1.0);
	int mediumAvoidCenter = createClassDistConstraint(classCenter, 10.0);
	int farAvoidCenter = createClassDistConstraint(classCenter, 20.0);
	int shortAvoidImpassableLand = createTerrainDistConstraint("Land", false, 1.0);
	int mediumAvoidImpassableLand = createTerrainDistConstraint("Land", false, 5.0);
	int farAvoidImpassableLand = createTerrainDistConstraint("Land", false, 10.0);
	int avoidCliff = createClassDistConstraint(classCliff, 1.0);

	// Settlements.
	int avoidStartingSettlement = createClassDistConstraint(classStartingSettlement, 20.0);
	int avoidSettlement = createTypeDistConstraint("AbstractSettlement", 15.0);
	int goldAvoidSettlement = createTypeDistConstraint("AbstractSettlement", 20.0);

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
	int avoidBuildings = createTypeDistConstraint("Building", 22.5);
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

	// Starting gold.
	int startingGoldID = rmCreateObjectDef("starting gold");
	rmAddObjectDefItem(startingGoldID, "Gold Mine Small", 1, 0.0);
	rmAddObjectDefConstraint(startingGoldID, avoidAll);
	rmAddObjectDefConstraint(startingGoldID, avoidEdge);
	rmAddObjectDefConstraint(startingGoldID, createTypeDistConstraint("Gold", 30.0));

	// Close hunt.
	int closeHuntID = rmCreateObjectDef("close hunt");
	if(randChance(0.7)) {
		rmAddObjectDefItem(closeHuntID, "Boar", rmRandInt(1, 3), 2.0);
	} else {
		rmAddObjectDefItem(closeHuntID, "Aurochs", rmRandInt(1, 2), 2.0);
	}
	rmAddObjectDefConstraint(closeHuntID, avoidAll);
	rmAddObjectDefConstraint(closeHuntID, avoidEdge);
	rmAddObjectDefConstraint(closeHuntID, avoidFood);
	rmAddObjectDefConstraint(closeHuntID, shortAvoidGold);
	rmAddObjectDefConstraint(closeHuntID, mediumAvoidCenter);
	rmAddObjectDefConstraint(closeHuntID, avoidCliff);

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
	rmAddObjectDefItem(startingHerdablesID, "Goat", rmRandInt(2, 5), 2.0);
	rmAddObjectDefConstraint(startingHerdablesID, avoidAll);
	rmAddObjectDefConstraint(startingHerdablesID, avoidEdge);

	// Straggler trees.
	int stragglerTreeID = rmCreateObjectDef("straggler tree");
	rmAddObjectDefItem(stragglerTreeID, "Pine Snow", 1, 0.0);
	rmAddObjectDefConstraint(stragglerTreeID, avoidAll);

	// Gold.
	// Bonus gold.
	int bonusGoldID = rmCreateObjectDef("bonus gold");
	rmAddObjectDefItem(bonusGoldID, "Gold Mine", 1, 0.0);
	rmAddObjectDefConstraint(bonusGoldID, avoidAll);
	rmAddObjectDefConstraint(bonusGoldID, avoidEdge);
	rmAddObjectDefConstraint(bonusGoldID, avoidCorner);
	rmAddObjectDefConstraint(bonusGoldID, createClassDistConstraint(classStartingSettlement, 70.0));
	rmAddObjectDefConstraint(bonusGoldID, goldAvoidSettlement);
	rmAddObjectDefConstraint(bonusGoldID, farAvoidGold);
	rmAddObjectDefConstraint(bonusGoldID, mediumAvoidCenter);
	rmAddObjectDefConstraint(bonusGoldID, avoidCliff);
	rmAddObjectDefConstraint(bonusGoldID, farAvoidImpassableLand);

	// Food.
	// Bonus huntable.
	int bonusHuntID = rmCreateObjectDef("bonus hunt");
	rmAddObjectDefItem(bonusHuntID, "Caribou", rmRandInt(4, 10), 4.0);
	rmAddObjectDefConstraint(bonusHuntID, avoidAll);
	rmAddObjectDefConstraint(bonusHuntID, avoidEdge);
	rmAddObjectDefConstraint(bonusHuntID, createClassDistConstraint(classStartingSettlement, 50.0));
	rmAddObjectDefConstraint(bonusHuntID, avoidHuntable);
	rmAddObjectDefConstraint(bonusHuntID, mediumAvoidCenter);
	rmAddObjectDefConstraint(bonusHuntID, avoidCliff);
	rmAddObjectDefConstraint(bonusHuntID, mediumAvoidImpassableLand);

	// Medium herdables.
	int mediumHerdablesID = rmCreateObjectDef("medium herdables");
	rmAddObjectDefItem(mediumHerdablesID, "Goat", rmRandInt(0, 2), 4.0);
	rmAddObjectDefConstraint(mediumHerdablesID, avoidAll);
	rmAddObjectDefConstraint(mediumHerdablesID, avoidEdge);
	rmAddObjectDefConstraint(mediumHerdablesID, createClassDistConstraint(classStartingSettlement, 50.0));
	rmAddObjectDefConstraint(mediumHerdablesID, avoidHerdable);
	rmAddObjectDefConstraint(mediumHerdablesID, avoidTowerLOS);
	rmAddObjectDefConstraint(mediumHerdablesID, shortAvoidImpassableLand);

	// Far herdables.
	int farHerdablesID = rmCreateObjectDef("far herdables");
	rmAddObjectDefItem(farHerdablesID, "Goat", 2, 4.0);
	rmAddObjectDefConstraint(farHerdablesID, avoidAll);
	rmAddObjectDefConstraint(farHerdablesID, avoidEdge);
	rmAddObjectDefConstraint(farHerdablesID, createClassDistConstraint(classStartingSettlement, 70.0));
	rmAddObjectDefConstraint(farHerdablesID, avoidHerdable);
	rmAddObjectDefConstraint(farHerdablesID, shortAvoidImpassableLand);

	// Far predators.
	int farPredatorsID = rmCreateObjectDef("far predators");
	rmAddObjectDefItem(farPredatorsID, "Polar Bear", rmRandInt(1, 2), 4.0);
	rmAddObjectDefConstraint(farPredatorsID, avoidAll);
	rmAddObjectDefConstraint(farPredatorsID, avoidEdge);
	rmAddObjectDefConstraint(farPredatorsID, createClassDistConstraint(classStartingSettlement, 80.0));
	rmAddObjectDefConstraint(farPredatorsID, avoidSettlement);
	rmAddObjectDefConstraint(farPredatorsID, avoidPredator);
	rmAddObjectDefConstraint(farPredatorsID, avoidCliff);

	// Far berries.
	int farBerriesID = rmCreateObjectDef("far berries");
	rmAddObjectDefItem(farBerriesID, "Berry Bush", rmRandInt(4, 10), 4.0);
	rmAddObjectDefConstraint(farBerriesID, avoidAll);
	rmAddObjectDefConstraint(farBerriesID, avoidEdge);
	rmAddObjectDefConstraint(farBerriesID, createClassDistConstraint(classStartingSettlement, 70.0));
	rmAddObjectDefConstraint(farBerriesID, avoidSettlement);
	rmAddObjectDefConstraint(farBerriesID, avoidFood);
	rmAddObjectDefConstraint(farBerriesID, mediumAvoidCenter);
	rmAddObjectDefConstraint(farBerriesID, avoidCliff);
	rmAddObjectDefConstraint(farBerriesID, farAvoidImpassableLand);

	// Other objects.
	// Random trees.
	int randomTreeID = rmCreateObjectDef("random tree");
	rmAddObjectDefItem(randomTreeID, "Pine Snow", 1, 0.0);
	setObjectDefDistanceToMax(randomTreeID);
	rmAddObjectDefConstraint(randomTreeID, avoidAll);
	rmAddObjectDefConstraint(randomTreeID, avoidStartingSettlement);
	rmAddObjectDefConstraint(randomTreeID, avoidSettlement);
	rmAddObjectDefConstraint(randomTreeID, mediumAvoidCenter);
	rmAddObjectDefConstraint(randomTreeID, avoidCliff);

	// Relics.
	int relicID = rmCreateObjectDef("relic");
	rmAddObjectDefItem(relicID, "Relic", 1, 0.0);
	rmAddObjectDefConstraint(relicID, avoidAll);
	rmAddObjectDefConstraint(relicID, avoidEdge);
	rmAddObjectDefConstraint(relicID, createClassDistConstraint(classStartingSettlement, 80.0));
	rmAddObjectDefConstraint(relicID, avoidRelic);
	rmAddObjectDefConstraint(relicID, mediumAvoidCenter);
	rmAddObjectDefConstraint(relicID, mediumAvoidImpassableLand);

	progress(0.1);

	// Set up player areas.
	for(i = 1; < cPlayers) {
		int playerAreaID = rmCreateArea("player area " + i);
		rmSetAreaSize(playerAreaID, rmAreaTilesToFraction(1800));
		rmSetAreaLocPlayer(playerAreaID, getPlayer(i));
		rmSetAreaTerrainType(playerAreaID, "SnowB");
		rmSetAreaCoherence(playerAreaID, 1.0);
		rmAddAreaToClass(playerAreaID, classPlayer);
		rmSetAreaWarnFailure(playerAreaID, false);
	}

	rmBuildAllAreas();

	// Build center.
	int centerID = 0;
	int numAreas = 5 + 10 * cNonGaiaPlayers;

	float a = getTeamAngle(0) - 0.875 * PI;
	float b = getTeamAngle(0) - 1.125 * PI;
	float r = radius - rmRandFloat(0.0, 0.15);

	float px = getXFromPolar(r, getTeamAngle(0), 0.5);
	float pz = getZFromPolar(r, getTeamAngle(0), 0.5);

	float x1 = getXFromPolar(r, a, px);
	float z1 = getZFromPolar(r, a, pz);
	float x2 = getXFromPolar(r, b, px);
	float z2 = getZFromPolar(r, b, pz);

	float incrX = (x2 - x1) / (numAreas - 1);
	float incrZ = (z2 - z1) / (numAreas - 1);

	for(i = 0; < numAreas) {
		float offsetX = rmRandFloat(-0.075, 0.075);
		float offsetZ = rmRandFloat(-0.075, 0.075);
		float lakeBlobSize = 0.0;

		if(cNonGaiaPlayers == 2) {
			lakeBlobSize = rmRandFloat(0.02, 0.06);
		} else {
			lakeBlobSize = rmRandFloat(0.02, 0.04);
		}

		for(j = 0; < 2) {
			centerID = rmCreateArea("ice " + j + " " + i);
			rmSetAreaSize(centerID, lakeBlobSize);
			rmSetAreaCoherence(centerID, 1.0);
			rmSetAreaWarnFailure(centerID, false);
			rmAddAreaToClass(centerID, classCenter);
			rmAddAreaConstraint(centerID, avoidPlayer);

			if(randChance()) {
				rmSetAreaTerrainType(centerID, "IceA");
			} else {
				rmSetAreaTerrainType(centerID, "IceB");
			}

			if(j == 1) {
				rmSetAreaLocation(centerID, incrX * i + x1 + offsetX, incrZ * i + z1 + offsetZ);
			} else {
				rmSetAreaLocation(centerID, 1.0 - incrX * i - x1 - offsetX, 1.0 - incrZ * i - z1 - offsetZ);
			}
		}
	}

	rmBuildAllAreas();

	progress(0.2);

	// Decorate player areas.
	for(i = 1; < cPlayers) {
		playerAreaID = rmCreateArea("player area beautification " + i);
		rmSetAreaSize(playerAreaID, rmAreaTilesToFraction(1500));
		rmSetAreaLocPlayer(playerAreaID, getPlayer(i));
		rmSetAreaTerrainType(playerAreaID, "SnowGrass50");
		rmAddAreaTerrainLayer(playerAreaID, "SnowGrass25", 0, 8);
		rmSetAreaCoherence(playerAreaID, 0.4);
		rmSetAreaMinBlobs(playerAreaID, 2);
		rmSetAreaMaxBlobs(playerAreaID, 3);
		rmSetAreaMinBlobDistance(playerAreaID, 20.0);
		rmSetAreaMaxBlobDistance(playerAreaID, 20.0);
		rmAddAreaConstraint(playerAreaID, mediumAvoidCenter);
		rmSetAreaWarnFailure(playerAreaID, false);
	}

	rmBuildAllAreas();

	// TCs.
	placeObjectAtPlayerLocs(startingSettlementID, true);

	// Towers.
	placeObjectMirrored(startingTowerID, true, 4, 23.0, 27.0, true, -1, startingTowerBackupID);

	// Beautification.
	int beautificationID = 0;

	for(i = 0; < 10 * cPlayers) {
		beautificationID = rmCreateArea("beautification 1 " + i);
		rmSetAreaTerrainType(beautificationID, "SnowGrass50");
		rmAddAreaTerrainLayer(beautificationID, "SnowGrass25", 2, 5);
		rmAddAreaTerrainLayer(beautificationID, "SnowB", 0, 2);
		rmSetAreaSize(beautificationID, rmAreaTilesToFraction(50), rmAreaTilesToFraction(200));
		rmSetAreaCoherence(beautificationID, 0.4);
		rmSetAreaMinBlobs(beautificationID, 1);
		rmSetAreaMaxBlobs(beautificationID, 5);
		rmSetAreaMinBlobDistance(beautificationID, 16.0);
		rmSetAreaMaxBlobDistance(beautificationID, 40.0);
		rmAddAreaConstraint(beautificationID, shortAvoidCenter);
		rmAddAreaConstraint(beautificationID, avoidPlayer);
		rmSetAreaWarnFailure(beautificationID, false);
		rmBuildArea(beautificationID);
	}

	for(i = 0; < 10 * cPlayers) {
		beautificationID = rmCreateArea("beautification 2 " + i);
		if(randChance()) {
			rmSetAreaTerrainType(beautificationID, "SnowA");
		} else {
			rmSetAreaTerrainType(beautificationID, "SnowSand25");
		}
		rmSetAreaSize(beautificationID, rmAreaTilesToFraction(10), rmAreaTilesToFraction(30));
		rmSetAreaCoherence(beautificationID, 0.4);
		rmSetAreaMinBlobs(beautificationID, 1);
		rmSetAreaMaxBlobs(beautificationID, 5);
		rmSetAreaMinBlobDistance(beautificationID, 16.0);
		rmSetAreaMaxBlobDistance(beautificationID, 40.0);
		rmAddAreaConstraint(beautificationID, shortAvoidCenter);
		rmAddAreaConstraint(beautificationID, avoidPlayer);
		rmSetAreaWarnFailure(beautificationID, false);
		rmBuildArea(beautificationID);
	}

	progress(0.3);

	// Settlements.
	int settlementID = rmCreateObjectDef("settlements");
	rmAddObjectDefItem(settlementID, "Settlement", 1, 0.0);

	// Far settlement.
	addFairLocConstraint(avoidTowerLOS);
	addFairLocConstraint(farAvoidCenter);

	if(cNonGaiaPlayers < 3) {
		addFairLoc(70.0, 120.0, true, false, 65.0, 12.0, 12.0);
	} else {
		addFairLocConstraint(createClassDistConstraint(classStartingSettlement, 50.0));
		addFairLoc(80.0, 120.0, true, false, 75.0, 12.0, 12.0);
	}

	// Close settlement.
	addFairLocConstraint(farAvoidCenter);

	if(cNonGaiaPlayers < 3) {
		addFairLocConstraint(avoidCorner);
		addFairLoc(60.0, 80.0, false, true, 65.0, 12.0, 12.0);
	} else {
		addFairLocConstraint(avoidTowerLOS);
		addFairLocConstraint(createClassDistConstraint(classStartingSettlement, 50.0));
		addFairLoc(60.0, 80.0, false, true, 50.0, 12.0, 12.0);
	}

	placeObjectAtNewFairLocs(settlementID, false, "settlements");

	progress(0.4);

	// Cliffs.
	setOuterCliff("CliffNorseA", 6.0, 4.5);
	setOuterCliffParams(1.5);
	setInnerCliff("SnowA", 6.0, 5.0);
	setInnerCliffParams(5.0);
	setCliffRamp("SnowA", 6.75, 5.0);
	setCliffRampParams(4.0);

	setCliffAvoidSelf(40.0);

	setCliffBlobs(4, 6);

	setCliffNumRamps(2);
	setCliffRequiredRatio(1.0);
	setCliffCoherence(-1.0, 0.5);
	setCliffSearchRadius(30.0, -1.0);

	addCliffConstraint(createClassDistConstraint(classStartingSettlement, 60.0));
	addCliffConstraint(avoidBuildings);
	addCliffConstraint(farAvoidCenter);

	buildCliffs(cNonGaiaPlayers, 0.1);

	progress(0.5);

	// Forests.
	initForestClass();

	addForestConstraint(farAvoidImpassableLand);
	addForestConstraint(avoidStartingSettlement);
	addForestConstraint(avoidAll);
	addForestConstraint(mediumAvoidCenter);

	addForestType("Snow Pine Forest", 1.0);

	setForestAvoidSelf(20.0);

	setForestBlobs(9);
	setForestBlobParams(5.0, 4.75);
	setForestCoherence(-0.75, 0.75);

	// Player forests.
	setForestSearchRadius(30.0, 40.0);
	setForestMinRatio(2.0 / 3.0);

	int numPlayerForests = 2;

	buildPlayerForests(numPlayerForests, 0.1);

	progress(0.6);

	// Normal forests.
	setForestSearchRadius(rmXFractionToMeters(0.2), -1.0);
	setForestMinRatio(2.0 / 3.0);

	int numForests = 8 * cNonGaiaPlayers / 2;

	buildForests(numForests, 0.2);

	progress(0.8);

	// Object placement.
	// Far gold.
	placeFarObjectMirrored(bonusGoldID, false, rmRandInt(2, 4));

	// Starting gold (fixed to 2), don't place near tower.
	placeObjectMirrored(startingGoldID, false, 2, 21.0, 24.0, true);

	// Close hunt.
	placeObjectMirrored(closeHuntID, false, rmRandInt(1, 2), 30.0, 50.0);

	// Bonus hunt.
	placeObjectMirrored(bonusHuntID, false, rmRandInt(1, 2), 60.0, 100.0);

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

	// Relics (non mirrored).
	placeObjectInPlayerSplits(relicID);

	// Random trees.
	placeObjectAtPlayerLocs(randomTreeID, false, 10);

	// Embellishment.
	// Rocks.
	int rockID = rmCreateObjectDef("rocks");
	rmAddObjectDefItem(rockID, "Rock Granite Sprite", 1, 0.0);
	setObjectDefDistanceToMax(rockID);
	rmAddObjectDefConstraint(rockID, embellishmentAvoidAll);
	rmAddObjectDefConstraint(rockID, shortAvoidCenter);
	rmPlaceObjectDefAtLoc(rockID, 0, 0.5, 0.5, 15 * cNonGaiaPlayers);

	// Birds.
	int birdsID = rmCreateObjectDef("birds");
	rmAddObjectDefItem(birdsID, "Hawk", 1, 0.0);
	setObjectDefDistanceToMax(birdsID);
	rmPlaceObjectDefAtLoc(birdsID, 0, 0.5, 0.5, 2 * cNonGaiaPlayers);

	// Finalize RM X.
	rmxFinalize();

	progress(1.0);
}
