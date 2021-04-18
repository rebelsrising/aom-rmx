/*
** Similar location generation.
** RebelsRising
** Last edit: 07/03/2021
*/

include "rmx_fair_locs.xs";

/************
* CONSTANTS *
************/

// Bias constants.
extern const int cBiasNone = -1;
extern const int cBiasForward = 0;
extern const int cBiasBackward = 1;
extern const int cBiasSide = 2;
extern const int cBiasAggressive = 3; // More aggressive version of cBiasForward.
extern const int cBiasDefensive = 4; // More defensive version of cBiasBackward.
extern const int cBiasNotDefensive = 5; // All except the most defensive quarter.
extern const int cBiasNotAggressive = 6; // All except the most aggressive quarter.

const string cSimLocName = "rmx similar loc";
const string cSimLocAreaName = "rmx similar loc area";

/************
* LOCATIONS *
************/

// Counter for similar location names so we don't end up with duplicates.
int simLocNameCounter = 0;

// Counter for fair location area names so we don't end up with duplicates.
int simLocAreaNameCounter = 0;

// Last added.
int lastAddedSimLocID = -1;

// Similar loc count.
int simLocCount = 0;

/*
** Returns the number of added similar locations. This does not indicate whether creation of those similar locations was successful!
**
** @returns: the current number of similar locations
*/
int getNumSimLocs() {
	return(simLocCount);
}

// Sim loc iteration counter.
int lastSimLocIters = -1;

/*
** Returns the number of iterations for the last placed similar location.
** Also gets reset by resetSimLocs().
**
** @returns: the number of iterations of the algorithm for the last created/attempted similar locs.
*/
int getLastSimLocIters() {
	return(lastSimLocIters);
}

// The arrays in here start from 1 due to always being associated to players.

// Similar locations X values.
float simLoc1X1 = -1.0;  float simLoc1X2  = -1.0; float simLoc1X3  = -1.0; float simLoc1X4  = -1.0;
float simLoc1X5 = -1.0;  float simLoc1X6  = -1.0; float simLoc1X7  = -1.0; float simLoc1X8  = -1.0;
float simLoc1X9 = -1.0;  float simLoc1X10 = -1.0; float simLoc1X11 = -1.0; float simLoc1X12 = -1.0;

float getSimLoc1X(int id = 0) {
	if(id == 1) return(simLoc1X1); if(id == 2)  return(simLoc1X2);  if(id == 3)  return(simLoc1X3);  if(id == 4)  return(simLoc1X4);
	if(id == 5) return(simLoc1X5); if(id == 6)  return(simLoc1X6);  if(id == 7)  return(simLoc1X7);  if(id == 8)  return(simLoc1X8);
	if(id == 9) return(simLoc1X9); if(id == 10) return(simLoc1X10); if(id == 11) return(simLoc1X11); if(id == 12) return(simLoc1X12);
	return(-1.0);
}

void setSimLoc1X(int id = 0, float val = -1.0) {
	if(id == 1) simLoc1X1 = val; if(id == 2)  simLoc1X2  = val; if(id == 3)  simLoc1X3  = val; if(id == 4)  simLoc1X4  = val;
	if(id == 5) simLoc1X5 = val; if(id == 6)  simLoc1X6  = val; if(id == 7)  simLoc1X7  = val; if(id == 8)  simLoc1X8  = val;
	if(id == 9) simLoc1X9 = val; if(id == 10) simLoc1X10 = val; if(id == 11) simLoc1X11 = val; if(id == 12) simLoc1X12 = val;
}

float simLoc2X1 = -1.0;  float simLoc2X2  = -1.0; float simLoc2X3  = -1.0; float simLoc2X4  = -1.0;
float simLoc2X5 = -1.0;  float simLoc2X6  = -1.0; float simLoc2X7  = -1.0; float simLoc2X8  = -1.0;
float simLoc2X9 = -1.0;  float simLoc2X10 = -1.0; float simLoc2X11 = -1.0; float simLoc2X12 = -1.0;

float getSimLoc2X(int id = 0) {
	if(id == 1) return(simLoc2X1); if(id == 2)  return(simLoc2X2);  if(id == 3)  return(simLoc2X3);  if(id == 4)  return(simLoc2X4);
	if(id == 5) return(simLoc2X5); if(id == 6)  return(simLoc2X6);  if(id == 7)  return(simLoc2X7);  if(id == 8)  return(simLoc2X8);
	if(id == 9) return(simLoc2X9); if(id == 10) return(simLoc2X10); if(id == 11) return(simLoc2X11); if(id == 12) return(simLoc2X12);
	return(-1.0);
}

void setSimLoc2X(int id = 0, float val = -1.0) {
	if(id == 1) simLoc2X1 = val; if(id == 2)  simLoc2X2  = val; if(id == 3)  simLoc2X3  = val; if(id == 4)  simLoc2X4  = val;
	if(id == 5) simLoc2X5 = val; if(id == 6)  simLoc2X6  = val; if(id == 7)  simLoc2X7  = val; if(id == 8)  simLoc2X8  = val;
	if(id == 9) simLoc2X9 = val; if(id == 10) simLoc2X10 = val; if(id == 11) simLoc2X11 = val; if(id == 12) simLoc2X12 = val;
}

float simLoc3X1 = -1.0;  float simLoc3X2  = -1.0; float simLoc3X3  = -1.0; float simLoc3X4  = -1.0;
float simLoc3X5 = -1.0;  float simLoc3X6  = -1.0; float simLoc3X7  = -1.0; float simLoc3X8  = -1.0;
float simLoc3X9 = -1.0;  float simLoc3X10 = -1.0; float simLoc3X11 = -1.0; float simLoc3X12 = -1.0;

float getSimLoc3X(int id = 0) {
	if(id == 1) return(simLoc3X1); if(id == 2)  return(simLoc3X2);  if(id == 3)  return(simLoc3X3);  if(id == 4)  return(simLoc3X4);
	if(id == 5) return(simLoc3X5); if(id == 6)  return(simLoc3X6);  if(id == 7)  return(simLoc3X7);  if(id == 8)  return(simLoc3X8);
	if(id == 9) return(simLoc3X9); if(id == 10) return(simLoc3X10); if(id == 11) return(simLoc3X11); if(id == 12) return(simLoc3X12);
	return(-1.0);
}

void setSimLoc3X(int id = 0, float val = -1.0) {
	if(id == 1) simLoc3X1 = val; if(id == 2)  simLoc3X2  = val; if(id == 3)  simLoc3X3  = val; if(id == 4)  simLoc3X4  = val;
	if(id == 5) simLoc3X5 = val; if(id == 6)  simLoc3X6  = val; if(id == 7)  simLoc3X7  = val; if(id == 8)  simLoc3X8  = val;
	if(id == 9) simLoc3X9 = val; if(id == 10) simLoc3X10 = val; if(id == 11) simLoc3X11 = val; if(id == 12) simLoc3X12 = val;
}

float simLoc4X1 = -1.0;  float simLoc4X2  = -1.0; float simLoc4X3  = -1.0; float simLoc4X4  = -1.0;
float simLoc4X5 = -1.0;  float simLoc4X6  = -1.0; float simLoc4X7  = -1.0; float simLoc4X8  = -1.0;
float simLoc4X9 = -1.0;  float simLoc4X10 = -1.0; float simLoc4X11 = -1.0; float simLoc4X12 = -1.0;

float getSimLoc4X(int id = 0) {
	if(id == 1) return(simLoc4X1); if(id == 2)  return(simLoc4X2);  if(id == 3)  return(simLoc4X3);  if(id == 4)  return(simLoc4X4);
	if(id == 5) return(simLoc4X5); if(id == 6)  return(simLoc4X6);  if(id == 7)  return(simLoc4X7);  if(id == 8)  return(simLoc4X8);
	if(id == 9) return(simLoc4X9); if(id == 10) return(simLoc4X10); if(id == 11) return(simLoc4X11); if(id == 12) return(simLoc4X12);
	return(-1.0);
}

void setSimLoc4X(int id = 0, float val = -1.0) {
	if(id == 1) simLoc4X1 = val; if(id == 2)  simLoc4X2  = val; if(id == 3)  simLoc4X3  = val; if(id == 4)  simLoc4X4  = val;
	if(id == 5) simLoc4X5 = val; if(id == 6)  simLoc4X6  = val; if(id == 7)  simLoc4X7  = val; if(id == 8)  simLoc4X8  = val;
	if(id == 9) simLoc4X9 = val; if(id == 10) simLoc4X10 = val; if(id == 11) simLoc4X11 = val; if(id == 12) simLoc4X12 = val;
}

/*
** Gets the x coordinate of a similar location.
**
** @param simLocID: the ID of the similar location
** @param id: the index of the coordinate in the array
**
** @returns: the x coordinate of the similar location
*/
float getSimLocX(int simLocID = 0, int id = 0) {
	if(simLocID == 1) return(getSimLoc1X(id)); if(simLocID == 2) return(getSimLoc2X(id));
	if(simLocID == 3) return(getSimLoc3X(id)); if(simLocID == 4) return(getSimLoc4X(id));
	return(-1.0);
}

/*
** Sets the x coordinate of a similar location.
**
** @param simLocID: the ID of the similar location
** @param id: the index of the coordinate in the array
** @param val: the value to set
*/
void setSimLocX(int simLocID = 0, int id = 0, float val = -1.0) {
	if(simLocID == 1) setSimLoc1X(id, val); if(simLocID == 2) setSimLoc2X(id, val);
	if(simLocID == 3) setSimLoc3X(id, val); if(simLocID == 4) setSimLoc4X(id, val);
}

// Similar locations Z values.
float simLoc1Z1 = -1.0; float simLoc1Z2  = -1.0; float simLoc1Z3  = -1.0; float simLoc1Z4  = -1.0;
float simLoc1Z5 = -1.0; float simLoc1Z6  = -1.0; float simLoc1Z7  = -1.0; float simLoc1Z8  = -1.0;
float simLoc1Z9 = -1.0; float simLoc1Z10 = -1.0; float simLoc1Z11 = -1.0; float simLoc1Z12 = -1.0;

float getSimLoc1Z(int id = 0) {
	if(id == 1) return(simLoc1Z1); if(id == 2)  return(simLoc1Z2);  if(id == 3)  return(simLoc1Z3);  if(id == 4)  return(simLoc1Z4);
	if(id == 5) return(simLoc1Z5); if(id == 6)  return(simLoc1Z6);  if(id == 7)  return(simLoc1Z7);  if(id == 8)  return(simLoc1Z8);
	if(id == 9) return(simLoc1Z9); if(id == 10) return(simLoc1Z10); if(id == 11) return(simLoc1Z11); if(id == 12) return(simLoc1Z12);
	return(-1.0);
}

void setSimLoc1Z(int id = 0, float val = -1.0) {
	if(id == 1) simLoc1Z1 = val; if(id == 2)  simLoc1Z2  = val; if(id == 3)  simLoc1Z3  = val; if(id == 4)  simLoc1Z4  = val;
	if(id == 5) simLoc1Z5 = val; if(id == 6)  simLoc1Z6  = val; if(id == 7)  simLoc1Z7  = val; if(id == 8)  simLoc1Z8  = val;
	if(id == 9) simLoc1Z9 = val; if(id == 10) simLoc1Z10 = val; if(id == 11) simLoc1Z11 = val; if(id == 12) simLoc1Z12 = val;
}

float simLoc2Z1 = -1.0; float simLoc2Z2  = -1.0; float simLoc2Z3  = -1.0; float simLoc2Z4  = -1.0;
float simLoc2Z5 = -1.0; float simLoc2Z6  = -1.0; float simLoc2Z7  = -1.0; float simLoc2Z8  = -1.0;
float simLoc2Z9 = -1.0; float simLoc2Z10 = -1.0; float simLoc2Z11 = -1.0; float simLoc2Z12 = -1.0;

float getSimLoc2Z(int id = 0) {
	if(id == 1) return(simLoc2Z1); if(id == 2)  return(simLoc2Z2);  if(id == 3)  return(simLoc2Z3);  if(id == 4)  return(simLoc2Z4);
	if(id == 5) return(simLoc2Z5); if(id == 6)  return(simLoc2Z6);  if(id == 7)  return(simLoc2Z7);  if(id == 8)  return(simLoc2Z8);
	if(id == 9) return(simLoc2Z9); if(id == 10) return(simLoc2Z10); if(id == 11) return(simLoc2Z11); if(id == 12) return(simLoc2Z12);
	return(-1.0);
}

void setSimLoc2Z(int id = 0, float val = -1.0) {
	if(id == 1) simLoc2Z1 = val; if(id == 2)  simLoc2Z2  = val; if(id == 3)  simLoc2Z3  = val; if(id == 4)  simLoc2Z4  = val;
	if(id == 5) simLoc2Z5 = val; if(id == 6)  simLoc2Z6  = val; if(id == 7)  simLoc2Z7  = val; if(id == 8)  simLoc2Z8  = val;
	if(id == 9) simLoc2Z9 = val; if(id == 10) simLoc2Z10 = val; if(id == 11) simLoc2Z11 = val; if(id == 12) simLoc2Z12 = val;
}

float simLoc3Z1 = -1.0; float simLoc3Z2  = -1.0; float simLoc3Z3  = -1.0; float simLoc3Z4  = -1.0;
float simLoc3Z5 = -1.0; float simLoc3Z6  = -1.0; float simLoc3Z7  = -1.0; float simLoc3Z8  = -1.0;
float simLoc3Z9 = -1.0; float simLoc3Z10 = -1.0; float simLoc3Z11 = -1.0; float simLoc3Z12 = -1.0;

float getSimLoc3Z(int id = 0) {
	if(id == 1) return(simLoc3Z1); if(id == 2)  return(simLoc3Z2);  if(id == 3)  return(simLoc3Z3);  if(id == 4)  return(simLoc3Z4);
	if(id == 5) return(simLoc3Z5); if(id == 6)  return(simLoc3Z6);  if(id == 7)  return(simLoc3Z7);  if(id == 8)  return(simLoc3Z8);
	if(id == 9) return(simLoc3Z9); if(id == 10) return(simLoc3Z10); if(id == 11) return(simLoc3Z11); if(id == 12) return(simLoc3Z12);
	return(-1.0);
}

void setSimLoc3Z(int id = 0, float val = -1.0) {
	if(id == 1) simLoc3Z1 = val; if(id == 2)  simLoc3Z2  = val; if(id == 3)  simLoc3Z3  = val; if(id == 4)  simLoc3Z4  = val;
	if(id == 5) simLoc3Z5 = val; if(id == 6)  simLoc3Z6  = val; if(id == 7)  simLoc3Z7  = val; if(id == 8)  simLoc3Z8  = val;
	if(id == 9) simLoc3Z9 = val; if(id == 10) simLoc3Z10 = val; if(id == 11) simLoc3Z11 = val; if(id == 12) simLoc3Z12 = val;
}

float simLoc4Z1 = -1.0; float simLoc4Z2  = -1.0; float simLoc4Z3  = -1.0; float simLoc4Z4  = -1.0;
float simLoc4Z5 = -1.0; float simLoc4Z6  = -1.0; float simLoc4Z7  = -1.0; float simLoc4Z8  = -1.0;
float simLoc4Z9 = -1.0; float simLoc4Z10 = -1.0; float simLoc4Z11 = -1.0; float simLoc4Z12 = -1.0;

float getSimLoc4Z(int id = 0) {
	if(id == 1) return(simLoc4Z1); if(id == 2)  return(simLoc4Z2);  if(id == 3)  return(simLoc4Z3);  if(id == 4)  return(simLoc4Z4);
	if(id == 5) return(simLoc4Z5); if(id == 6)  return(simLoc4Z6);  if(id == 7)  return(simLoc4Z7);  if(id == 8)  return(simLoc4Z8);
	if(id == 9) return(simLoc4Z9); if(id == 10) return(simLoc4Z10); if(id == 11) return(simLoc4Z11); if(id == 12) return(simLoc4Z12);
	return(-1.0);
}

void setSimLoc4Z(int id = 0, float val = -1.0) {
	if(id == 1) simLoc4Z1 = val; if(id == 2)  simLoc4Z2  = val; if(id == 3)  simLoc4Z3  = val; if(id == 4)  simLoc4Z4  = val;
	if(id == 5) simLoc4Z5 = val; if(id == 6)  simLoc4Z6  = val; if(id == 7)  simLoc4Z7  = val; if(id == 8)  simLoc4Z8  = val;
	if(id == 9) simLoc4Z9 = val; if(id == 10) simLoc4Z10 = val; if(id == 11) simLoc4Z11 = val; if(id == 12) simLoc4Z12 = val;
}

/*
** Gets the z coordinate of a similar location.
**
** @param simLocID: the ID of the similar location
** @param id: the index of the coordinate in the array
**
** @returns: the z coordinate of the similar location
*/
float getSimLocZ(int simLocID = 0, int id = 0) {
	if(simLocID == 1) return(getSimLoc1Z(id)); if(simLocID == 2) return(getSimLoc2Z(id));
	if(simLocID == 3) return(getSimLoc3Z(id)); if(simLocID == 4) return(getSimLoc4Z(id));
	return(-1.0);
}

/*
** Sets the z coordinate of a similar location.
**
** @param simLocID: the ID of the similar location
** @param id: the index of the coordinate in the array
** @param val: the value to set
*/
void setSimLocZ(int simLocID = 0, int id = 0, float val = -1.0) {
	if(simLocID == 1) setSimLoc1Z(id, val); if(simLocID == 2) setSimLoc2Z(id, val);
	if(simLocID == 3) setSimLoc3Z(id, val); if(simLocID == 4) setSimLoc4Z(id, val);
}

/*
** Sets both coordinates for a similar location.
**
** @param simLocID: the ID of the similar location
** @param id: the index of the coordinate in the array
** @param x: the x value to set
** @param z: the z value to set
*/
void setSimLocXZ(int simLocID = 0, int id = 0, float x = -1.0, float z = -1.0) {
	setSimLocX(simLocID, id, x);
	setSimLocZ(simLocID, id, z);
}

/**************
* CONSTRAINTS *
**************/

// Similar location constraints.
int simLocConstraintCount1 = 0; int simLocConstraintCount2 = 0; int simLocConstraintCount3 = 0; int simLocConstraintCount4 = 0;

int simLoc1Constraint1 = -1; int simLoc1Constraint2  = -1; int simLoc1Constraint3  = -1; int simLoc1Constraint4  = -1;
int simLoc1Constraint5 = -1; int simLoc1Constraint6  = -1; int simLoc1Constraint7  = -1; int simLoc1Constraint8  = -1;
int simLoc1Constraint9 = -1; int simLoc1Constraint10 = -1; int simLoc1Constraint11 = -1; int simLoc1Constraint12 = -1;

int getSimLoc1Constraint(int id = 0) {
	if(id == 1) return(simLoc1Constraint1); if(id == 2)  return(simLoc1Constraint2);  if(id == 3)  return(simLoc1Constraint3);  if(id == 4)  return(simLoc1Constraint4);
	if(id == 5) return(simLoc1Constraint5); if(id == 6)  return(simLoc1Constraint6);  if(id == 7)  return(simLoc1Constraint7);  if(id == 8)  return(simLoc1Constraint8);
	if(id == 9) return(simLoc1Constraint9); if(id == 10) return(simLoc1Constraint10); if(id == 11) return(simLoc1Constraint11); if(id == 12) return(simLoc1Constraint12);
	return(-1);
}

void setSimLoc1Constraint(int id = 0, int cID = -1) {
	if(id == 1) simLoc1Constraint1 = cID; if(id == 2)  simLoc1Constraint2  = cID; if(id == 3)  simLoc1Constraint3  = cID; if(id == 4)  simLoc1Constraint4  = cID;
	if(id == 5) simLoc1Constraint5 = cID; if(id == 6)  simLoc1Constraint6  = cID; if(id == 7)  simLoc1Constraint7  = cID; if(id == 8)  simLoc1Constraint8  = cID;
	if(id == 9) simLoc1Constraint9 = cID; if(id == 10) simLoc1Constraint10 = cID; if(id == 11) simLoc1Constraint11 = cID; if(id == 12) simLoc1Constraint12 = cID;
}

int simLoc2Constraint1 = -1; int simLoc2Constraint2  = -1; int simLoc2Constraint3  = -1; int simLoc2Constraint4  = -1;
int simLoc2Constraint5 = -1; int simLoc2Constraint6  = -1; int simLoc2Constraint7  = -1; int simLoc2Constraint8  = -1;
int simLoc2Constraint9 = -1; int simLoc2Constraint10 = -1; int simLoc2Constraint11 = -1; int simLoc2Constraint12 = -1;

int getSimLoc2Constraint(int id = 0) {
	if(id == 1) return(simLoc2Constraint1); if(id == 2)  return(simLoc2Constraint2);  if(id == 3)  return(simLoc2Constraint3);  if(id == 4)  return(simLoc2Constraint4);
	if(id == 5) return(simLoc2Constraint5); if(id == 6)  return(simLoc2Constraint6);  if(id == 7)  return(simLoc2Constraint7);  if(id == 8)  return(simLoc2Constraint8);
	if(id == 9) return(simLoc2Constraint9); if(id == 10) return(simLoc2Constraint10); if(id == 11) return(simLoc2Constraint11); if(id == 12) return(simLoc2Constraint12);
	return(-1);
}

void setSimLoc2Constraint(int id = 0, int cID = -1) {
	if(id == 1) simLoc2Constraint1 = cID; if(id == 2)  simLoc2Constraint2  = cID; if(id == 3)  simLoc2Constraint3  = cID; if(id == 4)  simLoc2Constraint4  = cID;
	if(id == 5) simLoc2Constraint5 = cID; if(id == 6)  simLoc2Constraint6  = cID; if(id == 7)  simLoc2Constraint7  = cID; if(id == 8)  simLoc2Constraint8  = cID;
	if(id == 9) simLoc2Constraint9 = cID; if(id == 10) simLoc2Constraint10 = cID; if(id == 11) simLoc2Constraint11 = cID; if(id == 12) simLoc2Constraint12 = cID;
}

int simLoc3Constraint1 = -1; int simLoc3Constraint2  = -1; int simLoc3Constraint3  = -1; int simLoc3Constraint4  = -1;
int simLoc3Constraint5 = -1; int simLoc3Constraint6  = -1; int simLoc3Constraint7  = -1; int simLoc3Constraint8  = -1;
int simLoc3Constraint9 = -1; int simLoc3Constraint10 = -1; int simLoc3Constraint11 = -1; int simLoc3Constraint12 = -1;

int getSimLoc3Constraint(int id = 0) {
	if(id == 1) return(simLoc3Constraint1); if(id == 2)  return(simLoc3Constraint2);  if(id == 3)  return(simLoc3Constraint3);  if(id == 4)  return(simLoc3Constraint4);
	if(id == 5) return(simLoc3Constraint5); if(id == 6)  return(simLoc3Constraint6);  if(id == 7)  return(simLoc3Constraint7);  if(id == 8)  return(simLoc3Constraint8);
	if(id == 9) return(simLoc3Constraint9); if(id == 10) return(simLoc3Constraint10); if(id == 11) return(simLoc3Constraint11); if(id == 12) return(simLoc3Constraint12);
	return(-1);
}

void setSimLoc3Constraint(int id = 0, int cID = -1) {
	if(id == 1) simLoc3Constraint1 = cID; if(id == 2)  simLoc3Constraint2  = cID; if(id == 3)  simLoc3Constraint3  = cID; if(id == 4)  simLoc3Constraint4  = cID;
	if(id == 5) simLoc3Constraint5 = cID; if(id == 6)  simLoc3Constraint6  = cID; if(id == 7)  simLoc3Constraint7  = cID; if(id == 8)  simLoc3Constraint8  = cID;
	if(id == 9) simLoc3Constraint9 = cID; if(id == 10) simLoc3Constraint10 = cID; if(id == 11) simLoc3Constraint11 = cID; if(id == 12) simLoc3Constraint12 = cID;
}

int simLoc4Constraint1 = -1; int simLoc4Constraint2  = -1; int simLoc4Constraint3  = -1; int simLoc4Constraint4  = -1;
int simLoc4Constraint5 = -1; int simLoc4Constraint6  = -1; int simLoc4Constraint7  = -1; int simLoc4Constraint8  = -1;
int simLoc4Constraint9 = -1; int simLoc4Constraint10 = -1; int simLoc4Constraint11 = -1; int simLoc4Constraint12 = -1;

int getSimLoc4Constraint(int id = 0) {
	if(id == 1) return(simLoc4Constraint1); if(id == 2)  return(simLoc4Constraint2);  if(id == 3)  return(simLoc4Constraint3);  if(id == 4)  return(simLoc4Constraint4);
	if(id == 5) return(simLoc4Constraint5); if(id == 6)  return(simLoc4Constraint6);  if(id == 7)  return(simLoc4Constraint7);  if(id == 8)  return(simLoc4Constraint8);
	if(id == 9) return(simLoc4Constraint9); if(id == 10) return(simLoc4Constraint10); if(id == 11) return(simLoc4Constraint11); if(id == 12) return(simLoc4Constraint12);
	return(-1);
}

void setSimLoc4Constraint(int id = 0, int cID = -1) {
	if(id == 1) simLoc4Constraint1 = cID; if(id == 2)  simLoc4Constraint2  = cID; if(id == 3)  simLoc4Constraint3  = cID; if(id == 4)  simLoc4Constraint4  = cID;
	if(id == 5) simLoc4Constraint5 = cID; if(id == 6)  simLoc4Constraint6  = cID; if(id == 7)  simLoc4Constraint7  = cID; if(id == 8)  simLoc4Constraint8  = cID;
	if(id == 9) simLoc4Constraint9 = cID; if(id == 10) simLoc4Constraint10 = cID; if(id == 11) simLoc4Constraint11 = cID; if(id == 12) simLoc4Constraint12 = cID;
}

/*
** Obtains a stored constraint for a given similar location.
**
** @param simLocID: the ID of the similar location
** @param id: the index of the constraint in the constraint array
**
** @returns: the ID of the constraint
*/
int getSimLocConstraint(int simLocID = 0, int id = 0) {
	if(simLocID == 1) return(getSimLoc1Constraint(id)); if(simLocID == 2) return(getSimLoc2Constraint(id));
	if(simLocID == 3) return(getSimLoc3Constraint(id)); if(simLocID == 4) return(getSimLoc4Constraint(id));
	return(-1);
}

/*
** Adds an area constraint to a certain similar location.
**
** The signature of this function may seem a little inconsistent, but it's a lot more convenient.
** Since usually the current similar location is used, the second argument can often be omitted.
** The exception (and reason why the second argument exists) are cases where you may want to have
** similar locations added in a different order depending on the number of players.
** Remember that the similar locations with the lower IDs are placed first.
**
** @param cID: the ID of the constraint
** @param simLocID: the ID of the similar location the constraint should belong to
*/
void addSimLocConstraint(int cID = -1, int simLocID = -1) {
	if(simLocID < 0) {
		simLocID = simLocCount + 1;
	}

	if(simLocID == 1) {
		simLocConstraintCount1++;
		setSimLoc1Constraint(simLocConstraintCount1, cID);
	} else if(simLocID == 2) {
		simLocConstraintCount2++;
		setSimLoc2Constraint(simLocConstraintCount2, cID);
	} else if(simLocID == 3) {
		simLocConstraintCount3++;
		setSimLoc3Constraint(simLocConstraintCount3, cID);
	} else if(simLocID == 4) {
		simLocConstraintCount4++;
		setSimLoc4Constraint(simLocConstraintCount4, cID);
	}
}

/*
** Returns the number of constraints for a certain similar location.
**
** @param simLocID: the ID of the similar location
**
** @returns: the number of constraints that have been added
*/
int getSimLocConstraintCount(int simLocID = 0) {
	if(simLocID == 1) return(simLocConstraintCount1); if(simLocID == 2) return(simLocConstraintCount2);
	if(simLocID == 3) return(simLocConstraintCount3); if(simLocID == 4) return(simLocConstraintCount4);
	return(-1);
}

/*************
* PARAMETERS *
*************/

// Min dist.
float simLoc1MinDist = 0.0; float simLoc2MinDist = 0.0; float simLoc3MinDist = 0.0; float simLoc4MinDist = 0.0;

float getSimLocMinDist(int id = 0) {
	if(id == 1) return(simLoc1MinDist); if(id == 2) return(simLoc2MinDist); if(id == 3) return(simLoc3MinDist); if(id == 4) return(simLoc4MinDist);
	return(0.0);
}

void setSimLocMinDist(int id = 0, float val = 0.0) {
	if(id == 1) simLoc1MinDist = val; if(id == 2) simLoc2MinDist = val; if(id == 3) simLoc3MinDist = val; if(id == 4) simLoc4MinDist = val;
}

// Max dist.
float simLoc1MaxDist = 0.0; float simLoc2MaxDist = 0.0; float simLoc3MaxDist = 0.0; float simLoc4MaxDist = 0.0;

float getSimLocMaxDist(int id = 0) {
	if(id == 1) return(simLoc1MaxDist); if(id == 2) return(simLoc2MaxDist); if(id == 3) return(simLoc3MaxDist); if(id == 4) return(simLoc4MaxDist);
	return(0.0);
}

void setSimLocMaxDist(int id = 0, float val = 0.0) {
	if(id == 1) simLoc1MaxDist = val; if(id == 2) simLoc2MaxDist = val; if(id == 3) simLoc3MaxDist = val; if(id == 4) simLoc4MaxDist = val;
}

// Area dist.
float simLoc1AreaDist = 0.0; float simLoc2AreaDist = 0.0; float simLoc3AreaDist = 0.0; float simLoc4AreaDist = 0.0;

float getSimLocAreaDist(int id = 0) {
	if(id == 1) return(simLoc1AreaDist); if(id == 2) return(simLoc2AreaDist); if(id == 3) return(simLoc3AreaDist); if(id == 4) return(simLoc4AreaDist);
	return(0.0);
}

void setSimLocAreaDist(int id = 0, float val = 0.0) {
	if(id == 1) simLoc1AreaDist = val; if(id == 2) simLoc2AreaDist = val; if(id == 3) simLoc3AreaDist = val; if(id == 4) simLoc4AreaDist = val;
}

// Edge dist x.
float simLoc1DistX = 0.0; float simLoc2DistX = 0.0; float simLoc3DistX = 0.0; float simLoc4DistX = 0.0;

float getSimLocDistX(int id = 0) {
	if(id == 1) return(simLoc1DistX); if(id == 2) return(simLoc2DistX); if(id == 3) return(simLoc3DistX); if(id == 4) return(simLoc4DistX);
	return(0.0);
}

void setSimLocDistX(int id = 0, float val = 0.0) {
	if(id == 1) simLoc1DistX = val; if(id == 2) simLoc2DistX = val; if(id == 3) simLoc3DistX = val; if(id == 4) simLoc4DistX = val;
}

// Edge dist z.
float simLoc1DistZ = 0.0; float simLoc2DistZ = 0.0; float simLoc3DistZ = 0.0; float simLoc4DistZ = 0.0;

float getSimLocDistZ(int id = 0) {
	if(id == 1) return(simLoc1DistZ); if(id == 2) return(simLoc2DistZ); if(id == 3) return(simLoc3DistZ); if(id == 4) return(simLoc4DistZ);
	return(0.0);
}

void setSimLocDistZ(int id = 0, float val = 0.0) {
	if(id == 1) simLoc1DistZ = val; if(id == 2) simLoc2DistZ = val; if(id == 3) simLoc3DistZ = val; if(id == 4) simLoc4DistZ = val;
}

// Inside out.
bool simLoc1InsideOut = true; bool simLoc2InsideOut = true; bool simLoc3InsideOut = true; bool simLoc4InsideOut = true;

bool getSimLocInsideOut(int id = 0) {
	if(id == 1) return(simLoc1InsideOut); if(id == 2) return(simLoc2InsideOut); if(id == 3) return(simLoc3InsideOut); if(id == 4) return(simLoc4InsideOut);
	return(true);
}

void setSimLocInsideOut(int id = 0, bool val = true) {
	if(id == 1) simLoc1InsideOut = val; if(id == 2) simLoc2InsideOut = val; if(id == 3) simLoc3InsideOut = val; if(id == 4) simLoc4InsideOut = val;
}

// In player area.
bool simLoc1InPlayerArea = false; bool simLoc2InPlayerArea = false; bool simLoc3InPlayerArea = false; bool simLoc4InPlayerArea = false;

bool getSimLocInPlayerArea(int id = 0) {
	if(id == 1) return(simLoc1InPlayerArea); if(id == 2) return(simLoc2InPlayerArea); if(id == 3) return(simLoc3InPlayerArea); if(id == 4) return(simLoc4InPlayerArea);
	return(false);
}

void setSimLocInPlayerArea(int id = 0, bool val = false) {
	if(id == 1) simLoc1InPlayerArea = val; if(id == 2) simLoc2InPlayerArea = val; if(id == 3) simLoc3InPlayerArea = val; if(id == 4) simLoc4InPlayerArea = val;
}

// In team area.
bool simLoc1InTeamArea = false; bool simLoc2InTeamArea = false; bool simLoc3InTeamArea = false; bool simLoc4InTeamArea = false;

bool getSimLocInTeamArea(int id = 0) {
	if(id == 1) return(simLoc1InTeamArea); if(id == 2) return(simLoc2InTeamArea);	if(id == 3) return(simLoc3InTeamArea); if(id == 4) return(simLoc4InTeamArea);
	return(false);
}

void setSimLocInTeamArea(int id = 0, bool val = false) {
	if(id == 1) simLoc1InTeamArea = val; if(id == 2) simLoc2InTeamArea = val; if(id == 3) simLoc3InTeamArea = val; if(id == 4) simLoc4InTeamArea = val;
}

// Whether to use square placement or not.
bool simLoc1IsSquare = false; bool simLoc2IsSquare = false; bool simLoc3IsSquare = false; bool simLoc4IsSquare = false;

bool getSimLocIsSquare(int id = 0) {
	if(id == 1) return(simLoc1IsSquare); if(id == 2) return(simLoc2IsSquare);	if(id == 3) return(simLoc3IsSquare); if(id == 4) return(simLoc4IsSquare);
	return(false);
}

void setSimLocIsSquare(int id = 0, bool val = false) {
	if(id == 1) simLoc1IsSquare = val; if(id == 2) simLoc2IsSquare = val; if(id == 3) simLoc3IsSquare = val; if(id == 4) simLoc4IsSquare = val;
}

// Angle bias, starting range.
float simLoc1BiasRangeFrom = 0.0; float simLoc2BiasRangeFrom = 0.0; float simLoc3BiasRangeFrom = 0.0; float simLoc4BiasRangeFrom = 0.0;

float getSimLocBiasRangeFrom(int id = 0) {
	if(id == 1) return(simLoc1BiasRangeFrom); if(id == 2) return(simLoc2BiasRangeFrom); if(id == 3) return(simLoc3BiasRangeFrom); if(id == 4) return(simLoc4BiasRangeFrom);
	return(0.0);
}

void setSimLocBiasRangeFrom(int id = 0, float val = 0.0) {
	if(id == 1) simLoc1BiasRangeFrom = val; if(id == 2) simLoc2BiasRangeFrom = val; if(id == 3) simLoc3BiasRangeFrom = val; if(id == 4) simLoc4BiasRangeFrom = val;
}

// Angle bias, ending range.
float simLoc1BiasRangeTo = 1.0; float simLoc2BiasRangeTo = 1.0; float simLoc3BiasRangeTo = 1.0; float simLoc4BiasRangeTo = 1.0;

float getSimLocBiasRangeTo(int id = 0) {
	if(id == 1) return(simLoc1BiasRangeTo); if(id == 2) return(simLoc2BiasRangeTo); if(id == 3) return(simLoc3BiasRangeTo); if(id == 4) return(simLoc4BiasRangeTo);
	return(1.0);
}

void setSimLocBiasRangeTo(int id = 0, float val = 1.0) {
	if(id == 1) simLoc1BiasRangeTo = val; if(id == 2) simLoc2BiasRangeTo = val; if(id == 3) simLoc3BiasRangeTo = val; if(id == 4) simLoc4BiasRangeTo = val;
}

/*
** Sets an angle bias for a similar location.
** This bias restricts the range of angles that a location can be in with respect to the player.
** The maximum range is [0, PI] which is the entire left half when looking from a player's spawn towards the center of the map.
** Since this range is always "mirrored" such that the angle may be randomized from either side, [0, PI] essentially spans the entire angle range.
** For instance, [0.5, 1.0] * PI means that we can only randomize forward angles (effectively from 0.5 * PI to 1.5 * PI with the mirroring of [0.5, 1.0] * PI to [1.0, 1.5] * PI).
**
** @param biasConst: one of the bias constants
** @param simLocID: the ID of the similar location to apply the bias to
*/
void setSimLocBias(int biasConst = cBiasNone, int simLocID = -1) {
	if(simLocID < 0) { // Use current simLoc if defaulted.
		simLocID = simLocCount + 1;
	}

	// The bias values only have to be set for one side, as the algorithm will automatically randomize from the other side (symmetrically) as well.
	if(biasConst == cBiasNone) {
		setSimLocBiasRangeFrom(simLocID, NINF);
		setSimLocBiasRangeTo(simLocID, NINF);
	} else if(biasConst == cBiasForward) { // [0.5, 1.0] * PI.
		setSimLocBiasRangeFrom(simLocID, 0.5);
		setSimLocBiasRangeTo(simLocID, 1.0);
	} else if(biasConst == cBiasBackward) { // [0.0, 0.5] * PI.
		setSimLocBiasRangeFrom(simLocID, 0.0);
		setSimLocBiasRangeTo(simLocID, 0.5);
	} else if(biasConst == cBiasSide) { // [0.25, 0.75] * PI.
		setSimLocBiasRangeFrom(simLocID, 0.25);
		setSimLocBiasRangeTo(simLocID, 0.75);
	} else if(biasConst == cBiasAggressive) { // [0.75, 1.0] * PI.
		setSimLocBiasRangeFrom(simLocID, 0.75);
		setSimLocBiasRangeTo(simLocID, 1.0);
	} else if(biasConst == cBiasDefensive) { // [0.0, 0.25] * PI.
		setSimLocBiasRangeFrom(simLocID, 0.0);
		setSimLocBiasRangeTo(simLocID, 0.25);
	} else if(biasConst == cBiasNotDefensive) { // [0.25, 1.0] * PI.
		setSimLocBiasRangeFrom(simLocID, 0.25);
		setSimLocBiasRangeTo(simLocID, 1.0);
	} else if(biasConst == cBiasNotAggressive) { // [0.0, 0.75] * PI.
		setSimLocBiasRangeFrom(simLocID, 0.0);
		setSimLocBiasRangeTo(simLocID, 0.75);
	}
}

/*
** Sets a custom bias for the range.
**
** Only use this if you understand the concept or you may break stuff!
**
** DON'T MULTIPLY THE RANGES WITH PI YET, THE RANDOMIZATION FUNCTION WILL DO THAT!
** For instance, if you want to restrict the angles to forward angles only, use setSimLocCustomBias(0.5, 1.0, mySimLocID).
**
** @param rangeFrom: the starting fraction in [0, 2.0] of the section
** @param rangeTo: the ending fraction in [0, 2.0] of the section; has to be greater than rangeFrom (!)
** @param simLocID: the ID of the similar location to set the bias for
*/
void setSimLocCustomBias(float rangeFrom = 0.0, float rangeTo = 1.0, int simLocID = -1) {
	if(simLocID < 0) { // Use current simLoc if defaulted.
		simLocID = simLocCount + 1;
	}

	setSimLocBiasRangeFrom(simLocID, rangeFrom);
	setSimLocBiasRangeTo(simLocID, rangeTo);
}

// Radius interval.
float simLoc1RadiusInterval = 30.0; float simLoc2RadiusInterval = 30.0; float simLoc3RadiusInterval = 30.0; float simLoc4RadiusInterval = 30.0;

float getSimLocRadiusInterval(int id = 0) {
	if(id == 1) return(simLoc1RadiusInterval); if(id == 2) return(simLoc2RadiusInterval); if(id == 3) return(simLoc3RadiusInterval); if(id == 4) return(simLoc4RadiusInterval);
	return(0.0);
}

void setSimLocRadiusInterval(int id = 0, float val = 30.0) {
	if(id == 1) simLoc1RadiusInterval = val; if(id == 2) simLoc2RadiusInterval = val; if(id == 3) simLoc3RadiusInterval = val; if(id == 4) simLoc4RadiusInterval = val;
}

/*
** Sets the interval around the randomized radius, which is then used to randomize individual radii.
** Gets constrained by upper/lower bound if exceeding those.
**
** @param interval: the interval to set (half of this value is subtracted/added to the randomized angle)
** @param simLocID: the ID of the similar location to set the interval for
*/
void setSimLocInterval(float interval = 30.0, int simLocID = -1) {
	if(simLocID < 0) { // Use current simLoc if defaulted.
		simLocID = simLocCount + 1;
	}

	setSimLocRadiusInterval(simLocID, interval);
}

// Default segment size.
float simLoc1AngleSegSize = 0.25; float simLoc2AngleSegSize = 0.25; float simLoc3AngleSegSize = 0.25; float simLoc4AngleSegSize = 0.25;

float getSimLocAngleSegSize(int id = 0) {
	if(id == 1) return(simLoc1AngleSegSize); if(id == 2) return(simLoc2AngleSegSize); if(id == 3) return(simLoc3AngleSegSize); if(id == 4) return(simLoc4AngleSegSize);
	return(0.0);
}

void setSimLocAngleSegSize(int id = 0, float val = 0.25) {
	if(id == 1) simLoc1AngleSegSize = val; if(id == 2) simLoc2AngleSegSize = val; if(id == 3) simLoc3AngleSegSize = val; if(id == 4) simLoc4AngleSegSize = val;
}

/*
** Sets the segment size for a given similar location.
** The segment size is (contrary to "size") the angle that is used to extend the initially randomized angle for all players.
** This range of angles is then used to randomize the individual player angles.
**
** @param segSize: the segment size in [0, 1.0].
** @param simLocID: the ID of the similar location to set the segment size for
*/
void setSimLocSegSize(float segSize = 0.25, int simLocID = -1) {
	if(simLocID < 0) { // Use current simLoc if defaulted.
		simLocID = simLocCount + 1;
	}

	setSimLocAngleSegSize(simLocID, segSize);
}

// Default two player tolerance.
float simLoc1TwoPlayerTol = -1.0; float simLoc2TwoPlayerTol = -1.0; float simLoc3TwoPlayerTol = -1.0; float simLoc4TwoPlayerTol = -1.0;

float getSimLocTwoPlayerTol(int id = 0) {
	if(id == 1) return(simLoc1TwoPlayerTol); if(id == 2) return(simLoc2TwoPlayerTol); if(id == 3) return(simLoc3TwoPlayerTol); if(id == 4) return(simLoc4TwoPlayerTol);
	return(-1.0);
}

void setSimLocTwoPlayerTol(int id = 0, float val = 0.2) {
	if(id == 1) simLoc1TwoPlayerTol = val; if(id == 2) simLoc2TwoPlayerTol = val; if(id == 3) simLoc3TwoPlayerTol = val; if(id == 4) simLoc4TwoPlayerTol = val;
}

/*
** Sets the maximum ratio for the two player check to tolerate.
**
** @param twoPlayerTol: the ratio as a float
** @param simLocID: the ID of the similar location to set the segment size for
*/
void enableSimLocTwoPlayerCheck(float twoPlayerTol = 0.2, int simLocID = -1) {
	if(simLocID < 0) { // Use current simLoc if defaulted.
		simLocID = simLocCount + 1;
	}

	setSimLocTwoPlayerTol(simLocID, twoPlayerTol);
}

// Inter dist.
float simLocInterDistMin = 0.0;
float simLocInterDistMax = INF;

/*
** Gets the minimum distance similar locations of a player have to be separated by.
**
** @returns: the distance in meters
*/
float getSimLocInterDistMin() {
	return(simLocInterDistMin);
}

/*
** Sets a minimum distance that similar locations of a player have to be separated by.
**
** @param val: the distance in meters
*/
void setSimLocInterDistMin(float val = 0.0) {
	simLocInterDistMin = val;
}

/*
** Gets the maximum distance similar locations of a player have to be separated by.
**
** @returns: the distance in meters
*/
float getSimLocInterDistMax() {
	return(simLocInterDistMax);
}

/*
** Sets a maximum distance that similar locations of a player can be separated by.
**
** @param val: the distance in meters
*/
void setSimLocInterDistMax(float val = INF) {
	simLocInterDistMax = val;
}

// Min cross distance.
float simLocMinCrossDist = 0.0;

/*
** Calculates the minimum cross distance that has to be guaranteed.
** This is the minimum distance that the separately specified similar locations (addSimLoc()) have to be apart from each other.
** Example: 2 similar locations were added with 80.0 and 60.0 areaDist, this means that the minimum cross distance is 60.0.
**
** Distance within the specific similar locations is checked separately.
*/
void calcSimLocMinCrossDist() {
	float tempMinCrossDist = INF;

	for(i = 1; <= simLocCount) {
		if(getSimLocAreaDist(i) < tempMinCrossDist) {
			tempMinCrossDist = getSimLocAreaDist(i);
		}
	}

	simLocMinCrossDist = tempMinCrossDist;
}

// Players start from 1 by convention (0 = Mother Nature).
int simLoc1Player1 = -1; int simLoc1Player2  = -1; int simLoc1Player3  = -1; int simLoc1Player4  = -1;
int simLoc1Player5 = -1; int simLoc1Player6  = -1; int simLoc1Player7  = -1; int simLoc1Player8  = -1;
int simLoc1Player9 = -1; int simLoc1Player10 = -1; int simLoc1Player11 = -1; int simLoc1Player12 = -1;

int getSimLoc1Player(int i = 0) {
	if(i == 1) return(simLoc1Player1); if(i == 2)  return(simLoc1Player2);  if(i == 3)  return(simLoc1Player3);  if(i == 4)  return(simLoc1Player4);
	if(i == 5) return(simLoc1Player5); if(i == 6)  return(simLoc1Player6);  if(i == 7)  return(simLoc1Player7);  if(i == 8)  return(simLoc1Player8);
	if(i == 9) return(simLoc1Player9); if(i == 10) return(simLoc1Player10); if(i == 11) return(simLoc1Player11); if(i == 12) return(simLoc1Player12);
	return(-1);
}

void setSimLoc1Player(int i = 0, int id = -1) {
	if(i == 1) simLoc1Player1 = id; if(i == 2)  simLoc1Player2  = id; if(i == 3)  simLoc1Player3  = id; if(i == 4)  simLoc1Player4  = id;
	if(i == 5) simLoc1Player5 = id; if(i == 6)  simLoc1Player6  = id; if(i == 7)  simLoc1Player7  = id; if(i == 8)  simLoc1Player8  = id;
	if(i == 9) simLoc1Player9 = id; if(i == 10) simLoc1Player10 = id; if(i == 11) simLoc1Player11 = id; if(i == 12) simLoc1Player12 = id;
}

int simLoc2Player1 = -1; int simLoc2Player2  = -1; int simLoc2Player3  = -1; int simLoc2Player4  = -1;
int simLoc2Player5 = -1; int simLoc2Player6  = -1; int simLoc2Player7  = -1; int simLoc2Player8  = -1;
int simLoc2Player9 = -1; int simLoc2Player10 = -1; int simLoc2Player11 = -1; int simLoc2Player12 = -1;

int getSimLoc2Player(int i = 0) {
	if(i == 1) return(simLoc2Player1); if(i == 2)  return(simLoc2Player2);  if(i == 3)  return(simLoc2Player3);  if(i == 4)  return(simLoc2Player4);
	if(i == 5) return(simLoc2Player5); if(i == 6)  return(simLoc2Player6);  if(i == 7)  return(simLoc2Player7);  if(i == 8)  return(simLoc2Player8);
	if(i == 9) return(simLoc2Player9); if(i == 10) return(simLoc2Player10); if(i == 11) return(simLoc2Player11); if(i == 12) return(simLoc2Player12);
	return(-1);
}

void setSimLoc2Player(int i = 0, int id = -1) {
	if(i == 1) simLoc2Player1 = id; if(i == 2)  simLoc2Player2  = id; if(i == 3)  simLoc2Player3  = id; if(i == 4)  simLoc2Player4  = id;
	if(i == 5) simLoc2Player5 = id; if(i == 6)  simLoc2Player6  = id; if(i == 7)  simLoc2Player7  = id; if(i == 8)  simLoc2Player8  = id;
	if(i == 9) simLoc2Player9 = id; if(i == 10) simLoc2Player10 = id; if(i == 11) simLoc2Player11 = id; if(i == 12) simLoc2Player12 = id;
}

int simLoc3Player1 = -1; int simLoc3Player2  = -1; int simLoc3Player3  = -1; int simLoc3Player4  = -1;
int simLoc3Player5 = -1; int simLoc3Player6  = -1; int simLoc3Player7  = -1; int simLoc3Player8  = -1;
int simLoc3Player9 = -1; int simLoc3Player10 = -1; int simLoc3Player11 = -1; int simLoc3Player12 = -1;

int getSimLoc3Player(int i = 0) {
	if(i == 1) return(simLoc3Player1); if(i == 2)  return(simLoc3Player2);  if(i == 3)  return(simLoc3Player3);  if(i == 4)  return(simLoc3Player4);
	if(i == 5) return(simLoc3Player5); if(i == 6)  return(simLoc3Player6);  if(i == 7)  return(simLoc3Player7);  if(i == 8)  return(simLoc3Player8);
	if(i == 9) return(simLoc3Player9); if(i == 10) return(simLoc3Player10); if(i == 11) return(simLoc3Player11); if(i == 12) return(simLoc3Player12);
	return(-1);
}

void setSimLoc3Player(int i = 0, int id = -1) {
	if(i == 1) simLoc3Player1 = id; if(i == 2)  simLoc3Player2  = id; if(i == 3)  simLoc3Player3  = id; if(i == 4)  simLoc3Player4  = id;
	if(i == 5) simLoc3Player5 = id; if(i == 6)  simLoc3Player6  = id; if(i == 7)  simLoc3Player7  = id; if(i == 8)  simLoc3Player8  = id;
	if(i == 9) simLoc3Player9 = id; if(i == 10) simLoc3Player10 = id; if(i == 11) simLoc3Player11 = id; if(i == 12) simLoc3Player12 = id;
}

int simLoc4Player1 = -1; int simLoc4Player2  = -1; int simLoc4Player3  = -1; int simLoc4Player4  = -1;
int simLoc4Player5 = -1; int simLoc4Player6  = -1; int simLoc4Player7  = -1; int simLoc4Player8  = -1;
int simLoc4Player9 = -1; int simLoc4Player10 = -1; int simLoc4Player11 = -1; int simLoc4Player12 = -1;

int getSimLoc4Player(int i = 0) {
	if(i == 1) return(simLoc4Player1); if(i == 2)  return(simLoc4Player2);  if(i == 3)  return(simLoc4Player3);  if(i == 4)  return(simLoc4Player4);
	if(i == 5) return(simLoc4Player5); if(i == 6)  return(simLoc4Player6);  if(i == 7)  return(simLoc4Player7);  if(i == 8)  return(simLoc4Player8);
	if(i == 9) return(simLoc4Player9); if(i == 10) return(simLoc4Player10); if(i == 11) return(simLoc4Player11); if(i == 12) return(simLoc4Player12);
	return(-1);
}

void setSimLoc4Player(int i = 0, int id = -1) {
	if(i == 1) simLoc4Player1 = id; if(i == 2)  simLoc4Player2  = id; if(i == 3)  simLoc4Player3  = id; if(i == 4)  simLoc4Player4  = id;
	if(i == 5) simLoc4Player5 = id; if(i == 6)  simLoc4Player6  = id; if(i == 7)  simLoc4Player7  = id; if(i == 8)  simLoc4Player8  = id;
	if(i == 9) simLoc4Player9 = id; if(i == 10) simLoc4Player10 = id; if(i == 11) simLoc4Player11 = id; if(i == 12) simLoc4Player12 = id;
}

/*
** Gets a player in the array that stores the placement order of a similar location.
**
** @param simLocID: the ID of the similar location
** @param i: the index in the array to retrieve
** @param id: the player number to store in the specified array and index
*/
void setSimLocPlayer(int simLocID = -1, int i = 0, int id = -1) {
	if(simLocID == 1) {
		setSimLoc1Player(i, id);
	} else if(simLocID == 2) {
		setSimLoc2Player(i, id);
	} else if(simLocID == 3) {
		setSimLoc3Player(i, id);
	} else if(simLocID == 4) {
		setSimLoc4Player(i, id);
	}
}

/*
** Gets a player from the array that stores the placement order of a similar location.
**
** @param simLocID: the ID of the similar location
** @param i: the index in the array to retrieve
**
** @returns: the player stored in the specified array (simLocID) and index
*/
int getSimLocPlayer(int simLocID = -1, int i = 0) {
	if(simLocID == 1) {
		return(getSimLoc1Player(i));
	} else if(simLocID == 2) {
		return(getSimLoc2Player(i));
	} else if(simLocID == 3) {
		return(getSimLoc3Player(i));
	} else if(simLocID == 4) {
		return(getSimLoc4Player(i));
	}

	// Should never be reached.
	return(-1);
}

/*
** Sets the order in which similar locations are placed for a given similar location ID.
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
** @param simLocID: the ID of the similar location
*/
void setSimLocPlayerOrder(int simLocID = -1) {
	int posStart = 0;
	int posEnd = cNumTeamPos - 1;

	// Go from negatve positions to 0 if we're placing inside out and take abs of p when used.
	if(getSimLocInsideOut(simLocID)) {
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
				setSimLocPlayer(simLocID, currPlayer, getMirroredPlayer(i));
				currPlayer++;
			}

			setSimLocPlayer(simLocID, currPlayer, i);

			currPlayer++;
		}

	}
}

/*
** Adds a similar location.
** Note that additional options such as enableSimLocTwoPlayerCheck() has to be called before this (or a simLocID has to be specified).
**
** @param minDist: the minimum distance of the radius for the similar location from the player location
** @param maxDist: the maximum distance of the radius for the similar location from the player location
** @param areaDist: the distances between the areas that will be enforced (!)
** @param distX: edge distance of the x axis of the location
** @param distZ: edge distance of the z axis of the location
** @param inPlayerArea: whether the location should be enforced to lie within a player's section of the map
** @param inTeamArea: whether the location should be enforced to lie within a player's team section of the map
** @param isSquare: if true, the radius is converted to a square (the original rmPlaceObjectDef does this)
** @param insideOut: whether to start from the inner players or from the outer players when placing the locations
** @param simLocID: the ID of the similar location; if not given, the default counter is used (starting at 1) - only use this if you know what you're doing!
*/
void addSimLoc(float minDist = 0.0, float maxDist = -1.0, float areaDist = 0.0, float distX = 0.0, float distZ = -1.0,
			   bool inPlayerArea = false, bool inTeamArea = false, bool isSquare = false, bool insideOut = true, int simLocID = -1) {
	simLocCount++;

	if(distZ < 0.0) {
		distZ = distX;
	}

	if(simLocID < 0) {
		simLocID = simLocCount;
	}

	// Set last added ID.
	lastAddedSimLocID = simLocID;

	setSimLocMinDist(simLocID, minDist);
	setSimLocMaxDist(simLocID, maxDist);
	setSimLocAreaDist(simLocID, areaDist);
	setSimLocDistX(simLocID, distX);
	setSimLocDistZ(simLocID, distZ);
	setSimLocInPlayerArea(simLocID, inPlayerArea);
	setSimLocInTeamArea(simLocID, inTeamArea);
	setSimLocIsSquare(simLocID, isSquare);
	setSimLocInsideOut(simLocID, insideOut);

	// Update minCrossDist.
	calcSimLocMinCrossDist();

	// Set player order.
	setSimLocPlayerOrder(simLocID);
}

/*
** Adds a similar location and uses the same constraints as the previous simLoc did (but NOT same bias, twoPlayerTol, etc.).
**
** @param minDist: the minimum distance of the radius for the similar location from the player location
** @param maxDist: the maximum distance of the radius for the similar location from the player location
** @param areaDist: the distances between the areas that will be enforced (!)
** @param distX: edge distance of the x axis of the location
** @param distZ: edge distance of the z axis of the location
** @param inPlayerArea: whether the location should be enforced to lie within a player's section of the map
** @param inTeamArea: whether the location should be enforced to lie within a player's team section of the map
** @param isSquare: if true, the radius is converted to a square (the original rmPlaceObjectDef does this)
** @param insideOut: whether to start from the inner players or from the outer players when placing the locations
** @param simLocID: the ID of the similar location; if not given, the default counter is used (starting at 1) - only use this if you know what you're doing!
*/
void addSimLocWithPrevConstraints(float minDist = 0.0, float maxDist = -1.0, float areaDist = 0.0, float distX = 0.0, float distZ = -1.0,
								  bool inPlayerArea = false, bool inTeamArea = false, bool isSquare = false, bool insideOut = true, int simLocID = -1) {
	if(simLocID < 0) {
		simLocID = simLocCount + 1;
	}

	if(lastAddedSimLocID > 0) {
		for(i = 1; <= getSimLocConstraintCount(lastAddedSimLocID)) {
			addSimLocConstraint(getSimLocConstraint(lastAddedSimLocID, i), simLocID);
		}
	}

	addSimLoc(minDist, maxDist, areaDist, distX, distZ, inPlayerArea, inTeamArea, insideOut, isSquare, simLocID);
}

/*
** Resets all similar loc values.
*/
void resetSimLocVals() {
	simLoc1X1 = -1.0; simLoc1X2  = -1.0; simLoc1X3  = -1.0; simLoc1X4  = -1.0;
	simLoc1X5 = -1.0; simLoc1X6  = -1.0; simLoc1X7  = -1.0; simLoc1X8  = -1.0;
	simLoc1X9 = -1.0; simLoc1X10 = -1.0; simLoc1X11 = -1.0; simLoc1X12 = -1.0;

	simLoc2X1 = -1.0; simLoc2X2  = -1.0; simLoc2X3  = -1.0; simLoc2X4  = -1.0;
	simLoc2X5 = -1.0; simLoc2X6  = -1.0; simLoc2X7  = -1.0; simLoc2X8  = -1.0;
	simLoc2X9 = -1.0; simLoc2X10 = -1.0; simLoc2X11 = -1.0; simLoc2X12 = -1.0;

	simLoc3X1 = -1.0; simLoc3X2  = -1.0; simLoc3X3  = -1.0; simLoc3X4  = -1.0;
	simLoc3X5 = -1.0; simLoc3X6  = -1.0; simLoc3X7  = -1.0; simLoc3X8  = -1.0;
	simLoc3X9 = -1.0; simLoc3X10 = -1.0; simLoc3X11 = -1.0; simLoc3X12 = -1.0;

	simLoc4X1 = -1.0; simLoc4X2  = -1.0; simLoc4X3  = -1.0; simLoc4X4  = -1.0;
	simLoc4X5 = -1.0; simLoc4X6  = -1.0; simLoc4X7  = -1.0; simLoc4X8  = -1.0;
	simLoc4X9 = -1.0; simLoc4X10 = -1.0; simLoc4X11 = -1.0; simLoc4X12 = -1.0;

	simLoc1Z1 = -1.0; simLoc1Z2  = -1.0; simLoc1Z3  = -1.0; simLoc1Z4  = -1.0;
	simLoc1Z5 = -1.0; simLoc1Z6  = -1.0; simLoc1Z7  = -1.0; simLoc1Z8  = -1.0;
	simLoc1Z9 = -1.0; simLoc1Z10 = -1.0; simLoc1Z11 = -1.0; simLoc1Z12 = -1.0;

	simLoc2Z1 = -1.0; simLoc2Z2  = -1.0; simLoc2Z3  = -1.0; simLoc2Z4  = -1.0;
	simLoc2Z5 = -1.0; simLoc2Z6  = -1.0; simLoc2Z7  = -1.0; simLoc2Z8  = -1.0;
	simLoc2Z9 = -1.0; simLoc2Z10 = -1.0; simLoc2Z11 = -1.0; simLoc2Z12 = -1.0;

	simLoc3Z1 = -1.0; simLoc3Z2  = -1.0; simLoc3Z3  = -1.0; simLoc3Z4  = -1.0;
	simLoc3Z5 = -1.0; simLoc3Z6  = -1.0; simLoc3Z7  = -1.0; simLoc3Z8  = -1.0;
	simLoc3Z9 = -1.0; simLoc3Z10 = -1.0; simLoc3Z11 = -1.0; simLoc3Z12 = -1.0;

	simLoc4Z1 = -1.0; simLoc4Z2  = -1.0; simLoc4Z3  = -1.0; simLoc4Z4  = -1.0;
	simLoc4Z5 = -1.0; simLoc4Z6  = -1.0; simLoc4Z7  = -1.0; simLoc4Z8  = -1.0;
	simLoc4Z9 = -1.0; simLoc4Z10 = -1.0; simLoc4Z11 = -1.0; simLoc4Z12 = -1.0;
}

/*
** Cleans similar location settings. Should be called after placing a set of similar locations (and before the next ones are defined).
*/
void resetSimLocs() {
	simLocCount = 0;
	lastSimLocIters = -1;
	lastAddedSimLocID = -1;

	simLocMinCrossDist = 0.0;
	simLocInterDistMin = 0.0;
	simLocInterDistMax = INF;

	// Write the resetting a bit more compact to save some lines.
	simLocConstraintCount1 = 0; simLocConstraintCount2 = 0;	simLocConstraintCount3 = 0; simLocConstraintCount4 = 0;
	simLoc1TwoPlayerTol = -1.0; simLoc2TwoPlayerTol = -1.0; simLoc3TwoPlayerTol = -1.0; simLoc4TwoPlayerTol = -1.0;

	simLoc1BiasRangeFrom = 0.0; simLoc2BiasRangeFrom = 0.0; simLoc3BiasRangeFrom = 0.0; simLoc4BiasRangeFrom = 0.0;
	simLoc1BiasRangeTo = 1.0; simLoc2BiasRangeTo = 1.0; simLoc3BiasRangeTo = 1.0; simLoc4BiasRangeTo = 1.0;
	simLoc1RadiusInterval = 30.0; simLoc2RadiusInterval = 30.0; simLoc3RadiusInterval = 30.0; simLoc4RadiusInterval = 30.0;
	simLoc1AngleSegSize = 0.25; simLoc2AngleSegSize = 0.25; simLoc3AngleSegSize = 0.25; simLoc4AngleSegSize = 0.25;

	// As of now, the following resets are actually not needed, but we do it anyway to keep it clean.
	resetSimLocVals();

	simLoc1Player1 = -1; simLoc1Player2  = -1; simLoc1Player3  = -1; simLoc1Player4  = -1;
	simLoc1Player5 = -1; simLoc1Player6  = -1; simLoc1Player7  = -1; simLoc1Player8  = -1;
	simLoc1Player9 = -1; simLoc1Player10 = -1; simLoc1Player11 = -1; simLoc1Player12 = -1;

	simLoc2Player1 = -1; simLoc2Player2  = -1; simLoc2Player3  = -1; simLoc2Player4  = -1;
	simLoc2Player5 = -1; simLoc2Player6  = -1; simLoc2Player7  = -1; simLoc2Player8  = -1;
	simLoc2Player9 = -1; simLoc2Player10 = -1; simLoc2Player11 = -1; simLoc2Player12 = -1;

	simLoc3Player1 = -1; simLoc3Player2  = -1; simLoc3Player3  = -1; simLoc3Player4  = -1;
	simLoc3Player5 = -1; simLoc3Player6  = -1; simLoc3Player7  = -1; simLoc3Player8  = -1;
	simLoc3Player9 = -1; simLoc3Player10 = -1; simLoc3Player11 = -1; simLoc3Player12 = -1;

	simLoc4Player1 = -1; simLoc4Player2  = -1; simLoc4Player3  = -1; simLoc4Player4  = -1;
	simLoc4Player5 = -1; simLoc4Player6  = -1; simLoc4Player7  = -1; simLoc4Player8  = -1;
	simLoc4Player9 = -1; simLoc4Player10 = -1; simLoc4Player11 = -1; simLoc4Player12 = -1;
}

// Temporary angles and radii used during calculation.
float simLocTempAngle1 = NINF; float simLocTempAngle2  = NINF; float simLocTempAngle3  = NINF; float simLocTempAngle4  = NINF;
float simLocTempAngle5 = NINF; float simLocTempAngle6  = NINF; float simLocTempAngle7  = NINF; float simLocTempAngle8  = NINF;
float simLocTempAngle9 = NINF; float simLocTempAngle10 = NINF; float simLocTempAngle11 = NINF; float simLocTempAngle12 = NINF;

float getSimLocTempAngle(int id = 0) {
	if(id == 1) return(simLocTempAngle1); if(id == 2)  return(simLocTempAngle2);  if(id == 3)  return(simLocTempAngle3);  if(id == 4)  return(simLocTempAngle4);
	if(id == 5) return(simLocTempAngle5); if(id == 6)  return(simLocTempAngle6);  if(id == 7)  return(simLocTempAngle7);  if(id == 8)  return(simLocTempAngle8);
	if(id == 9) return(simLocTempAngle9); if(id == 10) return(simLocTempAngle10); if(id == 11) return(simLocTempAngle11); if(id == 12) return(simLocTempAngle12);
	return(NINF);
}

void setSimLocTempAngle(int id = 0, float val = NINF) {
	if(id == 1) simLocTempAngle1 = val; if(id == 2)  simLocTempAngle2  = val; if(id == 3)  simLocTempAngle3  = val; if(id == 4)  simLocTempAngle4  = val;
	if(id == 5) simLocTempAngle5 = val; if(id == 6)  simLocTempAngle6  = val; if(id == 7)  simLocTempAngle7  = val; if(id == 8)  simLocTempAngle8  = val;
	if(id == 9) simLocTempAngle9 = val; if(id == 10) simLocTempAngle10 = val; if(id == 11) simLocTempAngle11 = val; if(id == 12) simLocTempAngle12 = val;
}

float simLocTempRadius1 = NINF; float simLocTempRadius2  = NINF; float simLocTempRadius3  = NINF; float simLocTempRadius4  = NINF;
float simLocTempRadius5 = NINF; float simLocTempRadius6  = NINF; float simLocTempRadius7  = NINF; float simLocTempRadius8  = NINF;
float simLocTempRadius9 = NINF; float simLocTempRadius10 = NINF; float simLocTempRadius11 = NINF; float simLocTempRadius12 = NINF;

float getSimLocTempRadius(int id = 0) {
	if(id == 1) return(simLocTempRadius1); if(id == 2)  return(simLocTempRadius2);  if(id == 3)  return(simLocTempRadius3);  if(id == 4)  return(simLocTempRadius4);
	if(id == 5) return(simLocTempRadius5); if(id == 6)  return(simLocTempRadius6);  if(id == 7)  return(simLocTempRadius7);  if(id == 8)  return(simLocTempRadius8);
	if(id == 9) return(simLocTempRadius9); if(id == 10) return(simLocTempRadius10); if(id == 11) return(simLocTempRadius11); if(id == 12) return(simLocTempRadius12);
	return(NINF);
}

void setSimLocTempRadius(int id = 0, float val = NINF) {
	if(id == 1) simLocTempRadius1 = val; if(id == 2)  simLocTempRadius2  = val; if(id == 3)  simLocTempRadius3  = val; if(id == 4)  simLocTempRadius4  = val;
	if(id == 5) simLocTempRadius5 = val; if(id == 6)  simLocTempRadius6  = val; if(id == 7)  simLocTempRadius7  = val; if(id == 8)  simLocTempRadius8  = val;
	if(id == 9) simLocTempRadius9 = val; if(id == 10) simLocTempRadius10 = val; if(id == 11) simLocTempRadius11 = val; if(id == 12) simLocTempRadius12 = val;
}

/*
** Cleans the temporary values.
** HAS to be called before starting a new iteration for a similar location ID as functions may expect unset values to be NINF.
*/
void resetSimLocTempVals() {
	simLocTempAngle1 = NINF; simLocTempAngle2  = NINF; simLocTempAngle3  = NINF; simLocTempAngle4  = NINF;
	simLocTempAngle5 = NINF; simLocTempAngle6  = NINF; simLocTempAngle7  = NINF; simLocTempAngle8  = NINF;
	simLocTempAngle9 = NINF; simLocTempAngle10 = NINF; simLocTempAngle11 = NINF; simLocTempAngle12 = NINF;

	simLocTempRadius1 = NINF; simLocTempRadius2  = NINF; simLocTempRadius3  = NINF; simLocTempRadius4  = NINF;
	simLocTempRadius5 = NINF; simLocTempRadius6  = NINF; simLocTempRadius7  = NINF; simLocTempRadius8  = NINF;
	simLocTempRadius9 = NINF; simLocTempRadius10 = NINF; simLocTempRadius11 = NINF; simLocTempRadius12 = NINF;
}

/*************
* GENERATION *
*************/

/*
** Performs an additional check that leads to very balanced placement in 1v1 situations.
** This check essentially calculates the ratio of the players' distance to the similar location of the respective other player.
** The fraction has to be smaller than twoPlayerTol to succeed, i.e., less than a certain percentage (0.125 -> difference in distance is less than 12.5%).
**
** @param simLocID: the location ID of the similar location to check
**
** @returns: true if the check succeeded, false otherwise
*/
bool performSimLocTwoPlayerCheck(int simLocID = -1) {
	if(cNonGaiaPlayers != 2) {
		return(true);
	}

	float twoPlayerTol = getSimLocTwoPlayerTol(simLocID);

	if(twoPlayerTol < 0.0) { // Not set.
		return(true);
	}

	// Get the distance in meters between p1 and the similar loc of p2 and the other way around.
	float distP1 = pointsGetDist(rmXFractionToMeters(getPlayerLocXFraction(1)), rmZFractionToMeters(getPlayerLocZFraction(1)),
								 rmXFractionToMeters(getSimLocX(simLocID, 2)), rmZFractionToMeters(getSimLocZ(simLocID, 2)));

	float distP2 = pointsGetDist(rmXFractionToMeters(getPlayerLocXFraction(2)), rmZFractionToMeters(getPlayerLocZFraction(2)),
								 rmXFractionToMeters(getSimLocX(simLocID, 1)), rmZFractionToMeters(getSimLocZ(simLocID, 1)));

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
** Randomizes a similar location angle according to the specified ranges.
**
** @param simLocID: the ID of the similar location to randomize an angle for
**
** @returns: the randomized angle
*/
float randSimLocAngle(int simLocID = -1) {
	float rangeFrom = getSimLocBiasRangeFrom(simLocID);
	float rangeTo = getSimLocBiasRangeTo(simLocID);

	if(rangeFrom == NINF || rangeTo == NINF) {
		return(randRadian()); // Unset bias, randomize from full range.
	}

	return(rmRandFloat(rangeFrom, rangeTo) * PI);
}

/*
** Randomizes a similar location radius according to the specified ranges.
**
** @param simLocID: the ID of the similar location to randomize a radius for
**
** @returns: the randomized radius
*/
float randSimLocRadius(int simLocID = -1) {
	return(rmRandFloat(getSimLocMinDist(simLocID), getSimLocMaxDist(simLocID)));
}

/*
** Randomizes an angle for a similar location for a player.
**
** @param simLocID: the ID of the similar location
** @param player: the player
** @param tol: tolerance for the angle; larger tolerance means that the angle may not lie within the original section anymore
**
** @returns: the randomized angle
*/
float findSimLocAngleForPlayer(int simLocID = -1, int player = 0, float tol = 0.0) {
	float angle = getSimLocTempAngle(player);
	float segment = getSimLocAngleSegSize(simLocID); // Segment used to extend both sides (effectively forming an angle of 2 * segment * PI).
	float rangeFrom = getSimLocBiasRangeFrom(simLocID);
	float rangeTo = getSimLocBiasRangeTo(simLocID);

	// Adjust ranges based on segment and the received angle.
	rangeFrom = max(angle - segment * PI, rangeFrom * PI);
	rangeTo = min(angle + segment * PI, rangeTo * PI);

	float tolAdjust = (PI - (rangeTo - rangeFrom)) * tol;

	// Randomize from a segment around the given angle.
	// angle = randFromIntervals(rangeFrom - tolAdjust, rangeTo + tolAdjust, 2.0 * PI - rangeTo - tolAdjust, 2.0 * PI - rangeFrom + tolAdjust);
	angle = randFromIntervals(max(rangeFrom - tolAdjust, 0.0), min(rangeTo + tolAdjust, PI),
							  max(2.0 * PI - rangeTo - tolAdjust, PI), min(2.0 * PI - rangeFrom + tolAdjust, 2.0 * PI));
	angle = angle + getPlayerTeamOffsetAngle(player);

	return(angle);
}

/*
** Randomizes a radius for a similar location for a player.
**
** @param simLocID: the ID of the similar location
** @param player: the player
** @param tol: tolerance for the angle; larger tolerance means that the angle may not lie within the original section anymore
**
** @returns: the randomized radius
*/
float findSimLocRadiusForPlayer(int simLocID = -1, int player = 0, float tol = 0.0) {
	// Randomize from an interval around the given radius.
	float radius = getSimLocTempRadius(player);
	float interval = 0.5 * getSimLocRadiusInterval(simLocID); // Half of the interval since we apply it to both ends of the range.

	// TODO Consider scaling the interval here via increasing tol.

	radius = randRadiusFromInterval(max(radius - interval, getSimLocMinDist(simLocID)), min(radius + interval, getSimLocMaxDist(simLocID)));

	return(radius);
}

/*
** Checks if a similar location with a radius and angle is valid (within map coordinates) and sets the values for the player.
** Also sets the x/z values for the mirrored player if mirroring is enabled.
**
** @param simLocID: the ID of the similar location
** @param player: the player
** @param radius: the radius to use for the location
** @param angle: the angle in radians to use
**
** @returns: true if a valid location was obtained, false otherwise
*/
bool checkAndSetSimLoc(int simLocID = -1, int player = 0, float radius = 0.0, float angle = 0.0) {
	float x = getXFromPolarForPlayer(player, radius, angle, getSimLocIsSquare(simLocID));
	float z = getZFromPolarForPlayer(player, radius, angle, getSimLocIsSquare(simLocID));

	if(isLocValid(x, z, rmXMetersToFraction(getSimLocDistX(simLocID)), rmZMetersToFraction(getSimLocDistZ(simLocID))) == false) {
		return(false);
	}

	setSimLocXZ(simLocID, player, x, z);

	// Also set mirrored coordinates if necessary.
	if(isMirrorOnAndValidConfig()) {
		player = getMirroredPlayer(player);

		if(getMirrorMode() != cMirrorPoint) {
			angle = 0.0 - angle;
		}

		x = getXFromPolarForPlayer(player, radius, angle, getSimLocIsSquare(simLocID));
		z = getZFromPolarForPlayer(player, radius, angle, getSimLocIsSquare(simLocID));

		setSimLocXZ(simLocID, player, x, z);
	}

	return(true);
}

/*
** Compares two similar locations and evaluates their validity according to the specified constraints.
**
** The following constraints are checked:
** 1. simLocInterDistMin (if specified): minimum distance similar locations of a player have to be apart from each other.
**    If not set, the cross distance is used as value (in the cross distance check as this is always performed).
**
** 2. simLocInterDistMax (if specified): maximum distance similar locations of a player can be apart from each other.
**
** 3. simLocAreaDist: minimum distance similar locations with the same similar location ID have to be apart from each other.
**
** 4. simLocMinCrossDist: minimum distance all specified similar locations have to be apart from each other.
**    This corresponds to the minimum areaDist value set when using addSimLoc().
**
** @param simLocID1: simLocID of the first similar location
** @param player1: player owning the first similar location
** @param simLocID2: simLocID of the second similar location
** @param player2: player owning the second similar location
**
** @returns: true if the comparison succeeded, false otherwise
*/
bool compareSimLocs(int simLocID1 = -1, int player1 = 0, int simLocID2 = -1, int player2 = 0) {
	float dist = pointsGetDist(rmXFractionToMeters(getSimLocX(simLocID1, player1)), rmZFractionToMeters(getSimLocZ(simLocID1, player1)),
							   rmXFractionToMeters(getSimLocX(simLocID2, player2)), rmZFractionToMeters(getSimLocZ(simLocID2, player2)));

	// Calculate similar loc inter distance (distance among similar locs of a player).
	if(player1 == player2) {
		if(dist < simLocInterDistMin) {
			return(false);
		}

		if(dist > simLocInterDistMax) {
			return(false);
		}
	}

	// Calculate similar loc intra distance (compare similar loc to the same similar loc of the other players).
	if(simLocID1 == simLocID2 && dist < getSimLocAreaDist(simLocID1)) {
		return(false);
	}

	// Calculate similar loc cross distance.
	if(dist < simLocMinCrossDist) {
		return(false);
	}

	return(true);
}

/*
** Performs checks to ensure that a similar location adheres to the specified settings (distance settings, NOT area constraints!).
** The check involves comparing the current similar location to be placed against all other similar locations that were previously placed.
**
** @param simLocID: the similar location ID of the location to check
** @param player: the player owning the similar location
**
** @returns: true if the check succeeded, false otherwise
*/
bool checkSimLoc(int simLocID = -1, int player = 0) {
	// Iterate over similar locs.
	for(s = 1; <= simLocID) {

		// Iterate over players.
		for(i = 1; < cPlayers) {
			// Map player to loc player array.
			int p = getSimLocPlayer(s, i);

			if(s == simLocID && p == player) {
				// Terminate early if we made it this far, skip remaining player for last simLoc as they have not had their simLoc placed yet.
				return(true);
			}

			if(compareSimLocs(simLocID, player, s, p) == false) {
				return(false);
			}
		}

	}
}

/*
** Attempts to build a previously placed similar location with respect to the constraints.
** Also adds player area and team area constraints if specified.
**
** @param simLocID: the ID of the similar location
** @param player: the player
**
** @returns: true if the area was successfully built, false otherwise
*/
bool buildSimLoc(int simLocID = -1, int player = 0) {
	// Define areas, apply constraints and try to place.
	int areaID = rmCreateArea(cSimLocName + " " + simLocNameCounter);

	rmSetAreaLocation(areaID, getSimLocX(simLocID, player), getSimLocZ(simLocID, player));

	rmSetAreaSize(areaID, rmXMetersToFraction(0.1));
	//rmSetAreaTerrainType(areaID, "HadesBuildable1");
	//rmSetAreaBaseHeight(areaID, 10.0);
	rmSetAreaCoherence(areaID, 1.0);
	rmSetAreaWarnFailure(areaID, false);

	simLocNameCounter++;

	// Add all defined constraints.
	for(j = 1; <= getSimLocConstraintCount(simLocID)) {
		rmAddAreaConstraint(areaID, getSimLocConstraint(simLocID, j));
	}

	// Add player area constraint if enabled.
	if(getSimLocInPlayerArea(simLocID)) {
		rmAddAreaConstraint(areaID, getPlayerAreaConstraint(player));
	}

	// Add team area constraint if enabled.
	if(getSimLocInTeamArea(simLocID)) {
		rmAddAreaConstraint(areaID, getTeamAreaConstraint(player));
	}

	return(rmBuildArea(areaID));
}

/*
** Single attempt to create a similar location.
**
** @param simLocID: the location ID of the similar location
** @param player: the player owning the similar location
** @param tol: tolerance for the angle; larger tolerance means that the angle may not lie within the original section anymore
**
** @returns: true upon success, false otherwise
*/
bool createSimLocForPlayer(int simLocID = -1, int player = 0, float tol = 0.0) {
	float angle = findSimLocAngleForPlayer(simLocID, player, tol);
	float radius = findSimLocRadiusForPlayer(simLocID, player, tol);

	if(checkAndSetSimLoc(simLocID, player, radius, angle) == false) {
		return(false);
	}

	// This is probably not necessary because the next check also considers the location placed for getMirroredPlayer(player).
	// if(isMirrorOnAndValidConfig()) {
		// if(checkSimLoc(simLocID, getMirroredPlayer(player)) == false) {
			// return(false)
		// }
	// }

	if(checkSimLoc(simLocID, player) == false) {
		return(false);
	}

	if(isMirrorOnAndValidConfig()) {
		if(buildSimLoc(simLocID, getMirroredPlayer(player)) == false) {
			return(false);
		}
	}

	return(buildSimLoc(simLocID, player));
}

/*
** Tries to create a valid similar location for a player according to the parameters specified by addSimLoc().
** The algorithm tries to find a valid location for a given number of times.
**
** @param simLocID: the location ID of the similar location
** @param player: the player owning the similar location
** @param maxIter: the number of attempts to find the location
**
** @returns: the number of iterations that were required to find a location; -1 indicates failure
*/
int createSimLocFromParams(int simLocID = -1, int player = 0, int maxIter = 100) {
	float tol = 0.0;
	int localIter = 0;
	int failCount = 0;

	while(localIter < maxIter) {
		// Increase tolerance upon failing several times.
		if(failCount >= 5) {
			failCount = 0;
			tol = min(tol + 0.05, 1.0); // Make sure we don't exceed 100% tolerance.
		}

		localIter++;

		// Try to find valid location.
		if(createSimLocForPlayer(simLocID, player, tol)) {
			return(localIter);
		}

		failCount++;
	}

	// -1 = failed to find a location within maxIter iterations, caller can decide what to do with this value.
	return(-1);
}

/*
** Sets the temporary angle/radius to use for the current pair of players.
**
** @param simLocID: the location ID of the similar location
** @param player: the player owning the similar location
*/
void setSimLocTempParams(int simLocID = -1, int player = 0) {
	// Determine opposing player to see if we already set an angle/radius for either of the current pair of players.
	int op = getMirroredPlayer(player);

	// Adjust angle and radius depending on setup.
	if(isMirrorOnAndValidConfig() || gameHasTwoEqualTeams() == false || getSimLocTempAngle(op) == NINF) {
		// Create new angle/radius.
		setSimLocTempAngle(player, randSimLocAngle(simLocID));
		setSimLocTempRadius(player, randSimLocRadius(simLocID));
	} else {
		// Load stored angle/radius from mirrored/opposing player.
		setSimLocTempAngle(player, getSimLocTempAngle(op));
		setSimLocTempRadius(player, getSimLocTempRadius(op));
	}
}

/*
** Runs the similar location placement algorithm.
** If a mirror mode is set, the created similar locations will be mirrored.
**
** @param maxIter: the maximum number of iterations to run the algorithm for
** @param localMaxIter: the maximum attempts to find a similar location for every player before starting over
**
** @returns: true upon success, false otherwise
*/
bool runSimLocs(int maxIter = 5000, int localMaxIter = 100) {
	int currIter = 0;
	int numPlayers = cNonGaiaPlayers;
	bool done = false;

	// Adjust player number in case we mirror, place only first half.
	if(isMirrorOnAndValidConfig()) {
		numPlayers = getNumberPlayersOnTeam(0);
	}

	while(currIter < maxIter && done == false) {
		done = true;

		// Iterate over similar locations.
		for(s = 1; <= simLocCount) {
			resetSimLocTempVals(); // Reset values for current simLoc.

			// Iterate over players.
			for(i = 1; <= numPlayers) {
				int p = getSimLocPlayer(s, i);

				if(isMirrorOnAndValidConfig()) {
					p = getSimLocPlayer(s, (i - 1) * 2 + 1);
				}

				// Determine angle and radius to use for the current player.
				setSimLocTempParams(s, p);

				// Try to create a similar location.
				int numIter = createSimLocFromParams(s, p, localMaxIter);

				if(numIter < 0) { // Failed, increment currIter; could also penalize fails later in the algorithm harder.
					currIter = currIter + localMaxIter;
					done = false;
					break;
				}

				currIter = currIter + numIter;
			}

			if(done == false) {
				break;
			} else if(performSimLocTwoPlayerCheck(s) == false) {
				done = false;
				break;
			}
		}
	}

	if(done == false) {
		lastSimLocIters = -1;
		return(false);
	}

	lastSimLocIters = currIter;
	return(true);
}

/*
** Attempts to create similar locations according to the added definitions and chosen settings.
** Also considers mirroring if a mirror mode was set prior to the call.
**
** @param simLocLabel: the name of the similar location (only used for debugging purposes)
** @param isCrucial: whether the similar loc is crucial and players should be warned if it fails or not
** @param maxIter: the maximum number of iterations to run the algorithm for
** @param localMaxIter: the maximum attempts to find a similar location for every player before starting over
**
** @returns: true if the locations were successfully generated, false otherwise
*/
bool createSimLocs(string simLocLabel = "", bool isCrucial = true, int maxIter = 5000, int localMaxIter = 100) {
	// Initialize splits if not already done.
	initializePlayerAreaConstraints();
	initializeTeamAreaConstraints();

	bool success = runSimLocs(maxIter, localMaxIter);

	// Clear values if not debugging.
	if(success == false && cDebugMode < cDebugTest) {
		resetSimLocVals();
	}

	// Print message if debugging.
	string varSpace = " ";

	if(simLocLabel == "") {
		varSpace = "";
	}

	if(lastSimLocIters >= 0) {
		printDebug("simLoc" + varSpace + simLocLabel + " succeeded: i = " + lastSimLocIters, cDebugTest);
	}

	// Log result.
	addCustomCheck("simLoc" + varSpace + simLocLabel, isCrucial, success);

	return(success);
}

/*
** Creates (fake) areas on the similar locations and adds them to a class.
** Useful if you need to block similar areas, but do not want to place objects on them yet.
**
** @param classID: the ID of the class to add the similar locations to
** @param areaMeterRadius: the radius of the (invisible) area to create
** @param simLocID: the ID of the similar location to create the areas from; if defaulted to -1, all stored similar locations will have locations generated
*/
void simLocAreasToClass(int classID = -1, float areaMeterRadius = 5.0, int simLocID = -1) {
	int simLocStartID = 1;

	if(simLocID < 0) {
		simLocID = simLocCount;
	} else {
		simLocStartID = simLocID;
	}

	for(i = simLocStartID; <= simLocID) {
		for(j = 1; < cPlayers) {
			int simLocAreaID = rmCreateArea(cSimLocAreaName + " " + simLocAreaNameCounter + " " + i + " " + j);
			rmSetAreaLocation(simLocAreaID, getSimLocX(i, j), getSimLocZ(i, j));
			rmSetAreaSize(simLocAreaID, areaRadiusMetersToFraction(areaMeterRadius));
			rmSetAreaCoherence(simLocAreaID, 1.0);
			rmAddAreaToClass(simLocAreaID, classID);
		}
	}

	rmBuildAllAreas();

	simLocAreaNameCounter++;
}

/*
** Stores the current set of similar locations in the location storage.
*/
void storeSimLocs() {
	for(i = 1; <= simLocCount) {
		for(j = 1; < cPlayers) {
			forceAddLocToStorage(getSimLocX(i, j), getSimLocZ(i, j), j);
		}
	}
}

/*
** Adds all stored constraints to an object.
** Useful if you need to apply the constraints to an already created object,
** for example, if you need to place the object normally instead of using sim locs due to the player number.
*/
void applySimLocConstraintsToObject(int objectID = -1, int simLocID = -1) {
	if(simLocID < 0) {
		simLocID = simLocCount;
	}

	for(i = 1; <= getSimLocConstraintCount(simLocID)) {
		rmAddObjectDefConstraint(objectID, getSimLocConstraint(simLocID, i));
	}
}
