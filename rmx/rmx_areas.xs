/*
** Default mirrored area generation.
** RebelsRising
** Last edit: 20/03/2022
*/

include "rmx_shape_gen.xs";

/************
* CONSTANTS *
************/

const string cAreaClassString = "rmx area class";

const string cAreaBlobString = "rmx area blob";
const string cFakeAreaString = "rmx fake area";

/**************
* CONSTRAINTS *
**************/

// Area constraints.
int areaConstraintCount = 0;

int areaConstraint0 = 0; int areaConstraint1 = 0; int areaConstraint2  = 0; int areaConstraint3  = 0;
int areaConstraint4 = 0; int areaConstraint5 = 0; int areaConstraint6  = 0; int areaConstraint7  = 0;
int areaConstraint8 = 0; int areaConstraint9 = 0; int areaConstraint10 = 0; int areaConstraint11 = 0;

int getAreaConstraint(int i = 0) {
	if(i == 0) return(areaConstraint0); if(i == 1) return(areaConstraint1); if(i == 2)  return(areaConstraint2);  if(i == 3)  return(areaConstraint3);
	if(i == 4) return(areaConstraint4); if(i == 5) return(areaConstraint5); if(i == 6)  return(areaConstraint6);  if(i == 7)  return(areaConstraint7);
	if(i == 8) return(areaConstraint8); if(i == 9) return(areaConstraint9); if(i == 10) return(areaConstraint10); if(i == 11) return(areaConstraint11);
	return(0);
}

void setAreaConstraint(int i = 0, int cID = 0) {
	if(i == 0) areaConstraint0 = cID; if(i == 1) areaConstraint1 = cID; if(i == 2)  areaConstraint2  = cID; if(i == 3)  areaConstraint3  = cID;
	if(i == 4) areaConstraint4 = cID; if(i == 5) areaConstraint5 = cID; if(i == 6)  areaConstraint6  = cID; if(i == 7)  areaConstraint7  = cID;
	if(i == 8) areaConstraint8 = cID; if(i == 9) areaConstraint9 = cID; if(i == 10) areaConstraint10 = cID; if(i == 11) areaConstraint11 = cID;
}

/*
** Resets area constraints.
*/
void resetAreaConstraints() {
	areaConstraintCount = 0;
}

/*
** Adds a constraint to the area constraints.
** Note that these should NOT include constraints that makes areas avoid themselves or buildArea() won't work properly!
**
** @param cID: the ID of the constraint
*/
void addAreaConstraint(int cID = 0) {
	setAreaConstraint(areaConstraintCount, cID);
	areaConstraintCount++;
}

/*************
* PARAMETERS *
*************/

// Used to keep track of the area class (if we need multiple classes).
int areaClassCount = -1;

// Counter for the number of areas so we don't run out of names.
int areaBlobCount = -1; // -1 since we increment before using the value.

// Default settings.
int classFakeArea = -1; // Set by initAreaClass().

int areaMinBlobs = 0;
int areaMaxBlobs = 0;

float areaBlobRequiredRatio = 0.5;

float areaBlobSize = 0.0;
float areaBlobSpacing = 0.0;

float areaMinCoherence = -1.0;
float areaMaxCoherence = 1.0;

float areaMinRadius = 20.0;
float areaMaxRadius = -1.0;

float areaMinAngle = NPI;
float areaMaxAngle = PI;

// Constraint for self avoidance.
int areaAvoidSelfID = -1;

// Whether to enforce constraints.
bool areaEnforceConstraints = false;

// Type.
string areaTerrainType = "";
string areaWaterType = "";

// Other properties.
float areaHeight = INF;
int areaSmoothDistance = -1;
int areaHeightBlend = -1;

// Layering doesn't make much sense because we place many small areas.

/*
** Sets a constraint for areas to avoid themselves.
**
** @param dist: distance in meters for areas to avoid each other
*/
void setAreaAvoidSelf(float dist = 0.0) {
	if(dist > 0.0) {
		areaAvoidSelfID = createClassDistConstraint(classFakeArea, dist);
	} else {
		areaAvoidSelfID = -1;
	}
}

/*
** Can be set to true to enforce constraints or all blobs instead of just applying them to fake blobs (at the cost of area precision).
**
** @param enforce: true to enforce constraints, false otherwise
*/
void setAreaEnforceConstraints(bool enforce = false) {
	areaEnforceConstraints = enforce;
}

/*
** Sets a minimum and maximum number of blobs for the areas.
**
** @param minBlobs: minimum number of blobs
** @param maxBlobs: maximum number of blobs, will be adjusted to minBlobs if not set
*/
void setAreaBlobs(int minBlobs = 0, int maxBlobs = -1) {
	if(maxBlobs < 0) {
		maxBlobs = minBlobs;
	}

	areaMinBlobs = minBlobs;
	areaMaxBlobs = maxBlobs;
}

/*
** Sets blob settings.
**
** @param blobSize: the radius of the blob in meters
** @param blobSpacing: the distance between the blobs in meters (independent of blob radius)
*/
void setAreaBlobParams(float blobSize = 0.0, float blobSpacing = 0.0) {
	areaBlobSize = blobSize;
	areaBlobSpacing = blobSpacing;
}

/*
** Sets additional parameters for the areas.
**
** @param height: the area height
** @param heightBlend: the hight blend parameter (0, 1 or 2) for areas
** @param smoothDistance: the smooth distance for areas
*/
void setAreaParams(float height = INF, int heightBlend = -1, int smoothDistance = -1) {
	areaHeight = height;
	areaSmoothDistance = smoothDistance;
	areaHeightBlend = heightBlend;
}

/*
** Sets the terrain type for the area.
**
** @param type: the terrain type as string
*/
void setAreaTerrainType(string type = "", float blobSize = -1.0, float blobSpacing = -1.0) {
	areaTerrainType = type;

	if(blobSize >= 0.0 && blobSpacing >= 0.0) {
		setAreaBlobParams(blobSize, blobSpacing);
	}
}

/*
** Sets the water type for the area.
**
** @param type: the water type as string
*/
void setAreaWaterType(string type = "", float blobSize = -1.0, float blobSpacing = -1.0) {
	areaWaterType = type;

	if(blobSize >= 0.0 && blobSpacing >= 0.0) {
		setAreaBlobParams(blobSize, blobSpacing);
	}
}

/*
** Sets the required ratio for an area to be built.
**
** @param requiredRatio: the minimum ratio of blobs successfully built required to build the entire area
*/
void setAreaRequiredRatio(float requiredRatio = 0.5) {
	areaBlobRequiredRatio = requiredRatio;
}

/*
** Sets a minimum and maximum coherence (compactness) for areas to randomize from.
**
** @param minCoherence: mimumum coherence (smallest possible value: -1.0), linear areas
** @param maxCoherence: maximum coherence (largest possible value: 1.0), circular areas
*/
void setAreaCoherence(float minCoherence = -1.0, float maxCoherence = 1.0) {
	areaMinCoherence = minCoherence;
	areaMaxCoherence = maxCoherence;
}

/*
** Sets a minimum and maximum radius in meters to consider when placing areas.
** Note that the default of -1.0 will be overwritten with the radius from the center to the corner at area generation time.
**
** @param minRadius: minimum radius in meters to randomize
** @param maxRadius: maximum radius in meters to randomize (-1.0 = up to corners)
*/
void setAreaSearchRadius(float minRadius = 20.0, float maxRadius = -1.0) {
	areaMinRadius = minRadius;
	areaMaxRadius = maxRadius;
}

/*
** Sets a minimum and maximum angle in radians to consider when placing areas.
**
** @param minRadius: minimum angle in radians to randomize
** @param maxRadius: maximum angle in radians to randomize
*/
void setAreaSearchAngle(float minAngle = NPI, float maxAngle = PI) {
	areaMinAngle = minAngle;
	areaMaxAngle = maxAngle;
}

/*
** Resets area settings (types, constraints, and search radius).
*/
void resetAreas() {
	classFakeArea = -1;

	resetAreaConstraints();

	setAreaTerrainType();
	setAreaWaterType();

	setAreaBlobs();
	setAreaBlobParams();
	setAreaParams();
	setAreaCoherence();
	setAreaSearchRadius();
	setAreaSearchAngle();
	setAreaAvoidSelf();
	setAreaEnforceConstraints();
	setAreaRequiredRatio();
}

/******************
* AREA GENERATION *
******************/

/*
** Initializes the area class.
**
** @param clazz: use an existing class for the areas instead of a new one if set
**
** @returns: the ID of the created class (can be used to set constraints!)
*/
int initAreaClass(int clazz = -1) {
	if(clazz == -1) {
		classFakeArea = rmDefineClass(cAreaClassString + " " + areaClassCount);
		areaClassCount++;
	} else {
		classFakeArea = clazz;
	}

	return(classFakeArea);
}

/*
** Randomizes a radius while considering an areaMaxRadius of -1.0.
**
** @returns: the randomized area radius in meters
*/
float getAreaLocRadius() {
	// Adjust maximum radius if necessary (i.e., set to < 0).
	if(areaMaxRadius < 0) {
		areaMaxRadius = largerFractionToMeters(HALF_SQRT_2);
	}

	return(rmRandFloat(areaMinRadius, areaMaxRadius));
}

/*
** Randomizes an angle from the specified range.
**
** @returns: the randomized area angle
*/
float getAreaLocAngle() {
	return(rmRandFloat(areaMinAngle, areaMaxAngle));
}

/*
** Checks if the location for an area is valid.
**
** @param radius: the radius in meters
** @param angle: the angle in the polar coordinate system
** @param player: if set to > 0, the player's location will be used as offset instead of the center of the map (0.5/0.5)
*/
bool isAreaLocValid(float radius = 0.0, float angle = 0.0, int player = 0) {
	float tolX = rmXMetersToFraction(areaBlobSize);
	float tolZ = rmZMetersToFraction(areaBlobSize);

	float x = getXFromPolarForPlayer(player, rmXMetersToFraction(radius), angle);
	float z = getZFromPolarForPlayer(player, rmZMetersToFraction(radius), angle);

	return(isLocValid(x, z, tolX, tolZ));
}

/*
** Creates blob areas for area according to given settings.
**
** @param numBlobs: the number of blobs to create areas for
** @param areaID: the template for area IDs (will have appended " " + i during the loop)
** @param paintTerrain: whether to paint the area or not
** @param addToClass: whether to add the area to the area class
** @param avoidSelf: whether to apply the constraint for self-avoidance
*/
void createAreaBlobAreas(int numBlobs = 0, string areaID = "", bool paintTerrain = false, bool addToClass = false, bool avoidSelf = true) {
	for(i = 0; < numBlobs) {
		int blobID = rmCreateArea(areaID + " " + i);

		// Add to class.
		if(addToClass) {
			rmAddAreaToClass(blobID, classFakeArea);
		}

		// Add type.
		if(paintTerrain) {
			// Normal blob.
			if(areaWaterType != "") {
				rmSetAreaWaterType(blobID, areaWaterType);
			} else if (areaTerrainType != "") {
				rmSetAreaTerrainType(blobID, areaTerrainType);
			}
		}

		// Set other properties.
		if(areaHeight != INF) {
			rmSetAreaBaseHeight(blobID, areaHeight);
		}

		if(areaHeightBlend != -1) {
			rmSetAreaHeightBlend(blobID, areaHeightBlend);
		}

		if(areaSmoothDistance != -1) {
			rmSetAreaSmoothDistance(blobID, areaSmoothDistance);
		}

		if(paintTerrain == false || areaEnforceConstraints) {
			// Apply constraints for fake blob or if enforced.
			for(c = 0; < areaConstraintCount) {
				rmAddAreaConstraint(blobID, getAreaConstraint(c));
			}
		}

		// Avoid self if exists.
		if(avoidSelf && areaAvoidSelfID >= 0) {
			rmAddAreaConstraint(blobID, areaAvoidSelfID);
		}
	}
}

/*
** Attempts to randomly place and build an area from a previously built random shape.
**
** @param numBlobs: the number of blobs to create
** @param player: if set to > 0, the player's location will be used as offset instead of the center of the map (0.5/0.5)
**
** @returns: true if the area has been built successfully, false otherwise
*/
bool buildAreaShape(int numBlobs = 0, int player = 0) {
	// Increase the counter here already because we may return early.
	areaBlobCount++;

	// Create fake blobs.
	createAreaBlobAreas(numBlobs, cFakeAreaString + " " + areaBlobCount);

	// Randomize angle and radius.
	float radius = getAreaLocRadius();
	float angle = getAreaLocAngle();

	int numTries = 0;

	while(isAreaLocValid(radius, angle, player) == false && numTries < 100) {
		radius = getAreaLocRadius();
		angle = getAreaLocAngle();
		numTries++;
	}

	if(numTries >= 100) {
		return(false);
	}

	placeRandomShape(radius, angle, cFakeAreaString + " " + areaBlobCount, areaBlobSize, areaBlobSpacing, player);

	// Check how many we can build successfully.
	int numBuilt = 0;

	for(i = 0; < numBlobs) {
		if(rmBuildArea(rmAreaID(cFakeAreaString + " " + areaBlobCount + " " + i))) {
			numBuilt++;
		} else {
			setBlobForRemoval(i - numBuilt, numBuilt);
		}
	}

	// Return false in case we failed to build the required ratio of blobs.
	if(numBuilt < areaBlobRequiredRatio * numBlobs) {
		return(false);
	}

	// Remove unbuilt blobs if we ended up in a valid state.
	for(i = 0; < numBlobs - numBuilt) {
		removeFullBlob(getBlobForRemoval(i));
	}

	// Define two areas of blobs, the original one and the mirrored one.
	for(i = 0; < 2) {
		createAreaBlobAreas(numBuilt, cAreaBlobString + " " + areaBlobCount + " " + i, true, true, false);
	}

	// Place the two previously generated areas.
	placeRandomShapeMirrored(radius, angle, cAreaBlobString + " " + areaBlobCount, areaBlobSize, areaBlobSpacing, player);

	rmBuildAllAreas();

	return(true);
}

/*
** Attempts to build a number of mirrored areas based on the defined parameters and arguments given.
**
** If you need more customized support, feel free to use this and the above function as a template and adjust them to your needs (or provide your own).
**
** @param numAreas: the number of areas to build
** @param prog: advances the progress bar by a fraction of the specified value for every area placed; if using this, make sure you use progress() instead of rmSetStatusText()
** @param player: if set to > 0, the player's location will be used as offset instead of the center of the map (0.5/0.5)
** @param numTries: number of attempts to place the desired amount of areas (default 250)
**
** @returns: the number of areas built (and mirrored) successfully
*/
int buildAreas(int numAreas = 0, float prog = 0.0, int player = 0, int numTries = 250) {
	int numBuilt = 0;

	// Prepare first iteration.
	int numBlobs = rmRandInt(areaMinBlobs, areaMaxBlobs);
	float coherence = rmRandFloat(areaMinCoherence, areaMaxCoherence);

	// Build a random shape.
	createRandomShape(numBlobs, coherence);

	for(i = 0; < numTries) {
		if(buildAreaShape(numBlobs, player) == false) {
			continue;
		}

		numBuilt++;
		addProgress(prog / numAreas);

		if(numBuilt >= numAreas) {
			break;
		}

		// Prepare for next iteration.
		numBlobs = rmRandInt(areaMinBlobs, areaMaxBlobs);
		coherence = rmRandFloat(areaMinCoherence, areaMaxCoherence);

		createRandomShape(numBlobs, coherence);
	}

	return(numBuilt);
}

/*
** Attempts to build a given number of mirrored areas around every player according to the previously specified parameters.
** The function iterates over the number of players in the team and places an area for every player and their mirrored counterpart.
**
** If it should ever be necessary to verify how many areas were successfully built and for which pair of players, make a custom version of this function
** along with a data structure to store the return result of buildAreas().
**
** @param numAreas: the number of areas to build
** @param prog: advances the progress bar by a fraction of the specified value for every area placed; if using this, make sure you use progress() instead of rmSetStatusText()
** @param numTries: number of attempts to place the desired amount of areas (default 250)
**
** @returns: the number of areas built (and mirrored) successfully
*/
int buildPlayerAreas(int numAreas = 0, float prog = 0.0, int numTries = 250) {
	int numBuilt = 0;
	int numPlayers = getNumberPlayersOnTeam(0);

	prog = prog / numPlayers;

	for(i = 1; <= numPlayers) {
		if(randChance(0.5)) {
			numBuilt = numBuilt + buildAreas(numAreas, prog, i, numTries);
		} else {
			numBuilt = numBuilt + buildAreas(numAreas, prog, getMirroredPlayer(i), numTries);
		}
	}

	return(numBuilt);
}

/*
** Utility function to create a single mirrored area based on the specified parameters at a given location.
** Note that this function does not check if a minimum number of blobs can be built and tries to place the areas directly.
**
** @param radius: the radius in meters
** @param angle: the angle in the polar coordinate system
** @param player: if set to > 0, the player's location will be used as offset instead of the center of the map (0.5/0.5)
*/
void buildMirroredAreaAtLocation(float radius = 0.0, float angle = 0.0, int player = 0) {
	areaBlobCount++;

	// Randomize blobs and coherence.
	int numBlobs = rmRandInt(areaMinBlobs, areaMaxBlobs);
	float coherence = rmRandInt(areaMinCoherence, areaMaxCoherence);

	// Build a random shape.
	createRandomShape(numBlobs, coherence);

	// Define two areas of blobs, the original one and the mirrored one.
	for(i = 0; < 2) {
		createAreaBlobAreas(numBlobs, cAreaBlobString + " " + areaBlobCount + " " + i, true, true, false);
	}

	// Place the two previously generated areas.
	placeRandomShapeMirrored(radius, angle, cAreaBlobString + " " + areaBlobCount, areaBlobSize, areaBlobSpacing, player);

	rmBuildAllAreas();
}
