/*
** MIRAGE MIRROR
** RebelsRising
** Last edit: 14/05/2022
*/

include "rmx.xs";

// Override 1v1 forward.
mutable float randFwdInsideSingle(float tol = 0.0) {
	if(randChance()) {
		return(rmRandFloat(0.7 - 0.3 * tol, 1.0 + 0.5 * tol) * PI);
	} else {
		return(rmRandFloat(1.0 - 0.5 * tol, 1.3 + 0.2 * tol) * PI);
	}
}

mutable float randFwdOutsideSingle(float tol = 0.0) {
	if(randChance()) {
		return(rmRandFloat(0.7 - 0.3 * tol, 1.0 + 0.5 * tol) * PI);
	} else {
		return(rmRandFloat(1.0 - 0.5 * tol, 1.3 + 0.2 * tol) * PI);
	}
}

// Overrides 1v1 backward.
mutable float randBackInsideSingle(float tol = 0.0) {
	return(randFromIntervals(0.4, 0.55, 1.45, 1.6) * PI);
}

mutable float randBackOutsideSingle(float tol = 0.0) {
	return(randFromIntervals(0.4, 0.55, 1.45, 1.6) * PI);
}

// Override tg forward outside.
mutable float randFwdOutsideFirst(float tol = 0.0) {
	return(rmRandFloat(1.0 - 0.2 * tol, 1.3 + 0.2 * tol) * PI);
}

mutable float randFwdOutsideLast(float tol = 0.0) {
	return(rmRandFloat(0.7 - 0.2 * tol, 1.0 + 0.2 * tol) * PI);
}

// Overrides tg forward inside.
mutable float randFwdInsideFirst(float tol = 0.0) {
	return(rmRandFloat(0.7 - 0.2 * tol, 1.0 + 0.2 * tol) * PI);
}

mutable float randFwdInsideLast(float tol = 0.0) {
	return(rmRandFloat(1.0 - 0.2 * tol, 1.3 + 0.2 * tol) * PI);
}

// Overrides tg backward outside.
mutable float randBackOutsideFirst(float tol = 0.0) {
	return(rmRandFloat(1.3 - 0.1 * tol, 1.5) * PI);
}

mutable float randBackOutsideLast(float tol = 0.0) {
	return(rmRandFloat(0.5, 0.7 + 0.1 * tol) * PI);
}

// Overrides tg backward inside.
mutable float randBackInsideFirst(float tol = 0.0) {
	return(rmRandFloat(0.45, 0.65 + 0.1 * tol) * PI);
}

mutable float randBackInsideLast(float tol = 0.0) {
	return(rmRandFloat(1.35 - 0.1 * tol, 1.55) * PI);
}

// Overrides tg center forward (remains unchanged).
mutable float randFwdCenter(float tol = 0.0) {
	return(rmRandFloat(0.8 - 0.3 * tol, 1.2 + 0.3 * tol) * PI);
}

// Overrides tg center backward.
mutable float randBackCenter(float tol = 0.0) {
	return(randFromIntervals(-0.5 - tol * 0.5, -0.5, 0.5, 0.5 + tol * 0.5) * PI);
}

void main() {
	progress(0.0);

	// Initial map setup.
	rmxInit("Mirage X");

	// Set mirror mode.
	setMirrorMode(cMirrorPoint);

	// Perform mirror check.
	if(mirrorConfigIsInvalid()) {
		injectMirrorGenError();

		// Invalid configuration, quit.
		return;
	}

	int maxPlayers = getNumberPlayersOnTeam(0);

	for(i = 1; < cTeams) {
		maxPlayers = max(maxPlayers, getNumberPlayersOnTeam(i));
	}

	float dimX = 320.0 + 30.0 * maxPlayers;
	float dimZ = 80.0 + 150.0 * maxPlayers;

	// Initialize map.
	initializeMap("SandA", dimX, dimZ);

	// Player placement.
	if(gameIs1v1()) {
		placePlayersInLine(0.225, 0.5, 0.775, 0.5);
	} else if(cTeams < 3) {
		int teamInt = rmRandInt(0, 1);
		// It's absolutely CRUCIAL to still place players in a counter clock-wise fashion!
		placeTeamInLine(teamInt, 0.225, 1.0 - rmZMetersToFraction(100.0), 0.225, rmZMetersToFraction(100.0));
		placeTeamInLine(1 - teamInt, 0.775, rmZMetersToFraction(100.0), 0.775, 1.0 - rmZMetersToFraction(100.0));
	} else {
		placePlayersInSquare(0.3);
	}

	// Set gaia.
	rmSetGaiaCiv(cCivIsis);

	// Initialize areas.
	float centerRadius = 22.5;

	int classCenter = initializeCenter(centerRadius);
	int classCliff = initCliffClass();

	// Define classes.
	int classStartingSettlement = rmDefineClass("starting settlement");

	// Define global constraints.
	// General.
	int avoidAll = createTypeDistConstraint("All", 7.0);
	int avoidEdge = createSymmetricBoxConstraint(rmXTilesToFraction(4), rmZTilesToFraction(4));
	int avoidCenter = createClassDistConstraint(classCenter, 1.0);

	// Settlements.
	int avoidStartingSettlement = createClassDistConstraint(classStartingSettlement, 20.0);
	int shortAvoidSettlement = createTypeDistConstraint("AbstractSettlement", 15.0);
	int mediumAvoidSettlement = createTypeDistConstraint("AbstractSettlement", 20.0);
	int farAvoidSettlement = createTypeDistConstraint("AbstractSettlement", 25.0);

	// Terrain.
	int shortAvoidImpassableLand = createTerrainDistConstraint("Land", false, 1.0);
	int mediumAvoidImpassableLand = createTerrainDistConstraint("Land", false, 10.0);
	int farAvoidImpassableLand = createTerrainDistConstraint("Land", false, 20.0);
	int avoidCliff = createClassDistConstraint(classCliff, 35.0);

	// Gold.
	int shortAvoidGold = createTypeDistConstraint("Gold", 10.0);
	int farAvoidGold = createTypeDistConstraint("Gold", 40.0);

	// Food.
	int avoidHuntable = createTypeDistConstraint("Huntable",  40.0);
	int avoidHerdable = createTypeDistConstraint("Herdable", 30.0);
	int avoidFood = createTypeDistConstraint("Food", 20.0);
	int avoidPredator = createTypeDistConstraint("AnimalPredator", 40.0);

	// Relics.
	int avoidRelic = createTypeDistConstraint("Relic", 70.0);

	// Buildings.
	int avoidBuildings = createTypeDistConstraint("Building", 25.0);
	int avoidTowerLOS = createTypeDistConstraint("Tower", 35.0);
	int shortAvoidTower = createTypeDistConstraint("Tower", 15.0);
	int farAvoidTower = createTypeDistConstraint("Tower", 25.0);

	// Embellishment.
	int embellishmentAvoidAll = createTypeDistConstraint("All", 3.0);

	// Define simple objects.
	// Starting settlement.
	int startingSettlementID = createObjectDefVerify("starting settlement");
	addObjectDefItemVerify(startingSettlementID, "Settlement Level 1", 1, 0.0);
	rmAddObjectDefToClass(startingSettlementID, classStartingSettlement);

	// Towers.
	int startingTowerID = rmCreateObjectDef("starting tower");
	rmAddObjectDefItem(startingTowerID, "Tower", 1, 0.0);
	rmAddObjectDefConstraint(startingTowerID, avoidAll);
	rmAddObjectDefConstraint(startingTowerID, farAvoidTower);
	rmAddObjectDefConstraint(startingTowerID, mediumAvoidImpassableLand);

	int startingTowerBackupID = rmCreateObjectDef("starting tower backup");
	rmAddObjectDefItem(startingTowerBackupID, "Tower", 1, 0.0);
	rmAddObjectDefConstraint(startingTowerBackupID, avoidAll);
	rmAddObjectDefConstraint(startingTowerBackupID, shortAvoidTower);
	rmAddObjectDefConstraint(startingTowerBackupID, mediumAvoidImpassableLand);

	// Starting hunt.
	int startingHuntID = createObjectDefVerify("starting hunt");
	addObjectDefItemVerify(startingHuntID, "Boar", 1, 0.0);
	rmAddObjectDefConstraint(startingHuntID, avoidAll);
	rmAddObjectDefConstraint(startingHuntID, avoidEdge);

	// Starting food.
	int startingFoodID = createObjectDefVerify("starting food");
	if(randChance()) {
		addObjectDefItemVerify(startingFoodID, "Chicken", rmRandInt(5, 6), 2.0);
	} else {
		addObjectDefItemVerify(startingFoodID, "Berry Bush", rmRandInt(5, 6), 2.0);
	}
	rmAddObjectDefConstraint(startingFoodID, avoidAll);
	rmAddObjectDefConstraint(startingFoodID, avoidEdge);
	rmAddObjectDefConstraint(startingFoodID, mediumAvoidImpassableLand);
	rmAddObjectDefConstraint(startingFoodID, avoidFood);

	// Starting herdables.
	int startingHerdablesID = createObjectDefVerify("starting herdables");
	addObjectDefItemVerify(startingHerdablesID, "Cow", rmRandInt(1, 3), 2.0);
	rmAddObjectDefConstraint(startingHerdablesID, avoidAll);
	rmAddObjectDefConstraint(startingHerdablesID, avoidEdge);
	rmAddObjectDefConstraint(startingHerdablesID, shortAvoidImpassableLand);

	// Straggler trees.
	int stragglerTreeID = createObjectDefVerify("straggler tree");
	addObjectDefItemVerify(stragglerTreeID, "Palm", 1, 0.0);
	rmAddObjectDefConstraint(stragglerTreeID, avoidAll);

	// Gold.
	int mediumGoldID = createObjectDefVerify("medium gold");
	addObjectDefItemVerify(mediumGoldID, "Gold Mine", 1, 0.0);
	rmAddObjectDefConstraint(mediumGoldID, avoidAll);
	rmAddObjectDefConstraint(mediumGoldID, avoidEdge);
	rmAddObjectDefConstraint(mediumGoldID, avoidCenter);
	rmAddObjectDefConstraint(mediumGoldID, farAvoidSettlement);
	rmAddObjectDefConstraint(mediumGoldID, farAvoidImpassableLand);
	rmAddObjectDefConstraint(mediumGoldID, createClassDistConstraint(classStartingSettlement, 40.0));
	rmAddObjectDefConstraint(mediumGoldID, farAvoidGold);
	rmAddObjectDefConstraint(mediumGoldID, avoidTowerLOS);

	// Bonus gold (anywhere in team area).
	int bonusGoldID = createObjectDefVerify("bonus gold", cNonGaiaPlayers < 5);
	addObjectDefItemVerify(bonusGoldID, "Gold Mine", 1, 0.0);
	rmAddObjectDefConstraint(bonusGoldID, avoidAll);
	rmAddObjectDefConstraint(bonusGoldID, avoidEdge);
	rmAddObjectDefConstraint(bonusGoldID, avoidCenter);
	rmAddObjectDefConstraint(bonusGoldID, farAvoidSettlement);
	rmAddObjectDefConstraint(bonusGoldID, farAvoidImpassableLand);
	rmAddObjectDefConstraint(bonusGoldID, createClassDistConstraint(classStartingSettlement, 70.0));
	rmAddObjectDefConstraint(bonusGoldID, avoidTowerLOS);
	rmAddObjectDefConstraint(bonusGoldID, farAvoidGold);

	// Hunt.
	// Medium hunt.
	int mediumHuntID = createObjectDefVerify("medium hunt", cNonGaiaPlayers < 5);
	addObjectDefItemVerify(mediumHuntID, "Gazelle", rmRandInt(6, 9), 2.0);
	rmAddObjectDefConstraint(mediumHuntID, avoidAll);
	rmAddObjectDefConstraint(mediumHuntID, avoidEdge);
	rmAddObjectDefConstraint(mediumHuntID, avoidCenter);
	rmAddObjectDefConstraint(mediumHuntID, mediumAvoidSettlement);
	rmAddObjectDefConstraint(mediumHuntID, mediumAvoidImpassableLand);
	rmAddObjectDefConstraint(mediumHuntID, avoidTowerLOS);
	rmAddObjectDefConstraint(mediumHuntID, shortAvoidGold);
	rmAddObjectDefConstraint(mediumHuntID, avoidHuntable);

	// Far monkeys.
	int farMonkeysID = createObjectDefVerify("far monkeys");
	if(randChance()) {
		addObjectDefItemVerify(farMonkeysID, "Monkey", rmRandInt(5, 8), 2.0);
	} else {
		addObjectDefItemVerify(farMonkeysID, "Baboon", rmRandInt(5, 8), 2.0);
	}
	rmAddObjectDefConstraint(farMonkeysID, avoidAll);
	rmAddObjectDefConstraint(farMonkeysID, avoidEdge);
	rmAddObjectDefConstraint(farMonkeysID, avoidCenter);
	rmAddObjectDefConstraint(farMonkeysID, shortAvoidSettlement);
	rmAddObjectDefConstraint(farMonkeysID, createClassDistConstraint(classStartingSettlement, 70.0));
	rmAddObjectDefConstraint(farMonkeysID, mediumAvoidImpassableLand);
	rmAddObjectDefConstraint(farMonkeysID, shortAvoidGold);
	rmAddObjectDefConstraint(farMonkeysID, avoidFood);
	rmAddObjectDefConstraint(farMonkeysID, avoidHuntable);

	// Far berries.
	int farBerriesID = createObjectDefVerify("far berries");
	addObjectDefItemVerify(farBerriesID, "Berry Bush", rmRandInt(5, 8), 2.0);
	rmAddObjectDefConstraint(farBerriesID, avoidAll);
	rmAddObjectDefConstraint(farBerriesID, avoidEdge);
	rmAddObjectDefConstraint(farBerriesID, avoidCenter);
	rmAddObjectDefConstraint(farBerriesID, shortAvoidSettlement);
	rmAddObjectDefConstraint(farBerriesID, createClassDistConstraint(classStartingSettlement, 70.0));
	rmAddObjectDefConstraint(farBerriesID, mediumAvoidImpassableLand);
	rmAddObjectDefConstraint(farBerriesID, shortAvoidGold);
	rmAddObjectDefConstraint(farBerriesID, avoidFood);

	// Medium herdables.
	int mediumHerdablesID = createObjectDefVerify("medium herdables");
	addObjectDefItemVerify(mediumHerdablesID, "Cow", rmRandInt(2, 3), 4.0);
	rmAddObjectDefConstraint(mediumHerdablesID, avoidAll);
	rmAddObjectDefConstraint(mediumHerdablesID, avoidEdge);
	rmAddObjectDefConstraint(mediumHerdablesID, avoidCenter);
	rmAddObjectDefConstraint(mediumHerdablesID, createClassDistConstraint(classStartingSettlement, 55.0));
	rmAddObjectDefConstraint(mediumHerdablesID, avoidHerdable);
	rmAddObjectDefConstraint(mediumHerdablesID, avoidTowerLOS);
	rmAddObjectDefConstraint(mediumHerdablesID, mediumAvoidImpassableLand);

	// Far herdables.
	int farHerdablesID = createObjectDefVerify("far herdables");
	addObjectDefItemVerify(farHerdablesID, "Cow", rmRandInt(1, 2), 4.0);
	rmAddObjectDefConstraint(farHerdablesID, avoidAll);
	rmAddObjectDefConstraint(farHerdablesID, avoidEdge);
	rmAddObjectDefConstraint(farHerdablesID, avoidCenter);
	rmAddObjectDefConstraint(farHerdablesID, createClassDistConstraint(classStartingSettlement, 70.0));
	rmAddObjectDefConstraint(farHerdablesID, avoidHerdable);
	rmAddObjectDefConstraint(farHerdablesID, mediumAvoidImpassableLand);

	// Far predators.
	int farPredatorsID = createObjectDefVerify("far predators");
	if(randChance()) {
		addObjectDefItemVerify(farPredatorsID, "Lion", 2, 4.0);
	} else {
		addObjectDefItemVerify(farPredatorsID, "Hyena", 2, 4.0);
	}
	rmAddObjectDefConstraint(farPredatorsID, avoidAll);
	rmAddObjectDefConstraint(farPredatorsID, avoidEdge);
	rmAddObjectDefConstraint(farPredatorsID, avoidCenter);
	rmAddObjectDefConstraint(farPredatorsID, createClassDistConstraint(classStartingSettlement, 80.0));
	rmAddObjectDefConstraint(farPredatorsID, mediumAvoidSettlement);
	rmAddObjectDefConstraint(farPredatorsID, mediumAvoidImpassableLand);
	rmAddObjectDefConstraint(farPredatorsID, avoidPredator);

	// Other objects.
	// Random trees.
	int randomTreeID = createObjectDefVerify("random tree");
	addObjectDefItemVerify(randomTreeID, "Palm", 1, 0.0);
	setObjectDefDistanceToMax(randomTreeID);
	rmAddObjectDefConstraint(randomTreeID, avoidAll);
	rmAddObjectDefConstraint(randomTreeID, shortAvoidImpassableLand);
	rmAddObjectDefConstraint(randomTreeID, avoidCliff);
	rmAddObjectDefConstraint(randomTreeID, mediumAvoidSettlement);
	
	// Relics.
	int relicID = createObjectDefVerify("relic");
	addObjectDefItemVerify(relicID, "Relic", 1, 0.0);
	rmAddObjectDefConstraint(relicID, avoidAll);
	rmAddObjectDefConstraint(relicID, avoidEdge);
	rmAddObjectDefConstraint(relicID, createClassDistConstraint(classStartingSettlement, 70.0));
	rmAddObjectDefConstraint(relicID, mediumAvoidImpassableLand);
	rmAddObjectDefConstraint(relicID, avoidRelic);

	progress(0.1);

	// Oceans.
	for(i = 0; < 2) {
		int oceanID = rmCreateArea("ocean " + i);
		rmSetAreaWaterType(oceanID, "Egyptian Nile");
		rmSetAreaHeightBlend(oceanID, 1);
		rmSetAreaCoherence(oceanID, 0.9);
		rmSetAreaSmoothDistance(oceanID, 1);
		rmSetAreaWarnFailure(oceanID, false);

		if(gameIs1v1()) {
			rmSetAreaSize(oceanID, rmXMetersToFraction(30.0));
		} else {
			rmSetAreaSize(oceanID, rmXMetersToFraction(45.0));
		}

		if(i == 0) {
			rmSetAreaLocation(oceanID, 0.01, 0.5);

			if(gameIs1v1()) {
				rmAddAreaInfluenceSegment(oceanID, 0.0, 0.275, 0.0, 0.725);
			} else {
				rmAddAreaInfluenceSegment(oceanID, 0.0, 0.0, 0.0, 1.0);
			}
		} else if(i == 1) {
			rmSetAreaLocation(oceanID, 0.99, 0.5);

			if(gameIs1v1()) {
				rmAddAreaInfluenceSegment(oceanID, 1.0, 0.275, 1.0, 0.725);
			} else {
				rmAddAreaInfluenceSegment(oceanID, 1.0, 0.0, 1.0, 1.0);
			}
		}
	}

	rmBuildAllAreas();

	// Set up player areas.
	for(i = 1; < cPlayers) {
		int playerAreaID = rmCreateArea("player area " + getPlayer(i));
		rmSetAreaSize(playerAreaID, rmAreaTilesToFraction(1200));
		rmSetAreaLocPlayer(playerAreaID, getPlayer(i));
		rmSetAreaTerrainType(playerAreaID, "SandA");
		rmSetAreaBaseHeight(playerAreaID, 2.0);
		rmSetAreaHeightBlend(playerAreaID, 2);
		rmSetAreaCoherence(playerAreaID, 1.0);
		rmSetAreaWarnFailure(playerAreaID, false);
		rmBuildArea(playerAreaID);
	}

	progress(0.2);

	// Beautification.
	int beautificationID = 0;

	for(i = 0; < 100 * cNonGaiaPlayers) {
		beautificationID = rmCreateArea("beautification " + i);
		rmSetAreaTerrainType(beautificationID, "SandD");
		rmSetAreaSize(beautificationID, rmAreaTilesToFraction(20), rmAreaTilesToFraction(60));
		rmSetAreaMinBlobs(beautificationID, 1);
		rmSetAreaMaxBlobs(beautificationID, 5);
		rmSetAreaMinBlobDistance(beautificationID, 16.0);
		rmSetAreaMaxBlobDistance(beautificationID, 40.0);
		rmAddAreaConstraint(beautificationID, mediumAvoidImpassableLand);
		rmSetAreaWarnFailure(beautificationID, false);
		rmBuildArea(beautificationID);
	}

	progress(0.3);

	// Starting settlement.
	placeObjectAtPlayerLocs(startingSettlementID, true);

	// Towers.
	placeAndStoreObjectMirrored(startingTowerID, true, 4, 23.0, 27.0, true, -1, startingTowerBackupID);

	float tcDist = 65.0;
	int settlementAvoidCenter = createClassDistConstraint(classCenter, 10.0 + 0.5 * (tcDist - 2.0 * centerRadius));

	// Close settlement.
	int settlementID = rmCreateObjectDef("settlements");
	rmAddObjectDefItem(settlementID, "Settlement", 1, 0.0);

	addFairLocConstraint(settlementAvoidCenter);

	if(gameIs1v1()) {
		addFairLocConstraint(mediumAvoidImpassableLand);
		enableFairLocTwoPlayerCheck(0.1);

		addFairLoc(75.0, 85.0, false, randChance(), 60.0, 12.0, 12.0);
	} else {
		addFairLocConstraint(avoidTowerLOS);
		addFairLocConstraint(createTerrainDistConstraint("Land", false, rmRandFloat(10.0, 20.0)));

		addFairLoc(60.0, 80.0, false, randChance(), 60.0, 12.0, 12.0, false, false, false, false);
	}

	// Far settlement.
	addFairLocConstraint(settlementAvoidCenter);
	addFairLocConstraint(mediumAvoidImpassableLand);
	addFairLocConstraint(avoidTowerLOS);

	enableFairLocTwoPlayerCheck();

	if(gameIs1v1()) {
		addFairLoc(70.0, 90.0, true, randChance(), 80.0, 12.0, 12.0);
	} else {
		addFairLoc(70.0, 90.0, true, randChance(), 70.0, 12.0, 12.0);
	}

	setFairLocInterDistMin(70.0);

	placeObjectAtNewFairLocs(settlementID);

	progress(0.4);

	// Forests.
	int classForest = initForestClass();

	addForestConstraint(avoidCenter);
	addForestConstraint(avoidStartingSettlement);
	addForestConstraint(avoidAll);

	addForestType("Savannah Forest", 1.0);

	setForestAvoidSelf(25.0);

	setForestBlobs(8, 15);
	setForestBlobParams(4.5, 4.25);
	setForestCoherence(-0.75, 0.75);

	// Player forests.
	setForestSearchRadius(30.0, 40.0);
	setForestMinRatio(2.0 / 3.0);

	int numPlayerForests = 2;

	buildPlayerForests(numPlayerForests, 0.1);

	progress(0.5);

	int avoidForest = createClassDistConstraint(classForest, 15.0);

	// Cliffs.
	setOuterCliff("CliffEgyptianA", 9.0, 6.0);
	setOuterCliffParams(1.5);

	setInnerCliff("SandA", 9.0, 7.0);
	setInnerCliffParams(0.0);

	setCliffRamp("SandA", 10.0, 9.0);
	setCliffRampParams(0.0);
	setCliffNumRamps(2, 3);

	setCliffBlobs(4);
	setCliffAvoidSelf(40.0);
	setCliffRequiredRatio(1.0);
	setCliffCoherence(-1.0, 0.0);
	setCliffSearchRadius(40.0, -1.0);

	addCliffConstraint(avoidForest);
	addCliffConstraint(avoidEdge);
	addCliffConstraint(avoidCenter);
	addCliffConstraint(farAvoidImpassableLand);
	addCliffConstraint(avoidCliff);
	addCliffConstraint(avoidBuildings);
	addCliffConstraint(avoidTowerLOS);

	int numCliffs = cNonGaiaPlayers; // 2 per player (mirrored, so 1 counts as 2).

	buildCliffs(numCliffs, 0.1);

	progress(0.6);

	// Normal forests.
	addForestConstraint(mediumAvoidImpassableLand); // Additional constraint.

	setForestSearchRadius(20.0, -1.0);

	int numForests = 12 * cNonGaiaPlayers / 2;

	buildForests(numForests, 0.2);

	progress(0.8);

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
	placeFarObjectMirrored(bonusGoldID, false, rmRandInt(1, 2));

	// Medium hunt.
	placeObjectMirrored(mediumHuntID, false, 1, 50.0, 70.0);

	// Starting hunt.
	placeObjectMirrored(startingHuntID, false, 1, 20.0, 25.0, true);

	// Starting food.
	placeObjectMirrored(startingFoodID, false, 1, 21.0, 27.0, true);

	// Straggler trees.
	placeObjectMirrored(stragglerTreeID, false, rmRandInt(2, 5), 13.0, 13.5, true);

	// Monkeys.
	placeFarObjectMirrored(farMonkeysID);

	// Berries.
	placeFarObjectMirrored(farBerriesID);

	// Medium herdables.
	placeObjectMirrored(mediumHerdablesID, false, 1, 50.0, 70.0);

	// Far herdables.
	placeFarObjectMirrored(farHerdablesID);

	// Starting herdables.
	placeObjectMirrored(startingHerdablesID, true, 1, 20.0, 30.0);

	// Predators.
	placeFarObjectMirrored(farPredatorsID);

	// Small center forest.
	int centerForestID = rmCreateArea("center forest");
	rmSetAreaForestType(centerForestID, "Savannah Forest");
	rmSetAreaSize(centerForestID, areaRadiusMetersToFraction(3.0));
	rmSetAreaLocation(centerForestID, 0.5, 0.5);
	rmSetAreaCoherence(centerForestID, 1.0);
	rmBuildArea(centerForestID);

	// Relics (non-mirrored).
	placeObjectInPlayerSplits(relicID);

	// Random trees.
	placeObjectAtPlayerLocs(randomTreeID, false, 10);

	// Define fish.
	int fish1ID = rmCreateObjectDef("close fish 1");
	rmAddObjectDefItem(fish1ID, "Fish - Mahi", rmRandInt(2, 3), 5.0);

	int fish2ID = rmCreateObjectDef("close fish 2");
	rmAddObjectDefItem(fish2ID, "Fish - Mahi", rmRandInt(2, 3), 5.0);

	// Place fish.
	if(cTeams < 3) {

		int numFish = 3;

		float fishDist = randRadiusFromInterval(54.5 + 6.5 * maxPlayers);

		for(i = 1; < cPlayers) {
			float playerAngle = getPlayerAngle(i);
			float teamOffset = getPlayerTeamOffsetAngle(i);

			// Calculate center point for first fish.
			float fX = getXFromPolarForPlayer(i, fishDist, teamOffset);
			float fZ = getZFromPolarForPlayer(i, fishDist, teamOffset);

			for(j = 0; < numFish) {
				float fishHalfWidth = rmZMetersToFraction(27.5);

				if(j % 2 == 1) {
					rmPlaceObjectDefAtLoc(fish1ID, 0, fX, fZ - fishHalfWidth + (2.0 * fishHalfWidth) * j / (numFish - 1));
				} else {
					rmPlaceObjectDefAtLoc(fish2ID, 0, fX, fZ - fishHalfWidth + (2.0 * fishHalfWidth) * j / (numFish - 1));
				}
			}
		}

	} else {

		// > 2 teams.
		rmSetObjectDefMinDistance(fish1ID, 0.0);
		rmSetObjectDefMaxDistance(fish1ID, rmZFractionToMeters(1.0));

		int fishLandMin = createTerrainDistConstraint("Land", true, 10.0);
		int avoidFish = createTypeDistConstraint("Fish", 18.0);

		rmAddObjectDefConstraint(fish1ID, fishLandMin);
		rmAddObjectDefConstraint(fish1ID, avoidFish);
		rmAddObjectDefConstraint(fish1ID, avoidAll);

		rmPlaceObjectDefAtLoc(fish1ID, 0, 0.5, 0.5, 5 * cNonGaiaPlayers);

	}

	progress(0.9);

	// Embellishment.
	// Bushes.
	int bush1ID = rmCreateObjectDef("bush 1");
	rmAddObjectDefItem(bush1ID, "Bush", 4, 4.0);
	setObjectDefDistanceToMax(bush1ID);
	rmAddObjectDefConstraint(bush1ID, embellishmentAvoidAll);
	rmAddObjectDefConstraint(bush1ID, mediumAvoidImpassableLand);
	rmPlaceObjectDefAtLoc(bush1ID, 0, 0.5, 0.5, 10 * cNonGaiaPlayers);

	int bush2ID = rmCreateObjectDef("bush 2");
	rmAddObjectDefItem(bush2ID, "Bush", 3, 2.0);
	rmAddObjectDefItem(bush2ID, "Rock Sandstone Sprite", 1, 2.0);
	setObjectDefDistanceToMax(bush2ID);
	rmAddObjectDefConstraint(bush2ID, embellishmentAvoidAll);
	rmAddObjectDefConstraint(bush2ID, mediumAvoidImpassableLand);
	rmPlaceObjectDefAtLoc(bush2ID, 0, 0.5, 0.5, 5 * cNonGaiaPlayers);

	// Rocks.
	int rockID = rmCreateObjectDef("rock sprite");
	rmAddObjectDefItem(rockID, "Rock Sandstone Sprite", 1, 0.0);
	setObjectDefDistanceToMax(rockID);
	rmAddObjectDefConstraint(rockID, embellishmentAvoidAll);
	rmAddObjectDefConstraint(rockID, mediumAvoidImpassableLand);
	rmPlaceObjectDefAtLoc(rockID, 0, 0.5, 0.5, 10 * cNonGaiaPlayers);

	// Drifts.
	int driftID = rmCreateObjectDef("drift");
	rmAddObjectDefItem(driftID, "Sand Drift Patch", 1, 0.0);
	setObjectDefDistanceToMax(driftID);
	rmAddObjectDefConstraint(driftID, embellishmentAvoidAll);
	rmAddObjectDefConstraint(driftID, avoidEdge);
	rmAddObjectDefConstraint(driftID, mediumAvoidImpassableLand);
	rmAddObjectDefConstraint(driftID, avoidBuildings);
	rmAddObjectDefConstraint(driftID, createTypeDistConstraint("Sand Drift Patch", 25.0));
	rmPlaceObjectDefAtLoc(driftID, 0, 0.5, 0.5, 5 * cNonGaiaPlayers);

	// Shore decoration.
	int riverBushID = rmCreateObjectDef("river bush");
	rmAddObjectDefItem(riverBushID, "Grass", rmRandInt(3, 4), 6.0);
	rmAddObjectDefItem(riverBushID, "Bush", rmRandInt(1, 4), 6.0);
	setObjectDefDistanceToMax(riverBushID);
	rmAddObjectDefConstraint(riverBushID, embellishmentAvoidAll);
	rmAddObjectDefConstraint(riverBushID, shortAvoidImpassableLand);
	rmAddObjectDefConstraint(riverBushID, createTerrainMaxDistConstraint("Water", true, 10.0));
	rmPlaceObjectDefAtLoc(riverBushID, 0, 0.5, 0.5, 15 * cNonGaiaPlayers);

	// Seaweed.
	int seaweedShoreMin = createTerrainDistConstraint("Land", true, 16.0);
	int seaweedShoreMax = createTerrainMaxDistConstraint("Land", true, 30.0);

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
	rmPlaceObjectDefAtLoc(seaweed2ID, 0, 0.5, 0.5, 10 * cNonGaiaPlayers);

	// Water.
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
