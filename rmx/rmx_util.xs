/*
** Conversions, scaling, randomization, constraints, player placement, and core areas.
** RebelsRising
** Last edit: 16/04/2021
*/

include "rmx_core.xs";
include "rmx_math.xs";

/************
* CONSTANTS *
************/

extern const string cSplitClassName = "rmx virtual split";
extern const string cTeamSplitClassName = "rmx virtual team split";
extern const string cCenterlineClassName = "rmx centerline";
extern const string cCenterClassName = "rmx center";
extern const string cCornerClassName = "rmx corner";

extern const string cSplitName = "rmx split";
extern const string cTeamSplitName = "rmx team split";
extern const string cFakeTeamSplitName = "rmx fake team split";
extern const string cCenterlineName = "rmx centerline";
extern const string cCenterName = "rmx center";
extern const string cCornerName = "rmx corner";

/*********
* ARRAYS *
*********/

/*
 * Player angles from player placement. Mapping is as follows:
 * getPlayerAngle(2) is the angle of player getPlayer(2).
 * This avoids redundant calls to getPlayer within getPlayerAngle.
*/
float playerAngle1 = 0.0; float playerAngle2  = 0.0; float playerAngle3  = 0.0; float playerAngle4  = 0.0;
float playerAngle5 = 0.0; float playerAngle6  = 0.0; float playerAngle7  = 0.0; float playerAngle8  = 0.0;
float playerAngle9 = 0.0; float playerAngle10 = 0.0; float playerAngle11 = 0.0; float playerAngle12 = 0.0;

float getPlayerAngle(int p = 0) {
	if(p == 0) return(0.0); // We use 0 frequently, return early.
	if(p == 1) return(playerAngle1); if(p == 2)  return(playerAngle2);  if(p == 3)  return(playerAngle3);  if(p == 4)  return(playerAngle4);
	if(p == 5) return(playerAngle5); if(p == 6)  return(playerAngle6);  if(p == 7)  return(playerAngle7);  if(p == 8)  return(playerAngle8);
	if(p == 9) return(playerAngle9); if(p == 10) return(playerAngle10); if(p == 11) return(playerAngle11); if(p == 12) return(playerAngle12);
	return(0.0);
}

void setPlayerAngle(int p = 0, float a = 0) {
	if(p == 1) playerAngle1 = a; if(p == 2)  playerAngle2  = a; if(p == 3)  playerAngle3  = a;  if(p == 4)  playerAngle4  = a;
	if(p == 5) playerAngle5 = a; if(p == 6)  playerAngle6  = a; if(p == 7)  playerAngle7  = a;  if(p == 8)  playerAngle8  = a;
	if(p == 9) playerAngle9 = a; if(p == 10) playerAngle10 = a; if(p == 11) playerAngle11 = a;  if(p == 12) playerAngle12 = a;
}

// Team angles (teams start from 0).
float teamAngle0 = 0.0; float teamAngle1 = 0.0; float teamAngle2  = 0.0; float teamAngle3  = 0.0;
float teamAngle4 = 0.0; float teamAngle5 = 0.0; float teamAngle6  = 0.0; float teamAngle7  = 0.0;
float teamAngle8 = 0.0; float teamAngle9 = 0.0; float teamAngle10 = 0.0; float teamAngle11 = 0.0;

float getTeamAngle(int id = 0) {
	if(id == 0) return(teamAngle0); if(id == 1) return(teamAngle1); if(id == 2)  return(teamAngle2);  if(id == 3)  return(teamAngle3);
	if(id == 4) return(teamAngle4); if(id == 5) return(teamAngle5); if(id == 6)  return(teamAngle6);  if(id == 7)  return(teamAngle7);
	if(id == 8) return(teamAngle8); if(id == 9) return(teamAngle9); if(id == 10) return(teamAngle10); if(id == 11) return(teamAngle11);
	return(0.0);
}

void setTeamAngle(int id = 0, float a = 0.0) {
	if(id == 0) teamAngle0 = a; if(id == 1) teamAngle1 = a; if(id == 2)  teamAngle2  = a; if(id == 3)  teamAngle3  = a;
	if(id == 4) teamAngle4 = a; if(id == 5) teamAngle5 = a; if(id == 6)  teamAngle6  = a; if(id == 7)  teamAngle7  = a;
	if(id == 8) teamAngle8 = a; if(id == 9) teamAngle9 = a; if(id == 10) teamAngle10 = a; if(id == 11) teamAngle11 = a;
}

// Player offset angles describing how much a player's angle differs from the angle the team is facing.
float playerTeamOffsetAngle1 = 0.0; float playerTeamOffsetAngle2  = 0.0; float playerTeamOffsetAngle3  = 0.0; float playerTeamOffsetAngle4  = 0.0;
float playerTeamOffsetAngle5 = 0.0; float playerTeamOffsetAngle6  = 0.0; float playerTeamOffsetAngle7  = 0.0; float playerTeamOffsetAngle8  = 0.0;
float playerTeamOffsetAngle9 = 0.0; float playerTeamOffsetAngle10 = 0.0; float playerTeamOffsetAngle11 = 0.0; float playerTeamOffsetAngle12 = 0.0;

float getPlayerTeamOffsetAngle(int t = 0) {
	if(t == 1) return(playerTeamOffsetAngle1); if(t == 2)  return(playerTeamOffsetAngle2);  if(t == 3)  return(playerTeamOffsetAngle3);  if(t == 4)  return(playerTeamOffsetAngle4);
	if(t == 5) return(playerTeamOffsetAngle5); if(t == 6)  return(playerTeamOffsetAngle6);  if(t == 7)  return(playerTeamOffsetAngle7);  if(t == 8)  return(playerTeamOffsetAngle8);
	if(t == 9) return(playerTeamOffsetAngle9); if(t == 10) return(playerTeamOffsetAngle10); if(t == 11) return(playerTeamOffsetAngle11); if(t == 12) return(playerTeamOffsetAngle12);
	return(0.0);
}

void setPlayerTeamOffsetAngle(int t = 0, float a = 0) {
	if(t == 1) playerTeamOffsetAngle1 = a; if(t == 2)  playerTeamOffsetAngle2  = a; if(t == 3)  playerTeamOffsetAngle3  = a; if(t == 4)  playerTeamOffsetAngle4  = a;
	if(t == 5) playerTeamOffsetAngle5 = a; if(t == 6)  playerTeamOffsetAngle6  = a; if(t == 7)  playerTeamOffsetAngle7  = a; if(t == 8)  playerTeamOffsetAngle8  = a;
	if(t == 9) playerTeamOffsetAngle9 = a; if(t == 10) playerTeamOffsetAngle10 = a; if(t == 11) playerTeamOffsetAngle11 = a; if(t == 12) playerTeamOffsetAngle12 = a;
}

/*******************
* TYPE CONVERSIONS *
*******************/

/*
** Convets a bool to a string.
**
** @param b: the bool to convert
**
** @returns: "true" if b is true, "false" otherwise
*/
string boolToString(bool b = true) {
	if(b) {
		return("true");
	}

	return("false");
}

/*
** Convets an int to a float (I often prefer to use 1.0 * ... directly instead of this).
**
** @param i: the int to convert
**
** @returns: the converted int as a float
*/
float intToFloat(int i = 0) {
	return(0.0 + i);
}

/*
** Convets a float to an int.
**
** @param f: the float to convert
**
** @returns: the converted float as an int
*/
int floatToInt(float f = 0.0) {
	return(1 * f);
}

/*****************
* MAP DIMENSIONS *
*****************/

// If one side is larger than the other, you can squash it using this factor (1.0 for the smaller side, < 1.0 for the larger side).
float dimFactorX = 1.0;
float dimFactorZ = 1.0;

// "Constants" that are set via setMapSize() so we don't have to calculate them over and over again.
float xMeters = 0.0;
float zMeters = 0.0;

/*
** Shortcut to the most common function used to determine the length of the x/z dimensions.
**
** @param playerTiles: the number of tiles to use per player
** @param tileDivisor: the divisior used to further adjust the tile value (default 0.9, set to 1.0 on some maps)
** @param preFactor: the factor to apply after calculating the sqrt (default 2.0)
** @param sizeFactor: the factor used to scale the map (normal/large/...); used as factor with sizeFactor^cMapSize
** @param playerOverride: overrides cNonGaiaPlayers if set
**
** @returns: the calculated map size (to be used as meters)
*/
float getStandardMapDimInMeters(int playerTiles = 7500, float tileDivisor = 0.9, float preFactor = 2.0, float sizeFactor = 1.3, int playerOverride = -1) {
	if(playerOverride < 0) {
		playerOverride = cNonGaiaPlayers;
	}

	return(preFactor * sqrt(playerOverride * (pow(sizeFactor, cMapSize) * playerTiles) / tileDivisor));
}

/*
** Returns the distance from the center to the corner in meters.
**
** @returns: distance from center to corner in meters
*/
float getCornerRadiusInMeters() {
	return(sqrt(sq(0.5 * xMeters) + sq(0.5 * zMeters)));
}

/*
** Has to be used instead of rmSetMapSize() and rmTerrainInitialize().
**
** The reason we have two factors (dimFactorX and dimFactorZ is that we can always easily shorten the longer side.
** This way we can stick to the distances we are used to (in meters), even in rectangular maps.
**
** The x/z dimension length will be converted to integers if provided as float,
** since the argument type overrides the type in the function signature in xs.
**
** @param terrain: the type of terrain to initialize; "Water" for initializing to water
** @param x0: x dimension in meters
** @param z0: z dimension in meters
*/
void initializeMap(string terrain = "Water", int x0 = 0, int z0 = -1) {
	// Force conversion to int if parameters were provided as floats (xs doesn't convert them to int despite the function signature).
	int x = x0;
	int z = z0;

	if(z < 0) {
		z = x;
	}

	rmSetMapSize(x, z);

	rmTerrainInitialize(terrain);

	xMeters = rmXFractionToMeters(1.0);
	zMeters = rmZFractionToMeters(1.0);

	if(x >= z) {
		// X longer dimension.
		dimFactorX = 1.0 * z / x; // * 1.0 to avoid int division.
	} else {
		// Z longer dimension.
		dimFactorZ = 1.0 * x / z; // * 1.0 to avoid int division.
	}

	printDebug("Map size: " + x + " x " + z, cDebugTest);
	printDebug("Radius to corner: " + floatToInt(getCornerRadiusInMeters()), cDebugTest);
}

/*
** Gets the dimension factor for x axis.
**
** @returns: the dimension factor of the x axis as float.
*/
float getDimFacX() {
	return(dimFactorX);
}

/*
** Gets the dimension factor for z axis.
**
** @returns: the dimension factor of the z axis as float.
*/
float getDimFacZ() {
	return(dimFactorZ);
}

/*
** Returns the length of the x axis.
**
** @returns: length of the x axis in meters
*/
float getFullXMeters() {
	return(xMeters);
}

/*
** Returns the length of the z axis.
**
** @returns: length of the z axis in meters
*/
float getFullZMeters() {
	return(zMeters);
}

/*
** Checks if the x dimension of this map is larger than the z dimension.
**
** @returns: true if the x dimension is larger, false otherwise
*/
bool isXLargerZ() {
	return(xMeters > zMeters);
}

/*
** Adjusts a single coordinate to fit within the map in [0, 1.0].
**
** @param x: the coordinate as a fraction
**
** @returns: the adjusted coordinate value
*/
float fitToMap(float x = 0.0) {
	if(x < 0.0) {
		return(0.0);
	}

	if(x > 1.0) {
		return(1.0);
	}

	return(x);
}

/**********************
* SPATIAL CONVERSIONS *
**********************/

/*
** Converts/stretches a square radius (as used by the original placement functions) to a circular one.
** Useful to adjust the maximum radius of an object if you want to use the original ES ranges, but use it with circular placement.
**
** @param r: the old radius
**
** @returns: the stretched radius
*/
float squaredToCircularRadius(float r = 0.0) {
	return(SQRT_2 * r);
}

/*
** Can be used to wrap a radius (in meters) for rmSetAreaSize().
** Since the latter function considers its input as a fraction of the total map area (i.e., size of x * size of z) to cover,
** this can be used to place areas with a certain radius size (as long as they are within map bounds!).
**
** This function considers rectangular maps, i.e., will maintain the radius of the circle regardless of the map dimensions.
**
** @param r: the radius to wrap in meters
**
** @returns: the wrapped radius in meters
*/
float areaRadiusMetersToFraction(float r = 0.0) {
	return(sq(r) * PI / (getFullXMeters() * getFullZMeters()));
}

/*
** Converts a fraction to meters according to the smaller dimension of the map.
**
** @param frac: the fraction to convert
**
** @returns: the converted fraction in meters
*/
float smallerFractionToMeters(float frac = 0.0) {
	if(isXLargerZ()) {
		return(rmZFractionToMeters(frac));
	}

	return(rmXFractionToMeters(frac));
}

/*
** Converts a fraction to meters according to the larger dimension of the map.
**
** @param frac: the fraction to convert
**
** @returns: the converted fraction in meters
*/
float largerFractionToMeters(float frac = 0.0) {
	if(isXLargerZ()) {
		return(rmXFractionToMeters(frac));
	}

	return(rmZFractionToMeters(frac));
}

/*
** Converts meters to a fraction according to the smaller dimension of the map.
**
** @param meters: the meters to convert
**
** @returns: the resulting fraction
*/
float smallerMetersToFraction(float meters = 0.0) {
	if(isXLargerZ()) {
		return(rmZMetersToFraction(meters));
	}

	return(rmXMetersToFraction(meters));
}

/*
** Converts meters to a fraction according to the larger dimension of the map.
**
** @param meters: the meters to convert
**
** @returns: the resulting fraction
*/
float largerMetersToFraction(float meters = 0.0) {
	if(isXLargerZ()) {
		return(rmXMetersToFraction(meters));
	}

	return(rmZMetersToFraction(meters));
}

/*********************
* RANDOMIZATION UTIL *
*********************/

/*
** Randomly returns true or false for a given chance.
**
** @param trueChance: the chance to return true
**
** @returns: true if the randomized value lies in [0, 0.5), false otherwise
*/
bool randChance(float trueChance = 0.5) {
	if(rmRandFloat(0.0, 1.0) < trueChance) {
		return(true);
	}

	return(false);
}

/*
** Calculates a random float with a higher chance for a smaller value.
**
** @param x: minimum value
** @param y: maximum value
**
** @returns: the randomized float
*/
float randSmallFloat(float x = 0.0, float y = 1.0) {
	return(sq(rmRandFloat(sqrt(x), sqrt(y))));
}

/*
** Calculates a random float with a higher chance for a larger value.
**
** @param x: minimum value
** @param y: maximum value
**
** @returns: the randomized float
*/
float randLargeFloat(float x = 0.0, float y = 1.0) {
	return(sqrt(rmRandFloat(sq(x), sq(y))));
}

/*
** Calculates a random int with a higher chance for a smaller value.
**
** @param x: minimum value
** @param y: maximum value
**
** @returns: the randomized int
*/
int randSmallInt(int x = 0, int y = 0) {
	return(0 + sq(rmRandFloat(sqrt(x), sqrt(y + 1))));
}

/*
** Calculates a random int with a higher chance for a larger value.
**
** @param x: minimum value
** @param y: maximum value
**
** @returns: the randomized int
*/
int randLargeInt(int x = 0, int y = 0) {
	return(0 + sqrt(rmRandFloat(sq(x), sq(y + 1))));
}

/*
** Calculates a random angle in [-PI, PI].
**
** @returns: the randomized angle in radians
*/
float randRadian() {
	return(rmRandFloat(0.0 - PI, PI));
}

/*
** Randomizes an equally distributed value from two intervals.
** Essentially, this concatenates the intervals and adds an offset after randomizing if a value in range of the second interval was chosen.
**
** @param aStart: start of the first interval
** @param aEnd: end of the first interval
** @param bStart: start of the second interval
** @param bEnd: end of the second interval
**
** @returns: the randomized value
*/
float randFromIntervals(float aStart = 0.0, float aEnd = 0.0, float bStart = INF, float bEnd = INF) {
	if(abs(bEnd - bStart) < TOL) {
		return(rmRandFloat(aStart, aEnd));
	}

	float diff = bStart - aEnd;
	float rand = rmRandFloat(aStart, aEnd + (bEnd - bStart));

	if(rand > aEnd) {
		rand = rand + diff;
	}

	return(rand);
}

/*
** Calculates a random radius within a given interval [minDist, maxDist] with respect to map dimensions.
** Note that this function expects the radius in meters as input (and not as a fraction) and returns the radius as a fraction!
** Uses the shorter dimension for calculation.
**
** @param minDist: the minimum radius distance in meters
** @param maxDist: the maximum radius distance in meters
**
** @returns: the randomized radius as a fraction (!)
*/
float randRadiusFromInterval(float minDist = 0.0, float maxDist = -1.0) {
	if(maxDist < 0.0) {
		maxDist = minDist;
	}

	if(getFullXMeters() > getFullZMeters()) {
		return(rmZMetersToFraction(rmRandFloat(minDist, maxDist)));
	}

	return(rmXMetersToFraction(rmRandFloat(minDist, maxDist)));
}

/*
** Calculates a random radius within [0, r] with respect to map dimensions.
**
** Also see randRadiusFromInterval().
**
** @param r: the maximum radius distance in meters
**
** @returns: the randomized radius as a fraction (!)
*/
float randRadiusFromZero(float r = 0.0) {
	return(randRadiusFromInterval(0.0, r));
}

/*
** Calculates a random radius between minDist and the edge of the map with respect to map dimensions.
**
** Also see randRadiusFromInterval().
**
** @param r: the maximum radius distance in meters
**
** @returns: the randomized radius as a fraction (!)
*/
float randRadiusFromCenterToEdge(float minDist = 0.0) {
	float maxDist = sqrt(sq(0.5 * getFullXMeters()) + sq(0.5 * getFullZMeters())); // Max distance to reach from center.

	return(randRadiusFromInterval(minDist, maxDist));
}

/******************
* PLAYER LOC UTIL *
******************/

/*
** Retrieves a player's x location, including for player 0 (Mother Nature) at 0.5/0.5.
**
** @param player: the player (unmapped)
**
** @returns: the x coordinate of the player's location
*/
float getPlayerLocXFraction(int player = 0) {
	if(player == 0) {
		return(0.5);
	}

	return(rmPlayerLocXFraction(getPlayer(player)));
}

/*
** Retrieves a player's z location, including for player 0 (Mother Nature) at 0.5/0.5.
**
** @param player: the player (unmapped)
**
** @returns: the x coordinate of the player's location
*/
float getPlayerLocZFraction(int player = 0) {
	if(player == 0) {
		return(0.5);
	}

	return(rmPlayerLocZFraction(getPlayer(player)));
}

/*
** Calculates the x coordinate of a location with respect to a player, including player 0 (Mother Nature).
**
** @param player: the player (unmapped)
** @param radius: the radius as a fraction
** @param angle: the angle in radians
** @param square: if true, the radius will be transformed to a square instead of a circle from the player's origin
**
** @returns: the calculated x coordinate
*/
float getXFromPolarForPlayer(int player = 0, float radius = 0.0, float angle = 0.0, bool square = false) {
	angle = angle + getPlayerAngle(player);

	// Square vs. circular distance from origin.
	if(square) {
		// Allow the range to be a square instead of a circle (as the original placement functions do).
		float xPol = getXFromPolar(radius, angle, 0.0) * getDimFacX();
		float zPol = getZFromPolar(radius, angle, 0.0) * getDimFacZ();

		return(mapXToSquare(xPol, zPol) + getPlayerLocXFraction(player));
	}

	return(getXFromPolar(radius, angle, 0.0) * getDimFacX() + getPlayerLocXFraction(player));
}

/*
** Calculates the z coordinate of a location with respect to a player, including player 0 (Mother Nature).
**
** @param player: the player (unmapped)
** @param radius: the radius as a fraction
** @param angle: the angle in radians
** @param square: if true, the radius will be transformed to a square instead of a circle from the player's origin
**
** @returns: the calculated z coordinate
*/
float getZFromPolarForPlayer(int player = 0, float radius = 0.0, float angle = 0.0, bool square = false) {
	angle = angle + getPlayerAngle(player);

	// Square vs. circular distance from origin.
	if(square) {
		// Allow the range to be a square instead of a circle (as the original placement functions do).
		float xPol = getXFromPolar(radius, angle, 0.0) * getDimFacX();
		float zPol = getZFromPolar(radius, angle, 0.0) * getDimFacZ();

		return(mapZToSquare(xPol, zPol) + getPlayerLocZFraction(player));
	}

	return(getZFromPolar(radius, angle, 0.0) * getDimFacZ() + getPlayerLocZFraction(player));
}

/*******************
* PLAYER PLACEMENT *
*******************/

/*
** Calculates the angles of the teams (i.e., the direction the team is facing towards the center).
** This is currently not ideal when placing teams separately (e.g. on Anatolia) as this is called multiple times.
** However, I would refrain from requiring a separate call to this as it could easily be forgotten and is not much overhead anyway.
**
** If you place players yourself you have to call this manually.
** Furthermore, if you place players in a fashion such that getPlayer(1) is not next to getPlayer(2) etc., you may have to calculate team angles yourself.
** Calculating this value is crucial for fair locations and for mirroring.
*/
void calcPlayerTeamOffsetAngles() {
	int currPlayer = 1;
	int angleOffsetPlayer = 1;
	float lastAngle = NINF;

	for(i = 0; < cTeams) {
		float teamAngle = 0.0;

		// For every team, iterate over players and sum up angles to calculate the offset of a player from team direction.
		for(j = 0; < getNumberPlayersOnTeam(i)) {
			float playerAngle = getPlayerAngle(currPlayer);

			// Adjust angle so we always have increasing player angles. Note that some functions of the framework take this assumption for granted!
			while(playerAngle < lastAngle) {
				playerAngle = playerAngle + 2.0 * PI;
			}

			setPlayerAngle(currPlayer, playerAngle);
			teamAngle = teamAngle + playerAngle;

			lastAngle = playerAngle;
			currPlayer++;
		}

		float normalizedTeamAngle = teamAngle / getNumberPlayersOnTeam(i);

		while(normalizedTeamAngle > 2.0 * PI) {
			normalizedTeamAngle = normalizedTeamAngle - 2.0 * PI;
		}

		setTeamAngle(i, normalizedTeamAngle);

		float teamOffsetAngle = teamAngle / getNumberPlayersOnTeam(i);

		for(j = 0; < getNumberPlayersOnTeam(i)) {
			setPlayerTeamOffsetAngle(angleOffsetPlayer, teamOffsetAngle - getPlayerAngle(angleOffsetPlayer)); // Team angle array starts also at 1.
			angleOffsetPlayer++;
		}
	}
}

/*
** Places players in a circle. Placement occurs counterclockwise from the starting angle.
** This is just an example of a circular placement function, for specific maps it may be sensible to implement your own function.
**
** @param minRadius: the minimum radius to randomize from in the shorter dimension as a fraction
** @param maxRadius: the maximum radius to randomize from in the shorter dimension as a fraction
** @param spacing: spacing modifier; 1.0 -> equidistant spacing between players, < 1.0 -> teams closer together
** @param range: percentage of the circle to use for placement (1.0 = 360 degrees)
** @param angle: angle (radian) at which to place the first player at, randomized on default
** @param offsetX: x offset (0.5 = center of x axis)
** @param offsetZ: z offset (0.5 = center of z axis)
**
** @returns: the radius that was chosen to place the players as a fraction
*/
float placePlayersInCircle(float minRadius = 0.0, float maxRadius = -1.0, float spacing = 1.0, float range = 1.0, float angle = INF, float offsetX = 0.5, float offsetZ = 0.5) {
	if(maxRadius < minRadius) {
		maxRadius = minRadius;
	}

	float radius = rmRandFloat(minRadius, maxRadius);

	printDebug("Player placement radius: " + radius, cDebugTest);

	// Calculate the segment to append after every iteration. Regular = within team, last = before next team gets placed (due to spacing).
	float reg = spacing * ((2.0 * PI) / cNonGaiaPlayers);
	float last = reg + (2.0 * PI - reg * cNonGaiaPlayers) / cTeams;

	// Adjust if custom range set.
	if(range < 1.0) {
		reg = spacing * ((2.0 * PI * range) / (cNonGaiaPlayers - 1));
		last = reg + (2.0 * PI * range - reg * (cNonGaiaPlayers - 1)) / (cTeams - 1);
	}

	if(angle == INF) {
		angle = randRadian();
	}

	float a = angle; // Just to make sure because 0 is interpreted as an int if we use the parameter variable.

	int player = 1;

	for(i = 0; < cTeams) {
		for(j = 0; < getNumberPlayersOnTeam(i)) {
			float x = getXFromPolar(radius, a, 0.0) * getDimFacX() + offsetX;
			float z = getZFromPolar(radius, a, 0.0) * getDimFacZ() + offsetZ;

			// Place player and set angle.
			rmPlacePlayer(getPlayer(player), x, z);
			setPlayerAngle(player, a);

			// Add current angle and prepare next iteration.
			if(j < getNumberPlayersOnTeam(i) - 1) {
				a = a + reg;
			} else {
				a = a + last;
			}

			player++;
		}
	}

	calcPlayerTeamOffsetAngles();

	// Return the randomed radius in case it's needed in the map script.
	return(radius);
}

/*
** Places players of a given team in a circle. Placement occurs counterclockwise from the starting angle.
** The different order of parameters compared to placePlayersInCircle() is chosen due to range being a lot less relevant here.
** Doesn't take a min/max to randomize from due to placing separate teams with different radii should not be necessarily.
** Therefore, you should randomize the radius directly in the random map script and then use the same radius for all teams when using this function for placement.
**
** @param teamID: the ID of the team (starting at 0)
** @param radius: radius in the shorter dimension as a fraction
** @param range: percentage of the circle to use for placement (1.0 = 360 degrees)
** @param angle: angle (radian) at which to place the first player at, randomized on default
** @param offsetX: x offset (0.5 = center of x axis)
** @param offsetZ: z offset (0.5 = center of z axis)
*/
void placeTeamInCircle(int teamID = -1, float radius = 0.0, float range = 1.0, float angle = INF, float offsetX = 0.5, float offsetZ = 0.5) {
	printDebug("Team " + teamID + " placement radius: " + radius, cDebugTest);

	int numPlayers = getNumberPlayersOnTeam(teamID);
	int player = 1;

	for(i = 0; < teamID) {
		player = player + getNumberPlayersOnTeam(i);
	}

	float reg = (2.0 * PI) / numPlayers;

	// Adjust if custom range set.
	if(range < 1.0) {
		reg = (2.0 * PI * range) / max(1, numPlayers - 1);
	}

	// Set initial angle.
	if(angle == INF) {
		angle = randRadian();
	}

	float a = angle; // Just to make sure because 0 is interpreted as an int if we use the parameter variable.

	// Adjust initial angle by team offset.
	if(range != 1.0 && numPlayers > 1) {
		a = a - range * PI;
	}

	for(i = 0; < numPlayers) {
		float x = getXFromPolar(radius, a, 0.0) * getDimFacX() + offsetX;
		float z = getZFromPolar(radius, a, 0.0) * getDimFacZ() + offsetZ;

		// Place player and set angle.
		rmPlacePlayer(getPlayer(player), x, z);
		setPlayerAngle(player, a);

		// Add current angle and prepare next iteration.
		a = a + reg;
		player++;
	}

	calcPlayerTeamOffsetAngles();
}

/*
** Places players in a square.
** Note that this mimicks the original rmPlacePlayersSquare function and does not necessarily result in equidistant player placement.
** Instead, if the next player is placed around a corner, the distance will be shorter.
**
** If you want to do fancier stuff like placing each team in a U shape, I'd recommend tweaking the circular placement function (with range) by mapping the circle to a square.
** This can be achieved with mapXToSquare() and mapZToSquare() (mind that the offset has to be added AFTER this calculation) and will result in equidistant square placement.
**
** @param minRadius: the minimum radius to randomize from in the shorter dimension as a fraction
** @param maxRadius: the maximum radius to randomize from in the shorter dimension as a fraction
** @param spacing: spacing modifier; 1.0 -> equidistant spacing between players, < 1.0 -> teams closer together
**
** @returns: the radius that was chosen to place the players as a fraction
*/
float placePlayersInSquare(float minRadius = 0.0, float maxRadius = -1.0, float spacing = 1.0) {
	if(maxRadius < minRadius) {
		maxRadius = minRadius;
	}

	float radius = rmRandFloat(minRadius, maxRadius);

	printDebug("Placement radius: " + radius, cDebugTest);

	// Edge distance in meters.
	float edgeDist = (0.5 * getFullXMeters() - rmXFractionToMeters(radius)) * getDimFacX();

	// Throughout this function, x and z are considered in meters.
	float x = 0.0;
	float z = 0.0;

	// Sets the direction we're moving; true = along x axis, false = along z axis.
	bool xStep = false;

	// Randomize starting point.
	if(randChance()) {
		// Fix x on either side, randomize z anywhere along the z axis.
		if(randChance()) {
			x = edgeDist;
		} else {
			x = getFullXMeters() - edgeDist;
		}

		z = rmRandFloat(edgeDist, getFullZMeters() - edgeDist);
	} else {
		// Fix z on either side, randomize x anywhere along the x axis.
		if(randChance()) {
			z = edgeDist;
		} else {
			z = getFullZMeters() - edgeDist;
		}

		x = rmRandFloat(edgeDist, getFullXMeters() - edgeDist);
		xStep = true;
	}

	// Circumference.
	float circ = 2.0 * getFullXMeters() + 2.0 * getFullZMeters() - 8.0 * edgeDist;

	// Distance between players of the same team (smaller if spacing is < 1.0).
	float sameTeamDist = (circ / cNonGaiaPlayers) * spacing;

	// Distance between players of different teams (larger if spacing is < 1.0).
	float diffTeamDist = sameTeamDist + (circ - (sameTeamDist * cNonGaiaPlayers)) / cTeams;

	int player = 1;

	// Iterate over teams.
	for(i = 0; < cTeams) {

		// Iterate over players per team.
		for(j = 0; < getNumberPlayersOnTeam(i)) {

			// Get starting position as fraction.
			float xFrac = rmXMetersToFraction(x);
			float zFrac = rmZMetersToFraction(z);

			// Place player and set angle.
			rmPlacePlayer(getPlayer(player), xFrac, zFrac);
			setPlayerAngle(player, getAngleFromCartesian(xFrac, zFrac, 0.5, 0.5));
			player++;

			float dist = 0.0;
			float nextDist = 0.0;

			if(j == getNumberPlayersOnTeam(i) - 1) {
				nextDist = diffTeamDist; // New team next, larger gap.
			} else {
				nextDist = sameTeamDist; // Same team next, smaller gap if team spacing has been set.
			}

			// Move along the square until the next position is reached. Ignore redundant ultimate iteration.
			while(dist < nextDist && (i != cTeams - 1 || j != getNumberPlayersOnTeam(i) - 1)) {
				/*
				 * xStep:
				 * z > 0.5 * getFullZMeters(): Currently in upper half, subtract.
				 * z < 0.5 * getFullZMeters(): Currently in lower half, add.
				 *
				 * zStep:
				 * x > 0.5 * getFullXMeters(): Currently in right half, add.
				 * x < 0.5 * getFullXMeters(): Currently in left half, subtract.
				 *
				 * Note that we have to add some minimum value (set to 0.1) to ensure progress due to inaccuracies in float addition.
				*/
				float newVal = 0.0;

				if(xStep == true) {

					if(z < 0.5 * getFullZMeters()) {
						// Lower half: Add as much as possible before overshooting.
						newVal = min(x + (nextDist - dist), getFullXMeters() - edgeDist);
						dist = dist + max(newVal - x, 0.1);
					} else {
						// Upper half: Subtract as much as possible before overshooting.
						newVal = max(x - (nextDist - dist), edgeDist);
						dist = dist + max(x - newVal, 0.1);
					}

					x = newVal;

					if(x >= getFullXMeters() - edgeDist || x <= edgeDist) {
						xStep = false;
					}

				} else {

					if(x < 0.5 * getFullXMeters()) {
						// Left half: Subtract as much as possible before overshooting.
						newVal = max(z - (nextDist - dist), edgeDist);
						dist = dist + max(z - newVal, 0.1);
					} else {
						// Right half: Add as much as possible before overshooting.
						newVal = min(z + (nextDist - dist), getFullZMeters() - edgeDist);
						dist = dist + max(newVal - z, 0.1);
					}

					z = newVal;

					if(z >= getFullZMeters() - edgeDist || z <= edgeDist) {
						xStep = true;
					}

				}
			}

		}

	}

	calcPlayerTeamOffsetAngles();

	return(radius);
}

/*
** Places players of a team in a line.
**
** @param teamID: ID of the team to be placed, starting at 0
** @param x1: x fraction of the placement starting location
** @param z1: z fraction of the placement starting location
** @param x2: x fraction of the placement ending location
** @param z2: z fraction of the placement ending location
*/
void placeTeamInLine(int teamID = -1, float x1 = 0.0, float z1 = 0.0, float x2 = 0.0, float z2 = 0.0) {
	int numPlayers = getNumberPlayersOnTeam(teamID);

	float xDist = (x2 - x1) / (numPlayers - 1);
	float zDist = (z2 - z1) / (numPlayers - 1);

	float x = x1;
	float z = z1;
	int player = 1;

	for(i = 0; < teamID) {
		player = player + getNumberPlayersOnTeam(i);
	}

	// Special case for 1 player in team.
	if(getNumberPlayersOnTeam(teamID) == 1) {
		x = x + 0.5 * (x2 - x1);
		z = z + 0.5 * (z2 - z1);
	}

	for(j = 0; < getNumberPlayersOnTeam(i)) {
		// Place player and set angle.
		rmPlacePlayer(getPlayer(player), x, z);
		setPlayerAngle(player, getAngleFromCartesian(x, z, 0.5, 0.5));
		player++;

		// Update coordinates for next iteration.
		x = x + xDist;
		z = z + zDist;
	}

	calcPlayerTeamOffsetAngles();
}

/*
** Places all players in a line.
**
** @param x1: x fraction of the placement starting location
** @param z1: z fraction of the placement starting location
** @param x2: x fraction of the placement ending location
** @param z2: z fraction of the placement ending location
** @param spacing: spacing modifier; 1.0 -> equidistant spacing between players, < 1.0 -> teams closer together
*/
void placePlayersInLine(float x1 = 0.0, float z1 = 0.0, float x2 = 0.0, float z2 = 0.0, float spacing = 1.0) {
	float xDistSameTeam = (x2 - x1) / (cNonGaiaPlayers - 1) * spacing;
	float zDistSameTeam = (z2 - z1) / (cNonGaiaPlayers - 1) * spacing;

	float xDistDiffTeam = ((x2 - x1) - (xDistSameTeam * (cNonGaiaPlayers - cTeams))) / (cTeams - 1);
	float zDistDiffTeam = ((z2 - z1) - (zDistSameTeam * (cNonGaiaPlayers - cTeams))) / (cTeams - 1);

	float x = x1;
	float z = z1;
	int player = 1;

	for(i = 0; < cTeams) {
		for(j = 0; < getNumberPlayersOnTeam(i)) {
			// Place player and set angle.
			rmPlacePlayer(getPlayer(player), x, z);
			setPlayerAngle(player, getAngleFromCartesian(x, z, 0.5, 0.5));
			player++;

			if(j == getNumberPlayersOnTeam(i) - 1) {
				// New team next, larger gap.
				x = x + xDistDiffTeam;
				z = z + zDistDiffTeam;
			} else {
				// Same team next, smaller gap if team spacing has been set.
				x = x + xDistSameTeam;
				z = z + zDistSameTeam;
			}
		}
	}

	calcPlayerTeamOffsetAngles();
}

/*********************
* CONSTRAINT UTILITY *
*********************/

// Since we cannot retrieve created constraints by name, the label only has descriptive purpose.
const string cConstraintName = "rmx constraint";

int constraintCount = 0;

/*
** Creates a box constraint without needing to specify a label.
**
** @param startX: start of the x value of the box
** @param startZ: start of the z value of the box
** @param endX: end of the x value of the box
** @param endZ: end of the z value of the box
** @param bufferFraction: one of the few values that I am still unsure what it does - bad if missing, so just provide it anyway
**
** @returns: the ID of the created constraint
*/
int createBoxConstraint(float startX = 0.0, float startZ = 0.0, float endX = 0.0, float endZ = 0.0, float bufferFraction = NINF) {
	constraintCount++;

	if(bufferFraction == NINF) {
		return(rmCreateBoxConstraint(cConstraintName + constraintCount, startX, startZ, endX, endZ));
	}

	return(rmCreateBoxConstraint(cConstraintName + constraintCount, startX, startZ, endX, endZ, bufferFraction));
}

/*
** Creates a symmetric box constraint.
**
** @param distX: start/end of the x value of the box as a fraction
** @param distZ: start/end of the z value of the box as a fraction
** @param bufferFraction: one of the few values that I am still unsure what it does - bad if missing, so just provide it anyway
**
** @returns: the ID of the created constraint
*/
int createSymmetricBoxConstraint(float distX = 0.0, float distZ = -1.0, float bufferFraction = NINF) {
	constraintCount++;

	if(distZ < 0.0) {
		distZ = distX;
	}

	// Use without bufferFraction argument if it has not been set.
	if(bufferFraction == NINF) {
		return(rmCreateBoxConstraint(cConstraintName + constraintCount, distX, distZ, 1.0 - distX, 1.0 - distZ));
	}

	return(rmCreateBoxConstraint(cConstraintName + constraintCount, distX, distZ, 1.0 - distX, 1.0 - distZ, bufferFraction));
}


/*
** Creates an area overlap constraint without needing to specify a label.
**
** @param areaID: the ID of the area to avoid overlapping with
**
** @returns: the ID of the created constraint
*/
int createAreaOverlapConstraint(int areaID = -1) {
	constraintCount++;
	return(rmCreateAreaOverlapConstraint(cConstraintName + constraintCount, areaID));
}

/*
** Creates an area constraint without needing to specify a label.
**
** @param areaID: the ID of the area to force an object or area to be placed in
**
** @returns: the ID of the created constraint
*/
int createAreaConstraint(int areaID = -1) {
	constraintCount++;
	return(rmCreateAreaConstraint(cConstraintName + constraintCount, areaID));
}

/*
** Creates an area distance constraint without needing to specify a label.
**
** @param areaID: the ID of the area
** @param dist: the minimum distance an object or area can be from the area
**
** @returns: the ID of the created constraint
*/
int createAreaDistConstraint(int areaID = -1, float dist = 0.0) {
	constraintCount++;
	return(rmCreateAreaDistanceConstraint(cConstraintName + constraintCount, areaID, dist));
}

/*
** Creates an area maximum distance constraint without needing to specify a label.
**
** @param areaID: the ID of the area
** @param dist: the maximum distance an object or area can be from the area
**
** @returns: the ID of the created constraint
*/
int createAreaMaxDistConstraint(int areaID = -1, float dist = 0.0) {
	constraintCount++;
	return(rmCreateAreaMaxDistanceConstraint(cConstraintName + constraintCount, areaID, dist));
}

/*
** Creates an edge constraint without needing to specify a label.
**
** @param areaID: the ID of the area of the edge to force an object or area to be placed in
**
** @returns: the ID of the created constraint
*/
int createEdgeConstraint(int areaID = -1) {
	constraintCount++;
	return(rmCreateEdgeConstraint(cConstraintName + constraintCount, areaID));
}

/*
** Creates an edge distance constraint without needing to specify a label.
**
** @param areaID: the ID of the area
** @param dist: the minimum distance an object or area can be from the area's edge
**
** @returns: the ID of the created constraint
*/
int createEdgeDistConstraint(int areaID = -1, float dist = 0.0) {
	constraintCount++;
	return(rmCreateEdgeDistanceConstraint(cConstraintName + constraintCount, areaID, dist));
}

/*
** Creates an edge maximum distance constraint without needing to specify a label.
**
** @param areaID: the ID of the area
** @param dist: the maximum distance an object or area can be from the area's edge
**
** @returns: the ID of the created constraint
*/
int createEdgeMaxDistConstraint(int areaID = -1, float dist = 0.0) {
	constraintCount++;
	return(rmCreateEdgeMaxDistanceConstraint(cConstraintName + constraintCount, areaID, dist));
}

/*
** Creates a cliff edge constraint without needing to specify a label.
**
** @param areaID: the ID of the area of the edge to force an object or area to be placed in
**
** @returns: the ID of the created constraint
*/
int createCliffEdgeConstraint(int areaID = -1) {
	constraintCount++;
	return(rmCreateCliffEdgeConstraint(cConstraintName + constraintCount, areaID));
}

/*
** Creates a cliff edge distance constraint without needing to specify a label.
**
** @param areaID: the ID of the area
** @param dist: the minimum distance an object or area can be from the area's edge
**
** @returns: the ID of the created constraint
*/
int createCliffEdgeDistConstraint(int areaID = -1, float dist = 0.0) {
	constraintCount++;
	return(rmCreateCliffEdgeDistanceConstraint(cConstraintName + constraintCount, areaID, dist));
}

/*
** Creates a cliff edge maximum distance constraint without needing to specify a label.
**
** @param areaID: the ID of the area
** @param dist: the maximum distance an object or area can be from the area's edge
**
** @returns: the ID of the created constraint
*/
int createCliffEdgeMaxDistConstraint(int areaID = -1, float dist = 0.0) {
	constraintCount++;
	return(rmCreateCliffEdgeMaxDistanceConstraint(cConstraintName + constraintCount, areaID, dist));
}

/*
** Creates a cliff ramp constraint without needing to specify a label.
**
** @param areaID: the ID of the area of the ramp to force an object or area to be placed in
**
** @returns: the ID of the created constraint
*/
int createCliffRampConstraint(int areaID = -1) {
	constraintCount++;
	return(rmCreateCliffRampConstraint(cConstraintName + constraintCount, areaID));
}

/*
** Creates a cliff ramp distance constraint without needing to specify a label.
**
** @param areaID: the ID of the area
** @param dist: the minimum distance an object or area can be from the area's ramp
**
** @returns: the ID of the created constraint
*/
int createCliffRampDistConstraint(int areaID = -1, float dist = 0.0) {
	constraintCount++;
	return(rmCreateCliffRampDistanceConstraint(cConstraintName + constraintCount, areaID, dist));
}

/*
** Creates a cliff ramp maximum distance constraint without needing to specify a label.
**
** @param areaID: the ID of the area
** @param dist: the maximum distance an object or area can be from the area's ramp
**
** @returns: the ID of the created constraint
*/
int createCliffRampMaxDistConstraint(int areaID = -1, float dist = 0.0) {
	constraintCount++;
	return(rmCreateCliffRampMaxDistanceConstraint(cConstraintName + constraintCount, areaID, dist));
}

/*
** Creates a type distance constraint without needing to specify a label.
**
** @param type: the type to create a constraint for, like "All", "Gold", "Huntable", "Chicken", ...
** @param dist: the minimum distance in meters
**
** @returns: the ID of the created constraint
*/
int createTypeDistConstraint(string type = "", float dist = 0.0) {
	constraintCount++;
	return(rmCreateTypeDistanceConstraint(cConstraintName + constraintCount, type, dist));
}

/*
** Creates a class distance constraint without needing to specify a label.
**
** @param classID: the ID of the class to avoid
** @param dist: the minimum distance in meters
**
** @returns: the ID of the created constraint
*/
int createClassDistConstraint(int classID = -1, float dist = 0.0) {
	constraintCount++;
	return(rmCreateClassDistanceConstraint(cConstraintName + constraintCount, classID, dist));
}

/*
** Creates a class distance constraint without needing to specify a label.
**
** @param type: the type of terrain to create a constraint for, like "Land"
** @param passable: whether the terrain is passable or not
** @param dist: the minimum distance in meters
**
** @returns: the ID of the created constraint
*/
int createTerrainDistConstraint(string type = "", bool passable = false, float dist = 0.0) {
	constraintCount++;
	return(rmCreateTerrainDistanceConstraint(cConstraintName + constraintCount, type, passable, dist));
}

/*
** Creates a maximum class distance constraint without needing to specify a label.
**
** @param type: the type of terrain to create a constraint for, like "Land"
** @param passable: whether the terrain is passable or not
** @param dist: the maximum distance in meters
**
** @returns: the ID of the created constraint
*/
int createTerrainMaxDistConstraint(string type = "", bool passable = false, float dist = 0.0) {
	constraintCount++;
	return(rmCreateTerrainMaxDistanceConstraint(cConstraintName + constraintCount, type, passable, dist));
}

/*********************
* OBJECT DEF UTILITY *
*********************/

/*
** Sets the min/max distance of an object at the same time.
**
** @param objectID: the ID of the object
** @param minDist: the minimum distance to set
** @param maxDist: the maximum distance to set
*/
void setObjectDefDistance(int objectID = -1, float minDist = 0.0, float maxDist = -1.0) {
	if(maxDist < 0.0) {
		maxDist = minDist;
	}

	rmSetObjectDefMinDistance(objectID, minDist);
	rmSetObjectDefMaxDistance(objectID, maxDist);
}

/*
** Sets the min/max distance from 0.0 to the edge of the map (with center offset).
** Very useful for all the embellishment that is placed at 0.5/0.5 with range [0, rmFractionToMeters(0.5)].
** Could also be done for number/distance of area blobs, but these are used a lot frequently than object definitions.
**
** @param objectID: the ID of the object
** @param minDist: the minimum distance to set
*/
void setObjectDefDistanceToMax(int objectID = -1, float minDist = 0.0) {
	rmSetObjectDefMinDistance(objectID, minDist);
	rmSetObjectDefMaxDistance(objectID, largerFractionToMeters(0.5));
}

/*************
* CORE AREAS *
*************/

int playerAreaConstraint1 = -1; int playerAreaConstraint2  = -1; int playerAreaConstraint3  = -1; int playerAreaConstraint4  = -1;
int playerAreaConstraint5 = -1; int playerAreaConstraint6  = -1; int playerAreaConstraint7  = -1; int playerAreaConstraint8  = -1;
int playerAreaConstraint9 = -1; int playerAreaConstraint10 = -1; int playerAreaConstraint11 = -1; int playerAreaConstraint12 = -1;

int getPlayerAreaConstraint(int id = -1) {
	if(id == 1) return(playerAreaConstraint1); if(id == 2)  return(playerAreaConstraint2);  if(id == 3)  return(playerAreaConstraint3);  if(id == 4)  return(playerAreaConstraint4);
	if(id == 5) return(playerAreaConstraint5); if(id == 6)  return(playerAreaConstraint6);  if(id == 7)  return(playerAreaConstraint7);  if(id == 8)  return(playerAreaConstraint8);
	if(id == 9) return(playerAreaConstraint9); if(id == 10) return(playerAreaConstraint10); if(id == 11) return(playerAreaConstraint11); if(id == 12) return(playerAreaConstraint12);
	return(-1);
}

void setPlayerAreaConstraint(int id = -1, int cID = -1) {
	if(id == 1) playerAreaConstraint1 = cID; if(id == 2)  playerAreaConstraint2  = cID; if(id == 3)  playerAreaConstraint3  = cID; if(id == 4)  playerAreaConstraint4  = cID;
	if(id == 5) playerAreaConstraint5 = cID; if(id == 6)  playerAreaConstraint6  = cID; if(id == 7)  playerAreaConstraint7  = cID; if(id == 8)  playerAreaConstraint8  = cID;
	if(id == 9) playerAreaConstraint9 = cID; if(id == 10) playerAreaConstraint10 = cID; if(id == 11) playerAreaConstraint11 = cID; if(id == 12) playerAreaConstraint12 = cID;
}

int teamAreaConstraint1 = -1; int teamAreaConstraint2  = -1; int teamAreaConstraint3  = -1; int teamAreaConstraint4  = -1;
int teamAreaConstraint5 = -1; int teamAreaConstraint6  = -1; int teamAreaConstraint7  = -1; int teamAreaConstraint8  = -1;
int teamAreaConstraint9 = -1; int teamAreaConstraint10 = -1; int teamAreaConstraint11 = -1; int teamAreaConstraint12 = -1;

int getTeamAreaConstraint(int id = 0) {
	if(id == 1) return(teamAreaConstraint1); if(id == 2)  return(teamAreaConstraint2);  if(id == 3)  return(teamAreaConstraint3);  if(id == 4)  return(teamAreaConstraint4);
	if(id == 5) return(teamAreaConstraint5); if(id == 6)  return(teamAreaConstraint6);  if(id == 7)  return(teamAreaConstraint7);  if(id == 8)  return(teamAreaConstraint8);
	if(id == 9) return(teamAreaConstraint9); if(id == 10) return(teamAreaConstraint10); if(id == 11) return(teamAreaConstraint11); if(id == 12) return(teamAreaConstraint12);
	return(-1);
}

void setTeamAreaConstraint(int id = 0, int cID = -1) {
	if(id == 1) teamAreaConstraint1 = cID; if(id == 2)  teamAreaConstraint2  = cID; if(id == 3)  teamAreaConstraint3  = cID; if(id == 4)  teamAreaConstraint4  = cID;
	if(id == 5) teamAreaConstraint5 = cID; if(id == 6)  teamAreaConstraint6  = cID; if(id == 7)  teamAreaConstraint7  = cID; if(id == 8)  teamAreaConstraint8  = cID;
	if(id == 9) teamAreaConstraint9 = cID; if(id == 10) teamAreaConstraint10 = cID; if(id == 11) teamAreaConstraint11 = cID; if(id == 12) teamAreaConstraint12 = cID;
}

/*
 * This section contains important areas.
 * Split: Divides the map into sections, one per player (imagine having every player a piece of the cake).
 * Team Split: Same as split, but the areas are for teams (for instance, with 2 teams, each team gets half the map).
 * Centerline: Uses the splits to build line(s) between the players (filling out the space "left" by the split).
 * Center: Creates a single center area.
 * Corner: Creates areas in all 4 corners.
 *
 * The last three of these are more utility than anything else, but I put them here anyway so everything is found in one place.
*/

// IDs.
int classSplit = -1;
int classTeamSplit = -1;
int classCenterline = -1;
int classCenter = -1;
int classCorner = -1;

// Run once.
bool playerAreaConstraintsInitialized = false;
bool teamAreaConstraintsInitialized = false;

/*
** Virtually splits the map into separate player areas.
**
** @param splitDist: the distance between the player areas in meters (how much the areas avoid each other)
**
** @returns: ID of classSplit
*/
int initializeSplit(float splitDist = 10.0) {
	if(classSplit != -1) {
		return(classSplit);
	}

	classSplit = rmDefineClass(cSplitClassName);

	int splitConstraint = createClassDistConstraint(classSplit, splitDist);

	for(i = 1; < cPlayers) {
		int splitID = rmCreateArea(cSplitName + " " + i);
		rmSetAreaLocPlayer(splitID, getPlayer(i));
		rmSetPlayerArea(getPlayer(i), splitID);
		rmSetAreaSize(splitID, 1.0);
		// rmSetAreaTerrainType(splitID, "HadesBuildable1");
		// rmSetAreaBaseHeight(splitID, 2.0);
		rmSetAreaCoherence(splitID, 1.0);
		rmAddAreaToClass(splitID, classSplit);
		rmAddAreaConstraint(splitID, splitConstraint);
		rmSetAreaWarnFailure(splitID, false);
	}

	rmBuildAllAreas();

	return(classSplit);
}

/*
** Virtually splits the map into separate team areas.
**
** @param teamSplitDist: the distance between the team areas in meters (how much the areas avoid each other)
**
** @returns: ID of classTeamSplit
*/
int initializeTeamSplit(float teamSplitDist = 10.0) {
	if(classTeamSplit != -1) {
		return(classTeamSplit);
	}

	classTeamSplit = rmDefineClass(cTeamSplitClassName);

	int teamSplitConstraint = createClassDistConstraint(classTeamSplit, teamSplitDist);

	for(i = 0; < cTeams) {
		int teamSplitID = rmCreateArea(cTeamSplitName + " " + i);
		rmSetTeamArea(i, teamSplitID);
		rmSetAreaLocTeam(teamSplitID, i);
		rmSetAreaSize(teamSplitID, 1.0);
		// rmSetAreaTerrainType(teamSplitID, "HadesBuildable1");
		// rmSetAreaBaseHeight(teamSplitID, 2.0);
		rmSetAreaCoherence(teamSplitID, 1.0);
		rmAddAreaToClass(teamSplitID, classTeamSplit);
		rmAddAreaConstraint(teamSplitID, teamSplitConstraint);
		rmSetAreaWarnFailure(teamSplitID, false);
	}

	rmBuildAllAreas();

	return(classTeamSplit);
}

/*
** Creates a centerline based on virtual split.
** Note that this creates player or team splits if they do not already exists, as they are needed to build the center lines.
**
** @param onPlayerSplit: whether to use the player split or not (team split used if false), will be created if not defined already
** @param splitDist: the distance between the split areas in meters (how much the areas avoid each other) used to create the splits if not defined already
**
** @returns: ID of classCenterline
*/
int initializeCenterline(bool onPlayerSplit = true, float splitDist = 10.0) {
	if(classCenterline != -1) {
		return(classCenterline);
	}

	classCenterline = rmDefineClass(cCenterlineClassName);

	int centerlineID = rmCreateArea(cCenterlineName);
	rmSetAreaSize(centerlineID, 0.4);
	// rmSetAreaTerrainType(centerlineID, "HadesBuildable1");
	// rmSetAreaBaseHeight(centerlineID, 2.0);
	rmAddAreaToClass(centerlineID, classCenterline);
	if(onPlayerSplit) {
		initializeSplit(splitDist);
		rmAddAreaConstraint(centerlineID, createClassDistConstraint(classSplit, rmXMetersToFraction(1.0)));
	} else {
		initializeTeamSplit(splitDist);
		rmAddAreaConstraint(centerlineID, createClassDistConstraint(classTeamSplit, rmXMetersToFraction(1.0)));
	}
	rmSetAreaWarnFailure(centerlineID, false);

	rmBuildArea(centerlineID);

	return(classCenterline);
}

/*
** Initializes the center class along with a center area.
**
** @param radius: radius of the center area
**
** @returns: classCenter ID
*/
int initializeCenter(float radius = 25.0) {
	if(classCenter != -1) {
		return(classCenter);
	}

	classCenter = rmDefineClass(cCenterClassName);

	int centerID = rmCreateArea(cCenterName);
	rmSetAreaSize(centerID, areaRadiusMetersToFraction(radius));
	rmSetAreaLocation(centerID, 0.5, 0.5);
	// rmSetAreaTerrainType(centerID, "HadesBuildable1");
	// rmSetAreaBaseHeight(centerID, 2.0);
	rmSetAreaCoherence(centerID, 1.0);
	rmAddAreaToClass(centerID, classCenter);
	rmSetAreaWarnFailure(centerID, false);

	rmBuildArea(centerID);

	return(classCenter);
}

/*
** Initializes the corner class along with four corner areas.
**
** @param radius: radius of the corner areas
**
** @returns: ID of classCorner
*/
int initializeCorners(float radius = 40.0) {
	if(classCorner != -1) {
		return(classCorner);
	}

	classCorner = rmDefineClass(cCornerClassName);

	int cornerID = 0;

	for(i = 0; < 4) {
		cornerID = rmCreateArea(cCornerName + " " + i);
		// Adjust size; since the area is on the corner, we only need 1/4 of the area (we can only place by area, not by radius).
		rmSetAreaSize(cornerID, areaRadiusMetersToFraction(radius) / 4.0);
		// rmSetAreaLocation(cornerID, (i % 2), min(1, (i % 3))); // (Yes this would also cover all corners.)
		if(i == 0) {
			rmSetAreaLocation(cornerID, 1.0, 1.0);
		} else if(i == 1) {
			rmSetAreaLocation(cornerID, 0.0, 1.0);
		} else if(i == 2) {
			rmSetAreaLocation(cornerID, 1.0, 0.0);
		} else if(i == 3) {
			rmSetAreaLocation(cornerID, 0.0, 0.0);
		}
		// rmSetAreaTerrainType(cornerID, "HadesBuildable1");
		// rmSetAreaBaseHeight(cornerID, 2.0);
		rmSetAreaCoherence(cornerID, 1.0);
		rmAddAreaToClass(cornerID, classCorner);
		rmSetAreaWarnFailure(cornerID, false);

		rmBuildArea(cornerID);
	}

	return(classCorner);
}

/*
** Initializes player area constraints. Calls initializeSplit() if not called previously.
**
** @param splitDist: the distance between the player areas in meters (how much the areas avoid each other) in case player splits were not yet created
*/
void initializePlayerAreaConstraints(float splitDist = 10.0) {
	if(playerAreaConstraintsInitialized) {
		return;
	}

	initializeSplit(splitDist);

	for(i = 1; < cPlayers) {
		setPlayerAreaConstraint(i, createAreaConstraint(rmAreaID(cSplitName + " " + i)));
	}

	playerAreaConstraintsInitialized = true;
}

/*
** Initializes player area constraints. Calls initializeSplit() if not called previously.
**
** @param teamSplitDist: the distance between the team areas in meters (how much the areas avoid each other)
*/
void initializeTeamAreaConstraints(float teamSplitDist = 10.0) {
	if(teamAreaConstraintsInitialized) {
		return;
	}

	initializeTeamSplit(teamSplitDist);

	for(i = 1; < cPlayers) {
		setTeamAreaConstraint(i, createAreaConstraint(rmAreaID(cTeamSplitName + " " + rmGetPlayerTeam(getPlayer(i)))));
	}

	teamAreaConstraintsInitialized = true;
}
