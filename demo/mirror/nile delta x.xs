/*
** NILE DELTA MIRROR
** RebelsRising
** Last edit: 14/05/2022
*/

include "rmx.xs";

/*
** Creates and builds areas under the last mirrored objects placed.
**
** @param player: the player the object was placed for
*/
void placeAreaUnderObj(int player = -1) {
	static int areaCount = 0;

	float areaSize = rmXMetersToFraction(1.0);

	float goldX = getLastObjX(player);
	float goldZ = getLastObjZ(player);

	int sandAreaID = rmCreateArea("gold area " + areaCount);
	rmSetAreaLocation(sandAreaID, goldX, goldZ);
	rmSetAreaSize(sandAreaID, areaSize);
	rmSetAreaCoherence(sandAreaID, 1.0);
	rmSetAreaBaseHeight(sandAreaID, 4.0);
	rmSetAreaHeightBlend(sandAreaID, 2);
	// rmSetAreaTerrainType(sandAreaID, "SandA");
	rmBuildArea(sandAreaID);

	sandAreaID = rmCreateArea("gold area mirrored " + areaCount);
	rmSetAreaLocation(sandAreaID, 1.0 - goldX, goldZ);
	rmSetAreaSize(sandAreaID, areaSize);
	rmSetAreaCoherence(sandAreaID, 1.0);
	rmSetAreaBaseHeight(sandAreaID, 4.0);
	rmSetAreaHeightBlend(sandAreaID, 2);
	// rmSetAreaTerrainType(sandAreaID, "SandA");
	rmBuildArea(sandAreaID);

	areaCount++;
}

void main() {
	progress(0.0);

	// Initial map setup.
	rmxInit("Nile Delta X");

	// Set mirror mode.
	setMirrorMode(cMirrorAxisZ);

	// Perform mirror check.
	if(mirrorConfigIsInvalid()) {
		injectMirrorGenError();

		// Invalid configuration, quit.
		return;
	}

	// Adjust angle for line spawn.
	setFarObjectAngleSlice(1.0 * PI, false);

	// Set size.
	int axisLength = getStandardMapDimInMeters(8000);

	// Initialize water.
	rmSetSeaLevel(3.0);
	rmSetSeaType("Egyptian Nile");

	// Initialize map.
	float xFac = 1.0;
	float zFac = 1.0;

	if(cNonGaiaPlayers > 5) {
		xFac = 0.85;
	}

	initializeMap("Water", xFac * axisLength, zFac * axisLength);

	// Needed for fish angle adjustment.
	int teamInt = rmRandInt(0, 1);
	float placementEdgeDist = rmXMetersToFraction(40.0);

	// Place players.
	if(cNonGaiaPlayers == 2) {
		placePlayersInLine(placementEdgeDist, 0.675, 1.0 - placementEdgeDist, 0.675);
	} else {
		placementEdgeDist = rmXMetersToFraction(60.0);

		// It's absolutely CRUCIAL to still place players in a counter clock-wise fashion!
		placeTeamInLine(teamInt, placementEdgeDist, 0.8, placementEdgeDist, 0.15);
		placeTeamInLine(1 - teamInt, 1.0 - placementEdgeDist, 0.15, 1.0 - placementEdgeDist, 0.8);
	}

	// Initialize areas.
	int classSplit = initializeTeamSplit(5.0);
	int classCenterline = initializeCenterline(false);

	// Define classes.
	int classStartingSettlement = rmDefineClass("starting settlement");
	int classShallows = rmDefineClass("shallows");
	int classWater = rmDefineClass("water");
	int classShore = rmDefineClass("shore");

	// General.
	int avoidAll = createTypeDistConstraint("All", 7.0);
	int avoidEdge = createSymmetricBoxConstraint(rmXTilesToFraction(4), rmZTilesToFraction(4));
	int avoidCenterline = createClassDistConstraint(classCenterline, 1.0);
	int shortAvoidCenter = createClassDistConstraint(classCenterline, 7.5);
	int mediumAvoidCenter = createClassDistConstraint(classCenterline, 12.5);
	int farAvoidCenter = createClassDistConstraint(classCenterline, 20.0);

	// Terrain.
	int hugeShallowBox = createBoxConstraint(0.0, 0.0, 1.0, 0.475);
	if(cNonGaiaPlayers > 3) {
		hugeShallowBox = createBoxConstraint(0.0, 0.0, 1.0, 0.525);
	}
	int shallowConstraint = createClassDistConstraint(classShallows, 0.1);
	int shoreShallow = createBoxConstraint(0.45, 0.0, 0.55, 1.0);
	int shortAvoidWater = createClassDistConstraint(classWater, 1.0);
	int mediumAvoidWater = createClassDistConstraint(classWater, 5.0);
	int farAvoidWater = createClassDistConstraint(classWater, 10.0);
	int veryFarAvoidWater = createClassDistConstraint(classWater, 15.0);
	int shoreConstraint = createClassDistConstraint(classShore, 20.0);

	// Settlements.
	int avoidStartingSettlement = createClassDistConstraint(classStartingSettlement, 20.0);
	int avoidSettlement = createTypeDistConstraint("AbstractSettlement", 15.0);

	// Gold.
	int shortAvoidGold = createTypeDistConstraint("Gold", 10.0);
	int farAvoidGold = createTypeDistConstraint("Gold", 35.0);
	int goldStayInBox = createBoxConstraint(0.0, 0.0, 1.0, 0.5);

	// Food.
	int avoidFood = createTypeDistConstraint("Food", 20.0);
	int avoidHuntable = createTypeDistConstraint("Huntable", 40.0);
	int avoidHerdable = createTypeDistConstraint("Herdable", 30.0);
	int avoidPredator = createTypeDistConstraint("AnimalPredator", 30.0);

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
	// Starting settlements.
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
	if(randChance(0.1)) {
		// 10% chance for 4.
		rmAddObjectDefItem(closeHuntID, "Gazelle", 4, 3.0);
	} else {
		// 45% chance each for 5 and 6.
		rmAddObjectDefItem(closeHuntID, "Gazelle", rmRandInt(5, 6), 2.0);
	}
	rmAddObjectDefConstraint(closeHuntID, avoidAll);
	rmAddObjectDefConstraint(closeHuntID, avoidEdge);
	rmAddObjectDefConstraint(closeHuntID, shortAvoidGold);
	rmAddObjectDefConstraint(closeHuntID, avoidFood);

	// Starting food.
	int startingFoodID = rmCreateObjectDef("starting food");
	rmAddObjectDefItem(startingFoodID, "Berry Bush", rmRandInt(5, 7), 2.0);
	rmAddObjectDefConstraint(startingFoodID, avoidAll);
	rmAddObjectDefConstraint(startingFoodID, avoidEdge);
	rmAddObjectDefConstraint(startingFoodID, shortAvoidGold);
	rmAddObjectDefConstraint(startingFoodID, avoidFood);

	// Starting herdables.
	int startingHerdablesID = rmCreateObjectDef("starting herdables");
	if(randChance(0.1)) {
		// 10% chance for 5.
		rmAddObjectDefItem(startingHerdablesID, "Goat", 5, 2.0);
	} else {
		// 45% chance each for 3 and 4.
		rmAddObjectDefItem(startingHerdablesID, "Goat", rmRandInt(3, 4), 2.0);
	}
	rmAddObjectDefConstraint(startingHerdablesID, avoidAll);
	rmAddObjectDefConstraint(startingHerdablesID, avoidEdge);

	// Straggler trees.
	int stragglerTreeID = rmCreateObjectDef("straggler tree");
	rmAddObjectDefItem(stragglerTreeID, "Palm", 1, 0.0);
	rmAddObjectDefConstraint(stragglerTreeID, avoidAll);

	// Gold.
	// Medium gold.
	int mediumGoldID = rmCreateObjectDef("medium gold");
	rmAddObjectDefItem(mediumGoldID, "Gold Mine", 1, 0.0);
	if(cNonGaiaPlayers == 2) {
		rmAddObjectDefConstraint(mediumGoldID, goldStayInBox);
	}
	rmAddObjectDefConstraint(mediumGoldID, avoidAll);
	rmAddObjectDefConstraint(mediumGoldID, avoidEdge);
	rmAddObjectDefConstraint(mediumGoldID, mediumAvoidCenter);
	rmAddObjectDefConstraint(mediumGoldID, createClassDistConstraint(classStartingSettlement, 50.0));
	rmAddObjectDefConstraint(mediumGoldID, avoidSettlement);
	rmAddObjectDefConstraint(mediumGoldID, farAvoidGold);
	rmAddObjectDefConstraint(mediumGoldID, veryFarAvoidWater);
	rmAddObjectDefConstraint(mediumGoldID, avoidTowerLOS);

	// Bonus gold.
	int bonusGoldID = rmCreateObjectDef("bonus gold");
	rmAddObjectDefItem(bonusGoldID, "Gold Mine", 1, 0.0);
	if(cNonGaiaPlayers == 2) {
		rmAddObjectDefConstraint(bonusGoldID, goldStayInBox);
	}
	rmAddObjectDefConstraint(bonusGoldID, avoidAll);
	rmAddObjectDefConstraint(bonusGoldID, avoidEdge);
	rmAddObjectDefConstraint(bonusGoldID, farAvoidCenter);
	rmAddObjectDefConstraint(bonusGoldID, createClassDistConstraint(classStartingSettlement, 60.0));
	rmAddObjectDefConstraint(bonusGoldID, avoidSettlement);
	rmAddObjectDefConstraint(bonusGoldID, farAvoidGold);
	rmAddObjectDefConstraint(bonusGoldID, veryFarAvoidWater);
	rmAddObjectDefConstraint(bonusGoldID, avoidTowerLOS);

	// Hunt and berries.
	// Medium hunt 1.
	int mediumHunt1ID = rmCreateObjectDef("medium hunt 1");
	if(randChance(0.75)) {
		// 1 group.
		if(randChance(0.25)) {
			rmAddObjectDefItem(mediumHunt1ID, "Giraffe", rmRandInt(3, 9), 2.0);
		} else {
			if(randChance(0.5)) {
				rmAddObjectDefItem(mediumHunt1ID, "Gazelle", rmRandInt(3, 9), 2.0);
			} else {
				rmAddObjectDefItem(mediumHunt1ID, "Zebra", rmRandInt(3, 9), 2.0);
			}
		}
	} else {
		// 2 groups.
		if(randChance(0.25)) {
			rmAddObjectDefItem(mediumHunt1ID, "Giraffe", rmRandInt(0, 4), 4.0);
			rmAddObjectDefItem(mediumHunt1ID, "Gazelle", rmRandInt(2, 6), 4.0);
		} else {
			if(randChance(0.25)) {
				rmAddObjectDefItem(mediumHunt1ID, "Zebra", rmRandInt(2, 6), 4.0);
				rmAddObjectDefItem(mediumHunt1ID, "Gazelle", rmRandInt(2, 6), 4.0);
			} else {
				rmAddObjectDefItem(mediumHunt1ID, "Zebra", rmRandInt(2, 6), 4.0);
				rmAddObjectDefItem(mediumHunt1ID, "Giraffe", rmRandInt(0, 4), 4.0);
			}
		}
	}
	rmAddObjectDefConstraint(mediumHunt1ID, avoidAll);
	rmAddObjectDefConstraint(mediumHunt1ID, avoidEdge);
	rmAddObjectDefConstraint(mediumHunt1ID, farAvoidCenter);
	rmAddObjectDefConstraint(mediumHunt1ID, createClassDistConstraint(classStartingSettlement, 50.0));
	rmAddObjectDefConstraint(mediumHunt1ID, avoidHuntable);
	rmAddObjectDefConstraint(mediumHunt1ID, farAvoidWater);

	// Medium hunt 2.
	int mediumHunt2ID = rmCreateObjectDef("medium hunt 2");
	if(randChance(0.75)) {
		// 1 group.
		if(randChance(0.25)) {
			rmAddObjectDefItem(mediumHunt2ID, "Giraffe", rmRandInt(3, 9), 2.0);
		} else {
			if(randChance(0.5)) {
				rmAddObjectDefItem(mediumHunt2ID, "Gazelle", rmRandInt(3, 9), 2.0);
			} else {
				rmAddObjectDefItem(mediumHunt2ID, "Zebra", rmRandInt(3, 9), 2.0);
			}
		}
	} else {
		// 2 groups.
		if(randChance(0.25)) {
			rmAddObjectDefItem(mediumHunt2ID, "Giraffe", rmRandInt(1, 4), 2.0);
			rmAddObjectDefItem(mediumHunt2ID, "Gazelle", rmRandInt(2, 5), 2.0);
		} else {
			if(randChance(0.25)) {
				rmAddObjectDefItem(mediumHunt2ID, "Zebra", rmRandInt(2, 5), 4.0);
				rmAddObjectDefItem(mediumHunt2ID, "Gazelle", rmRandInt(2, 5), 4.0);
			} else {
				rmAddObjectDefItem(mediumHunt2ID, "Zebra", rmRandInt(2, 5), 2.0);
				rmAddObjectDefItem(mediumHunt2ID, "Giraffe", rmRandInt(1, 4), 2.0);
			}
		}
	}
	rmAddObjectDefConstraint(mediumHunt2ID, avoidAll);
	rmAddObjectDefConstraint(mediumHunt2ID, avoidEdge);
	rmAddObjectDefConstraint(mediumHunt2ID, farAvoidCenter);
	rmAddObjectDefConstraint(mediumHunt2ID, createClassDistConstraint(classStartingSettlement, 50.0));
	rmAddObjectDefConstraint(mediumHunt2ID, avoidHuntable);
	rmAddObjectDefConstraint(mediumHunt2ID, farAvoidWater);

	// Bonus hunt 1.
	float bonusHunt1Float = rmRandFloat(0.0, 1.0);

	int bonusHunt1ID = rmCreateObjectDef("bonus hunt 1");
	if(randChance(1.0 / 3.0)) {
		if(bonusHunt1Float < 0.1) {
			rmAddObjectDefItem(bonusHunt1ID, "Elephant", 4, 2.0);
		} else if(bonusHunt1Float < 0.9) {
			rmAddObjectDefItem(bonusHunt1ID, "Elephant", rmRandInt(1, 3), 2.0);
		} else {
			rmAddObjectDefItem(bonusHunt1ID, "Elephant", 1, 0.0);
		}
	} else if(randChance()) {
		if(bonusHunt1Float < 0.1) {
			rmAddObjectDefItem(bonusHunt1ID, "Rhinocerous", 4, 2.0);
		} else {
			rmAddObjectDefItem(bonusHunt1ID, "Rhinocerous", rmRandInt(1, 3), 2.0);
		}
	} else {
		rmAddObjectDefItem(bonusHunt1ID, "Hippo", rmRandInt(2, 5), 2.0);
	}
	rmAddObjectDefConstraint(bonusHunt1ID, avoidAll);
	rmAddObjectDefConstraint(bonusHunt1ID, avoidEdge);
	rmAddObjectDefConstraint(bonusHunt1ID, farAvoidCenter);
	rmAddObjectDefConstraint(bonusHunt1ID, createClassDistConstraint(classStartingSettlement, 70.0));
	rmAddObjectDefConstraint(bonusHunt1ID, avoidHuntable);
	rmAddObjectDefConstraint(bonusHunt1ID, farAvoidWater);

	// Bonus hunt 2.
	float bonusHunt2Float = rmRandFloat(0.0, 1.0);

	int bonusHunt2ID = rmCreateObjectDef("bonus hunt 2");
	if(randChance(1.0 / 3.0)) {
		if(bonusHunt2Float < 0.1) {
			rmAddObjectDefItem(bonusHunt2ID, "Elephant", 4, 2.0);
		} else if(bonusHunt2Float < 0.9) {
			rmAddObjectDefItem(bonusHunt2ID, "Elephant", rmRandInt(1, 3), 2.0);
		} else {
			rmAddObjectDefItem(bonusHunt2ID, "Elephant", 1, 0.0);
		}
	} else if(randChance()) {
		if(bonusHunt2Float < 0.1) {
			rmAddObjectDefItem(bonusHunt2ID, "Rhinocerous", 4, 2.0);
		} else {
			rmAddObjectDefItem(bonusHunt2ID, "Rhinocerous", rmRandInt(1, 3), 2.0);
		}
	} else {
		rmAddObjectDefItem(bonusHunt2ID, "Hippo", rmRandInt(2, 5), 2.0);
	}
	rmAddObjectDefConstraint(bonusHunt2ID, avoidAll);
	rmAddObjectDefConstraint(bonusHunt2ID, avoidEdge);
	rmAddObjectDefConstraint(bonusHunt2ID, farAvoidCenter);
	rmAddObjectDefConstraint(bonusHunt2ID, createClassDistConstraint(classStartingSettlement, 70.0));
	rmAddObjectDefConstraint(bonusHunt2ID, avoidHuntable);
	rmAddObjectDefConstraint(bonusHunt2ID, farAvoidWater);

	// Far crane.
	int farCraneID = rmCreateObjectDef("far crane");
	rmAddObjectDefItem(farCraneID, "Crowned Crane", rmRandInt(5, 7), 2.0);
	rmAddObjectDefConstraint(farCraneID, avoidAll);
	rmAddObjectDefConstraint(farCraneID, avoidEdge);
	rmAddObjectDefConstraint(farCraneID, shortAvoidWater);
	rmAddObjectDefConstraint(farCraneID, mediumAvoidCenter);
	rmAddObjectDefConstraint(farCraneID, avoidTowerLOS);

	// Far berries.
	int farBerriesID = rmCreateObjectDef("far berries");
	rmAddObjectDefItem(farBerriesID, "Berry Bush", rmRandInt(4, 10), 4.0);
	rmAddObjectDefConstraint(farBerriesID, avoidAll);
	rmAddObjectDefConstraint(farBerriesID, avoidEdge);
	rmAddObjectDefConstraint(farBerriesID, farAvoidCenter);
	rmAddObjectDefConstraint(farBerriesID, createClassDistConstraint(classStartingSettlement, 70.0));
	rmAddObjectDefConstraint(farBerriesID, avoidFood);
	rmAddObjectDefConstraint(farBerriesID, avoidSettlement);
	rmAddObjectDefConstraint(farBerriesID, farAvoidWater);

	// Herdables and predators.
	// Medium herdables.
	int mediumHerdablesID = rmCreateObjectDef("medium herdables");
	if(randChance(0.2)) {
		rmAddObjectDefItem(mediumHerdablesID, "Goat", 3, 4.0);
	} else {
		rmAddObjectDefItem(mediumHerdablesID, "Goat", 2, 4.0);
	}
	rmAddObjectDefConstraint(mediumHerdablesID, avoidAll);
	rmAddObjectDefConstraint(mediumHerdablesID, avoidEdge);
	rmAddObjectDefConstraint(mediumHerdablesID, mediumAvoidCenter);
	rmAddObjectDefConstraint(mediumHerdablesID, createClassDistConstraint(classStartingSettlement, 50.0));
	rmAddObjectDefConstraint(mediumHerdablesID, avoidHerdable);
	rmAddObjectDefConstraint(mediumHerdablesID, avoidTowerLOS);
	rmAddObjectDefConstraint(mediumHerdablesID, farAvoidWater);

	// Far herdables.
	int farHerdablesID = rmCreateObjectDef("far herdables");
	if(randChance(0.2)) {
		rmAddObjectDefItem(farHerdablesID, "Goat", 1, 0.0);
	} else {
		rmAddObjectDefItem(farHerdablesID, "Goat", 2, 4.0);
	}
	rmAddObjectDefConstraint(farHerdablesID, avoidAll);
	rmAddObjectDefConstraint(farHerdablesID, avoidEdge);
	rmAddObjectDefConstraint(farHerdablesID, mediumAvoidCenter);
	rmAddObjectDefConstraint(farHerdablesID, createClassDistConstraint(classStartingSettlement, 70.0));
	rmAddObjectDefConstraint(farHerdablesID, avoidHerdable);
	rmAddObjectDefConstraint(farHerdablesID, farAvoidWater);

	// Far predators 1.
	int farPredators1ID = rmCreateObjectDef("far predators 1");
	rmAddObjectDefItem(farPredators1ID, "Lion", 1, 0.0);
	rmAddObjectDefConstraint(farPredators1ID, avoidAll);
	rmAddObjectDefConstraint(farPredators1ID, avoidEdge);
	rmAddObjectDefConstraint(farPredators1ID, farAvoidCenter);
	rmAddObjectDefConstraint(farPredators1ID, createClassDistConstraint(classStartingSettlement, 70.0));
	rmAddObjectDefConstraint(farPredators1ID, avoidPredator);
	rmAddObjectDefConstraint(farPredators1ID, avoidSettlement);
	rmAddObjectDefConstraint(farPredators1ID, farAvoidWater);

	// Far predators 2.
	int farPredators2ID = rmCreateObjectDef("far predators 2");
	rmAddObjectDefItem(farPredators2ID, "Crocodile", 1, 0.0);
	rmAddObjectDefConstraint(farPredators2ID, avoidAll);
	rmAddObjectDefConstraint(farPredators2ID, avoidEdge);
	rmAddObjectDefConstraint(farPredators2ID, farAvoidCenter);
	rmAddObjectDefConstraint(farPredators2ID, createClassDistConstraint(classStartingSettlement, 70.0));
	rmAddObjectDefConstraint(farPredators2ID, avoidPredator);
	rmAddObjectDefConstraint(farPredators2ID, avoidSettlement);
	rmAddObjectDefConstraint(farPredators2ID, farAvoidWater);

	// Other objects.
	// Random trees.
	int randomTreeID = rmCreateObjectDef("random tree");
	rmAddObjectDefItem(randomTreeID, "Palm", 1, 0.0);
	setObjectDefDistanceToMax(randomTreeID);
	rmAddObjectDefConstraint(randomTreeID, avoidAll);
	rmAddObjectDefConstraint(randomTreeID, avoidStartingSettlement);
	rmAddObjectDefConstraint(randomTreeID, avoidSettlement);
	rmAddObjectDefConstraint(randomTreeID, mediumAvoidWater);

	// Relics.
	int relicID = rmCreateObjectDef("relic");
	rmAddObjectDefItem(relicID, "Relic", 1, 0.0);
	rmAddObjectDefConstraint(relicID, avoidAll);
	rmAddObjectDefConstraint(relicID, avoidEdge);
	rmAddObjectDefConstraint(relicID, createClassDistConstraint(classStartingSettlement, 80.0));
	rmAddObjectDefConstraint(relicID, avoidRelic);
	rmAddObjectDefConstraint(relicID, mediumAvoidWater);

	progress(0.1);

	/*
	 * Terrain Generation:
	 * This is a bit more complex than on the average map because we're working with shallow water.
	 * Unfortunately, this counts as regular water, so all our "avoid water" constraints don't work.
	 * However, we can simply "rebuild" the ocean as a fake area once we have the shallow part settled.
	 * This way, we can avoid the ocean (actual water) and bypass the issue perfectly.
	*/

	// 1. Make shallow box in lower half of the map.
	int shallowID = rmCreateArea("global shallow");
	rmSetAreaWarnFailure(shallowID, false);
	rmSetAreaSize(shallowID, 1.0);
	rmSetAreaLocation(shallowID, 0.5, 0.01);
	rmSetAreaCoherence(shallowID, 0.0);
	rmSetAreaBaseHeight(shallowID, 2.0);
	rmSetAreaHeightBlend(shallowID, 2);
	rmAddAreaConstraint(shallowID, hugeShallowBox);
	rmAddAreaToClass(shallowID, classShallows);
	rmBuildArea(shallowID);

	// 2. Create bottom lake if > 3 players.
	if(gameIs1v1() == false) {
		float sideLakeSize = rmRandFloat(0.0075, 0.0125);
		float sideLakeZOffset = rmRandFloat(0.02, 0.06);
		float sideLakeXOffset = rmRandFloat(0.1, 0.15);

		int smallLake1ID = rmCreateArea("small lake 1");
		rmSetAreaWarnFailure(smallLake1ID, false);
		rmSetAreaBaseHeight(smallLake1ID, 0.0);
		rmSetAreaSize(smallLake1ID, sideLakeSize);
		rmSetAreaSmoothDistance(smallLake1ID, 0);
		rmSetAreaHeightBlend(smallLake1ID, 2);
		rmSetAreaCoherence(smallLake1ID, 1.0);
		rmSetAreaWaterType(smallLake1ID, "Egyptian Nile");
		rmAddAreaToClass(smallLake1ID, classWater);

		rmSetAreaLocation(smallLake1ID, 0.5 - sideLakeXOffset, sideLakeZOffset);

		int smallLake2ID = rmCreateArea("small lake 2");
		rmSetAreaWarnFailure(smallLake2ID, false);
		rmSetAreaBaseHeight(smallLake2ID, 0.0);
		rmSetAreaSize(smallLake2ID, sideLakeSize);
		rmSetAreaSmoothDistance(smallLake2ID, 0);
		rmSetAreaHeightBlend(smallLake2ID, 2);
		rmSetAreaCoherence(smallLake2ID, 1.0);
		rmSetAreaWaterType(smallLake2ID, "Egyptian Nile");
		rmAddAreaToClass(smallLake2ID, classWater);

		rmSetAreaLocation(smallLake2ID, 0.5 + sideLakeXOffset, sideLakeZOffset);

		int smallLake3ID = rmCreateArea("small lake 3");
		rmSetAreaWarnFailure(smallLake3ID, false);
		rmSetAreaBaseHeight(smallLake3ID, 0.0);
		rmSetAreaSize(smallLake3ID, rmRandFloat(0.035, 0.05));
		rmSetAreaSmoothDistance(smallLake3ID, 0);
		rmSetAreaHeightBlend(smallLake3ID, 2);
		rmSetAreaCoherence(smallLake3ID, 1.0);
		rmSetAreaWaterType(smallLake3ID, "Egyptian Nile");
		rmAddAreaToClass(smallLake3ID, classWater);

		rmSetAreaLocation(smallLake3ID, 0.5, rmRandFloat(0.04, 0.08));

		rmBuildAllAreas();
	}

	// 3. Block (= make shallow) "continents" to make space for players.
	int continentID = 0;

	for(i = 0; < 2) {
		continentID = rmCreateArea("continent 1 " + i);
		rmSetAreaBaseHeight(continentID, 2.0);
		rmSetAreaHeightBlend(continentID, 2);
		rmAddAreaToClass(continentID, classShallows);
		rmSetAreaWarnFailure(continentID, false);
		rmSetAreaCoherence(continentID, 1.0);
		rmAddAreaConstraint(continentID, mediumAvoidCenter);

		if(gameIs1v1()) {
			rmSetAreaSize(continentID, rmRandFloat(0.2, 0.2));
		} else if(cNonGaiaPlayers < 5) {
			rmSetAreaSize(continentID, rmRandFloat(0.25, 0.25));
		} else {
			rmSetAreaSize(continentID, rmRandFloat(0.17, 0.23));
		}

		if(i == 0) {
			rmSetAreaLocation(continentID, 0.0, 0.625);
		} else {
			rmSetAreaLocation(continentID, 1.0, 0.625);
		}
	}

	for(i = 0; < 2) {
		continentID = rmCreateArea("continent 2 " + i);
		rmSetAreaBaseHeight(continentID, 2.0);
		rmSetAreaHeightBlend(continentID, 2);
		rmAddAreaToClass(continentID, classShallows);
		rmSetAreaWarnFailure(continentID, false);
		rmSetAreaCoherence(continentID, 1.0);
		rmAddAreaConstraint(continentID, shortAvoidCenter);

		if(gameIs1v1()) {
			rmSetAreaSize(continentID, 0.325);
		} else if(cNonGaiaPlayers < 5) {
			rmSetAreaSize(continentID, 0.35);
		} else {
			rmSetAreaSize(continentID, 0.29);
		}

		if(i == 0) {
			rmSetAreaLocation(continentID, 0.0, 0.5);
		} else {
			rmSetAreaLocation(continentID, 1.0, 0.5);
		}
	}

	rmBuildAllAreas();

	// 4. Block (= make shallow) area around players for nicer shape of the shore.
	int numShoreBlobs = 50;

	for(i = 0; < cNonGaiaPlayers) {
		for(j = 0; < numShoreBlobs) {
			int playerShoreID = rmCreateArea("shore area " + i + " " + j);
			// rmSetAreaTerrainType(playerShoreID, "SandA");
			rmSetAreaCoherence(playerShoreID, 1.0);
			rmSetAreaBaseHeight(playerShoreID, 2.0);
			rmSetAreaHeightBlend(playerShoreID, 2);
			rmAddAreaToClass(playerShoreID, classShallows);
			rmSetAreaWarnFailure(playerShoreID, false);
		}
	}

	createRandomShape(numShoreBlobs, 1.0);

	// Find out for which player we have to place.
	int oceanPlayer = 1;

	if(teamInt == 1 && gameIs1v1() == false) {
		oceanPlayer = getNumberPlayersOnTeam(0) + 1;
	}

	// Set blob size.
	float shoreBlobSize = 25.0;

	if(gameIs1v1() == false) {
		shoreBlobSize = 20.0 + 5.0 * (cNonGaiaPlayers / 2.0);
	}

	placeRandomShapeMirrored(0.0, 0.0, "shore area", shoreBlobSize, 12.0, oceanPlayer);

	rmBuildAllAreas();

	// 5. Rebuild sea after we added all necessary areas to classShore.
	int seaID = rmCreateArea("sea");
	rmSetAreaWarnFailure(seaID, false);
	rmSetAreaSize(seaID, 1.0);
	rmSetAreaLocation(seaID, 0.5, 1.0);
	rmAddAreaConstraint(seaID, shallowConstraint);
	rmAddAreaToClass(seaID, classWater);
	rmBuildArea(seaID);

	// 6. Redefine shore according to previously built sea area.
	int areaNearOcean = createAreaMaxDistConstraint(rmAreaID("sea"), 15.0);

	int shoreID = rmCreateArea("shore");
	rmSetAreaWarnFailure(shoreID, false);
	rmSetAreaSize(shoreID, 1.0);
	rmAddAreaConstraint(shoreID, shoreShallow);
	rmAddAreaConstraint(shoreID, shortAvoidWater);
	rmAddAreaConstraint(shoreID, areaNearOcean);
	rmBuildArea(shoreID);

	int avoidShoreArea = createAreaDistConstraint(rmAreaID("shore"), 0.1);

	// 7. Build the actual shore with sand.
	for(i = 0; < 2) {
		shoreID = rmCreateArea("shore " + i);
		rmSetAreaWarnFailure(shoreID, false);
		rmSetAreaBaseHeight(shoreID, 5.0);
		rmSetAreaSize(shoreID, 1.0);
		rmSetAreaSmoothDistance(shoreID, 0);
		rmSetAreaHeightBlend(shoreID, 2);
		rmSetAreaCoherence(shoreID, 0.0);
		rmSetAreaTerrainType(shoreID, "SandA");
		rmAddAreaConstraint(shoreID, shortAvoidWater);
		rmAddAreaConstraint(shoreID, areaNearOcean);
		rmAddAreaConstraint(shoreID, avoidShoreArea);
		rmAddAreaConstraint(shoreID, shoreConstraint);
		rmAddAreaToClass(shoreID, classShore);
		rmBuildArea(shoreID);
	}

	if(gameIs1v1() == false) {
		for(i = 1; < 3) {
			int areaNearLake = createAreaMaxDistConstraint(rmAreaID("small lake " + i), 15.0);

			shoreID = rmCreateArea("shore lake " + i);
			rmSetAreaWarnFailure(shoreID, false);
			rmSetAreaBaseHeight(shoreID, 5.0);
			rmSetAreaSize(shoreID, 1.0);
			rmSetAreaSmoothDistance(shoreID, 0);
			rmSetAreaHeightBlend(shoreID, 2);
			rmSetAreaCoherence(shoreID, 0.0);
			rmSetAreaTerrainType(shoreID, "SandA");
			rmAddAreaConstraint(shoreID, shortAvoidWater);
			rmAddAreaConstraint(shoreID, areaNearLake);
			rmAddAreaConstraint(shoreID, avoidShoreArea);
			rmAddAreaConstraint(shoreID, shoreConstraint);
			rmAddAreaToClass(shoreID, classShore);
			rmBuildArea(shoreID);
		}
	}

	progress(0.2);

	// 8. Sandy areas.
	initAreaClass();

	setAreaTerrainType("SandA");

	setAreaBlobs(5, 10);
	setAreaCoherence(-0.25);
	setAreaParams(4.0, 2);
	setAreaAvoidSelf(30.0);

	addAreaConstraint(farAvoidWater);
	addAreaConstraint(mediumAvoidCenter);

	// Player area.
	setAreaSearchRadius(1.0, 1.0);
	setAreaBlobParams(17.5, 10.0);

	buildPlayerAreas(1);

	// Normal areas.
	setAreaSearchRadius(60.0, -1.0);
	setAreaBlobParams(10.0, 10.0);

	int numNormalAreas = 4 * cNonGaiaPlayers;

	if(cNonGaiaPlayers > 6) {
		numNormalAreas = 2 * cNonGaiaPlayers;
	} else if(cNonGaiaPlayers > 4) {
		numNormalAreas = 3 * cNonGaiaPlayers;
	}

	buildAreas(numNormalAreas, 0.1);

	progress(0.3);

	// TCs.
	placeObjectAtPlayerLocs(startingSettlementID, true);

	// Towers.
	placeAndStoreObjectMirrored(startingTowerID, true, 4, 23.0, 27.0, true, -1, startingTowerBackupID);

	// Settlements.
	int settlementID = rmCreateObjectDef("settlements");
	rmAddObjectDefItem(settlementID, "Settlement", 1, 0.0);

	float tcDist = 70.0;
	int tcAvoidCenterline = createClassDistConstraint( classCenterline, 0.5 * tcDist);

	// Close settlement
	addFairLocConstraint(avoidTowerLOS);
	addFairLocConstraint(veryFarAvoidWater);

	if(gameIs1v1()) {
		addFairLoc(60.0, 100.0, false, true, 70.0, 14.0, 14.0);
	} else {
		addFairLoc(60.0, 100.0, false, true, 55.0, 14.0, 14.0);
	}

	// Far settlement
	addFairLocConstraint(avoidTowerLOS);
	addFairLocConstraint(tcAvoidCenterline);
	addFairLocConstraint(veryFarAvoidWater);

	addFairLoc(80.0, 130.0, true, true, 70.0, 60.0, 60.0);

	// setFairLocInterDistMin(80.0);

	createFairLocs("settlements");

	// Build small sandy location on fair locs.
	for(f = 1; < 3) {
		for(i = 1; < cPlayers) {
			float x = getFairLocX(f, i);
			float z = getFairLocZ(f, i);

			int settlementAreaID = rmCreateArea("settlement area " + f + " " + i);
			rmSetAreaWarnFailure(settlementAreaID, false);
			rmSetAreaBaseHeight(settlementAreaID, 5);
			rmSetAreaSize(settlementAreaID, areaRadiusMetersToFraction(10.0));
			rmSetAreaSmoothDistance(settlementAreaID, 0);
			rmSetAreaHeightBlend(settlementAreaID, 2);
			rmSetAreaCoherence(settlementAreaID, 1.0);
			rmSetAreaTerrainType(settlementAreaID, "SandA");

			rmSetAreaLocation(settlementAreaID, x, z);

			rmBuildArea(settlementAreaID);
		}
	}

	placeObjectAtAllFairLocs(settlementID);

	progress(0.4);

	// Forests.
	initForestClass();

	addForestConstraint(avoidStartingSettlement);
	addForestConstraint(avoidAll);
	addForestConstraint(farAvoidWater);
	addForestConstraint(shortAvoidCenter);

	addForestType("Palm Forest", 1.0);

	setForestAvoidSelf(25.0);

	setForestBlobs(9);
	setForestBlobParams(4.625, 4.25);
	setForestParams(6.0, 2);
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

	int numForests = 10 * cNonGaiaPlayers / 2;

	if(cNonGaiaPlayers > 4) {
		numForests = 6 * cNonGaiaPlayers / 2;
	} else if(gameIs1v1() == false) {
		numForests = 8 * cNonGaiaPlayers / 2;
	}

	buildForests(numForests, 0.2);

	progress(0.7);

	// Object placement.
	// Starting gold close to tower (don't avoid water as it also includes shallows).
	storeObjectDefItem("Gold Mine Small", 1, 0.0);
	storeObjectConstraint(createTypeDistConstraint("Tower", rmRandFloat(8.0, 10.0))); // Don't get too close.
	storeObjectConstraint(avoidAll);
	storeObjectConstraint(avoidEdge);
	placeStoredObjectMirroredNearStoredLocs(4, false, 24.0, 25.0, 12.5);

	resetObjectStorage();

	// Place a small area under every mine so it looks nicer.
	for(j = 1; <= getNumberPlayersOnTeam(0)) {
		placeAreaUnderObj(j);
	}

	// Medium gold.
	for(j = 1; <= getNumberPlayersOnTeam(0)) {
		if(placeObjectForMirroredPlayers(j, mediumGoldID, false, 1, 50.0, 70.0) == 1) {
			placeAreaUnderObj(j);
		}
	}

	// Far gold.
	int numFarGold = 2;

	for(i = 0; < numFarGold) {
		for(j = 1; <= getNumberPlayersOnTeam(0)) {
			if(placeFarObjectForMirroredPlayers(j, bonusGoldID) == 1) {
				placeAreaUnderObj(j);
			}
		}
	}

	// Starting hunt.
	placeObjectMirrored(closeHuntID, false, 1, 25.0, 30.0, true);

	// Medium hunt.
	placeObjectMirrored(mediumHunt1ID, false, 1, 50.0, 80.0);
	placeObjectMirrored(mediumHunt2ID, false, 1, 50.0, 80.0);

	// 33% chance to spawn a second medium hunt (1 or 2).
	if(randChance(1.0 / 3.0)) {
		if(randChance()) {
			placeObjectMirrored(mediumHunt1ID, false, 1, 50.0, 80.0);
		} else {
			placeObjectMirrored(mediumHunt2ID, false, 1, 50.0, 80.0);
		}
	}

	// Bonus hunt.
	placeFarObjectMirrored(bonusHunt1ID, false, rmRandInt(1, 2));

	if(cNonGaiaPlayers == 2) {
		placeFarObjectMirrored(bonusHunt2ID, false, 1);
	}

	// Crane only for edge players.
	// Apply shore constraint to cranes.
	rmAddObjectDefConstraint(farCraneID, createAreaMaxDistConstraint(seaID, 8.0));
	placeFarObjectForMirroredPlayers(oceanPlayer, farCraneID, false, 1, 40.0);

	// Starting food.
	placeObjectMirrored(startingFoodID, false, 1, 21.0, 27.0, true);

	// Berries.
	placeFarObjectMirrored(farBerriesID, false, rmRandInt(1, 2));

	// Straggler trees.
	placeObjectMirrored(stragglerTreeID, false, rmRandInt(2, 5), 13.0, 13.5, true);

	// Medium herdables.
	placeObjectMirrored(mediumHerdablesID, false, rmRandInt(1, 2), 50.0, 70.0);

	// Far herdables.
	placeFarObjectMirrored(farHerdablesID, false, 2);

	// Starting herdables.
	placeObjectMirrored(startingHerdablesID, true, 1, 20.0, 30.0, false);

	// Far predators.
	if(cNonGaiaPlayers == 2) {
		placeFarObjectMirrored(farPredators1ID, false, rmRandInt(1, 3));
		placeFarObjectMirrored(farPredators2ID, false, rmRandInt(1, 3));
	} else {
		placeFarObjectMirrored(farPredators1ID, false, 1);
		placeFarObjectMirrored(farPredators2ID, false, 1);
	}

	progress(0.8);

	// Fish.
	int fishLandMin = createTerrainDistConstraint("Land", true, 15.0);
	int farAvoidFish = createTypeDistConstraint("Fish", 20.0);
	int shortAvoidFish = createTypeDistConstraint("Fish", 15.0);

	// Close fish.
	int playerFishID = rmCreateObjectDef("player fish");
	rmAddObjectDefItem(playerFishID, "Fish - Mahi", 3, 5.0);
	rmAddObjectDefConstraint(playerFishID, avoidEdge);
	rmAddObjectDefConstraint(playerFishID, fishLandMin);
	rmAddObjectDefConstraint(playerFishID, farAvoidFish);
	rmAddObjectDefConstraint(playerFishID, shortAvoidCenter);

	// Alt object without constraints so it's guaranteed to mirror correctly.
	int altFishID = rmCreateObjectDef("player fish alt");
	rmAddObjectDefItem(altFishID, "Fish - Mahi", 3, 5.0);

	// Bonus fish.
	int bonusFishID = rmCreateObjectDef("bonus fish");
	rmAddObjectDefItem(bonusFishID, "Fish - Perch", 2, 4.0);
	rmAddObjectDefConstraint(bonusFishID, avoidEdge);
	rmAddObjectDefConstraint(bonusFishID, fishLandMin);
	rmAddObjectDefConstraint(bonusFishID, shortAvoidCenter);
	if(cNonGaiaPlayers == 2) {
		rmAddObjectDefConstraint(bonusFishID, shortAvoidFish);
	} else {
		rmAddObjectDefConstraint(bonusFishID, farAvoidFish);
	}

	// Alt object without constraints so it's guaranteed to mirror correctly.
	int altBonusFishID = rmCreateObjectDef("bonus fish alt");
	rmAddObjectDefItem(altBonusFishID, "Fish - Perch", 2, 4.0);

	// 1. Upper lake.

	int centerFish1ID = rmCreateObjectDef("center fish 1");
	if(cNonGaiaPlayers == 2) {
		rmAddObjectDefItem(centerFish1ID, "Fish - Perch", 2, 4.0);
	} else {
		if(randChance()) {
			rmAddObjectDefItem(centerFish1ID, "Fish - Mahi", 3, 5.0);
		} else {
			rmAddObjectDefItem(centerFish1ID, "Fish - Perch", 2, 4.0);
		}
	}

	int centerFish2ID = rmCreateObjectDef("center fish 2");
	rmAddObjectDefItem(centerFish2ID, "Fish - Mahi", rmRandInt(3, 4), 5.0);

	int centerFish3ID = rmCreateObjectDef("center fish 3");
	if(randChance()) {
		rmAddObjectDefItem(centerFish3ID, "Fish - Mahi", 3, 5.0);
	} else {
		rmAddObjectDefItem(centerFish3ID, "Fish - Perch", 2, 4.0);
	}

	// Center fish.
	float fixedFishOffset = rmRandFloat(0.0, 0.04);
	placeObjectDefAtLoc(centerFish1ID, 0, 0.5, 0.54 + fixedFishOffset);
	placeObjectDefAtLoc(centerFish3ID, 0, 0.5, rmRandFloat(0.64 + fixedFishOffset, 0.68));

	if(cNonGaiaPlayers > 5) {
		placeObjectDefAtLoc(centerFish2ID, 0, 0.5, rmRandFloat(0.58 + fixedFishOffset, 0.62));
	}

	int numPlayerFish = 2;
	int numBonusFish = 1;
	float fishMinDist = 60.0;
	float originalFishMinDist = 0.0; // Store for placements of other objects later on.
	setObjectAngleInterval(1.15 * PI, 1.5 * PI, true);

	if(gameIs1v1() == false) {
		numBonusFish = cNonGaiaPlayers;
	} else {
		setObjectAngleInterval(1.275 * PI, 1.4 * PI, true);
	}

	for(f = 0; < numPlayerFish) {
		// Find location for first pair of mirrored players.
		for(i = 1; < 10) {
			if(placeObjectForMirroredPlayers(oceanPlayer, playerFishID, false, 1, fishMinDist, fishMinDist + 15.0, false, altFishID) == 1) {
				break;
			}

			fishMinDist = fishMinDist + 10.0;
		}

		if(f == 0) {
			// Adjust fishMaxDist after first iteration.
			originalFishMinDist = fishMinDist;
		}
	}

	setObjectAngleInterval(1.0 * PI, 1.6 * PI);

	placeObjectForMirroredPlayers(oceanPlayer, bonusFishID, false, numBonusFish, originalFishMinDist, fishMinDist + 100.0, false, altBonusFishID);

	// 2. Lower lake.

	if(gameIs1v1() == false) {
		numPlayerFish = cNonGaiaPlayers / 2;

		if(cNonGaiaPlayers > 7) {
			numPlayerFish = 5;
		}

		if(cNonGaiaPlayers > 3) {
			placeObjectDefAtLoc(altFishID, 0, 0.5, rmRandFloat(0.02, 0.04));
			placeObjectDefAtLoc(altFishID, 0, 0.5, rmRandFloat(0.10, 0.12));
		}

		fishMinDist = 70.0;
		setObjectAngleInterval(0.5 * PI, 1.0 * PI, true);

		for(f = 0; < numPlayerFish) {
			// Find location for first pair of mirrored players only (closest to pond).
			for(i = 1; < 8) {
				if(placeObjectForMirroredPlayers(oceanPlayer + getNumberPlayersOnTeam(0) - 1, playerFishID, false, 1, fishMinDist, fishMinDist + 15.0, false, altFishID) == 1) {
					break;
				}

				fishMinDist = fishMinDist + 10.0;
			}
		}
	}

	progress(0.9);

	// Relics (non-mirrored).
	placeObjectInPlayerSplits(relicID);

	// Random trees.
	placeObjectAtPlayerLocs(randomTreeID, false, 10);

	// Embellishment.
	int avoidDeepWater = createTerrainMaxDistConstraint("Land", true, 15.0);
	int nearOceanShore = createAreaMaxDistConstraint(seaID, 8.0);

	// Grass.
	int grassGroup1ID = rmCreateObjectDef("grass group 1");
	rmAddObjectDefItem(grassGroup1ID, "Grass", rmRandFloat(1, 3), 8.0);
	rmAddObjectDefItem(grassGroup1ID, "Bush", rmRandInt(1, 2), 8.0);
	setObjectDefDistanceToMax(grassGroup1ID);
	rmAddObjectDefConstraint(grassGroup1ID, embellishmentAvoidAll);
	rmAddObjectDefConstraint(grassGroup1ID, shortAvoidWater);
	rmPlaceObjectDefAtLoc(grassGroup1ID, 0, 0.5, 0.5, 60 * cNonGaiaPlayers);

	int grassGroup2ID = rmCreateObjectDef("grass group 2");
	rmAddObjectDefItem(grassGroup2ID, "Grass", rmRandFloat(1, 5), 8.0);
	rmAddObjectDefItem(grassGroup2ID, "Bush", rmRandInt(1, 3), 8.0);
	setObjectDefDistanceToMax(grassGroup2ID);
	rmAddObjectDefConstraint(grassGroup2ID, embellishmentAvoidAll);
	rmAddObjectDefConstraint(grassGroup2ID, nearOceanShore);
	rmAddObjectDefConstraint(grassGroup2ID, shortAvoidWater);
	rmPlaceObjectDefAtLoc(grassGroup2ID, 0, 0.5, 0.5, 5 * cNonGaiaPlayers);

	// Papyrus.
	int papyrus1ID = rmCreateObjectDef("papyrus 1");
	rmAddObjectDefItem(papyrus1ID, "Papyrus", 1, 0.0);
	setObjectDefDistanceToMax(papyrus1ID);
	rmAddObjectDefConstraint(papyrus1ID, nearOceanShore);
	rmAddObjectDefConstraint(papyrus1ID, avoidDeepWater);
	rmPlaceObjectDefAtLoc(papyrus1ID, 0, 0.5, 0.5, 5 * cNonGaiaPlayers);

	int papyrus2ID = rmCreateObjectDef("papyrus 2");
	rmAddObjectDefItem(papyrus2ID, "Papyrus", 2, 7.0);
	setObjectDefDistanceToMax(papyrus2ID);
	rmAddObjectDefConstraint(papyrus2ID, nearOceanShore);
	rmAddObjectDefConstraint(papyrus2ID, avoidDeepWater);
	rmPlaceObjectDefAtLoc(papyrus2ID, 0, 0.5, 0.5, 5 * cNonGaiaPlayers);

	if(gameIs1v1() == false) {
		for(i = 1; < 4) {
			int nearLakeShore = rmCreateAreaMaxDistanceConstraint("near lake shore " + i, rmAreaID("small lake " + i), 15.0);

			int grassGroup3ID = rmCreateObjectDef("grass group 3 " + i);
			rmAddObjectDefItem(grassGroup3ID, "Grass", rmRandFloat(1, 7), 8.0);
			rmAddObjectDefItem(grassGroup3ID, "Bush", rmRandInt(0, 3), 8.0);
			setObjectDefDistanceToMax(grassGroup3ID);
			rmAddObjectDefConstraint(grassGroup3ID, nearLakeShore);
			rmAddObjectDefConstraint(grassGroup3ID, shortAvoidWater);
			rmPlaceObjectDefAtLoc(grassGroup3ID, 0, 0.5, 0.5, cNonGaiaPlayers);

			int papyrus3ID = rmCreateObjectDef("papyrus 3 " + i);
			rmAddObjectDefItem(papyrus3ID, "Papyrus", 1, 0.0);
			setObjectDefDistanceToMax(papyrus3ID);
			rmAddObjectDefConstraint(papyrus3ID, nearLakeShore);
			rmAddObjectDefConstraint(papyrus3ID, avoidDeepWater);
			rmPlaceObjectDefAtLoc(papyrus3ID, 0, 0.5, 0.5, cNonGaiaPlayers);
		}
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
