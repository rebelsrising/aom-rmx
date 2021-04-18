/*
** Shape generation.
** RebelsRising
** Last edit: 07/03/2021
**
** This implementation is based on a data structure described as below and adjusted from an implementation of SlySherZ.
**
** I'm using a different approach for blob placement and to map the blob grid to the actual map.
** Furthermore, data access methods are adjusted to fit the approach I'm taking for forest generation (see areas.xs)
** to achieve irregular (yet mirrored) forest placement with good variance.
**
** The core principle is to start with a single (center) area, then expand slowly and randomly to areas adjacent to this center area.
** To do so, consider all areas around already chosen areas as possible attachment points.
** Due to non-continuity, this only allows to consider areas in a square or a cross around a given area, e.g.:
**
** - - -
** - + -
** - - -
**
** To do this, we maintain two lists of states (near and full). Full blobs are blobs that are used for placement,
** where as near blobs are in consideration for the next possible blob to be placed.
** The lists can be searched and elements can be deleted (where the last element is copied on to the position
** of the element to be deleted).
**
** After making the center '+' of the upper example a full blob, we get:
**
** - - - - -
** - + + + -           x = full blob
** - + x + -   where   + = near blob
** - + + + -           - = empty blob
** - - - - -
*/

include "rmx_sim_locs.xs";

/************
* CONSTANTS *
************/

extern const int cBlobInvalid = -1;
extern const int cBlobEmpty = 0;
extern const int cBlobNear = 1;
extern const int cBlobFull = 2;

const int cFirstState = 1;
const int cTotalStates = 2;

/***************
* BLOB REMOVAL *
***************/

/*
 * Although not used in this file, this array is declared here to be used in combination with the shape generator.
 *
 * The idea is to place a shape and then build fake areas one by one. This allows to determine how many of the blobs were actually built.
 * Based on this, you can specify a minimum percentage (or number) of blobs that must be built successfully for a shape to be actually placed.
 *
 * This should greatly improve the quality of areas generated (check "forests.xs" for an example of this technique).
*/

int blobForRemoval0  = 0; int blobForRemoval1  = 0; int blobForRemoval2  = 0; int blobForRemoval3  = 0;
int blobForRemoval4  = 0; int blobForRemoval5  = 0; int blobForRemoval6  = 0; int blobForRemoval7  = 0;
int blobForRemoval8  = 0; int blobForRemoval9  = 0; int blobForRemoval10 = 0; int blobForRemoval11 = 0;
int blobForRemoval12 = 0; int blobForRemoval13 = 0; int blobForRemoval14 = 0; int blobForRemoval15 = 0;
int blobForRemoval16 = 0; int blobForRemoval17 = 0; int blobForRemoval18 = 0; int blobForRemoval19 = 0;
int blobForRemoval20 = 0; int blobForRemoval21 = 0; int blobForRemoval22 = 0; int blobForRemoval23 = 0;
int blobForRemoval24 = 0; int blobForRemoval25 = 0; int blobForRemoval26 = 0; int blobForRemoval27 = 0;
int blobForRemoval28 = 0; int blobForRemoval29 = 0; int blobForRemoval30 = 0; int blobForRemoval31 = 0;
int blobForRemoval32 = 0; int blobForRemoval33 = 0; int blobForRemoval34 = 0; int blobForRemoval35 = 0;
int blobForRemoval36 = 0; int blobForRemoval37 = 0; int blobForRemoval38 = 0; int blobForRemoval39 = 0;
int blobForRemoval40 = 0; int blobForRemoval41 = 0; int blobForRemoval42 = 0; int blobForRemoval43 = 0;
int blobForRemoval44 = 0; int blobForRemoval45 = 0; int blobForRemoval46 = 0; int blobForRemoval47 = 0;
int blobForRemoval48 = 0; int blobForRemoval49 = 0; int blobForRemoval50 = 0; int blobForRemoval51 = 0;
int blobForRemoval52 = 0; int blobForRemoval53 = 0; int blobForRemoval54 = 0; int blobForRemoval55 = 0;
int blobForRemoval56 = 0; int blobForRemoval57 = 0; int blobForRemoval58 = 0; int blobForRemoval59 = 0;
int blobForRemoval60 = 0; int blobForRemoval61 = 0; int blobForRemoval62 = 0; int blobForRemoval63 = 0;

int getBlobForRemoval(int i = -1) {
	if(i == 0)  return(blobForRemoval0);  if(i == 1)  return(blobForRemoval1);  if(i == 2)  return(blobForRemoval2);  if(i == 3)  return(blobForRemoval3);
	if(i == 4)  return(blobForRemoval4);  if(i == 5)  return(blobForRemoval5);  if(i == 6)  return(blobForRemoval6);  if(i == 7)  return(blobForRemoval7);
	if(i == 8)  return(blobForRemoval8);  if(i == 9)  return(blobForRemoval9);  if(i == 10) return(blobForRemoval10); if(i == 11) return(blobForRemoval11);
	if(i == 12) return(blobForRemoval12); if(i == 13) return(blobForRemoval13); if(i == 14) return(blobForRemoval14); if(i == 15) return(blobForRemoval15);
	if(i == 16) return(blobForRemoval16); if(i == 17) return(blobForRemoval17); if(i == 18) return(blobForRemoval18); if(i == 19) return(blobForRemoval19);
	if(i == 20) return(blobForRemoval20); if(i == 21) return(blobForRemoval21); if(i == 22) return(blobForRemoval22); if(i == 23) return(blobForRemoval23);
	if(i == 24) return(blobForRemoval24); if(i == 25) return(blobForRemoval25); if(i == 26) return(blobForRemoval26); if(i == 27) return(blobForRemoval27);
	if(i == 28) return(blobForRemoval28); if(i == 29) return(blobForRemoval29); if(i == 30) return(blobForRemoval30); if(i == 31) return(blobForRemoval31);
	if(i == 32) return(blobForRemoval32); if(i == 33) return(blobForRemoval33); if(i == 34) return(blobForRemoval34); if(i == 35) return(blobForRemoval35);
	if(i == 36) return(blobForRemoval36); if(i == 37) return(blobForRemoval37); if(i == 38) return(blobForRemoval38); if(i == 39) return(blobForRemoval39);
	if(i == 40) return(blobForRemoval40); if(i == 41) return(blobForRemoval41); if(i == 42) return(blobForRemoval42); if(i == 43) return(blobForRemoval43);
	if(i == 44) return(blobForRemoval44); if(i == 45) return(blobForRemoval45); if(i == 46) return(blobForRemoval46); if(i == 47) return(blobForRemoval47);
	if(i == 48) return(blobForRemoval48); if(i == 49) return(blobForRemoval49); if(i == 50) return(blobForRemoval50); if(i == 51) return(blobForRemoval51);
	if(i == 52) return(blobForRemoval52); if(i == 53) return(blobForRemoval53); if(i == 54) return(blobForRemoval54); if(i == 55) return(blobForRemoval55);
	if(i == 56) return(blobForRemoval56); if(i == 57) return(blobForRemoval57); if(i == 58) return(blobForRemoval58); if(i == 59) return(blobForRemoval59);
	if(i == 60) return(blobForRemoval60); if(i == 61) return(blobForRemoval61); if(i == 62) return(blobForRemoval62); if(i == 63) return(blobForRemoval63);
	return(0);
}

int setBlobForRemoval(int i = -1, int blobID = 0) {
	if(i == 0)  blobForRemoval0  = blobID; if(i == 1)  blobForRemoval1  = blobID; if(i == 2)  blobForRemoval2  = blobID; if(i == 3)  blobForRemoval3  = blobID;
	if(i == 4)  blobForRemoval4  = blobID; if(i == 5)  blobForRemoval5  = blobID; if(i == 6)  blobForRemoval6  = blobID; if(i == 7)  blobForRemoval7  = blobID;
	if(i == 8)  blobForRemoval8  = blobID; if(i == 9)  blobForRemoval9  = blobID; if(i == 10) blobForRemoval10 = blobID; if(i == 11) blobForRemoval11 = blobID;
	if(i == 12) blobForRemoval12 = blobID; if(i == 13) blobForRemoval13 = blobID; if(i == 14) blobForRemoval14 = blobID; if(i == 15) blobForRemoval15 = blobID;
	if(i == 16) blobForRemoval16 = blobID; if(i == 17) blobForRemoval17 = blobID; if(i == 18) blobForRemoval18 = blobID; if(i == 19) blobForRemoval19 = blobID;
	if(i == 20) blobForRemoval20 = blobID; if(i == 21) blobForRemoval21 = blobID; if(i == 22) blobForRemoval22 = blobID; if(i == 23) blobForRemoval23 = blobID;
	if(i == 24) blobForRemoval24 = blobID; if(i == 25) blobForRemoval25 = blobID; if(i == 26) blobForRemoval26 = blobID; if(i == 27) blobForRemoval27 = blobID;
	if(i == 28) blobForRemoval28 = blobID; if(i == 29) blobForRemoval29 = blobID; if(i == 30) blobForRemoval30 = blobID; if(i == 31) blobForRemoval31 = blobID;
	if(i == 32) blobForRemoval32 = blobID; if(i == 33) blobForRemoval33 = blobID; if(i == 34) blobForRemoval34 = blobID; if(i == 35) blobForRemoval35 = blobID;
	if(i == 36) blobForRemoval36 = blobID; if(i == 37) blobForRemoval37 = blobID; if(i == 38) blobForRemoval38 = blobID; if(i == 39) blobForRemoval39 = blobID;
	if(i == 40) blobForRemoval40 = blobID; if(i == 41) blobForRemoval41 = blobID; if(i == 42) blobForRemoval42 = blobID; if(i == 43) blobForRemoval43 = blobID;
	if(i == 44) blobForRemoval44 = blobID; if(i == 45) blobForRemoval45 = blobID; if(i == 46) blobForRemoval46 = blobID; if(i == 47) blobForRemoval47 = blobID;
	if(i == 48) blobForRemoval48 = blobID; if(i == 49) blobForRemoval49 = blobID; if(i == 50) blobForRemoval50 = blobID; if(i == 51) blobForRemoval51 = blobID;
	if(i == 52) blobForRemoval52 = blobID; if(i == 53) blobForRemoval53 = blobID; if(i == 54) blobForRemoval54 = blobID; if(i == 55) blobForRemoval55 = blobID;
	if(i == 56) blobForRemoval56 = blobID; if(i == 57) blobForRemoval57 = blobID; if(i == 58) blobForRemoval58 = blobID; if(i == 59) blobForRemoval59 = blobID;
	if(i == 60) blobForRemoval60 = blobID; if(i == 61) blobForRemoval61 = blobID; if(i == 62) blobForRemoval62 = blobID; if(i == 63) blobForRemoval63 = blobID;
}

/*************
* FULL BLOBS *
*************/

int fullBlobsCount = 0;

int fullBlobX0  = 0; int fullBlobX1  = 0; int fullBlobX2  = 0; int fullBlobX3  = 0;
int fullBlobX4  = 0; int fullBlobX5  = 0; int fullBlobX6  = 0; int fullBlobX7  = 0;
int fullBlobX8  = 0; int fullBlobX9  = 0; int fullBlobX10 = 0; int fullBlobX11 = 0;
int fullBlobX12 = 0; int fullBlobX13 = 0; int fullBlobX14 = 0; int fullBlobX15 = 0;
int fullBlobX16 = 0; int fullBlobX17 = 0; int fullBlobX18 = 0; int fullBlobX19 = 0;
int fullBlobX20 = 0; int fullBlobX21 = 0; int fullBlobX22 = 0; int fullBlobX23 = 0;
int fullBlobX24 = 0; int fullBlobX25 = 0; int fullBlobX26 = 0; int fullBlobX27 = 0;
int fullBlobX28 = 0; int fullBlobX29 = 0; int fullBlobX30 = 0; int fullBlobX31 = 0;
int fullBlobX32 = 0; int fullBlobX33 = 0; int fullBlobX34 = 0; int fullBlobX35 = 0;
int fullBlobX36 = 0; int fullBlobX37 = 0; int fullBlobX38 = 0; int fullBlobX39 = 0;
int fullBlobX40 = 0; int fullBlobX41 = 0; int fullBlobX42 = 0; int fullBlobX43 = 0;
int fullBlobX44 = 0; int fullBlobX45 = 0; int fullBlobX46 = 0; int fullBlobX47 = 0;
int fullBlobX48 = 0; int fullBlobX49 = 0; int fullBlobX50 = 0; int fullBlobX51 = 0;
int fullBlobX52 = 0; int fullBlobX53 = 0; int fullBlobX54 = 0; int fullBlobX55 = 0;
int fullBlobX56 = 0; int fullBlobX57 = 0; int fullBlobX58 = 0; int fullBlobX59 = 0;
int fullBlobX60 = 0; int fullBlobX61 = 0; int fullBlobX62 = 0; int fullBlobX63 = 0;

int fullBlobZ0  = 0; int fullBlobZ1  = 0; int fullBlobZ2  = 0; int fullBlobZ3  = 0;
int fullBlobZ4  = 0; int fullBlobZ5  = 0; int fullBlobZ6  = 0; int fullBlobZ7  = 0;
int fullBlobZ8  = 0; int fullBlobZ9  = 0; int fullBlobZ10 = 0; int fullBlobZ11 = 0;
int fullBlobZ12 = 0; int fullBlobZ13 = 0; int fullBlobZ14 = 0; int fullBlobZ15 = 0;
int fullBlobZ16 = 0; int fullBlobZ17 = 0; int fullBlobZ18 = 0; int fullBlobZ19 = 0;
int fullBlobZ20 = 0; int fullBlobZ21 = 0; int fullBlobZ22 = 0; int fullBlobZ23 = 0;
int fullBlobZ24 = 0; int fullBlobZ25 = 0; int fullBlobZ26 = 0; int fullBlobZ27 = 0;
int fullBlobZ28 = 0; int fullBlobZ29 = 0; int fullBlobZ30 = 0; int fullBlobZ31 = 0;
int fullBlobZ32 = 0; int fullBlobZ33 = 0; int fullBlobZ34 = 0; int fullBlobZ35 = 0;
int fullBlobZ36 = 0; int fullBlobZ37 = 0; int fullBlobZ38 = 0; int fullBlobZ39 = 0;
int fullBlobZ40 = 0; int fullBlobZ41 = 0; int fullBlobZ42 = 0; int fullBlobZ43 = 0;
int fullBlobZ44 = 0; int fullBlobZ45 = 0; int fullBlobZ46 = 0; int fullBlobZ47 = 0;
int fullBlobZ48 = 0; int fullBlobZ49 = 0; int fullBlobZ50 = 0; int fullBlobZ51 = 0;
int fullBlobZ52 = 0; int fullBlobZ53 = 0; int fullBlobZ54 = 0; int fullBlobZ55 = 0;
int fullBlobZ56 = 0; int fullBlobZ57 = 0; int fullBlobZ58 = 0; int fullBlobZ59 = 0;
int fullBlobZ60 = 0; int fullBlobZ61 = 0; int fullBlobZ62 = 0; int fullBlobZ63 = 0;

/*
** Adds a blob to the list of full blobs.
** The ID parameter should not be set unless you keep track of which blobs are set (note how fullBlobsCount is only incremented on id == -1).
**
** @param x: x coordinate on the grid
** @param z: z coordinate on the grid
** @param id: ID of the blob to be added
*/
void setFullBlob(int x = -1, int z = -1, int id = -1) {
	if(id == -1) {
		// If the ID is not specified, set state for next free blob.
		id = fullBlobsCount;

		// Since we don't overwrite an existing blob, increase the number of full blobs.
		fullBlobsCount++;
	}

	if(id == 0)  { fullBlobX0  = x; fullBlobZ0  = z; return; } if(id == 1)  { fullBlobX1  = x; fullBlobZ1  = z; return; }
	if(id == 2)  { fullBlobX2  = x; fullBlobZ2  = z; return; } if(id == 3)  { fullBlobX3  = x; fullBlobZ3  = z; return; }
	if(id == 4)  { fullBlobX4  = x; fullBlobZ4  = z; return; } if(id == 5)  { fullBlobX5  = x; fullBlobZ5  = z; return; }
	if(id == 6)  { fullBlobX6  = x; fullBlobZ6  = z; return; } if(id == 7)  { fullBlobX7  = x; fullBlobZ7  = z; return; }
	if(id == 8)  { fullBlobX8  = x; fullBlobZ8  = z; return; } if(id == 9)  { fullBlobX9  = x; fullBlobZ9  = z; return; }
	if(id == 10) { fullBlobX10 = x; fullBlobZ10 = z; return; } if(id == 11) { fullBlobX11 = x; fullBlobZ11 = z; return; }
	if(id == 12) { fullBlobX12 = x; fullBlobZ12 = z; return; } if(id == 13) { fullBlobX13 = x; fullBlobZ13 = z; return; }
	if(id == 14) { fullBlobX14 = x; fullBlobZ14 = z; return; } if(id == 15) { fullBlobX15 = x; fullBlobZ15 = z; return; }
	if(id == 16) { fullBlobX16 = x; fullBlobZ16 = z; return; } if(id == 17) { fullBlobX17 = x; fullBlobZ17 = z; return; }
	if(id == 18) { fullBlobX18 = x; fullBlobZ18 = z; return; } if(id == 19) { fullBlobX19 = x; fullBlobZ19 = z; return; }
	if(id == 20) { fullBlobX20 = x; fullBlobZ20 = z; return; } if(id == 21) { fullBlobX21 = x; fullBlobZ21 = z; return; }
	if(id == 22) { fullBlobX22 = x; fullBlobZ22 = z; return; } if(id == 23) { fullBlobX23 = x; fullBlobZ23 = z; return; }
	if(id == 24) { fullBlobX24 = x; fullBlobZ24 = z; return; } if(id == 25) { fullBlobX25 = x; fullBlobZ25 = z; return; }
	if(id == 26) { fullBlobX26 = x; fullBlobZ26 = z; return; } if(id == 27) { fullBlobX27 = x; fullBlobZ27 = z; return; }
	if(id == 28) { fullBlobX28 = x; fullBlobZ28 = z; return; } if(id == 29) { fullBlobX29 = x; fullBlobZ29 = z; return; }
	if(id == 30) { fullBlobX30 = x; fullBlobZ30 = z; return; } if(id == 31) { fullBlobX31 = x; fullBlobZ31 = z; return; }
	if(id == 32) { fullBlobX32 = x; fullBlobZ32 = z; return; } if(id == 33) { fullBlobX33 = x; fullBlobZ33 = z; return; }
	if(id == 34) { fullBlobX34 = x; fullBlobZ34 = z; return; } if(id == 35) { fullBlobX35 = x; fullBlobZ35 = z; return; }
	if(id == 36) { fullBlobX36 = x; fullBlobZ36 = z; return; } if(id == 37) { fullBlobX37 = x; fullBlobZ37 = z; return; }
	if(id == 38) { fullBlobX38 = x; fullBlobZ38 = z; return; } if(id == 39) { fullBlobX39 = x; fullBlobZ39 = z; return; }
	if(id == 40) { fullBlobX40 = x; fullBlobZ40 = z; return; } if(id == 41) { fullBlobX41 = x; fullBlobZ41 = z; return; }
	if(id == 42) { fullBlobX42 = x; fullBlobZ42 = z; return; } if(id == 43) { fullBlobX43 = x; fullBlobZ43 = z; return; }
	if(id == 44) { fullBlobX44 = x; fullBlobZ44 = z; return; } if(id == 45) { fullBlobX45 = x; fullBlobZ45 = z; return; }
	if(id == 46) { fullBlobX46 = x; fullBlobZ46 = z; return; } if(id == 47) { fullBlobX47 = x; fullBlobZ47 = z; return; }
	if(id == 48) { fullBlobX48 = x; fullBlobZ48 = z; return; } if(id == 49) { fullBlobX49 = x; fullBlobZ49 = z; return; }
	if(id == 50) { fullBlobX50 = x; fullBlobZ50 = z; return; } if(id == 51) { fullBlobX51 = x; fullBlobZ51 = z; return; }
	if(id == 52) { fullBlobX52 = x; fullBlobZ52 = z; return; } if(id == 53) { fullBlobX53 = x; fullBlobZ53 = z; return; }
	if(id == 54) { fullBlobX54 = x; fullBlobZ54 = z; return; } if(id == 55) { fullBlobX55 = x; fullBlobZ55 = z; return; }
	if(id == 56) { fullBlobX56 = x; fullBlobZ56 = z; return; } if(id == 57) { fullBlobX57 = x; fullBlobZ57 = z; return; }
	if(id == 58) { fullBlobX58 = x; fullBlobZ58 = z; return; } if(id == 59) { fullBlobX59 = x; fullBlobZ59 = z; return; }
	if(id == 60) { fullBlobX60 = x; fullBlobZ60 = z; return; } if(id == 61) { fullBlobX61 = x; fullBlobZ61 = z; return; }
	if(id == 62) { fullBlobX62 = x; fullBlobZ62 = z; return; } if(id == 63) { fullBlobX63 = x; fullBlobZ63 = z; return; }
}

/*
** Gets the x coordinate of a blob in the list of full blobs.
**
** @param id: ID of the blob
**
** @returns: the x coordinate of the blob
*/
int getFullBlobX(int id = -1) {
	if(id == 0)  return(fullBlobX0);  if(id == 1)  return(fullBlobX1);  if(id == 2)  return(fullBlobX2);  if(id == 3)  return(fullBlobX3);
	if(id == 4)  return(fullBlobX4);  if(id == 5)  return(fullBlobX5);  if(id == 6)  return(fullBlobX6);  if(id == 7)  return(fullBlobX7);
	if(id == 8)  return(fullBlobX8);  if(id == 9)  return(fullBlobX9);  if(id == 10) return(fullBlobX10); if(id == 11) return(fullBlobX11);
	if(id == 12) return(fullBlobX12); if(id == 13) return(fullBlobX13); if(id == 14) return(fullBlobX14); if(id == 15) return(fullBlobX15);
	if(id == 16) return(fullBlobX16); if(id == 17) return(fullBlobX17); if(id == 18) return(fullBlobX18); if(id == 19) return(fullBlobX19);
	if(id == 20) return(fullBlobX20); if(id == 21) return(fullBlobX21); if(id == 22) return(fullBlobX22); if(id == 23) return(fullBlobX23);
	if(id == 24) return(fullBlobX24); if(id == 25) return(fullBlobX25); if(id == 26) return(fullBlobX26); if(id == 27) return(fullBlobX27);
	if(id == 28) return(fullBlobX28); if(id == 29) return(fullBlobX29); if(id == 30) return(fullBlobX30); if(id == 31) return(fullBlobX31);
	if(id == 32) return(fullBlobX32); if(id == 33) return(fullBlobX33); if(id == 34) return(fullBlobX34); if(id == 35) return(fullBlobX35);
	if(id == 36) return(fullBlobX36); if(id == 37) return(fullBlobX37); if(id == 38) return(fullBlobX38); if(id == 39) return(fullBlobX39);
	if(id == 40) return(fullBlobX40); if(id == 41) return(fullBlobX41); if(id == 42) return(fullBlobX42); if(id == 43) return(fullBlobX43);
	if(id == 44) return(fullBlobX44); if(id == 45) return(fullBlobX45); if(id == 46) return(fullBlobX46); if(id == 47) return(fullBlobX47);
	if(id == 48) return(fullBlobX48); if(id == 49) return(fullBlobX49); if(id == 50) return(fullBlobX50); if(id == 51) return(fullBlobX51);
	if(id == 52) return(fullBlobX52); if(id == 53) return(fullBlobX53); if(id == 54) return(fullBlobX54); if(id == 55) return(fullBlobX55);
	if(id == 56) return(fullBlobX56); if(id == 57) return(fullBlobX57); if(id == 58) return(fullBlobX58); if(id == 59) return(fullBlobX59);
	if(id == 60) return(fullBlobX60); if(id == 61) return(fullBlobX61); if(id == 62) return(fullBlobX62); if(id == 63) return(fullBlobX63);

	return(0);
}

/*
** Gets the z coordinate of a blob in the list of full blobs.
**
** @param id: ID of the blob
**
** @returns: the z coordinate of the blob
*/
int getFullBlobZ(int id = -1) {
	if(id == 0)  return(fullBlobZ0);  if(id == 1)  return(fullBlobZ1);  if(id == 2)  return(fullBlobZ2);  if(id == 3)  return(fullBlobZ3);
	if(id == 4)  return(fullBlobZ4);  if(id == 5)  return(fullBlobZ5);  if(id == 6)  return(fullBlobZ6);  if(id == 7)  return(fullBlobZ7);
	if(id == 8)  return(fullBlobZ8);  if(id == 9)  return(fullBlobZ9);  if(id == 10) return(fullBlobZ10); if(id == 11) return(fullBlobZ11);
	if(id == 12) return(fullBlobZ12); if(id == 13) return(fullBlobZ13); if(id == 14) return(fullBlobZ14); if(id == 15) return(fullBlobZ15);
	if(id == 16) return(fullBlobZ16); if(id == 17) return(fullBlobZ17); if(id == 18) return(fullBlobZ18); if(id == 19) return(fullBlobZ19);
	if(id == 20) return(fullBlobZ20); if(id == 21) return(fullBlobZ21); if(id == 22) return(fullBlobZ22); if(id == 23) return(fullBlobZ23);
	if(id == 24) return(fullBlobZ24); if(id == 25) return(fullBlobZ25); if(id == 26) return(fullBlobZ26); if(id == 27) return(fullBlobZ27);
	if(id == 28) return(fullBlobZ28); if(id == 29) return(fullBlobZ29); if(id == 30) return(fullBlobZ30); if(id == 31) return(fullBlobZ31);
	if(id == 32) return(fullBlobZ32); if(id == 33) return(fullBlobZ33); if(id == 34) return(fullBlobZ34); if(id == 35) return(fullBlobZ35);
	if(id == 36) return(fullBlobZ36); if(id == 37) return(fullBlobZ37); if(id == 38) return(fullBlobZ38); if(id == 39) return(fullBlobZ39);
	if(id == 40) return(fullBlobZ40); if(id == 41) return(fullBlobZ41); if(id == 42) return(fullBlobZ42); if(id == 43) return(fullBlobZ43);
	if(id == 44) return(fullBlobZ44); if(id == 45) return(fullBlobZ45); if(id == 46) return(fullBlobZ46); if(id == 47) return(fullBlobZ47);
	if(id == 48) return(fullBlobZ48); if(id == 49) return(fullBlobZ49); if(id == 50) return(fullBlobZ50); if(id == 51) return(fullBlobZ51);
	if(id == 52) return(fullBlobZ52); if(id == 53) return(fullBlobZ53); if(id == 54) return(fullBlobZ54); if(id == 55) return(fullBlobZ55);
	if(id == 56) return(fullBlobZ56); if(id == 57) return(fullBlobZ57); if(id == 58) return(fullBlobZ58); if(id == 59) return(fullBlobZ59);
	if(id == 60) return(fullBlobZ60); if(id == 61) return(fullBlobZ61); if(id == 62) return(fullBlobZ62); if(id == 63) return(fullBlobZ63);

	return(0);
}

/*
** Searches the list of full blobs for the ID of a blob with given coordinates.
**
** @param x: x coordinate on the grid
** @param z: z coordinate on the grid
**
** @returns: the ID of the blob
*/
int findFullBlob(int x = -1, int z = -1) {
	if(fullBlobX0  == x && fullBlobZ0  == z) return(0);  if(fullBlobX1  == x && fullBlobZ1 ==  z) return(1);
	if(fullBlobX2  == x && fullBlobZ2  == z) return(2);  if(fullBlobX3  == x && fullBlobZ3 ==  z) return(3);
	if(fullBlobX4  == x && fullBlobZ4  == z) return(4);  if(fullBlobX5  == x && fullBlobZ5 ==  z) return(5);
	if(fullBlobX6  == x && fullBlobZ6  == z) return(6);  if(fullBlobX7  == x && fullBlobZ7 ==  z) return(7);
	if(fullBlobX8  == x && fullBlobZ8  == z) return(8);  if(fullBlobX9  == x && fullBlobZ9 ==  z) return(9);
	if(fullBlobX10 == x && fullBlobZ10 == z) return(10); if(fullBlobX11 == x && fullBlobZ11 == z) return(11);
	if(fullBlobX12 == x && fullBlobZ12 == z) return(12); if(fullBlobX13 == x && fullBlobZ13 == z) return(13);
	if(fullBlobX14 == x && fullBlobZ14 == z) return(14); if(fullBlobX15 == x && fullBlobZ15 == z) return(15);
	if(fullBlobX16 == x && fullBlobZ16 == z) return(16); if(fullBlobX17 == x && fullBlobZ17 == z) return(17);
	if(fullBlobX18 == x && fullBlobZ18 == z) return(18); if(fullBlobX19 == x && fullBlobZ19 == z) return(19);
	if(fullBlobX20 == x && fullBlobZ20 == z) return(20); if(fullBlobX21 == x && fullBlobZ21 == z) return(21);
	if(fullBlobX22 == x && fullBlobZ22 == z) return(22); if(fullBlobX23 == x && fullBlobZ23 == z) return(23);
	if(fullBlobX24 == x && fullBlobZ24 == z) return(24); if(fullBlobX25 == x && fullBlobZ25 == z) return(25);
	if(fullBlobX26 == x && fullBlobZ26 == z) return(26); if(fullBlobX27 == x && fullBlobZ27 == z) return(27);
	if(fullBlobX28 == x && fullBlobZ28 == z) return(28); if(fullBlobX29 == x && fullBlobZ29 == z) return(29);
	if(fullBlobX30 == x && fullBlobZ30 == z) return(30); if(fullBlobX31 == x && fullBlobZ31 == z) return(31);
	if(fullBlobX32 == x && fullBlobZ32 == z) return(32); if(fullBlobX33 == x && fullBlobZ33 == z) return(33);
	if(fullBlobX34 == x && fullBlobZ34 == z) return(34); if(fullBlobX35 == x && fullBlobZ35 == z) return(35);
	if(fullBlobX36 == x && fullBlobZ36 == z) return(36); if(fullBlobX37 == x && fullBlobZ37 == z) return(37);
	if(fullBlobX38 == x && fullBlobZ38 == z) return(38); if(fullBlobX39 == x && fullBlobZ39 == z) return(39);
	if(fullBlobX40 == x && fullBlobZ40 == z) return(40); if(fullBlobX41 == x && fullBlobZ41 == z) return(41);
	if(fullBlobX42 == x && fullBlobZ42 == z) return(42); if(fullBlobX43 == x && fullBlobZ43 == z) return(43);
	if(fullBlobX44 == x && fullBlobZ44 == z) return(44); if(fullBlobX45 == x && fullBlobZ45 == z) return(45);
	if(fullBlobX46 == x && fullBlobZ46 == z) return(46); if(fullBlobX47 == x && fullBlobZ47 == z) return(47);
	if(fullBlobX48 == x && fullBlobZ48 == z) return(48); if(fullBlobX49 == x && fullBlobZ49 == z) return(49);
	if(fullBlobX50 == x && fullBlobZ50 == z) return(50); if(fullBlobX51 == x && fullBlobZ51 == z) return(51);
	if(fullBlobX52 == x && fullBlobZ52 == z) return(52); if(fullBlobX53 == x && fullBlobZ53 == z) return(53);
	if(fullBlobX54 == x && fullBlobZ54 == z) return(54); if(fullBlobX55 == x && fullBlobZ55 == z) return(55);
	if(fullBlobX56 == x && fullBlobZ56 == z) return(56); if(fullBlobX57 == x && fullBlobZ57 == z) return(57);
	if(fullBlobX58 == x && fullBlobZ58 == z) return(58); if(fullBlobX59 == x && fullBlobZ59 == z) return(59);
	if(fullBlobX60 == x && fullBlobZ60 == z) return(60); if(fullBlobX61 == x && fullBlobZ61 == z) return(61);
	if(fullBlobX62 == x && fullBlobZ62 == z) return(62); if(fullBlobX63 == x && fullBlobZ63 == z) return(63);

	return (-1);
}

/*
** Removes a full blob from the list of full blobs.
**
** @param id: the ID of the blob to be removed
*/
void removeFullBlob(int id = -1) {
	if(id == -1 || fullBlobsCount == 0) {
		return;
	}

	fullBlobsCount--;

	// Shift entries in the array to maintain contiguousness.
	for(i = id; < fullBlobsCount) {
		setFullBlob(getFullBlobX(i + 1), getFullBlobZ(i + 1), i);
	}
}

/*************
* NEAR BLOBS *
*************/

int nearBlobsCount = 0;

int nearBlobX0  = 0; int nearBlobX1  = 0; int nearBlobX2  = 0; int nearBlobX3  = 0;
int nearBlobX4  = 0; int nearBlobX5  = 0; int nearBlobX6  = 0; int nearBlobX7  = 0;
int nearBlobX8  = 0; int nearBlobX9  = 0; int nearBlobX10 = 0; int nearBlobX11 = 0;
int nearBlobX12 = 0; int nearBlobX13 = 0; int nearBlobX14 = 0; int nearBlobX15 = 0;
int nearBlobX16 = 0; int nearBlobX17 = 0; int nearBlobX18 = 0; int nearBlobX19 = 0;
int nearBlobX20 = 0; int nearBlobX21 = 0; int nearBlobX22 = 0; int nearBlobX23 = 0;
int nearBlobX24 = 0; int nearBlobX25 = 0; int nearBlobX26 = 0; int nearBlobX27 = 0;
int nearBlobX28 = 0; int nearBlobX29 = 0; int nearBlobX30 = 0; int nearBlobX31 = 0;
int nearBlobX32 = 0; int nearBlobX33 = 0; int nearBlobX34 = 0; int nearBlobX35 = 0;
int nearBlobX36 = 0; int nearBlobX37 = 0; int nearBlobX38 = 0; int nearBlobX39 = 0;
int nearBlobX40 = 0; int nearBlobX41 = 0; int nearBlobX42 = 0; int nearBlobX43 = 0;
int nearBlobX44 = 0; int nearBlobX45 = 0; int nearBlobX46 = 0; int nearBlobX47 = 0;
int nearBlobX48 = 0; int nearBlobX49 = 0; int nearBlobX50 = 0; int nearBlobX51 = 0;
int nearBlobX52 = 0; int nearBlobX53 = 0; int nearBlobX54 = 0; int nearBlobX55 = 0;
int nearBlobX56 = 0; int nearBlobX57 = 0; int nearBlobX58 = 0; int nearBlobX59 = 0;
int nearBlobX60 = 0; int nearBlobX61 = 0; int nearBlobX62 = 0; int nearBlobX63 = 0;

int nearBlobZ0  = 0; int nearBlobZ1  = 0; int nearBlobZ2  = 0; int nearBlobZ3  = 0;
int nearBlobZ4  = 0; int nearBlobZ5  = 0; int nearBlobZ6  = 0; int nearBlobZ7  = 0;
int nearBlobZ8  = 0; int nearBlobZ9  = 0; int nearBlobZ10 = 0; int nearBlobZ11 = 0;
int nearBlobZ12 = 0; int nearBlobZ13 = 0; int nearBlobZ14 = 0; int nearBlobZ15 = 0;
int nearBlobZ16 = 0; int nearBlobZ17 = 0; int nearBlobZ18 = 0; int nearBlobZ19 = 0;
int nearBlobZ20 = 0; int nearBlobZ21 = 0; int nearBlobZ22 = 0; int nearBlobZ23 = 0;
int nearBlobZ24 = 0; int nearBlobZ25 = 0; int nearBlobZ26 = 0; int nearBlobZ27 = 0;
int nearBlobZ28 = 0; int nearBlobZ29 = 0; int nearBlobZ30 = 0; int nearBlobZ31 = 0;
int nearBlobZ32 = 0; int nearBlobZ33 = 0; int nearBlobZ34 = 0; int nearBlobZ35 = 0;
int nearBlobZ36 = 0; int nearBlobZ37 = 0; int nearBlobZ38 = 0; int nearBlobZ39 = 0;
int nearBlobZ40 = 0; int nearBlobZ41 = 0; int nearBlobZ42 = 0; int nearBlobZ43 = 0;
int nearBlobZ44 = 0; int nearBlobZ45 = 0; int nearBlobZ46 = 0; int nearBlobZ47 = 0;
int nearBlobZ48 = 0; int nearBlobZ49 = 0; int nearBlobZ50 = 0; int nearBlobZ51 = 0;
int nearBlobZ52 = 0; int nearBlobZ53 = 0; int nearBlobZ54 = 0; int nearBlobZ55 = 0;
int nearBlobZ56 = 0; int nearBlobZ57 = 0; int nearBlobZ58 = 0; int nearBlobZ59 = 0;
int nearBlobZ60 = 0; int nearBlobZ61 = 0; int nearBlobZ62 = 0; int nearBlobZ63 = 0;

/*
** Adds a blob to the list of near blobs.
** The ID parameter should not be set unless you keep track of which blobs are set (note how fullBlobsCount is only incremented on id == -1).
**
** @param x: x coordinate on the grid
** @param z: z coordinate on the grid
** @param id: ID of the blob to be added
*/
void setNearBlob(int x = -1, int z = -1, int id = -1) {
	if(id == -1) {
		// If the ID is not specified, set state for next free blob.
		id = nearBlobsCount;

		// Since we don't overwrite an existing blob, increase the number of full blobs.
		nearBlobsCount++;
	}

	if(id == 0)  { nearBlobX0  = x; nearBlobZ0  = z; return; } if(id == 1)  { nearBlobX1  = x; nearBlobZ1  = z; return; }
	if(id == 2)  { nearBlobX2  = x; nearBlobZ2  = z; return; } if(id == 3)  { nearBlobX3  = x; nearBlobZ3  = z; return; }
	if(id == 4)  { nearBlobX4  = x; nearBlobZ4  = z; return; } if(id == 5)  { nearBlobX5  = x; nearBlobZ5  = z; return; }
	if(id == 6)  { nearBlobX6  = x; nearBlobZ6  = z; return; } if(id == 7)  { nearBlobX7  = x; nearBlobZ7  = z; return; }
	if(id == 8)  { nearBlobX8  = x; nearBlobZ8  = z; return; } if(id == 9)  { nearBlobX9  = x; nearBlobZ9  = z; return; }
	if(id == 10) { nearBlobX10 = x; nearBlobZ10 = z; return; } if(id == 11) { nearBlobX11 = x; nearBlobZ11 = z; return; }
	if(id == 12) { nearBlobX12 = x; nearBlobZ12 = z; return; } if(id == 13) { nearBlobX13 = x; nearBlobZ13 = z; return; }
	if(id == 14) { nearBlobX14 = x; nearBlobZ14 = z; return; } if(id == 15) { nearBlobX15 = x; nearBlobZ15 = z; return; }
	if(id == 16) { nearBlobX16 = x; nearBlobZ16 = z; return; } if(id == 17) { nearBlobX17 = x; nearBlobZ17 = z; return; }
	if(id == 18) { nearBlobX18 = x; nearBlobZ18 = z; return; } if(id == 19) { nearBlobX19 = x; nearBlobZ19 = z; return; }
	if(id == 20) { nearBlobX20 = x; nearBlobZ20 = z; return; } if(id == 21) { nearBlobX21 = x; nearBlobZ21 = z; return; }
	if(id == 22) { nearBlobX22 = x; nearBlobZ22 = z; return; } if(id == 23) { nearBlobX23 = x; nearBlobZ23 = z; return; }
	if(id == 24) { nearBlobX24 = x; nearBlobZ24 = z; return; } if(id == 25) { nearBlobX25 = x; nearBlobZ25 = z; return; }
	if(id == 26) { nearBlobX26 = x; nearBlobZ26 = z; return; } if(id == 27) { nearBlobX27 = x; nearBlobZ27 = z; return; }
	if(id == 28) { nearBlobX28 = x; nearBlobZ28 = z; return; } if(id == 29) { nearBlobX29 = x; nearBlobZ29 = z; return; }
	if(id == 30) { nearBlobX30 = x; nearBlobZ30 = z; return; } if(id == 31) { nearBlobX31 = x; nearBlobZ31 = z; return; }
	if(id == 32) { nearBlobX32 = x; nearBlobZ32 = z; return; } if(id == 33) { nearBlobX33 = x; nearBlobZ33 = z; return; }
	if(id == 34) { nearBlobX34 = x; nearBlobZ34 = z; return; } if(id == 35) { nearBlobX35 = x; nearBlobZ35 = z; return; }
	if(id == 36) { nearBlobX36 = x; nearBlobZ36 = z; return; } if(id == 37) { nearBlobX37 = x; nearBlobZ37 = z; return; }
	if(id == 38) { nearBlobX38 = x; nearBlobZ38 = z; return; } if(id == 39) { nearBlobX39 = x; nearBlobZ39 = z; return; }
	if(id == 40) { nearBlobX40 = x; nearBlobZ40 = z; return; } if(id == 41) { nearBlobX41 = x; nearBlobZ41 = z; return; }
	if(id == 42) { nearBlobX42 = x; nearBlobZ42 = z; return; } if(id == 43) { nearBlobX43 = x; nearBlobZ43 = z; return; }
	if(id == 44) { nearBlobX44 = x; nearBlobZ44 = z; return; } if(id == 45) { nearBlobX45 = x; nearBlobZ45 = z; return; }
	if(id == 46) { nearBlobX46 = x; nearBlobZ46 = z; return; } if(id == 47) { nearBlobX47 = x; nearBlobZ47 = z; return; }
	if(id == 48) { nearBlobX48 = x; nearBlobZ48 = z; return; } if(id == 49) { nearBlobX49 = x; nearBlobZ49 = z; return; }
	if(id == 50) { nearBlobX50 = x; nearBlobZ50 = z; return; } if(id == 51) { nearBlobX51 = x; nearBlobZ51 = z; return; }
	if(id == 52) { nearBlobX52 = x; nearBlobZ52 = z; return; } if(id == 53) { nearBlobX53 = x; nearBlobZ53 = z; return; }
	if(id == 54) { nearBlobX54 = x; nearBlobZ54 = z; return; } if(id == 55) { nearBlobX55 = x; nearBlobZ55 = z; return; }
	if(id == 56) { nearBlobX56 = x; nearBlobZ56 = z; return; } if(id == 57) { nearBlobX57 = x; nearBlobZ57 = z; return; }
	if(id == 58) { nearBlobX58 = x; nearBlobZ58 = z; return; } if(id == 59) { nearBlobX59 = x; nearBlobZ59 = z; return; }
	if(id == 60) { nearBlobX60 = x; nearBlobZ60 = z; return; } if(id == 61) { nearBlobX61 = x; nearBlobZ61 = z; return; }
	if(id == 62) { nearBlobX62 = x; nearBlobZ62 = z; return; } if(id == 63) { nearBlobX63 = x; nearBlobZ63 = z; return; }
}

/*
** Gets the x coordinate of a blob in the list of near blobs.
**
** @param id: ID of the blob
**
** @returns: the x coordinate of the blob
*/
int getNearBlobX(int id = -1) {
	if(id == 0)  return(nearBlobX0);  if(id == 1)  return(nearBlobX1);  if(id == 2)  return(nearBlobX2);  if(id == 3)  return(nearBlobX3);
	if(id == 4)  return(nearBlobX4);  if(id == 5)  return(nearBlobX5);  if(id == 6)  return(nearBlobX6);  if(id == 7)  return(nearBlobX7);
	if(id == 8)  return(nearBlobX8);  if(id == 9)  return(nearBlobX9);  if(id == 10) return(nearBlobX10); if(id == 11) return(nearBlobX11);
	if(id == 12) return(nearBlobX12); if(id == 13) return(nearBlobX13); if(id == 14) return(nearBlobX14); if(id == 15) return(nearBlobX15);
	if(id == 16) return(nearBlobX16); if(id == 17) return(nearBlobX17); if(id == 18) return(nearBlobX18); if(id == 19) return(nearBlobX19);
	if(id == 20) return(nearBlobX20); if(id == 21) return(nearBlobX21); if(id == 22) return(nearBlobX22); if(id == 23) return(nearBlobX23);
	if(id == 24) return(nearBlobX24); if(id == 25) return(nearBlobX25); if(id == 26) return(nearBlobX26); if(id == 27) return(nearBlobX27);
	if(id == 28) return(nearBlobX28); if(id == 29) return(nearBlobX29); if(id == 30) return(nearBlobX30); if(id == 31) return(nearBlobX31);
	if(id == 32) return(nearBlobX32); if(id == 33) return(nearBlobX33); if(id == 34) return(nearBlobX34); if(id == 35) return(nearBlobX35);
	if(id == 36) return(nearBlobX36); if(id == 37) return(nearBlobX37); if(id == 38) return(nearBlobX38); if(id == 39) return(nearBlobX39);
	if(id == 40) return(nearBlobX40); if(id == 41) return(nearBlobX41); if(id == 42) return(nearBlobX42); if(id == 43) return(nearBlobX43);
	if(id == 44) return(nearBlobX44); if(id == 45) return(nearBlobX45); if(id == 46) return(nearBlobX46); if(id == 47) return(nearBlobX47);
	if(id == 48) return(nearBlobX48); if(id == 49) return(nearBlobX49); if(id == 50) return(nearBlobX50); if(id == 51) return(nearBlobX51);
	if(id == 52) return(nearBlobX52); if(id == 53) return(nearBlobX53); if(id == 54) return(nearBlobX54); if(id == 55) return(nearBlobX55);
	if(id == 56) return(nearBlobX56); if(id == 57) return(nearBlobX57); if(id == 58) return(nearBlobX58); if(id == 59) return(nearBlobX59);
	if(id == 60) return(nearBlobX60); if(id == 61) return(nearBlobX61); if(id == 62) return(nearBlobX62); if(id == 63) return(nearBlobX63);

	return(0);
}

/*
** Gets the z coordinate of a blob in the list of near blobs.
**
** @param id: ID of the blob
**
** @returns: the z coordinate of the blob
*/
int getNearBlobZ(int id = -1) {
	if(id == 0)  return(nearBlobZ0);  if(id == 1)  return(nearBlobZ1);  if(id == 2)  return(nearBlobZ2);  if(id == 3)  return(nearBlobZ3);
	if(id == 4)  return(nearBlobZ4);  if(id == 5)  return(nearBlobZ5);  if(id == 6)  return(nearBlobZ6);  if(id == 7)  return(nearBlobZ7);
	if(id == 8)  return(nearBlobZ8);  if(id == 9)  return(nearBlobZ9);  if(id == 10) return(nearBlobZ10); if(id == 11) return(nearBlobZ11);
	if(id == 12) return(nearBlobZ12); if(id == 13) return(nearBlobZ13); if(id == 14) return(nearBlobZ14); if(id == 15) return(nearBlobZ15);
	if(id == 16) return(nearBlobZ16); if(id == 17) return(nearBlobZ17); if(id == 18) return(nearBlobZ18); if(id == 19) return(nearBlobZ19);
	if(id == 20) return(nearBlobZ20); if(id == 21) return(nearBlobZ21); if(id == 22) return(nearBlobZ22); if(id == 23) return(nearBlobZ23);
	if(id == 24) return(nearBlobZ24); if(id == 25) return(nearBlobZ25); if(id == 26) return(nearBlobZ26); if(id == 27) return(nearBlobZ27);
	if(id == 28) return(nearBlobZ28); if(id == 29) return(nearBlobZ29); if(id == 30) return(nearBlobZ30); if(id == 31) return(nearBlobZ31);
	if(id == 32) return(nearBlobZ32); if(id == 33) return(nearBlobZ33); if(id == 34) return(nearBlobZ34); if(id == 35) return(nearBlobZ35);
	if(id == 36) return(nearBlobZ36); if(id == 37) return(nearBlobZ37); if(id == 38) return(nearBlobZ38); if(id == 39) return(nearBlobZ39);
	if(id == 40) return(nearBlobZ40); if(id == 41) return(nearBlobZ41); if(id == 42) return(nearBlobZ42); if(id == 43) return(nearBlobZ43);
	if(id == 44) return(nearBlobZ44); if(id == 45) return(nearBlobZ45); if(id == 46) return(nearBlobZ46); if(id == 47) return(nearBlobZ47);
	if(id == 48) return(nearBlobZ48); if(id == 49) return(nearBlobZ49); if(id == 50) return(nearBlobZ50); if(id == 51) return(nearBlobZ51);
	if(id == 52) return(nearBlobZ52); if(id == 53) return(nearBlobZ53); if(id == 54) return(nearBlobZ54); if(id == 55) return(nearBlobZ55);
	if(id == 56) return(nearBlobZ56); if(id == 57) return(nearBlobZ57); if(id == 58) return(nearBlobZ58); if(id == 59) return(nearBlobZ59);
	if(id == 60) return(nearBlobZ60); if(id == 61) return(nearBlobZ61); if(id == 62) return(nearBlobZ62); if(id == 63) return(nearBlobZ63);

	return(0);
}

/*
** Searches the list of near blobs for the ID of a blob with given coordinates.
**
** @param x: x coordinate on the grid
** @param z: z coordinate on the grid
**
** @returns: the ID of the blob
*/
int findNearBlob(int x = -1, int z = -1) {
	if(nearBlobX0  == x && nearBlobZ0  == z) return(0);  if(nearBlobX1  == x && nearBlobZ1  == z) return(1);
	if(nearBlobX2  == x && nearBlobZ2  == z) return(2);  if(nearBlobX3  == x && nearBlobZ3  == z) return(3);
	if(nearBlobX4  == x && nearBlobZ4  == z) return(4);  if(nearBlobX5  == x && nearBlobZ5  == z) return(5);
	if(nearBlobX6  == x && nearBlobZ6  == z) return(6);  if(nearBlobX7  == x && nearBlobZ7  == z) return(7);
	if(nearBlobX8  == x && nearBlobZ8  == z) return(8);  if(nearBlobX9  == x && nearBlobZ9  == z) return(9);
	if(nearBlobX10 == x && nearBlobZ10 == z) return(10); if(nearBlobX11 == x && nearBlobZ11 == z) return(11);
	if(nearBlobX12 == x && nearBlobZ12 == z) return(12); if(nearBlobX13 == x && nearBlobZ13 == z) return(13);
	if(nearBlobX14 == x && nearBlobZ14 == z) return(14); if(nearBlobX15 == x && nearBlobZ15 == z) return(15);
	if(nearBlobX16 == x && nearBlobZ16 == z) return(16); if(nearBlobX17 == x && nearBlobZ17 == z) return(17);
	if(nearBlobX18 == x && nearBlobZ18 == z) return(18); if(nearBlobX19 == x && nearBlobZ19 == z) return(19);
	if(nearBlobX20 == x && nearBlobZ20 == z) return(20); if(nearBlobX21 == x && nearBlobZ21 == z) return(21);
	if(nearBlobX22 == x && nearBlobZ22 == z) return(22); if(nearBlobX23 == x && nearBlobZ23 == z) return(23);
	if(nearBlobX24 == x && nearBlobZ24 == z) return(24); if(nearBlobX25 == x && nearBlobZ25 == z) return(25);
	if(nearBlobX26 == x && nearBlobZ26 == z) return(26); if(nearBlobX27 == x && nearBlobZ27 == z) return(27);
	if(nearBlobX28 == x && nearBlobZ28 == z) return(28); if(nearBlobX29 == x && nearBlobZ29 == z) return(29);
	if(nearBlobX30 == x && nearBlobZ30 == z) return(30); if(nearBlobX31 == x && nearBlobZ31 == z) return(31);
	if(nearBlobX32 == x && nearBlobZ32 == z) return(32); if(nearBlobX33 == x && nearBlobZ33 == z) return(33);
	if(nearBlobX34 == x && nearBlobZ34 == z) return(34); if(nearBlobX35 == x && nearBlobZ35 == z) return(35);
	if(nearBlobX36 == x && nearBlobZ36 == z) return(36); if(nearBlobX37 == x && nearBlobZ37 == z) return(37);
	if(nearBlobX38 == x && nearBlobZ38 == z) return(38); if(nearBlobX39 == x && nearBlobZ39 == z) return(39);
	if(nearBlobX40 == x && nearBlobZ40 == z) return(40); if(nearBlobX41 == x && nearBlobZ41 == z) return(41);
	if(nearBlobX42 == x && nearBlobZ42 == z) return(42); if(nearBlobX43 == x && nearBlobZ43 == z) return(43);
	if(nearBlobX44 == x && nearBlobZ44 == z) return(44); if(nearBlobX45 == x && nearBlobZ45 == z) return(45);
	if(nearBlobX46 == x && nearBlobZ46 == z) return(46); if(nearBlobX47 == x && nearBlobZ47 == z) return(47);
	if(nearBlobX48 == x && nearBlobZ48 == z) return(48); if(nearBlobX49 == x && nearBlobZ49 == z) return(49);
	if(nearBlobX50 == x && nearBlobZ50 == z) return(50); if(nearBlobX51 == x && nearBlobZ51 == z) return(51);
	if(nearBlobX52 == x && nearBlobZ52 == z) return(52); if(nearBlobX53 == x && nearBlobZ53 == z) return(53);
	if(nearBlobX54 == x && nearBlobZ54 == z) return(54); if(nearBlobX55 == x && nearBlobZ55 == z) return(55);
	if(nearBlobX56 == x && nearBlobZ56 == z) return(56); if(nearBlobX57 == x && nearBlobZ57 == z) return(57);
	if(nearBlobX58 == x && nearBlobZ58 == z) return(58); if(nearBlobX59 == x && nearBlobZ59 == z) return(59);
	if(nearBlobX60 == x && nearBlobZ60 == z) return(60); if(nearBlobX61 == x && nearBlobZ61 == z) return(61);
	if(nearBlobX62 == x && nearBlobZ62 == z) return(62); if(nearBlobX63 == x && nearBlobZ63 == z) return(63);

	return(-1);
}

/*
** Removes a full blob from the list of near blobs.
**
** @param id: the ID of the blob to be removed
*/
void removeNearBlob(int id = -1) {
	if(id == -1 || nearBlobsCount == 0) {
		return;
	}

	nearBlobsCount--;

	// Shift entries in the array to maintain contiguousness.
	for(i = id; < nearBlobsCount) {
		setNearBlob(getNearBlobX(i + 1), getNearBlobZ(i + 1), i);
	}
}

/**************
* BLOB ACCESS *
**************/

/*
** Resets all blob counters and coordinats to 0.
*/
void resetBlobs() {
	fullBlobsCount = 0;
	nearBlobsCount = 0;

	// It's necessary to clear here for getBlobIndex() (otherwise blobs that do not actually exist can be found).
	fullBlobX0  = 0; fullBlobX1  = 0; fullBlobX2  = 0; fullBlobX3  = 0;
	fullBlobX4  = 0; fullBlobX5  = 0; fullBlobX6  = 0; fullBlobX7  = 0;
	fullBlobX8  = 0; fullBlobX9  = 0; fullBlobX10 = 0; fullBlobX11 = 0;
	fullBlobX12 = 0; fullBlobX13 = 0; fullBlobX14 = 0; fullBlobX15 = 0;
	fullBlobX16 = 0; fullBlobX17 = 0; fullBlobX18 = 0; fullBlobX19 = 0;
	fullBlobX20 = 0; fullBlobX21 = 0; fullBlobX22 = 0; fullBlobX23 = 0;
	fullBlobX24 = 0; fullBlobX25 = 0; fullBlobX26 = 0; fullBlobX27 = 0;
	fullBlobX28 = 0; fullBlobX29 = 0; fullBlobX30 = 0; fullBlobX31 = 0;
	fullBlobX32 = 0; fullBlobX33 = 0; fullBlobX34 = 0; fullBlobX35 = 0;
	fullBlobX36 = 0; fullBlobX37 = 0; fullBlobX38 = 0; fullBlobX39 = 0;
	fullBlobX40 = 0; fullBlobX41 = 0; fullBlobX42 = 0; fullBlobX43 = 0;
	fullBlobX44 = 0; fullBlobX45 = 0; fullBlobX46 = 0; fullBlobX47 = 0;
	fullBlobX48 = 0; fullBlobX49 = 0; fullBlobX50 = 0; fullBlobX51 = 0;
	fullBlobX52 = 0; fullBlobX53 = 0; fullBlobX54 = 0; fullBlobX55 = 0;
	fullBlobX56 = 0; fullBlobX57 = 0; fullBlobX58 = 0; fullBlobX59 = 0;
	fullBlobX60 = 0; fullBlobX61 = 0; fullBlobX62 = 0; fullBlobX63 = 0;

	fullBlobZ0  = 0; fullBlobZ1  = 0; fullBlobZ2  = 0; fullBlobZ3  = 0;
	fullBlobZ4  = 0; fullBlobZ5  = 0; fullBlobZ6  = 0; fullBlobZ7  = 0;
	fullBlobZ8  = 0; fullBlobZ9  = 0; fullBlobZ10 = 0; fullBlobZ11 = 0;
	fullBlobZ12 = 0; fullBlobZ13 = 0; fullBlobZ14 = 0; fullBlobZ15 = 0;
	fullBlobZ16 = 0; fullBlobZ17 = 0; fullBlobZ18 = 0; fullBlobZ19 = 0;
	fullBlobZ20 = 0; fullBlobZ21 = 0; fullBlobZ22 = 0; fullBlobZ23 = 0;
	fullBlobZ24 = 0; fullBlobZ25 = 0; fullBlobZ26 = 0; fullBlobZ27 = 0;
	fullBlobZ28 = 0; fullBlobZ29 = 0; fullBlobZ30 = 0; fullBlobZ31 = 0;
	fullBlobZ32 = 0; fullBlobZ33 = 0; fullBlobZ34 = 0; fullBlobZ35 = 0;
	fullBlobZ36 = 0; fullBlobZ37 = 0; fullBlobZ38 = 0; fullBlobZ39 = 0;
	fullBlobZ40 = 0; fullBlobZ41 = 0; fullBlobZ42 = 0; fullBlobZ43 = 0;
	fullBlobZ44 = 0; fullBlobZ45 = 0; fullBlobZ46 = 0; fullBlobZ47 = 0;
	fullBlobZ48 = 0; fullBlobZ49 = 0; fullBlobZ50 = 0; fullBlobZ51 = 0;
	fullBlobZ52 = 0; fullBlobZ53 = 0; fullBlobZ54 = 0; fullBlobZ55 = 0;
	fullBlobZ56 = 0; fullBlobZ57 = 0; fullBlobZ58 = 0; fullBlobZ59 = 0;
	fullBlobZ60 = 0; fullBlobZ61 = 0; fullBlobZ62 = 0; fullBlobZ63 = 0;

	nearBlobX0  = 0; nearBlobX1  = 0; nearBlobX2  = 0; nearBlobX3  = 0;
	nearBlobX4  = 0; nearBlobX5  = 0; nearBlobX6  = 0; nearBlobX7  = 0;
	nearBlobX8  = 0; nearBlobX9  = 0; nearBlobX10 = 0; nearBlobX11 = 0;
	nearBlobX12 = 0; nearBlobX13 = 0; nearBlobX14 = 0; nearBlobX15 = 0;
	nearBlobX16 = 0; nearBlobX17 = 0; nearBlobX18 = 0; nearBlobX19 = 0;
	nearBlobX20 = 0; nearBlobX21 = 0; nearBlobX22 = 0; nearBlobX23 = 0;
	nearBlobX24 = 0; nearBlobX25 = 0; nearBlobX26 = 0; nearBlobX27 = 0;
	nearBlobX28 = 0; nearBlobX29 = 0; nearBlobX30 = 0; nearBlobX31 = 0;
	nearBlobX32 = 0; nearBlobX33 = 0; nearBlobX34 = 0; nearBlobX35 = 0;
	nearBlobX36 = 0; nearBlobX37 = 0; nearBlobX38 = 0; nearBlobX39 = 0;
	nearBlobX40 = 0; nearBlobX41 = 0; nearBlobX42 = 0; nearBlobX43 = 0;
	nearBlobX44 = 0; nearBlobX45 = 0; nearBlobX46 = 0; nearBlobX47 = 0;
	nearBlobX48 = 0; nearBlobX49 = 0; nearBlobX50 = 0; nearBlobX51 = 0;
	nearBlobX52 = 0; nearBlobX53 = 0; nearBlobX54 = 0; nearBlobX55 = 0;
	nearBlobX56 = 0; nearBlobX57 = 0; nearBlobX58 = 0; nearBlobX59 = 0;
	nearBlobX60 = 0; nearBlobX61 = 0; nearBlobX62 = 0; nearBlobX63 = 0;

	nearBlobZ0  = 0; nearBlobZ1  = 0; nearBlobZ2  = 0; nearBlobZ3  = 0;
	nearBlobZ4  = 0; nearBlobZ5  = 0; nearBlobZ6  = 0; nearBlobZ7  = 0;
	nearBlobZ8  = 0; nearBlobZ9  = 0; nearBlobZ10 = 0; nearBlobZ11 = 0;
	nearBlobZ12 = 0; nearBlobZ13 = 0; nearBlobZ14 = 0; nearBlobZ15 = 0;
	nearBlobZ16 = 0; nearBlobZ17 = 0; nearBlobZ18 = 0; nearBlobZ19 = 0;
	nearBlobZ20 = 0; nearBlobZ21 = 0; nearBlobZ22 = 0; nearBlobZ23 = 0;
	nearBlobZ24 = 0; nearBlobZ25 = 0; nearBlobZ26 = 0; nearBlobZ27 = 0;
	nearBlobZ28 = 0; nearBlobZ29 = 0; nearBlobZ30 = 0; nearBlobZ31 = 0;
	nearBlobZ32 = 0; nearBlobZ33 = 0; nearBlobZ34 = 0; nearBlobZ35 = 0;
	nearBlobZ36 = 0; nearBlobZ37 = 0; nearBlobZ38 = 0; nearBlobZ39 = 0;
	nearBlobZ40 = 0; nearBlobZ41 = 0; nearBlobZ42 = 0; nearBlobZ43 = 0;
	nearBlobZ44 = 0; nearBlobZ45 = 0; nearBlobZ46 = 0; nearBlobZ47 = 0;
	nearBlobZ48 = 0; nearBlobZ49 = 0; nearBlobZ50 = 0; nearBlobZ51 = 0;
	nearBlobZ52 = 0; nearBlobZ53 = 0; nearBlobZ54 = 0; nearBlobZ55 = 0;
	nearBlobZ56 = 0; nearBlobZ57 = 0; nearBlobZ58 = 0; nearBlobZ59 = 0;
	nearBlobZ60 = 0; nearBlobZ61 = 0; nearBlobZ62 = 0; nearBlobZ63 = 0;
}

/*
** Retrieves the x coodinate of a blob with a certain ID depending on its state.
**
** @param id: the ID of the blob
** @param state: the state of the blob (i.e., the list of blobs to search)
**
** @returns: the x coodinate of the blob on the grid
*/
int getBlobX(int id = -1, int state = cBlobInvalid) {
	if(state == cBlobFull) {
		return(getFullBlobX(id));
	} else if(state == cBlobNear) {
		return(getNearBlobX(id));
	}

	return(cBlobInvalid);
}

/*
** Retrieves the z coodinate of a blob with a certain ID depending on its state.
**
** @param id: the ID of the blob
** @param state: the state of the blob (i.e., the list of blobs to search)
**
** @returns: the z coodinate of the blob on the grid
*/
int getBlobZ(int id = -1, int state = cBlobInvalid) {
	if(state == cBlobFull) {
		return(getFullBlobZ(id));
	} else if(state == cBlobNear) {
		return(getNearBlobZ(id));
	}

	return(cBlobInvalid);
}

/*
** Retrieves the size of a list of blobs.
**
** @param state: the list to retrieve the size of
**
** @returns: the list size
*/
int getStateSize(int state = cBlobInvalid) {
	if(state == cBlobFull) {
		return(fullBlobsCount);
	} else if(state == cBlobNear) {
		return(nearBlobsCount);
	}

	return(cBlobInvalid);
}

/*
** Appends a blob to a list depending on its state.
**
** @param x: x coordinate on the grid
** @param z: z coordinate on the grid
** @param state: the state of the blob (i.e., the list of blobs to append to)
*/
void writeBlob(int x = -1, int z = -1, int state = cBlobInvalid) {
	if(state == cBlobFull) {
		setFullBlob(x, z);
	} else if(state == cBlobNear) {
		setNearBlob(x, z);
	}
}

/*
** Removes a blob from the list depending on its state.
**
** @param id: the ID of the blob
** @param state: the state of the blob (i.e., the list of blobs to remove the blob from)
*/
void removeBlob(int id = -1, int state = cBlobInvalid) {
	if(state == cBlobFull) {
		removeFullBlob(id);
	} else if(state == cBlobNear) {
		removeNearBlob(id);
	}
}

/*
** Gets the ID of a blob given its coordinates and state.
**
** @param x: x coordinate on the grid
** @param z: z coordinate on the grid
** @param state: the state of the blob (i.e., the list of blobs to scan)
**
** @returns: the ID of the blob
*/
int getBlobIndex(int x = -1, int z = -1, int state = cBlobInvalid) {
	if(state == cBlobFull) {
		return(findFullBlob(x, z));
	} else if(state == cBlobNear) {
		return(findNearBlob(x, z));
	}

	return(cBlobInvalid);
}

/*
** Gets the state of a blob given its coordinates.
**
** @param x: x coordinate on the grid
** @param z: z coordinate on the grid
**
** @returns: the state of the blob
*/
int getBlobState(int x = -1, int z = -1) {
	for(i = cFirstState; <= cTotalStates) {
		if(getBlobIndex(x, z, i) != -1) {
			return(i);
		}
	}

	return(cBlobEmpty);
}

/*
** Gets the blob distance from the center of 0/0.
**
** @param x: x coordinate on the grid
** @param z: z coordinate on the grid
**
** @returns: the distance from the center as float
*/
float getBlobDistance(int x = -1, int z = -1) {
	// Don't bother taking the square root here, the values only have to be comparable, not exact.
	return(1.0 * sq(x) + sq(z));
}

/*******************
* SHAPE GENERATION *
*******************/

/*
** Gets the minimum distance from any near blob to the center.
**
** @returns: the minimum distance of any blob to the center as a float
*/
float getMinBlobDistance() {
	float minDist = INF;

	for(i = 0; < getStateSize(cBlobNear)) {
		int x = getBlobX(i, cBlobNear);
		int z = getBlobZ(i, cBlobNear);

		float distance = getBlobDistance(x, z);

		if(distance < minDist) {
			minDist = distance;
		}
	}

	return(minDist);
}

/*
** Gets the maximum distance from any near blob to the center.
**
** @returns: the maximum distance of any blob to the center as a float
*/
float getMaxBlobDistance() {
	float maxDist = 0.0;

	for(i = 0; < getStateSize(cBlobNear)) {
		int x = getBlobX(i, cBlobNear);
		int z = getBlobZ(i, cBlobNear);

		float distance = getBlobDistance(x, z);

		if(distance > maxDist) {
			maxDist = distance;
		}
	}

	return(maxDist);
}

/*
** Calculates the chance for a single blob to be filled based on coordinates, coherence and distance to the center.
**
** @param x: x coordinate on the grid
** @param z: z coordinate on the grid
** @param coherence: [-1.0, 0.0]: long shapes (-1.0 = a line); [0.0, 1.0]: circular shapes (1.0 = circle)
** @param minDist: the current minimum distance of any blob to the center
** @param maxDist: the current maximum distance of any blob to the center
**
** @returns: the chance for the particular blob to be filled
*/
float getBlobChance(int x = -1, int z = -1, float coherence = 0.0, float minDist = -1.0, float maxDist = -1.0) {
	float distance = getBlobDistance(x, z);

	// Guarantee 100% for first blob at 0/0.
	if(distance == 0.0) {
		return(1.0);
	}

	// Upon negative coherence, give a higher probability for blobs further away.
	if(coherence < 0.0) {
		coherence = 0.0 - coherence;

		float maxPart = distance / maxDist;

		return(coherence * pow(maxPart, 3) + (1.0 - coherence));
	}

	float minPart = 0.0;

	/*
	 * Otherwise, guarantee 1.0 for closest blobs if coherence >= 0. If not closest blob, return 1.0 - coherence.
	 * For a coherence of 1.0, blobs that don't have minimum distance thus have a 0% chance of getting picked.
	 * For a coherence of 0.0, all blobs have a chance of 1.0 of being picked, regardless if closest or not.
	*/
	if(distance == minDist) {
		minPart = 1.0;
	}

	return(coherence * minPart + (1.0 - coherence));
}

/*
** Fills a certain blob. The blob has to be near already to be filled.
** If this is the case, all adjacent blobs are marked as near, and the targeted blob is filled.
**
** @param x: x coordinate on the grid
** @param z: z coordinate on the grid
*/
void fillBlob(int x = -1, int z = -1) {
	// Fills a single blob and marks all blobs surrounding the x/z coordinates as near.
	if(getBlobState(x, z) != cBlobNear) {
		// Blob has to be near, otherwise it can't be filled!
		return;
	}

	for(j = -1; <= 1) {
		for(k = -1; <= 1) {
			if(j == 0 && k == 0) {
				// Remove chosen blob from near blobs and add to full blobs.
				removeBlob(getBlobIndex(x, z, cBlobNear), cBlobNear);
				writeBlob(x, z, cBlobFull);
			} else if(getBlobState(x + j, z + k) == cBlobEmpty) {
				// Add adjacent blobs to near blobs.
				writeBlob(x + j, z + k, cBlobNear);
			}
		}
	}
}

/*
** Adds a new blob to the shape.
**
** @param coherence: [-1.0, 0.0]: long shapes (-1.0 = line); [0.0, 1.0]: circular shapes (1.0 = circle)
*/
void addBlob(float coherence = 1.0) {
	float maxChance = 0.0;
	float maxDistance = getMaxBlobDistance(); // Distance of furthest near blob.
	float minDistance = getMinBlobDistance(); // Distance of closest near blob.

	for(i = 0; < getStateSize(cBlobNear)) {
		int x = getBlobX(i, cBlobNear);
		int z = getBlobZ(i, cBlobNear);
		maxChance = maxChance + getBlobChance(x, z, coherence, minDistance, maxDistance);
	}

	// Return if we have a summed chance of 0%.
	if(maxChance == 0.0) {
		return;
	}

	float randomChance = rmRandFloat(0.0, maxChance);
	maxChance = 0.0;

	// Pick a random blob, blobs with higher chances will get selected more likely.
	for(i = 0; < getStateSize(cBlobNear)) {
		x = getBlobX(i, cBlobNear);
		z = getBlobZ(i, cBlobNear);
		maxChance = maxChance + getBlobChance(x, z, coherence, minDistance, maxDistance);

		// Over threshold, select current blob.
		if(maxChance >= randomChance) {
			fillBlob(x, z);
			return;
		}
	}
}

/*
** Creates a new random shape.
**
** @param numBlobs: the number of blobs to use for the shape
** @param coherence: [-1.0, 0.0]: long shapes (-1.0 = line); [0.0, 1.0]: circular shapes (1.0 = circle)
*/
void createRandomShape(int numBlobs = 0, float coherence = 1.0) {
	resetBlobs();

	writeBlob(0, 0, cBlobNear);

	for(i = 0; < numBlobs) {
		addBlob(coherence);
	}
}

/*
** Sets the area location for a single blob, i.e., maps the blob coodinate system onto the random map coodinate system.
**
** @param radius: the radius at which the random shape should be placed
** @param angle: the angle at which the random shape should be placed
** @param areaID: the area ID of this specific blob as int
** @param blobRadius: the radius of the blob in meters
** @param blobSpacing: the distance between the blobs in meters (independent of blob radius)
** @param x: x coordinate on the grid
** @param z: z coordinate on the grid
** @param player: the player to place the area for; if this is set, player angle offset is used instead of the center of the map
*/
void placeBlob(float radius = -1.0, float angle = -1.0, int areaID = -1, float blobRadius = -1.0, float blobSpacing = 1.0, float x = -1.0, float z = -1.0, int player = 0) {
	rmSetAreaSize(areaID, areaRadiusMetersToFraction(blobRadius));
	rmSetAreaCoherence(areaID, 1.0);
	rmSetAreaWarnFailure(areaID, false);

	// Calculate position and rotate by angle.
	float posX = getXFromPolarForPlayer(player, radius, angle) + rmXMetersToFraction(blobSpacing) * getXRotatePoint(x, z, angle + getPlayerAngle(player));
	float posZ = getZFromPolarForPlayer(player, radius, angle) + rmZMetersToFraction(blobSpacing) * getZRotatePoint(x, z, angle + getPlayerAngle(player));

	// Set area location and fit to map.
	rmSetAreaLocation(areaID, fitToMap(posX), fitToMap(posZ));
}

/*
** Calculates the mirrored angle of a shape based on a given angle and whether center offset or player offset is used.
**
** @param angle: the angle to mirror
** @param hasCenterOffset: whether center offset is used or not (= player offset is used)
**
** @returns: the mirrored angle
*/
float getMirrorAngleForShape(float angle = 0.0, bool hasCenterOffset = true) {
	int mode = getMirrorMode();

	// Mirror by point: Rotate by 180 degree.
	if(mode == cMirrorPoint) {
		if(hasCenterOffset) {
			return(angle + PI);
		} else {
			return(angle);
		}
	}

	// Mirror by axis.
	angle = 0.0 - angle;

	// When using player offset, just return 0.0 - angle.
	if(hasCenterOffset == false) {
		return(angle);
	}

	// Center offset: 4 possibilities for all 4 possible axis mirror cases.
	if(mode == cMirrorAxisX) {
		return(angle);
	} else if(mode == cMirrorAxisZ) {
		return(angle + PI);
	} else if(mode == cMirrorAxisH) {
		return(angle + 1.5 * PI);
	} else if(mode == cMirrorAxisV) {
		return(angle + 0.5 * PI);
	}

	// Should never happen.
	return(0.0);
}

/*
** Places a previously created shape on the map and mirrors it. This sets the locations of the areas and requires areas to be defined as
** areaName + " " + i + " " + j where i is in {0, 1} for the original and mirrored area and j is the number of blobs the shape has (starting from 0).
** The mirrored shape will be placed according to the mirror mode set.
** If a player is set, the area will be mirrored for the corresponding mirrored player (also depending on the mirror mode that has been set).
**
** @param radius: the radius in meters at which the random shape should be placed
** @param angle: the angle at which the random shape should be placed
** @param name: the name of the areas; format: "myAreaName 0 0", "myAreaName 0 1", ..., "myAreaName 1 0", "myAreaName 1 1", ...
** @param blobRadius: the radius of the blob in meters
** @param blobSpacing: the distance between the blobs in meters (independent of blob radius)
** @param player: the player to place the area for; if this is set, player angle offset is used instead of the center of the map
*/
void placeRandomShapeMirrored(float radius = 0.0, float angle = 0.0, string name = "", float blobRadius = 4.5, float blobSpacing = 4.5, int player = 0) {
	// Convert radius to fraction.
	radius = smallerMetersToFraction(radius);

	// Mirrored player and adjusted angle
	int mirrorPlayer = getMirroredPlayer(player);
	float mirrorAngle = getMirrorAngleForShape(angle, player == 0);

	// Place original shape.
	for(i = 0; < getStateSize(cBlobFull)) {
		int x = getBlobX(i, cBlobFull);
		int z = getBlobZ(i, cBlobFull);

		// Original shape.
		placeBlob(radius, angle, rmAreaID(name + " " + 0 + " " + i), blobRadius, blobSpacing, 0.0 + x, 0.0 + z, player);

		// Mirrored shape.
		if(getMirrorMode() == cMirrorPoint) {
			placeBlob(radius, mirrorAngle, rmAreaID(name + " " + 1 + " " + i), blobRadius, blobSpacing, 0.0 + x, 0.0 + z, mirrorPlayer);
		} else {
			/*
			 * By axis requires the inversion of the z axis of the shape grid.
			 * We don't invert the x axis here because we always want the same part of the shape to point towards the inside.
			 * While this may not sound very intuitive, if you draw a shape and try to rotate it and then mirror it, it will make sense.
			*/
			placeBlob(radius, mirrorAngle, rmAreaID(name + " " + 1 + " " + i), blobRadius, blobSpacing, 0.0 + x, 0.0 - z, mirrorPlayer);
		}
	}

	// Store locations.
	addLocPolarWithOffsetToLocStorage(player, radius, angle);
	addLocPolarWithOffsetToLocStorage(mirrorPlayer, radius, mirrorAngle);
}

/*
** Places a random shape on the map. This has to be called prior to rmBuildAllAreas(), which will then build the placed shape.
** This function is not used frequently as you probably only want to generate and place shapes when mirroring which is already covered by placeRandomShapeMirrored().
**
** @param radius: the radius in meters at which the random shape should be placed
** @param angle: the angle at which the random shape should be placed
** @param name: the name of the areas; format: "myAreaName 0", "myAreaName 1", ... (starting at 0)
** @param blobRadius: the radius of the blob in meters
** @param blobSpacing: the distance between the blobs in meters (independent of blob radius)
** @param player: the player to place the area for; if this is set, player angle offset is used instead of the center of the map
*/
void placeRandomShape(float radius = 0.0, float angle = 0.0, string name = "", float blobRadius = 4.5, float blobSpacing = 4.5, int player = 0) {
	radius = smallerMetersToFraction(radius);

	for(i = 0; < getStateSize(cBlobFull)) {
		int x = getBlobX(i, cBlobFull);
		int z = getBlobZ(i, cBlobFull);

		placeBlob(radius, angle, rmAreaID(name + " " + i), blobRadius, blobSpacing, 0.0 + x, 0.0 + z, player);
	}
}
