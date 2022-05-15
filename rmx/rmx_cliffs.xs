/*
** Default mirrored cliff generation.
** RebelsRising
** Last edit: 20/03/2022
*/

include "rmx_forests.xs";

/************
* CONSTANTS *
************/

const string cCliffClassString = "rmx cliff class";

const string cInnerCliffString = "rmx inner cliff";
const string cOuterCliffString = "rmx outer cliff";
const string cRampCliffString = "rmx ramp cliff";
const string cFakeCliffString = "rmx fake cliff";

const int cCliffTypeFake = -1;
const int cCliffTypeInner = 0;
const int cCliffTypeOuter = 1;
const int cCliffTypeRamp = 2;

/********
* RAMPS *
********/

// Near blobs for ramp ID list.
int rampListSize = 0;

int rampID0 = 0; int rampID1 = 0; int rampID2  = 0; int rampID3  = 0;
int rampID4 = 0; int rampID5 = 0; int rampID6  = 0; int rampID7  = 0;
int rampID8 = 0; int rampID9 = 0; int rampID10 = 0; int rampID11 = 0;

int getRampID(int i = -1) {
	if(i == 0) return(rampID0); if(i == 1) return(rampID1); if(i == 2)  return(rampID2);  if(i == 3)  return(rampID3);
	if(i == 4) return(rampID4); if(i == 5) return(rampID5); if(i == 6)  return(rampID6);  if(i == 7)  return(rampID7);
	if(i == 8) return(rampID8); if(i == 9) return(rampID9); if(i == 10) return(rampID10); if(i == 11) return(rampID11);
	return(0);
}

void setRampID(int i = 0, int id = 0) {
	if(i == 0) rampID0 = id; if(i == 1) rampID1 = id; if(i == 2)  rampID2  = id; if(i == 3)  rampID3  = id;
	if(i == 4) rampID4 = id; if(i == 5) rampID5 = id; if(i == 6)  rampID6  = id; if(i == 7)  rampID7  = id;
	if(i == 8) rampID8 = id; if(i == 9) rampID9 = id; if(i == 10) rampID10 = id; if(i == 11) rampID11 = id;
}

/*
** Calculates one of the possible adjacent blobs.
** This is important for ramps as we need 2 blobs to form a ramp - 1 may not grant access if we have a corner blob.
**
** @param currX: the x value (on the shape grid!) of the blob to find the next blob for
** @param currZ: the z value (on the shape grid!) of the blob to find the next blob for
**
** @returns: the ID of the chosen blob
*/
int getNextBlobID(int currX = 0, int currZ = 0) {
	float shortest = INF;
	int blobID = -1;

	// Go through the entire list of near blobs.
	for(i = 0; < getStateSize(cBlobNear)) {
		int nextX = getBlobX(i, cBlobNear);
		int nextZ = getBlobZ(i, cBlobNear);

		if(nextX == currX && nextZ == currZ) {
			continue; // Skip current.
		}

		// Calculate the distance between the current blob and the potential neighbor.
		float dist = pointsGetDist(currX, currZ, nextX, nextZ);

		// Keep the blob if it's closest to the current blob.
		if(abs(dist - shortest) < TOL) {

			// Same distance as the blob currently selected (blobID), pick the one that is further away to catch corner blobs.
			if(pointsGetDist(nextX, nextZ, 0.0, 0.0) > pointsGetDist(getBlobX(blobID, cBlobNear), getBlobZ(blobID, cBlobNear), 0.0, 0.0)) {
				blobID = i;
			}

		} else if(dist < shortest) {

			shortest = dist;
			blobID = i;

		}
	}

	return(blobID);
}

/*
** Tries to add a new ramp ID (near blob) to the list.
** The ID must not be already present and pass the check for not being too close (angle) to the IDs already in the list.
**
** @param rampID: the ID of the near blob that should be added
** @param minAngle: the minimum angle the blob must be away from all other blobs in the list
**
** @returns: true on success, false otherwise
*/
bool addRampToList(int rampID = -1, float minAngle = 0.0) {
	float blobX = getBlobX(rampID, cBlobNear);
	float blobZ = getBlobZ(rampID, cBlobNear);
	float blobAngle = getAngleFromCartesian(blobX, blobZ, 0.0, 0.0);

	for(i = 0; < rampListSize) {
		int currID = getRampID(i);

		// Return early if the ID is already in the list.
		if(rampID == currID) {
			return(false);
		}

		// Cet the current angle.
		float currX = getBlobX(currID, cBlobNear);
		float currZ = getBlobZ(currID, cBlobNear);
		float currAngle = getAngleFromCartesian(currX, currZ, 0.0, 0.0);

		float diff = 0.0;

		// Calculate the difference of the angles depending on which angle comes "first".
		if(currAngle < blobAngle) {
			// currAngle first.
			diff = min(blobAngle - currAngle, 2.0 * PI - (blobAngle - currAngle));
		} else {
			// blobAngle first.
			diff = min(currAngle - blobAngle, 2.0 * PI - (currAngle - blobAngle));
		}

		if(diff < minAngle) {
			return(false);
		}
	}

	// Succeeded.
	setRampID(rampListSize, rampID);
	rampListSize++;

	/*
	 * Also add close blob to it so that the ramps will always grant access.
	 * Otherwise we may end up with a single corner blob.
	 * Note that this blob will not adhere to the angle restrictions set above.
	*/
	setRampID(rampListSize, getNextBlobID(blobX, blobZ));
	rampListSize++;

	return(true);
}

/*
** Resets the list of ramp IDs.
** Note that this does not reset the IDs as they are only being read if they were rewritten since this function was called last.
*/
void resetRampList() {
	rampListSize = 0;
}

/**************
* CONSTRAINTS *
**************/

// Cliff constraints.
int cliffConstraintCount = 0;

int cliffConstraint0 = 0; int cliffConstraint1 = 0; int cliffConstraint2  = 0; int cliffConstraint3  = 0;
int cliffConstraint4 = 0; int cliffConstraint5 = 0; int cliffConstraint6  = 0; int cliffConstraint7  = 0;
int cliffConstraint8 = 0; int cliffConstraint9 = 0; int cliffConstraint10 = 0; int cliffConstraint11 = 0;

int getCliffConstraint(int i = 0) {
	if(i == 0) return(cliffConstraint0); if(i == 1) return(cliffConstraint1); if(i == 2)  return(cliffConstraint2);  if(i == 3)  return(cliffConstraint3);
	if(i == 4) return(cliffConstraint4); if(i == 5) return(cliffConstraint5); if(i == 6)  return(cliffConstraint6);  if(i == 7)  return(cliffConstraint7);
	if(i == 8) return(cliffConstraint8); if(i == 9) return(cliffConstraint9); if(i == 10) return(cliffConstraint10); if(i == 11) return(cliffConstraint11);
	return(0);
}

void setCliffConstraint(int i = 0, int cID = 0) {
	if(i == 0) cliffConstraint0 = cID; if(i == 1) cliffConstraint1 = cID; if(i == 2)  cliffConstraint2  = cID; if(i == 3)  cliffConstraint3  = cID;
	if(i == 4) cliffConstraint4 = cID; if(i == 5) cliffConstraint5 = cID; if(i == 6)  cliffConstraint6  = cID; if(i == 7)  cliffConstraint7  = cID;
	if(i == 8) cliffConstraint8 = cID; if(i == 9) cliffConstraint9 = cID; if(i == 10) cliffConstraint10 = cID; if(i == 11) cliffConstraint11 = cID;
}

/*
** Resets cliff constraints.
*/
void resetCliffConstraints() {
	cliffConstraintCount = 0;
}

/*
** Adds a constraint to the cliff constraints.
** Note that these should NOT include constraints that makes cliffs avoid themselves or the behavior of the algorithm is undefined!
**
** @param cID: the ID of the constraint
*/
void addCliffConstraint(int cID = 0) {
	setCliffConstraint(cliffConstraintCount, cID);

	cliffConstraintCount++;
}

/*************
* PARAMETERS *
*************/

// Settings for outer cliffs.
string outerTerrainType = "";
float outerBlobSize = 0.0;
float outerBlobSpacing = 0.0;

float outerHeight = INF;
int outerSmoothDistance = -1;
int outerHeightBlend = -1;

/*
** Sets the parameters for the outer part of the cliffs.
**
** @param terrainType: the terrain to use (can also be impassable terrain like CliffEgyptianA)
** @param blobSize: the radius of the blob in meters
** @param blobSpacing: the distance between the blobs in meters (independent of blob radius)
*/
void setOuterCliff(string terrainType = "", float blobSize = 0.0, float blobSpacing = 0.0) {
	outerTerrainType = terrainType;
	outerBlobSize = blobSize;
	outerBlobSpacing = blobSpacing;
}

/*
** Sets additional parameters for outer cliffs.
**
** @param height: the area height
** @param heightBlend: the hight blend parameter (0, 1 or 2) for areas
** @param smoothDistance: the smooth distance for areas
*/
void setOuterCliffParams(float height = INF, int heightBlend = -1, int smoothDistance = -1) {
	outerHeight = height;
	outerSmoothDistance = smoothDistance;
	outerHeightBlend = heightBlend;
}

// Settings for inner cliffs.
string innerTerrainType = "";
float innerBlobSize = 0.0;
float innerBlobSpacing = 0.0;
string innerCliffType = "";

float innerHeight = INF;
int innerSmoothDistance = -1;
int innerHeightBlend = -1;

/*
** Sets the parameters for the inner part of the cliffs.
** Has the cliffType as optional argument since the first
**
** @param terrainType: the terrain to use (can also be impassable terrain like CliffEgyptianA)
** @param blobSize: the radius of the blob in meters
** @param blobSpacing: the distance between the blobs in meters (independent of blob radius)
** @param cliffType: sets the cliff type; this will use rmSetAreaCliffType() instead of just a regular area, should be used if no outer cliff is needed
*/
void setInnerCliff(string terrainType = "", float blobSize = 0.0, float blobSpacing = 0.0, string cliffType = "") {
	innerTerrainType = terrainType;
	innerBlobSize = blobSize;
	innerBlobSpacing = blobSpacing;
	innerCliffType = cliffType;
}

/*
** Sets additional parameters for inner cliffs.
**
** @param height: the area height
** @param heightBlend: the hight blend parameter (0, 1 or 2) for areas
** @param smoothDistance: the smooth distance for areas
*/
void setInnerCliffParams(float height = INF, int heightBlend = -1, int smoothDistance = -1) {
	innerHeight = height;
	innerSmoothDistance = smoothDistance;
	innerHeightBlend = heightBlend;
}

// Settings for ramps.
string rampTerrainType = "";
float rampBlobSize = 0.0;
float rampBlobSpacing = 0.0;

float rampHeight = INF;
int rampSmoothDistance = -1;
int rampHeightBlend = -1;

/*
** Sets the parameters for ramps.
**
** @param terrainType: the terrain to use (can also be impassable terrain like CliffEgyptianA)
** @param blobSize: the radius of the blob in meters
** @param blobSpacing: the distance between the blobs in meters (independent of blob radius)
*/
void setCliffRamp(string terrainType = "", float blobSize = 0.0, float blobSpacing = 0.0) {
	rampTerrainType = terrainType;
	rampBlobSize = blobSize;
	rampBlobSpacing = blobSpacing;
}

/*
** Sets additional parameters for the ramps.
**
** @param height: the area height
** @param heightBlend: the hight blend parameter (0, 1 or 2) for areas
** @param smoothDistance: the smooth distance for areas
*/
void setCliffRampParams(float height = INF, int heightBlend = -1, int smoothDistance = -1) {
	rampHeight = height;
	rampSmoothDistance = smoothDistance;
	rampHeightBlend = heightBlend;
}

/*
** Getter for terrain type by cliff type.
**
** @param type: the type (one of cCliffTypeFake, cCliffTypeInner, cCliffTypeOuter, cCliffTypeRamp)
**
** @returns: the terrain type
*/
string cliffGetTerrainType(int type = cCliffTypeFake) {
	if(type == cCliffTypeInner) {
		return(innerTerrainType);
	} else if(type == cCliffTypeOuter) {
		return(outerTerrainType);
	} else if(type == cCliffTypeRamp) {
		return(rampTerrainType);
	}

	return("");
}

/*
** Getter for height by cliff type.
**
** @param type: the type (one of cCliffTypeFake, cCliffTypeInner, cCliffTypeOuter, cCliffTypeRamp)
**
** @returns: the height value
*/
float cliffGetHeight(int type = cCliffTypeFake) {
	if(type == cCliffTypeInner) {
		return(innerHeight);
	} else if(type == cCliffTypeOuter) {
		return(outerHeight);
	} else if(type == cCliffTypeRamp) {
		return(rampHeight);
	}

	return(2.0);
}

/*
** Getter for height blend by cliff type.
**
** @param type: the type (one of cCliffTypeFake, cCliffTypeInner, cCliffTypeOuter, cCliffTypeRamp)
**
** @returns: the height blend value
*/
int cliffGetHeightBlend(int type = cCliffTypeFake) {
	if(type == cCliffTypeInner) {
		return(innerHeightBlend);
	} else if(type == cCliffTypeOuter) {
		return(outerHeightBlend);
	} else if(type == cCliffTypeRamp) {
		return(rampHeightBlend);
	}

	return(0);
}

/*
** Getter for smooth distance by cliff type.
**
** @param type: the type (one of cCliffTypeFake, cCliffTypeInner, cCliffTypeOuter, cCliffTypeRamp)
**
** @returns: the smooth distance value
*/
int cliffGetSmoothDistance(int type = cCliffTypeFake) {
	if(type == cCliffTypeInner) {
		return(innerSmoothDistance);
	} else if(type == cCliffTypeOuter) {
		return(outerSmoothDistance);
	} else if(type == cCliffTypeRamp) {
		return(rampSmoothDistance);
	}

	return(0);
}

// Cliff settings.
// Used to keep track of the cliff class (if we need multiple classes).
int cliffClassCount = -1;

// Counter for the number of areas so we don't run out of names.
int cliffAreaCount = -1; // -1 since we increment before using the value.

// Default settings.
int classFakeCliff = -1; // Set by initCliffClass().

int cliffMinBlobs = 0;
int cliffMaxBlobs = 0;

int cliffMinRamps = 0;
int cliffMaxRamps = 0;

float cliffBlobRequiredRatio = 1.0;

float cliffMinCoherence = -1.0;
float cliffMaxCoherence = 1.0;

float cliffMinRadius = 20.0;
float cliffMaxRadius = -1.0;

float cliffMinAngle = NPI;
float cliffMaxAngle = PI;

// Constraint for self avoidance.
int cliffAvoidSelfID = -1;

// Whether to enforce constraints.
bool cliffEnforceConstraints = false;

/*
** Sets a constraint for cliffs to avoid themselves.
** This is necessary because real cliff blobs won't spawn if they have this constraint applied when being built.
**
** @param dist: distance in meters for cliffs to avoid each other
*/
void setCliffAvoidSelf(float dist = 0.0) {
	if(dist > 0.0) {
		cliffAvoidSelfID = createClassDistConstraint(classFakeCliff, dist);
	} else {
		cliffAvoidSelfID = -1;
	}
}

/*
** Can be set to either enforce constraints not just for fake blobs (at the cost of precision) or to not do so.
**
** @param enforce: true to enforce constraints, false otherwise
*/
void setCliffEnforceConstraints(bool enforce = false) {
	cliffEnforceConstraints = enforce;
}

/*
** Sets a minimum and maximum number of blobs for the cliffs.
**
** @param minBlobs: minimum number of blobs
** @param maxBlobs: maximum number of blobs, will be adjusted to minBlobs if not set
*/
void setCliffBlobs(int minBlobs = 0, int maxBlobs = -1) {
	if(maxBlobs < 0) {
		maxBlobs = minBlobs;
	}

	cliffMinBlobs = minBlobs;
	cliffMaxBlobs = maxBlobs;
}

/*
** Sets a minimum and maximum number of ramps for the cliffs.
**
** @param minRamps: minimum number of ramps
** @param maxRamps: maximum number of ramps, will be adjusted to minRamps if not set
*/
void setCliffNumRamps(int minRamps = 0, int maxRamps = -1) {
	if(maxRamps < 0) {
		maxRamps = minRamps;
	}

	cliffMinRamps = minRamps;
	cliffMaxRamps = maxRamps;
}

/*
** Sets the required ratio for an area to be built.
**
** @param requiredRatio: the minimum ratio of blobs successfully built required to build the entire area
*/
void setCliffRequiredRatio(float requiredRatio = 1.0) {
	cliffBlobRequiredRatio = requiredRatio;
}

/*
** Sets a minimum and maximum coherence (compactness) for cliffs to randomize from.
**
** @param minCoherence: mimumum coherence (smallest possible value: -1.0), linear areas
** @param maxCoherence: maximum coherence (largest possible value: 1.0), circular areas
*/
void setCliffCoherence(float minCoherence = -1.0, float maxCoherence = 1.0) {
	cliffMinCoherence = minCoherence;
	cliffMaxCoherence = maxCoherence;
}

/*
** Sets a minimum and maximum radius in meters to consider when placing cliffs.
** Note that the default of -1.0 will be overwritten with the radius from the center to the corner at cliff generation time.
**
** @param minRadius: minimum radius in meters to randomize
** @param maxRadius: maximum radius in meters to randomize (-1.0 = up to corners)
*/
void setCliffSearchRadius(float minRadius = 20.0, float maxRadius = -1.0) {
	cliffMinRadius = minRadius;
	cliffMaxRadius = maxRadius;
}

/*
** Sets a minimum and maximum angle in radians to consider when placing cliffs.
**
** @param minRadius: minimum angle in radians to randomize
** @param maxRadius: maximum angle in radians to randomize
*/
void setCliffSearchAngle(float minAngle = NPI, float maxAngle = PI) {
	cliffMinAngle = minAngle;
	cliffMaxAngle = maxAngle;
}

/*
** Resets cliff settings and restores defaults.
*/
void resetCliffs() {
	classFakeCliff = -1;

	resetCliffConstraints();

	setInnerCliff();
	setInnerCliffParams();
	setOuterCliff();
	setOuterCliffParams();
	setCliffRamp();
	setCliffRampParams();

	setCliffBlobs();
	setCliffCoherence();
	setCliffNumRamps();
	setCliffSearchRadius();
	setCliffSearchAngle();
	setCliffAvoidSelf();
	setCliffEnforceConstraints();
	setCliffRequiredRatio();
}

/*******************
* CLIFF GENERATION *
*******************/

/*
** Initializes the cliff class.
**
** @param clazz: use an existing class for the ponds instead of a new one if set
**
** @returns: the ID of the created class (can be used to set constraints!)
*/
int initCliffClass(int clazz = -1) {
	if(clazz == -1) {
		classFakeCliff = rmDefineClass(cCliffClassString + " " + cliffClassCount);
		cliffClassCount++;
	} else {
		classFakeCliff = clazz;
	}

	return(classFakeCliff);
}

/*
** Randomizes a radius while considering a cliffMaxRadius of -1.0.
**
** @returns: the randomized cliff radius in meters
*/
float getCliffLocRadius() {
	// Adjust maximum radius if necessary (i.e., set to < 0).
	if(cliffMaxRadius < 0) {
		cliffMaxRadius = largerFractionToMeters(HALF_SQRT_2);
	}

	return(rmRandFloat(cliffMinRadius, cliffMaxRadius));
}

/*
** Randomizes an angle from the specified range.
**
** @returns: the randomized cliff angle
*/
float getCliffLocAngle() {
	return(rmRandFloat(cliffMinAngle, cliffMaxAngle));
}

/*
** Checks if the location for a cliff is valid.
**
** @param radius: the radius in meters
** @param angle: the angle in the polar coordinate system
** @param player: if set to > 0, the player's location will be used as offset instead of the center of the map (0.5/0.5)
*/
bool isCliffLocValid(float radius = 0.0, float angle = 0.0, int player = 0) {
	// Require the center of the area to avoid the egde by at least the radius of the inner blob.
	float tolX = rmXMetersToFraction(innerBlobSize);
	float tolZ = rmZMetersToFraction(innerBlobSize);

	float x = getXFromPolarForPlayer(player, rmXMetersToFraction(radius), angle);
	float z = getZFromPolarForPlayer(player, rmZMetersToFraction(radius), angle);

	return(isLocValid(x, z, tolX, tolZ));
}

/*
** Places the areas for the inner part of the cliff. Both areas must be defined (normal and mirrored).
** Note that we place the near blobs here and take them as border for the cliff.
**
** @param radius: the radius in the polar coordinate system
** @param angle: the angle in the polar coordinate system
** @param player: if set to > 0, the player's location will be used as offset instead of the center of the map (0.5/0.5)
*/
void placeOuterCliffShape(float radius = 0.0, float angle = 0.0, int player = 0) {
	// Convert radius to fraction.
	radius = smallerMetersToFraction(radius);

	// Mirrored player and adjusted angle
	int mirrorPlayer = getMirroredPlayer(player);
	float mirrorAngle = getMirrorAngleForShape(angle, mirrorPlayer == 0);

	// Place original shape.
	for(i = 0; < getStateSize(cBlobNear)) {
		int x = getBlobX(i, cBlobNear);
		int z = getBlobZ(i, cBlobNear);

		// Original shape.
		placeBlob(radius, angle, rmAreaID(cOuterCliffString + " " + cliffAreaCount + " " + 0 + " " + i), outerBlobSize, outerBlobSpacing, 0.0 + x, 0.0 + z, player);

		// Mirrored shape.
		if(getMirrorMode() == cMirrorPoint) {
			placeBlob(radius, mirrorAngle, rmAreaID(cOuterCliffString + " " + cliffAreaCount + " " + 1 + " " + i), outerBlobSize, outerBlobSpacing, 0.0 + x, 0.0 + z, mirrorPlayer);
		} else {
			/*
			 * By axis requires the inversion of the z axis of the shape grid.
			 * We don't invert the x axis here because we always want the same part of the shape to point towards the inside.
			 * While this may not sound very intuitive, if you draw a shape and try to rotate it and then mirror it, it will make sense.
			*/
			placeBlob(radius, mirrorAngle, rmAreaID(cOuterCliffString + " " + cliffAreaCount + " " + 1 + " " + i), outerBlobSize, outerBlobSpacing, 0.0 + x, 0.0 - z, mirrorPlayer);
		}
	}
}

/*
** Places the areas for the inner part of the cliff. Both areas must be defined (normal and mirrored).
** Note that this uses some of the near blobs and overwrites them with textures according to the defined ramp parameters.
**
** @param numRamps: the number of ramp areas to place
** @param radius: the radius in the polar coordinate system
** @param angle: the angle in the polar coordinate system
** @param player: if set to > 0, the player's location will be used as offset instead of the center of the map (0.5/0.5)
*/
void placeRampCliffShape(int numRamps = 0, float radius = 0.0, float angle = 0.0, int player = 0) {
	// Convert radius to fraction.
	radius = smallerMetersToFraction(radius);

	// Mirrored player and adjusted angle
	int mirrorPlayer = getMirroredPlayer(player);
	float mirrorAngle = getMirrorAngleForShape(angle, mirrorPlayer == 0);

	// Place original shape.
	for(i = 0; < numRamps) {
		int x = getBlobX(getRampID(i), cBlobNear);
		int z = getBlobZ(getRampID(i), cBlobNear);

		// Original shape.
		placeBlob(radius, angle, rmAreaID(cRampCliffString + " " + cliffAreaCount + " " + 0 + " " + i), rampBlobSize, rampBlobSpacing, 0.0 + x, 0.0 + z, player);

		// Mirrored shape.
		if(getMirrorMode() == cMirrorPoint) {
			placeBlob(radius, mirrorAngle, rmAreaID(cRampCliffString + " " + cliffAreaCount + " " + 1 + " " + i), rampBlobSize, rampBlobSpacing, 0.0 + x, 0.0 + z, mirrorPlayer);
		} else {
			/*
			 * By axis requires the inversion of the z axis of the shape grid.
			 * We don't invert the x axis here because we always want the same part of the shape to point towards the inside.
			 * While this may not sound very intuitive, if you draw a shape and try to rotate it and then mirror it, it will make sense.
			*/
			placeBlob(radius, mirrorAngle, rmAreaID(cRampCliffString + " " + cliffAreaCount + " " + 1 + " " + i), rampBlobSize, rampBlobSpacing, 0.0 + x, 0.0 - z, mirrorPlayer);
		}
	}
}

/*
** Creates blob areas for cliffs according to given settings.
**
** @param numBlobs: the number of blobs to create areas for
** @param areaID: the template for area IDs (will have appended " " + i during the loop)
** @param type: the type (one of cCliffTypeFake, cCliffTypeInner, cCliffTypeOuter, cCliffTypeRamp)
** @param addToClass: whether to add the area to the cliff class
** @param avoidSelf: whether to apply the constraint for self-avoidance
*/
void createCliffBlobAreas(int numBlobs = 0, string areaID = "", int type = cCliffTypeFake, bool addToClass = false, bool avoidSelf = true) {
	for(i = 0; < numBlobs) {
		int blobID = rmCreateArea(areaID + " " + i);

		// Add to class.
		if(addToClass) {
			rmAddAreaToClass(blobID, classFakeCliff);
		}

		// Avoid self if exists.
		if(avoidSelf && cliffAvoidSelfID >= 0) {
			rmAddAreaConstraint(blobID, cliffAvoidSelfID);
		}

		// Add constraints for fake cliffs or if enforced.
		if(cliffEnforceConstraints == true || type == cCliffTypeFake) {
			for(c = 0; < cliffConstraintCount) {
				rmAddAreaConstraint(blobID, getCliffConstraint(c));
				// rmSetAreaTerrainType(blobID, "SnowA");
			}
		}

		// Specific things first.
		if(type == cCliffTypeFake) {
			continue;
		} else if(type == cCliffTypeInner && innerCliffType != "") {
			rmSetAreaCliffType(blobID, innerCliffType);
			rmSetAreaCliffEdge(blobID, 1, 1.0, 0.0, 0.0, 0);
			rmSetAreaCliffPainting(blobID, true, false, true, 1.5, false);
		}

		// Generic things.
		string terrain = cliffGetTerrainType(type);
		float height = cliffGetHeight(type);
		int heightBlend = cliffGetHeightBlend(type);
		int smoothDistance = cliffGetSmoothDistance(type);

		if(terrain != "") {
			rmSetAreaTerrainType(blobID, terrain);
		}

		if(height != INF) {
			rmSetAreaBaseHeight(blobID, height);
		}

		if(heightBlend > -1) {
			rmSetAreaHeightBlend(blobID, heightBlend);
		}

		if(smoothDistance > 0) {
			rmSetAreaSmoothDistance(blobID, smoothDistance);
		}
	}
}

/*
** Attempts to randomly place and build a cliff from a previously built random shape.
**
** @param numBlobs: the number of blobs to create
** @param player: if set to > 0, the player's location will be used as offset instead of the center of the map (0.5/0.5)
**
** @returns: true if the cliff has been built successfully, false otherwise
*/
bool buildCliffShape(int numBlobs = 0, int player = 0) {
	// Increase the counter here already because we may return early.
	cliffAreaCount++;

	// Create fake blobs.
	createCliffBlobAreas(numBlobs, cFakeCliffString + " " + cliffAreaCount, cCliffTypeFake);

	// Randomize angle and radius.
	float radius = getCliffLocRadius();
	float angle = getCliffLocAngle();

	int numTries = 0;

	while(isCliffLocValid(radius, angle, player) == false && numTries < 100) {
		radius = getCliffLocRadius();
		angle = getCliffLocAngle();
		numTries++;
	}

	if(numTries >= 100) {
		return(false);
	}

	placeRandomShape(radius, angle, cFakeCliffString + " " + cliffAreaCount, innerBlobSize, innerBlobSpacing, player);

	// Check how many we can build successfully.
	int numBuilt = 0;

	for(i = 0; < numBlobs) {
		if(rmBuildArea(rmAreaID(cFakeCliffString + " " + cliffAreaCount + " " + i))) {
			numBuilt++;
		} else {
			setBlobForRemoval(i - numBuilt, numBuilt);
		}
	}

	// Return false in case we failed to build the required ratio of blobs.
	if(numBuilt < cliffBlobRequiredRatio * numBlobs) {
		return(false);
	}

	// Remove unbuilt blobs if we ended up in a valid state.
	for(i = 0; < numBlobs - numBuilt) {
		removeFullBlob(getBlobForRemoval(i));
	}

	// Place outer cliffs.
	for(i = 0; < 2) {
		createCliffBlobAreas(getStateSize(cBlobNear), cOuterCliffString + " " + cliffAreaCount + " " + i, cCliffTypeOuter, true, false);
	}

	placeOuterCliffShape(radius, angle, player);

	rmBuildAllAreas();

	// Place inner cliffs.
	for(i = 0; < 2) {
		createCliffBlobAreas(numBuilt, cInnerCliffString + " " + cliffAreaCount + " " + i, cCliffTypeInner, true, false);
	}

	placeRandomShapeMirrored(radius, angle, cInnerCliffString + " " + cliffAreaCount, innerBlobSize, innerBlobSpacing, player);

	rmBuildAllAreas();

	// Place ramps.
	resetRampList();

	numTries = 0;
	int succ = 0; // Could also use rampListSize here but better stay in scope for readability.
	int numRamps = rmRandInt(cliffMinRamps, cliffMaxRamps);

	// Randomize new entry in case its already present in the list.
	while(succ < numRamps && numTries < 100) {
		/*
		 * Try to add a new blob to the list of ramps.
		 * Use PI / numRamps as minimum angle to separate ramps; 2.0 * PI / numRamps would be exact.
		 * However, this would scale poorly and create artificial results.
		*/
		if(addRampToList(rmRandInt(0, getStateSize(cBlobNear) - 1), PI / numRamps)) {
			succ++;
		}

		numTries++;
	}

	// Place ramps.
	for(i = 0; < 2) {
		createCliffBlobAreas(rampListSize, cRampCliffString + " " + cliffAreaCount + " " + i, cCliffTypeRamp, true, false);
	}

	placeRampCliffShape(rampListSize, radius, angle, player);

	rmBuildAllAreas();

	return(true);
}

/*
** Attempts to build a number of cliffs (mirrored) based on the defined parameters and arguments given.
**
** If you need more customized support, feel free to use this and the above function as a template and adjust them to your needs (or provide your own).
**
** @param numCliffs: the number of cliffs to build
** @param prog: advances the progress bar by a fraction of the specified value for every cliff placed; only keeps the value if progress() was used to advance the bar prior
** @param player: if set to > 0, the player's location will be used as offset instead of the center of the map (0.5/0.5)
** @param numTries: number of attempts to place the desired amount of cliffs (default 250)
**
** @returns: the number of cliffs built (and mirrored) successfully
*/
int buildCliffs(int numCliffs = 0, float prog = 0.0, int player = 0, int numTries = 250) {
	int numBuilt = 0;

	// Prepare first iteration.
	int numBlobs = rmRandInt(cliffMinBlobs, cliffMaxBlobs);
	float coherence = rmRandFloat(cliffMinCoherence, cliffMaxCoherence);

	// Build a random shape.
	createRandomShape(numBlobs, coherence);

	for(i = 0; < numTries) {
		if(buildCliffShape(numBlobs, player) == false) {
			continue;
		}

		numBuilt++;
		addProgress(prog / numCliffs);

		if(numBuilt >= numCliffs) {
			break;
		}

		// Prepare for next iteration.
		numBlobs = rmRandInt(cliffMinBlobs, cliffMaxBlobs);
		coherence = rmRandFloat(cliffMinCoherence, cliffMaxCoherence);

		createRandomShape(numBlobs, coherence);
	}

	return(numBuilt);
}

/*
** Attempts to build a given number of mirrored cliffs around every player according to the previously specified parameters.
** The function iterates over the number of players in the team and places a cliff for every player and their mirrored counterpart.
**
** If it should ever be necessary to verify how many cliffs were successfully built and for which pair of players, make a custom version of this function
** along with a data structure to store the return result of buildCliffs().
**
** @param numCliffs: the number of cliffs to build
** @param prog: advances the progress bar by a fraction of the specified value for every area placed; if using this, make sure you use progress() instead of rmSetStatusText()
** @param numTries: number of attempts to place the desired amount of cliffs (default 250)
**
** @returns: the number of cliffs built (and mirrored) successfully
*/
int buildPlayerCliffs(int numCliffs = 0, float prog = 0.0, int numTries = 250) {
	int numBuilt = 0;
	int numPlayers = getNumberPlayersOnTeam(0);

	prog = prog / numPlayers;

	for(i = 1; <= numPlayers) {
		if(randChance(0.5)) {
			numBuilt = numBuilt + buildCliffs(numCliffs, prog, i, numTries);
		} else {
			numBuilt = numBuilt + buildCliffs(numCliffs, prog, getMirroredPlayer(i), numTries);
		}
	}

	return(numBuilt);
}

/*
** Utility function to create a single mirrored cliff based on the specified parameters at a given location.
** Note that this function does not check if a minimum number of blobs can be built and tries to place the areas directly.
**
** @param radius: the radius from the center in meters
** @param angle: the angle in the polar coordinate system
** @param player: if set to > 0, the player's location will be used as offset instead of the center of the map (0.5/0.5)
*/
void buildMirroredCliffAtLocation(float radius = 0.0, float angle = 0.0, int player = 0) {
	cliffAreaCount++;

	// Randomize blobs and coherence.
	int numBlobs = rmRandInt(cliffMinBlobs, cliffMaxBlobs);
	float coherence = rmRandInt(cliffMinCoherence, cliffMaxCoherence);

	// Build a random shape.
	createRandomShape(numBlobs, coherence);

	// Place outer cliffs.
	for(i = 0; < 2) {
		createCliffBlobAreas(getStateSize(cBlobNear), cOuterCliffString + " " + cliffAreaCount + " " + i, cCliffTypeOuter, true, false);
	}

	placeOuterCliffShape(radius, angle, player);

	rmBuildAllAreas();

	// Place inner cliffs.
	for(i = 0; < 2) {
		createCliffBlobAreas(numBlobs, cInnerCliffString + " " + cliffAreaCount + " " + i, cCliffTypeInner, true, false);
	}

	placeRandomShapeMirrored(radius, angle, cInnerCliffString + " " + cliffAreaCount, innerBlobSize, innerBlobSpacing, player);

	rmBuildAllAreas();

	// Place ramps.
	resetRampList();

	int numTries = 0;
	int succ = 0; // Could also use rampListSize here but better stay in scope for readability.
	int numRamps = rmRandInt(cliffMinRamps, cliffMaxRamps);

	// Randomize new entry in case its already present in the list.
	while(succ < numRamps && numTries < 100) {
		if(addRampToList(rmRandInt(0, getStateSize(cBlobNear) - 1), PI / numRamps)) {
			succ++;
		}

		numTries++;
	}

	// Place ramps.
	for(i = 0; < 2) {
		createCliffBlobAreas(rampListSize, cRampCliffString + " " + cliffAreaCount + " " + i, cCliffTypeRamp, true, false);
	}

	placeRampCliffShape(rampListSize, radius, angle, player);

	rmBuildAllAreas();
}
