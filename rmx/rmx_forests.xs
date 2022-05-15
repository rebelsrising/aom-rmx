/*
** Default mirrored forest generation.
** RebelsRising
** Last edit: 20/03/2022
*/

include "rmx_areas.xs";

/************
* CONSTANTS *
************/

const string cForestClassString = "rmx forest class";

const string cForestString = "rmx forest";
const string cFakeForestString = "rmx fake forest";

/**************
* CONSTRAINTS *
**************/

// Forest constraints.
int forestConstraintCount = 0;

int forestConstraint0 = 0; int forestConstraint1 = 0; int forestConstraint2  = 0; int forestConstraint3  = 0;
int forestConstraint4 = 0; int forestConstraint5 = 0; int forestConstraint6  = 0; int forestConstraint7  = 0;
int forestConstraint8 = 0; int forestConstraint9 = 0; int forestConstraint10 = 0; int forestConstraint11 = 0;

int getForestConstraint(int i = 0) {
	if(i == 0) return(forestConstraint0); if(i == 1) return(forestConstraint1); if(i == 2)  return(forestConstraint2);  if(i == 3)  return(forestConstraint3);
	if(i == 4) return(forestConstraint4); if(i == 5) return(forestConstraint5); if(i == 6)  return(forestConstraint6);  if(i == 7)  return(forestConstraint7);
	if(i == 8) return(forestConstraint8); if(i == 9) return(forestConstraint9); if(i == 10) return(forestConstraint10); if(i == 11) return(forestConstraint11);
	return(0);
}

void setForestConstraint(int i = 0, int cID = 0) {
	if(i == 0) forestConstraint0 = cID; if(i == 1) forestConstraint1 = cID; if(i == 2)  forestConstraint2  = cID; if(i == 3)  forestConstraint3  = cID;
	if(i == 4) forestConstraint4 = cID; if(i == 5) forestConstraint5 = cID; if(i == 6)  forestConstraint6  = cID; if(i == 7)  forestConstraint7  = cID;
	if(i == 8) forestConstraint8 = cID; if(i == 9) forestConstraint9 = cID; if(i == 10) forestConstraint10 = cID; if(i == 11) forestConstraint11 = cID;
}

/*
** Resets forest constraints.
*/
void resetForestConstraints() {
	forestConstraintCount = 0;
}

/*
** Adds a constraint to the forest constraints.
** Note that these should NOT include constraints that makes forests avoid themselves or buildForests() won't work properly!
**
** @param cID: the ID of the constraint
*/
void addForestConstraint(int cID = 0) {
	setForestConstraint(forestConstraintCount, cID);

	forestConstraintCount++;
}

/********
* TYPES *
********/

// Forest types.
int forestTypeCount = 0;

string forestType0 = ""; string forestType1 = ""; string forestType2  = ""; string forestType3  = "";
string forestType4 = ""; string forestType5 = ""; string forestType6  = ""; string forestType7  = "";
string forestType8 = ""; string forestType9 = ""; string forestType10 = ""; string forestType11 = "";

string getForestType(int i = 0) {
	if(i == 0) return(forestType0); if(i == 1) return(forestType1); if(i == 2)  return(forestType2);  if(i == 3)  return(forestType3);
	if(i == 4) return(forestType4); if(i == 5) return(forestType5); if(i == 6)  return(forestType6);  if(i == 7)  return(forestType7);
	if(i == 8) return(forestType8); if(i == 9) return(forestType9); if(i == 10) return(forestType10); if(i == 11) return(forestType11);
	return("");
}

void setForestType(int i = 0, string type = "") {
	if(i == 0) forestType0 = type; if(i == 1) forestType1 = type; if(i == 2)  forestType2  = type; if(i == 3)  forestType3  = type;
	if(i == 4) forestType4 = type; if(i == 5) forestType5 = type; if(i == 6)  forestType6  = type; if(i == 7)  forestType7  = type;
	if(i == 8) forestType8 = type; if(i == 9) forestType9 = type; if(i == 10) forestType10 = type; if(i == 11) forestType11 = type;
}

// Forest type chance.
float forestTotalChance = 0.0;

float forestTypeChance0 = 0.0; float forestTypeChance1 = 0.0; float forestTypeChance2  = 0.0; float forestTypeChance3  = 0.0;
float forestTypeChance4 = 0.0; float forestTypeChance5 = 0.0; float forestTypeChance6  = 0.0; float forestTypeChance7  = 0.0;
float forestTypeChance8 = 0.0; float forestTypeChance9 = 0.0; float forestTypeChance10 = 0.0; float forestTypeChance11 = 0.0;

float getForestTypeChance(int i = 0) {
	if(i == 0) return(forestTypeChance0); if(i == 1) return(forestTypeChance1); if(i == 2)  return(forestTypeChance2);  if(i == 3)  return(forestTypeChance3);
	if(i == 4) return(forestTypeChance4); if(i == 5) return(forestTypeChance5); if(i == 6)  return(forestTypeChance6);  if(i == 7)  return(forestTypeChance7);
	if(i == 8) return(forestTypeChance8); if(i == 9) return(forestTypeChance9); if(i == 10) return(forestTypeChance10); if(i == 11) return(forestTypeChance11);
	return(0.0);
}

void setForestTypeChance(int i = 0, float chance = 0.0) {
	if(i == 0) forestTypeChance0 = chance; if(i == 1) forestTypeChance1 = chance; if(i == 2)  forestTypeChance2  = chance; if(i == 3)  forestTypeChance3  = chance;
	if(i == 4) forestTypeChance4 = chance; if(i == 5) forestTypeChance5 = chance; if(i == 6)  forestTypeChance6  = chance; if(i == 7)  forestTypeChance7  = chance;
	if(i == 8) forestTypeChance8 = chance; if(i == 9) forestTypeChance9 = chance; if(i == 10) forestTypeChance10 = chance; if(i == 11) forestTypeChance11 = chance;
}

/*
** Adds a type and the chance to randomize that type to the array of forest types.
**
** @param type: the forest type as string
** @param chance: chance to randomize the forest type in [0, 1]
*/
void addForestType(string type = "", float chance = 0.0) {
	setForestType(forestTypeCount, type);
	setForestTypeChance(forestTypeCount, chance);
	forestTotalChance = forestTotalChance + chance;

	forestTypeCount++;
}

/*
** Resets forest types.
*/
void resetForestTypes() {
	forestTypeCount = 0;
	forestTotalChance = 0.0;
}

/*************
* PARAMETERS *
*************/

// Used to keep track of the forest class (if we need multiple classes).
int forestClassCount = -1;

// Counter for the number of areas so we don't run out of names.
int forestAreaCount = -1; // -1 since we increment before using the value.

// Default settings.
int classFakeForest = -1; // Set by initForestClass().

int forestMinBlobs = 0;
int forestMaxBlobs = 0;

float forestBlobSize = 0.0;
float forestBlobSpacing = 0.0;
float forestBlobRequiredRatio = 0.5;

float forestMinCoherence = -1.0;
float forestMaxCoherence = 1.0;

float forestMinRadius = 20.0;
float forestMaxRadius = -1.0;

float forestMinAngle = NPI;
float forestMaxAngle = PI;

// Constraint for self avoidance.
int forestAvoidSelfID = -1;

// Other properties.
float forestHeight = INF;
int forestSmoothDistance = -1;
int forestHeightBlend = -1;

/*
** Sets a constraint for forests to avoid themselves.
** This is necessary because real forest blobs won't spawn if they have this constraint applied when being built.
**
** @param dist: distance in meters for forests to avoid each other
*/
void setForestAvoidSelf(float dist = 0.0) {
	if(dist > 0.0) {
		forestAvoidSelfID = createClassDistConstraint(classFakeForest, dist);
	} else {
		forestAvoidSelfID = -1;
	}
}

/*
** Sets a minimum and maximum number of blobs for the forests.
**
** @param minBlobs: minimum number of blobs
** @param maxBlobs: maximum number of blobs, will be adjusted to minBlobs if not set
*/
void setForestBlobs(int minBlobs = 0, int maxBlobs = -1) {
	if(maxBlobs < 0) {
		maxBlobs = minBlobs;
	}

	forestMinBlobs = minBlobs;
	forestMaxBlobs = maxBlobs;
}

/*
** Sets blob settings.
**
** @param blobSize: the radius of the blob in meters
** @param blobSpacing: the distance between the blobs in meters (independent of blob radius)
*/
void setForestBlobParams(float blobSize = 0.0, float blobSpacing = 0.0) {
	forestBlobSize = blobSize;
	forestBlobSpacing = blobSpacing;
}

/*
** Sets additional parameters for the areas.
**
** @param height: the area height
** @param heightBlend: the hight blend parameter (0, 1 or 2) for areas
** @param smoothDistance: the smooth distance for areas
*/
void setForestParams(float height = INF, int heightBlend = -1, int smoothDistance = -1) {
	forestHeight = height;
	forestSmoothDistance = smoothDistance;
	forestHeightBlend = heightBlend;
}

/*
** Sets the required ratio for an area to be built.
**
** @param requiredRatio: the minimum ratio of blobs successfully built required to build the entire area
*/
void setForestMinRatio(float requiredRatio = 0.5) {
	forestBlobRequiredRatio = requiredRatio;
}

/*
** Sets a minimum and maximum coherence (compactness) for forests to randomize from.
**
** @param minCoherence: mimumum coherence (smallest possible value: -1.0), linear areas
** @param maxCoherence: maximum coherence (largest possible value: 1.0), circular areas
*/
void setForestCoherence(float minCoherence = -1.0, float maxCoherence = 1.0) {
	forestMinCoherence = minCoherence;
	forestMaxCoherence = maxCoherence;
}

/*
** Sets a minimum and maximum radius in meters to consider when placing forests.
** Note that the default of -1.0 will be overwritten with the radius from the center to the corner at forest generation time.
**
** @param minRadius: minimum radius in meters to randomize
** @param maxRadius: maximum radius in meters to randomize (-1.0 = up to corners)
*/
void setForestSearchRadius(float minRadius = 20.0, float maxRadius = -1.0) {
	forestMinRadius = minRadius;
	forestMaxRadius = maxRadius;
}

/*
** Sets a minimum and maximum angle in radians to consider when placing forests.
**
** @param minRadius: minimum angle in radians to randomize
** @param maxRadius: maximum angle in radians to randomize
*/
void setForestSearchAngle(float minAngle = NPI, float maxAngle = PI) {
	forestMinAngle = minAngle;
	forestMaxAngle = maxAngle;
}

/*
** Resets forest settings (types, constraints, and search radius).
*/
void resetForests() {
	classFakeForest = -1;

	resetForestConstraints();
	resetForestTypes();

	setForestBlobs();
	setForestBlobParams();
	setForestParams();
	setForestCoherence();
	setForestSearchRadius();
	setForestSearchAngle();
	setForestAvoidSelf();
	setForestMinRatio();
}

/********************
* FOREST GENERATION *
********************/

/*
** Initializes the cliff class.
**
** @param altClass: use an existing class for the ponds instead of a new one if set
**
** @returns: the ID of the created class (can be used to set constraints!)
*/
int initForestClass(int clazz = -1) {
	if(clazz == -1) {
		classFakeForest = rmDefineClass(cForestClassString + " " + forestClassCount);
		forestClassCount++;
	} else {
		classFakeForest = clazz;
	}

	return(classFakeForest);
}

/*
** Randomizes a radius while considering a forestMaxRadius of -1.0.
**
** @returns: the randomized forest radius in meters
*/
float getForestLocRadius() {
	// Adjust maximum radius if necessary (i.e., set to < 0).
	if(forestMaxRadius < 0) {
		forestMaxRadius = largerFractionToMeters(HALF_SQRT_2);
	}

	// Consider using randLargeFloat here instead.
	return(rmRandFloat(forestMinRadius, forestMaxRadius));
}

/*
** Randomizes an angle from the specified range.
**
** @returns: the randomized forest angle
*/
float getForestLocAngle() {
	return(rmRandFloat(forestMinAngle, forestMaxAngle));
}

/*
** Checks if the location for a forest is valid.
**
** @param radius: the radius in meters
** @param angle: the angle in the polar coordinate system
** @param player: if set to > 0, the player's location will be used as offset instead of the center of the map (0.5/0.5)
*/
bool isForestLocValid(float radius = 0.0, float angle = 0.0, int player = 0) {
	// Allow origin of a forest to be slightly outside of the map for more variability.
	float tolX = rmXMetersToFraction(0.0 - forestBlobSize);
	float tolZ = rmZMetersToFraction(0.0 - forestBlobSize);

	float x = getXFromPolarForPlayer(player, rmXMetersToFraction(radius), angle);
	float z = getZFromPolarForPlayer(player, rmZMetersToFraction(radius), angle);

	return(isLocValid(x, z, tolX, tolZ));
}

/*
** Randomizes the forest time according the set forest types and chances.
**
** @returns: the randomized forest type
*/
string randomizeForestType() {
	// Determine forest type.
	float forestChance = rmRandFloat(0.0, forestTotalChance);
	string forestType = getForestType(0);
	float summedProbabilities = getForestTypeChance(0);

	for(i = 1; < forestTypeCount) {
		if(summedProbabilities >= forestChance) {
			forestType = getForestType(i);
			break;
		}

		summedProbabilities = summedProbabilities + getForestTypeChance(i);
	}

	return(forestType);
}

/*
** Creates blob areas for forest according to given settings.
**
** @param numBlobs: the number of blobs to create areas for
** @param areaID: the template for area IDs (will have appended " " + i during the loop)
** @param paintTerrain: whether to paint the area or not
** @param addToClass: whether to add the area to the forest class
** @param avoidSelf: whether to apply the constraint for self-avoidance
*/
void createForestBlobAreas(int numBlobs = 0, string areaID = "", bool paintTerrain = false, bool addToClass = false, bool avoidSelf = true) {
	string type = randomizeForestType();

	for(i = 0; < numBlobs) {
		int blobID = rmCreateArea(areaID + " " + i);

		/*
		 * Applying constraints to all blobs, fake and normal ones, affects the placement as follows:
		 * Due to constraints in the fake blobs, it is possible that they get built, but not as perfect circles.
		 * This is due to the game engine trying to reach the minimum tile count for an area if it's constrained/placed on the edge.
		 * Unfortunately, this means that the area is still built, but not as circle and will cause the fake blob to remain in the shape.
		 * This is one of the reasons why we sometimes see imperfect forests.
		*/
		for(c = 0; < forestConstraintCount) {
			rmAddAreaConstraint(blobID, getForestConstraint(c));
		}

		// Add to class.
		if(addToClass) {
			rmAddAreaToClass(blobID, classFakeForest);
		}

		// Add forest type.
		if(paintTerrain) {
			rmSetAreaForestType(blobID, type);
		}

		// Set other properties.
		if(forestHeight != INF) {
			rmSetAreaBaseHeight(blobID, forestHeight);
		}

		if(forestHeightBlend != -1) {
			rmSetAreaHeightBlend(blobID, forestHeightBlend);
		}

		if(forestSmoothDistance != -1) {
			rmSetAreaSmoothDistance(blobID, forestSmoothDistance);
		}

		// Avoid self if exists.
		if(avoidSelf && forestAvoidSelfID >= 0) {
			rmAddAreaConstraint(blobID, forestAvoidSelfID);
		}
	}
}

/*
** Attempts to randomly place and build a forest from a previously built random shape.
**
** @param numBlobs: the number of blobs to create
** @param player: if set to > 0, the player's location will be used as offset instead of the center of the map (0.5/0.5)
**
** @returns: true if the forest has been built successfully, false otherwise
*/
bool buildForestShape(int numBlobs = 0, int player = 0) {
	// Increase the counter here already because we may return early.
	forestAreaCount++;

	// Create fake blobs.
	createForestBlobAreas(numBlobs, cFakeForestString + " " + forestAreaCount);

	// Randomize angle and radius.
	float radius = getForestLocRadius();
	float angle = getForestLocAngle();

	int numTries = 0;

	while(isForestLocValid(radius, angle, player) == false && numTries < 100) {
		radius = getForestLocRadius();
		angle = getForestLocAngle();
		numTries++;
	}

	if(numTries >= 100) {
		return(false);
	}

	placeRandomShape(radius, angle, cFakeForestString + " " + forestAreaCount, forestBlobSize, forestBlobSpacing, player);

	// Check how many we can build successfully.
	int numBuilt = 0;

	for(i = 0; < numBlobs) {
		if(rmBuildArea(rmAreaID(cFakeForestString + " " + forestAreaCount + " " + i))) {
			numBuilt++;
		} else {
			setBlobForRemoval(i - numBuilt, numBuilt);
		}
	}

	// Return false in case we failed to build the required ratio of blobs.
	if(numBuilt < forestBlobRequiredRatio * numBlobs) {
		return(false);
	}

	// Remove unbuilt blobs if we ended up in a valid state.
	for(i = 0; < numBlobs - numBuilt) {
		removeFullBlob(getBlobForRemoval(i));
	}

	// Define two areas of blobs, the original one and the mirrored one.
	for(i = 0; < 2) {
		createForestBlobAreas(numBuilt, cForestString + " " + forestAreaCount + " " + i, true, true, false);
	}

	// Place the two previously generated areas.
	placeRandomShapeMirrored(radius, angle, cForestString + " " + forestAreaCount, forestBlobSize, forestBlobSpacing, player);

	rmBuildAllAreas();

	return(true);
}

/*
** Attempts to build a number of forests (mirrored) based on the defined parameters and arguments given.
**
** If you need more customized support, feel free to use this and the above function as a template and adjust them to your needs (or provide your own).
**
** @param numForests: the number of forests to build
** @param prog: advances the progress bar by a fraction of the specified value for every forest placed; only keeps the value if progress() was used to advance the bar prior
** @param player: if set to > 0, the player's location will be used as offset instead of the center of the map (0.5/0.5)
** @param numTries: number of attempts to place the desired amount of forests (default 250)
**
** @returns: the number of forests built (and mirrored) successfully
*/
int buildForests(int numForests = 0, float prog = 0.0, int player = 0, int numTries = 250) {
	int numBuilt = 0;

	// Prepare first iteration.
	int numBlobs = rmRandInt(forestMinBlobs, forestMaxBlobs);
	float coherence = rmRandFloat(forestMinCoherence, forestMaxCoherence);

	// Build a random shape.
	createRandomShape(numBlobs, coherence);

	for(i = 0; < numTries) {
		if(buildForestShape(numBlobs, player) == false) {
			continue;
		}

		numBuilt++;
		addProgress(prog / numForests);

		if(numBuilt >= numForests) {
			break;
		}

		// Prepare for next iteration.
		numBlobs = rmRandInt(forestMinBlobs, forestMaxBlobs);
		coherence = rmRandFloat(forestMinCoherence, forestMaxCoherence);

		createRandomShape(numBlobs, coherence);
	}

	return(numBuilt);
}

/*
** Attempts to build a given number of forests around every player according to the previously specified parameters.
** The function iterates over the number of players in the team and places a forest for every player and its mirrored counterpart.
**
** If it should ever be necessary to verify how many forests were successfully built and for which pair of players, make a custom version of this function
** along with a data structure to store the return result of buildForests().
**
** @param numForests: the number of forests to build
** @param prog: advances the progress bar by a fraction of the specified value for every forest placed; only keeps the value if progress() was used to advance the bar prior
** @param numTries: number of attempts to place the desired amount of forests (default 250)
**
** @returns: the number of forests built (and mirrored) successfully
*/
int buildPlayerForests(int numForests = 0, float prog = 0.0, int numTries = 250) {
	int numBuilt = 0;
	int numPlayers = getNumberPlayersOnTeam(0);

	prog = prog / numPlayers;

	for(i = 1; <= numPlayers) {
		if(randChance(0.5)) {
			numBuilt = numBuilt + buildForests(numForests, prog, i);
		} else {
			numBuilt = numBuilt + buildForests(numForests, prog, getMirroredPlayer(i));
		}
	}

	return(numBuilt);
}

/*
** Utility function to create a single mirrored forest based on the specified parameters at a given location.
** Note that this function does not check if a minimum number of blobs can be built and tries to place the areas directly.
**
** @param radius: the radius from the center in meters
** @param angle: the angle in the polar coordinate system
** @param player: if set to > 0, the player's location will be used as offset instead of the center of the map (0.5/0.5)
*/
void buildMirroredForestAtLocation(float radius = 0.0, float angle = 0.0, int player = 0) {
	forestAreaCount++;

	// Randomize blobs and coherence.
	int numBlobs = rmRandInt(forestMinBlobs, forestMaxBlobs);
	float coherence = rmRandInt(forestMinCoherence, forestMaxCoherence);

	// Build a random shape.
	createRandomShape(numBlobs, coherence);

	// Define two areas of blobs, the original one and the mirrored one.
	for(i = 0; < 2) {
		createForestBlobAreas(numBlobs, cForestString + " " + forestAreaCount + " " + i, true, true, false);
	}

	// Place the two previously generated areas.
	placeRandomShapeMirrored(radius, angle, cForestString + " " + forestAreaCount, forestBlobSize, forestBlobSpacing, player);

	rmBuildAllAreas();
}
