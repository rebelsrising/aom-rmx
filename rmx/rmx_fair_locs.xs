/*
** Fair location generation.
** RebelsRising
** Last edit: 07/03/2021
**
** Potential TODOs:
** - Adjust failCount handling.
** - Adjust angle generation for matchups that are not XvX.
**   -> Scale up to full [0.0, 2.0] * PI range depending on gameHasTwoEqualTeams() for an easy fix.
*/

include "rmx_placement_check.xs";

/************
* CONSTANTS *
************/

const string cFairLocName = "rmx fair loc";
const string cFairLocAreaName = "rmx fair loc area";

/************
* LOCATIONS *
************/

// Counter for fair location names so we don't end up with duplicates.
int fairLocNameCounter = 0;

// Counter for fair location area names so we don't end up with duplicates.
int fairLocAreaNameCounter = 0;

// Last added.
int lastAddedFairLocID = -1;

// Fair loc count.
int fairLocCount = 0;

/*
** Returns the number of added fair locations. This does not indicate whether creation of those fair locations was successful!
**
** @returns: the current number of fair locations
*/
int getNumFairLocs() {
	return(fairLocCount);
}

// Fair loc iteration counter.
int lastFairLocIters = -1;

/*
** Returns the number of iterations for the last placed fair location.
** Also gets reset by resetFairLocs().
**
** @returns: the number of iterations of the algorithm for the last created/attempted fair locs.
*/
int getLastFairLocIters() {
	return(lastFairLocIters);
}

// The arrays in here start from 1 due to always being associated to players.

// Fair locations X values.
float fairLoc1X1 = -1.0; float fairLoc1X2  = -1.0; float fairLoc1X3  = -1.0; float fairLoc1X4  = -1.0;
float fairLoc1X5 = -1.0; float fairLoc1X6  = -1.0; float fairLoc1X7  = -1.0; float fairLoc1X8  = -1.0;
float fairLoc1X9 = -1.0; float fairLoc1X10 = -1.0; float fairLoc1X11 = -1.0; float fairLoc1X12 = -1.0;

float getFairLoc1X(int id = 0) {
	if(id == 1) return(fairLoc1X1); if(id == 2)  return(fairLoc1X2);  if(id == 3)  return(fairLoc1X3);  if(id == 4)  return(fairLoc1X4);
	if(id == 5) return(fairLoc1X5); if(id == 6)  return(fairLoc1X6);  if(id == 7)  return(fairLoc1X7);  if(id == 8)  return(fairLoc1X8);
	if(id == 9) return(fairLoc1X9); if(id == 10) return(fairLoc1X10); if(id == 11) return(fairLoc1X11); if(id == 12) return(fairLoc1X12);
	return(-1.0);
}

void setFairLoc1X(int id = 0, float val = -1.0) {
	if(id == 1) fairLoc1X1 = val; if(id == 2)  fairLoc1X2  = val; if(id == 3)  fairLoc1X3  = val; if(id == 4)  fairLoc1X4  = val;
	if(id == 5) fairLoc1X5 = val; if(id == 6)  fairLoc1X6  = val; if(id == 7)  fairLoc1X7  = val; if(id == 8)  fairLoc1X8  = val;
	if(id == 9) fairLoc1X9 = val; if(id == 10) fairLoc1X10 = val; if(id == 11) fairLoc1X11 = val; if(id == 12) fairLoc1X12 = val;
}

float fairLoc2X1 = -1.0; float fairLoc2X2  = -1.0; float fairLoc2X3  = -1.0; float fairLoc2X4  = -1.0;
float fairLoc2X5 = -1.0; float fairLoc2X6  = -1.0; float fairLoc2X7  = -1.0; float fairLoc2X8  = -1.0;
float fairLoc2X9 = -1.0; float fairLoc2X10 = -1.0; float fairLoc2X11 = -1.0; float fairLoc2X12 = -1.0;

float getFairLoc2X(int id = 0) {
	if(id == 1) return(fairLoc2X1); if(id == 2)  return(fairLoc2X2);  if(id == 3)  return(fairLoc2X3);  if(id == 4)  return(fairLoc2X4);
	if(id == 5) return(fairLoc2X5); if(id == 6)  return(fairLoc2X6);  if(id == 7)  return(fairLoc2X7);  if(id == 8)  return(fairLoc2X8);
	if(id == 9) return(fairLoc2X9); if(id == 10) return(fairLoc2X10); if(id == 11) return(fairLoc2X11); if(id == 12) return(fairLoc2X12);
	return(-1.0);
}

void setFairLoc2X(int id = 0, float val = -1.0) {
	if(id == 1) fairLoc2X1 = val; if(id == 2)  fairLoc2X2  = val; if(id == 3)  fairLoc2X3  = val; if(id == 4)  fairLoc2X4  = val;
	if(id == 5) fairLoc2X5 = val; if(id == 6)  fairLoc2X6  = val; if(id == 7)  fairLoc2X7  = val; if(id == 8)  fairLoc2X8  = val;
	if(id == 9) fairLoc2X9 = val; if(id == 10) fairLoc2X10 = val; if(id == 11) fairLoc2X11 = val; if(id == 12) fairLoc2X12 = val;
}

float fairLoc3X1 = -1.0; float fairLoc3X2  = -1.0; float fairLoc3X3  = -1.0; float fairLoc3X4  = -1.0;
float fairLoc3X5 = -1.0; float fairLoc3X6  = -1.0; float fairLoc3X7  = -1.0; float fairLoc3X8  = -1.0;
float fairLoc3X9 = -1.0; float fairLoc3X10 = -1.0; float fairLoc3X11 = -1.0; float fairLoc3X12 = -1.0;

float getFairLoc3X(int id = 0) {
	if(id == 1) return(fairLoc3X1); if(id == 2)  return(fairLoc3X2);  if(id == 3)  return(fairLoc3X3);  if(id == 4)  return(fairLoc3X4);
	if(id == 5) return(fairLoc3X5); if(id == 6)  return(fairLoc3X6);  if(id == 7)  return(fairLoc3X7);  if(id == 8)  return(fairLoc3X8);
	if(id == 9) return(fairLoc3X9); if(id == 10) return(fairLoc3X10); if(id == 11) return(fairLoc3X11); if(id == 12) return(fairLoc3X12);
	return(-1.0);
}

void setFairLoc3X(int id = 0, float val = -1.0) {
	if(id == 1) fairLoc3X1 = val; if(id == 2)  fairLoc3X2  = val; if(id == 3)  fairLoc3X3  = val; if(id == 4)  fairLoc3X4  = val;
	if(id == 5) fairLoc3X5 = val; if(id == 6)  fairLoc3X6  = val; if(id == 7)  fairLoc3X7  = val; if(id == 8)  fairLoc3X8  = val;
	if(id == 9) fairLoc3X9 = val; if(id == 10) fairLoc3X10 = val; if(id == 11) fairLoc3X11 = val; if(id == 12) fairLoc3X12 = val;
}

float fairLoc4X1 = -1.0; float fairLoc4X2  = -1.0; float fairLoc4X3  = -1.0; float fairLoc4X4  = -1.0;
float fairLoc4X5 = -1.0; float fairLoc4X6  = -1.0; float fairLoc4X7  = -1.0; float fairLoc4X8  = -1.0;
float fairLoc4X9 = -1.0; float fairLoc4X10 = -1.0; float fairLoc4X11 = -1.0; float fairLoc4X12 = -1.0;

float getFairLoc4X(int id = 0) {
	if(id == 1) return(fairLoc4X1); if(id == 2)  return(fairLoc4X2);  if(id == 3)  return(fairLoc4X3);  if(id == 4)  return(fairLoc4X4);
	if(id == 5) return(fairLoc4X5); if(id == 6)  return(fairLoc4X6);  if(id == 7)  return(fairLoc4X7);  if(id == 8)  return(fairLoc4X8);
	if(id == 9) return(fairLoc4X9); if(id == 10) return(fairLoc4X10); if(id == 11) return(fairLoc4X11); if(id == 12) return(fairLoc4X12);
	return(-1.0);
}

void setFairLoc4X(int id = 0, float val = -1.0) {
	if(id == 1) fairLoc4X1 = val; if(id == 2)  fairLoc4X2  = val; if(id == 3)  fairLoc4X3  = val; if(id == 4)  fairLoc4X4  = val;
	if(id == 5) fairLoc4X5 = val; if(id == 6)  fairLoc4X6  = val; if(id == 7)  fairLoc4X7  = val; if(id == 8)  fairLoc4X8  = val;
	if(id == 9) fairLoc4X9 = val; if(id == 10) fairLoc4X10 = val; if(id == 11) fairLoc4X11 = val; if(id == 12) fairLoc4X12 = val;
}

/*
** Gets the x coordinate of a fair location.
**
** @param fairLocID: the ID of the fair location
** @param id: the index of the coordinate in the array
**
** @returns: the x coordinate of the fair location
*/
float getFairLocX(int fairLocID = 0, int id = 0) {
	if(fairLocID == 1) return(getFairLoc1X(id)); if(fairLocID == 2) return(getFairLoc2X(id));
	if(fairLocID == 3) return(getFairLoc3X(id)); if(fairLocID == 4) return(getFairLoc4X(id));
	return(-1.0);
}

/*
** Sets the x coordinate of a fair location.
**
** @param fairLocID: the ID of the fair location
** @param id: the index of the coordinate in the array
** @param val: the value to set
*/
void setFairLocX(int fairLocID = 0, int id = 0, float val = -1.0) {
	if(fairLocID == 1) setFairLoc1X(id, val); if(fairLocID == 2) setFairLoc2X(id, val);
	if(fairLocID == 3) setFairLoc3X(id, val); if(fairLocID == 4) setFairLoc4X(id, val);
}

// Fair locations Z values.
float fairLoc1Z1 = -1.0;  float fairLoc1Z2  = -1.0; float fairLoc1Z3  = -1.0; float fairLoc1Z4  = -1.0;
float fairLoc1Z5 = -1.0;  float fairLoc1Z6  = -1.0; float fairLoc1Z7  = -1.0; float fairLoc1Z8  = -1.0;
float fairLoc1Z9 = -1.0;  float fairLoc1Z10 = -1.0; float fairLoc1Z11 = -1.0; float fairLoc1Z12 = -1.0;

float getFairLoc1Z(int id = 0) {
	if(id == 1) return(fairLoc1Z1); if(id == 2)  return(fairLoc1Z2);  if(id == 3)  return(fairLoc1Z3);  if(id == 4)  return(fairLoc1Z4);
	if(id == 5) return(fairLoc1Z5); if(id == 6)  return(fairLoc1Z6);  if(id == 7)  return(fairLoc1Z7);  if(id == 8)  return(fairLoc1Z8);
	if(id == 9) return(fairLoc1Z9); if(id == 10) return(fairLoc1Z10); if(id == 11) return(fairLoc1Z11); if(id == 12) return(fairLoc1Z12);
	return(-1.0);
}

void setFairLoc1Z(int id = 0, float val = -1.0) {
	if(id == 1) fairLoc1Z1 = val; if(id == 2)  fairLoc1Z2  = val; if(id == 3)  fairLoc1Z3  = val; if(id == 4)  fairLoc1Z4  = val;
	if(id == 5) fairLoc1Z5 = val; if(id == 6)  fairLoc1Z6  = val; if(id == 7)  fairLoc1Z7  = val; if(id == 8)  fairLoc1Z8  = val;
	if(id == 9) fairLoc1Z9 = val; if(id == 10) fairLoc1Z10 = val; if(id == 11) fairLoc1Z11 = val; if(id == 12) fairLoc1Z12 = val;
}

float fairLoc2Z1 = -1.0;  float fairLoc2Z2  = -1.0; float fairLoc2Z3  = -1.0; float fairLoc2Z4  = -1.0;
float fairLoc2Z5 = -1.0;  float fairLoc2Z6  = -1.0; float fairLoc2Z7  = -1.0; float fairLoc2Z8  = -1.0;
float fairLoc2Z9 = -1.0;  float fairLoc2Z10 = -1.0; float fairLoc2Z11 = -1.0; float fairLoc2Z12 = -1.0;

float getFairLoc2Z(int id = 0) {
	if(id == 1) return(fairLoc2Z1); if(id == 2)  return(fairLoc2Z2);  if(id == 3)  return(fairLoc2Z3);  if(id == 4)  return(fairLoc2Z4);
	if(id == 5) return(fairLoc2Z5); if(id == 6)  return(fairLoc2Z6);  if(id == 7)  return(fairLoc2Z7);  if(id == 8)  return(fairLoc2Z8);
	if(id == 9) return(fairLoc2Z9); if(id == 10) return(fairLoc2Z10); if(id == 11) return(fairLoc2Z11); if(id == 12) return(fairLoc2Z12);
	return(-1.0);
}

void setFairLoc2Z(int id = 0, float val = -1.0) {
	if(id == 1) fairLoc2Z1 = val; if(id == 2)  fairLoc2Z2  = val; if(id == 3)  fairLoc2Z3  = val; if(id == 4)  fairLoc2Z4  = val;
	if(id == 5) fairLoc2Z5 = val; if(id == 6)  fairLoc2Z6  = val; if(id == 7)  fairLoc2Z7  = val; if(id == 8)  fairLoc2Z8  = val;
	if(id == 9) fairLoc2Z9 = val; if(id == 10) fairLoc2Z10 = val; if(id == 11) fairLoc2Z11 = val; if(id == 12) fairLoc2Z12 = val;
}

float fairLoc3Z1 = -1.0;  float fairLoc3Z2  = -1.0; float fairLoc3Z3  = -1.0; float fairLoc3Z4  = -1.0;
float fairLoc3Z5 = -1.0;  float fairLoc3Z6  = -1.0; float fairLoc3Z7  = -1.0; float fairLoc3Z8  = -1.0;
float fairLoc3Z9 = -1.0;  float fairLoc3Z10 = -1.0; float fairLoc3Z11 = -1.0; float fairLoc3Z12 = -1.0;

float getFairLoc3Z(int id = 0) {
	if(id == 1) return(fairLoc3Z1); if(id == 2)  return(fairLoc3Z2);  if(id == 3)  return(fairLoc3Z3);  if(id == 4)  return(fairLoc3Z4);
	if(id == 5) return(fairLoc3Z5); if(id == 6)  return(fairLoc3Z6);  if(id == 7)  return(fairLoc3Z7);  if(id == 8)  return(fairLoc3Z8);
	if(id == 9) return(fairLoc3Z9); if(id == 10) return(fairLoc3Z10); if(id == 11) return(fairLoc3Z11); if(id == 12) return(fairLoc3Z12);
	return(-1.0);
}

void setFairLoc3Z(int id = 0, float val = -1.0) {
	if(id == 1) fairLoc3Z1 = val; if(id == 2)  fairLoc3Z2  = val; if(id == 3)  fairLoc3Z3  = val; if(id == 4)  fairLoc3Z4  = val;
	if(id == 5) fairLoc3Z5 = val; if(id == 6)  fairLoc3Z6  = val; if(id == 7)  fairLoc3Z7  = val; if(id == 8)  fairLoc3Z8  = val;
	if(id == 9) fairLoc3Z9 = val; if(id == 10) fairLoc3Z10 = val; if(id == 11) fairLoc3Z11 = val; if(id == 12) fairLoc3Z12 = val;
}

float fairLoc4Z1 = -1.0;  float fairLoc4Z2  = -1.0; float fairLoc4Z3  = -1.0; float fairLoc4Z4  = -1.0;
float fairLoc4Z5 = -1.0;  float fairLoc4Z6  = -1.0; float fairLoc4Z7  = -1.0; float fairLoc4Z8  = -1.0;
float fairLoc4Z9 = -1.0;  float fairLoc4Z10 = -1.0; float fairLoc4Z11 = -1.0; float fairLoc4Z12 = -1.0;

float getFairLoc4Z(int id = 0) {
	if(id == 1) return(fairLoc4Z1); if(id == 2)  return(fairLoc4Z2);  if(id == 3)  return(fairLoc4Z3);  if(id == 4)  return(fairLoc4Z4);
	if(id == 5) return(fairLoc4Z5); if(id == 6)  return(fairLoc4Z6);  if(id == 7)  return(fairLoc4Z7);  if(id == 8)  return(fairLoc4Z8);
	if(id == 9) return(fairLoc4Z9); if(id == 10) return(fairLoc4Z10); if(id == 11) return(fairLoc4Z11); if(id == 12) return(fairLoc4Z12);
	return(-1.0);
}

void setFairLoc4Z(int id = 0, float val = -1.0) {
	if(id == 1) fairLoc4Z1 = val; if(id == 2)  fairLoc4Z2  = val; if(id == 3)  fairLoc4Z3  = val; if(id == 4)  fairLoc4Z4  = val;
	if(id == 5) fairLoc4Z5 = val; if(id == 6)  fairLoc4Z6  = val; if(id == 7)  fairLoc4Z7  = val; if(id == 8)  fairLoc4Z8  = val;
	if(id == 9) fairLoc4Z9 = val; if(id == 10) fairLoc4Z10 = val; if(id == 11) fairLoc4Z11 = val; if(id == 12) fairLoc4Z12 = val;
}

/*
** Gets the z coordinate of a fair location.
**
** @param fairLocID: the ID of the fair location
** @param id: the index of the coordinate in the array
**
** @returns: the z coordinate of the fair location
*/
float getFairLocZ(int fairLocID = 0, int id = 0) {
	if(fairLocID == 1) return(getFairLoc1Z(id)); if(fairLocID == 2) return(getFairLoc2Z(id));
	if(fairLocID == 3) return(getFairLoc3Z(id)); if(fairLocID == 4) return(getFairLoc4Z(id));
	return(-1.0);
}

/*
** Sets the z coordinate of a fair location.
**
** @param fairLocID: the ID of the fair location
** @param id: the index of the coordinate in the array
** @param val: the value to set
*/
void setFairLocZ(int fairLocID = 0, int id = 0, float val = -1.0) {
	if(fairLocID == 1) setFairLoc1Z(id, val); if(fairLocID == 2) setFairLoc2Z(id, val);
	if(fairLocID == 3) setFairLoc3Z(id, val); if(fairLocID == 4) setFairLoc4Z(id, val);
}

/*
** Sets both coordinates for a fair location.
**
** @param fairLocID: the ID of the fair location
** @param id: the index of the coordinate in the array
** @param x: the x value to set
** @param z: the z value to set
*/
void setFairLocXZ(int fairLocID = 0, int id = 0, float x = -1.0, float z = -1.0) {
	setFairLocX(fairLocID, id, x);
	setFairLocZ(fairLocID, id, z);
}

/**************
* CONSTRAINTS *
**************/

// Fair location constraints.
int fairLocConstraintCount1 = 0; int fairLocConstraintCount2 = 0; int fairLocConstraintCount3 = 0; int fairLocConstraintCount4 = 0;

int fairLoc1Constraint1 = -1; int fairLoc1Constraint2  = -1; int fairLoc1Constraint3  = -1; int fairLoc1Constraint4  = -1;
int fairLoc1Constraint5 = -1; int fairLoc1Constraint6  = -1; int fairLoc1Constraint7  = -1; int fairLoc1Constraint8  = -1;
int fairLoc1Constraint9 = -1; int fairLoc1Constraint10 = -1; int fairLoc1Constraint11 = -1; int fairLoc1Constraint12 = -1;

int getFairLoc1Constraint(int id = 0) {
	if(id == 1) return(fairLoc1Constraint1); if(id == 2)  return(fairLoc1Constraint2);  if(id == 3)  return(fairLoc1Constraint3);  if(id == 4)  return(fairLoc1Constraint4);
	if(id == 5) return(fairLoc1Constraint5); if(id == 6)  return(fairLoc1Constraint6);  if(id == 7)  return(fairLoc1Constraint7);  if(id == 8)  return(fairLoc1Constraint8);
	if(id == 9) return(fairLoc1Constraint9); if(id == 10) return(fairLoc1Constraint10); if(id == 11) return(fairLoc1Constraint11); if(id == 12) return(fairLoc1Constraint12);
	return(-1);
}

void setFairLoc1Constraint(int id = 0, int cID = -1) {
	if(id == 1) fairLoc1Constraint1 = cID; if(id == 2)  fairLoc1Constraint2  = cID; if(id == 3)  fairLoc1Constraint3  = cID; if(id == 4)  fairLoc1Constraint4  = cID;
	if(id == 5) fairLoc1Constraint5 = cID; if(id == 6)  fairLoc1Constraint6  = cID; if(id == 7)  fairLoc1Constraint7  = cID; if(id == 8)  fairLoc1Constraint8  = cID;
	if(id == 9) fairLoc1Constraint9 = cID; if(id == 10) fairLoc1Constraint10 = cID; if(id == 11) fairLoc1Constraint11 = cID; if(id == 12) fairLoc1Constraint12 = cID;
}

int fairLoc2Constraint1 = -1; int fairLoc2Constraint2  = -1; int fairLoc2Constraint3  = -1; int fairLoc2Constraint4  = -1;
int fairLoc2Constraint5 = -1; int fairLoc2Constraint6  = -1; int fairLoc2Constraint7  = -1; int fairLoc2Constraint8  = -1;
int fairLoc2Constraint9 = -1; int fairLoc2Constraint10 = -1; int fairLoc2Constraint11 = -1; int fairLoc2Constraint12 = -1;

int getFairLoc2Constraint(int id = 0) {
	if(id == 1) return(fairLoc2Constraint1); if(id == 2)  return(fairLoc2Constraint2);  if(id == 3)  return(fairLoc2Constraint3);  if(id == 4)  return(fairLoc2Constraint4);
	if(id == 5) return(fairLoc2Constraint5); if(id == 6)  return(fairLoc2Constraint6);  if(id == 7)  return(fairLoc2Constraint7);  if(id == 8)  return(fairLoc2Constraint8);
	if(id == 9) return(fairLoc2Constraint9); if(id == 10) return(fairLoc2Constraint10); if(id == 11) return(fairLoc2Constraint11); if(id == 12) return(fairLoc2Constraint12);
	return(-1);
}

void setFairLoc2Constraint(int id = 0, int cID = -1) {
	if(id == 1) fairLoc2Constraint1 = cID; if(id == 2)  fairLoc2Constraint2  = cID; if(id == 3)  fairLoc2Constraint3  = cID; if(id == 4)  fairLoc2Constraint4  = cID;
	if(id == 5) fairLoc2Constraint5 = cID; if(id == 6)  fairLoc2Constraint6  = cID; if(id == 7)  fairLoc2Constraint7  = cID; if(id == 8)  fairLoc2Constraint8  = cID;
	if(id == 9) fairLoc2Constraint9 = cID; if(id == 10) fairLoc2Constraint10 = cID; if(id == 11) fairLoc2Constraint11 = cID; if(id == 12) fairLoc2Constraint12 = cID;
}

int fairLoc3Constraint1 = -1; int fairLoc3Constraint2  = -1; int fairLoc3Constraint3  = -1; int fairLoc3Constraint4  = -1;
int fairLoc3Constraint5 = -1; int fairLoc3Constraint6  = -1; int fairLoc3Constraint7  = -1; int fairLoc3Constraint8  = -1;
int fairLoc3Constraint9 = -1; int fairLoc3Constraint10 = -1; int fairLoc3Constraint11 = -1; int fairLoc3Constraint12 = -1;

int getFairLoc3Constraint(int id = 0) {
	if(id == 1) return(fairLoc3Constraint1); if(id == 2)  return(fairLoc3Constraint2);  if(id == 3)  return(fairLoc3Constraint3);  if(id == 4)  return(fairLoc3Constraint4);
	if(id == 5) return(fairLoc3Constraint5); if(id == 6)  return(fairLoc3Constraint6);  if(id == 7)  return(fairLoc3Constraint7);  if(id == 8)  return(fairLoc3Constraint8);
	if(id == 9) return(fairLoc3Constraint9); if(id == 10) return(fairLoc3Constraint10); if(id == 11) return(fairLoc3Constraint11); if(id == 12) return(fairLoc3Constraint12);
	return(-1);
}

void setFairLoc3Constraint(int id = 0, int cID = -1) {
	if(id == 1) fairLoc3Constraint1 = cID; if(id == 2)  fairLoc3Constraint2  = cID; if(id == 3)  fairLoc3Constraint3  = cID; if(id == 4)  fairLoc3Constraint4  = cID;
	if(id == 5) fairLoc3Constraint5 = cID; if(id == 6)  fairLoc3Constraint6  = cID; if(id == 7)  fairLoc3Constraint7  = cID; if(id == 8)  fairLoc3Constraint8  = cID;
	if(id == 9) fairLoc3Constraint9 = cID; if(id == 10) fairLoc3Constraint10 = cID; if(id == 11) fairLoc3Constraint11 = cID; if(id == 12) fairLoc3Constraint12 = cID;
}

int fairLoc4Constraint1 = -1; int fairLoc4Constraint2  = -1; int fairLoc4Constraint3  = -1; int fairLoc4Constraint4  = -1;
int fairLoc4Constraint5 = -1; int fairLoc4Constraint6  = -1; int fairLoc4Constraint7  = -1; int fairLoc4Constraint8  = -1;
int fairLoc4Constraint9 = -1; int fairLoc4Constraint10 = -1; int fairLoc4Constraint11 = -1; int fairLoc4Constraint12 = -1;

int getFairLoc4Constraint(int id = 0) {
	if(id == 1) return(fairLoc4Constraint1); if(id == 2)  return(fairLoc4Constraint2);  if(id == 3)  return(fairLoc4Constraint3);  if(id == 4)  return(fairLoc4Constraint4);
	if(id == 5) return(fairLoc4Constraint5); if(id == 6)  return(fairLoc4Constraint6);  if(id == 7)  return(fairLoc4Constraint7);  if(id == 8)  return(fairLoc4Constraint8);
	if(id == 9) return(fairLoc4Constraint9); if(id == 10) return(fairLoc4Constraint10); if(id == 11) return(fairLoc4Constraint11); if(id == 12) return(fairLoc4Constraint12);
	return(-1);
}

void setFairLoc4Constraint(int id = 0, int cID = -1) {
	if(id == 1) fairLoc4Constraint1 = cID; if(id == 2)  fairLoc4Constraint2  = cID; if(id == 3)  fairLoc4Constraint3  = cID; if(id == 4)  fairLoc4Constraint4  = cID;
	if(id == 5) fairLoc4Constraint5 = cID; if(id == 6)  fairLoc4Constraint6  = cID; if(id == 7)  fairLoc4Constraint7  = cID; if(id == 8)  fairLoc4Constraint8  = cID;
	if(id == 9) fairLoc4Constraint9 = cID; if(id == 10) fairLoc4Constraint10 = cID; if(id == 11) fairLoc4Constraint11 = cID; if(id == 12) fairLoc4Constraint12 = cID;
}

/*
** Obtains a stored constraint for a given fair location.
**
** @param fairLocID: the ID of the fair location
** @param id: the index of the constraint in the constraint array
**
** @returns: the ID of the constraint
*/
int getFairLocConstraint(int fairLocID = 0, int id = 0) {
	if(fairLocID == 1) return(getFairLoc1Constraint(id)); if(fairLocID == 2) return(getFairLoc2Constraint(id));
	if(fairLocID == 3) return(getFairLoc3Constraint(id)); if(fairLocID == 4) return(getFairLoc4Constraint(id));
	return(-1);
}

/*
** Adds an area constraint to a certain fair location.
**
** The signature of this function may seem a little inconsistent, but it's a lot more convenient.
** Since usually the current fair location is used, the second argument can often be omitted.
** The exception (and reason why the second argument exists) are cases where you may want to have
** fair locations added in a different order depending on the number of players.
** Remember that the fair locations with the lower IDs are placed first.
**
** @param cID: the ID of the constraint
** @param fairLocID: the ID of the fair location the constraint should belong to
*/
void addFairLocConstraint(int cID = -1, int fairLocID = -1) {
	if(fairLocID < 0) {
		fairLocID = fairLocCount + 1;
	}

	if(fairLocID == 1) {
		fairLocConstraintCount1++;
		setFairLoc1Constraint(fairLocConstraintCount1, cID);
	} else if(fairLocID == 2) {
		fairLocConstraintCount2++;
		setFairLoc2Constraint(fairLocConstraintCount2, cID);
	} else if(fairLocID == 3) {
		fairLocConstraintCount3++;
		setFairLoc3Constraint(fairLocConstraintCount3, cID);
	} else if(fairLocID == 4) {
		fairLocConstraintCount4++;
		setFairLoc4Constraint(fairLocConstraintCount4, cID);
	}
}

/*
** Returns the number of constraints for a certain fair location.
**
** @param fairLocID: the ID of the fair location
**
** @returns: the number of constraints that have been added
*/
int getFairLocConstraintCount(int fairLocID = 0) {
	if(fairLocID == 1) return(fairLocConstraintCount1); if(fairLocID == 2) return(fairLocConstraintCount2);
	if(fairLocID == 3) return(fairLocConstraintCount3); if(fairLocID == 4) return(fairLocConstraintCount4);
	return(-1);
}

/*************
* PARAMETERS *
*************/

// Min dist.
float fairLoc1MinDist = 0.0; float fairLoc2MinDist = 0.0; float fairLoc3MinDist = 0.0; float fairLoc4MinDist = 0.0;

float getFairLocMinDist(int id = 0) {
	if(id == 1) return(fairLoc1MinDist); if(id == 2) return(fairLoc2MinDist); if(id == 3) return(fairLoc3MinDist); if(id == 4) return(fairLoc4MinDist);
	return(0.0);
}

void setFairLocMinDist(int id = 0, float val = 0.0) {
	if(id == 1) fairLoc1MinDist = val; if(id == 2) fairLoc2MinDist = val; if(id == 3) fairLoc3MinDist = val; if(id == 4) fairLoc4MinDist = val;
}

// Max dist.
float fairLoc1MaxDist = 0.0; float fairLoc2MaxDist = 0.0; float fairLoc3MaxDist = 0.0; float fairLoc4MaxDist = 0.0;

float getFairLocMaxDist(int id = 0) {
	if(id == 1) return(fairLoc1MaxDist); if(id == 2) return(fairLoc2MaxDist); if(id == 3) return(fairLoc3MaxDist); if(id == 4) return(fairLoc4MaxDist);
	return(0.0);
}

void setFairLocMaxDist(int id = 0, float val = 0.0) {
	if(id == 1) fairLoc1MaxDist = val; if(id == 2) fairLoc2MaxDist = val; if(id == 3) fairLoc3MaxDist = val; if(id == 4) fairLoc4MaxDist = val;
}

// Forward.
bool fairLoc1Forward = false; bool fairLoc2Forward = false; bool fairLoc3Forward = false; bool fairLoc4Forward = false;

bool getFairLocForward(int id = 0) {
	if(id == 1) return(fairLoc1Forward); if(id == 2) return(fairLoc2Forward); if(id == 3) return(fairLoc3Forward); if(id == 4) return(fairLoc4Forward);
	return(false);
}

void setFairLocForward(int id = 0, bool val = false) {
	if(id == 1) fairLoc1Forward = val; if(id == 2) fairLoc2Forward = val; if(id == 3) fairLoc3Forward = val; if(id == 4) fairLoc4Forward = val;
}

// Inside.
bool fairLoc1Inside = false; bool fairLoc2Inside = false; bool fairLoc3Inside = false; bool fairLoc4Inside = false;

bool getFairLocInside(int id = 0) {
	if(id == 1) return(fairLoc1Inside); if(id == 2) return(fairLoc2Inside); if(id == 3) return(fairLoc3Inside); if(id == 4) return(fairLoc4Inside);
	return(false);
}

void setFairLocInside(int id = 0, bool val = false) {
	if(id == 1) fairLoc1Inside = val; if(id == 2) fairLoc2Inside = val; if(id == 3) fairLoc3Inside = val; if(id == 4) fairLoc4Inside = val;
}

// Area dist.
float fairLoc1AreaDist = 0.0; float fairLoc2AreaDist = 0.0; float fairLoc3AreaDist = 0.0; float fairLoc4AreaDist = 0.0;

float getFairLocAreaDist(int id = 0) {
	if(id == 1) return(fairLoc1AreaDist); if(id == 2) return(fairLoc2AreaDist); if(id == 3) return(fairLoc3AreaDist); if(id == 4) return(fairLoc4AreaDist);
	return(0.0);
}

void setFairLocAreaDist(int id = 0, float val = 0.0) {
	if(id == 1) fairLoc1AreaDist = val; if(id == 2) fairLoc2AreaDist = val; if(id == 3) fairLoc3AreaDist = val; if(id == 4) fairLoc4AreaDist = val;
}

// Edge dist x.
float fairLoc1DistX = 0.0; float fairLoc2DistX = 0.0; float fairLoc3DistX = 0.0; float fairLoc4DistX = 0.0;

float getFairLocDistX(int id = 0) {
	if(id == 1) return(fairLoc1DistX); if(id == 2) return(fairLoc2DistX); if(id == 3) return(fairLoc3DistX); if(id == 4) return(fairLoc4DistX);
	return(0.0);
}

void setFairLocDistX(int id = 0, float val = 0.0) {
	if(id == 1) fairLoc1DistX = val; if(id == 2) fairLoc2DistX = val; if(id == 3) fairLoc3DistX = val; if(id == 4) fairLoc4DistX = val;
}

// Edge dist z.
float fairLoc1DistZ = 0.0; float fairLoc2DistZ = 0.0; float fairLoc3DistZ = 0.0; float fairLoc4DistZ = 0.0;

float getFairLocDistZ(int id = 0) {
	if(id == 1) return(fairLoc1DistZ); if(id == 2) return(fairLoc2DistZ); if(id == 3) return(fairLoc3DistZ); if(id == 4) return(fairLoc4DistZ);
	return(0.0);
}

void setFairLocDistZ(int id = 0, float val = 0.0) {
	if(id == 1) fairLoc1DistZ = val; if(id == 2) fairLoc2DistZ = val; if(id == 3) fairLoc3DistZ = val; if(id == 4) fairLoc4DistZ = val;
}

// Inside out.
bool fairLoc1InsideOut = true; bool fairLoc2InsideOut = true; bool fairLoc3InsideOut = true; bool fairLoc4InsideOut = true;

bool getFairLocInsideOut(int id = 0) {
	if(id == 1) return(fairLoc1InsideOut); if(id == 2) return(fairLoc2InsideOut); if(id == 3) return(fairLoc3InsideOut); if(id == 4) return(fairLoc4InsideOut);
	return(true);
}

void setFairLocInsideOut(int id = 0, bool val = true) {
	if(id == 1) fairLoc1InsideOut = val; if(id == 2) fairLoc2InsideOut = val; if(id == 3) fairLoc3InsideOut = val; if(id == 4) fairLoc4InsideOut = val;
}

// In player area.
bool fairLoc1InPlayerArea = false; bool fairLoc2InPlayerArea = false; bool fairLoc3InPlayerArea = false; bool fairLoc4InPlayerArea = false;

bool getFairLocInPlayerArea(int id = 0) {
	if(id == 1) return(fairLoc1InPlayerArea); if(id == 2) return(fairLoc2InPlayerArea); if(id == 3) return(fairLoc3InPlayerArea); if(id == 4) return(fairLoc4InPlayerArea);
	return(false);
}

void setFairLocInPlayerArea(int id = 0, bool val = false) {
	if(id == 1) fairLoc1InPlayerArea = val; if(id == 2) fairLoc2InPlayerArea = val; if(id == 3) fairLoc3InPlayerArea = val; if(id == 4) fairLoc4InPlayerArea = val;
}

// In team area.
bool fairLoc1InTeamArea = false; bool fairLoc2InTeamArea = false; bool fairLoc3InTeamArea = false; bool fairLoc4InTeamArea = false;

bool getFairLocInTeamArea(int id = 0) {
	if(id == 1) return(fairLoc1InTeamArea); if(id == 2) return(fairLoc2InTeamArea);	if(id == 3) return(fairLoc3InTeamArea); if(id == 4) return(fairLoc4InTeamArea);
	return(false);
}

void setFairLocInTeamArea(int id = 0, bool val = false) {
	if(id == 1) fairLoc1InTeamArea = val; if(id == 2) fairLoc2InTeamArea = val; if(id == 3) fairLoc3InTeamArea = val; if(id == 4) fairLoc4InTeamArea = val;
}

// Whether to use square placement or not.
bool fairLoc1IsSquare = false; bool fairLoc2IsSquare = false; bool fairLoc3IsSquare = false; bool fairLoc4IsSquare = false;

bool getFairLocIsSquare(int id = 0) {
	if(id == 1) return(fairLoc1IsSquare); if(id == 2) return(fairLoc2IsSquare);	if(id == 3) return(fairLoc3IsSquare); if(id == 4) return(fairLoc4IsSquare);
	return(false);
}

void setFairLocIsSquare(int id = 0, bool val = false) {
	if(id == 1) fairLoc1IsSquare = val; if(id == 2) fairLoc2IsSquare = val; if(id == 3) fairLoc3IsSquare = val; if(id == 4) fairLoc4IsSquare = val;
}

// Default two player tolerance.
float fairLoc1TwoPlayerTol = -1.0; float fairLoc2TwoPlayerTol = -1.0; float fairLoc3TwoPlayerTol = -1.0; float fairLoc4TwoPlayerTol = -1.0;

float getFairLocTwoPlayerTol(int id = 0) {
	if(id == 1) return(fairLoc1TwoPlayerTol); if(id == 2) return(fairLoc2TwoPlayerTol); if(id == 3) return(fairLoc3TwoPlayerTol); if(id == 4) return(fairLoc4TwoPlayerTol);
	return(-1.0);
}

void setFairLocTwoPlayerTol(int id = 0, float val = 0.125) {
	if(id == 1) fairLoc1TwoPlayerTol = val; if(id == 2) fairLoc2TwoPlayerTol = val; if(id == 3) fairLoc3TwoPlayerTol = val; if(id == 4) fairLoc4TwoPlayerTol = val;
}

/*
** Sets the maximum ratio for the two player check to tolerate.
**
** @param twoPlayerTol: the ratio as a float
** @param fairLocID: the ID of the fair location to set the segment size for
*/
void enableFairLocTwoPlayerCheck(float twoPlayerTol = 0.125, int fairLocID = -1) {
	if(fairLocID < 0) { // Use current fairLoc if defaulted.
		fairLocID = fairLocCount + 1;
	}

	setFairLocTwoPlayerTol(fairLocID, twoPlayerTol);
}

// Inter dist.
float fairLocInterDistMin = 0.0;
float fairLocInterDistMax = INF;

/*
** Gets the minimum distance fair locations of a player have to be separated by.
**
** @returns: the distance in meters
*/
float getFairLocInterDistMin() {
	return(fairLocInterDistMin);
}

/*
** Sets a minimum distance that fair locations of a player have to be separated by.
**
** @param val: the distance in meters
*/
void setFairLocInterDistMin(float val = 0.0) {
	fairLocInterDistMin = val;
}

/*
** Gets the maximum distance fair locations of a player have to be separated by.
**
** @returns: the distance in meters
*/
float getFairLocInterDistMax() {
	return(fairLocInterDistMax);
}

/*
** Sets a maximum distance that fair locations of a player can be separated by.
**
** @param val: the distance in meters
*/
void setFairLocInterDistMax(float val = INF) {
	fairLocInterDistMax = val;
}

// Min cross distance.
float fairLocMinCrossDist = 0.0;

/*
** Calculates the minimum cross distance that has to be guaranteed.
** This is the minimum distance that the separately specified fair locations (addFairLoc()) have to be apart from each other.
** Example: 2 fair locations were added with 80.0 and 60.0 areaDist, this means that the minimum cross distance is 60.0.
**
** Distance within the specific fair locations is checked separately.
**
** @returns: the minimum area distance of all specified fair locations.
*/
float calcFairLocMinCrossDist() {
	float tempMinCrossDist = INF;

	for(i = 1; <= fairLocCount) {
		if(getFairLocAreaDist(i) < tempMinCrossDist) {
			tempMinCrossDist = getFairLocAreaDist(i);
		}
	}

	fairLocMinCrossDist = tempMinCrossDist;
}

// Players start from 1 by convention (0 = Mother Nature).
int fairLoc1Player1 = -1; int fairLoc1Player2  = -1; int fairLoc1Player3  = -1; int fairLoc1Player4  = -1;
int fairLoc1Player5 = -1; int fairLoc1Player6  = -1; int fairLoc1Player7  = -1; int fairLoc1Player8  = -1;
int fairLoc1Player9 = -1; int fairLoc1Player10 = -1; int fairLoc1Player11 = -1; int fairLoc1Player12 = -1;

int getFairLoc1Player(int i = 0) {
	if(i == 1) return(fairLoc1Player1); if(i == 2)  return(fairLoc1Player2);  if(i == 3)  return(fairLoc1Player3);  if(i == 4)  return(fairLoc1Player4);
	if(i == 5) return(fairLoc1Player5); if(i == 6)  return(fairLoc1Player6);  if(i == 7)  return(fairLoc1Player7);  if(i == 8)  return(fairLoc1Player8);
	if(i == 9) return(fairLoc1Player9); if(i == 10) return(fairLoc1Player10); if(i == 11) return(fairLoc1Player11); if(i == 12) return(fairLoc1Player12);
	return(-1);
}

void setFairLoc1Player(int i = 0, int id = -1) {
	if(i == 1) fairLoc1Player1 = id; if(i == 2)  fairLoc1Player2  = id; if(i == 3)  fairLoc1Player3  = id; if(i == 4)  fairLoc1Player4  = id;
	if(i == 5) fairLoc1Player5 = id; if(i == 6)  fairLoc1Player6  = id; if(i == 7)  fairLoc1Player7  = id; if(i == 8)  fairLoc1Player8  = id;
	if(i == 9) fairLoc1Player9 = id; if(i == 10) fairLoc1Player10 = id; if(i == 11) fairLoc1Player11 = id; if(i == 12) fairLoc1Player12 = id;
}

int fairLoc2Player1 = -1; int fairLoc2Player2  = -1; int fairLoc2Player3  = -1; int fairLoc2Player4  = -1;
int fairLoc2Player5 = -1; int fairLoc2Player6  = -1; int fairLoc2Player7  = -1; int fairLoc2Player8  = -1;
int fairLoc2Player9 = -1; int fairLoc2Player10 = -1; int fairLoc2Player11 = -1; int fairLoc2Player12 = -1;

int getFairLoc2Player(int i = 0) {
	if(i == 1) return(fairLoc2Player1); if(i == 2)  return(fairLoc2Player2);  if(i == 3)  return(fairLoc2Player3);  if(i == 4)  return(fairLoc2Player4);
	if(i == 5) return(fairLoc2Player5); if(i == 6)  return(fairLoc2Player6);  if(i == 7)  return(fairLoc2Player7);  if(i == 8)  return(fairLoc2Player8);
	if(i == 9) return(fairLoc2Player9); if(i == 10) return(fairLoc2Player10); if(i == 11) return(fairLoc2Player11); if(i == 12) return(fairLoc2Player12);
	return(-1);
}

void setFairLoc2Player(int i = 0, int id = -1) {
	if(i == 1) fairLoc2Player1 = id; if(i == 2)  fairLoc2Player2  = id; if(i == 3)  fairLoc2Player3  = id; if(i == 4)  fairLoc2Player4  = id;
	if(i == 5) fairLoc2Player5 = id; if(i == 6)  fairLoc2Player6  = id; if(i == 7)  fairLoc2Player7  = id; if(i == 8)  fairLoc2Player8  = id;
	if(i == 9) fairLoc2Player9 = id; if(i == 10) fairLoc2Player10 = id; if(i == 11) fairLoc2Player11 = id; if(i == 12) fairLoc2Player12 = id;
}

int fairLoc3Player1 = -1; int fairLoc3Player2  = -1; int fairLoc3Player3  = -1; int fairLoc3Player4  = -1;
int fairLoc3Player5 = -1; int fairLoc3Player6  = -1; int fairLoc3Player7  = -1; int fairLoc3Player8  = -1;
int fairLoc3Player9 = -1; int fairLoc3Player10 = -1; int fairLoc3Player11 = -1; int fairLoc3Player12 = -1;

int getFairLoc3Player(int i = 0) {
	if(i == 1) return(fairLoc3Player1); if(i == 2)  return(fairLoc3Player2);  if(i == 3)  return(fairLoc3Player3);  if(i == 4)  return(fairLoc3Player4);
	if(i == 5) return(fairLoc3Player5); if(i == 6)  return(fairLoc3Player6);  if(i == 7)  return(fairLoc3Player7);  if(i == 8)  return(fairLoc3Player8);
	if(i == 9) return(fairLoc3Player9); if(i == 10) return(fairLoc3Player10); if(i == 11) return(fairLoc3Player11); if(i == 12) return(fairLoc3Player12);
	return(-1);
}

void setFairLoc3Player(int i = 0, int id = -1) {
	if(i == 1) fairLoc3Player1 = id; if(i == 2)  fairLoc3Player2  = id; if(i == 3)  fairLoc3Player3  = id; if(i == 4)  fairLoc3Player4  = id;
	if(i == 5) fairLoc3Player5 = id; if(i == 6)  fairLoc3Player6  = id; if(i == 7)  fairLoc3Player7  = id; if(i == 8)  fairLoc3Player8  = id;
	if(i == 9) fairLoc3Player9 = id; if(i == 10) fairLoc3Player10 = id; if(i == 11) fairLoc3Player11 = id; if(i == 12) fairLoc3Player12 = id;
}

int fairLoc4Player1 = -1; int fairLoc4Player2  = -1; int fairLoc4Player3  = -1; int fairLoc4Player4  = -1;
int fairLoc4Player5 = -1; int fairLoc4Player6  = -1; int fairLoc4Player7  = -1; int fairLoc4Player8  = -1;
int fairLoc4Player9 = -1; int fairLoc4Player10 = -1; int fairLoc4Player11 = -1; int fairLoc4Player12 = -1;

int getFairLoc4Player(int i = 0) {
	if(i == 1) return(fairLoc4Player1); if(i == 2)  return(fairLoc4Player2);  if(i == 3)  return(fairLoc4Player3);  if(i == 4)  return(fairLoc4Player4);
	if(i == 5) return(fairLoc4Player5); if(i == 6)  return(fairLoc4Player6);  if(i == 7)  return(fairLoc4Player7);  if(i == 8)  return(fairLoc4Player8);
	if(i == 9) return(fairLoc4Player9); if(i == 10) return(fairLoc4Player10); if(i == 11) return(fairLoc4Player11); if(i == 12) return(fairLoc4Player12);
	return(-1);
}

void setFairLoc4Player(int i = 0, int id = -1) {
	if(i == 1) fairLoc4Player1 = id; if(i == 2)  fairLoc4Player2  = id; if(i == 3)  fairLoc4Player3  = id; if(i == 4)  fairLoc4Player4  = id;
	if(i == 5) fairLoc4Player5 = id; if(i == 6)  fairLoc4Player6  = id; if(i == 7)  fairLoc4Player7  = id; if(i == 8)  fairLoc4Player8  = id;
	if(i == 9) fairLoc4Player9 = id; if(i == 10) fairLoc4Player10 = id; if(i == 11) fairLoc4Player11 = id; if(i == 12) fairLoc4Player12 = id;
}

/*
** Gets a player in the array that stores the placement order of a fair location.
**
** @param fairLocID: the ID of the fair location
** @param i: the index in the array to retrieve
** @param id: the player number to store in the specified array and index
*/
void setFairLocPlayer(int fairLocID = -1, int i = 0, int id = -1) {
	if(fairLocID == 1) {
		setFairLoc1Player(i, id);
	} else if(fairLocID == 2) {
		setFairLoc2Player(i, id);
	} else if(fairLocID == 3) {
		setFairLoc3Player(i, id);
	} else if(fairLocID == 4) {
		setFairLoc4Player(i, id);
	}
}

/*
** Gets a player from the array that stores the placement order of a fair location.
**
** @param fairLocID: the ID of the fair location
** @param i: the index in the array to retrieve
**
** @returns: the player stored in the specified array (fairLocID) and index
*/
int getFairLocPlayer(int fairLocID = -1, int i = 0) {
	if(fairLocID == 1) {
		return(getFairLoc1Player(i));
	} else if(fairLocID == 2) {
		return(getFairLoc2Player(i));
	} else if(fairLocID == 3) {
		return(getFairLoc3Player(i));
	} else if(fairLocID == 4) {
		return(getFairLoc4Player(i));
	}

	// Should never be reached.
	return(-1);
}

/*
** Sets the order in which fair locations are placed for a given fair location ID.
** This can be either inside out or outside in according to playerTeamPos values, i.e., the position of a player in a team.
** For instance, for 4v4 this means (F = first, C = center, L = last):
**
** 1 (F) <-> 8 (L)
** 2 (C) <-> 7 (C)
** 3 (C) <-> 6 (C)
** 4 (L) <-> 5 (F)
**
** For inside out, the players are ordered such that the center players (2, 3, 6, 7) have their locations placed first, then 1 and 5 and finally 4 and 8.
** For outside in, the inverse is done.
**
** For mirroring, the behavior is different: The respective mirrored player is inserted right after the "original" player.
**
** @param fairLocID: the ID of the fair location
*/
void setFairLocPlayerOrder(int fairLocID = -1) {
	int posStart = 0;
	int posEnd = cNumTeamPos - 1;

	// Go from negatve positions to 0 if we're placing inside out and take abs of p when used.
	if(getFairLocInsideOut(fairLocID)) {
		posStart = 0 - posEnd;
		posEnd = 0;
	}

	int currPlayer = 1;
	int numPlayers = cNonGaiaPlayers;

	if(isMirrorOnAndValidConfig()) {
		numPlayers = getNumberPlayersOnTeam(0);
	}

	// Iterate over positions.
	for(p = posStart; <= posEnd) {

		// Iterate over players that have the current position.
		for(i = 1; <= numPlayers) {
			if(getPlayerTeamPos(i) != abs(p)) {
				// Player doesn't have current position, move on to next player.
				continue;
			}

			// Set mirrored player first (as it's position is also evaluated first).
			if(isMirrorOnAndValidConfig()) {
				setFairLocPlayer(fairLocID, currPlayer, getMirroredPlayer(i));
				currPlayer++;
			}

			setFairLocPlayer(fairLocID, currPlayer, i);

			currPlayer++;
		}

	}
}

/*
** Adds a fair location.
** Note that additional options such as enableFairLocTwoPlayerCheck() has to be called before this or it will apply to the next fair location.
**
** @param minDist: the minimum distance of the radius for the fair location from the player location
** @param maxDist: the maximum distance of the radius for the fair location from the player location
** @param forward: whether the location should be forward or backward with respect to the player
** @param inside: whether the location should be inside or outside with respect to the player
** @param areaDist: the distances between the areas that will be enforced (!)
** @param distX: edge distance of the x axis of the location
** @param distZ: edge distance of the z axis of the location
** @param inPlayerArea: whether the location should be enforced to lie within a player's section of the map
** @param inTeamArea: whether the location should be enforced to lie within a player's team section of the map
** @param isSquare: if true, the radius is converted to a square (the original rmPlaceObjectDef does this)
** @param insideOut: whether to start from the inner players or from the outer players when placing the locations
** @param fairLocID: the ID of the fair location; if not given, the default counter is used (starting at 1)
*/
void addFairLoc(float minDist = 0.0, float maxDist = -1.0, bool forward = false, bool inside = false, float areaDist = 0.0, float distX = 0.0, float distZ = -1.0,
				bool inPlayerArea = false, bool inTeamArea = false, bool isSquare = false, bool insideOut = true, int fairLocID = -1) {
	fairLocCount++;

	if(distZ < 0.0) {
		distZ = distX;
	}

	if(fairLocID < 0) {
		fairLocID = fairLocCount;
	}

	setFairLocMinDist(fairLocID, minDist);
	setFairLocMaxDist(fairLocID, maxDist);
	setFairLocForward(fairLocID, forward);
	setFairLocInside(fairLocID, inside);
	setFairLocAreaDist(fairLocID, areaDist);
	setFairLocDistX(fairLocID, distX);
	setFairLocDistZ(fairLocID, distZ);
	setFairLocInPlayerArea(fairLocID, inPlayerArea);
	setFairLocInTeamArea(fairLocID, inTeamArea);
	setFairLocIsSquare(fairLocID, isSquare);
	setFairLocInsideOut(fairLocID, insideOut);

	// Update minCrossDist.
	calcFairLocMinCrossDist();

	// Set player order.
	setFairLocPlayerOrder(fairLocID);
}

/*
** Adds a fair location and uses the same constraints as the previous fairLoc did (but NOT same twoPlayerTol, etc.).
**
** @param minDist: the minimum distance of the radius for the fair location from the player location
** @param maxDist: the maximum distance of the radius for the fair location from the player location
** @param forward: whether the location should be forward or backward with respect to the player
** @param inside: whether the location should be inside or outside with respect to the player
** @param areaDist: the distances between the areas that will be enforced (!)
** @param distX: edge distance of the x axis of the location
** @param distZ: edge distance of the z axis of the location
** @param inPlayerArea: whether the location should be enforced to lie within a player's section of the map
** @param inTeamArea: whether the location should be enforced to lie within a player's team section of the map
** @param isSquare: if true, the radius is converted to a square (the original rmPlaceObjectDef does this)
** @param insideOut: whether to start from the inner players or from the outer players when placing the locations
** @param fairLocID: the ID of the fair location; if not given, the default counter is used (starting at 1)
*/
void addFairLocWithPrevConstraints(float minDist = 0.0, float maxDist = -1.0, bool forward = false, bool inside = false, float areaDist = 0.0,
								   float distX = 0.0, float distZ = -1.0, bool inPlayerArea = false, bool inTeamArea = false, bool isSquare = false,
								   bool insideOut = true, int fairLocID = -1) {
	if(fairLocID < 0) {
		fairLocID = fairLocCount + 1;
	}

	if(lastAddedFairLocID > 0) {
		for(i = 1; <= getFairLocConstraintCount(lastAddedFairLocID)) {
			addFairLocConstraint(getFairLocConstraint(lastAddedFairLocID, i), fairLocID);
		}
	}

	// Set player order.
	setFairLocPlayerOrder(fairLocID);
}

/*
** Resets all fair loc values.
*/
void resetFairLocVals() {
	fairLoc1X1 = -1.0; fairLoc1X2  = -1.0; fairLoc1X3  = -1.0; fairLoc1X4  = -1.0;
	fairLoc1X5 = -1.0; fairLoc1X6  = -1.0; fairLoc1X7  = -1.0; fairLoc1X8  = -1.0;
	fairLoc1X9 = -1.0; fairLoc1X10 = -1.0; fairLoc1X11 = -1.0; fairLoc1X12 = -1.0;

	fairLoc2X1 = -1.0; fairLoc2X2  = -1.0; fairLoc2X3  = -1.0; fairLoc2X4  = -1.0;
	fairLoc2X5 = -1.0; fairLoc2X6  = -1.0; fairLoc2X7  = -1.0; fairLoc2X8  = -1.0;
	fairLoc2X9 = -1.0; fairLoc2X10 = -1.0; fairLoc2X11 = -1.0; fairLoc2X12 = -1.0;

	fairLoc3X1 = -1.0; fairLoc3X2  = -1.0; fairLoc3X3  = -1.0; fairLoc3X4  = -1.0;
	fairLoc3X5 = -1.0; fairLoc3X6  = -1.0; fairLoc3X7  = -1.0; fairLoc3X8  = -1.0;
	fairLoc3X9 = -1.0; fairLoc3X10 = -1.0; fairLoc3X11 = -1.0; fairLoc3X12 = -1.0;

	fairLoc4X1 = -1.0; fairLoc4X2  = -1.0; fairLoc4X3  = -1.0; fairLoc4X4  = -1.0;
	fairLoc4X5 = -1.0; fairLoc4X6  = -1.0; fairLoc4X7  = -1.0; fairLoc4X8  = -1.0;
	fairLoc4X9 = -1.0; fairLoc4X10 = -1.0; fairLoc4X11 = -1.0; fairLoc4X12 = -1.0;

	fairLoc1Z1 = -1.0; fairLoc1Z2  = -1.0; fairLoc1Z3  = -1.0; fairLoc1Z4  = -1.0;
	fairLoc1Z5 = -1.0; fairLoc1Z6  = -1.0; fairLoc1Z7  = -1.0; fairLoc1Z8  = -1.0;
	fairLoc1Z9 = -1.0; fairLoc1Z10 = -1.0; fairLoc1Z11 = -1.0; fairLoc1Z12 = -1.0;

	fairLoc2Z1 = -1.0; fairLoc2Z2  = -1.0; fairLoc2Z3  = -1.0; fairLoc2Z4  = -1.0;
	fairLoc2Z5 = -1.0; fairLoc2Z6  = -1.0; fairLoc2Z7  = -1.0; fairLoc2Z8  = -1.0;
	fairLoc2Z9 = -1.0; fairLoc2Z10 = -1.0; fairLoc2Z11 = -1.0; fairLoc2Z12 = -1.0;

	fairLoc3Z1 = -1.0; fairLoc3Z2  = -1.0; fairLoc3Z3  = -1.0; fairLoc3Z4  = -1.0;
	fairLoc3Z5 = -1.0; fairLoc3Z6  = -1.0; fairLoc3Z7  = -1.0; fairLoc3Z8  = -1.0;
	fairLoc3Z9 = -1.0; fairLoc3Z10 = -1.0; fairLoc3Z11 = -1.0; fairLoc3Z12 = -1.0;

	fairLoc4Z1 = -1.0; fairLoc4Z2  = -1.0; fairLoc4Z3  = -1.0; fairLoc4Z4  = -1.0;
	fairLoc4Z5 = -1.0; fairLoc4Z6  = -1.0; fairLoc4Z7  = -1.0; fairLoc4Z8  = -1.0;
	fairLoc4Z9 = -1.0; fairLoc4Z10 = -1.0; fairLoc4Z11 = -1.0; fairLoc4Z12 = -1.0;
}

/*
** Clean fair location settings. Should be called after placing a set of fair locations (and before the next ones are defined).
*/
void resetFairLocs() {
	fairLocCount = 0;
	lastFairLocIters = -1;
	lastAddedFairLocID = -1;

	fairLocMinCrossDist = 0.0;
	fairLocInterDistMin = 0.0;
	fairLocInterDistMax = INF;

	// Write the resetting a bit more compact to save some lines.
	fairLocConstraintCount1 = 0; fairLocConstraintCount2 = 0;	fairLocConstraintCount3 = 0; fairLocConstraintCount4 = 0;
	fairLoc1TwoPlayerTol = -1.0; fairLoc2TwoPlayerTol = -1.0; fairLoc3TwoPlayerTol = -1.0; fairLoc4TwoPlayerTol = -1.0;

	fairLoc1Player1 = -1; fairLoc1Player2  = -1; fairLoc1Player3  = -1; fairLoc1Player4  = -1;
	fairLoc1Player5 = -1; fairLoc1Player6  = -1; fairLoc1Player7  = -1; fairLoc1Player8  = -1;
	fairLoc1Player9 = -1; fairLoc1Player10 = -1; fairLoc1Player11 = -1; fairLoc1Player12 = -1;

	fairLoc2Player1 = -1; fairLoc2Player2  = -1; fairLoc2Player3  = -1; fairLoc2Player4  = -1;
	fairLoc2Player5 = -1; fairLoc2Player6  = -1; fairLoc2Player7  = -1; fairLoc2Player8  = -1;
	fairLoc2Player9 = -1; fairLoc2Player10 = -1; fairLoc2Player11 = -1; fairLoc2Player12 = -1;

	fairLoc3Player1 = -1; fairLoc3Player2  = -1; fairLoc3Player3  = -1; fairLoc3Player4  = -1;
	fairLoc3Player5 = -1; fairLoc3Player6  = -1; fairLoc3Player7  = -1; fairLoc3Player8  = -1;
	fairLoc3Player9 = -1; fairLoc3Player10 = -1; fairLoc3Player11 = -1; fairLoc3Player12 = -1;

	fairLoc4Player1 = -1; fairLoc4Player2  = -1; fairLoc4Player3  = -1; fairLoc4Player4  = -1;
	fairLoc4Player5 = -1; fairLoc4Player6  = -1; fairLoc4Player7  = -1; fairLoc4Player8  = -1;
	fairLoc4Player9 = -1; fairLoc4Player10 = -1; fairLoc4Player11 = -1; fairLoc4Player12 = -1;

	// As of now, the following resets are actually not needed, but we do it anyway to keep it clean.
	resetFairLocVals();
}

/**************
* FAIR ANGLES *
**************/

/*
 * Note that most functions here are mutable, i.e., you can overwrite them in your own script by redefining them.
 * This should allow for specific fair location generation if your map is not suitable for the default angles that work for most maps.
 *
 * Angle orientation (as seen from the center when looking towards a player):
 * 0		= Behind
 * PI / 2	= Left (seen from center!)
 * PI;		= Front
 * 3PI / 2	= Right (seen from center!)
 *
 * Note that these angles are always relative to a player as they are added to the player angle when placing fair locations.
 * For instance, an angle of PI / 2 directs exactly perpendicular to the left of a player when looking from the center towards the player's location.
*/

/*****************
* FORWARD ANGLES *
*****************/

/*
 * The following functions all have the same signature so I won't document them all individually.
 * All of them are used to randomize backward angles for the different settings in randBackward().
 *
 * A larger tolerance means that the angle search range has been extended by the algorithm
 * due to failing too often to find a valid location.
 *
 * tol: the tolerance in [0, 1.0]
 *
 * returns: the randomized angle.
*/

mutable float randFwdInsideFirst(float tol = 0.0) {
	return(rmRandFloat(0.7 - 0.3 * tol, 1.0 + 0.5 * tol) * PI);
}

mutable float randFwdOutsideFirst(float tol = 0.0) {
	return(rmRandFloat(1.0 - 0.5 * tol, 1.3 + 0.2 * tol) * PI);
}

mutable float randFwdInsideLast(float tol = 0.0) {
	return(rmRandFloat(1.0 - 0.5 * tol, 1.3 + 0.2 * tol) * PI);
}

mutable float randFwdOutsideLast(float tol = 0.0) {
	return(rmRandFloat(0.7 - 0.3 * tol, 1.0 + 0.5 * tol) * PI);
}

mutable float randFwdCenter(float tol = 0.0) {
	if(tol == 0.0) {
		return(rmRandFloat(0.8, 1.2) * PI);
	} else {
		return(randFromIntervals(0.8 - 0.6 * tol, 0.8, 1.2, 1.2 + 0.6 * tol) * PI);
	}
}

mutable float randFwdInsideSingle(float tol = 0.0) {
	if(randChance()) {
		return(randFwdInsideFirst(tol));
	} else {
		return(randFwdInsideLast(tol));
	}
}

mutable float randFwdOutsideSingle(float tol = 0.0) {
	if(randChance()) {
		return(randFwdInsideFirst(tol));
	} else {
		return(randFwdInsideLast(tol));
	}
}

/*
** Randomizes an angle for a forward position with respect to a given player team position.
**
** @param inside: whether the angle should be towards the team or away from the team
** @param playerTeamPos: the orientation of the player within the team
** @param tol: tolerance for the angle; larger tolerance means that the angle may not lie within the original section anymore
**
** @returns: the randomized angle in radians
*/
mutable float randForward(bool inside = false, int playerTeamPos = -1, float tol = 0.0) {
	if(playerTeamPos == cPosSingle) {
		if(inside) {
			return(randFwdInsideSingle(tol));
		} else {
			return(randFwdOutsideSingle(tol));
		}
	}

	if(playerTeamPos == cPosFirst) {
		if(inside) {
			return(randFwdInsideFirst(tol));
		} else {
			return(randFwdOutsideFirst(tol));
		}
	}

	if(playerTeamPos == cPosLast) {
		if(inside) {
			return(randFwdInsideLast(tol));
		} else {
			return(randFwdOutsideLast(tol));
		}
	}

	if(playerTeamPos == cPosCenter) {
		return(randFwdCenter(tol));
	}

	return(rmRandFloat(0.0, 2.0 * PI)); // Should never happen.
}

/******************
* BACKWARD ANGLES *
******************/

/*
** The following functions all have the same signature so I won't document them all individually.
** All of them are used to randomize backward angles for the different settings in randBackward().
**
** A larger tolerance means that the angle search range has been extended by the algorithm
** due to failing too often to find a valid location.
**
** tol: the tolerance in [0, 1.0]
**
** returns: the randomized angle.
*/

mutable float randBackInsideFirst(float tol = 0.0) {
	return(rmRandFloat(-0.05 - 0.45 * tol, 0.3 + 0.3 * tol) * PI);
}

mutable float randBackOutsideFirst(float tol = 0.0) {
	return(rmRandFloat(1.7 - 0.3 * tol, 2.05 + 0.45 * tol) * PI);
}

mutable float randBackInsideLast(float tol = 0.0) {
	return(rmRandFloat(1.7 - 0.3 * tol, 2.05 + 0.45 * tol) * PI);
}

mutable float randBackOutsideLast(float tol = 0.0) {
	return(rmRandFloat(-0.05 - 0.45 * tol, 0.3 + 0.3 * tol) * PI);
}

mutable float randBackCenter(float tol = 0.0) {
	if(tol == 0.0) {
		return(rmRandFloat(-0.3, 0.3) * PI);
	} else {
		return(randFromIntervals(-0.3 - tol * 0.5, -0.3, 0.3, 0.3 + tol * 0.5) * PI);
	}
}

mutable float randBackInsideSingle(float tol = 0.0) {
	return(rmRandFloat(-0.4 - 0.4 * tol, 0.4 + 0.4 * tol) * PI);

}

mutable float randBackOutsideSingle(float tol = 0.0) {
	return(rmRandFloat(-0.4 - 0.4 * tol, 0.4 + 0.4 * tol) * PI);
}

/*
** Randomizes an angle for a backward position with respect to a given player team position.
**
** @param inside: whether the angle should be towards the team or away from the team
** @param playerTeamPos: the orientation of the player within the team
** @param tol: tolerance for the angle; larger tolerance means that the angle may not lie within the original section anymore
**
** @returns: the randomized angle in radians
*/
mutable float randBackward(bool inside = false, int playerTeamPos = -1, float tol = 0.0) {
	if(playerTeamPos == cPosSingle) {
		if(inside) {
			return(randBackInsideSingle(tol));
		} else {
			return(randBackOutsideSingle(tol));
		}
	}

	if(playerTeamPos == cPosFirst) {
		if(inside) {
			return(randBackInsideFirst(tol));
		} else {
			return(randBackOutsideFirst(tol));
		}
	}

	if(playerTeamPos == cPosLast) {
		if(inside) {
			return(randBackInsideLast(tol));
		} else {
			return(randBackOutsideLast(tol));
		}
	}

	if(playerTeamPos == cPosCenter) {
		return(randBackCenter(tol));
	}

	return(rmRandFloat(0.0, 2.0 * PI)); // Should never happen.
}

/*
** Randomizes a fair angle for a given player according to forward/inside settings.
**
** @param player: the player number (already mapped; player = 1 corresponds to getPlayer(1))
** @param forward: whether the location should be forward or backward with respect to the player
** @param inside: whether the location should be inside or outside with respect to the player
** @param tol: tolerance for the angle; larger tolerance means that the angle may not lie within the original section anymore
**
** @returns: the randomized angle in radians
*/
mutable float getRandomFairAngle(int player = 0, bool forward = false, bool inside = false, float tol = 0.0) {
	int playerTeamPos = getPlayerTeamPos(player);

	if(forward) {
		return(randForward(inside, playerTeamPos, tol));
	} else {
		return(randBackward(inside, playerTeamPos, tol));
	}
}

/*************
* GENERATION *
*************/

/*
** Performs an additional check that leads to very balanced placement in 1v1 situations.
** This check essentially calculates the ratio of the players' distance to the fair location of the respective other player.
** The fraction has to be smaller than twoPlayerTol to succeed, i.e., less than a certain percentage (0.125 -> difference in distance is less than 12.5%).
**
** @param fairLocID: the location ID of the fair location to check
**
** @returns: true if the check succeeded, false otherwise
*/
bool performFairLocTwoPlayerCheck(int fairLocID = -1) {
	if(cNonGaiaPlayers != 2) {
		return(true);
	}

	float twoPlayerTol = getFairLocTwoPlayerTol(fairLocID);

	if(twoPlayerTol < 0.0) { // Not set.
		return(true);
	}

	// Get the distance in meters between p1 and the fair loc of p2 and the other way around.
	float distP1 = pointsGetDist(rmXFractionToMeters(getPlayerLocXFraction(1)), rmZFractionToMeters(getPlayerLocZFraction(1)),
								 rmXFractionToMeters(getFairLocX(fairLocID, 2)), rmZFractionToMeters(getFairLocZ(fairLocID, 2)));

	float distP2 = pointsGetDist(rmXFractionToMeters(getPlayerLocXFraction(2)), rmZFractionToMeters(getPlayerLocZFraction(2)),
								 rmXFractionToMeters(getFairLocX(fairLocID, 1)), rmZFractionToMeters(getFairLocZ(fairLocID, 1)));

	// Divide the smaller distance by the larger to get the fraction.
	if(distP1 < distP2) {
		if(1.0 - distP1 / distP2 > twoPlayerTol) {
			return(false);
		}
	} else {
		if(1.0 - distP2 / distP1 > twoPlayerTol) {
			return(false);
		}
	}

	return(true);
}

/*
** Checks if a fair location with a radius and angle is valid (within map coordinates) and sets the values for the player.
** Also sets the x/z values for the mirrored player if mirroring is enabled.
**
** @param fairLocID: the ID of the fair location
** @param player: the player
** @param radius: the radius to use for the location
** @param angle: the angle in radians to use
**
** @returns: true if a valid location was obtained, false otherwise
*/
bool checkAndSetFairLoc(int fairLocID = -1, int player = 0, float radius = 0.0, float angle = 0.0) {
	float x = getXFromPolarForPlayer(player, radius, angle, getFairLocIsSquare(fairLocID));
	float z = getZFromPolarForPlayer(player, radius, angle, getFairLocIsSquare(fairLocID));

	if(isLocValid(x, z, rmXMetersToFraction(getFairLocDistX(fairLocID)), rmZMetersToFraction(getFairLocDistZ(fairLocID))) == false) {
		return(false);
	}

	setFairLocXZ(fairLocID, player, x, z);

	// Also set mirrored coordinates if necessary.
	if(isMirrorOnAndValidConfig()) {
		player = getMirroredPlayer(player);

		if(getMirrorMode() != cMirrorPoint) {
			angle = 0.0 - angle;
		}

		x = getXFromPolarForPlayer(player, radius, angle, getFairLocIsSquare(fairLocID));
		z = getZFromPolarForPlayer(player, radius, angle, getFairLocIsSquare(fairLocID));

		setFairLocXZ(fairLocID, player, x, z);
	}

	return(true);
}

/*
** Compares two fair locations and evaluates their validity according to the specified constraints.
**
** The following constraints are checked:
** 1. fairLocInterDistMin (if specified): minimum distance fair locations of a player have to be apart from each other.
**    If not set, the cross distance is used as value (in the cross distance check as this is always performed).
**
** 2. fairLocInterDistMax (if specified): maximum distance fair locations of a player can be apart from each other.
**
** 3. fairLocAreaDist: minimum distance fair locations with the same fair location ID have to be apart from each other.
**
** 4. fairLocMinCrossDist: minimum distance all specified fair locations have to be apart from each other.
**    This corresponds to the minimum areaDist value set when using addFairLoc().
**
** @param fairLocID1: fairLocID of the first fair location
** @param player1: player owning the first fair location
** @param fairLocID2: fairLocID of the second fair location
** @param player2: player owning the second fair location
**
** @returns: true if the comparison succeeded, false otherwise
*/
bool compareFairLocs(int fairLocID1 = -1, int player1 = 0, int fairLocID2 = -1, int player2 = 0) {
	float dist = pointsGetDist(rmXFractionToMeters(getFairLocX(fairLocID1, player1)), rmZFractionToMeters(getFairLocZ(fairLocID1, player1)),
							   rmXFractionToMeters(getFairLocX(fairLocID2, player2)), rmZFractionToMeters(getFairLocZ(fairLocID2, player2)));

	// Calculate fair loc inter distance (distance among fair locs of a player).
	if(player1 == player2) {
		if(dist < fairLocInterDistMin) {
			return(false);
		}

		if(dist > fairLocInterDistMax) {
			return(false);
		}
	}

	// Calculate fair loc intra distance (compare fair loc to the same fair loc of the other players).
	if(fairLocID1 == fairLocID2 && dist < getFairLocAreaDist(fairLocID1)) {
		return(false);
	}

	// Calculate fair loc cross distance.
	if(dist < fairLocMinCrossDist) {
		return(false);
	}

	return(true);
}

/*
** Performs checks to ensure that a fair location adheres to the specified settings (distance settings, NOT area constraints!).
** The check involves comparing the current fair location to be placed against all other fair locations that were previously placed.
**
** @param fairLocID: the fair location ID of the location to check
** @param player: the player owning the fair location
**
** @returns: true if the check succeeded, false otherwise
*/
bool checkFairLoc(int fairLocID = -1, int player = 0) {
	// Iterate over fair locs.
	for(f = 1; <= fairLocID) {

		// Iterate over players.
		for(i = 1; < cPlayers) {
			// Map player to loc player array.
			int p = getFairLocPlayer(f, i);

			if(f == fairLocID && p == player) {
				// Terminate early if we made it this far, skip remaining player for last fairLoc as they have not had their fairLoc placed yet.
				return(true);
			}

			if(compareFairLocs(fairLocID, player, f, p) == false) {
				return(false);
			}
		}

	}
}

/*
** Attempts to build a previously placed fair location with respect to the constraints.
** Also adds player area and team area constraints if specified.
**
** @param fairLocID: the ID of the fair location
** @param player: the player (unmapped)
**
** @returns: true if the area was built, false otherwise
*/
bool buildFairLoc(int fairLocID = -1, int player = 0) {
	// Define areas, apply constraints and try to place.
	int areaID = rmCreateArea(cFairLocName + " " + fairLocNameCounter);

	rmSetAreaLocation(areaID, getFairLocX(fairLocID, player), getFairLocZ(fairLocID, player));

	rmSetAreaSize(areaID, rmXMetersToFraction(0.1));
	//rmSetAreaTerrainType(areaID, "HadesBuildable1");
	//rmSetAreaBaseHeight(areaID, 10.0);
	rmSetAreaCoherence(areaID, 1.0);
	rmSetAreaWarnFailure(areaID, false);

	fairLocNameCounter++;

	// Add all defined constraints.
	for(j = 1; <= getFairLocConstraintCount(fairLocID)) {
		rmAddAreaConstraint(areaID, getFairLocConstraint(fairLocID, j));
	}

	// Add player area constraint if enabled.
	if(getFairLocInPlayerArea(fairLocID)) {
		rmAddAreaConstraint(areaID, getPlayerAreaConstraint(player));
	}

	// Add team area constraint if enabled.
	if(getFairLocInTeamArea(fairLocID)) {
		rmAddAreaConstraint(areaID, getTeamAreaConstraint(player));
	}

	return(rmBuildArea(areaID));
}

/*
** Single attempt to create a fair location.
**
** @param fairLocID: the location ID of the fair location
** @param player: the player owning the fair location
** @param tol: tolerance for the angle; larger tolerance means that the angle may not lie within the original section anymore
**
** @returns: true upon success, false otherwise
*/
bool createFairLocForPlayer(int fairLocID = -1, int player = 0, float tol = 0.0) {
	float angle = getRandomFairAngle(player, getFairLocForward(fairLocID), getFairLocInside(fairLocID), tol) + getPlayerTeamOffsetAngle(player);
	float radius = randRadiusFromInterval(getFairLocMinDist(fairLocID), getFairLocMaxDist(fairLocID));

	if(checkAndSetFairLoc(fairLocID, player, radius, angle) == false) {
		return(false);
	}

	// This is probably not necessary because the next check also considers the location placed for getMirroredPlayer(player).
	// if(isMirrorOnAndValidConfig()) {
		// if(checkFairLoc(fairLocID, getMirroredPlayer(player)) == false) {
			// return(false)
		// }
	// }

	if(checkFairLoc(fairLocID, player) == false) {
		return(false);
	}

	if(isMirrorOnAndValidConfig()) {
		if(buildFairLoc(fairLocID, getMirroredPlayer(player)) == false) {
			return(false);
		}
	}

	return(buildFairLoc(fairLocID, player));
}

/*
** Tries to create a valid fair location for a player according to the parameters specified by addFairLoc().
** The algorithm tries to find a valid location for a given number of times.
**
** @param fairLocID: the location ID of the fair location
** @param player: the player owning the fair location
** @param maxIter: the number of attempts to find the location
**
** @returns: the number of iterations that were required to find a location; -1 indicates failure
*/
int createFairLocFromParams(int fairLocID = -1, int player = 0, int maxIter = 100) {
	float tol = 0.0;
	int localIter = 0;
	int failCount = 0;

	while(localIter < maxIter) {
		// Increase tolerance upon failing several times.
		if(failCount >= 10) {
			failCount = 5;
			tol = min(tol + 0.1, 1.0); // Make sure we don't exceed 100% tolerance.
		}

		localIter++;

		// Try to find valid location.
		if(createFairLocForPlayer(fairLocID, player, tol)) {
			return(localIter);
		}

		failCount++;
	}

	// -1 = failed to find a location within maxIter iterations, caller can decide what to do with this value.
	return(-1);
}

/*
** Runs the fair location placement algorithm.
** If a mirror mode is set, the created fair locations will be mirrored.
**
** @param maxIter: the maximum number of iterations to run the algorithm for
** @param localMaxIter: the maximum attempts to find a fair location for every player before starting over
**
** @returns: true upon success, false otherwise
*/
bool runFairLocs(int maxIter = 5000, int localMaxIter = 100) {
	int currIter = 0;
	int numPlayers = cNonGaiaPlayers;
	bool done = false;

	// Adjust player number in case we mirror.
	if(isMirrorOnAndValidConfig()) {
		numPlayers = getNumberPlayersOnTeam(0);
	}

	while(currIter < maxIter && done == false) {
		done = true;

		// Iterate over fair locations.
		for(f = 1; <= fairLocCount) {

			// Iterate over players.
			for(i = 1; <= numPlayers) {
				int p = getFairLocPlayer(f, i);

				if(isMirrorOnAndValidConfig()) {
					p = getFairLocPlayer(f, (i - 1) * 2 + 1);
				}

				int numIter = createFairLocFromParams(f, p, localMaxIter);

				if(numIter < 0) { // Failed, increment currIter; could also penalize fails later in the algorithm harder.
					currIter = currIter + localMaxIter;
					done = false;
					break;
				}

				currIter = currIter + numIter;
			}

			if(done == false) {
				break;
			} else if(performFairLocTwoPlayerCheck(f) == false) {
				done = false;
				break;
			}
		}
	}

	if(done == false) {
		lastFairLocIters = -1;
		return(false);
	}

	lastFairLocIters = currIter;
	return(true);
}

/*
** Attempts to create fair locations according to the added definitions and chosen settings.
** Also considers mirroring if a mirror mode was set prior to the call.
**
** @param fairLocLabel: the name of the fair location (only used for debugging purposes)
** @param isCrucial: whether the fair loc is crucial and players should be warned if it fails or not
** @param maxIter: the maximum number of iterations to run the algorithm for
** @param localMaxIter: the maximum attempts to find a fair location for every player before starting over
**
** @returns: true if the locations were successfully generated, false otherwise
*/
bool createFairLocs(string fairLocLabel = "", bool isCrucial = true,  int maxIter = 5000, int localMaxIter = 100) {
	// Initialize splits if not already done.
	initializePlayerAreaConstraints();
	initializeTeamAreaConstraints();

	bool success = runFairLocs(maxIter, localMaxIter);

	// Clear values if not debugging.
	if(success == false && cDebugMode < cDebugTest) {
		resetFairLocVals();
	}

	// Print message if debugging.
	string varSpace = " ";

	if(fairLocLabel == "") {
		varSpace = "";
	}

	if(lastFairLocIters >= 0) {
		printDebug("fairLoc" + varSpace + fairLocLabel + " succeeded: i = " + lastFairLocIters, cDebugTest);
	}

	// Log result.
	addCustomCheck("fairLoc" + varSpace + fairLocLabel, isCrucial, success);

	return(success);
}

/*
** Creates (fake) areas on the fair locations and adds them to a class.
** Useful if you need to block fair areas, but do not want to place objects on them yet.
**
** @param classID: the ID of the class to add the fair locations to
** @param areaMeterRadius: the radius of the (invisible) area to create
** @param fairLocID: the ID of the fair location to create the areas from; if defaulted to -1, all stored fair locations will have locations generated
*/
void fairLocAreasToClass(int classID = -1, float areaMeterRadius = 5.0, int fairLocID = -1) {
	int fairLocStartID = 1;

	if(fairLocID < 0) {
		fairLocID = fairLocCount;
	} else {
		fairLocStartID = fairLocID;
	}

	for(i = fairLocStartID; <= fairLocID) {
		for(j = 1; < cPlayers) {
			int fairLocAreaID = rmCreateArea(cFairLocAreaName + " " + fairLocAreaNameCounter + " " + i + " " + j);
			rmSetAreaLocation(fairLocAreaID, getFairLocX(i, j), getFairLocZ(i, j));
			rmSetAreaSize(fairLocAreaID, areaRadiusMetersToFraction(areaMeterRadius));
			rmSetAreaCoherence(fairLocAreaID, 1.0);
			rmAddAreaToClass(fairLocAreaID, classID);
		}
	}

	rmBuildAllAreas();

	fairLocAreaNameCounter++;
}

/*
** Stores the current set of fair locations in the location storage.
*/
void storeFairLocs() {
	for(i = 1; <= fairLocCount) {
		for(j = 1; < cPlayers) {
			forceAddLocToStorage(getFairLocX(i, j), getFairLocZ(i, j), j);
		}
	}
}
