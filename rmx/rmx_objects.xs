/*
** Object storage arrays and object placement.
** RebelsRising
** Last edit: 07/03/2021
*/

include "rmx_cliffs.xs";

/*****************
* OBJECT STORAGE *
*****************/

/*
 * Arrays to store object information that is otherwise stroed in object IDs.
 * Particularily useful if you need to create multiple identical object definitions and then apply separate/different constraints,
 * like when placing objects near different locations for every player (e.g., near starting towers).
*/

// Proto unit.
string objectStorageProto0 = ""; string objectStorageProto1 = ""; string objectStorageProto2  = ""; string objectStorageProto3  = "";
string objectStorageProto4 = ""; string objectStorageProto5 = ""; string objectStorageProto6  = ""; string objectStorageProto7  = "";
string objectStorageProto8 = ""; string objectStorageProto9 = ""; string objectStorageProto10 = ""; string objectStorageProto11 = "";

string getObjectStorageProto(int i = -1) {
	if(i == 0) return(objectStorageProto0); if(i == 1) return(objectStorageProto1); if(i == 2)  return(objectStorageProto2);  if(i == 3)  return(objectStorageProto3);
	if(i == 4) return(objectStorageProto4); if(i == 5) return(objectStorageProto5); if(i == 6)  return(objectStorageProto6);  if(i == 7)  return(objectStorageProto7);
	if(i == 8) return(objectStorageProto8); if(i == 9) return(objectStorageProto9); if(i == 10) return(objectStorageProto10); if(i == 11) return(objectStorageProto11);
	return("");
}

void setObjectStorageProto(int i = -1, string proto = "") {
	if(i == 0) objectStorageProto0 = proto; if(i == 1) objectStorageProto1 = proto; if(i == 2)  objectStorageProto2  = proto; if(i == 3)  objectStorageProto3  = proto;
	if(i == 4) objectStorageProto4 = proto; if(i == 5) objectStorageProto5 = proto; if(i == 6)  objectStorageProto6  = proto; if(i == 7)  objectStorageProto7  = proto;
	if(i == 8) objectStorageProto8 = proto; if(i == 9) objectStorageProto9 = proto; if(i == 10) objectStorageProto10 = proto; if(i == 11) objectStorageProto11 = proto;
}

// Count.
int objectStorageItemCount0 = 0; int objectStorageItemCount1 = 0; int objectStorageItemCount2  = 0; int objectStorageItemCount3  = 0;
int objectStorageItemCount4 = 0; int objectStorageItemCount5 = 0; int objectStorageItemCount6  = 0; int objectStorageItemCount7  = 0;
int objectStorageItemCount8 = 0; int objectStorageItemCount9 = 0; int objectStorageItemCount10 = 0; int objectStorageItemCount11 = 0;

int getObjectStorageItemCount(int i = -1) {
	if(i == 0) return(objectStorageItemCount0); if(i == 1) return(objectStorageItemCount1); if(i == 2)  return(objectStorageItemCount2);  if(i == 3)  return(objectStorageItemCount3);
	if(i == 4) return(objectStorageItemCount4); if(i == 5) return(objectStorageItemCount5); if(i == 6)  return(objectStorageItemCount6);  if(i == 7)  return(objectStorageItemCount7);
	if(i == 8) return(objectStorageItemCount8); if(i == 9) return(objectStorageItemCount9); if(i == 10) return(objectStorageItemCount10); if(i == 11) return(objectStorageItemCount11);
	return(0);
}

void setObjectStorageItemCount(int i = -1, int count = 0) {
	if(i == 0) objectStorageItemCount0 = count; if(i == 1) objectStorageItemCount1 = count; if(i == 2)  objectStorageItemCount2  = count; if(i == 3)  objectStorageItemCount3  = count;
	if(i == 4) objectStorageItemCount4 = count; if(i == 5) objectStorageItemCount5 = count; if(i == 6)  objectStorageItemCount6  = count; if(i == 7)  objectStorageItemCount7  = count;
	if(i == 8) objectStorageItemCount8 = count; if(i == 9) objectStorageItemCount9 = count; if(i == 10) objectStorageItemCount10 = count; if(i == 11) objectStorageItemCount11 = count;
}

// Cluster distance.
float objectStorageDist0 = 0.0; float objectStorageDist1 = 0.0; float objectStorageDist2  = 0.0; float objectStorageDist3  = 0.0;
float objectStorageDist4 = 0.0; float objectStorageDist5 = 0.0; float objectStorageDist6  = 0.0; float objectStorageDist7  = 0.0;
float objectStorageDist8 = 0.0; float objectStorageDist9 = 0.0; float objectStorageDist10 = 0.0; float objectStorageDist11 = 0.0;

float getObjectStorageDist(int i = -1) {
	if(i == 0) return(objectStorageDist0); if(i == 1) return(objectStorageDist1); if(i == 2)  return(objectStorageDist2);  if(i == 3)  return(objectStorageDist3);
	if(i == 4) return(objectStorageDist4); if(i == 5) return(objectStorageDist5); if(i == 6)  return(objectStorageDist6);  if(i == 7)  return(objectStorageDist7);
	if(i == 8) return(objectStorageDist8); if(i == 9) return(objectStorageDist9); if(i == 10) return(objectStorageDist10); if(i == 11) return(objectStorageDist11);
	return(0.0);
}

void setObjectStorageDist(int i = -1, float dist = 0.0) {
	if(i == 0) objectStorageDist0 = dist; if(i == 1) objectStorageDist1 = dist; if(i == 2)  objectStorageDist2  = dist; if(i == 3)  objectStorageDist3  = dist;
	if(i == 4) objectStorageDist4 = dist; if(i == 5) objectStorageDist5 = dist; if(i == 6)  objectStorageDist6  = dist; if(i == 7)  objectStorageDist7  = dist;
	if(i == 8) objectStorageDist8 = dist; if(i == 9) objectStorageDist9 = dist; if(i == 10) objectStorageDist10 = dist; if(i == 11) objectStorageDist11 = dist;
}

// Constraints.
int objectStorageConstraint0 = 0; int objectStorageConstraint1 = 0; int objectStorageConstraint2  = 0; int objectStorageConstraint3  = 0;
int objectStorageConstraint4 = 0; int objectStorageConstraint5 = 0; int objectStorageConstraint6  = 0; int objectStorageConstraint7  = 0;
int objectStorageConstraint8 = 0; int objectStorageConstraint9 = 0; int objectStorageConstraint10 = 0; int objectStorageConstraint11 = 0;

int getObjectStorageConstraint(int i = -1) {
	if(i == 0) return(objectStorageConstraint0); if(i == 1) return(objectStorageConstraint1); if(i == 2)  return(objectStorageConstraint2);  if(i == 3)  return(objectStorageConstraint3);
	if(i == 4) return(objectStorageConstraint4); if(i == 5) return(objectStorageConstraint5); if(i == 6)  return(objectStorageConstraint6);  if(i == 7)  return(objectStorageConstraint7);
	if(i == 8) return(objectStorageConstraint8); if(i == 9) return(objectStorageConstraint9); if(i == 10) return(objectStorageConstraint10); if(i == 11) return(objectStorageConstraint11);
	return(0);
}

void setObjectStorageConstraint(int i = -1, int cID = 0) {
	if(i == 0) objectStorageConstraint0 = cID; if(i == 1) objectStorageConstraint1 = cID; if(i == 2)  objectStorageConstraint2  = cID; if(i == 3)  objectStorageConstraint3  = cID;
	if(i == 4) objectStorageConstraint4 = cID; if(i == 5) objectStorageConstraint5 = cID; if(i == 6)  objectStorageConstraint6  = cID; if(i == 7)  objectStorageConstraint7  = cID;
	if(i == 8) objectStorageConstraint8 = cID; if(i == 9) objectStorageConstraint9 = cID; if(i == 10) objectStorageConstraint10 = cID; if(i == 11) objectStorageConstraint11 = cID;
}

const string cObjectLabel = "stored object";

int objectStorageCount = 0;
int objectConstraintCount = 0;
int objectLabelCount = 0;

/*
** Stores an item for an object.
**
** @param proto: the proto name of the object to be placed (e.g., "Gazelle")
** @param num: the number of times the proto item should be placed
** @param dist: the distance the objects can be apart from each other
*/
void storeObjectDefItem(string proto = "", int num = 0, float dist = 0.0) {
	setObjectStorageProto(objectStorageCount, proto);
	setObjectStorageItemCount(objectStorageCount, num);
	setObjectStorageDist(objectStorageCount, dist);

	objectStorageCount++;
}

/*
** Stores a constraint for an object.
**
** @param cID: the ID of the constraint
*/
void storeObjectConstraint(int cID = -1) {
	setObjectStorageConstraint(objectConstraintCount, cID);

	objectConstraintCount++;
}

/*
** Creates a new object with the currently stored properties.
**
** @param objLabel: the label to use for creating the definition
** @param verify: whether to create the object definition with verification properties or not
** @param applyConstraints: whether to apply constraints or not
**
** @returns: the created object ID
*/
int createObjectFromStorage(string objLabel = "", bool verify = true, bool applyConstraints = true) {
	int objectID = -1;

	// Create label if not given.
	if(objLabel == "") {
		objLabel = cObjectLabel + " " + objectLabelCount;
		objectLabelCount++;
	}

	// Create object and add definitions based on whether to verify or not.
	if(verify) {
		objectID = createObjectDefVerify(objLabel);

		for(i = 0; < objectStorageCount) {
			addObjectDefItemVerify(objectID, getObjectStorageProto(i), getObjectStorageItemCount(i), getObjectStorageDist(i));
		}
	} else {
		objectID = rmCreateObjectDef(objLabel);

		for(i = 0; < objectStorageCount) {
			rmAddObjectDefItem(objectID, getObjectStorageProto(i), getObjectStorageItemCount(i), getObjectStorageDist(i));
		}
	}

	// Add constraints.
	if(applyConstraints) {
		for(i = 0; < objectConstraintCount) {
			rmAddObjectDefConstraint(objectID, getObjectStorageConstraint(i));
		}
	}

	return(objectID);
}

/*
** Resets the object storage.
*/
void resetObjectStorage() {
	objectStorageCount = 0;
	objectConstraintCount = 0;
}

/*******************
* OBJECT LOCATIONS *
*******************/

/*
 * Array for storing the coordinates of the last object placed for every player (!).
 * Therefore, the index here corresponds to the player number (unlike in the location storage!).
 * For simplicity, only the last iteration of an object will be stored here.
 *
 * If you need more than this, enable the location storage from location.xs via enableLocStorage() before placing the object.
 * After placement, you will find the locations of all (up to 64 total) objects in the array there.
 * Make sure you turn it off again via disableLocStorage() if you don't need it anymore!
*/

// Object X storage.
float lastObjX0 = -1.0; // Also store for Mother Nature.
float lastObjX1 = -1.0; float lastObjX2  = -1.0; float lastObjX3  = -1.0; float lastObjX4  = -1.0;
float lastObjX5 = -1.0; float lastObjX6  = -1.0; float lastObjX7  = -1.0; float lastObjX8  = -1.0;
float lastObjX9 = -1.0; float lastObjX10 = -1.0; float lastObjX11 = -1.0; float lastObjX12 = -1.0;

float getLastObjX(int i = -1) {
	if(i == 0) return(lastObjX0);
	if(i == 1) return(lastObjX1);  if(i == 2)  return(lastObjX2);  if(i == 3)  return(lastObjX3);  if(i == 4)  return(lastObjX4);
	if(i == 5) return(lastObjX5);  if(i == 6)  return(lastObjX6);  if(i == 7)  return(lastObjX7);  if(i == 8)  return(lastObjX8);
	if(i == 9) return(lastObjX9);  if(i == 10) return(lastObjX10); if(i == 11) return(lastObjX11); if(i == 12) return(lastObjX12);
	return(-1.0);
}

float setLastObjX(int i = -1, float val = -1.0) {
	if(i == 0) lastObjX0 = val;
	if(i == 1) lastObjX1 = val; if(i == 2)  lastObjX2  = val; if(i == 3)  lastObjX3  = val; if(i == 4)  lastObjX4  = val;
	if(i == 5) lastObjX5 = val; if(i == 6)  lastObjX6  = val; if(i == 7)  lastObjX7  = val; if(i == 8)  lastObjX8  = val;
	if(i == 9) lastObjX9 = val; if(i == 10) lastObjX10 = val; if(i == 11) lastObjX11 = val; if(i == 12) lastObjX12 = val;
}

// Object Z storage.
float lastObjZ0 = -1.0; // Also store for Mother Nature.
float lastObjZ1 = -1.0; float lastObjZ2  = -1.0; float lastObjZ3  = -1.0; float lastObjZ4  = -1.0;
float lastObjZ5 = -1.0; float lastObjZ6  = -1.0; float lastObjZ7  = -1.0; float lastObjZ8  = -1.0;
float lastObjZ9 = -1.0; float lastObjZ10 = -1.0; float lastObjZ11 = -1.0; float lastObjZ12 = -1.0;

float getLastObjZ(int i = -1) {
	if(i == 0) return(lastObjZ0);
	if(i == 1) return(lastObjZ1);  if(i == 2)  return(lastObjZ2);  if(i == 3)  return(lastObjZ3);  if(i == 4)  return(lastObjZ4);
	if(i == 5) return(lastObjZ5);  if(i == 6)  return(lastObjZ6);  if(i == 7)  return(lastObjZ7);  if(i == 8)  return(lastObjZ8);
	if(i == 9) return(lastObjZ9);  if(i == 10) return(lastObjZ10); if(i == 11) return(lastObjZ11); if(i == 12) return(lastObjZ12);
	return(-1.0);
}

float setLastObjZ(int i = -1, float val = -1.0) {
	if(i == 0) lastObjZ0 = val;
	if(i == 1) lastObjZ1 = val; if(i == 2)  lastObjZ2  = val; if(i == 3)  lastObjZ3  = val; if(i == 4)  lastObjZ4  = val;
	if(i == 5) lastObjZ5 = val; if(i == 6)  lastObjZ6  = val; if(i == 7)  lastObjZ7  = val; if(i == 8)  lastObjZ8  = val;
	if(i == 9) lastObjZ9 = val; if(i == 10) lastObjZ10 = val; if(i == 11) lastObjZ11 = val; if(i == 12) lastObjZ12 = val;
}

/*
** Sets the x and z value for a single entry.
**
** @param i: the index to set
** @param x: the x value (fraction)
** @param z: the z value (fraction)
*/
void setLastObjXZ(int i = 0, float x = -1.0, float z = -1.0) {
	setLastObjX(i, x);
	setLastObjZ(i, z);
}

/*****************************
* COMMON PLACEMENT FUNCTIONS *
*****************************/

/*
** Attempts to place an object for a player at a given location.
**
** @param objectID: the ID of the object to be placed
** @param player: the player (already mapped) owning the object (0 = Mother Nature)
** @param x: x coordinate of the location
** @param z: z coordinate of the location
** @param force: has to be set to true if the object must be placed (note that this alone will not guarantee placement though, see function below)
**
** @returns: true if placement succeeded, false otherwise
*/
bool placeObjectForPlayer(int objectID = -1, int player = 0, float x = -1.0, float z = -1.0, bool force = false) {
	if(force == false && isLocValid(x, z) == false) {
		return(false);
	}

	return(rmPlaceObjectDefAtLoc(objectID, player, x, z) > 0);
}

/*
** Enforces placement for an object for a player by steadily increasing MaxDistance of the object until placement succeeded.
**
** @param objectID: the ID of the object to be placed
** @param player: the player (already mapped) owning the object (0 = Mother Nature)
** @param x: x coordinate of the location
** @param z: z coordinate of the location
*/
void forcePlaceObjectForPlayer(int objectID = -1, int player = 0, float x = -1.0, float z = -1.0) {
	// Calculate diagonal.
	int numForceTries = 100;
	float diag = sqrt(sq(getFullXMeters()) + sq(getFullZMeters()));
	float range = 1.0;

	for(i = 1; < numForceTries) {
		// Increase maximum distance allowed to be placed from original location, try to place, increment.
		rmSetObjectDefMaxDistance(objectID, range);

		if(placeObjectForPlayer(objectID, player, x, z, true) || range > diag) {
			// Reset max distance if placed successfully (in case we place same object again) and return.
			rmSetObjectDefMaxDistance(objectID, 0.0);
			return;
		}

		range = 2.0 * range;
	}
}

/**************************************
* MIRRORED PLACEMENT ANGLE PARAMETERS *
**************************************/

// Object angle randomization settings.
float objectMinAngle = INF;
float objectMaxAngle = PI;
bool useIntervalOnce = true;

/*
** Sets the interval to randomize from.
** 0 is behind the player, PI is in front. 0.5 * PI is to the right when watching from the player towards the center, -0.5 * PI to the left.
**
** @param minAngle: the minimum angle to randomize
** @param maxAngle: the maximum angle to randomize
** @param runOnce: whether to reset the interval after placing an object for every player or keep it until changed
*/
void setObjectAngleInterval(float minAngle = INF, float maxAngle = PI, bool runOnce = true) {
	objectMinAngle = minAngle;
	objectMaxAngle = maxAngle;
	useIntervalOnce = runOnce;
}

// Far object angle slice setting.
float farObjectAngleSlice = INF;
bool useFarSliceOnce = true;

/*
** Sets the far object player angle slice.
** Note that the far angle is inverted, i.e., PI is straight through/behind the player and 0 is in front.
**
** @param slice: the slice (angle) to randomize from with respect to player offset (example: PI -> rmRandFloat(-0.5 * PI, 0.5 * PI)
** @param runOnce: whether to reset the interval after placing an object for every player or keep it until changed
*/
void setFarObjectAngleSlice(float slice = INF, bool runOnce = true) {
	farObjectAngleSlice = slice;
	useFarSliceOnce = runOnce;
}

/*
** Returns the far angle segment to randomize from (or half of it to be accurate).
** Considers the angle slice parameter if set.
**
** @param player: the player to calculate the angle segment for
**
** @returns: half of the angle segment
*/
float getFarAngleSegment(int player = 0) {
	if(player == 0) {
		return(PI);
	}

	if(farObjectAngleSlice < INF) {
		return(0.5 * farObjectAngleSlice);
	}

	// Less priority than set angle.
	if(cNonGaiaPlayers == 2) {
		return(PI);
	}

	// Return the larger section which makes 0.5 of the total section that will be used for randomization.
	float diffPrev = getSectionBetweenConsecutiveAngles(getPlayerAngle(getPrevPlayer(player)), getPlayerAngle(player));
	float diffNext = getSectionBetweenConsecutiveAngles(getPlayerAngle(player), getPlayerAngle(getNextPlayer(player)));

	if(diffPrev > diffNext) {
		return(diffPrev);
	}

	return(diffNext);
}

/*********************
* MIRRORED PLACEMENT *
*********************/

/*
** Attempts to place an object at a specific location (defined in polar coordinates) for a player and its mirrored counterpart.
**
** @param player: the player number of the player and their mirrored counterpart to place the object for
** @param objectID: the ID of the object to be placed
** @param radius: radius as fraction
** @param angle: angle in radians
** @param playerOwned: true means the object is owned by the players, false means it is owned by Mother Nature
** @param square: if true, the radius is converted to a square (the original rmPlaceObjectDef does this)
** @param altObjID: if set, this object will be used for the mirrored player instead of objectID
**                  (e.g., without constraints in case it is placed close to the center)
**
** @returns: true if placement succeeded, false otherwise
*/
bool placeObjectForMirroredPlayersAtAngle(int player = 0, int objectID = -1, float radius = 0.0, float angle = 0.0, bool playerOwned = false, bool square = false, int altObjID = -1) {
	float owner = 0; // Mother Nature.

	for(i = 0; < 2) {
		if(playerOwned) { // Set owner to player.
			owner = getPlayer(player);
		}

		float x = getXFromPolarForPlayer(player, radius, angle, square);
		float z = getZFromPolarForPlayer(player, radius, angle, square);

		if(placeObjectForPlayer(objectID, owner, x, z) == false) {
			// Failed to place for first player, return.
			if(i == 0) {
				return(false);
			}

			// Failed to place for second player, enforce placement.
			forcePlaceObjectForPlayer(objectID, owner, x, z);
		}

		// Make entry in location array.
		setLastObjXZ(player, x, z);

		// Store location.
		addLocToStorage(x, z, player);

		// If we get here with i == 1 we're done.
		if(i == 1) {
			return(true);
		}

		// Prepare for next iteration.
		// Adjust angle.
		if(getMirrorMode() != cMirrorPoint) {
			angle = 0.0 - angle;
		}

		// Use alt object if defined.
		if(altObjID > -1) {
			objectID = altObjID;
		}

		// Prepare player for next iteration.
		player = getMirroredPlayer(player);
	}
}

/*
** Attempts to place a mirrored object for a player and their mirrored counterpart.
**
** @param player: the player number of the player and their mirrored counterpart to place the object for
** @param objectID: the ID of the object to be placed
** @param playerOwned: true means the object is owned by the players, false means it is owned by Mother Nature
** @param num: the number of objects to place per player
** @param minDist: minimum distance from the player
** @param maxDist: maximum distance from the player
** @param square: if true, the radius is converted to a square (the original rmPlaceObjectDef does this)
** @param altObjID: if set, this object will be used for the mirrored player instead of objectID
**                  (e.g., without constraints in case it is placed close to the center)
**
** @returns: the number of objects placed successfully placed for both players
*/
int placeObjectForMirroredPlayers(int player = 0, int objectID = -1, bool playerOwned = false, int num = 1, float minDist = 0.0, float maxDist = -1.0, bool square = false, int altObjID = -1) {
	if(maxDist < 0) {
		maxDist = minDist;
	}

	int numIter = 500 * num;
	int placed = 0;
	float angle = 0.0;

	for(i = 0; < numIter) {
		// Randomize radius and angle and try to place.
		float radius = randRadiusFromInterval(minDist, maxDist);

		if(objectMinAngle < INF) {
			angle = rmRandFloat(objectMinAngle, objectMaxAngle);
		} else {
			angle = randRadian();
		}

		if(placeObjectForMirroredPlayersAtAngle(player, objectID, radius, angle, playerOwned, square, altObjID)) {
			placed++;

			if(placed == num) {
				break;
			}
		}
	}

	return(placed);
}

/*
** Attempts to place a mirrored object for all players.
** This is done by separately mirroring an object for every pair of mirrored players.
**
** @param objectID: the ID of the object to be placed
** @param playerOwned: true means the object is owned by the players, false means it is owned by Mother Nature
** @param num: the number of objects to place per player
** @param minDist: minimum distance from the player
** @param maxDist: maximum distance from the player
** @param square: if true, the radius is converted to a square (the original rmPlaceObjectDef does this)
** @param altObjID: if set, this object will be used for the mirrored player instead of objectID
**                  (e.g., without constraints in case it is placed close to the center)
** @param backupObjID: if set, this object will be used for backup placement in case the original object fails to place in some instances
**
** @returns: true on success, false on any failures
*/
bool placeObjectMirrored(int objectID = -1, bool playerOwned = false, int num = 1, float minDist = 0.0, float maxDist = -1.0, bool square = false, int altObjID = -1, int backupObjID = -1) {
	int succeeded = 0;

	for(p = 1; <= getNumberPlayersOnTeam(0)) {
		int player = p;

		if(randChance()) {
			player = getMirroredPlayer(player);
		}

		int placed = placeObjectForMirroredPlayers(player, objectID, playerOwned, num, minDist, maxDist, square, altObjID);

		if(placed == num) {
			succeeded++;
		} else if(backupObjID != -1) {
			if(placeObjectForMirroredPlayers(player, backupObjID, playerOwned, num - placed, minDist, maxDist, square, altObjID) == num - placed) {
				succeeded++;
			}
		}
	}

	if(useIntervalOnce) {
		setObjectAngleInterval();
	}

	return(succeeded == 0.5 * cNonGaiaPlayers);
}

/*
** Attempts to place an object at a specific location (defined in polar coordinates) for a player and its mirrored counterpart.
**
** The difference here is that we try to place the object from the middle towards the player instead of the other way around.
** This is good for far objects as we can directly avoid the center circle and still place the object in the player's section.
**
** @param player: the player number of the player and their mirrored counterpart to place the object for
** @param objectID: the ID of the object to be placed
** @param radius: radius as fraction
** @param angle: angle in radians from the center (!), 0 points towards the center and PI towards the edge of the map with respect to the player
** @param playerOwned: true means the object is owned by the players, false means it is owned by Mother Nature
** @param altObjID: if set, this object will be used for the mirrored player instead of objectID
**                  (e.g., without constraints in case it is placed close to the center)
**
** @returns: true if placement succeeded, false otherwise
*/
bool placeFarObjectForMirroredPlayersAtAngle(int player = 0, int objectID = -1, float radius = 0.0, float angle = 0.0, bool playerOwned = false, int altObjID = -1) {
	float owner = 0;

	for(i = 0; < 2) {
		if(playerOwned) { // Set owner to player.
			owner = getPlayer(player);
		}

		/*
		 * Always use player 0 (0.5/0.5) as offset here, resulting in the player angle not being added in getFromPolarForPlayer().
		 * To still achieve the offset relative to the player so that you can actually specify a meaningful angle argument for this function,
		 * we add the player angle manually.
		 * Since we are placing from the middle, the angles are now inverted: 0.0 points towards the center, PI follows the player angle from the center.
		*/
		float x = getXFromPolarForPlayer(0, radius, angle + getPlayerAngle(player));
		float z = getZFromPolarForPlayer(0, radius, angle + getPlayerAngle(player));

		if(placeObjectForPlayer(objectID, owner, x, z) == false) {
			// Failed to place for p1, return.
			if(i == 0) {
				return(false);
			}

			// Failed to place for another player, enforce placement.
			forcePlaceObjectForPlayer(objectID, owner, x, z);
		}

		// Make entry in location array.
		setLastObjXZ(player, x, z);

		// Store location.
		addLocToStorage(x, z, player);

		// If we get here with i == 1 we're done.
		if(i == 1) {
			return(true);
		}

		// Prepare for next iteration.
		// Adjust angle.
		if(getMirrorMode() != cMirrorPoint) {
			angle = 0.0 - angle;
		}

		// Use alt object if defined.
		if(altObjID > -1) {
			objectID = altObjID;
		}

		// Prepare player for next iteration.
		player = getMirroredPlayer(player);
	}
}

/*
** Attempts to place a mirrored object for a player and their mirrored counterpart.
**
** The difference here is that we try to place the object from the middle towards the player instead of the other way around.
** This is good for far objects as we can directly avoid the center circle and still place the object in the player's section.
**
** @param player: the player number of the player and their mirrored counterpart to place the object for
** @param objectID: the ID of the object to be placed
** @param playerOwned: true means the object is owned by the players, false means it is owned by Mother Nature
** @param num: the number of objects to place per player
** @param minDist: the minimum distance of the objects to be from the center (to avoid very close spawns)
** @param altObjID: if set, this object will be used for the mirrored player instead of objectID
**                  (e.g., without constraints in case it is placed close to the center)
**
** @returns: the number of objects placed successfully placed for both players
*/
int placeFarObjectForMirroredPlayers(int player = 0, int objectID = -1, bool playerOwned = false, int num = 1, float minDist = 20.0, int altObjID = -1) {
	int numIter = 500 * num;
	int placed = 0;

	// Get angle range to place towards (offset to player).
	float maxAngle = getFarAngleSegment(player);
	float minAngle = 0.0 - maxAngle;

	for(i = 0; < numIter) {
		float radius = randRadiusFromCenterToEdge(minDist);
		float angle = rmRandFloat(minAngle, maxAngle);

		if(placeFarObjectForMirroredPlayersAtAngle(player, objectID, radius, angle, playerOwned, altObjID)) {
			placed++;

			if(placed == num) {
				break;
			}
		}
	}

	return(placed);
}

/*
** Attempts to place a far object mirrored for all players.
** You have to use constraints to make the object avoid the player, it can be placed anywhere in the player's section.
**
** @param objectID: the ID of the object to be placed
** @param playerOwned: true means the object is owned by the players, false means it is owned by Mother Nature
** @param num: the number of objects to place per player
** @param minDist: the minimum distance of the objects to be from the center (to avoid very close spawns)
** @param altObjID: if set, this object will be used for the mirrored player instead of objectID
**                  (e.g., without constraints in case it is placed close to the center)
** @param backupObjID: if set, this object will be used for backup placement in case the original object fails to place in some instances
**
** @returns: true on success, false on any failures
*/
bool placeFarObjectMirrored(int objectID = -1, bool playerOwned = false, int num = 1, float minDist = 20.0, int altObjID = -1, int backupObjID = -1) {
	int succeeded = 0;

	for(p = 1; <= getNumberPlayersOnTeam(0)) {
		int player = p;

		if(randChance(0.0)) {
			player = getMirroredPlayer(player);
		}

		int placed = placeFarObjectForMirroredPlayers(player, objectID, playerOwned, num, minDist, altObjID);

		if(placed == num) {
			succeeded++;
		} else if(backupObjID != -1) {
			if(placeFarObjectForMirroredPlayers(player, backupObjID, playerOwned, num - placed, minDist, altObjID) == num - placed) {
				succeeded++;
			}
		}
	}

	if(useFarSliceOnce) {
		setFarObjectAngleSlice();
	}

	return(succeeded == 0.5 * cNonGaiaPlayers);
}

/********************
* REGULAR PLACEMENT *
********************/

float placeObjectMinAngle = 0.0;
float placeObjectMaxAngle = 2.0;

/*
** Sets the minimum/maximum angle to randomize from for placeObjectDefForPlayer().
**
** @param startAngle: starting angle in radians but without multiplied by PI (basically the angle in radians / PI)
** @param endAngle: ending angle in radians but without multiplied by PI (basically the angle in radians / PI)
*/
void setPlaceObjectAngleRange(float startAngle = 0.0, float endAngle = 2.0) {
	placeObjectMinAngle = startAngle;
	placeObjectMaxAngle = endAngle;
}

/*
** Resets the angles to default values. Has to be called manually if using placeObjectDefForPlayer() instead of placeObjectDefPerPlayer()!
*/
void resetPlaceObjectAngle() {
	setPlaceObjectAngleRange();
}

/*
** Attempts to place a regular object for a single player.
**
** @param player: the player
** @param objectID: the ID of the object to be placed
** @param playerOwned: true means the object is owned by the player, false means it is owned by Mother Nature
** @param num: the number of objects to place
** @param minDist: minimum distance from the player
** @param maxDist: maximum distance from the player
** @param square: if true, the radius is converted to a square (the original rmPlaceObjectDef does this)
** @param verify: whether to verify placement or not (disable this for heuristic approaches); requires an object created with createObjectDefVerify()
** @param numTries: the number of attempts per object instance
**
** @returns: the number of objects placed successfully placed for both players (the number of actual objects, NOT the number of items * the number of objects!)
*/
int placeObjectDefForPlayer(int player = 0, int objectID = -1, bool playerOwned = false, int num = 1, float minDist = 0.0, float maxDist = -1.0, bool square = false, bool verify = true, int numTries = 1000) {
	setObjectDefDistance(objectID, 0.0, 0.0);

	if(maxDist < 0) {
		maxDist = minDist;
	}

	int numIter = numTries * num;
	int placed = 0;
	float owner = 0; // Mother Nature.

	if(playerOwned) { // Set owner to player.
		owner = getPlayer(player);
	}

	for(i = 0; < numIter) {
		float radius = randRadiusFromInterval(minDist, maxDist);
		float angle = rmRandFloat(placeObjectMinAngle, placeObjectMaxAngle) * PI;

		float x = getXFromPolarForPlayer(player, radius, angle, square);
		float z = getZFromPolarForPlayer(player, radius, angle, square);

		if(placeObjectForPlayer(objectID, owner, x, z)) {
			setLastObjXZ(player, x, z);
			addLocToStorage(x, z, player);
			placed++;

			if(placed == num) {
				break;
			}
		}
	}

	setObjectDefDistance(objectID, minDist, maxDist);

	// Verification stuff.
	if(verify) {
		updateObjectTargetPlaced(objectID, num);
	}

	return(placed);
}

/*
** Places an object within a given distance interval for a certain player.
**
** Replaces rmPlaceObjectDefPerPlayer().
** If you use this function, be aware that the min/max distance of the object definition gets overwritten with the parameters used here.
**
** @param objectID: the object definition ID
** @param playerOwned: true means the object is owned by the players, false means it is owned by Mother Nature
** @param num: the number of times the object should be placed
** @param minDist: the minimum distance from the player location the object can be
** @param maxDist: the maximum distance from the player location the object can be
** @param square: if true, the radius is converted to a square (the original rmPlaceObjectDef does this)
**
** @returns: true on success, false on any failures
*/
bool placeObjectDefPerPlayer(int objectID = -1, bool playerOwned = false, int num = 1, float minDist = 0.0, float maxDist = -1.0, bool square = false) {
	int succeeded = 0;

	for(p = 1; < cPlayers) {
		if(placeObjectDefForPlayer(p, objectID, playerOwned, num, minDist, maxDist, square) == num) {
			succeeded++;
		}
	}

	// updateObjectTargetPlaced(objectID, num * cNonGaiaPlayers); // Already done in placeObjectDefForPlayer().

	// Reset angle.
	resetPlaceObjectAngle();

	return(succeeded == cNonGaiaPlayers);
}

/*
** Replaces rmPlaceObjectDefAtLoc() to allow placement checking.
**
** @param objectID: the ID of the object to be placed
** @param owner: the object owner; 0 -> nature, 1 <= owner <= 12 -> one of the actual players
** @param x: the x coordinate of the location as a fraction
** @param z: the z coordinate of the location as a fraction
** @param num: the number of times the object should be placed
**
** @returns: the number of placed object items, not the number of actual object definitions placed (!)
*/
int placeObjectDefAtLoc(int objectID = -1, int owner = 0, float x = 0.0, float z = 0.0, int num = 1) {
	int res = rmPlaceObjectDefAtLoc(objectID, getPlayer(owner), x, z, num);

	updateObjectTargetPlaced(objectID, num);

	return(res);
}

/*
** Replaces rmPlaceObjectDefAtAreaLoc() to allow placement checking.
**
** @param objectID: the ID of the object to be placed
** @param owner: the object owner; 0 -> nature, 1 <= owner <= 12 -> one of the actual players
** @param areaID: the ID of the area to place the object at
** @param num: the number of times the object should be placed
**
** @returns: the number of placed object items, not the number of actual object definitions placed (!)
*/
int placeObjectDefAtAreaLoc(int objectID = -1, int owner = 0, int areaID = -1, int num = 1) {
	int res = rmPlaceObjectDefAtAreaLoc(objectID, getPlayer(owner), areaID, num);

	updateObjectTargetPlaced(objectID, num);

	return(res);
}

/*
** Replaces rmPlaceObjectDefInArea() to allow placement checking.
**
** @param objectID: the ID of the object to be placed
** @param owner: the object owner; 0 -> nature, 1 <= owner <= 12 -> one of the actual players
** @param areaID: the ID of the area to place the object at
** @param num: the number of times the object should be placed
**
** @returns: the number of placed object items, not the number of actual object definitions placed (!)
*/
int placeObjectDefInArea(int objectID = -1, int owner = 0, int areaID = -1, int num = 1) {
	int res = rmPlaceObjectDefInArea(objectID, getPlayer(owner), areaID, num);

	updateObjectTargetPlaced(objectID, num);

	return(res);
}

/*
** Replaces rmPlaceObjectDefAtRandomAreaOfClass() to allow placement checking.
**
** @param objectID: the ID of the object to be placed
** @param owner: the object owner; 0 -> nature, 1 <= owner <= 12 -> one of the actual players
** @param classID: the ID of the class to randomly select an area from
** @param num: the number of times the object should be placed
**
** @returns: the number of placed object items, not the number of actual object definitions placed (!)
*/
int placeObjectDefAtRandomAreaOfClass(int objectID = -1, int owner = 0, int classID = -1, int num = 1) {
	int res = rmPlaceObjectDefAtRandomAreaOfClass(objectID, getPlayer(owner), classID, num);

	updateObjectTargetPlaced(objectID, num);

	return(res);
}

/*
** Replaces rmPlaceObjectDefInRandomAreaOfClass() to allow placement checking.
**
** @param objectID: the ID of the object to be placed
** @param owner: the object owner; 0 -> nature, 1 <= owner <= 12 -> one of the actual players
** @param classID: the ID of the class to randomly select an area from
** @param num: the number of times the object should be placed
**
** @returns: the number of placed object items, not the number of actual object definitions placed (!)
*/
int placeObjectDefInRandomAreaOfClass(int objectID = -1, int owner = 0, int classID = -1, int num = 1) {
	int res = rmPlaceObjectDefInRandomAreaOfClass(objectID, getPlayer(owner), classID, num);

	updateObjectTargetPlaced(objectID, num);

	return(res);
}

/*
** Places an object at a specific player location. Player 0 (Mother Nature) has offset 0.5/0.5.
**
** @param objectID: the ID of the object to be placed
** @param playerOwned: defaults to false (= Mother Nature); players will own the object if set to true
** @param player: the player to use as offset
** @param num: the number of times the object should be placed
**
** @returns: the number of placed object items, not the number of actual object definitions placed (!)
*/
int placeObjectAtPlayerLoc(int objectID = -1, bool playerOwned = false, int player = 0, int num = 1) {
	int res = 0;

	if(playerOwned) {
		res = placeObjectDefAtLoc(objectID, player, getPlayerLocXFraction(player), getPlayerLocZFraction(player), num);
	} else {
		res = placeObjectDefAtLoc(objectID, 0, getPlayerLocXFraction(player), getPlayerLocZFraction(player), num);
	}

	return(res);
}

/*
** Places the same object for every player, starting (rmSetObjectDefMinDistance() = 0.0) from the player's spawn.
** This is a direct replacement for rmPlaceObjectDefPerPlayer(), which should NOT be used due to observers/merged players.
**
** @param objectID: the ID of the object to be placed
** @param playerOwned: defaults to false (= Mother Nature); players will own the object if set to true
** @param num: the number of times the object should be placed
*/
void placeObjectAtPlayerLocs(int objectID = -1, bool playerOwned = false, int num = 1) {
	for(i = 1; < cPlayers) {
		placeObjectAtPlayerLoc(objectID, playerOwned, i, num);
	}
}

/*
** Places an object for every player somewhere in their split.
**
** @param objectID: the ID of the object to be placed
** @param playerOwned: defaults to false (= Mother Nature); players will own the object if set to true
** @param num: the number of times the object should be placed
*/
void placeObjectInPlayerSplits(int objectID = -1, bool playerOwned = false, int num = 1) {
	// Initialize splits if not already done.
	initializeSplit();

	for(i = 1; < cPlayers) {
		if(playerOwned) {
			placeObjectDefInArea(objectID, i, rmAreaID(cSplitName + " " + i), num);
		} else {
			placeObjectDefInArea(objectID, 0, rmAreaID(cSplitName + " " + i), num);
		}
	}
}

/*
** Places an object for every player somewhere in the split of their team.
** This should be used instead of randomly placing objects from 0.5/0.5 with a huge maximum distance (e.g., bonus hunt on Oasis).
**
** @param objectID: the ID of the object to be placed
** @param playerOwned: defaults to false (= Mother Nature); players will own the object if set to true
** @param num: the number of times the object should be placed
*/
void placeObjectInTeamSplits(int objectID = -1, bool playerOwned = false, int num = 1) {
	// Initialize splits if not already done.
	initializeTeamSplit(10.0);

	for(i = 1; < cPlayers) {
		if(playerOwned) {
			placeObjectDefInArea(objectID, i, rmAreaID(cTeamSplitName + " " + rmGetPlayerTeam(getPlayer(i))), num);
		} else {
			placeObjectDefInArea(objectID, 0, rmAreaID(cTeamSplitName + " " + rmGetPlayerTeam(getPlayer(i))), num);
		}
	}
}

/*************************
* FAIR/SIM LOC PLACEMENT *
**************************

/*
** Places a given object at the location of the specified fair location for every player.
**
** @param objectID: the ID of the object to be placed
** @param playerOwned: defaults to false (= Mother Nature); players will own the object if set to true
** @param fairLocID: the ID of the fair location
*/
void placeObjectAtFairLoc(int objectID = -1, bool playerOwned = false, int fairLocID = 1) {
	for(i = 1; < cPlayers) {
		float x = getFairLocX(fairLocID, i);
		float z = getFairLocZ(fairLocID, i);

		if(playerOwned) {
			placeObjectDefAtLoc(objectID, i, x, z);
		} else {
			placeObjectDefAtLoc(objectID, 0, x, z);
		}
	}
}

/*
** Places a given object at the location of all generated fair locations.
**
** @param objectID: the ID of the object to be placed
** @param playerOwned: defaults to false (= Mother Nature); players will own the object if set to true
*/
void placeObjectAtAllFairLocs(int objectID = -1, bool playerOwned = false) {
	int numFairLocs = getNumFairLocs();

	for(f = 1; <= numFairLocs) {
		placeObjectAtFairLoc(objectID, playerOwned, f);
	}
}

/*
** Convenience function to place objects at defined fair locations in atomic (all-or-nothing) fashion.
**
** @param objectID: the ID of the object to be placed
** @param playerOwned: defaults to false (= Mother Nature); players will own the object if set to true
** @param fairLocLabel: the name of the fair location (only used for debugging purposes)
** @param isCrucial: whether the fair loc is crucial and players should be warned if it fails or not
** @param maxIter: the maximum number of iterations to run the algorithm for
** @param localMaxIter: the maximum attempts to find a fair location for every player before starting over
**
** @returns: true upon successfully generating the locations (and placing the objects), false upon any failure (abort)
*/
bool placeObjectAtNewFairLocs(int objectID = -1, bool playerOwned = false, string fairLocLabel = "", bool isCrucial = true, int maxIter = 5000, int localMaxIter = 100) {
	bool success = createFairLocs(fairLocLabel, isCrucial, maxIter, localMaxIter);

	if(success) {
		// Place.
		placeObjectAtAllFairLocs(objectID, playerOwned);
	}

	// Reset.
	resetFairLocs();

	return(success);
}

/*
** Places a given object at the location of the specified fair location for every player.
**
** @param objectID: the ID of the object to be placed
** @param playerOwned: defaults to false (= Mother Nature); players will own the object if set to true
** @param simLocID: the ID of the fair location
*/
void placeObjectAtSimLoc(int objectID = -1, bool playerOwned = false, int simLocID = 1) {
	for(i = 1; < cPlayers) {
		float x = getSimLocX(simLocID, i);
		float z = getSimLocZ(simLocID, i);

		if(playerOwned) {
			placeObjectDefAtLoc(objectID, i, x, z);
		} else {
			placeObjectDefAtLoc(objectID, 0, x, z);
		}
	}
}

/*
** Places a given object at the location of all generated fair locations.
**
** @param objectID: the ID of the object to be placed
** @param playerOwned: defaults to false (= Mother Nature); players will own the object if set to true
*/
void placeObjectAtAllSimLocs(int objectID = -1, bool playerOwned = false) {
	int numSimLocs = getNumSimLocs();

	for(f = 1; <= numSimLocs) {
		placeObjectAtSimLoc(objectID, playerOwned, f);
	}
}

/*
** Convenience function to place objects at defined similar locations in atomic (all-or-nothing) fashion.
**
** @param objectID: the ID of the object to be placed
** @param playerOwned: defaults to false (= Mother Nature); players will own the object if set to true
** @param simLocLabel: the name of the similar location (only used for debugging purposes)
** @param isCrucial: whether the fair loc is crucial and players should be warned if it fails or not
** @param maxIter: the maximum number of iterations to run the algorithm for
** @param localMaxIter: the maximum attempts to find a similar location for every player before starting over
**
** @returns: true upon successfully generating the locations (and placing the objects), false upon any failure (abort)
*/
bool placeObjectAtNewSimLocs(int objectID = -1, bool playerOwned = false, string simLocLabel = "", bool isCrucial = true, int maxIter = 5000, int localMaxIter = 100) {
	bool success = createSimLocs(simLocLabel, isCrucial, maxIter, localMaxIter);

	if(success) {
		// Place.
		placeObjectAtAllSimLocs(objectID, playerOwned);
	}

	// Reset.
	resetSimLocs();

	return(success);
}

/*************************
* PLACEMENT NEAR OBJECTS *
*************************/

const string cAltObjLabel = "rmx near alt object";
const string cBackupObjLabel = "rmx near backup object";
const string cObjAreaLabel = "rmx near object area";
const string cObjLabel = "rmx near object";
const string cObjString = "rmx object near area";

int objCounter = 0;

// Mirrored.

/*
** Places and stores a mirrored object in the location storage.
** Note that this resets the storage and also calls disableLocStorage() before returning.
** Also see placeObjectMirrored().
**
** @param objectID: the ID of the object to be placed
** @param playerOwned: true means the object is owned by the players, false means it is owned by Mother Nature
** @param num: the number of objects to place per player
** @param minDist: minimum distance from the player
** @param maxDist: maximum distance from the player
** @param square: if true, the radius is converted to a square (the original rmPlaceObjectDef does this)
** @param altObjID: if set, this object will be used for the mirrored player instead of objectID
**                  (e.g., without constraints in case it is placed close to the center)
** @param backupObjID: if set, this object will be used for backup placement in case the original object fails to place in some instances
**
** @returns: true on success, false on any failures
*/
bool placeAndStoreObjectMirrored(int objectID = -1, bool playerOwned = false, int num = 1, float minDist = 0.0, float maxDist = -1.0, bool square = false, int altObjID = -1, int backupObjID = -1) {
	resetLocStorage();
	enableLocStorage();

	bool success = placeObjectMirrored(objectID, playerOwned, num, minDist, maxDist, square, altObjID, backupObjID);

	disableLocStorage();

	return(success);
}

/*
** Reads from the first n entries of the location storage to place a mirrored object close to one (!) of the locations per player.
** Since this requires a new object (with different area constraints for every player), you have to use storeObject...() functions
** and this function will use the object information that is currently stored.
** Note that players will only get objects placed close to locations they actually own (as per getLocOwner()).
**
** @param nLocs: the number of locations per player to consider from the location storage
** @param playerOwned: true means the object is owned by the players, false means it is owned by Mother Nature
** @param minPlayerDist: the minimum distance from the player location the object can be
** @param maxPlayerDist: the maximum distance from the player location the object can be
** @param objectDist: the maximum distance the object can be from the previously placed object
** @param square: if true, the radius is converted to a square (the original rmPlaceObjectDef does this)
*/
void placeStoredObjectMirroredNearStoredLocs(int nLocs = 0, bool playerOwned = false, float minPlayerDist = 0.0, float maxPlayerDist = 0.0, float objectDist = 0.0, bool square = false) {
	int altObjectID = createObjectFromStorage(cAltObjLabel + " " + objCounter, false, false); // No constraints.
	int backupObjectID = createObjectFromStorage(cBackupObjLabel + " " + objCounter, false, true); // With constraints, but no area constraint later on.

	for(p = 0; < getNumberPlayersOnTeam(0)) {
		bool done = false;

		for(o = 1; <= nLocs) {
			// 2 * p * nLocs = 2 locations for every pair of mirrored players per location used as offset.
			// 2 * o - 1 = We only look at the first location for mirrored players (index 1, 3, 5, ...).
			int idx = 2 * o - 1 + 2 * p * nLocs;
			float x = getLocX(idx);
			float z = getLocZ(idx);

			int fakeAreaID = rmCreateArea(cObjAreaLabel + " " + objCounter + " " + p + " " + o);
			rmSetAreaLocation(fakeAreaID, x, z);
			rmSetAreaSize(fakeAreaID, rmXMetersToFraction(0.1));
			rmSetAreaCoherence(fakeAreaID, 1.0);
			rmBuildArea(fakeAreaID);

			// New object with the constraint forcing it close to one of the areas.
			int nearObjectID = createObjectFromStorage(cObjLabel + " " + objCounter + " " + p + " " + o, false, true);

			// Create individual constraint so the object actually places close to the area.
			rmAddObjectDefConstraint(nearObjectID, createAreaMaxDistConstraint(fakeAreaID, objectDist));

			if(placeObjectForMirroredPlayers(getLocOwner(idx), nearObjectID, playerOwned, 1, minPlayerDist, maxPlayerDist, square, altObjectID) > 0) {
				done = true;
				break;
			}
		}

		if(done == false) {
			// Backup.
			placeObjectForMirroredPlayers(p, backupObjectID, playerOwned, 1, minPlayerDist, maxPlayerDist, square, altObjectID);
		}
	}

	objCounter++;
}

// Non-mirrored.

/*
** Places and stores an object in the location storage.
** Note that this resets the storage and also calls disableLocStorage() before returning.
** Also see placeObjectDefPerPlayer().
**
** @param objectID: the ID of the object to be placed
** @param playerOwned: true means the object is owned by the players, false means it is owned by Mother Nature
** @param num: the number of objects to place per player
** @param minDist: minimum distance from the player
** @param maxDist: maximum distance from the player
** @param square: if true, the radius is converted to a square (the original rmPlaceObjectDef does this)
**
** @returns: true on success, false on any failures
*/
bool placeAndStoreObjectAtPlayerLocs(int objectID = -1, bool playerOwned = false, int num = 1, float minDist = 0.0, float maxDist = -1.0, bool square = false) {
	resetLocStorage();
	enableLocStorage();

	bool success = placeObjectDefPerPlayer(objectID, playerOwned, num, minDist, maxDist, square);

	disableLocStorage();

	return(success);
}

/*
** Reads from the first n entries of the location storage to place an object close to one (!) of the locations per player.
** Since this requires a new object (with different area constraints for every player), you have to use storeObject...() functions
** and this function will use the object information that is currently stored.
** Note that players will only get objects placed close to locations they actually own (as per getLocOwner()).
** Does NOT verify object placement, make sure to do that via trigger if you intend to use this.
**
** @param nLocs: the number of locations per player to consider from the location storage
** @param playerOwned: true means the object is owned by the players, false means it is owned by Mother Nature
** @param minPlayerDist: the minimum distance from the player location the object can be
** @param maxPlayerDist: the maximum distance from the player location the object can be
** @param objectDist: the maximum distance the object can be from the previously placed object
** @param square: if true, the radius is converted to a square (the original rmPlaceObjectDef does this)
** @param verify: whether to verify placement or not (disable this for heuristic approaches)
*/
void placeStoredObjectNearStoredLocs(int nLocs = 0, bool playerOwned = false, float minPlayerDist = 0.0, float maxPlayerDist = 0.0, float objectDist = 0.0, bool square = true, bool verify = true) {
	for(p = 0; < cNonGaiaPlayers) {
		int nearObjectID = -1;

		for(o = 1; <= nLocs) {
			// Multiple objects placed for a single player are contiguous in the array, use o + offset (number of locations * the player).
			int idx = o + p * nLocs;
			float x = getLocX(idx);
			float z = getLocZ(idx);

			int fakeAreaID = rmCreateArea(cObjAreaLabel + " " + objCounter + " " + p + " " + o);
			rmSetAreaLocation(fakeAreaID, x, z);
			rmSetAreaSize(fakeAreaID, rmXMetersToFraction(0.1));
			rmSetAreaCoherence(fakeAreaID, 1.0);
			rmBuildArea(fakeAreaID);

			// New object with the constraint forcing it close to one of the areas.
			nearObjectID = createObjectFromStorage(cObjLabel + " " + objCounter + " " + p + " " + o, false); // Don't verify here to avoid blowing up the storage.

			// Create individual constraint so the object actually places close to the area.
			rmAddObjectDefConstraint(nearObjectID, createAreaMaxDistConstraint(fakeAreaID, objectDist));

			if(placeObjectDefForPlayer(getLocOwner(idx), nearObjectID, playerOwned, 1, minPlayerDist, maxPlayerDist, square, false) > 0) {
				break;
			}
		}

		// Update verification. Not very clean, but necessary to properly verify without blowing up the storage.
		if(verify) {
			// Use the last/placed object ID and store it.
			registerObjectDefVerifyFromID(cObjLabel + " " + objCounter + " " + p, nearObjectID);

			// Apply all stored items to the object.
			for(i = 0; < objectStorageCount) {
				addObjectDefItemVerify(nearObjectID, getObjectStorageProto(i), getObjectStorageItemCount(i), getObjectStorageDist(i));
			}

			// At this point, the object has double the items (but only half of them are tracked); since we won't be placing it anymore this is not a problem.

			// Enforce the check with the previously added items.
			updateObjectTargetPlaced(nearObjectID, 1);
		}
	}

	objCounter++;
}

/*****************
* MISC PLACEMENT *
*****************/

/*
** Places objects in a line.
**
** @param objectID: the object ID to place
** @param owner: the player number the object should belong to
** @param num: the number of objects to place in a line
** @param x1: x fraction of the placement starting location
** @param z1: z fraction of the placement starting location
** @param x2: x fraction of the placement ending location
** @param z2: z fraction of the placement ending location
** @param xVar: variance as a fraction in the x dimension
** @param zVar: variance as a fraction in the z dimension
*/
void placeObjectInLine(int objectID = -1, int owner = 0, int num = 0, float x1 = 0.0, float z1 = 0.0, float x2 = 0.0, float z2 = 0.0, float xVar = 0.0, float zVar = 0.0) {
	float xDist = (x2 - x1) / (num - 1);
	float zDist = (z2 - z1) / (num - 1);

	float x = x1;
	float z = z1;

	// Special case for 1 object.
	if(num == 1) {
		x = x + 0.5 * (x2 - x1);
		z = z + 0.5 * (z2 - z1);
	}

	for(j = 0; < num) {
		float tempXVar = rmRandFloat(0.0 - xVar, xVar);
		float tempZVar = rmRandFloat(0.0 - zVar, zVar);

		// Place object.
		placeObjectDefAtLoc(objectID, owner, x + tempXVar, z + tempZVar, 1);

		// Update coordinates for next iteration.
		x = x + xDist;
		z = z + zDist;
	}
}
