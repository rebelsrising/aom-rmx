/*
** OASIS MIRROR
** RebelsRising
** Last edit: 14/05/2022
*/

include "rmx.xs";

void main() {
	progress(0.0);

	// Initial map setup.
	rmxInit("Oasis X");

	// Set mirror mode.
	setMirrorMode(cMirrorPoint);

	// Perform mirror check.
	if(mirrorConfigIsInvalid()) {
		injectMirrorGenError();

		// Invalid configuration, quit.
		return;
	}

	// Set size.
	int axisLength = getStandardMapDimInMeters();

	// Initialize map.
	initializeMap("SandA", axisLength);

	// Place players.
	placePlayersInSquare(0.4);

	// Initialize areas.
	float centerRadius = 22.5;

	int classCenter = initializeCenter(centerRadius);
	int classCorner = initializeCorners(25.0);

	// Define classes.
	int classOasis = rmDefineClass("oasis");
	int classStartingSettlement = rmDefineClass("starting settlement");
	int classForest = rmDefineClass("forest");

	// Define global constraints.
	// General.
	int avoidAll = createTypeDistConstraint("All", 7.0);
	int avoidEdge = createSymmetricBoxConstraint(rmXTilesToFraction(4), rmZTilesToFraction(4));
	int avoidCenter = createClassDistConstraint(classCenter, 1.0);
	int avoidCorner = createClassDistConstraint(classCorner, 1.0);
	int shortAvoidOasis = createClassDistConstraint(classOasis, 8.0);
	int mediumAvoidOasis = createClassDistConstraint(classOasis, 12.0);
	int farAvoidOasis = createClassDistConstraint(classOasis, 20.0);

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
	rmAddObjectDefItem(closeHuntID, "Zebra", rmRandInt(2, 5), 2.0);
	rmAddObjectDefConstraint(closeHuntID, avoidAll);
	rmAddObjectDefConstraint(closeHuntID, avoidEdge);
	rmAddObjectDefConstraint(closeHuntID, shortAvoidOasis);
	rmAddObjectDefConstraint(closeHuntID, shortAvoidGold);

	// Starting food.
	int startingFoodID = rmCreateObjectDef("starting food");
	if(randChance()) {
		rmAddObjectDefItem(startingFoodID, "Chicken", rmRandInt(5, 8), 2.0);
	} else {
		rmAddObjectDefItem(startingFoodID, "Berry Bush", rmRandInt(6, 8), 2.0);
	}
	rmAddObjectDefConstraint(startingFoodID, avoidAll);
	rmAddObjectDefConstraint(startingFoodID, avoidEdge);
	rmAddObjectDefConstraint(startingFoodID, shortAvoidOasis);
	rmAddObjectDefConstraint(startingFoodID, avoidFood);
	rmAddObjectDefConstraint(startingFoodID, shortAvoidGold);

	// Starting herdables.
	int startingHerdablesID = rmCreateObjectDef("starting herdables");
	rmAddObjectDefItem(startingHerdablesID, "Goat", 2, 2.0);
	rmAddObjectDefConstraint(startingHerdablesID, avoidAll);
	rmAddObjectDefConstraint(startingHerdablesID, avoidEdge);
	rmAddObjectDefConstraint(startingHerdablesID, shortAvoidOasis);

	// Straggler trees.
	int stragglerTreeID = rmCreateObjectDef("straggler tree");
	rmAddObjectDefItem(stragglerTreeID, "Palm", 1, 0.0);
	rmAddObjectDefConstraint(stragglerTreeID, avoidAll);

	// Gold
	// Medium gold.
	int mediumGoldID = rmCreateObjectDef("medium gold");
	rmAddObjectDefItem(mediumGoldID, "Gold Mine", 1, 0.0);
	rmAddObjectDefConstraint(mediumGoldID, avoidAll);
	rmAddObjectDefConstraint(mediumGoldID, avoidEdge);
	rmAddObjectDefConstraint(mediumGoldID, shortAvoidOasis);
	rmAddObjectDefConstraint(mediumGoldID, createClassDistConstraint(classStartingSettlement, 50.0));
	rmAddObjectDefConstraint(mediumGoldID, goldAvoidSettlement);
	rmAddObjectDefConstraint(mediumGoldID, farAvoidGold);
	rmAddObjectDefConstraint(mediumGoldID, avoidTowerLOS);

	// Bonus gold.
	int bonusGoldID = rmCreateObjectDef("bonus gold");
	rmAddObjectDefItem(bonusGoldID, "Gold Mine", 1, 0.0);
	rmAddObjectDefConstraint(bonusGoldID, avoidAll);
	rmAddObjectDefConstraint(bonusGoldID, avoidEdge);
	rmAddObjectDefConstraint(bonusGoldID, shortAvoidOasis);
	rmAddObjectDefConstraint(bonusGoldID, avoidCenter);
	if(gameIs1v1()) {
		rmAddObjectDefConstraint(bonusGoldID, createClassDistConstraint(classStartingSettlement, 80.0));
	} else {
		rmAddObjectDefConstraint(bonusGoldID, createClassDistConstraint(classStartingSettlement, 50.0));
	}
	rmAddObjectDefConstraint(bonusGoldID, goldAvoidSettlement);
	rmAddObjectDefConstraint(bonusGoldID, farAvoidGold);

	// Hunt and berries.
	// Bonus huntable.
	int bonusHuntID = rmCreateObjectDef("bonus hunt");
	if(randChance()) {
		rmAddObjectDefItem(bonusHuntID, "Giraffe", rmRandInt(2, 3), 2.0);
		rmAddObjectDefItem(bonusHuntID, "Gazelle", rmRandInt(0, 4), 2.0);
	} else {
		rmAddObjectDefItem(bonusHuntID, "Giraffe", rmRandInt(2, 5), 2.0);
	}
	rmAddObjectDefConstraint(bonusHuntID, avoidAll);
	rmAddObjectDefConstraint(bonusHuntID, avoidEdge);
	rmAddObjectDefConstraint(bonusHuntID, avoidCenter);
	rmAddObjectDefConstraint(bonusHuntID, shortAvoidOasis);
	rmAddObjectDefConstraint(bonusHuntID, createClassDistConstraint(classStartingSettlement, 50.0));
	rmAddObjectDefConstraint(bonusHuntID, avoidHuntable);

	// Far monkeys.
	int farMonkeysID = rmCreateObjectDef("far monkeys");
	if(randChance()) {
		rmAddObjectDefItem(farMonkeysID, "Monkey", rmRandInt(5, 8), 2.0);
	} else {
		rmAddObjectDefItem(farMonkeysID, "Baboon", rmRandInt(4, 6), 2.0);
	}
	rmAddObjectDefConstraint(farMonkeysID, avoidAll);
	rmAddObjectDefConstraint(farMonkeysID, avoidEdge);
	rmAddObjectDefConstraint(farMonkeysID, avoidCenter);
	rmAddObjectDefConstraint(farMonkeysID, shortAvoidOasis);
	rmAddObjectDefConstraint(farMonkeysID, createClassDistConstraint(classStartingSettlement, 80.0));
	rmAddObjectDefConstraint(farMonkeysID, avoidFood);
	rmAddObjectDefConstraint(farMonkeysID, avoidHuntable);

	// Far berries.
	int farBerriesID = rmCreateObjectDef("far berries");
	rmAddObjectDefItem(farBerriesID, "Berry Bush", rmRandInt(4, 10), 4.0);
	rmAddObjectDefConstraint(farBerriesID, avoidAll);
	rmAddObjectDefConstraint(farBerriesID, avoidEdge);
	rmAddObjectDefConstraint(farBerriesID, avoidCenter);
	rmAddObjectDefConstraint(farBerriesID, shortAvoidOasis);
	rmAddObjectDefConstraint(farBerriesID, createClassDistConstraint(classStartingSettlement, 70.0));
	rmAddObjectDefConstraint(farBerriesID, avoidSettlement);
	rmAddObjectDefConstraint(farBerriesID, avoidFood);

	// Herdables and predators.
	// Medium herdables.
	int mediumHerdablesID = rmCreateObjectDef("medium herdables");
	rmAddObjectDefItem(mediumHerdablesID, "Goat", rmRandInt(1, 3), 4.0);
	rmAddObjectDefConstraint(mediumHerdablesID, avoidAll);
	rmAddObjectDefConstraint(mediumHerdablesID, avoidEdge);
	rmAddObjectDefConstraint(mediumHerdablesID, avoidCenter);
	rmAddObjectDefConstraint(mediumHerdablesID, shortAvoidOasis);
	rmAddObjectDefConstraint(mediumHerdablesID, createClassDistConstraint(classStartingSettlement, 50.0));
	rmAddObjectDefConstraint(mediumHerdablesID, avoidHerdable);
	rmAddObjectDefConstraint(mediumHerdablesID, avoidTowerLOS);

	// Far herdables.
	int farHerdablesID = rmCreateObjectDef("far herdables");
	rmAddObjectDefItem(farHerdablesID, "Goat", rmRandInt(1, 2), 4.0);
	rmAddObjectDefConstraint(farHerdablesID, avoidAll);
	rmAddObjectDefConstraint(farHerdablesID, avoidEdge);
	rmAddObjectDefConstraint(farHerdablesID, avoidCenter);
	rmAddObjectDefConstraint(farHerdablesID, shortAvoidOasis);
	rmAddObjectDefConstraint(farHerdablesID, createClassDistConstraint(classStartingSettlement, 70.0));
	rmAddObjectDefConstraint(farHerdablesID, avoidHerdable);

	// Far predators.
	int farPredatorsID = rmCreateObjectDef("far predators");
	if(randChance()) {
		rmAddObjectDefItem(farPredatorsID, "Lion", rmRandInt(1, 2), 4.0);
	} else {
		rmAddObjectDefItem(farPredatorsID, "Hyena", 2, 4.0);
	}
	rmAddObjectDefConstraint(farPredatorsID, avoidAll);
	rmAddObjectDefConstraint(farPredatorsID, avoidEdge);
	rmAddObjectDefConstraint(farPredatorsID, shortAvoidOasis);
	rmAddObjectDefConstraint(farPredatorsID, avoidCenter);
	rmAddObjectDefConstraint(farPredatorsID, createClassDistConstraint(classStartingSettlement, 80.0));
	rmAddObjectDefConstraint(farPredatorsID, avoidSettlement);
	rmAddObjectDefConstraint(farPredatorsID, avoidPredator);

	// Other objects.
	// Random trees 1.
	int randomTree1ID = rmCreateObjectDef("random tree 1");
	rmAddObjectDefItem(randomTree1ID, "Palm", 1, 0.0);
	setObjectDefDistanceToMax(randomTree1ID);
	rmAddObjectDefConstraint(randomTree1ID, avoidAll);
	rmAddObjectDefConstraint(randomTree1ID, shortAvoidOasis);
	rmAddObjectDefConstraint(randomTree1ID, avoidStartingSettlement);
	rmAddObjectDefConstraint(randomTree1ID, avoidSettlement);

	// Random trees 2.
	int randomTree2ID = rmCreateObjectDef("random tree 2");
	rmAddObjectDefItem(randomTree2ID, "Savannah Tree", 1, 0.0);
	setObjectDefDistanceToMax(randomTree2ID);
	rmAddObjectDefConstraint(randomTree2ID, avoidAll);
	rmAddObjectDefConstraint(randomTree2ID, shortAvoidOasis);
	rmAddObjectDefConstraint(randomTree2ID, avoidStartingSettlement);
	rmAddObjectDefConstraint(randomTree2ID, avoidSettlement);
	
	// Relics.
	int relicID = rmCreateObjectDef("relic");
	rmAddObjectDefItem(relicID, "Relic", 1, 0.0);
	rmAddObjectDefConstraint(relicID, avoidAll);
	rmAddObjectDefConstraint(relicID, avoidEdge);
	rmAddObjectDefConstraint(relicID, shortAvoidOasis);
	rmAddObjectDefConstraint(relicID, createClassDistConstraint(classStartingSettlement, 80.0));
	rmAddObjectDefConstraint(relicID, avoidRelic);

	progress(0.1);

	// Create oasis.
	int oasisForestID = 0;
	int oasisLakeID = 0;
	float oasisChance = rmRandFloat(0.0, 1.0);

	if(oasisChance < 0.25) {
		// Create oasis forest 1.
		oasisForestID = rmCreateArea("oasis forest 1");
		rmSetAreaSize(oasisForestID, 0.15);
		rmSetAreaLocation(oasisForestID, 0.5, 0.5);
		rmSetAreaForestType(oasisForestID, "Palm Forest");
		rmSetAreaCoherence(oasisForestID, 1.0);
		rmAddAreaToClass(oasisForestID, classOasis);
		rmAddAreaToClass(oasisForestID, classForest);
		rmSetAreaWarnFailure(oasisForestID, false);
		rmBuildArea(oasisForestID);

		// Create oasis lake 1.
		oasisLakeID = rmCreateArea("oasis lake 1");
		rmSetAreaSize(oasisLakeID, 0.06);
		rmSetAreaLocation(oasisLakeID, 0.5, 0.5);
		rmSetAreaWaterType(oasisLakeID, "Egyptian Nile");
		rmSetAreaCoherence(oasisLakeID,1.0);
		rmAddAreaToClass(oasisLakeID, classOasis);
		rmSetAreaWarnFailure(oasisLakeID, false);
		rmBuildArea(oasisLakeID);
	} else if(oasisChance < 0.5) {
		// Create oasis forest 1.
		oasisForestID = rmCreateArea("oasis forest 1");
		rmSetAreaSize(oasisForestID, 0.075);
		rmSetAreaLocation(oasisForestID, 0.35, 0.65);
		rmSetAreaForestType(oasisForestID, "Palm Forest");
		rmSetAreaCoherence(oasisForestID, 1.0);
		rmAddAreaToClass(oasisForestID, classOasis);
		rmAddAreaToClass(oasisForestID, classForest);
		rmSetAreaWarnFailure(oasisForestID, false);
		rmBuildArea(oasisForestID);

		// Create oasis forest 2.
		oasisForestID = rmCreateArea("oasis forest 2");
		rmSetAreaSize(oasisForestID, 0.075);
		rmSetAreaLocation(oasisForestID, 0.65, 0.35);
		rmSetAreaForestType(oasisForestID, "Palm Forest");
		rmSetAreaCoherence(oasisForestID, 1.0);
		rmAddAreaToClass(oasisForestID, classOasis);
		rmAddAreaToClass(oasisForestID, classForest);
		rmSetAreaWarnFailure(oasisForestID, false);
		rmBuildArea(oasisForestID);

		// Create oasis lake 1.
		oasisLakeID = rmCreateArea("oasis lake 1");
		rmSetAreaSize(oasisLakeID, 0.03);
		rmSetAreaLocation(oasisLakeID, 0.35, 0.65);
		rmSetAreaWaterType(oasisLakeID, "Egyptian Nile");
		rmSetAreaCoherence(oasisLakeID, 1.0);
		rmAddAreaToClass(oasisLakeID, classOasis);
		rmSetAreaWarnFailure(oasisLakeID, false);
		rmBuildArea(oasisLakeID);

		// Create oasis lake 2.
		oasisLakeID = rmCreateArea("oasis lake 2");
		rmSetAreaSize(oasisLakeID, 0.03);
		rmSetAreaLocation(oasisLakeID, 0.65, 0.35);
		rmSetAreaWaterType(oasisLakeID, "Egyptian Nile");
		rmSetAreaCoherence(oasisLakeID, 1.0);
		rmAddAreaToClass(oasisLakeID, classOasis);
		rmSetAreaWarnFailure(oasisLakeID, false);
		rmBuildArea(oasisLakeID);
	} else if(oasisChance < 0.75) {
		// Create oasis forest 1.
		oasisForestID = rmCreateArea("oasis forest 1");
		rmSetAreaSize(oasisForestID, 0.075);
		rmSetAreaLocation(oasisForestID, 0.35, 0.35);
		rmSetAreaForestType(oasisForestID, "Palm Forest");
		rmSetAreaCoherence(oasisForestID, 1.0);
		rmAddAreaToClass(oasisForestID, classOasis);
		rmAddAreaToClass(oasisForestID, classForest);
		rmSetAreaWarnFailure(oasisForestID, false);
		rmBuildArea(oasisForestID);

		// Create oasis forest 2.
		oasisForestID = rmCreateArea("oasis forest 2");
		rmSetAreaSize(oasisForestID, 0.075);
		rmSetAreaLocation(oasisForestID, 0.65, 0.65);
		rmSetAreaForestType(oasisForestID, "Palm Forest");
		rmSetAreaCoherence(oasisForestID, 1.0);
		rmAddAreaToClass(oasisForestID, classOasis);
		rmAddAreaToClass(oasisForestID, classForest);
		rmSetAreaWarnFailure(oasisForestID, false);
		rmBuildArea(oasisForestID);

		// Create oasis lake 1.
		oasisLakeID = rmCreateArea("oasis lake 1");
		rmSetAreaSize(oasisLakeID, 0.03);
		rmSetAreaLocation(oasisLakeID, 0.35, 0.35);
		rmSetAreaWaterType(oasisLakeID, "Egyptian Nile");
		rmSetAreaCoherence(oasisLakeID, 1.0);
		rmAddAreaToClass(oasisLakeID, classOasis);
		rmSetAreaWarnFailure(oasisLakeID, false);
		rmBuildArea(oasisLakeID);

		// Create oasis lake 2.
		oasisLakeID = rmCreateArea("oasis lake 2");
		rmSetAreaSize(oasisLakeID, 0.03);
		rmSetAreaLocation(oasisLakeID, 0.65, 0.65);
		rmSetAreaWaterType(oasisLakeID, "Egyptian Nile");
		rmSetAreaCoherence(oasisLakeID, 1.0);
		rmAddAreaToClass(oasisLakeID, classOasis);
		rmSetAreaWarnFailure(oasisLakeID, false);
		rmBuildArea(oasisLakeID);
	} else {
		// Create oasis forest 1.
		oasisForestID = rmCreateArea("oasis forest 1");
		rmSetAreaSize(oasisForestID, 0.03);
		rmSetAreaLocation(oasisForestID, 0.5, 0.3);
		rmSetAreaForestType(oasisForestID, "Palm Forest");
		rmSetAreaCoherence(oasisForestID, 1.0);
		rmAddAreaToClass(oasisForestID, classOasis);
		rmAddAreaToClass(oasisForestID, classForest);
		rmSetAreaWarnFailure(oasisForestID, false);
		rmBuildArea(oasisForestID);

		// Create oasis forest 2.
		oasisForestID = rmCreateArea("oasis forest 2");
		rmSetAreaSize(oasisForestID, 0.03);
		rmSetAreaLocation(oasisForestID, 0.5, 0.7);
		rmSetAreaForestType(oasisForestID, "Palm Forest");
		rmSetAreaCoherence(oasisForestID, 1.0);
		rmAddAreaToClass(oasisForestID, classOasis);
		rmAddAreaToClass(oasisForestID, classForest);
		rmSetAreaWarnFailure(oasisForestID, false);
		rmBuildArea(oasisForestID);

		// Create oasis forest 3.
		oasisForestID = rmCreateArea("oasis forest 3");
		rmSetAreaSize(oasisForestID, 0.03);
		rmSetAreaLocation(oasisForestID, 0.3, 0.5);
		rmSetAreaForestType(oasisForestID, "Palm Forest");
		rmSetAreaCoherence(oasisForestID, 1.0);
		rmAddAreaToClass(oasisForestID, classOasis);
		rmAddAreaToClass(oasisForestID, classForest);
		rmSetAreaWarnFailure(oasisForestID, false);
		rmBuildArea(oasisForestID);

		// Create oasis forest 4.
		oasisForestID = rmCreateArea("oasis forest 4");
		rmSetAreaSize(oasisForestID, 0.03);
		rmSetAreaLocation(oasisForestID, 0.7, 0.5);
		rmSetAreaForestType(oasisForestID, "Palm Forest");
		rmSetAreaCoherence(oasisForestID, 1.0);
		rmAddAreaToClass(oasisForestID, classOasis);
		rmAddAreaToClass(oasisForestID, classForest);
		rmSetAreaWarnFailure(oasisForestID, false);
		rmBuildArea(oasisForestID);

		if(cNonGaiaPlayers > 4) {
			// Create oasis lake 1.
			oasisLakeID = rmCreateArea("oasis lake 1");
			rmSetAreaSize(oasisLakeID, 0.015);
			rmSetAreaLocation(oasisLakeID, 0.5, 0.3);
			rmSetAreaWaterType(oasisLakeID, "Egyptian Nile");
			rmSetAreaCoherence(oasisLakeID, 1.0);
			rmAddAreaToClass(oasisLakeID, classOasis);
			rmSetAreaWarnFailure(oasisLakeID, false);
			rmBuildArea(oasisLakeID);

			// Create oasis lake 2.
			oasisLakeID = rmCreateArea("oasis lake 2");
			rmSetAreaSize(oasisLakeID, 0.015);
			rmSetAreaLocation(oasisLakeID, 0.5, 0.7);
			rmSetAreaWaterType(oasisLakeID, "Egyptian Nile");
			rmSetAreaCoherence(oasisLakeID, 1.0);
			rmAddAreaToClass(oasisLakeID, classOasis);
			rmSetAreaWarnFailure(oasisLakeID, false);
			rmBuildArea(oasisLakeID);

			// Create oasis lake 3.
			oasisLakeID = rmCreateArea("oasis lake 3");
			rmSetAreaSize(oasisLakeID, 0.015);
			rmSetAreaLocation(oasisLakeID, 0.3, 0.5);
			rmSetAreaWaterType(oasisLakeID, "Egyptian Nile");
			rmSetAreaCoherence(oasisLakeID, 1.0);
			rmAddAreaToClass(oasisLakeID, classOasis);
			rmSetAreaWarnFailure(oasisLakeID, false);
			rmBuildArea(oasisLakeID);

			// Create oasis lake 4.
			oasisLakeID = rmCreateArea("oasis lake 4");
			rmSetAreaSize(oasisLakeID, 0.015);
			rmSetAreaLocation(oasisLakeID, 0.7, 0.5);
			rmSetAreaWaterType(oasisLakeID, "Egyptian Nile");
			rmSetAreaCoherence(oasisLakeID, 1.0);
			rmAddAreaToClass(oasisLakeID, classOasis);
			rmSetAreaWarnFailure(oasisLakeID, false);
			rmBuildArea(oasisLakeID);
		}
	}

	// Set up player areas.
	float playerAreaSize = rmAreaTilesToFraction(3000);

	for(i = 1; < cPlayers) {
		int playerAreaID = rmCreateArea("player area " + i);
		rmSetAreaSize(playerAreaID, 0.9 * playerAreaSize, 1.1 * playerAreaSize);
		rmSetAreaLocPlayer(playerAreaID, getPlayer(i));
		rmSetAreaTerrainType(playerAreaID, "SandDirt50");
		rmAddAreaTerrainLayer(playerAreaID, "SandA", 1, 2);
		rmAddAreaTerrainLayer(playerAreaID, "SandB", 0, 1);
		rmSetAreaMinBlobs(playerAreaID, 1);
		rmSetAreaMaxBlobs(playerAreaID, 5);
		rmSetAreaMinBlobDistance(playerAreaID, 16.0);
		rmSetAreaMaxBlobDistance(playerAreaID, 40.0);
		rmAddAreaConstraint(playerAreaID, mediumAvoidOasis);
		rmSetAreaWarnFailure(playerAreaID, false);
	}

	rmBuildAllAreas();

	// TCs.
	placeObjectAtPlayerLocs(startingSettlementID, true);

	// Towers.
	placeAndStoreObjectMirrored(startingTowerID, true, 4, 23.0, 27.0, true, -1, startingTowerBackupID);

	// Beautification.
	int beautificationID = 0;

	for(i = 0; < 5 * cPlayers) {
		beautificationID = rmCreateArea("beautification 1 " + i);
		rmSetAreaSize(beautificationID, rmAreaTilesToFraction(100), rmAreaTilesToFraction(200));
		rmSetAreaTerrainType(beautificationID, "SandD");
		rmSetAreaMinBlobs(beautificationID, 1);
		rmSetAreaMaxBlobs(beautificationID, 5);
		rmSetAreaMinBlobDistance(beautificationID, 16.0);
		rmSetAreaMaxBlobDistance(beautificationID, 40.0);
		rmAddAreaConstraint(beautificationID, shortAvoidOasis);
		rmSetAreaWarnFailure(beautificationID, false);
		rmBuildArea(beautificationID);
	}

	progress(0.2);

	// Center avoidance here is different due to the oasis/oases forming the center.
	int settlementID = rmCreateObjectDef("settlements");
	rmAddObjectDefItem(settlementID, "Settlement", 1, 0.0);

	int settlementAvoidCenter = createClassDistConstraint(classCenter, 35.0);

	// Close settlement.
	addFairLocConstraint(farAvoidOasis);

	if(gameIs1v1()) {
		addFairLocConstraint(avoidCorner);
	} else {
		addFairLocConstraint(avoidTowerLOS);
	}

	addFairLoc(60.0, 80.0, false, true, 65.0, 12.0, 12.0);

	// Far settlement.
	addFairLocConstraint(avoidTowerLOS);
	addFairLocConstraint(settlementAvoidCenter);
	addFairLocConstraint(farAvoidOasis);

	enableFairLocTwoPlayerCheck();

	if(gameIs1v1()) {
		addFairLoc(80.0, 110.0, true, false, 80.0, 16.0, 16.0);
	} else if(cNonGaiaPlayers < 5) {
		addFairLoc(80.0, 100.0, true, false, 75.0, 16.0, 16.0);
	} else {
		addFairLoc(70.0, 100.0, true, randChance(0.25), 75.0, 16.0, 16.0);
	}

	if(gameIs1v1()) {
		setFairLocInterDistMin(100.0);
	}

	placeObjectAtNewFairLocs(settlementID, false, "settlements");

	progress(0.3);

	// Forests.
	initForestClass();

	addForestConstraint(createClassDistConstraint(classForest, 20.0));
	addForestConstraint(avoidStartingSettlement);
	addForestConstraint(avoidAll);
	addForestConstraint(shortAvoidOasis);

	addForestType("Palm Forest", 1.0);

	// 30.0 instead of 25.0 to achieve a better spread.
	setForestAvoidSelf(30.0);

	setForestBlobs(6);
	setForestBlobParams(4.625, 4.25);
	setForestCoherence(-0.75, 0.75);

	// Player forests.
	setForestSearchRadius(30.0, 40.0);
	setForestMinRatio(1.0);

	int numPlayerForests = 2;

	buildPlayerForests(numPlayerForests, 0.1);

	progress(0.4);

	// Normal forests.
	setForestSearchRadius(rmXFractionToMeters(0.2), -1.0);
	setForestMinRatio(2.0 / 3.0);

	int numForests = 7 * cNonGaiaPlayers / 2;

	buildForests(numForests, 0.4);

	progress(0.8);

	// Avoid placing in center.
	float centerDist = 20.0;

	// Adjust for teamgames so we don't get the center full of stuff.
	if(gameIs1v1() == false) {
		centerDist = rmXFractionToMeters(0.175);
	}

	// Object placement.
	// Starting gold close to tower.
	storeObjectDefItem("Gold Mine Small", 1, 0.0);
	storeObjectConstraint(createTypeDistConstraint("Tower", rmRandFloat(8.0, 10.0))); // Don't get too close.
	storeObjectConstraint(avoidAll);
	storeObjectConstraint(avoidEdge);
	placeStoredObjectMirroredNearStoredLocs(4, false, 24.0, 25.0, 12.5);

	resetObjectStorage();

	// Medium gold.
	placeObjectMirrored(mediumGoldID, false, 1, 40.0, 65.0);

	// Far gold.
	placeFarObjectMirrored(bonusGoldID, false, 3, centerDist);

	// Close hunt.
	placeObjectMirrored(closeHuntID, false, 1, 30.0, 60.0);

	// Bonus hunt.
	placeFarObjectMirrored(bonusHuntID, false, 1, centerDist);

	// Close food.
	placeObjectMirrored(startingFoodID, false, 1, 22.0, 26.0, true);

	// Far monkeys.
	placeFarObjectMirrored(farMonkeysID, false, 1, centerDist);

	// Berries.
	placeFarObjectMirrored(farBerriesID, false, 1, centerDist);

	// Straggler trees.
	placeObjectMirrored(stragglerTreeID, false, rmRandInt(2, 5), 13.0, 13.5, true);

	// Medium herdables.
	placeObjectMirrored(mediumHerdablesID, false, 2, 50.0, 70.0);

	// Far herdables.
	placeFarObjectMirrored(farHerdablesID, false, rmRandInt(2, 3), centerDist);

	// Starting herdables.
	placeObjectMirrored(startingHerdablesID, true, 1, 20.0, 30.0);

	// Far predators.
	placeFarObjectMirrored(farPredatorsID, false, 1, centerDist);

	progress(0.9);

	// Relics (non-mirrored).
	placeObjectInPlayerSplits(relicID);

	// Random trees.
	placeObjectAtPlayerLocs(randomTree1ID, false, 7);
	placeObjectAtPlayerLocs(randomTree2ID, false, 3);

	// Embellishment.
	// Rocks.
	int rockID = rmCreateObjectDef("rocks");
	rmAddObjectDefItem(rockID, "Rock Sandstone Sprite", 1, 0.0);
	setObjectDefDistanceToMax(rockID);
	rmAddObjectDefConstraint(rockID, embellishmentAvoidAll);
	rmAddObjectDefConstraint(rockID, shortAvoidOasis);
	rmPlaceObjectDefAtLoc(rockID, 0, 0.5, 0.5, 30 * cNonGaiaPlayers);

	// Bushes.
	int bush1ID = rmCreateObjectDef("bush 1");
	rmAddObjectDefItem(bush1ID, "Bush", 4, 3.0);
	setObjectDefDistanceToMax(bush1ID);
	rmAddObjectDefConstraint(bush1ID, embellishmentAvoidAll);
	rmAddObjectDefConstraint(bush1ID, shortAvoidOasis);
	rmPlaceObjectDefAtLoc(bush1ID, 0, 0.5, 0.5, 5 * cNonGaiaPlayers);

	int bush2ID = rmCreateObjectDef("bush 2");
	rmAddObjectDefItem(bush2ID, "Bush", 3, 2.0);
	rmAddObjectDefItem(bush2ID, "Rock Sandstone Sprite", 1, 2.0);
	setObjectDefDistanceToMax(bush2ID);
	rmAddObjectDefConstraint(bush2ID, embellishmentAvoidAll);
	rmAddObjectDefConstraint(bush2ID, shortAvoidOasis);
	rmPlaceObjectDefAtLoc(bush2ID, 0, 0.5, 0.5, 5 * cNonGaiaPlayers);

	// Grass.
	int grassID = rmCreateObjectDef("grass");
	rmAddObjectDefItem(grassID, "Grass", 1, 0.0);
	setObjectDefDistanceToMax(grassID);
	rmAddObjectDefConstraint(grassID, embellishmentAvoidAll);
	rmAddObjectDefConstraint(grassID, shortAvoidOasis);
	rmPlaceObjectDefAtLoc(grassID, 0, 0.5, 0.5, 30 * cNonGaiaPlayers);

	// Drifts.
	int driftID = rmCreateObjectDef("drift");
	rmAddObjectDefItem(driftID, "Sand Drift Patch", 1, 0.0);
	setObjectDefDistanceToMax(driftID);
	rmAddObjectDefConstraint(driftID, embellishmentAvoidAll);
	rmAddObjectDefConstraint(driftID, avoidEdge);
	rmAddObjectDefConstraint(driftID, shortAvoidOasis);
	rmAddObjectDefConstraint(driftID, avoidBuildings);
	rmAddObjectDefConstraint(driftID, createTypeDistConstraint("Sand Drift Patch", 25.0));
	rmPlaceObjectDefAtLoc(driftID, 0, 0.5, 0.5, 4 * cNonGaiaPlayers);

	// Birds.
	int birdsID = rmCreateObjectDef("birds");
	rmAddObjectDefItem(birdsID, "Hawk", 1, 0.0);
	setObjectDefDistanceToMax(birdsID);
	rmPlaceObjectDefAtLoc(birdsID, 0, 0.5, 0.5, 2 * cNonGaiaPlayers);

	// Finalize RM X.
	rmxFinalize();

	progress(1.0);
}
