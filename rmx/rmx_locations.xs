/*
** Location storage data structure.
** RebelsRising
** Last edit: 12/05/2021
*/

include "rmx_util.xs";

/*******************
* LOCATION STORAGE *
*******************/

/*
 * Used by regular object placement and all (objects & areas) mirrored placement.
 * Has to be enabled via enableLocStorage() to be active. Once full, any additional entries will be discarded!
 * Therefore, using disableLocStorage() is important not needing the storage anymore.
 *
 * Note that mirrored locations and objects for players are usually placed in the order of mirroring.
 * If t1p(1) means team 1 player 1, then the placement is as follows:
 *
 * Mirroring through point: t1p(1), t2p(1), t1p(2), t2p(2), ...
 * Mirroring through axis:  t1p(1), t2p(n), t1p(2), t2p(n-1), ...
 * Placing the same object multiple times will do so per mirrored player pair.
 * Example for 4 players placing twice: p1, p3, p1, p3, p2, p4, p2, p4.
*/

const int cAreaStorageSize = 64;

int locCounter = 0;
bool isStorageActive = false;

// Location X storage, starts at 1 due to often being used in combination with players.
float locX1  = -1.0; float locX2  = -1.0; float locX3  = -1.0; float locX4  = -1.0;
float locX5  = -1.0; float locX6  = -1.0; float locX7  = -1.0; float locX8  = -1.0;
float locX9  = -1.0; float locX10 = -1.0; float locX11 = -1.0; float locX12 = -1.0;
float locX13 = -1.0; float locX14 = -1.0; float locX15 = -1.0; float locX16 = -1.0;
float locX17 = -1.0; float locX18 = -1.0; float locX19 = -1.0; float locX20 = -1.0;
float locX21 = -1.0; float locX22 = -1.0; float locX23 = -1.0; float locX24 = -1.0;
float locX25 = -1.0; float locX26 = -1.0; float locX27 = -1.0; float locX28 = -1.0;
float locX29 = -1.0; float locX30 = -1.0; float locX31 = -1.0; float locX32 = -1.0;
float locX33 = -1.0; float locX34 = -1.0; float locX35 = -1.0; float locX36 = -1.0;
float locX37 = -1.0; float locX38 = -1.0; float locX39 = -1.0; float locX40 = -1.0;
float locX41 = -1.0; float locX42 = -1.0; float locX43 = -1.0; float locX44 = -1.0;
float locX45 = -1.0; float locX46 = -1.0; float locX47 = -1.0; float locX48 = -1.0;
float locX49 = -1.0; float locX50 = -1.0; float locX51 = -1.0; float locX52 = -1.0;
float locX53 = -1.0; float locX54 = -1.0; float locX55 = -1.0; float locX56 = -1.0;
float locX57 = -1.0; float locX58 = -1.0; float locX59 = -1.0; float locX60 = -1.0;
float locX61 = -1.0; float locX62 = -1.0; float locX63 = -1.0; float locX64 = -1.0;

float getLocX(int i = 0) {
	if(i == 1)  return(locX1);  if(i == 2)  return(locX2);  if(i == 3)  return(locX3);  if(i == 4)  return(locX4);
	if(i == 5)  return(locX5);  if(i == 6)  return(locX6);  if(i == 7)  return(locX7);  if(i == 8)  return(locX8);
	if(i == 9)  return(locX9);  if(i == 10) return(locX10); if(i == 11) return(locX11); if(i == 12) return(locX12);
	if(i == 13) return(locX13); if(i == 14) return(locX14); if(i == 15) return(locX15); if(i == 16) return(locX16);
	if(i == 17) return(locX17); if(i == 18) return(locX18); if(i == 19) return(locX19); if(i == 20) return(locX20);
	if(i == 21) return(locX21); if(i == 22) return(locX22); if(i == 23) return(locX23); if(i == 24) return(locX24);
	if(i == 25) return(locX25); if(i == 26) return(locX26); if(i == 27) return(locX27); if(i == 28) return(locX28);
	if(i == 29) return(locX29); if(i == 30) return(locX30); if(i == 31) return(locX31); if(i == 32) return(locX32);
	if(i == 33) return(locX33); if(i == 34) return(locX34); if(i == 35) return(locX35); if(i == 36) return(locX36);
	if(i == 37) return(locX37); if(i == 38) return(locX38); if(i == 39) return(locX39); if(i == 40) return(locX40);
	if(i == 41) return(locX41); if(i == 42) return(locX42); if(i == 43) return(locX43); if(i == 44) return(locX44);
	if(i == 45) return(locX45); if(i == 46) return(locX46); if(i == 47) return(locX47); if(i == 48) return(locX48);
	if(i == 49) return(locX49); if(i == 50) return(locX50); if(i == 51) return(locX51); if(i == 52) return(locX52);
	if(i == 53) return(locX53); if(i == 54) return(locX54); if(i == 55) return(locX55); if(i == 56) return(locX56);
	if(i == 57) return(locX57); if(i == 58) return(locX58); if(i == 59) return(locX59); if(i == 60) return(locX60);
	if(i == 61) return(locX61); if(i == 62) return(locX62); if(i == 63) return(locX63); if(i == 64) return(locX64);
	return(-1.0);
}

float setLocX(int i = 0, float val = -1.0) {
	if(i == 1)  locX1  = val; if(i == 2)  locX2  = val; if(i == 3)  locX3  = val; if(i == 4)  locX4  = val;
	if(i == 5)  locX5  = val; if(i == 6)  locX6  = val; if(i == 7)  locX7  = val; if(i == 8)  locX8  = val;
	if(i == 9)  locX9  = val; if(i == 10) locX10 = val; if(i == 11) locX11 = val; if(i == 12) locX12 = val;
	if(i == 13) locX13 = val; if(i == 14) locX14 = val; if(i == 15) locX15 = val; if(i == 16) locX16 = val;
	if(i == 17) locX17 = val; if(i == 18) locX18 = val; if(i == 19) locX19 = val; if(i == 20) locX20 = val;
	if(i == 21) locX21 = val; if(i == 22) locX22 = val; if(i == 23) locX23 = val; if(i == 24) locX24 = val;
	if(i == 25) locX25 = val; if(i == 26) locX26 = val; if(i == 27) locX27 = val; if(i == 28) locX28 = val;
	if(i == 29) locX29 = val; if(i == 30) locX30 = val; if(i == 31) locX31 = val; if(i == 32) locX32 = val;
	if(i == 33) locX33 = val; if(i == 34) locX34 = val; if(i == 35) locX35 = val; if(i == 36) locX36 = val;
	if(i == 37) locX37 = val; if(i == 38) locX38 = val; if(i == 39) locX39 = val; if(i == 40) locX40 = val;
	if(i == 41) locX41 = val; if(i == 42) locX42 = val; if(i == 43) locX43 = val; if(i == 44) locX44 = val;
	if(i == 45) locX45 = val; if(i == 46) locX46 = val; if(i == 47) locX47 = val; if(i == 48) locX48 = val;
	if(i == 49) locX49 = val; if(i == 50) locX50 = val; if(i == 51) locX51 = val; if(i == 52) locX52 = val;
	if(i == 53) locX53 = val; if(i == 54) locX54 = val; if(i == 55) locX55 = val; if(i == 56) locX56 = val;
	if(i == 57) locX57 = val; if(i == 58) locX58 = val; if(i == 59) locX59 = val; if(i == 60) locX60 = val;
	if(i == 61) locX61 = val; if(i == 62) locX62 = val; if(i == 63) locX63 = val; if(i == 64) locX64 = val;
}

// Location Z storage, starts at 1 due to often being used in combination with players.
float locZ1  = -1.0; float locZ2  = -1.0; float locZ3  = -1.0; float locZ4  = -1.0;
float locZ5  = -1.0; float locZ6  = -1.0; float locZ7  = -1.0; float locZ8  = -1.0;
float locZ9  = -1.0; float locZ10 = -1.0; float locZ11 = -1.0; float locZ12 = -1.0;
float locZ13 = -1.0; float locZ14 = -1.0; float locZ15 = -1.0; float locZ16 = -1.0;
float locZ17 = -1.0; float locZ18 = -1.0; float locZ19 = -1.0; float locZ20 = -1.0;
float locZ21 = -1.0; float locZ22 = -1.0; float locZ23 = -1.0; float locZ24 = -1.0;
float locZ25 = -1.0; float locZ26 = -1.0; float locZ27 = -1.0; float locZ28 = -1.0;
float locZ29 = -1.0; float locZ30 = -1.0; float locZ31 = -1.0; float locZ32 = -1.0;
float locZ33 = -1.0; float locZ34 = -1.0; float locZ35 = -1.0; float locZ36 = -1.0;
float locZ37 = -1.0; float locZ38 = -1.0; float locZ39 = -1.0; float locZ40 = -1.0;
float locZ41 = -1.0; float locZ42 = -1.0; float locZ43 = -1.0; float locZ44 = -1.0;
float locZ45 = -1.0; float locZ46 = -1.0; float locZ47 = -1.0; float locZ48 = -1.0;
float locZ49 = -1.0; float locZ50 = -1.0; float locZ51 = -1.0; float locZ52 = -1.0;
float locZ53 = -1.0; float locZ54 = -1.0; float locZ55 = -1.0; float locZ56 = -1.0;
float locZ57 = -1.0; float locZ58 = -1.0; float locZ59 = -1.0; float locZ60 = -1.0;
float locZ61 = -1.0; float locZ62 = -1.0; float locZ63 = -1.0; float locZ64 = -1.0;

float getLocZ(int i = 0) {
	if(i == 1)  return(locZ1);  if(i == 2)  return(locZ2);  if(i == 3)  return(locZ3);  if(i == 4)  return(locZ4);
	if(i == 5)  return(locZ5);  if(i == 6)  return(locZ6);  if(i == 7)  return(locZ7);  if(i == 8)  return(locZ8);
	if(i == 9)  return(locZ9);  if(i == 10) return(locZ10); if(i == 11) return(locZ11); if(i == 12) return(locZ12);
	if(i == 13) return(locZ13); if(i == 14) return(locZ14); if(i == 15) return(locZ15); if(i == 16) return(locZ16);
	if(i == 17) return(locZ17); if(i == 18) return(locZ18); if(i == 19) return(locZ19); if(i == 20) return(locZ20);
	if(i == 21) return(locZ21); if(i == 22) return(locZ22); if(i == 23) return(locZ23); if(i == 24) return(locZ24);
	if(i == 25) return(locZ25); if(i == 26) return(locZ26); if(i == 27) return(locZ27); if(i == 28) return(locZ28);
	if(i == 29) return(locZ29); if(i == 30) return(locZ30); if(i == 31) return(locZ31); if(i == 32) return(locZ32);
	if(i == 33) return(locZ33); if(i == 34) return(locZ34); if(i == 35) return(locZ35); if(i == 36) return(locZ36);
	if(i == 37) return(locZ37); if(i == 38) return(locZ38); if(i == 39) return(locZ39); if(i == 40) return(locZ40);
	if(i == 41) return(locZ41); if(i == 42) return(locZ42); if(i == 43) return(locZ43); if(i == 44) return(locZ44);
	if(i == 45) return(locZ45); if(i == 46) return(locZ46); if(i == 47) return(locZ47); if(i == 48) return(locZ48);
	if(i == 49) return(locZ49); if(i == 50) return(locZ50); if(i == 51) return(locZ51); if(i == 52) return(locZ52);
	if(i == 53) return(locZ53); if(i == 54) return(locZ54); if(i == 55) return(locZ55); if(i == 56) return(locZ56);
	if(i == 57) return(locZ57); if(i == 58) return(locZ58); if(i == 59) return(locZ59); if(i == 60) return(locZ60);
	if(i == 61) return(locZ61); if(i == 62) return(locZ62); if(i == 63) return(locZ63); if(i == 64) return(locZ64);
	return(-1.0);
}

float setLocZ(int i = 0, float val = -1.0) {
	if(i == 1)  locZ1  = val; if(i == 2)  locZ2  = val; if(i == 3)  locZ3  = val; if(i == 4)  locZ4  = val;
	if(i == 5)  locZ5  = val; if(i == 6)  locZ6  = val; if(i == 7)  locZ7  = val; if(i == 8)  locZ8  = val;
	if(i == 9)  locZ9  = val; if(i == 10) locZ10 = val; if(i == 11) locZ11 = val; if(i == 12) locZ12 = val;
	if(i == 13) locZ13 = val; if(i == 14) locZ14 = val; if(i == 15) locZ15 = val; if(i == 16) locZ16 = val;
	if(i == 17) locZ17 = val; if(i == 18) locZ18 = val; if(i == 19) locZ19 = val; if(i == 20) locZ20 = val;
	if(i == 21) locZ21 = val; if(i == 22) locZ22 = val; if(i == 23) locZ23 = val; if(i == 24) locZ24 = val;
	if(i == 25) locZ25 = val; if(i == 26) locZ26 = val; if(i == 27) locZ27 = val; if(i == 28) locZ28 = val;
	if(i == 29) locZ29 = val; if(i == 30) locZ30 = val; if(i == 31) locZ31 = val; if(i == 32) locZ32 = val;
	if(i == 33) locZ33 = val; if(i == 34) locZ34 = val; if(i == 35) locZ35 = val; if(i == 36) locZ36 = val;
	if(i == 37) locZ37 = val; if(i == 38) locZ38 = val; if(i == 39) locZ39 = val; if(i == 40) locZ40 = val;
	if(i == 41) locZ41 = val; if(i == 42) locZ42 = val; if(i == 43) locZ43 = val; if(i == 44) locZ44 = val;
	if(i == 45) locZ45 = val; if(i == 46) locZ46 = val; if(i == 47) locZ47 = val; if(i == 48) locZ48 = val;
	if(i == 49) locZ49 = val; if(i == 50) locZ50 = val; if(i == 51) locZ51 = val; if(i == 52) locZ52 = val;
	if(i == 53) locZ53 = val; if(i == 54) locZ54 = val; if(i == 55) locZ55 = val; if(i == 56) locZ56 = val;
	if(i == 57) locZ57 = val; if(i == 58) locZ58 = val; if(i == 59) locZ59 = val; if(i == 60) locZ60 = val;
	if(i == 61) locZ61 = val; if(i == 62) locZ62 = val; if(i == 63) locZ63 = val; if(i == 64) locZ64 = val;
}

// Location owner storage, starts at 1 due to often being used in combination with players.
int locOwner1  = 0; int locOwner2  = 0; int locOwner3  = 0; int locOwner4  = 0;
int locOwner5  = 0; int locOwner6  = 0; int locOwner7  = 0; int locOwner8  = 0;
int locOwner9  = 0; int locOwner10 = 0; int locOwner11 = 0; int locOwner12 = 0;
int locOwner13 = 0; int locOwner14 = 0; int locOwner15 = 0; int locOwner16 = 0;
int locOwner17 = 0; int locOwner18 = 0; int locOwner19 = 0; int locOwner20 = 0;
int locOwner21 = 0; int locOwner22 = 0; int locOwner23 = 0; int locOwner24 = 0;
int locOwner25 = 0; int locOwner26 = 0; int locOwner27 = 0; int locOwner28 = 0;
int locOwner29 = 0; int locOwner30 = 0; int locOwner31 = 0; int locOwner32 = 0;
int locOwner33 = 0; int locOwner34 = 0; int locOwner35 = 0; int locOwner36 = 0;
int locOwner37 = 0; int locOwner38 = 0; int locOwner39 = 0; int locOwner40 = 0;
int locOwner41 = 0; int locOwner42 = 0; int locOwner43 = 0; int locOwner44 = 0;
int locOwner45 = 0; int locOwner46 = 0; int locOwner47 = 0; int locOwner48 = 0;
int locOwner49 = 0; int locOwner50 = 0; int locOwner51 = 0; int locOwner52 = 0;
int locOwner53 = 0; int locOwner54 = 0; int locOwner55 = 0; int locOwner56 = 0;
int locOwner57 = 0; int locOwner58 = 0; int locOwner59 = 0; int locOwner60 = 0;
int locOwner61 = 0; int locOwner62 = 0; int locOwner63 = 0; int locOwner64 = 0;

int getLocOwner(int i = 0) {
	if(i == 1)  return(locOwner1);  if(i == 2)  return(locOwner2);  if(i == 3)  return(locOwner3);  if(i == 4)  return(locOwner4);
	if(i == 5)  return(locOwner5);  if(i == 6)  return(locOwner6);  if(i == 7)  return(locOwner7);  if(i == 8)  return(locOwner8);
	if(i == 9)  return(locOwner9);  if(i == 10) return(locOwner10); if(i == 11) return(locOwner11); if(i == 12) return(locOwner12);
	if(i == 13) return(locOwner13); if(i == 14) return(locOwner14); if(i == 15) return(locOwner15); if(i == 16) return(locOwner16);
	if(i == 17) return(locOwner17); if(i == 18) return(locOwner18); if(i == 19) return(locOwner19); if(i == 20) return(locOwner20);
	if(i == 21) return(locOwner21); if(i == 22) return(locOwner22); if(i == 23) return(locOwner23); if(i == 24) return(locOwner24);
	if(i == 25) return(locOwner25); if(i == 26) return(locOwner26); if(i == 27) return(locOwner27); if(i == 28) return(locOwner28);
	if(i == 29) return(locOwner29); if(i == 30) return(locOwner30); if(i == 31) return(locOwner31); if(i == 32) return(locOwner32);
	if(i == 33) return(locOwner33); if(i == 34) return(locOwner34); if(i == 35) return(locOwner35); if(i == 36) return(locOwner36);
	if(i == 37) return(locOwner37); if(i == 38) return(locOwner38); if(i == 39) return(locOwner39); if(i == 40) return(locOwner40);
	if(i == 41) return(locOwner41); if(i == 42) return(locOwner42); if(i == 43) return(locOwner43); if(i == 44) return(locOwner44);
	if(i == 45) return(locOwner45); if(i == 46) return(locOwner46); if(i == 47) return(locOwner47); if(i == 48) return(locOwner48);
	if(i == 49) return(locOwner49); if(i == 50) return(locOwner50); if(i == 51) return(locOwner51); if(i == 52) return(locOwner52);
	if(i == 53) return(locOwner53); if(i == 54) return(locOwner54); if(i == 55) return(locOwner55); if(i == 56) return(locOwner56);
	if(i == 57) return(locOwner57); if(i == 58) return(locOwner58); if(i == 59) return(locOwner59); if(i == 60) return(locOwner60);
	if(i == 61) return(locOwner61); if(i == 62) return(locOwner62); if(i == 63) return(locOwner63); if(i == 64) return(locOwner64);
	return(0);
}

int setLocOwner(int i = 0, int o = 0) {
	if(i == 1)  locOwner1  = o; if(i == 2)  locOwner2  = o; if(i == 3)  locOwner3  = o; if(i == 4)  locOwner4  = o;
	if(i == 5)  locOwner5  = o; if(i == 6)  locOwner6  = o; if(i == 7)  locOwner7  = o; if(i == 8)  locOwner8  = o;
	if(i == 9)  locOwner9  = o; if(i == 10) locOwner10 = o; if(i == 11) locOwner11 = o; if(i == 12) locOwner12 = o;
	if(i == 13) locOwner13 = o; if(i == 14) locOwner14 = o; if(i == 15) locOwner15 = o; if(i == 16) locOwner16 = o;
	if(i == 17) locOwner17 = o; if(i == 18) locOwner18 = o; if(i == 19) locOwner19 = o; if(i == 20) locOwner20 = o;
	if(i == 21) locOwner21 = o; if(i == 22) locOwner22 = o; if(i == 23) locOwner23 = o; if(i == 24) locOwner24 = o;
	if(i == 25) locOwner25 = o; if(i == 26) locOwner26 = o; if(i == 27) locOwner27 = o; if(i == 28) locOwner28 = o;
	if(i == 29) locOwner29 = o; if(i == 30) locOwner30 = o; if(i == 31) locOwner31 = o; if(i == 32) locOwner32 = o;
	if(i == 33) locOwner33 = o; if(i == 34) locOwner34 = o; if(i == 35) locOwner35 = o; if(i == 36) locOwner36 = o;
	if(i == 37) locOwner37 = o; if(i == 38) locOwner38 = o; if(i == 39) locOwner39 = o; if(i == 40) locOwner40 = o;
	if(i == 41) locOwner41 = o; if(i == 42) locOwner42 = o; if(i == 43) locOwner43 = o; if(i == 44) locOwner44 = o;
	if(i == 45) locOwner45 = o; if(i == 46) locOwner46 = o; if(i == 47) locOwner47 = o; if(i == 48) locOwner48 = o;
	if(i == 49) locOwner49 = o; if(i == 50) locOwner50 = o; if(i == 51) locOwner51 = o; if(i == 52) locOwner52 = o;
	if(i == 53) locOwner53 = o; if(i == 54) locOwner54 = o; if(i == 55) locOwner55 = o; if(i == 56) locOwner56 = o;
	if(i == 57) locOwner57 = o; if(i == 58) locOwner58 = o; if(i == 59) locOwner59 = o; if(i == 60) locOwner60 = o;
	if(i == 61) locOwner61 = o; if(i == 62) locOwner62 = o; if(i == 63) locOwner63 = o; if(i == 64) locOwner64 = o;
}

// Location X backup storage, starts at 1 due to often being used in combination with players.
float locBackupX1  = -1.0; float locBackupX2  = -1.0; float locBackupX3  = -1.0; float locBackupX4  = -1.0;
float locBackupX5  = -1.0; float locBackupX6  = -1.0; float locBackupX7  = -1.0; float locBackupX8  = -1.0;
float locBackupX9  = -1.0; float locBackupX10 = -1.0; float locBackupX11 = -1.0; float locBackupX12 = -1.0;
float locBackupX13 = -1.0; float locBackupX14 = -1.0; float locBackupX15 = -1.0; float locBackupX16 = -1.0;
float locBackupX17 = -1.0; float locBackupX18 = -1.0; float locBackupX19 = -1.0; float locBackupX20 = -1.0;
float locBackupX21 = -1.0; float locBackupX22 = -1.0; float locBackupX23 = -1.0; float locBackupX24 = -1.0;
float locBackupX25 = -1.0; float locBackupX26 = -1.0; float locBackupX27 = -1.0; float locBackupX28 = -1.0;
float locBackupX29 = -1.0; float locBackupX30 = -1.0; float locBackupX31 = -1.0; float locBackupX32 = -1.0;
float locBackupX33 = -1.0; float locBackupX34 = -1.0; float locBackupX35 = -1.0; float locBackupX36 = -1.0;
float locBackupX37 = -1.0; float locBackupX38 = -1.0; float locBackupX39 = -1.0; float locBackupX40 = -1.0;
float locBackupX41 = -1.0; float locBackupX42 = -1.0; float locBackupX43 = -1.0; float locBackupX44 = -1.0;
float locBackupX45 = -1.0; float locBackupX46 = -1.0; float locBackupX47 = -1.0; float locBackupX48 = -1.0;
float locBackupX49 = -1.0; float locBackupX50 = -1.0; float locBackupX51 = -1.0; float locBackupX52 = -1.0;
float locBackupX53 = -1.0; float locBackupX54 = -1.0; float locBackupX55 = -1.0; float locBackupX56 = -1.0;
float locBackupX57 = -1.0; float locBackupX58 = -1.0; float locBackupX59 = -1.0; float locBackupX60 = -1.0;
float locBackupX61 = -1.0; float locBackupX62 = -1.0; float locBackupX63 = -1.0; float locBackupX64 = -1.0;

float getLocBackupX(int i = 0) {
	if(i == 1)  return(locBackupX1);  if(i == 2)  return(locBackupX2);  if(i == 3)  return(locBackupX3);  if(i == 4)  return(locBackupX4);
	if(i == 5)  return(locBackupX5);  if(i == 6)  return(locBackupX6);  if(i == 7)  return(locBackupX7);  if(i == 8)  return(locBackupX8);
	if(i == 9)  return(locBackupX9);  if(i == 10) return(locBackupX10); if(i == 11) return(locBackupX11); if(i == 12) return(locBackupX12);
	if(i == 13) return(locBackupX13); if(i == 14) return(locBackupX14); if(i == 15) return(locBackupX15); if(i == 16) return(locBackupX16);
	if(i == 17) return(locBackupX17); if(i == 18) return(locBackupX18); if(i == 19) return(locBackupX19); if(i == 20) return(locBackupX20);
	if(i == 21) return(locBackupX21); if(i == 22) return(locBackupX22); if(i == 23) return(locBackupX23); if(i == 24) return(locBackupX24);
	if(i == 25) return(locBackupX25); if(i == 26) return(locBackupX26); if(i == 27) return(locBackupX27); if(i == 28) return(locBackupX28);
	if(i == 29) return(locBackupX29); if(i == 30) return(locBackupX30); if(i == 31) return(locBackupX31); if(i == 32) return(locBackupX32);
	if(i == 33) return(locBackupX33); if(i == 34) return(locBackupX34); if(i == 35) return(locBackupX35); if(i == 36) return(locBackupX36);
	if(i == 37) return(locBackupX37); if(i == 38) return(locBackupX38); if(i == 39) return(locBackupX39); if(i == 40) return(locBackupX40);
	if(i == 41) return(locBackupX41); if(i == 42) return(locBackupX42); if(i == 43) return(locBackupX43); if(i == 44) return(locBackupX44);
	if(i == 45) return(locBackupX45); if(i == 46) return(locBackupX46); if(i == 47) return(locBackupX47); if(i == 48) return(locBackupX48);
	if(i == 49) return(locBackupX49); if(i == 50) return(locBackupX50); if(i == 51) return(locBackupX51); if(i == 52) return(locBackupX52);
	if(i == 53) return(locBackupX53); if(i == 54) return(locBackupX54); if(i == 55) return(locBackupX55); if(i == 56) return(locBackupX56);
	if(i == 57) return(locBackupX57); if(i == 58) return(locBackupX58); if(i == 59) return(locBackupX59); if(i == 60) return(locBackupX60);
	if(i == 61) return(locBackupX61); if(i == 62) return(locBackupX62); if(i == 63) return(locBackupX63); if(i == 64) return(locBackupX64);
	return(-1.0);
}

float setLocBackupX(int i = 0, float val = -1.0) {
	if(i == 1)  locBackupX1  = val; if(i == 2)  locBackupX2  = val; if(i == 3)  locBackupX3  = val; if(i == 4)  locBackupX4  = val;
	if(i == 5)  locBackupX5  = val; if(i == 6)  locBackupX6  = val; if(i == 7)  locBackupX7  = val; if(i == 8)  locBackupX8  = val;
	if(i == 9)  locBackupX9  = val; if(i == 10) locBackupX10 = val; if(i == 11) locBackupX11 = val; if(i == 12) locBackupX12 = val;
	if(i == 13) locBackupX13 = val; if(i == 14) locBackupX14 = val; if(i == 15) locBackupX15 = val; if(i == 16) locBackupX16 = val;
	if(i == 17) locBackupX17 = val; if(i == 18) locBackupX18 = val; if(i == 19) locBackupX19 = val; if(i == 20) locBackupX20 = val;
	if(i == 21) locBackupX21 = val; if(i == 22) locBackupX22 = val; if(i == 23) locBackupX23 = val; if(i == 24) locBackupX24 = val;
	if(i == 25) locBackupX25 = val; if(i == 26) locBackupX26 = val; if(i == 27) locBackupX27 = val; if(i == 28) locBackupX28 = val;
	if(i == 29) locBackupX29 = val; if(i == 30) locBackupX30 = val; if(i == 31) locBackupX31 = val; if(i == 32) locBackupX32 = val;
	if(i == 33) locBackupX33 = val; if(i == 34) locBackupX34 = val; if(i == 35) locBackupX35 = val; if(i == 36) locBackupX36 = val;
	if(i == 37) locBackupX37 = val; if(i == 38) locBackupX38 = val; if(i == 39) locBackupX39 = val; if(i == 40) locBackupX40 = val;
	if(i == 41) locBackupX41 = val; if(i == 42) locBackupX42 = val; if(i == 43) locBackupX43 = val; if(i == 44) locBackupX44 = val;
	if(i == 45) locBackupX45 = val; if(i == 46) locBackupX46 = val; if(i == 47) locBackupX47 = val; if(i == 48) locBackupX48 = val;
	if(i == 49) locBackupX49 = val; if(i == 50) locBackupX50 = val; if(i == 51) locBackupX51 = val; if(i == 52) locBackupX52 = val;
	if(i == 53) locBackupX53 = val; if(i == 54) locBackupX54 = val; if(i == 55) locBackupX55 = val; if(i == 56) locBackupX56 = val;
	if(i == 57) locBackupX57 = val; if(i == 58) locBackupX58 = val; if(i == 59) locBackupX59 = val; if(i == 60) locBackupX60 = val;
	if(i == 61) locBackupX61 = val; if(i == 62) locBackupX62 = val; if(i == 63) locBackupX63 = val; if(i == 64) locBackupX64 = val;
}

// LocationZ backup storage, starts at 1 due to often being used in combination with players.
float locBackupZ1  = -1.0; float locBackupZ2  = -1.0; float locBackupZ3  = -1.0; float locBackupZ4  = -1.0;
float locBackupZ5  = -1.0; float locBackupZ6  = -1.0; float locBackupZ7  = -1.0; float locBackupZ8  = -1.0;
float locBackupZ9  = -1.0; float locBackupZ10 = -1.0; float locBackupZ11 = -1.0; float locBackupZ12 = -1.0;
float locBackupZ13 = -1.0; float locBackupZ14 = -1.0; float locBackupZ15 = -1.0; float locBackupZ16 = -1.0;
float locBackupZ17 = -1.0; float locBackupZ18 = -1.0; float locBackupZ19 = -1.0; float locBackupZ20 = -1.0;
float locBackupZ21 = -1.0; float locBackupZ22 = -1.0; float locBackupZ23 = -1.0; float locBackupZ24 = -1.0;
float locBackupZ25 = -1.0; float locBackupZ26 = -1.0; float locBackupZ27 = -1.0; float locBackupZ28 = -1.0;
float locBackupZ29 = -1.0; float locBackupZ30 = -1.0; float locBackupZ31 = -1.0; float locBackupZ32 = -1.0;
float locBackupZ33 = -1.0; float locBackupZ34 = -1.0; float locBackupZ35 = -1.0; float locBackupZ36 = -1.0;
float locBackupZ37 = -1.0; float locBackupZ38 = -1.0; float locBackupZ39 = -1.0; float locBackupZ40 = -1.0;
float locBackupZ41 = -1.0; float locBackupZ42 = -1.0; float locBackupZ43 = -1.0; float locBackupZ44 = -1.0;
float locBackupZ45 = -1.0; float locBackupZ46 = -1.0; float locBackupZ47 = -1.0; float locBackupZ48 = -1.0;
float locBackupZ49 = -1.0; float locBackupZ50 = -1.0; float locBackupZ51 = -1.0; float locBackupZ52 = -1.0;
float locBackupZ53 = -1.0; float locBackupZ54 = -1.0; float locBackupZ55 = -1.0; float locBackupZ56 = -1.0;
float locBackupZ57 = -1.0; float locBackupZ58 = -1.0; float locBackupZ59 = -1.0; float locBackupZ60 = -1.0;
float locBackupZ61 = -1.0; float locBackupZ62 = -1.0; float locBackupZ63 = -1.0; float locBackupZ64 = -1.0;

float getLocBackupZ(int i = 0) {
	if(i == 1)  return(locBackupZ1);  if(i == 2)  return(locBackupZ2);  if(i == 3)  return(locBackupZ3);  if(i == 4)  return(locBackupZ4);
	if(i == 5)  return(locBackupZ5);  if(i == 6)  return(locBackupZ6);  if(i == 7)  return(locBackupZ7);  if(i == 8)  return(locBackupZ8);
	if(i == 9)  return(locBackupZ9);  if(i == 10) return(locBackupZ10); if(i == 11) return(locBackupZ11); if(i == 12) return(locBackupZ12);
	if(i == 13) return(locBackupZ13); if(i == 14) return(locBackupZ14); if(i == 15) return(locBackupZ15); if(i == 16) return(locBackupZ16);
	if(i == 17) return(locBackupZ17); if(i == 18) return(locBackupZ18); if(i == 19) return(locBackupZ19); if(i == 20) return(locBackupZ20);
	if(i == 21) return(locBackupZ21); if(i == 22) return(locBackupZ22); if(i == 23) return(locBackupZ23); if(i == 24) return(locBackupZ24);
	if(i == 25) return(locBackupZ25); if(i == 26) return(locBackupZ26); if(i == 27) return(locBackupZ27); if(i == 28) return(locBackupZ28);
	if(i == 29) return(locBackupZ29); if(i == 30) return(locBackupZ30); if(i == 31) return(locBackupZ31); if(i == 32) return(locBackupZ32);
	if(i == 33) return(locBackupZ33); if(i == 34) return(locBackupZ34); if(i == 35) return(locBackupZ35); if(i == 36) return(locBackupZ36);
	if(i == 37) return(locBackupZ37); if(i == 38) return(locBackupZ38); if(i == 39) return(locBackupZ39); if(i == 40) return(locBackupZ40);
	if(i == 41) return(locBackupZ41); if(i == 42) return(locBackupZ42); if(i == 43) return(locBackupZ43); if(i == 44) return(locBackupZ44);
	if(i == 45) return(locBackupZ45); if(i == 46) return(locBackupZ46); if(i == 47) return(locBackupZ47); if(i == 48) return(locBackupZ48);
	if(i == 49) return(locBackupZ49); if(i == 50) return(locBackupZ50); if(i == 51) return(locBackupZ51); if(i == 52) return(locBackupZ52);
	if(i == 53) return(locBackupZ53); if(i == 54) return(locBackupZ54); if(i == 55) return(locBackupZ55); if(i == 56) return(locBackupZ56);
	if(i == 57) return(locBackupZ57); if(i == 58) return(locBackupZ58); if(i == 59) return(locBackupZ59); if(i == 60) return(locBackupZ60);
	if(i == 61) return(locBackupZ61); if(i == 62) return(locBackupZ62); if(i == 63) return(locBackupZ63); if(i == 64) return(locBackupZ64);
	return(-1.0);
}

float setLocBackupZ(int i = 0, float val = -1.0) {
	if(i == 1)  locBackupZ1  = val; if(i == 2)  locBackupZ2  = val; if(i == 3)  locBackupZ3  = val; if(i == 4)  locBackupZ4  = val;
	if(i == 5)  locBackupZ5  = val; if(i == 6)  locBackupZ6  = val; if(i == 7)  locBackupZ7  = val; if(i == 8)  locBackupZ8  = val;
	if(i == 9)  locBackupZ9  = val; if(i == 10) locBackupZ10 = val; if(i == 11) locBackupZ11 = val; if(i == 12) locBackupZ12 = val;
	if(i == 13) locBackupZ13 = val; if(i == 14) locBackupZ14 = val; if(i == 15) locBackupZ15 = val; if(i == 16) locBackupZ16 = val;
	if(i == 17) locBackupZ17 = val; if(i == 18) locBackupZ18 = val; if(i == 19) locBackupZ19 = val; if(i == 20) locBackupZ20 = val;
	if(i == 21) locBackupZ21 = val; if(i == 22) locBackupZ22 = val; if(i == 23) locBackupZ23 = val; if(i == 24) locBackupZ24 = val;
	if(i == 25) locBackupZ25 = val; if(i == 26) locBackupZ26 = val; if(i == 27) locBackupZ27 = val; if(i == 28) locBackupZ28 = val;
	if(i == 29) locBackupZ29 = val; if(i == 30) locBackupZ30 = val; if(i == 31) locBackupZ31 = val; if(i == 32) locBackupZ32 = val;
	if(i == 33) locBackupZ33 = val; if(i == 34) locBackupZ34 = val; if(i == 35) locBackupZ35 = val; if(i == 36) locBackupZ36 = val;
	if(i == 37) locBackupZ37 = val; if(i == 38) locBackupZ38 = val; if(i == 39) locBackupZ39 = val; if(i == 40) locBackupZ40 = val;
	if(i == 41) locBackupZ41 = val; if(i == 42) locBackupZ42 = val; if(i == 43) locBackupZ43 = val; if(i == 44) locBackupZ44 = val;
	if(i == 45) locBackupZ45 = val; if(i == 46) locBackupZ46 = val; if(i == 47) locBackupZ47 = val; if(i == 48) locBackupZ48 = val;
	if(i == 49) locBackupZ49 = val; if(i == 50) locBackupZ50 = val; if(i == 51) locBackupZ51 = val; if(i == 52) locBackupZ52 = val;
	if(i == 53) locBackupZ53 = val; if(i == 54) locBackupZ54 = val; if(i == 55) locBackupZ55 = val; if(i == 56) locBackupZ56 = val;
	if(i == 57) locBackupZ57 = val; if(i == 58) locBackupZ58 = val; if(i == 59) locBackupZ59 = val; if(i == 60) locBackupZ60 = val;
	if(i == 61) locBackupZ61 = val; if(i == 62) locBackupZ62 = val; if(i == 63) locBackupZ63 = val; if(i == 64) locBackupZ64 = val;
}

// Location owner storage, starts at 1 due to often being used in combination with players.
int locBackupOwner1  = 0; int locBackupOwner2  = 0; int locBackupOwner3  = 0; int locBackupOwner4  = 0;
int locBackupOwner5  = 0; int locBackupOwner6  = 0; int locBackupOwner7  = 0; int locBackupOwner8  = 0;
int locBackupOwner9  = 0; int locBackupOwner10 = 0; int locBackupOwner11 = 0; int locBackupOwner12 = 0;
int locBackupOwner13 = 0; int locBackupOwner14 = 0; int locBackupOwner15 = 0; int locBackupOwner16 = 0;
int locBackupOwner17 = 0; int locBackupOwner18 = 0; int locBackupOwner19 = 0; int locBackupOwner20 = 0;
int locBackupOwner21 = 0; int locBackupOwner22 = 0; int locBackupOwner23 = 0; int locBackupOwner24 = 0;
int locBackupOwner25 = 0; int locBackupOwner26 = 0; int locBackupOwner27 = 0; int locBackupOwner28 = 0;
int locBackupOwner29 = 0; int locBackupOwner30 = 0; int locBackupOwner31 = 0; int locBackupOwner32 = 0;
int locBackupOwner33 = 0; int locBackupOwner34 = 0; int locBackupOwner35 = 0; int locBackupOwner36 = 0;
int locBackupOwner37 = 0; int locBackupOwner38 = 0; int locBackupOwner39 = 0; int locBackupOwner40 = 0;
int locBackupOwner41 = 0; int locBackupOwner42 = 0; int locBackupOwner43 = 0; int locBackupOwner44 = 0;
int locBackupOwner45 = 0; int locBackupOwner46 = 0; int locBackupOwner47 = 0; int locBackupOwner48 = 0;
int locBackupOwner49 = 0; int locBackupOwner50 = 0; int locBackupOwner51 = 0; int locBackupOwner52 = 0;
int locBackupOwner53 = 0; int locBackupOwner54 = 0; int locBackupOwner55 = 0; int locBackupOwner56 = 0;
int locBackupOwner57 = 0; int locBackupOwner58 = 0; int locBackupOwner59 = 0; int locBackupOwner60 = 0;
int locBackupOwner61 = 0; int locBackupOwner62 = 0; int locBackupOwner63 = 0; int locBackupOwner64 = 0;

int getLocBackupOwner(int i = 0) {
	if(i == 1)  return(locBackupOwner1);  if(i == 2)  return(locBackupOwner2);  if(i == 3)  return(locBackupOwner3);  if(i == 4)  return(locBackupOwner4);
	if(i == 5)  return(locBackupOwner5);  if(i == 6)  return(locBackupOwner6);  if(i == 7)  return(locBackupOwner7);  if(i == 8)  return(locBackupOwner8);
	if(i == 9)  return(locBackupOwner9);  if(i == 10) return(locBackupOwner10); if(i == 11) return(locBackupOwner11); if(i == 12) return(locBackupOwner12);
	if(i == 13) return(locBackupOwner13); if(i == 14) return(locBackupOwner14); if(i == 15) return(locBackupOwner15); if(i == 16) return(locBackupOwner16);
	if(i == 17) return(locBackupOwner17); if(i == 18) return(locBackupOwner18); if(i == 19) return(locBackupOwner19); if(i == 20) return(locBackupOwner20);
	if(i == 21) return(locBackupOwner21); if(i == 22) return(locBackupOwner22); if(i == 23) return(locBackupOwner23); if(i == 24) return(locBackupOwner24);
	if(i == 25) return(locBackupOwner25); if(i == 26) return(locBackupOwner26); if(i == 27) return(locBackupOwner27); if(i == 28) return(locBackupOwner28);
	if(i == 29) return(locBackupOwner29); if(i == 30) return(locBackupOwner30); if(i == 31) return(locBackupOwner31); if(i == 32) return(locBackupOwner32);
	if(i == 33) return(locBackupOwner33); if(i == 34) return(locBackupOwner34); if(i == 35) return(locBackupOwner35); if(i == 36) return(locBackupOwner36);
	if(i == 37) return(locBackupOwner37); if(i == 38) return(locBackupOwner38); if(i == 39) return(locBackupOwner39); if(i == 40) return(locBackupOwner40);
	if(i == 41) return(locBackupOwner41); if(i == 42) return(locBackupOwner42); if(i == 43) return(locBackupOwner43); if(i == 44) return(locBackupOwner44);
	if(i == 45) return(locBackupOwner45); if(i == 46) return(locBackupOwner46); if(i == 47) return(locBackupOwner47); if(i == 48) return(locBackupOwner48);
	if(i == 49) return(locBackupOwner49); if(i == 50) return(locBackupOwner50); if(i == 51) return(locBackupOwner51); if(i == 52) return(locBackupOwner52);
	if(i == 53) return(locBackupOwner53); if(i == 54) return(locBackupOwner54); if(i == 55) return(locBackupOwner55); if(i == 56) return(locBackupOwner56);
	if(i == 57) return(locBackupOwner57); if(i == 58) return(locBackupOwner58); if(i == 59) return(locBackupOwner59); if(i == 60) return(locBackupOwner60);
	if(i == 61) return(locBackupOwner61); if(i == 62) return(locBackupOwner62); if(i == 63) return(locBackupOwner63); if(i == 64) return(locBackupOwner64);
	return(0);
}

int setLocBackupOwner(int i = 0, int o = 0) {
	if(i == 1)  locBackupOwner1  = o; if(i == 2)  locBackupOwner2  = o; if(i == 3)  locBackupOwner3  = o; if(i == 4)  locBackupOwner4  = o;
	if(i == 5)  locBackupOwner5  = o; if(i == 6)  locBackupOwner6  = o; if(i == 7)  locBackupOwner7  = o; if(i == 8)  locBackupOwner8  = o;
	if(i == 9)  locBackupOwner9  = o; if(i == 10) locBackupOwner10 = o; if(i == 11) locBackupOwner11 = o; if(i == 12) locBackupOwner12 = o;
	if(i == 13) locBackupOwner13 = o; if(i == 14) locBackupOwner14 = o; if(i == 15) locBackupOwner15 = o; if(i == 16) locBackupOwner16 = o;
	if(i == 17) locBackupOwner17 = o; if(i == 18) locBackupOwner18 = o; if(i == 19) locBackupOwner19 = o; if(i == 20) locBackupOwner20 = o;
	if(i == 21) locBackupOwner21 = o; if(i == 22) locBackupOwner22 = o; if(i == 23) locBackupOwner23 = o; if(i == 24) locBackupOwner24 = o;
	if(i == 25) locBackupOwner25 = o; if(i == 26) locBackupOwner26 = o; if(i == 27) locBackupOwner27 = o; if(i == 28) locBackupOwner28 = o;
	if(i == 29) locBackupOwner29 = o; if(i == 30) locBackupOwner30 = o; if(i == 31) locBackupOwner31 = o; if(i == 32) locBackupOwner32 = o;
	if(i == 33) locBackupOwner33 = o; if(i == 34) locBackupOwner34 = o; if(i == 35) locBackupOwner35 = o; if(i == 36) locBackupOwner36 = o;
	if(i == 37) locBackupOwner37 = o; if(i == 38) locBackupOwner38 = o; if(i == 39) locBackupOwner39 = o; if(i == 40) locBackupOwner40 = o;
	if(i == 41) locBackupOwner41 = o; if(i == 42) locBackupOwner42 = o; if(i == 43) locBackupOwner43 = o; if(i == 44) locBackupOwner44 = o;
	if(i == 45) locBackupOwner45 = o; if(i == 46) locBackupOwner46 = o; if(i == 47) locBackupOwner47 = o; if(i == 48) locBackupOwner48 = o;
	if(i == 49) locBackupOwner49 = o; if(i == 50) locBackupOwner50 = o; if(i == 51) locBackupOwner51 = o; if(i == 52) locBackupOwner52 = o;
	if(i == 53) locBackupOwner53 = o; if(i == 54) locBackupOwner54 = o; if(i == 55) locBackupOwner55 = o; if(i == 56) locBackupOwner56 = o;
	if(i == 57) locBackupOwner57 = o; if(i == 58) locBackupOwner58 = o; if(i == 59) locBackupOwner59 = o; if(i == 60) locBackupOwner60 = o;
	if(i == 61) locBackupOwner61 = o; if(i == 62) locBackupOwner62 = o; if(i == 63) locBackupOwner63 = o; if(i == 64) locBackupOwner64 = o;
}

/*
** Sets both x and z value for a given index in the array.
** Note that the arrays have to be managed manually.
**
** @param i: the index in the array
** @param x: the x value to set
** @param z: the z value to set
** @param owner: the owner of the location to set
*/
void setLocXZ(int i = 0, float x = -1.0, float z = -1.0, int owner = 0) {
	setLocX(i, x);
	setLocZ(i, z);
	setLocOwner(i, owner);
}

/*
** Sets both x and z value for a given index in the backup array.
** Note that the arrays have to be managed manually.
**
** @param i: the index in the backup array
** @param x: the x value to set
** @param z the z value to set
** @param owner: the owner of the location to set
*/
void setLocBackupXZ(int i = 0, float x = -1.0, float z = -1.0, int owner = 0) {
	setLocBackupX(i, x);
	setLocBackupZ(i, z);
	setLocBackupOwner(i, z);
}

/*
** Moves the current content of the location arrays to the backupLocation arrays.
*/
void backupLocStorage() {
	for(i = 1; <= cAreaStorageSize) {
		setLocBackupXZ(i, getLocX(i), getLocZ(i), getLocOwner(i));
	}
}

/*
** Adds a location to the next unoccupied slot in the array.
** Don't call this from outside this file.
**
** @param x: the x value to set
** @param z: the z value to set
** @param owner: the owner of the location to set
*/
void storeLocXZ(float x = -1.0, float z = -1.0, int owner = 0) {
	locCounter++;
	setLocXZ(locCounter, x, z, owner);
}

/*
** Forcefully adds a location to the next unoccupied slot in the array.
**
** @param x: the x value to set
** @param z: the z value to set
** @param owner: the owner of the location to set
*/
void forceAddLocToStorage(float x = -1.0, float z = -1.0, int owner = 0) {
	storeLocXZ(x, z, owner);
}

/*
** Adds a location to the next unoccupied slot in the array if storing is enabled.
**
** @param x: the x value to set
** @param z: the z value to set
** @param owner: the owner of the location to set
*/
void addLocToStorage(float x = -1.0, float z = -1.0, int owner = 0) {
	if(isStorageActive) {
		storeLocXZ(x, z, owner);
	}
}

/*
** Converts a polar location to cartesian coordinate and adds the value to the next unoccupied slot in the array if storing is enabled.
**
** @param player: the player to use as offset (0 = 0.5/0.5)
** @param radius: the radius as a fraction
** @param angle: the angle in radians
*/
void addLocPolarWithOffsetToLocStorage(int player = 0, float radius = 0.0, float angle = 0.0) {
	if(isStorageActive) {
		storeLocXZ(getXFromPolarForPlayer(player, radius, angle), getZFromPolarForPlayer(player, radius, angle), player);
	}
}

/*
** Set the location counter to a specific value/offset.
**
** @param loc: the new value
*/
void setLocCounter(int loc = 0) {
	locCounter = loc;
}

/*
** Resets the location storage by setting the counter to 0.
*/
void resetLocStorage() {
	locCounter = 0;
}

/*
** Returns the current size of the location storage.
** Keep in mind that the indices start at 1 when using this to iterate over the array.
**
** @returns: the current size of the array
*/
int getLocStorageSize() {
	return(locCounter);
}

/*
** Enables the storage.
*/
void enableLocStorage() {
	isStorageActive = true;
}

/*
** Disables the storage.
*/
void disableLocStorage() {
	isStorageActive = false;
}

/*
** Setter for the storage.
**
** @param active: true to activate, false to deactivate
*/
void setLocStorageActive(bool state = true) {
	isStorageActive = state;
}

/*
** Checks if the location storage is currently active.
**
** @returns: true if the storage is active, false otherwise
*/
bool isLocStorageActive() {
	return(isStorageActive);
}

/*****************************
* LOCATION PLACEMENT UTILITY *
*****************************/

/*
** Creates locations between teams and stores them in the location storage.
** Locations get appended at the current position the array is at, use resetLocStorage() if you want them at the beginning.
**
** @param radius: radius from the center to the location
*/
void placeLocationsBetweenTeams(float radius = 0.0) {
	for(i = 1; <= cTeams) {
		float angleBetweenTeams = getAngleBetweenConsecutiveAngles(getTeamAngle(i - 1), getTeamAngle(i % cTeams));

		// Calculate x and z, use map center as offset.
		float x = getXFromPolar(radius, angleBetweenTeams);
		float z = getZFromPolar(radius, angleBetweenTeams);

		// Fit to map and add to storage regardless of setting.
		forceAddLocToStorage(fitToMap(x), fitToMap(z));
	}
}

/*
** Creates locations between allies and stores them in the location storage.
** Locations get appended at the current position the array is at, use resetLocStorage() if you want them at the beginning.
**
** @param radius: radius from the center to the location
*/
void placeLocationsBetweenAllies(float radius = 0.0) {
	int player = 1;

	for(i = 1; <= cTeams) {
		for(j = 1; < getNumberPlayersOnTeam(i - 1)) { // Skip last player.
			float a = getPlayerAngle(player);
			float b = getPlayerAngle(getNextPlayer(player));
			float angleBetweenPlayers = getAngleBetweenConsecutiveAngles(a, b);

			// Calculate x and z, use map center as offset.
			float x = getXFromPolar(radius, angleBetweenPlayers);
			float z = getZFromPolar(radius, angleBetweenPlayers);

			// Fit to map and add to storage regardless of setting.
			forceAddLocToStorage(fitToMap(x), fitToMap(z));

			player++;
		}

		player++;
	}
}

/*
** Creates locations between all players and stores them in the location storage.
** Locations get appended at the current position the array is at, use resetLocStorage() if you want them at the beginning.
**
** @param radius: radius from the center to the location
*/
void placeLocationsBetweenPlayers(float radius = 0.0) {
	int player = 1;

	for(i = 1; <= cTeams) {
		for(j = 1; <= getNumberPlayersOnTeam(i - 1)) {
			float a = getPlayerAngle(player);
			float b = getPlayerAngle(getNextPlayer(player));
			float angleBetweenPlayers = getAngleBetweenConsecutiveAngles(a, b);

			// Calculate x and z, use map center as offset.
			float x = getXFromPolar(radius, angleBetweenPlayers);
			float z = getZFromPolar(radius, angleBetweenPlayers);

			// Fit to map and add to storage regardless of setting.
			forceAddLocToStorage(fitToMap(x), fitToMap(z));

			player++;
		}
	}
}

/*
** Creates locations in a circle and stores them in the location storage.
** Locations get appended at the current position the array is at, use resetLocStorage() if you want them at the beginning.
**
** @param n: the number of locations to place
** @param radius: radius from the offset to place the circle at
** @param angle: the angle to start placement at; note that for an arc (range < 1.0), this will be the center of the arc
** @param range: 1.0 for full circle, 0.5 for half of a circle, etc.
** @param offsetX: the center of the circle that will be used as offset; defaults to center of the map (0.5/0.5)
** @param offsetZ: the center of the circle that will be used as offset; defaults to center of the map (0.5/0.5)
*/
void placeLocationsInCircle(int n = 1, float radius = 0.0, float angle = 0.0, float range = 1.0, float offsetX = 0.5, float offsetZ = 0.5) {
	float a = angle; // Just to make sure because 0 is interpreted as an int if we use the parameter variable.

	// Angle interval between locations.
	float interval = (2.0 * PI) / n;

	if(range < 1.0) {
		// Sector segments.
		interval = (2.0 * PI * range) / (n - 1);
		a = a - ((1.0 * (n - 1)) / 2.0) * interval;
	}

	for(i = 1; <= n) {
		float x = getXFromPolar(radius, a, 0.0) * getDimFacX() + offsetX;
		float z = getZFromPolar(radius, a, 0.0) * getDimFacZ() + offsetZ;

		// Don't fit to map if location invalid.
		forceAddLocToStorage(x, z);

		a = a + interval;
	}
}

/*
** Creates locations in a line and stores them in the location storage.
** Locations get appended at the current position the array is at, use resetLocStorage() if you want them at the beginning.
**
** @param n: the number of locations to place
** @param x1: the x coordinate of the first point
** @param z1: the z coordinate of the first point
** @param x2: the x coordinate of the second point
** @param x2: the z coordinate of the second point
** @param range: can be used to shrink (< 1.0) or to stretch (> 1.0) the line
*/
void placeLocationsInLine(int n = 1, float x1 = 0.0, float z1 = 0.0, float x2 = 0.0, float z2 = 0.0, float range = 1.0) {
	float xDist = (range * (x2 - x1)) / (n - 1);
	float zDist = (range * (z2 - z1)) / (n - 1);

	// Adjust the first point in case a range was set.
	x1 = x1 + ((1.0 - range) * (x2 - x1)) / 2.0;
	z1 = z1 + ((1.0 - range) * (z2 - z1)) / 2.0;

	// Special case for n = 1: Place between the two locations.
	if(n == 1) {
		x1 = (x2 + x1) / 2.0;
		z1 = (z2 + z1) / 2.0;
	}

	for(i = 1; <= n) {
		float x = x1 + 1.0 * (i - 1) * xDist;
		float z = z1 + 1.0 * (i - 1) * zDist;

		// Don't fit to map if location invalid.
		forceAddLocToStorage(x, z);
	}
}
