/*
** General math functionality.
** RebelsRising
** Last edit: 13/05/2022
*/

/************
* CONSTANTS *
************/

extern const float PI = 3.14159265359;
extern const float NPI = -3.14159265359;
extern const float e = 2.71828182846;
extern const float SQRT_2 = 1.4142135624;
extern const float HALF_SQRT_2 = 0.7071067812;
extern const float INF = 9999999.0;
extern const float NINF = -9999999.0;
extern const float TOL = 0.0000001;
extern const int MAX_IT = 100;

/**********
* GENERAL *
**********/

/*
** Calculates the smaller of two floats.
**
** @param x: first float to compare
** @param y: second float to compare
**
** @returns: the smaller of the two floats
*/
float min(float x = 0.0, float y = INF) {
	if(x > y) {
		return(y);
	}

	return(x);
}

/*
** Calculates the larger of two floats.
**
** @param x: first float to compare
** @param y: second float to compare
**
** @returns: the larger of the two floats
*/
float max(float x = 0.0, float y = NINF) {
	if(x < y) {
		return(y);
	}

	return(x);
}

/*
** Floor function for floats.
**
** @param x: the float
**
** @returns: the floor value of x
*/
float floor(float x = 0.0) {
	if(x == 0 + x) {
		return(x); // Return x if x is an int for correctness.
	}

	return(0.0 + (0 + x));
}

/*
** Ceiling function for floats.
**
** @param x: the float
**
** @returns: the ceiling value of x
*/
float ceil(float x = 0.0) {
	if(x == 0 + x) {
		return(x); // Return x if x is an int for correctness.
	}

	return(0.0 + (1 + x));
}

/*
** Rounds a value for a given threshold.
**
** @param x: the value to round
** @param t: the threshold in (0.0, 1.0) to use for rounding up
**
** @returns: the rounded value
*/
float round(float x = 0.0, float t = 0.5) {
	int i = x;

	if(x - i >= t) {
		return(0.0 + (i + 1));
	}

	return(0.0 + i);
}

/*
** Calculates the absolute value of a float.
**
** @param x: the float to take the absolute value from
**
** @returns: the absolute value
*/
float abs(float x = 0.0) {
	if(x >= 0) {
		return(0.0 + x);
	}

	return(0.0 - x);
}

/*
** Calculates the squared value of a float.
**
** @param x: the float to square
**
** @returns: the squared value
*/
float sq(float x = 0.0) {
	return(x * x);
}

/*
** Calculates the signum of a float.
**
** @param a: the float to take the signum from
**
** @returns: the signum as a float (NOT int!)
*/
float sgn(float x = 0.0) {
	if(x > 0.0) {
		return(1.0);
	}

	if(x < 0.0) {
		return(-1.0);
	}

	return(0.0);
}

/*
** Calculates the power of a float (or int).
**
** @param x: the base
** @param n: the exponent
**
** @returns: x^n as a float
*/
float pow(float x = 0.0, int n = 0) {
	if(n == 0) {
		return(1.0);
	}

	float p = pow(x, n / 2); // Int division.

	if(n % 2 == 1) {
		// In case we truncated 1 from the exponent in the int division above.
		return(0.0 + x * p * p);
	}

	return(p * p);
}

/*
** Calculates the factorial of a float or int (floor applied to floats before, e.g.: 5.4! = 1 * 2 * 3 * 4 * 5).
**
** @param n: the float to calculate the factorial for
**
** @returns: n!
*/
int fact(float n = 0.0) {
	float res = 1;

	for(i = 1; <= n) {
		res = res * i;
	}

	return(res);
}

/*
** Natural logarithm, also accurate for large values (!).
** Partially taken from https://math.stackexchange.com/a/977836
** Adjusted so it also works for numbers close to 0.
**
** @param x: the float to calculate the natural logarithm for
**
** @returns x: ln(x)
*/
float log(float x = 0.0) {
	// Return infinity right away.
	if(x == 0.0) {
		return(INF);
	}

	// Convert to float and take absolute value.
	float a = abs(x);
	int n = 0;

	// Shift until we have a number of format x.[x].
	if(a >= 10.0) {
		// Shift right and count until single digit.
		while(a * 0.1 >= 1.0) {
			a = a * 0.1;
			n++;
		}
	} else if(a < 1.0) {
		// Shift left and count until >= 1.0.
		while(a * 10.0 < 1.0) {
			a = a * 10.0;
			n--;
		}
	}

	float sum = 0.0;
	float y = (a - 1.0) / (a + 1.0);

	int i = 0;
	float curr = y;
	float prec = TOL / pow(10.0, n); // Adjust precision because we're shifting.

	while(i < MAX_IT && curr > prec) {
		sum = sum + curr / (2 * i + 1);
		curr = curr * sq(y);
		i++;
	}

	// Return as log(10) * n + 2.0 * sum.
	return(2.30258509299 * n + 2.0 * sum);
}

/***************
* TRIGONOMETRY *
***************/

/*
** Approximates sin(x) via Taylor. Note that two iterations are executed per step.
**
** @param x: the value to take the sine of
**
** @returns: sin(x)
*/
float sin(float x = 0.0) {
	int n = 1;
	float res = 0.0;
	float curr = x; // Stores all the x^n / n! so we don't have to recalculate every time.

	while(n < MAX_IT && abs(curr) > TOL) {
		res = res + curr;
		curr = 0.0 - curr * (x / (n + 1)) * (x / (n + 2));
		n = n + 2;
	}

	return(res);
}

/*
** Approximates cos(x) via Taylor. Note that two iterations are executed per step.
**
** @param x: the value to take the cosine of
**
** @returns: cos(x)
*/
float cos(float x = 0.0) {
	int n = 1;
	float res = 0.0;
	float curr = 1.0; // Stores all the x^n / n! so we don't have to recalculate every time.

	while(n < MAX_IT && abs(curr) > TOL) {
		res = res + curr;
		curr = 0.0 - curr * (x / n) * (x / (n + 1));
		n = n + 2;
	}

	return(res);
}

/*
** Approximates atan(x) via Taylor.
** This can probably be approximated a lot more efficiently.
**
** @param x: the value to take the arcus tangens of
**
** @returns: atan(x)
*/
float atan(float x = 0.0) {
	float x0 = x;

	// Transform if not in [-1.0, 1.0].
	if(abs(x) > 1.0) {
		x0 = sgn(x0) / x;
	}

	int n = 1;
	float res = 0.0;
	float curr = x0; // Stores all the x0^n so we don't have to recalculate every time.
	float x0sq = sq(x0);

	while(n < MAX_IT && abs(curr) > TOL) {
		res = res + curr / n;
		curr = 0.0 - curr * x0sq;
		n = n + 2;
	}

	// Transform back if x wasn't in [-1.0, 1.0].
	if(abs(x) > 1.0) {
		res = 0.5 * PI - res;
	}

	if(x < -1.0) {
		res = 0.0 - res;
	}

	return(res);
}

/*
** atan2(). Used to get the angle of a point in the Cartesian coordinate system.
** An offset can be set, defaults to the center of the map.
**
** @param x: x coordinate in [0.0, 1.0]
** @param z: z coordinate in [0.0, 1.0]
** @param offsetX: x offset, 0.5 = middle of the x axis
** @param offsetZ: z offset, 0.5 = middle of the z axis
**
** @returns: the angle of (x, z)
*/
float getAngleFromCartesian(float x = 0.0, float z = 0.0, float offsetX = 0.5, float offsetZ = 0.5) {
	x = x - offsetX;
	z = z - offsetZ;

	float frac = z / x;

	// atan2(). Considers cases where x is very small and frac gets very large.
	if(abs(frac) > INF && z > 0.0) {
		return(0.5 * PI);
	}

	if(abs(frac) > INF && z < 0.0) {
		return(0.0 - 0.5 * PI);
	}

	if(x > 0.0) {
		return(atan(frac));
	}

	if(x < 0.0 && z >= 0.0) {
		return(atan(frac) + PI);
	}

	if(x < 0.0 && z < 0.0) {
		return(atan(frac) - PI);
	}

	// x == z == 0 -> undefined angle; this will likely never happen because 0.5 - 0.5 can result in -0.000...
	return(0.0);
}

/*
** Counterpart of getAngleFromCartesian() (atan2()). Returns the radius of a point in the Cartesian coordinate system with respect to an offset.
**
** @param x: x coordinate in [0.0, 1.0]
** @param z: z coordinate in [0.0, 1.0]
** @param offsetX: x offset, 0.5 = middle of the x axis
** @param offsetZ: z offset, 0.5 = middle of the z axis
**
** @returns: the radius of (x, z)
*/
float getRadiusFromCartesian(float x = 0.0, float z = 0.0, float offsetX = 0.5, float offsetZ = 0.5) {
	return(sqrt(sq(x - offsetX) + sq(z - offsetZ)));
}

/*********
* POINTS *
*********/

/*
** Calculates the x coordinate in the Cartesian coordinate system from polar coordinates.
**
** @param r: the radius
** @param a: angle in radians
** @param offset: x offset, 0.5 = middle of the x axis
**
** @returns: x in Cartesian coordinates
*/
float getXFromPolar(float r = 0.0, float a = 0.0, float offset = 0.5) {
	return(cos(a) * r + offset);
}

/*
** Calculates the z coordinate in the Cartesian coordinate system from polar coordinates.
**
** @param r: the radius
** @param a: angle in radians
** @param offset: z offset, 0.5 = middle of the z axis
**
** @returns: z in Cartesian coordinates
*/
float getZFromPolar(float r = 0.0, float a = 0.0, float offset = 0.5) {
	return(sin(a) * r + offset);
}

/*
** Rotates a point (or vector if you want) around an angle.
**
** @param x: x coordinate
** @param z: z coordinate
** @param a: the angle to rotate the point around
**
** @returns: the x coordinate of the rotated point
*/
float getXRotatePoint(float x = 0.0, float z = 0.0, float a = 0.0) {
	return(cos(a) * x - sin(a) * z);
}

/*
** Rotates a point (or vector if you want) around an angle.
**
** @param x: x coordinate
** @param z: z coordinate
** @param a: the angle to rotate the point around
**
** @returns: the z coordinate of the rotated point
*/
float getZRotatePoint(float x = 0.0, float z = 0.0, float a = 0.0) {
	return(cos(a) * z + sin(a) * x);
}

/*
** Maps a point in the Cartesian coordinate system from circular to square by stretching.
** Source: https://arxiv.org/ftp/arxiv/papers/1509/1509.06344.pdf
**
** @param x: x coordinate in [0.0, 1.0]
** @param z: z coordinate in [0.0, 1.0]
**
** @returns: the x coordinate of the stretched point
*/
float mapXToSquare(float x = 0.0, float z = 1.0) {
	float xSq = sq(x);
	float zSq = sq(z);

	if(xSq >= zSq) {
		return(sgn(x) * sqrt(xSq + zSq));
	}

	return(sgn(z) * (x / z) * sqrt(xSq + zSq));
}

/*
** Maps a point in the Cartesian coordinate system from circular to square by stretching.
** Source: https://arxiv.org/ftp/arxiv/papers/1509/1509.06344.pdf
**
** @param x: x coordinate in [0.0, 1.0]
** @param z: z coordinate in [0.0, 1.0]
**
** @returns: the z coordinate of the stretched point
*/
float mapZToSquare(float x = 1.0, float z = 0.0) {
	float xSq = sq(x);
	float zSq = sq(z);

	if(xSq >= zSq) {
		return(sgn(x) * (z / x) * sqrt(xSq + zSq));
	}

	return(sgn(z) * sqrt(xSq + zSq));
}

/*
** Calculates the distance between two points in the Cartesian coordinate system.
**
** @param x1: x value of point 1
** @param z1: z value of point 1
** @param x2: x value of point 2
** @param z2: z value of point 2
**
** @returns: the distance between the two points
*/
float pointsGetDist(float x1 = 0.0, float z1 = 0.0, float x2 = 0.0, float z2 = 0.0) {
	return(sqrt(sq(x1 - x2) + sq(z1 - z2)));
}

/*
** Determines whether a location is valid (within the map boundaries) or not.
** A tolerance value can be set to allow edges smaller than 0.0/1.0.
**
** @param x: x value of the location
** @param z: z value of the location
** @param tolX: tolerance value for x
** @param tolZ: tolerance value for z
**
** @returns: true if the point is valid, false otherwise
*/
bool isLocValid(float x = 0.0, float z = 0.0, float tolX = 0.0, float tolZ = 0.0) {
	return(x >= tolX && x <= 1.0 - tolX && z >= tolZ && z <= 1.0 - tolZ);
}

/*********
* ANGLES *
*********/

/*
** Calculates the section between two angles, where the second angle is assumed to "follow" the first one (counterclockwise).
** Example: getAngleBetweenConsecutiveAngles(1.0 * PI, 1.5 * PI) = 0.5 * PI.
**
** @param a1: the first angle
** @param a2: the second angle
**
** @returns: the section between the two angles (in radians)
*/
float getSectionBetweenConsecutiveAngles(float a1 = 0.0, float a2 = 0.0) {
	while(a2 < a1) {
		a2 = a2 + 2.0 * PI;
	}

	return(a2 - a1);
}

/*
** Calculates the angle between two angles, where the second angle is assumed to "follow" the first one (counterclockwise).
** The difference to the above function is that this function returns an angle with offset.
**
** @param a1: the first angle
** @param a2: the second angle
**
** @returns: the angle between the two angles (in radians)
*/
float getAngleBetweenConsecutiveAngles(float a1 = 0.0, float a2 = 0.0) {
	return(a1 + 0.5 * getSectionBetweenConsecutiveAngles(a1, a2));
}
