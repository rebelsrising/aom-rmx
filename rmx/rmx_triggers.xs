/*
** Triggers for observer mode, merge mode, and balance rules.
** RebelsRising
** Last edit: 20/03/2022
**
** Code style in this file is not consistent for the sake of readability when injecting code.
**
** The triggers here could be a lot more efficient, consistent and simplified.
** This is especially the case for the live/continuous update triggers.
**
** As for injection, I try to inject as much as possible unless it is necessary to use "regular" commands (e.g. getPlayer(i)).
*/

include "rmx_objects.xs";

/************************
* CONSTANTS & FUNCTIONS *
************************/

/*
** Injects the player constants and player mapping array.
*/
void injectPlayerConstants() {
	code("const int cTeams = " + cTeams + ";");
	code("const int cNonGaiaPlayers = " + cNonGaiaPlayers + ";");
	code("const int cPlayers = " + cPlayers + ";");
	code("const int cPlayersObs = " + cPlayersObs + ";");
	code("const int cPlayersMerged = " + cPlayersMerged + ";");
	code("const int cNumberTeams = " + cNumberTeams + ";");
	code("const int cNumberNonGaiaPlayers = " + cNumberNonGaiaPlayers + ";");
	code("const int cNumberPlayers = " + cNumberPlayers + ";");

	// Carry over values from rm script for player mapping.
	code("int getPlayer(int p = 0)");
	code("{");
		code("if(p == 1) return(" + getPlayer(1) + "); if(p == 2)  return(" + getPlayer(2) + ");  if(p == 3)  return(" + getPlayer(3) + ");  if(p == 4)  return(" + getPlayer(4) + ");");
		code("if(p == 5) return(" + getPlayer(5) + "); if(p == 6)  return(" + getPlayer(6) + ");  if(p == 7)  return(" + getPlayer(7) + ");  if(p == 8)  return(" + getPlayer(8) + ");");
		code("if(p == 9) return(" + getPlayer(9) + "); if(p == 10) return(" + getPlayer(10) + "); if(p == 11) return(" + getPlayer(11) + "); if(p == 12) return(" + getPlayer(12) + ");");
		code("return(0);");
	code("}");
}

/*
** Injects game constants (tech status, culture, major/minor god, techs).
*/
void injectGameConstants() {
	// Tech status constants.
	code("const int cTechStatusUnobtainable = 0;");
	code("const int cTechStatusObtainable = 1;");
	code("const int cTechStatusAvailable = 2;");
	code("const int cTechStatusResearching = 3;");
	code("const int cTechStatusActive = 4;");
	code("const int cTechStatusPersistent = 5;");

	// Culture constants.
	code("const int cCultureGreekID = 0;");
	code("const int cCultureEgyptianID = 1;");
	code("const int cCultureNorseID = 2;");
	code("const int cCultureAtlanteanID = 3;");
	// code("const int cCultureChineseID = 4;"); // Techs not supported.

	// Major god constants.
	code("const int cCivZeus = 0;");
	code("const int cCivPoseidon = 1;");
	code("const int cCivHades = 2;");
	code("const int cCivIsis = 3;");
	code("const int cCivRa = 4;");
	code("const int cCivSet = 5;");
	code("const int cCivOdin = 6;");
	code("const int cCivThor = 7;");
	code("const int cCivLoki = 8;");
	code("const int cCivKronos = 9;");
	code("const int cCivOuranos = 10;");
	code("const int cCivGaia = 11;");
	// code("const int cCivFuxiID = 12;"); // Techs not supported.
	// code("const int cCivNuwaID = 13;"); // Techs not supported.
	// code("const int cCivShennongID = 14;"); // Techs not supported.

	// Minor god constants.
	code("const int cMinorAthena = 0;");
	code("const int cMinorHermes = 1;");
	code("const int cMinorAres = 2;");
	code("const int cMinorApollo = 3;");
	code("const int cMinorDionysos = 4;");
	code("const int cMinorAphrodite = 5;");
	code("const int cMinorHephaestus = 6;");
	code("const int cMinorHera = 7;");
	code("const int cMinorArtemis = 8;");
	code("const int cMinorAnubis = 9;");
	code("const int cMinorBast = 10;");
	code("const int cMinorPtah = 11;");
	code("const int cMinorHathor = 12;");
	code("const int cMinorNephthys = 13;");
	code("const int cMinorSekhmet = 14;");
	code("const int cMinorOsiris = 15;");
	code("const int cMinorThoth = 16;");
	code("const int cMinorHorus = 17;");
	code("const int cMinorFreyja = 18;");
	code("const int cMinorHeimdall = 19;");
	code("const int cMinorForseti = 20;");
	code("const int cMinorNjord = 21;");
	code("const int cMinorSkadi = 22;");
	code("const int cMinorBragi = 23;");
	code("const int cMinorBaldr = 24;");
	code("const int cMinorTyr = 25;");
	code("const int cMinorHel = 26;");
	code("const int cMinorPrometheus = 27;");
	code("const int cMinorLeto = 28;");
	code("const int cMinorOceanus = 29;");
	code("const int cMinorHyperion = 30;");
	code("const int cMinorRheia = 31;");
	code("const int cMinorTheia = 32;");
	code("const int cMinorHelios = 33;");
	code("const int cMinorAtlas = 34;");
	code("const int cMinorHekate = 35;");

	// Tech IDs.
	code("const int cTechAge1 = 0;");
	code("const int cTechAge2 = 1;");
	code("const int cTechAge3 = 2;");
	code("const int cTechMediumArchers = 3;");
	code("const int cTechHeavyArchers = 4;");
	code("const int cTechChampionArchers = 5;");
	code("const int cTechMediumInfantry = 6;");
	code("const int cTechHeavyInfantry = 7;");
	code("const int cTechChampionInfantry = 8;");
	code("const int cTechHusbandry = 9;");
	code("const int cTechPlow = 10;");
	code("const int cTechIrrigation = 11;");
	code("const int cTechCopperWeapons = 12;");
	code("const int cTechBronzeWeapons = 13;");
	code("const int cTechIronWeapons = 14;");
	code("const int cTechCopperMail = 15;");
	code("const int cTechBronzeMail = 16;");
	code("const int cTechIronMail = 17;");
	code("const int cTechCopperShields = 18;");
	code("const int cTechBronzeShields = 19;");
	code("const int cTechIronShields = 20;");
	code("const int cTechAmbassadors = 21;");
	code("const int cTechTaxCollectors = 22;");
	code("const int cTechCoinage = 23;");
	code("const int cTechMediumCavalry = 24;");
	code("const int cTechHeavyCavalry = 25;");
	code("const int cTechChampionCavalry = 26;");
	code("const int cTechWatchTower = 27;");
	code("const int cTechGuardTower = 28;");
	code("const int cTechBallistaTower = 29;");
	code("const int cTechBoilingOil = 30;");
	code("const int cTechLevyInfantry = 31;");
	code("const int cTechBurningPitch = 32;");
	code("const int cTechMasons = 33;");
	code("const int cTechPickaxe = 34;");
	code("const int cTechHandAxe = 35;");
	code("const int cTechShaftMine = 36;");
	code("const int cTechBowSaw = 37;");
	code("const int cTechQuarry = 38;");
	code("const int cTechCarpenters = 39;");
	code("const int cTechBravery = 40;");
	code("const int cTechValleyOfTheKings = 41;");
	code("const int cTechLightningStorm = 42;");
	code("const int cTechLocustSwarm = 43;");
	code("const int cTechTornado = 44;");
	code("const int cTechWinterHarvest = 45;");
	code("const int cTechSafeguard = 46;");
	code("const int cTechRampage = 47;");
	code("const int cTechMithrilBreastplate = 48;");
	code("const int cTechCallOfValhalla = 49;");
	code("const int cTechArcticWinds = 50;");
	code("const int cTechArcticGale = 51;");
	code("const int cTechWrathOfTheDeep = 52;");
	code("const int cTechSpiritedCharge = 53;");
	code("const int cTechThunderingHooves = 54;");
	code("const int cTechBerserkergang = 55;");
	code("const int cTechRime = 56;");
	code("const int cTechFrost = 57;");
	code("const int cTechDraftHorses = 58;");
	code("const int cTechEngineers = 59;");
	code("const int cTechArchitects = 60;");
	code("const int cTechMeteor = 61;");
	code("const int cTechBoneBow = 62;");
	code("const int cTechAxeOfVengeance = 63;");
	code("const int cTechDesertWind = 64;");
	code("const int cTechEnclosedDeck = 65;");
	code("const int cTechArrowShipCladding = 66;");
	code("const int cTechFortifiedWall = 67;");
	code("const int cTechAge1Zeus = 68;");
	code("const int cTechSkinOfTheRhino = 69;");
	code("const int cTechAge15Egyptian = 70;");
	code("const int cTechSacredCats = 71;");
	code("const int cTechGraniteBlood = 72;");
	code("const int cTechHamarrtroll = 73;");
	code("const int cTechCriosphinx = 74;");
	code("const int cTechHieracosphinx = 75;");
	code("const int cTechMonstrousRage = 76;");
	code("const int cTechPhobosSpearOfPanic = 77;");
	code("const int cTechBacchanalia = 78;");
	code("const int cTechSunRay = 79;");
	code("const int cTechSylvanLore = 80;");
	code("const int cTechForgeOfOlympus = 81;");
	code("const int cTechAge1Hades = 82;");
	code("const int cTechAge1Poseidon = 83;");
	code("const int cTechCreateGold = 84;");
	code("const int cTechAge1Ra = 85;");
	code("const int cTechAge1Isis = 86;");
	code("const int cTechAge1Set = 87;");
	code("const int cTechAge1Odin = 88;");
	code("const int cTechAge1Thor = 89;");
	code("const int cTechAge1Loki = 90;");
	code("const int cTechAuroraBorealis = 91;");
	code("const int cTechAge2Athena = 92;");
	code("const int cTechAge2Ares = 93;");
	code("const int cTechAge2Hermes = 94;");
	code("const int cTechAge3Dionysos = 95;");
	code("const int cTechAge3Apollo = 96;");
	code("const int cTechAge3Aphrodite = 97;");
	code("const int cTechAge4Hera = 98;");
	code("const int cTechAge4Artemis = 99;");
	code("const int cTechAge4Hephaestus = 100;");
	code("const int cTechHuntingDogs = 101;");
	code("const int cTechHandOfTalos = 102;");
	code("const int cTechSarissa = 103;");
	code("const int cTechAegisShield = 104;");
	code("const int cTechWingedMessenger = 105;");
	code("const int cTechAge2Anubis = 106;");
	code("const int cTechAge2Bast = 107;");
	code("const int cTechAge2Ptah = 108;");
	code("const int cTechAge3Hathor = 109;");
	code("const int cTechAge3Nephthys = 110;");
	code("const int cTechAge3Sekhmet = 111;");
	code("const int cTechAge4Thoth = 112;");
	code("const int cTechAge4Osiris = 113;");
	code("const int cTechAge4Horus = 114;");
	code("const int cTechFeetOfTheJackal = 115;");
	code("const int cTechAge4 = 116;");
	code("const int cTechAge2Forseti = 117;");
	code("const int cTechAge2Heimdall = 118;");
	code("const int cTechAge2Freyja = 119;");
	code("const int cTechAge3Skadi = 120;");
	code("const int cTechAge3Bragi = 121;");
	code("const int cTechAge3Njord = 122;");
	code("const int cTechAge4Hel = 123;");
	code("const int cTechAge4Baldr = 124;");
	code("const int cTechAge4Tyr = 125;");
	code("const int cTechSignalFires = 126;");
	code("const int cTechStoneWall = 127;");
	code("const int cTechShoulderOfTalos = 128;");
	code("const int cTechSkeletonPower = 129;");
	code("const int cTechBookOfThoth = 130;");
	code("const int cTechFaceOfTheGorgon = 131;");
	code("const int cTechCitadelWall = 132;");
	code("const int cTechUnderworldPassage = 133;");
	code("const int cTechRestoration = 134;");
	code("const int cTechConscriptInfantry = 135;");
	code("const int cTechLevyArchers = 136;");
	code("const int cTechConscriptArchers = 137;");
	code("const int cTechLevyCavalry = 138;");
	code("const int cTechConscriptCavalry = 139;");
	code("const int cTechCarrierPigeons = 140;");
	code("const int cTechFloodControl = 141;");
	code("const int cTechPharaohRespawn = 142;");
	code("const int cTechStartingUnitsNorse = 143;");
	code("const int cTechStartingUnitsGreek = 144;");
	code("const int cTechStartingUnitsEgyptian = 145;");
	code("const int cTechGreatHunt = 146;");
	code("const int cTechCeaseFire = 147;");
	code("const int cTechMonument1 = 148;");
	code("const int cTechMonument2 = 149;");
	code("const int cTechMonument3 = 150;");
	code("const int cTechMonument4 = 151;");
	code("const int cTechUndermine = 152;");
	code("const int cTechDwarvenMail = 153;");
	code("const int cTechDwarvenShields = 154;");
	code("const int cTechDwarvenWeapons = 155;");
	code("const int cTechRain = 156;");
	code("const int cTechSerpentSpear = 157;");
	code("const int cTechFloodOfTheNile = 158;");
	code("const int cTechVaultsOfErebus = 159;");
	code("const int cTechLordOfHorses = 160;");
	code("const int cTechOlympicParentage = 161;");
	code("const int cTechPigSticker = 162;");
	code("const int cTechLoneWanderer = 163;");
	code("const int cTechEyesInTheForest = 164;");
	code("const int cTechScallopedAxe = 165;");
	code("const int cTechRingGiver = 166;");
	code("const int cTechLongSerpent = 167;");
	code("const int cTechSwineArray = 168;");
	code("const int cTechAge15Norse = 169;");
	code("const int cTechAge15Greek = 170;");
	code("const int cTechOdinsRavenRespawn = 171;");
	code("const int cTechSnowStorm = 172;");
	code("const int cTechHeavyCamelry = 173;");
	code("const int cTechChampionCamelry = 174;");
	code("const int cTechBronze = 175;");
	code("const int cTechPharaohRespawnOsiris = 176;");
	code("const int cTechNewKingdom = 177;");
	code("const int cTechMedjay = 178;");
	code("const int cTechFuneralRites = 179;");
	code("const int cTechSpiritOfMaat = 180;");
	code("const int cTechCityOfTheDead = 181;");
	code("const int cTechFortifyTownCenter = 182;");
	code("const int cTechHeroesZeusAge2 = 183;");
	code("const int cTechHeroesZeusAge3 = 184;");
	code("const int cTechHeroesZeusAge4 = 185;");
	code("const int cTechHeroesPoseidonAge2 = 186;");
	code("const int cTechHeroesPoseidonAge3 = 187;");
	code("const int cTechHeroesPoseidonAge4 = 188;");
	code("const int cTechHeroesHadesAge2 = 189;");
	code("const int cTechHeroesHadesAge3 = 190;");
	code("const int cTechHeroesHadesAge4 = 191;");
	code("const int cTechShaduf = 192;");
	code("const int cTechMonument0 = 193;");
	code("const int cTechRelicAnkhOfRa = 194;");
	code("const int cTechRelicEyeOfHorus = 195;");
	code("const int cTechRelicSistrumOfBast = 196;");
	code("const int cTechRelicHeadOfOrpheus = 197;");
	code("const int cTechRelicRingOfTheNibelung = 198;");
	code("const int cTechRelicStaffOfDionysus = 199;");
	code("const int cTechRelicFettersOfFenrir = 200;");
	code("const int cTechRelicOdinsSpear = 201;");
	code("const int cTechRelicKitharaOfApollo = 202;");
	code("const int cTechRelicMithrilHorseshoes = 203;");
	code("const int cTechRelicBowOfArtemis = 204;");
	code("const int cTechRelicWedjatEye = 205;");
	code("const int cTechRelicNoseOfTheSphinx = 206;");
	code("const int cTechGoldenApples = 207;");
	code("const int cTechElhrimnirKettle = 208;");
	code("const int cTechRelicArrowsOfAlfar = 209;");
	code("const int cTechRelicToothedArrows = 210;");
	code("const int cTechRelicWandOfGambantein = 211;");
	code("const int cTechProsperity = 212;");
	code("const int cTechPegasusRelicRespawn = 213;");
	code("const int cTechRelicGoldenBridleOfPegasus = 214;");
	code("const int cTechEclipse = 215;");
	code("const int cTechWillOfKronos = 216;");
	code("const int cTechLabyrinthOfMinos = 217;");
	code("const int cTechFlamesOfTyphon = 218;");
	code("const int cTechDivineBlood = 219;");
	code("const int cTechShaftsOfPlague = 220;");
	code("const int cTechVision = 221;");
	code("const int cTechBolt = 222;");
	code("const int cTechSpy = 223;");
	code("const int cTechFlamingWeapons = 224;");
	code("const int cTechFlamingWeaponsActive = 225;");
	code("const int cTechLossOfLOS = 226;");
	code("const int cTechSerpents = 227;");
	code("const int cTechAnimalMagnetism = 228;");
	code("const int cTechHealingSpring = 229;");
	code("const int cTechCurse = 230;");
	code("const int cTechSentinel = 231;");
	code("const int cTechSandstorm = 232;");
	code("const int cTechCitadel = 233;");
	code("const int cTechWalkingWoods = 234;");
	code("const int cTechRagnorok = 235;");
	code("const int cTechNidhogg = 236;");
	code("const int cTechPlenty = 237;");
	code("const int cTechSonOfOsiris = 238;");
	code("const int cTechPharaohRespawnCityOfTheDead = 239;");
	code("const int cTechEarthquake = 240;");
	code("const int cTechAthenianWall = 241;");
	code("const int cTechHeroesHadesAge1 = 242;");
	code("const int cTechHeroesPoseidonAge1 = 243;");
	code("const int cTechHeroesZeusAge1 = 244;");
	code("const int cTechDwarvenAuger = 245;");
	code("const int cTechPurseSeine = 246;");
	code("const int cTechReinforcedRam = 247;");
	code("const int cTechHuntressAxe = 248;");
	code("const int cTechForestFire = 249;");
	code("const int cTechPestilence = 250;");
	code("const int cTechRelicTriosBow = 251;");
	code("const int cTechRelicShardOfBlueCrystal = 252;");
	code("const int cTechRelicArmorOfAchilles = 253;");
	code("const int cTechRelicShipOfFingernails = 254;");
	code("const int cTechCrocodopolis = 255;");
	code("const int cTechLeatherFrameShield = 256;");
	code("const int cTechElectrumBullets = 257;");
	code("const int cTechStonesOfRedLinen = 258;");
	code("const int cTechSpearOnTheHorizon = 259;");
	code("const int cTechFeral = 260;");
	code("const int cTechAnastrophe = 261;");
	code("const int cTechTrierarch = 262;");
	code("const int cTechThracianHorses = 263;");
	code("const int cTechRelicShinglesOfSteel = 264;");
	code("const int cTechRelicEyeOfOrnlu = 265;");
	code("const int cTechRelicTuskOfTheIronBoar = 266;");
	code("const int cTechAssignLOS = 267;");
	code("const int cTechRoarOfOrthus = 268;");
	code("const int cTechAtefCrown = 269;");
	code("const int cTechConscriptSailors = 270;");
	code("const int cTechNavalOxybeles = 271;");
	code("const int cTechEnyosBowOfHorror = 272;");
	code("const int cTechDeimosSwordOfDread = 273;");
	code("const int cTechChampionElephants = 274;");
	code("const int cTechHallOfThanes = 275;");
	code("const int cTechAdzeOfWepwawet = 276;");
	code("const int cTechSlingsOfTheSun = 277;");
	code("const int cTechRamOfTheWestWind = 278;");
	code("const int cTechSunDriedMudBrick = 279;");
	code("const int cTechFuneralBarge = 280;");
	code("const int cTechNecropolis = 281;");
	code("const int cTechDisableArmoryForThor = 282;");
	code("const int cTechIronMailThor = 283;");
	code("const int cTechBronzeMailThor = 284;");
	code("const int cTechBronzeShieldsThor = 285;");
	code("const int cTechBronzeWeaponsThor = 286;");
	code("const int cTechIronShieldsThor = 287;");
	code("const int cTechIronWeaponsThor = 288;");
	code("const int cTechBurningPitchThor = 289;");
	code("const int cTechHammerOfTheGods = 290;");
	code("const int cTechMeteoricIronMail = 291;");
	code("const int cTechDragonscaleShields = 292;");
	code("const int cTechTusksOfApedemak = 293;");
	code("const int cTechRelicPandorasBox = 294;");
	code("const int cTechRelicHerasThundercloudShawl = 295;");
	code("const int cTechRelicHarmoniasNecklace = 296;");
	code("const int cTechRelicDwarfenCalipers = 297;");
	code("const int cTechOracle = 298;");
	code("const int cTechSonsOfSleipnir = 299;");
	code("const int cTechSetAge2Critter = 300;");
	code("const int cTechSetAge3Critter = 301;");
	code("const int cTechSetAge4Critter = 302;");
	code("const int cTechPoseidonHippocampusRespawn = 303;");
	code("const int cTechEgyptianBuildingBonus = 304;");
	code("const int cTechOmniscience = 305;");
	code("const int cTechMediumAxemen = 306;");
	code("const int cTechHeavyAxemen = 307;");
	code("const int cTechChampionAxemen = 308;");
	code("const int cTechMediumSpearmen = 309;");
	code("const int cTechHeavySpearmen = 310;");
	code("const int cTechChampionSpearmen = 311;");
	code("const int cTechHeavyChariots = 312;");
	code("const int cTechChampionChariots = 313;");
	code("const int cTechHeavyElephants = 314;");
	code("const int cTechLevyBarracksSoldiers = 315;");
	code("const int cTechConscriptBarracksSoldiers = 316;");
	code("const int cTechLevyMigdolSoldiers = 317;");
	code("const int cTechConscriptMigdolSoldiers = 318;");
	code("const int cTechMediumSlingers = 319;");
	code("const int cTechHeavySlingers = 320;");
	code("const int cTechChampionSlingers = 321;");
	code("const int cTechRelicGoldenLions = 322;");
	code("const int cTechRelicMonkeyHead = 323;");
	code("const int cTechLevyLonghouseSoldiers = 324;");
	code("const int cTechConscriptLonghouseSoldiers = 325;");
	code("const int cTechConscriptHillFortSoldiers = 326;");
	code("const int cTechLevyHillFortSoldiers = 327;");
	code("const int cTechThurisazRune = 328;");
	code("const int cTechGoldenLionsRelicRespawn = 329;");
	code("const int cTechMonkeyHeadRelicRespawn = 330;");
	code("const int cTechRelicCanopicJarOfImsety = 331;");
	code("const int cTechRelicTowerOfSestus = 332;");
	code("const int cTechRelicTrojanGateHinge = 333;");
	code("const int cTechSPCMeteor = 334;");
	code("const int cTechOdinsFirstRavens = 335;");
	code("const int cTechHeroesEgyptianAge1 = 336;");
	code("const int cTechWeakenAge1Units = 337;");
	code("const int cTechSaltAmphora = 338;");
	code("const int cTechMediumMigdolShadow = 339;");
	code("const int cTechPoseidonFirstHippocampus = 340;");
	code("const int cTechTempleOfHealing = 341;");
	code("const int cTechGreatestOfFifty = 342;");
	code("const int cTechCopperMailThor = 343;");
	code("const int cTechCopperShieldsThor = 344;");
	code("const int cTechCopperWeaponsThor = 345;");
	code("const int cTechWeaponOfTheTitans = 346;");
	code("const int cTechAge2Fake = 347;");
	code("const int cTechAge3Fake = 348;");
	code("const int cTechAge4Fake = 349;");
	code("const int cTechCrenellations = 350;");
	code("const int cTechBlessingOfZeus = 351;");
	code("const int cTechRelicGirdleOfHippolyta = 352;");
	code("const int cTechSharedLOS = 353;");
	code("const int cTechRelicPygmalionsStatue = 354;");
	code("const int cTechRelicBlackLotus = 355;");
	code("const int cTechDeathmatchGreek = 356;");
	code("const int cTechDeathmatchEgyptian = 357;");
	code("const int cTechDeathmatchNorse = 358;");
	code("const int cTechCeasefireEffect = 359;");
	code("const int cTechNorsebuildingBonus = 360;");
	code("const int cTechLightningMode = 361;");
	code("const int cTechFortifiedTents = 362;");
	code("const int cTechDwarvenShieldsEffect = 363;");
	code("const int cTechRelicHartersFolly = 364;");
	code("const int cTechRelicScarabPendant = 365;");
	code("const int cTechWellOfUrd = 366;");
	code("const int cTechRelicBootsOfKickEverything = 367;");
	code("const int cTechRelicAnvilOfHephaestus = 368;");
	code("const int cTechRelicPeltOfArgus = 369;");
	code("const int cTechRelicOsebergWagon = 370;");
	code("const int cTechRelicBuhenFlagstone = 371;");
	code("const int cTechRelicCatoblepasScales = 372;");
	code("const int cTechRelicTailOfCerberus = 373;");
	code("const int cTechRelicBlanketOfEmpressZoe = 374;");
	code("const int cTechRelicKhopeshOfHorus = 375;");
	code("const int cTechCeaseFireNomad = 376;");
	code("const int cTechEclipseActive = 377;");
	code("const int cTechPlentyKOTHenable = 378;");
	code("const int cTechStartingUnitsThor = 379;");
	code("const int cTechSetAge1Critter = 380;");
	code("const int cTechStartingResourcesEgyptian = 381;");
	code("const int cTechStartingResourcesGreek = 382;");
	code("const int cTechStartingResourcesNorse = 383;");
	code("const int cTechRelicReedOfNekhebet = 384;");
	code("const int cTechWeakenTrojanGate = 385;");
	code("const int cTechBuildTCFaster = 386;");
	code("const int cTechIncreaseRegeneration = 387;");
	code("const int cTechChickenStorm = 388;");
	code("const int cTechWalkingBerryBushes = 389;");
	code("const int cTechEliteHersir = 390;");
	code("const int cTechGoatunheim = 391;");
	code("const int cTechAge1Kronos = 392;");
	code("const int cTechAge1Gaia = 393;");
	code("const int cTechStartingUnitsAtlantean = 394;");
	code("const int cTechAge1Ouranos = 395;");
	code("const int cTechStartingResourcesAtlantean = 396;");
	code("const int cTechAge2Oceanus = 397;");
	code("const int cTechAge2Prometheus = 398;");
	code("const int cTechAge2Leto = 399;");
	code("const int cTechAge3Hyperion = 400;");
	code("const int cTechAge3Rheia = 401;");
	code("const int cTechAge3Theia = 402;");
	code("const int cTechAge4Helios = 403;");
	code("const int cTechAge4Hekate = 404;");
	code("const int cTechAge4Atlas = 405;");
	code("const int cTechReverseTime = 406;");
	code("const int cTechAudrey = 407;");
	code("const int cTechTraitors = 408;");
	code("const int cTechChaos = 409;");
	code("const int cTechVolcano = 410;");
	code("const int cTechBronzeWall = 411;");
	code("const int cTechIronWall = 412;");
	code("const int cTechOrichalkosWall = 413;");
	code("const int cTechTremor = 414;");
	code("const int cTechHeavyFireship = 415;");
	code("const int cTechHeartOfTheTitans = 416;");
	code("const int cTechHephaestusRevenge = 417;");
	code("const int cTechGaiaForest = 418;");
	code("const int cTechTartarianGate = 419;");
	code("const int cTechLevyMainlineUnits = 420;");
	code("const int cTechLevySpecialtyUnits = 421;");
	code("const int cTechLevyPalaceUnits = 422;");
	code("const int cTechConscriptMainlineUnits = 423;");
	code("const int cTechConscriptSpecialtyUnits = 424;");
	code("const int cTechConscriptPalaceUnits = 425;");
	code("const int cTechHaloOfTheSun = 426;");
	code("const int cTechHornsOfConsecration = 427;");
	code("const int cTechLemurianDescendants = 428;");
	code("const int cTechChannels = 429;");
	code("const int cTechAlluvialClay = 430;");
	code("const int cTechVortex = 431;");
	code("const int cTechMythicRejuvenation = 432;");
	code("const int cTechHeroicRenewal = 433;");
	code("const int cTechReverseWonder = 434;");
	code("const int cTechBiteOfTheShark = 435;");
	code("const int cTechHesperides = 436;");
	code("const int cTechHeavyChieroballista = 437;");
	code("const int cTechSpiders = 438;");
	code("const int cTechHeroize = 439;");
	code("const int cTechGemino = 440;");
	code("const int cTechNorseArmory = 441;");
	code("const int cTechImplode = 442;");
	code("const int cTechSecretsOfTheTitans = 443;");
	code("const int cTechTitanGate = 444;");
	code("const int cTechDisableTitan = 445;");
	code("const int cTechFocus = 446;");
	code("const int cTechSafePassage = 447;");
	code("const int cTechHeroicFleet = 448;");
	code("const int cTechWeightlessMace = 449;");
	code("const int cTechEyesOfAtlas = 450;");
	code("const int cTechAsperBlood = 451;");
	code("const int cTechTitanShield = 452;");
	code("const int cTechPoseidonsSecret = 453;");
	code("const int cTechRelicWhirlwindSPC = 454;");
	code("const int cTechRelicOfBronzeSPC = 455;");
	code("const int cTechRelicOfEarthquakeSPC = 456;");
	code("const int cTechBronzeXP05 = 457;");
	code("const int cTechTornadoXP05 = 458;");
	code("const int cTechRelicTitansTreasure = 459;");
	code("const int cTechVolcanicForge = 460;");
	code("const int cTechRelicGaiasBookOfKnowledge = 461;");
	code("const int cTechChangeCyclops = 462;");
	code("const int cTechChangeChimera = 463;");
	code("const int cTechChangeCaladria = 464;");
	code("const int cTechChangeManticore = 465;");
	code("const int cTechChangeNemean = 466;");
	code("const int cTechChangeHydra = 467;");
	code("const int cTechSPCLightningStorm = 468;");
	code("const int cTechDeathmatchAtlantean = 469;");
	code("const int cTechMailOfOrichalkos = 470;");
	code("const int cTechHandsOfThePharaoh = 471;");
	code("const int cTechBronzeAll = 472;");
	code("const int cTechBronzeAllThor = 473;");
	code("const int cTechCopperAll = 474;");
	code("const int cTechCopperAllThor = 475;");
	code("const int cTechIronAll = 476;");
	code("const int cTechIronAllThor = 477;");
	code("const int cTechMediumAll = 478;");
	code("const int cTechHeavyAll = 479;");
	code("const int cTechChampionAll = 480;");
	code("const int cTechRheiasGift = 481;");
	code("const int cTechTimeShiftFake = 482;");
	code("const int cTechFocusTurbo = 483;");
	code("const int cTechCelerity = 484;");
	code("const int cTechSeedOfGaia = 485;");
	code("const int cTechGrantPhoenixEgg = 486;");
	code("const int cTechIoGuardian = 487;");
	code("const int cTechDisableAtlanteanFavor = 488;");
	code("const int cTechTimeShiftFake2 = 489;");
	code("const int cTechAxeOfMuspell = 490;");
	code("const int cTechChampionChieroballista = 491;");
	code("const int cTechTraitorsSPC = 492;");
	code("const int cTechSuperRocs = 493;");
	code("const int cTechBeastSlayer = 494;");
	code("const int cTechLanceOfStone = 495;");
	code("const int cTechSuddenDeathAtlantean = 496;");
	code("const int cTechRelicOfAncestorsSPC = 497;");
	code("const int cTechSuperTitanSPC = 498;");
	code("const int cTechSuperNidhoggSPC = 499;");
	code("const int cTechPetrified = 500;");
	code("const int cTechPrometheusWeak = 501;");
	code("const int cTechPrometheusWeakest = 502;");
	code("const int cTechAge2AtlanteanHeroes = 503;");
	code("const int cTechAge4AtlanteanHeroes = 504;");
	code("const int cTechAge15Atlantean = 505;");
	code("const int cTechGaiaForestSPC = 506;");
	code("const int cTechRainFix = 507;");
	code("const int cTechAge2Odin = 508;");
	code("const int cTechAge3Odin = 509;");
	code("const int cTechAge4Odin = 510;");
	code("const int cTechGaiaPlow = 511;");
	code("const int cTechGaiaIrrigation = 512;");
	code("const int cTechGaiaFloodControl = 513;");
	code("const int cTechGaiaPickaxe = 514;");
	code("const int cTechGaiaShaftMine = 515;");
	code("const int cTechGaiaQuarry = 516;");
	code("const int cTechGaiaHandAxe = 517;");
	code("const int cTechGaiaBowSaw = 518;");
	code("const int cTechGaiaCarpenters = 519;");
	code("const int cTechGaiaHusbandry = 520;");
	code("const int cTechGaiaHuntingDogs = 521;");
	code("const int cTechGaiaPurseSeine = 522;");
	code("const int cTechGaiaSaltAmphora = 523;");
	code("const int cTechSetAge1AnimalSpeed = 524;");
}

/*
** Injects misc utility functions.
*/
void injectMiscUtil() {
	// Minimum.
	code("int min(int a = 0, int b = 9999999)");
	code("{");
		code("if(a > b)");
		code("{");
			code("return(b);");
		code("}");

		code("return(a);");
	code("}");

	// Function to calculate timestamp.
	code("string timeStamp(int time = 0)");
	code("{");

		code("int s = time;");

		// Modulo doesn't work here, find seconds manually.
		code("while(s >= 60)");
		code("{");
			code("s = s - 60;");
		code("}");

		// If less than 10 seconds, add a 0 (e.g., for 05) and return in mm:ss format.
		code("if(s < 10)");
		code("{");
			code("return(\"\" + time / 60 + \":0\" + s);");
		code("} else {");
			code("return(\"\" + time / 60 + \":\" + s);");
		code("}");

	code("}");
}

/*
** Injects array functionality.
*/
void injectArrayUtil() {
	// Keeps track of position for UnitPicks (increased by size of array upon array creation).
	code("int numUnitPicks = -1;");

	// Creates a new array.
	code("int arrayCreate(int size = 1)");
	code("{");
		code("int oldContext = xsGetContextPlayer();");
		code("xsSetContextPlayer(0);");

		code("if(numUnitPicks == -1)");
		code("{");

			// 2867 = max value to use.
			code("for(i = 0; < 2867)");
			code("{");
				code("kbUnitPickCreate(\"\" + i);");
				code("kbUnitPickSetMinimumPop(i, -1);");
				code("kbUnitPickSetMaximumPop(i, -1);");
				code("kbUnitPickSetPreferenceWeight(i, -1);");
			code("}");

			code("numUnitPicks = 0;");
		code("}");


		code("int ret = numUnitPicks;");
		code("numUnitPicks = numUnitPicks + size;");
		code("kbUnitPickSetMaximumPop(ret, 0);");
		code("xsSetContextPlayer(oldContext);");

		code("return(ret);");
	code("}");

	// Retrieves a value stored in an array as int.
	code("int arrayGetInt(int array = -1, int index = -1, bool asFloat = false)");
	code("{");
		code("int oldContext = xsGetContextPlayer();");
		code("xsSetContextPlayer(0);");
		code("int ret = -1;");

		code("if(asFloat == false)");
		code("{");
			code("ret = kbUnitPickGetMinimumPop(array + index);");
		code("} else {");
			code("ret = kbUnitPickGetPreferenceWeight(array + index);");
		code("}");

		code("xsSetContextPlayer(oldContext);");

		code("return(ret);");
	code("}");

	// Sets an int in an array.
	code("void arraySetInt(int array = -1, int index = -1, int value = -1, bool asFloat = false)");
	code("{");
		code("int oldContext = xsGetContextPlayer();");
		code("xsSetContextPlayer(0);");

		code("if(asFloat == false)");
		code("{");
			code("kbUnitPickSetMinimumPop(array + index, value);");
		code("} else {");
			code("float val = value;");
			code("kbUnitPickSetPreferenceWeight(array + index, val);");
		code("}");

		code("if(index >= kbUnitPickGetMaximumPop(array))");
		code("{");
			code("kbUnitPickSetMaximumPop(array, index + 1);");
		code("}");

		code("xsSetContextPlayer(oldContext);");
	code("}");

	// Retrieves the size of an array.
	code("int arrayGetSize(int array = -1)");
	code("{");
		code("int oldContext = xsGetContextPlayer();");
		code("xsSetContextPlayer(0);");

		code("int ret = kbUnitPickGetMaximumPop(array);");

		code("xsSetContextPlayer(oldContext);");

		code("return(ret);");
	code("}");

	// Appends a value to an array.
	code("void arrayAppend(int array = -1, int value = -1)");
	code("{");
		code("int oldContext = xsGetContextPlayer();");
		code("xsSetContextPlayer(0);");

		code("int index = kbUnitPickGetMaximumPop(array);");
		code("kbUnitPickSetMaximumPop(array, index + 1);");
		code("kbUnitPickSetMinimumPop(array + index, value);");

		code("xsSetContextPlayer(oldContext);");
	code("}");

	// Removes a value from an array (effectively decreasing the size).
	code("void arrayRemoveInt(int array = -1, int index = -1)");
	code("{");
		code("for(i = index; < arrayGetSize(array))");
		code("{");
			code("arraySetInt(array, i, arrayGetInt(array, i + 1));");
			code("arraySetInt(array, i, arrayGetInt(array, i + 1, true), true);");
		code("}");

		code("int oldContext = xsGetContextPlayer();");
		code("xsSetContextPlayer(0);");

		code("int size = kbUnitPickGetMaximumPop(array);");
		code("if(size > 0)");
		code("{");
			code("kbUnitPickSetMaximumPop(array, size - 1);");
		code("}");

		code("xsSetContextPlayer(oldContext);");
	code("}");
}

/*
** Injects utility functions to add techs to an array depending on the civilization.
*/
void injectTechArrayUtil() {
	// Adds all techs of a minor god to an array.
	code("void addMinorGod(int array = -1, int m = -1)");
	code("{");
		code("if(m == cMinorAthena) {");
			code("arrayAppend(array, cTechLabyrinthOfMinos);");
			code("arrayAppend(array, cTechAegisShield);");
			code("arrayAppend(array, cTechSarissa);");
		code("}");
		code("else if(m == cMinorHermes) {");
			code("arrayAppend(array, cTechSylvanLore);");
			code("arrayAppend(array, cTechWingedMessenger);");
			code("arrayAppend(array, cTechSpiritedCharge);");
		code("}");
		code("else if(m == cMinorAres) {");
			code("arrayAppend(array, cTechWillOfKronos);");
			code("arrayAppend(array, cTechPhobosSpearOfPanic);");
			code("arrayAppend(array, cTechDeimosSwordOfDread);");
			code("arrayAppend(array, cTechEnyosBowOfHorror);");
		code("}");
		code("else if(m == cMinorApollo) {");
			code("arrayAppend(array, cTechSunRay);");
			code("arrayAppend(array, cTechOracle);");
			code("arrayAppend(array, cTechTempleOfHealing);");
		code("}");
		code("else if(m == cMinorDionysos) {");
			code("arrayAppend(array, cTechBacchanalia);");
			code("arrayAppend(array, cTechThracianHorses);");
			code("arrayAppend(array, cTechAnastrophe);");
		code("}");
		code("else if(m == cMinorAphrodite) {");
			code("arrayAppend(array, cTechDivineBlood);");
			code("arrayAppend(array, cTechGoldenApples);");
			code("arrayAppend(array, cTechRoarOfOrthus);");
		code("}");
		code("else if(m == cMinorHephaestus) {");
			code("arrayAppend(array, cTechForgeOfOlympus);");
			code("arrayAppend(array, cTechWeaponOfTheTitans);");
			code("arrayAppend(array, cTechShoulderOfTalos);");
			code("arrayAppend(array, cTechHandOfTalos);");
		code("}");
		code("else if(m == cMinorHera) {");
			code("arrayAppend(array, cTechMonstrousRage);");
			code("arrayAppend(array, cTechAthenianWall);");
			code("arrayAppend(array, cTechFaceOfTheGorgon);");
		code("}");
		code("else if(m == cMinorArtemis) {");
			code("arrayAppend(array, cTechShaftsOfPlague);");
			code("arrayAppend(array, cTechFlamesOfTyphon);");
			code("arrayAppend(array, cTechTrierarch);");
		code("}");
		code("else if(m == cMinorAnubis) {");
			code("arrayAppend(array, cTechNecropolis);");
			code("arrayAppend(array, cTechSerpentSpear);");
			code("arrayAppend(array, cTechFeetOfTheJackal);");
		code("}");
		code("else if(m == cMinorBast) {");
			code("arrayAppend(array, cTechAdzeOfWepwawet);");
			code("arrayAppend(array, cTechSacredCats);");
			code("arrayAppend(array, cTechCriosphinx);");
			code("arrayAppend(array, cTechHieracosphinx);");
		code("}");
		code("else if(m == cMinorPtah) {");
			code("arrayAppend(array, cTechShaduf);");
			code("arrayAppend(array, cTechScallopedAxe);");
			code("arrayAppend(array, cTechLeatherFrameShield);");
			code("arrayAppend(array, cTechElectrumBullets);");
		code("}");
		code("else if(m == cMinorHathor) {");
			code("arrayAppend(array, cTechMedjay);");
			code("arrayAppend(array, cTechCrocodopolis);");
			code("arrayAppend(array, cTechSunDriedMudBrick);");
		code("}");
		code("else if(m == cMinorNephthys) {");
			code("arrayAppend(array, cTechSpiritOfMaat);");
			code("arrayAppend(array, cTechFuneralRites);");
			code("arrayAppend(array, cTechCityOfTheDead);");
		code("}");
		code("else if(m == cMinorSekhmet) {");
			code("arrayAppend(array, cTechStonesOfRedLinen);");
			code("arrayAppend(array, cTechRamOfTheWestWind);");
			code("arrayAppend(array, cTechSlingsOfTheSun);");
			code("arrayAppend(array, cTechBoneBow);");
		code("}");
		code("else if(m == cMinorOsiris) {");
			code("arrayAppend(array, cTechAtefCrown);");
			code("arrayAppend(array, cTechDesertWind);");
			code("arrayAppend(array, cTechNewKingdom);");
			code("arrayAppend(array, cTechFuneralBarge);");
		code("}");
		code("else if(m == cMinorThoth) {");
			code("arrayAppend(array, cTechValleyOfTheKings);");
			code("arrayAppend(array, cTechTusksOfApedemak);");
			code("arrayAppend(array, cTechBookOfThoth);");
		code("}");
		code("else if(m == cMinorHorus) {");
			code("arrayAppend(array, cTechAxeOfVengeance);");
			code("arrayAppend(array, cTechGreatestOfFifty);");
			code("arrayAppend(array, cTechSpearOnTheHorizon);");
		code("}");
		code("else if(m == cMinorFreyja) {");
			code("arrayAppend(array, cTechAuroraBorealis);");
			code("arrayAppend(array, cTechThunderingHooves);");
		code("}");
		code("else if(m == cMinorHeimdall) {");
			code("arrayAppend(array, cTechSafeguard);");
			code("arrayAppend(array, cTechElhrimnirKettle);");
			code("arrayAppend(array, cTechArcticWinds);");
		code("}");
		code("else if(m == cMinorForseti) {");
			code("arrayAppend(array, cTechHallOfThanes);");
			code("arrayAppend(array, cTechMithrilBreastplate);");
			code("arrayAppend(array, cTechHamarrtroll);");
		code("}");
		code("else if(m == cMinorNjord) {");
			code("arrayAppend(array, cTechRingGiver);");
			code("arrayAppend(array, cTechWrathOfTheDeep);");
			code("arrayAppend(array, cTechLongSerpent);");
		code("}");
		code("else if(m == cMinorSkadi) {");
			code("arrayAppend(array, cTechRime);");
			code("arrayAppend(array, cTechWinterHarvest);");
			code("arrayAppend(array, cTechHuntressAxe);");
		code("}");
		code("else if(m == cMinorBragi) {");
			code("arrayAppend(array, cTechSwineArray);");
			code("arrayAppend(array, cTechThurisazRune);");
			code("arrayAppend(array, cTechCallOfValhalla);");
		code("}");
		code("else if(m == cMinorBaldr) {");
			code("arrayAppend(array, cTechArcticGale);");
			code("arrayAppend(array, cTechSonsOfSleipnir);");
			code("arrayAppend(array, cTechDwarvenAuger);");
		code("}");
		code("else if(m == cMinorTyr) {");
			code("arrayAppend(array, cTechBerserkergang);");
			code("arrayAppend(array, cTechBravery);");
		code("}");
		code("else if(m == cMinorHel) {");
			code("arrayAppend(array, cTechRampage);");
			code("arrayAppend(array, cTechGraniteBlood);");
		code("}");
		code("else if(m == cMinorPrometheus) {");
			code("arrayAppend(array, cTechHeartOfTheTitans);");
			code("arrayAppend(array, cTechAlluvialClay);");
		code("}");
		code("else if(m == cMinorLeto) {");
			code("arrayAppend(array, cTechHephaestusRevenge);");
			code("arrayAppend(array, cTechVolcanicForge);");
		code("}");
		code("else if(m == cMinorOceanus) {");
			code("arrayAppend(array, cTechBiteOfTheShark);");
			code("arrayAppend(array, cTechWeightlessMace);");
		code("}");
		code("else if(m == cMinorHyperion) {");
			code("arrayAppend(array, cTechGemino);");
			code("arrayAppend(array, cTechHeroicRenewal);");
		code("}");
		code("else if(m == cMinorRheia) {");
			code("arrayAppend(array, cTechHornsOfConsecration);");
			code("arrayAppend(array, cTechMailOfOrichalkos);");
			code("arrayAppend(array, cTechRheiasGift);");
		code("}");
		code("else if(m == cMinorTheia) {");
			code("arrayAppend(array, cTechLanceOfStone);");
			code("arrayAppend(array, cTechPoseidonsSecret);");
			code("arrayAppend(array, cTechLemurianDescendants);");
		code("}");
		code("else if(m == cMinorHelios) {");
			code("arrayAppend(array, cTechPetrified);");
			code("arrayAppend(array, cTechHaloOfTheSun);");
		code("}");
		code("else if(m == cMinorAtlas) {");
			code("arrayAppend(array, cTechTitanShield);");
			code("arrayAppend(array, cTechEyesOfAtlas);");
			code("arrayAppend(array, cTechIoGuardian);");
		code("}");
		code("else if(m == cMinorHekate) {");
			code("arrayAppend(array, cTechMythicRejuvenation);");
			code("arrayAppend(array, cTechCelerity);");
			code("arrayAppend(array, cTechAsperBlood);");
		code("}");
	code("}");

	// Assigns all available techs of the current context player to an array.
	code("void assignTechs(int array = -1)");
	code("{");
		code("int civ = kbGetCiv();");

		// Armory techs.
		code("if(civ == cCivThor) {");
			code("arrayAppend(array, cTechBronzeWeaponsThor);");
			code("arrayAppend(array, cTechBronzeMailThor);");
			code("arrayAppend(array, cTechBronzeShieldsThor);");
			code("arrayAppend(array, cTechCopperWeaponsThor);");
			code("arrayAppend(array, cTechCopperMailThor);");
			code("arrayAppend(array, cTechCopperShieldsThor);");
			code("arrayAppend(array, cTechIronWeaponsThor);");
			code("arrayAppend(array, cTechIronMailThor);");
			code("arrayAppend(array, cTechIronShieldsThor);");
			code("arrayAppend(array, cTechBurningPitchThor);");
			code("arrayAppend(array, cTechHammerOfTheGods);");
			code("arrayAppend(array, cTechDragonscaleShields);");
			code("arrayAppend(array, cTechMeteoricIronMail);");
		code("} else {");
			code("arrayAppend(array, cTechBronzeWeapons);");
			code("arrayAppend(array, cTechBronzeMail);");
			code("arrayAppend(array, cTechBronzeShields);");
			code("arrayAppend(array, cTechCopperWeapons);");
			code("arrayAppend(array, cTechCopperMail);");
			code("arrayAppend(array, cTechCopperShields);");
			code("arrayAppend(array, cTechIronWeapons);");
			code("arrayAppend(array, cTechIronMail);");
			code("arrayAppend(array, cTechIronShields);");
			code("arrayAppend(array, cTechBurningPitch);");
		code("}");

		// Mythological techs and minor gods.
		code("if(civ == cCivZeus) {");
			code("addMinorGod(array, cMinorHermes);");
			code("addMinorGod(array, cMinorAthena);");
			code("addMinorGod(array, cMinorApollo);");
			code("addMinorGod(array, cMinorDionysos);");
			code("addMinorGod(array, cMinorHephaestus);");
			code("addMinorGod(array, cMinorHera);");
			code("arrayAppend(array, cTechOlympicParentage);");
			code("arrayAppend(array, cTechAge2Hermes);");
			code("arrayAppend(array, cTechAge2Athena);");
			code("arrayAppend(array, cTechAge3Apollo);");
			code("arrayAppend(array, cTechAge3Dionysos);");
			code("arrayAppend(array, cTechAge4Hephaestus);");
			code("arrayAppend(array, cTechAge4Hera);");
		code("}");
		code("else if(civ == cCivPoseidon) {");
			code("addMinorGod(array, cMinorHermes);");
			code("addMinorGod(array, cMinorAres);");
			code("addMinorGod(array, cMinorDionysos);");
			code("addMinorGod(array, cMinorAphrodite);");
			code("addMinorGod(array, cMinorHephaestus);");
			code("addMinorGod(array, cMinorArtemis);");
			code("arrayAppend(array, cTechLordOfHorses);");
			code("arrayAppend(array, cTechAge2Hermes);");
			code("arrayAppend(array, cTechAge2Ares);");
			code("arrayAppend(array, cTechAge3Dionysos);");
			code("arrayAppend(array, cTechAge3Aphrodite);");
			code("arrayAppend(array, cTechAge4Hephaestus);");
			code("arrayAppend(array, cTechAge4Artemis);");
		code("}");
		code("else if(civ == cCivHades) {");
			code("addMinorGod(array, cMinorAres);");
			code("addMinorGod(array, cMinorAthena);");
			code("addMinorGod(array, cMinorApollo);");
			code("addMinorGod(array, cMinorAphrodite);");
			code("addMinorGod(array, cMinorHephaestus);");
			code("addMinorGod(array, cMinorArtemis);");
			code("arrayAppend(array, cTechVaultsOfErebus);");
			code("arrayAppend(array, cTechAge2Ares);");
			code("arrayAppend(array, cTechAge2Athena);");
			code("arrayAppend(array, cTechAge3Apollo);");
			code("arrayAppend(array, cTechAge3Aphrodite);");
			code("arrayAppend(array, cTechAge4Hephaestus);");
			code("arrayAppend(array, cTechAge4Artemis);");
		code("}");
		code("else if(civ == cCivSet) {");
			code("addMinorGod(array, cMinorAnubis);");
			code("addMinorGod(array, cMinorPtah);");
			code("addMinorGod(array, cMinorSekhmet);");
			code("addMinorGod(array, cMinorNephthys);");
			code("addMinorGod(array, cMinorHorus);");
			code("addMinorGod(array, cMinorThoth);");
			code("arrayAppend(array, cTechFeral);");
			code("arrayAppend(array, cTechAge2Anubis);");
			code("arrayAppend(array, cTechAge2Ptah);");
			code("arrayAppend(array, cTechAge3Sekhmet);");
			code("arrayAppend(array, cTechAge3Nephthys);");
			code("arrayAppend(array, cTechAge4Horus);");
			code("arrayAppend(array, cTechAge4Thoth);");
		code("}");
		code("else if(civ == cCivIsis) {");
			code("addMinorGod(array, cMinorAnubis);");
			code("addMinorGod(array, cMinorBast);");
			code("addMinorGod(array, cMinorHathor);");
			code("addMinorGod(array, cMinorNephthys);");
			code("addMinorGod(array, cMinorThoth);");
			code("addMinorGod(array, cMinorOsiris);");
			code("arrayAppend(array, cTechFloodOfTheNile);");
			code("arrayAppend(array, cTechAge2Anubis);");
			code("arrayAppend(array, cTechAge2Bast);");
			code("arrayAppend(array, cTechAge3Hathor);");
			code("arrayAppend(array, cTechAge3Nephthys);");
			code("arrayAppend(array, cTechAge4Thoth);");
			code("arrayAppend(array, cTechAge4Osiris);");
		code("}");
		code("else if(civ == cCivRa) {");
			code("addMinorGod(array, cMinorBast);");
			code("addMinorGod(array, cMinorPtah);");
			code("addMinorGod(array, cMinorSekhmet);");
			code("addMinorGod(array, cMinorHathor);");
			code("addMinorGod(array, cMinorOsiris);");
			code("addMinorGod(array, cMinorHorus);");
			code("arrayAppend(array, cTechSkinOfTheRhino);");
			code("arrayAppend(array, cTechAge2Bast);");
			code("arrayAppend(array, cTechAge2Ptah);");
			code("arrayAppend(array, cTechAge3Sekhmet);");
			code("arrayAppend(array, cTechAge3Hathor);");
			code("arrayAppend(array, cTechAge4Osiris);");
			code("arrayAppend(array, cTechAge4Horus);");
		code("}");
		code("else if(civ == cCivThor) {");
			code("addMinorGod(array, cMinorFreyja);");
			code("addMinorGod(array, cMinorForseti);");
			code("addMinorGod(array, cMinorBragi);");
			code("addMinorGod(array, cMinorSkadi);");
			code("addMinorGod(array, cMinorBaldr);");
			code("addMinorGod(array, cMinorTyr);");
			code("arrayAppend(array, cTechPigSticker);");
			code("arrayAppend(array, cTechAge2Freyja);");
			code("arrayAppend(array, cTechAge2Forseti);");
			code("arrayAppend(array, cTechAge3Bragi);");
			code("arrayAppend(array, cTechAge3Skadi);");
			code("arrayAppend(array, cTechAge4Baldr);");
			code("arrayAppend(array, cTechAge4Tyr);");
		code("}");
		code("else if(civ == cCivLoki) {");
			code("addMinorGod(array, cMinorHeimdall);");
			code("addMinorGod(array, cMinorForseti);");
			code("addMinorGod(array, cMinorBragi);");
			code("addMinorGod(array, cMinorNjord);");
			code("addMinorGod(array, cMinorTyr);");
			code("addMinorGod(array, cMinorHel);");
			code("arrayAppend(array, cTechEyesInTheForest);");
			code("arrayAppend(array, cTechAge2Heimdall);");
			code("arrayAppend(array, cTechAge2Forseti);");
			code("arrayAppend(array, cTechAge3Bragi);");
			code("arrayAppend(array, cTechAge3Njord);");
			code("arrayAppend(array, cTechAge4Tyr);");
			code("arrayAppend(array, cTechAge4Hel);");
		code("}");
		code("else if(civ == cCivOdin) {");
			code("addMinorGod(array, cMinorHeimdall);");
			code("addMinorGod(array, cMinorFreyja);");
			code("addMinorGod(array, cMinorSkadi);");
			code("addMinorGod(array, cMinorNjord);");
			code("addMinorGod(array, cMinorTyr);");
			code("addMinorGod(array, cMinorBaldr);");
			code("arrayAppend(array, cTechLoneWanderer);");
			code("arrayAppend(array, cTechAge2Heimdall);");
			code("arrayAppend(array, cTechAge2Freyja);");
			code("arrayAppend(array, cTechAge3Skadi);");
			code("arrayAppend(array, cTechAge3Njord);");
			code("arrayAppend(array, cTechAge4Tyr);");
			code("arrayAppend(array, cTechAge4Baldr);");
		code("}");
		code("else if(civ == cCivOuranos) {");
			code("addMinorGod(array, cMinorPrometheus);");
			code("addMinorGod(array, cMinorOceanus);");
			code("addMinorGod(array, cMinorTheia);");
			code("addMinorGod(array, cMinorHyperion);");
			code("addMinorGod(array, cMinorHelios);");
			code("addMinorGod(array, cMinorHekate);");
			code("arrayAppend(array, cTechSafePassage);");
			code("arrayAppend(array, cTechAge2Prometheus);");
			code("arrayAppend(array, cTechAge2Oceanus);");
			code("arrayAppend(array, cTechAge3Theia);");
			code("arrayAppend(array, cTechAge3Hyperion);");
			code("arrayAppend(array, cTechAge4Helios);");
			code("arrayAppend(array, cTechAge4Hekate);");
		code("}");
		code("else if(civ == cCivKronos) {");
			code("addMinorGod(array, cMinorPrometheus);");
			code("addMinorGod(array, cMinorLeto);");
			code("addMinorGod(array, cMinorRheia);");
			code("addMinorGod(array, cMinorHyperion);");
			code("addMinorGod(array, cMinorHelios);");
			code("addMinorGod(array, cMinorAtlas);");
			code("arrayAppend(array, cTechFocus);");
			code("arrayAppend(array, cTechAge2Prometheus);");
			code("arrayAppend(array, cTechAge2Leto);");
			code("arrayAppend(array, cTechAge3Rheia);");
			code("arrayAppend(array, cTechAge3Hyperion);");
			code("arrayAppend(array, cTechAge4Helios);");
			code("arrayAppend(array, cTechAge4Atlas);");
		code("}");
		code("else if(civ == cCivGaia) {");
			code("addMinorGod(array, cMinorLeto);");
			code("addMinorGod(array, cMinorOceanus);");
			code("addMinorGod(array, cMinorTheia);");
			code("addMinorGod(array, cMinorRheia);");
			code("addMinorGod(array, cMinorHekate);");
			code("addMinorGod(array, cMinorAtlas);");
			code("arrayAppend(array, cTechChannels);");
			code("arrayAppend(array, cTechAge2Leto);");
			code("arrayAppend(array, cTechAge2Oceanus);");
			code("arrayAppend(array, cTechAge3Theia);");
			code("arrayAppend(array, cTechAge3Rheia);");
			code("arrayAppend(array, cTechAge4Hekate);");
			code("arrayAppend(array, cTechAge4Atlas);");
		code("}");

		// Eco techs.
		code("if(civ == cCivGaia && " + boolToString(cVBPEnabled) + " == true) {");
			// Gaia.
			code("arrayAppend(array, cTechGaiaHandAxe);");
			code("arrayAppend(array, cTechGaiaPickaxe);");
			code("arrayAppend(array, cTechGaiaHusbandry);");
			code("arrayAppend(array, cTechGaiaHuntingDogs);");
			code("arrayAppend(array, cTechGaiaPlow);");
			code("arrayAppend(array, cTechGaiaBowSaw);");
			code("arrayAppend(array, cTechGaiaShaftMine);");
			code("arrayAppend(array, cTechGaiaCarpenters);");
			code("arrayAppend(array, cTechGaiaQuarry);");
			code("arrayAppend(array, cTechGaiaIrrigation);");
			code("arrayAppend(array, cTechGaiaFloodControl);");
			code("arrayAppend(array, cTechGaiaPurseSeine);");
			code("arrayAppend(array, cTechGaiaSaltAmphora);");
		code("} else {");
			// Everyone else.
			code("arrayAppend(array, cTechHandAxe);");
			code("arrayAppend(array, cTechPickaxe);");
			code("arrayAppend(array, cTechHusbandry);");
			code("arrayAppend(array, cTechHuntingDogs);");
			code("arrayAppend(array, cTechPlow);");
			code("arrayAppend(array, cTechBowSaw);");
			code("arrayAppend(array, cTechShaftMine);");
			code("arrayAppend(array, cTechCarpenters);");
			code("arrayAppend(array, cTechQuarry);");
			code("arrayAppend(array, cTechIrrigation);");
			code("arrayAppend(array, cTechFloodControl);");
			code("arrayAppend(array, cTechPurseSeine);");
			code("arrayAppend(array, cTechSaltAmphora);");
		code("}");

		// Common techs.
		code("arrayAppend(array, cTechSecretsOfTheTitans);");
		code("arrayAppend(array, cTechMasons);");
		code("arrayAppend(array, cTechArchitects);");
		code("arrayAppend(array, cTechStoneWall);");
		code("arrayAppend(array, cTechSignalFires);");
		code("arrayAppend(array, cTechCarrierPigeons);");
		code("arrayAppend(array, cTechCrenellations);");
		code("arrayAppend(array, cTechAmbassadors);");
		code("arrayAppend(array, cTechTaxCollectors);");
		code("arrayAppend(array, cTechCoinage);");
		code("arrayAppend(array, cTechBoilingOil);");
		code("arrayAppend(array, cTechDraftHorses);");
		code("arrayAppend(array, cTechEngineers);");
		code("arrayAppend(array, cTechEnclosedDeck);");
		code("arrayAppend(array, cTechHeroicFleet);");
		code("arrayAppend(array, cTechArrowShipCladding);");
		code("arrayAppend(array, cTechReinforcedRam);");
		code("arrayAppend(array, cTechNavalOxybeles);");
		code("arrayAppend(array, cTechConscriptSailors);");
		code("arrayAppend(array, cTechFortifyTownCenter);");

		// Culture-related techs.
		code("if(civ == cCivZeus || civ == cCivPoseidon || civ == cCivHades) {");
			code("arrayAppend(array, cTechLevyInfantry);");
			code("arrayAppend(array, cTechLevyArchers);");
			code("arrayAppend(array, cTechLevyCavalry);");
			code("arrayAppend(array, cTechConscriptInfantry);");
			code("arrayAppend(array, cTechConscriptArchers);");
			code("arrayAppend(array, cTechConscriptCavalry);");
			code("arrayAppend(array, cTechMediumInfantry);");
			code("arrayAppend(array, cTechMediumArchers);");
			code("arrayAppend(array, cTechMediumCavalry);");
			code("arrayAppend(array, cTechHeavyInfantry);");
			code("arrayAppend(array, cTechHeavyArchers);");
			code("arrayAppend(array, cTechHeavyCavalry);");
			code("arrayAppend(array, cTechChampionInfantry);");
			code("arrayAppend(array, cTechChampionArchers);");
			code("arrayAppend(array, cTechChampionCavalry);");
			code("arrayAppend(array, cTechBeastSlayer);");
			code("arrayAppend(array, cTechGuardTower);");
			code("arrayAppend(array, cTechFortifiedWall);");
			code("arrayAppend(array, cTechWatchTower);");
		code("}");
		code("else if(civ == cCivOdin || civ == cCivThor || civ == cCivLoki) {");
			code("arrayAppend(array, cTechLevyLonghouseSoldiers);");
			code("arrayAppend(array, cTechLevyHillFortSoldiers);");
			code("arrayAppend(array, cTechConscriptLonghouseSoldiers);");
			code("arrayAppend(array, cTechConscriptHillFortSoldiers);");
			code("arrayAppend(array, cTechMediumInfantry);");
			code("arrayAppend(array, cTechMediumCavalry);");
			code("arrayAppend(array, cTechHeavyInfantry);");
			code("arrayAppend(array, cTechHeavyCavalry);");
			code("arrayAppend(array, cTechChampionInfantry);");
			code("arrayAppend(array, cTechChampionCavalry);");
			code("arrayAppend(array, cTechAxeOfMuspell);");
			code("arrayAppend(array, cTechWatchTower);");
		code("}");
		code("else if(civ == cCivOuranos || civ == cCivKronos || civ == cCivGaia) {");
			code("arrayAppend(array, cTechMediumInfantry);");
			code("arrayAppend(array, cTechMediumArchers);");
			code("arrayAppend(array, cTechMediumCavalry);");
			code("arrayAppend(array, cTechHeavyInfantry);");
			code("arrayAppend(array, cTechHeavyArchers);");
			code("arrayAppend(array, cTechHeavyCavalry);");
			code("arrayAppend(array, cTechChampionInfantry);");
			code("arrayAppend(array, cTechChampionArchers);");
			code("arrayAppend(array, cTechChampionCavalry);");
			code("arrayAppend(array, cTechLevyMainlineUnits);");
			code("arrayAppend(array, cTechLevySpecialtyUnits);");
			code("arrayAppend(array, cTechLevyPalaceUnits);");
			code("arrayAppend(array, cTechConscriptMainlineUnits);");
			code("arrayAppend(array, cTechConscriptSpecialtyUnits);");
			code("arrayAppend(array, cTechConscriptPalaceUnits);");
			code("arrayAppend(array, cTechWatchTower);");
			code("arrayAppend(array, cTechHeavyChieroballista);");
			code("arrayAppend(array, cTechChampionChieroballista);");
			code("arrayAppend(array, cTechIronWall);");
			code("arrayAppend(array, cTechBronzeWall);");
			code("arrayAppend(array, cTechOrichalkosWall);");
			code("arrayAppend(array, cTechGuardTower);");
		code("}");
		code("else if(civ == cCivRa || civ == cCivSet || civ == cCivIsis) {");
			code("arrayAppend(array, cTechMediumSpearmen);");
			code("arrayAppend(array, cTechMediumAxemen);");
			code("arrayAppend(array, cTechMediumSlingers);");
			code("arrayAppend(array, cTechHeavySpearmen);");
			code("arrayAppend(array, cTechHeavyAxemen);");
			code("arrayAppend(array, cTechHeavySlingers);");
			code("arrayAppend(array, cTechChampionSpearmen);");
			code("arrayAppend(array, cTechChampionAxemen);");
			code("arrayAppend(array, cTechChampionSlingers);");
			code("arrayAppend(array, cTechHeavyChariots);");
			code("arrayAppend(array, cTechHeavyCamelry);");
			code("arrayAppend(array, cTechHeavyElephants);");
			code("arrayAppend(array, cTechChampionChariots);");
			code("arrayAppend(array, cTechChampionCamelry);");
			code("arrayAppend(array, cTechChampionElephants);");
			code("arrayAppend(array, cTechLevyBarracksSoldiers);");
			code("arrayAppend(array, cTechLevyMigdolSoldiers);");
			code("arrayAppend(array, cTechConscriptBarracksSoldiers);");
			code("arrayAppend(array, cTechConscriptMigdolSoldiers);");
			code("arrayAppend(array, cTechHandsOfThePharaoh);");
			code("arrayAppend(array, cTechBallistaTower);");
			code("arrayAppend(array, cTechCitadelWall);");
			code("arrayAppend(array, cTechFortifiedWall);");
			code("arrayAppend(array, cTechGuardTower);");
		code("}");
	code("}");
}

/*
** Injects utility functions for techs to get tech icons and to check if a tech is an age-up tech.
*/
void injectTechUtil() {
	// Function for tech icons.
	code("string getTechIcon(int techID = -1)");
	code("{");
		// Convert patched Gaia techs right away.
		code("if(techID == cTechGaiaHandAxe) techID = cTechHandAxe;");
		code("else if(techID == cTechGaiaPickaxe) techID = cTechPickaxe;");
		code("else if(techID == cTechGaiaHuntingDogs) techID = cTechHuntingDogs;");
		code("else if(techID == cTechGaiaHusbandry) techID = cTechHusbandry;");
		code("else if(techID == cTechGaiaPlow) techID = cTechPlow;");
		code("else if(techID == cTechGaiaBowSaw) techID = cTechBowSaw;");
		code("else if(techID == cTechGaiaShaftMine) techID = cTechShaftMine;");
		code("else if(techID == cTechGaiaCarpenters) techID = cTechCarpenters;");
		code("else if(techID == cTechGaiaQuarry) techID = cTechQuarry;");
		code("else if(techID == cTechGaiaIrrigation) techID = cTechIrrigation;");
		code("else if(techID == cTechGaiaFloodControl) techID = cTechFloodControl;");
		code("else if(techID == cTechGaiaPurseSeine) techID = cTechPurseSeine;");
		code("else if(techID == cTechGaiaSaltAmphora) techID = cTechSaltAmphora;");

		// Variables.
		code("bool hasExpSuffix = false;");
		code("string techName = kbGetTechName(techID);");
		code("string prefix = \"<icon=(20)(icons/improvement \";");
		code("string suffix = \" icon)>\";");
		code("string expSuffix = \" icons 64)>\";");

		// Greek.
		// Minor gods.
		code("if(techID == cTechAge2Athena) techName = \"athena\";");
		code("else if(techID == cTechAge2Hermes) techName = \"hermes\";");
		code("else if(techID == cTechAge2Ares) techName = \"ares\";");
		code("else if(techID == cTechAge3Apollo) techName = \"apollo\";");
		code("else if(techID == cTechAge3Dionysos) techName = \"dionysos\";");
		code("else if(techID == cTechAge3Aphrodite) techName = \"aphrodite\";");
		code("else if(techID == cTechAge4Hephaestus) techName = \"hephaestus\";");
		code("else if(techID == cTechAge4Hera) techName = \"hera\";");
		code("else if(techID == cTechAge4Artemis) techName = \"artemis\";");

		// Mythology.
		code("else if(techID == cTechBeastSlayer) hasExpSuffix = true;");
		code("else if(techID == cTechOlympicParentage) techName = \"olympic patronage\";");
		code("else if(techID == cTechLordOfHorses) techName = \"lord of the horses\";");
		code("else if(techID == cTechVaultsOfErebus) techName = \"wealth of erebus\";");
		code("else if(techID == cTechMonstrousRage) techName = \"monsterous rage\";");
		code("else if(techID == cTechHandOfTalos) techName = \"iron colossus\";");
		code("else if(techID == cTechShoulderOfTalos) techName = \"bronze colossus\";");
		code("else if(techID == cTechFlamesOfTyphon)");
		code("{");
			code("return(\"<icon=(20)(icons/god power inferno icon)>\");"); // Directly return this as it's completely different.
		code("}");

		// Military.
		code("else if(techID == cTechMediumArchers) techName = \"medium archer\";");
		code("else if(techID == cTechHeavyArchers) techName = \"heavy archer\";");
		code("else if(techID == cTechChampionArchers) techName = \"champion archer\";");

		// Egyptian.
		// Minor gods.
		code("else if(techID == cTechAge2Anubis) techName = \"anubis\";");
		code("else if(techID == cTechAge2Bast) techName = \"bast\";");
		code("else if(techID == cTechAge2Ptah) techName = \"ptah\";");
		code("else if(techID == cTechAge3Hathor) techName = \"hathor\";");
		code("else if(techID == cTechAge3Nephthys) techName = \"nephthys\";");
		code("else if(techID == cTechAge3Sekhmet) techName = \"sekhmet\";");
		code("else if(techID == cTechAge4Osiris) techName = \"osiris\";");
		code("else if(techID == cTechAge4Thoth) techName = \"thoth\";");
		code("else if(techID == cTechAge4Horus) techName = \"horus\";");

		// Mythology.
		code("else if(techID == cTechHandsOfThePharaoh) hasExpSuffix = true;");
		code("else if(techID == cTechHieracosphinx) techName = \"hieraco sphinx\";");
		code("else if(techID == cTechCriosphinx) techName = \"crio sphinx\";");
		code("else if(techID == cTechSunDriedMudBrick) techName = \"sun dried brick\";");
		code("else if(techID == cTechAxeOfVengeance) techName = \"vengeance\";");
		code("else if(techID == cTechRamOfTheWestWind) techName = \"ram of the wind\";");

		// Military.
		code("else if(techID == cTechLevyBarracksSoldiers) techName = \"levy barracks\";");
		code("else if(techID == cTechLevyMigdolSoldiers) techName = \"levy migdol\";");
		code("else if(techID == cTechMediumSlingers) techName = \"medium slinger\";");
		code("else if(techID == cTechHeavySlingers) techName = \"heavy slinger\";");
		code("else if(techID == cTechChampionSlingers) techName = \"champion slinger\";");
		code("else if(techID == cTechHeavyElephants) techName = \"heavy elephant\";");
		code("else if(techID == cTechChampionElephants) techName = \"champion elephant\";");
		code("else if(techID == cTechChampionChariots) techName = \"champion archer\";");

		// Norse.
		// Minor gods.
		code("else if(techID == cTechAge2Freyja) techName = \"freyja\";");
		code("else if(techID == cTechAge2Heimdall) techName = \"heimdall\";");
		code("else if(techID == cTechAge2Forseti) techName = \"forseti\";");
		code("else if(techID == cTechAge3Njord) techName = \"njord\";");
		code("else if(techID == cTechAge3Skadi) techName = \"frigg\";");
		code("else if(techID == cTechAge3Bragi) techName = \"bragi\";");
		code("else if(techID == cTechAge4Baldr) techName = \"baldr\";");
		code("else if(techID == cTechAge4Tyr) techName = \"tyr\";");
		code("else if(techID == cTechAge4Hel) techName = \"hel\";");

		// Thor upgrades.
		code("else if(techID == cTechBronzeWeaponsThor) techName = \"bronze weapons\";");
		code("else if(techID == cTechBronzeMailThor) techName = \"bronze mail\";");
		code("else if(techID == cTechBronzeShieldsThor) techName = \"bronze shields\";");
		code("else if(techID == cTechCopperWeaponsThor) techName = \"copper weapons\";");
		code("else if(techID == cTechCopperMailThor) techName = \"copper mail\";");
		code("else if(techID == cTechCopperShieldsThor) techName = \"copper shields\";");
		code("else if(techID == cTechIronWeaponsThor) techName = \"iron weapons\";");
		code("else if(techID == cTechIronMailThor) techName = \"iron mail\";");
		code("else if(techID == cTechIronShieldsThor) techName = \"iron shields\";");
		code("else if(techID == cTechBurningPitchThor) techName = \"burning pitch\";");
		code("else if(techID == cTechHammerOfTheGods) techName = \"dwarven weapons\";");
		code("else if(techID == cTechDragonscaleShields) techName = \"dwarven shields\";");
		code("else if(techID == cTechMeteoricIronMail) techName = \"dwarven mail\";");

		// Mythology.
		code("else if(techID == cTechHamarrtroll) techName = \"hamar troll\";");
		code("else if(techID == cTechWinterHarvest) techName = \"bountiful harvest\";");
		code("else if(techID == cTechElhrimnirKettle) techName = \"elminer kettle\";");
		code("else if(techID == cTechArcticWinds) techName = \"arctic wind\";");

		// Military.
		code("else if(techID == cTechAxeOfMuspell) hasExpSuffix = true;");
		code("else if(techID == cTechLevyLonghouseSoldiers) techName = \"levy longhouse\";");
		code("else if(techID == cTechConscriptLonghouseSoldiers) techName = \"conscript longhouse\";");
		code("else if(techID == cTechLevyHillFortSoldiers) techName = \"levy hillfort\";");
		code("else if(techID == cTechConscriptHillFortSoldiers) techName = \"conscript hillfort\";");

		// Atlanteans.
		// Minor gods. Directly return these as they are completely different.
		code("else if(techID == cTechAge2Prometheus) return(\"<icon=(20)(icons/god major prometheus icons 64)>\");");
		code("else if(techID == cTechAge2Leto) return(\"<icon=(20)(icons/god major leto icons 64)>\");");
		code("else if(techID == cTechAge2Oceanus) return(\"<icon=(20)(icons/god major okeanus icons 64)>\");");
		code("else if(techID == cTechAge3Hyperion) return(\"<icon=(20)(icons/god major hyperion icons 64)>\");");
		code("else if(techID == cTechAge3Rheia) return(\"<icon=(20)(icons/god major rheia icons 64)>\");");
		code("else if(techID == cTechAge3Theia) return(\"<icon=(20)(icons/god major theia icons 64)>\");");
		code("else if(techID == cTechAge4Helios) return(\"<icon=(20)(icons/god major helios icons 64)>\");");
		code("else if(techID == cTechAge4Atlas) return(\"<icon=(20)(icons/god major atlas icons 64)>\");");
		code("else if(techID == cTechAge4Hekate) return(\"<icon=(20)(icons/god major hekate icons 64)>\");");

		// Mytholoy.
		code("else if(techID == cTechFocus) hasExpSuffix = true;");
		code("else if(techID == cTechChannels) hasExpSuffix = true;");
		code("else if(techID == cTechSafePassage) hasExpSuffix = true;");
		code("else if(techID == cTechAxeOfMuspell) hasExpSuffix = true;");
		code("else if(techID == cTechHeartOfTheTitans) hasExpSuffix = true;");
		code("else if(techID == cTechAlluvialClay) hasExpSuffix = true;");
		code("else if(techID == cTechHephaestusRevenge) hasExpSuffix = true;");
		code("else if(techID == cTechVolcanicForge) hasExpSuffix = true;");
		code("else if(techID == cTechBiteOfTheShark) hasExpSuffix = true;");
		code("else if(techID == cTechWeightlessMace) hasExpSuffix = true;");
		code("else if(techID == cTechGemino) hasExpSuffix = true;");
		code("else if(techID == cTechHeroicRenewal) hasExpSuffix = true;");
		code("else if(techID == cTechHornsOfConsecration) hasExpSuffix = true;");
		code("else if(techID == cTechMailOfOrichalkos) hasExpSuffix = true;");
		code("else if(techID == cTechRheiasGift) hasExpSuffix = true;");
		code("else if(techID == cTechLanceOfStone) hasExpSuffix = true;");
		code("else if(techID == cTechPoseidonsSecret) hasExpSuffix = true;");
		code("else if(techID == cTechLemurianDescendants) { hasExpSuffix = true; techName = \"lemurian descendant\"; }");
		code("else if(techID == cTechPetrified) hasExpSuffix = true;");
		code("else if(techID == cTechHaloOfTheSun) hasExpSuffix = true;");
		code("else if(techID == cTechTitanShield) hasExpSuffix = true;");
		code("else if(techID == cTechEyesOfAtlas) hasExpSuffix = true;");
		code("else if(techID == cTechIoGuardian) { hasExpSuffix = true; techName = \"guardian\"; }");
		code("else if(techID == cTechMythicRejuvenation) hasExpSuffix = true;");
		code("else if(techID == cTechCelerity) hasExpSuffix = true;");
		code("else if(techID == cTechAsperBlood) hasExpSuffix = true;");

		// Military.
		code("else if(techID == cTechLevyMainlineUnits) { hasExpSuffix = true; techName = \"levy mainline\"; }");
		code("else if(techID == cTechLevySpecialtyUnits){ hasExpSuffix = true; techName = \"levy specialty\"; }");
		code("else if(techID == cTechLevyPalaceUnits) { hasExpSuffix = true; techName = \"levy palace\"; }");
		code("else if(techID == cTechConscriptMainlineUnits) { hasExpSuffix = true; techName = \"conscript mainline\"; }");
		code("else if(techID == cTechConscriptSpecialtyUnits) { hasExpSuffix = true; techName = \"conscript specialty\"; }");
		code("else if(techID == cTechConscriptPalaceUnits) { hasExpSuffix = true; techName = \"conscript palace\"; }");
		code("else if(techID == cTechHeavyChieroballista) hasExpSuffix = true;");
		code("else if(techID == cTechChampionChieroballista) hasExpSuffix = true;");
		code("else if(techID == cTechIronWall) hasExpSuffix = true;");
		code("else if(techID == cTechBronzeWall) hasExpSuffix = true;");
		code("else if(techID == cTechOrichalkosWall) { hasExpSuffix = true; techName = \"orichalkos wall\"; }");

		// Common.
		// Sectrets of the Titans.
		code("else if(techID == cTechSecretsOfTheTitans) hasExpSuffix = true;");

		// Buildings.
		code("else if(techID == cTechFortifyTownCenter) techName = \"fortified town center\";");
		code("else if(techID == cTechCrenellations) techName = \"crenelations\";");
		code("else if(techID == cTechBoilingOil) techName = \"murder holes\";");

		// Dock.
		code("else if(techID == cTechConscriptSailors) techName = \"conscript naval\";");
		code("else if(techID == cTechEnclosedDeck) techName = \"enclosed decks\";");
		code("else if(techID == cTechHeroicFleet) hasExpSuffix = true;");

		// Apply suffix and return.
		code("if(hasExpSuffix)");
		code("{");
			code("suffix = expSuffix;");
		code("}");

		code("return(prefix + techName + suffix);");
	code("}");

	// Checks if a tech is an age-up tech.
	code("bool isTechAgeUp(int tech = -1)");
	code("{");
		code("if(tech == cTechAge2Anubis) return(true);");
		code("else if(tech == cTechAge2Ares) return(true);");
		code("else if(tech == cTechAge2Athena) return(true);");
		code("else if(tech == cTechAge2Bast) return(true);");
		code("else if(tech == cTechAge2Forseti) return(true);");
		code("else if(tech == cTechAge2Freyja) return(true);");
		code("else if(tech == cTechAge2Heimdall) return(true);");
		code("else if(tech == cTechAge2Hermes) return(true);");
		code("else if(tech == cTechAge2Leto) return(true);");
		code("else if(tech == cTechAge2Oceanus) return(true);");
		code("else if(tech == cTechAge2Prometheus) return(true);");
		code("else if(tech == cTechAge2Ptah) return(true);");
		code("else if(tech == cTechAge3Aphrodite) return(true);");
		code("else if(tech == cTechAge3Apollo) return(true);");
		code("else if(tech == cTechAge3Bragi) return(true);");
		code("else if(tech == cTechAge3Dionysos) return(true);");
		code("else if(tech == cTechAge3Hathor) return(true);");
		code("else if(tech == cTechAge3Hyperion) return(true);");
		code("else if(tech == cTechAge3Nephthys) return(true);");
		code("else if(tech == cTechAge3Njord) return(true);");
		code("else if(tech == cTechAge3Rheia) return(true);");
		code("else if(tech == cTechAge3Sekhmet) return(true);");
		code("else if(tech == cTechAge3Skadi) return(true);");
		code("else if(tech == cTechAge3Theia) return(true);");
		code("else if(tech == cTechAge4Artemis) return(true);");
		code("else if(tech == cTechAge4Atlas) return(true);");
		code("else if(tech == cTechAge4Baldr) return(true);");
		code("else if(tech == cTechAge4Hekate) return(true);");
		code("else if(tech == cTechAge4Hel) return(true);");
		code("else if(tech == cTechAge4Helios) return(true);");
		code("else if(tech == cTechAge4Hephaestus) return(true);");
		code("else if(tech == cTechAge4Hera) return(true);");
		code("else if(tech == cTechAge4Horus) return(true);");
		code("else if(tech == cTechAge4Osiris) return(true);");
		code("else if(tech == cTechAge4Thoth) return(true);");
		code("else if(tech == cTechAge4Tyr) return(true);");

		code("return(false);");
	code("}");

	code("const int cTechUpdateStart = 0;");
	code("const int cTechUpdateComplete = 1;");
	code("const int cTechUpdateAbort = 2;");

	// Global tech updates to observers. Currently only active for age-ups.
	code("void techUpdateToObs(int type = -1, int p = -1, int tech = -1)");
	code("{");
		code("if(isTechAgeUp(tech) && type != cTechUpdateComplete)"); // Only send if age-up tech and either started or aborted.
		code("{");
			code("string m = \"\";");

			code("if(type == cTechUpdateStart)");
			code("{");
				code("m = \"Started: \" + getTechIcon(tech) + \" \" + kbGetTechName(tech) + \" (\" + timeStamp(trTime()) + \")\";");
			code("} else {");
				code("m = \"Aborted: \" + getTechIcon(tech) + \" \" + kbGetTechName(tech) + \" (\" + timeStamp(trTime()) + \")\";");
			code("}");

			for(i = cPlayersMerged; < cPlayersObs) {
				code("trChatSendSpoofedToPlayer(p, " + getPlayer(i) + ", m);");
			}
		code("}");
	code("}");
}

/*****************
* OBSERVER RULES *
*****************/

/*
 * This section is extremely messy.
 * Like above, functions are not independent from each other and have to be called
 * in the order they are listed here to work properly.
*/

/*
** Injects the constants and variables needed for the update toggles.
*/
void injectToggleVars() {
	// Techs request toggle states.
	code("const int cToggleOff = 0;");
	code("const int cToggleRunOnce = 1;"); // !r and !t respectively.
	code("const int cToggleOn = 2;");

	// States for live resources and techs.
	for(i = cPlayersMerged; < cPlayersObs) {
		code("int resState" + getPlayer(i) + " = cToggleOff;");
		code("int techState" + getPlayer(i) + " = cToggleOff;");
		code("int detailPlayerState" + getPlayer(i) + " = cToggleOff;"); // Obtains details for the specified player if enabled.
		code("int detailPlayer" + getPlayer(i) + " = 0;");
	}

	for(i = cPlayersMerged; < cPlayersObs) {
		for(j = 1; < cPlayers) {
			code("int playerResState" + getPlayer(j) + "X" + getPlayer(i) + " = cToggleOff;");
			code("int playerTechState" + getPlayer(j) + "X" + getPlayer(i) + " = cToggleOff;");
		}
	}
}

/*
** Tech update core.
** Creates arrays and stores the state of every update for every player, removing techs that are already reseached from the check.
** Has an upper limit per pass (cTechBatchSize) - 1 iteration will never check more than this value.
*/
void injectTechUpdateCore() {
	// Core for filling and updating the arrays holding the tech states. Credits to Loggy for the great concept.
	code("const int cTechArraySize = 120;"); // ~100 is the maximum number of techs for civs.
	code("const int cTechBatchSize = 50;"); // Try to update about half the (initial) techs of a player per round.

	// An array with an entry for every player, where each value is the index of another array that stores tech statuses.
	code("int dataArray = -1;");

	for(i = cPlayersMerged; < cPlayersObs) {
		code("rule _update_techs_" + getPlayer(i));
		code("active");
		code("highFrequency");
		code("{");
			injectRuleInterval(200);

			code("static int currentPlayer = 1;");
			code("static int currentTech = 0;"); // Not a tech, but rather the position in currentPlayer's array that we got to last time.
			code("static bool init = false;");

			// Only do for observers.
			code("if(trCurrentPlayer() == " + getPlayer(i) + ")");
			code("{");
				code("if(init == false)");
				code("{");
					// Initialization.
					code("if(dataArray == -1)");
					code("{");
						code("dataArray = arrayCreate(cPlayers);");
					code("}");

					code("int arrData = arrayCreate(cTechArraySize);");
					code("arraySetInt(dataArray, currentPlayer, arrData);");

					// Use different updates to build all arrays.
					code("int oldContext = xsGetContextPlayer();");
					code("xsSetContextPlayer(getPlayer(currentPlayer));");

					code("assignTechs(arrData);");

					// Next player.
					code("currentPlayer++;");

					code("if(currentPlayer > cNonGaiaPlayers)");
					code("{");
						code("init = true;");
					code("}");

					code("xsSetContextPlayer(oldContext);");

					code("xsSetRuleMinIntervalSelf(0);");
				code("} else {");
					// Silently update the tech arrays every now and then.
					// Reset counter.
					code("if(currentPlayer > cNonGaiaPlayers)");
					code("{");
						code("currentPlayer = 1;");
					code("}");

					code("int p = getPlayer(currentPlayer);");

					code("oldContext = xsGetContextPlayer();");
					code("xsSetContextPlayer(p);");

					// Obtain player array; don't use offset of -1, [0] empty.
					code("int arrPlayerArray = arrayGetInt(dataArray, currentPlayer);");

					// Number of techs to check this iteration.
					code("int count = min(cTechBatchSize, arrayGetSize(arrPlayerArray) - currentTech);");
					// code("trChatSend(0, \"\" + p + \" \" + arrayGetSize(arrPlayerArray));");
					code("int thisCount = count;");

					code("while(count > 0)");
					code("{");
						code("int tech = arrayGetInt(arrPlayerArray, currentTech);");
						code("int savedStatus = arrayGetInt(arrPlayerArray, currentTech, true);");
						code("int status = kbGetTechStatus(tech);");

						code("if(status != savedStatus)");
						code("{");
							code("if(savedStatus != cTechStatusResearching && status == cTechStatusResearching)"); // If we don't check for != cTechStatusResearching we may miss some.
							code("{");
								// Case 1: Started researching tech since last update.
								code("techUpdateToObs(cTechUpdateStart, p, tech);");

								code("arraySetInt(arrPlayerArray, currentTech, cTechStatusResearching, true);");
							code("} else if(status == cTechStatusActive) {");
								// Case 2: Tech has been successfully researched.
								// code("techUpdateToObs(cTechUpdateComplete, p, tech);");

								// Remove researched tech from array.
								code("arrayRemoveInt(arrPlayerArray, currentTech);");

								// Decrement currentTech as we also reduce array size.
								code("currentTech--;");
							code("} else if(status == cTechStatusAvailable && savedStatus == cTechStatusResearching) {");
								// This may miss cancellations if the tech was unavailable and then got available, researching and cancelled before the next update.

								// Case 3: Researchment was cancelled.
								// code("techUpdateToObs(cTechUpdateAbort, p, tech);");

								code("arraySetInt(arrPlayerArray, currentTech, cTechStatusAvailable, true);");
							code("} else {");
								// Case 4: Update in any other case.
								code("arraySetInt(arrPlayerArray, currentTech, status, true);");
							code("}");
						code("}");

						code("currentTech++;");
						code("count--;");
					code("}");

					// See if we need to move onto the next player.
					code("if(currentTech >= arrayGetSize(arrPlayerArray))");
					code("{");
						code("currentPlayer++;");
						code("currentTech = 0;");

						// Avoid having a minInterval of 0 permenantly if the array is small.
						code("if(arrayGetSize(arrPlayerArray) > thisCount)");
						code("{");
							code("xsSetRuleMinIntervalSelf(0);");
						code("}");
					code("}");

					code("xsSetContextPlayer(oldContext);");
				code("}");
			code("}");

			code("xsDisableSelf();");
			code("trDelayedRuleActivation(\"_update_techs_" + getPlayer(i) + "\");");
		code("}");
	}
}

/*
** !x command to clear all active toggles and the chat.
*/
void injectCmdToggleClear() {
	for(i = cPlayersMerged; < cPlayersObs) {
		code("rule _clear_toggles_" + getPlayer(i));
		code("active");
		code("{");
			injectRuleInterval();

			// Only do for observers.
			code("if(trCurrentPlayer() == " + getPlayer(i) + ")");
			code("{");
				// Don't merge ifs because XS evaluates both conditions in an && even if the first one is false.
				code("if(trChatHistoryContains(\"!x\", " + getPlayer(i) + "))");
				code("{");
					// Kill active !lr and !lt.
					code("techState" + getPlayer(i) + " = false;");
					code("resState" + getPlayer(i) + " = false;");
					code("detailPlayerState" + getPlayer(i) + " = cToggleOff;");
					code("detailPlayer" + getPlayer(i) + " = 0;");

					for(j = 1; < cPlayers) {
						code("playerResState" + getPlayer(j) + "X" + getPlayer(i) + " = cToggleOff;");
						code("playerTechState" + getPlayer(j) + "X" + getPlayer(i) + " = cToggleOff;");
					}

					code("trChatHistoryClear();");
					code("trChatSendSpoofedToPlayer(" + getPlayer(i) + ", " + getPlayer(i) + ", \"Chat cleared.\");");
				code("}");
			code("}");

			code("xsDisableSelf();");
			code("trDelayedRuleActivation(\"_clear_toggles_" + getPlayer(i) + "\");");
		code("}");
	}
}

/*
** !h command to display all available commands (clears active toggles).
*/
void injectCmdHelp() {
	// List of commands. This has be generated before !lr and !lt to properly shut them down if active.
	for(i = cPlayersMerged; < cPlayersObs) {
		code("rule _get_commands_" + getPlayer(i));
		code("active");
		code("{");
			injectRuleInterval();

			// Only do for observers.
			code("if(trCurrentPlayer() == " + getPlayer(i) + ")");
			code("{");
				// Don't merge ifs because XS evaluates both conditions in an && even if the first one is false.
				code("if(trChatHistoryContains(\"!h\", " + getPlayer(i) + "))");
				code("{");
					// Kill active !lr and !lt.
					code("techState" + getPlayer(i) + " = cToggleOff;");
					code("resState" + getPlayer(i) + " = cToggleOff;");
					code("detailPlayerState" + getPlayer(i) + " = cToggleOff;");
					code("detailPlayer" + getPlayer(i) + " = 0;");

					code("trChatHistoryClear();");

					code("string cp = \"" + cColorChat + "\";");
					code("string cs = \"" + cColorOff + "\";");

					code("trChatSendSpoofedToPlayer(" + getPlayer(i) + ", " + getPlayer(i) + ", cp + \"!m\" + cs + \" toggles map reveal\");");
					code("trChatSendSpoofedToPlayer(" + getPlayer(i) + ", " + getPlayer(i) + ", cp + \"!i\" + cs + \" shows the current resources and techs of player i (example: !2)\");");
					code("trChatSendSpoofedToPlayer(" + getPlayer(i) + ", " + getPlayer(i) + ", cp + \"!r\" + cs + \" shows the current resources of all players\");");
					code("trChatSendSpoofedToPlayer(" + getPlayer(i) + ", " + getPlayer(i) + ", cp + \"!t\" + cs + \" shows all techs currently being researched\");");
					code("trChatSendSpoofedToPlayer(" + getPlayer(i) + ", " + getPlayer(i) + ", cp + \"!li\" + cs + \" toggles live resources and techs for player i (example: !l2)\");");
					code("trChatSendSpoofedToPlayer(" + getPlayer(i) + ", " + getPlayer(i) + ", cp + \"!lra\" + cs + \" toggles live resources for all players\");");
					code("trChatSendSpoofedToPlayer(" + getPlayer(i) + ", " + getPlayer(i) + ", cp + \"!lri\" + cs + \" toggles live resources for player i (example: !lr2)\");");
					code("trChatSendSpoofedToPlayer(" + getPlayer(i) + ", " + getPlayer(i) + ", cp + \"!lta\" + cs + \" toggles live techs for all players\");");
					code("trChatSendSpoofedToPlayer(" + getPlayer(i) + ", " + getPlayer(i) + ", cp + \"!lti\" + cs + \" toggles live techs for player i (example: !lt2)\");");
					code("trChatSendSpoofedToPlayer(" + getPlayer(i) + ", " + getPlayer(i) + ", cp + \"!la\" + cs + \" toggles live resources and techs for all players (1v1 only)\");");
					code("trChatSendSpoofedToPlayer(" + getPlayer(i) + ", " + getPlayer(i) + ", cp + \"!x\" + cs + \" clears the chat (and all active toggles)\");");
					code("trChatSendSpoofedToPlayer(" + getPlayer(i) + ", " + getPlayer(i) + ", \"You will be unable to see player chat while any live (!l*) command is enabled.\");");
					code("trChatSendSpoofedToPlayer(" + getPlayer(i) + ", " + getPlayer(i) + ", \"Chat is always cleared when a command is issued.\");");
				code("}");
			code("}");

			code("xsDisableSelf();");
			code("trDelayedRuleActivation(\"_get_commands_" + getPlayer(i) + "\");");
		code("}");
	}
}

/*
** !m command to reveal the map.
** Has to be injected before the toggles to be usable while toggles are active.
** The command in the chat will get cleared by active toggles otherwise, as rules are iterated over sequentially in each pass.
*/
void injectCmdMapReveal() {
	for(i = cPlayersMerged; < cPlayersObs) {
		code("rule _toggle_map_reveal_" + getPlayer(i));
		code("active");
		code("{");
			injectRuleInterval();

			// Only do for observers.
			code("if(trCurrentPlayer() == " + getPlayer(i) + ")");
			code("{");
				// Static variable holds state over calls of this rule.
				code("static bool mapRevealed" + getPlayer(i) + " = true;");

				code("if(trChatHistoryContains(\"!m\", " + getPlayer(i) + "))");
				code("{");
					code("trChatHistoryClear();");

					// Change state of variable.
					code("if(mapRevealed" + getPlayer(i) + ")");
					code("{");
						code("mapRevealed" + getPlayer(i) + " = false;");
					code("} else {");
						code("mapRevealed" + getPlayer(i) + " = true;");
					code("}");

					// Toggle black map/fog.
					code("trSetFogAndBlackmap(mapRevealed" + getPlayer(i) + ", mapRevealed" + getPlayer(i) + ");");

				code("}");
			code("}");

			code("xsDisableRule(\"_toggle_map_reveal_" + getPlayer(i) + "\");");
			code("trDelayedRuleActivation(\"_toggle_map_reveal_" + getPlayer(i) + "\");");
		code("}");
	}
}

/*
** Listener for all stats/tech commands.
*/
void injectCmdListener() {
	// This is admittedly super messy but I don't think it's more useful to have all listeners in separate rules or functions.
	for(i = cPlayersMerged; < cPlayersObs) {
		code("rule _toggle_live_stats_" + getPlayer(i));
		code("active");
		code("{");
			injectRuleInterval();

			code("if(trCurrentPlayer() == " + getPlayer(i) + ")");
			code("{");
				code("bool switchOff = false;");

			// One indentation level less so the injected code aligns.
			if(cNonGaiaPlayers == 2) {
				// Live toggle all (!la), only for 1v1.
				code("if(trChatHistoryContains(\"!la\", " + getPlayer(i) + "))");
				code("{");
					code("trChatHistoryClear();");

					code("if(");
				for(k = 1; < cPlayers) {
					code("playerResState" + getPlayer(k) + "X" + getPlayer(i) + " == cToggleOn &&");
					code("playerTechState" + getPlayer(k) + "X" + getPlayer(i) + " == cToggleOn &&");
				}
					code("true)");
					code("{");
						// Both turned on, disable.
						code("resState" + getPlayer(i) + " = cToggleOff;");
						code("techState" + getPlayer(i) + " = cToggleOff;");

						for(j = 1; < cPlayers) {
							code("playerResState" + getPlayer(j) + "X" + getPlayer(i) + " = cToggleOff;");
							code("playerTechState" + getPlayer(j) + "X" + getPlayer(i) + " = cToggleOff;");
						}
					code("} else {");
						// At least one not turned on, enable everything.
						code("resState" + getPlayer(i) + " = cToggleOn;");
						code("techState" + getPlayer(i) + " = cToggleOn;");
						code("detailPlayerState" + getPlayer(i) + " = cToggleOff;");
						code("detailPlayer" + getPlayer(i) + " = 0;");

						for(j = 1; < cPlayers) {
							code("playerResState" + getPlayer(j) + "X" + getPlayer(i) + " = cToggleOn;");
							code("playerTechState" + getPlayer(j) + "X" + getPlayer(i) + " = cToggleOn;");
						}
					code("}");
			} else {
				code("if(false)"); // Ridiculous but we can nicely inject else ifs after this.
				code("{");
			}

				// Live resource toggle (!lr).
				code("} else if(trChatHistoryContains(\"!lra\", " + getPlayer(i) + ")) {");
					code("trChatHistoryClear();");

					code("if(resState" + getPlayer(i) + " == cToggleOn)");
					code("{");
						code("resState" + getPlayer(i) + " = cToggleOff;");

						for(j = 1; < cPlayers) {
							code("playerResState" + getPlayer(j) + "X" + getPlayer(i) + " = cToggleOff;");
						}
					code("} else {");
						code("resState" + getPlayer(i) + " = cToggleOn;");
						code("detailPlayerState" + getPlayer(i) + " = cToggleOff;");
						code("detailPlayer" + getPlayer(i) + " = 0;");

						for(j = 1; < cPlayers) {
							code("playerResState" + getPlayer(j) + "X" + getPlayer(i) + " = cToggleOn;");
						}
					code("}");

			// One indentation level less because we're injecting else ifs.
			for(j = 1; < cPlayers) {
				code("} else if(trChatHistoryContains(\"!lr" + getPlayer(j) + "\", " + getPlayer(i) + ")) {");
					code("trChatHistoryClear();");

					code("if(playerResState" + getPlayer(j) + "X" + getPlayer(i) + " == cToggleOn)");
					code("{");
						code("playerResState" + getPlayer(j) + "X" + getPlayer(i) + " = cToggleOff;");

						// Check if we have to disable.
						code("switchOff = true;");

						code("if(false)"); // Ridiculous but we can nicely inject else ifs after this.
						code("{");
					for(k = 1; < cPlayers) {
						code("} else if (playerResState" + getPlayer(k) + "X" + getPlayer(i) + " == cToggleOn) {");
						code("switchOff = false;");
					}
						code("}");

						code("if(switchOff)");
						code("{");
							code("resState" + getPlayer(i) + " = cToggleOff;");
						code("}");
					code("} else {");
						code("playerResState" + getPlayer(j) + "X" + getPlayer(i) + " = cToggleOn;");
						code("detailPlayerState" + getPlayer(i) + " = cToggleOff;");
						code("detailPlayer" + getPlayer(i) + " = 0;");

						// At least 1 is running, turn on.
						code("resState" + getPlayer(i) + " = cToggleOn;");
					code("}");
			}

				// Live tech toggle (!lt).
				code("} else if(trChatHistoryContains(\"!lta\", " + getPlayer(i) + ")) {");
					code("trChatHistoryClear();");

					code("if(techState" + getPlayer(i) + " == cToggleOn)");
					code("{");
						code("techState" + getPlayer(i) + " = cToggleOff;");

						for(j = 1; < cPlayers) {
							code("playerTechState" + getPlayer(j) + "X" + getPlayer(i) + " = cToggleOff;");
						}
					code("} else {");
						code("techState" + getPlayer(i) + " = cToggleOn;");
						code("detailPlayerState" + getPlayer(i) + " = cToggleOff;");
						code("detailPlayer" + getPlayer(i) + " = 0;");

						for(j = 1; < cPlayers) {
							code("playerTechState" + getPlayer(j) + "X" + getPlayer(i) + " = cToggleOn;");
						}
					code("}");

			// One indentation level less because we're injecting else ifs.
			for(j = 1; < cPlayers) {
				code("} else if(trChatHistoryContains(\"!lt" + getPlayer(j) + "\", " + getPlayer(i) + ")) {");
					code("trChatHistoryClear();");

					code("if(playerTechState" + getPlayer(j) + "X" + getPlayer(i) + " == cToggleOn)");
					code("{");
						code("playerTechState" + getPlayer(j) + "X" + getPlayer(i) + " = cToggleOff;");

						// Check if we have to disable.
						code("switchOff = true;");

						code("if(false)"); // Ridiculous but we can nicely inject else ifs after this.
						code("{");
					for(k = 1; < cPlayers) {
						code("} else if (playerTechState" + getPlayer(k) + "X" + getPlayer(i) + " == cToggleOn) {");
							code("switchOff = false;");
					}
						code("}");

						code("if(switchOff)");
						code("{");
							code("techState" + getPlayer(i) + " = cToggleOff;");
						code("}");
					code("} else {");
						code("playerTechState" + getPlayer(j) + "X" + getPlayer(i) + " = cToggleOn;");
						code("detailPlayerState" + getPlayer(i) + " = cToggleOff;");
						code("detailPlayer" + getPlayer(i) + " = 0;");

						// At least 1 is running, turn on.
						code("techState" + getPlayer(i) + " = cToggleOn;");
					code("}");
			}

			// Player stat toggle (!li).
			// One indentation level less because we're injecting else ifs.
			for(j = 1; < cPlayers) {
				code("} else if(trChatHistoryContains(\"!l" + getPlayer(j) + "\", " + getPlayer(i) + ")) {");
					code("trChatHistoryClear();");

					code("if(detailPlayerState" + getPlayer(i) + " == cToggleOn && detailPlayer" + getPlayer(i) + " == " + getPlayer(j) + ")");
					code("{");
						// Same player, turn off.
						code("detailPlayer" + getPlayer(i) + " = 0;");
						code("detailPlayerState" + getPlayer(i) + " = cToggleOff;");
					code("} else {");
						// Different player, turn on.
						code("detailPlayer" + getPlayer(i) + " = " + getPlayer(j) + ";");
						code("detailPlayerState" + getPlayer(i) + " = cToggleOn;");

						// Disable everything else.
						for(k = 1; < cPlayers) {
							code("playerResState" + getPlayer(k) + "X" + getPlayer(i) + " = cToggleOff;");
							code("playerTechState" + getPlayer(k) + "X" + getPlayer(i) + " = cToggleOff;");
						}

						code("resState" + getPlayer(i) + " = cToggleOff;");
						code("techState" + getPlayer(i) + " = cToggleOff;");
					code("}");
			}
				// Resource once (!r).
				code("} else if(trChatHistoryContains(\"!r\", " + getPlayer(i) + ")) {");
					code("trChatHistoryClear();");

					// Set to run once.
					code("resState" + getPlayer(i) + " = cToggleRunOnce;");

					// Disable every toggle.
					for(j = 1; < cPlayers) {
						code("playerResState" + getPlayer(j) + "X" + getPlayer(i) + " = cToggleOff;");
						code("playerTechState" + getPlayer(j) + "X" + getPlayer(i) + " = cToggleOff;");
					}

					code("techState" + getPlayer(i) + " = cToggleOff;");
					code("detailPlayerState" + getPlayer(i) + " = cToggleOff;");
					code("detailPlayer" + getPlayer(i) + " = 0;");
				// Techs once (!t).
				code("} else if(trChatHistoryContains(\"!t\", " + getPlayer(i) + ")) {");
					code("trChatHistoryClear();");

					// Set to run once.
					code("techState" + getPlayer(i) + " = cToggleRunOnce;");

						// Disable every toggle.
					for(j = 1; < cPlayers) {
						code("playerResState" + getPlayer(j) + "X" + getPlayer(i) + " = cToggleOff;");
						code("playerTechState" + getPlayer(j) + "X" + getPlayer(i) + " = cToggleOff;");
					}

					code("resState" + getPlayer(i) + " = cToggleOff;");
					code("detailPlayerState" + getPlayer(i) + " = cToggleOff;");
					code("detailPlayer" + getPlayer(i) + " = 0;");

			// Player stats once.
			// One indentation level less because we're injecting else ifs.
			for(j = 1; < cPlayers) {
				code("} else if(trChatHistoryContains(\"!" + getPlayer(j) + "\", " + getPlayer(i) + ")) {");
					code("trChatHistoryClear();");

					code("if(detailPlayerState" + getPlayer(i) + " == cToggleOn && detailPlayer" + getPlayer(i) + " == " + getPlayer(j) + ")");
					code("{");
						// Same player, turn off.
						code("detailPlayerState" + getPlayer(i) + " = cToggleOff;");
					code("} else {");
						// Different player, turn on.
						code("detailPlayer" + getPlayer(i) + " = " + getPlayer(j) + ";");
						code("detailPlayerState" + getPlayer(i) + " = cToggleRunOnce;");

						// Disable everything else.
						for(k = 1; < cPlayers) {
							code("playerResState" + getPlayer(k) + "X" + getPlayer(i) + " = cToggleOff;");
							code("playerTechState" + getPlayer(k) + "X" + getPlayer(i) + " = cToggleOff;");
						}

						code("resState" + getPlayer(i) + " = cToggleOff;");
						code("techState" + getPlayer(i) + " = cToggleOff;");
					code("}");
			}

				code("}");
			code("}");

			code("xsDisableSelf();");
			code("trDelayedRuleActivation(\"_toggle_live_stats_" + getPlayer(i) + "\");");
		code("}");
	}
}

/*
** Stats for !lra, !lta, !r, and !t.
*/
void injectCmdUpdateGlobal() {
	// Live updates.
	code("string attyIconFish = \"<icon=(20)(icons/boat x fishing ship atlantean icons 32)>\";");

	// Global update. Used by !lra, !lta, !r and !t.
	for(i = cPlayersMerged; < cPlayersObs) {
		code("rule _update_live_stats_" + getPlayer(i));
		code("active");
		code("{");
			code("static int techCount" + getPlayer(i) + " = 0;");

			injectRuleInterval();

			code("if(trCurrentPlayer() == " + getPlayer(i) + ")");
			code("{");
				code("if(resState" + getPlayer(i) + " + techState" + getPlayer(i) + " != 0)");
				code("{");
					code("int oldContext = xsGetContextPlayer();");

					// Clean chat for next messages.
					code("xsSetContextPlayer(" + getPlayer(i) + ");");
					code("trChatHistoryClear();");

					// Define variables here because scoping doesn't exist.
					// Global.
					code("int currTechCount = 0;");

					// Local (overwritten for every player upon iterations).
					code("string f = \"\";");
					code("string w = \"\";");
					code("string g = \"\";");
					code("string favor = \"\";");
					code("string pop = \"\";");

					code("int tradeCount = 0;");
					code("int fishCount = 0;");
					code("int villSum = 0;");

					code("string vills = \"\";");
					code("string trade = \"\";");
					code("string fishing = \"\";");

					code("int playerArray = 0;");
					code("int p = 0;");
					code("int pt = 0;");
					code("string s = \"\";");
					code("int arrSize = 0;");
					code("int tech = 0;");
					code("int status = 0;");
					code("bool runOnce = true;");

					for(j = 1; < cPlayers) {
						code("if(playerResState" + getPlayer(j) + "X" + getPlayer(i) + " != 0 || resState" + getPlayer(i) + " == cToggleRunOnce)");
						code("{");
							code("xsSetContextPlayer(" + getPlayer(j) + ");");

							code("favor = \"<icon=(20)(icons/icon resource favor)>\" + trPlayerResourceCount(" + getPlayer(j) + ", \"favor\");");
							code("pop = \"<icon=(20)(icons/icon resource population)>\" + kbGetPop() + \"/\" + kbGetPopCap();");
							code("f = \"<icon=(20)(icons/icon resource food)>\" + trPlayerResourceCount(" + getPlayer(j) + ", \"food\");");
							code("w = \"<icon=(20)(icons/icon resource wood)>\" + trPlayerResourceCount(" + getPlayer(j) + ", \"wood\");");
							code("g = \"<icon=(20)(icons/icon resource gold)>\" + trPlayerResourceCount(" + getPlayer(j) + ", \"gold\");");

							code("trChatSendSpoofedToPlayer(" + getPlayer(j) + ", " + getPlayer(i) + ", \"" + rmGetPlayerName(getPlayer(j)) + " (" + getGodName(j) + "): \" + pop + \" \" + favor);");
							code("trChatSendSpoofedToPlayer(" + getPlayer(j) + ", " + getPlayer(i) + ", f + \"\" + w + \"\" + g);");

							if(cNonGaiaPlayers == 2) {
								// Depending on culture, obtain villager/fishing/caravan stats.
								int cultureCompact = rmGetPlayerCulture(getPlayer(j));

								if(cultureCompact == cCultureGreek) {
									code("vills = \"<icon=(20)(icons/villager g male icon)>\" + trPlayerUnitCountSpecific(" + getPlayer(j) + ", \"Villager Greek\");");

									code("fishCount = trPlayerUnitCountSpecific(" + getPlayer(j) + ", \"Fishing Ship Greek\");");
									code("fishing = \"<icon=(20)(icons/boat g fishing boat icon)>\" + fishCount;");

									code("tradeCount = trPlayerUnitCountSpecific(" + getPlayer(j) + ", \"Caravan Greek\");");
									code("trade = \"<icon=(20)(icons/trade g caravan icon)>\" + tradeCount;");
								} else if(cultureCompact == cCultureEgyptian) {
									code("vills = \"<icon=(20)(icons/villager e male icon)>\" + trPlayerUnitCountSpecific(" + getPlayer(j) + ", \"Villager Egyptian\");");

									code("fishCount = trPlayerUnitCountSpecific(" + getPlayer(j) + ", \"Fishing Ship Egyptian\");");
									code("fishing = \"<icon=(20)(icons/boat e fishing boat icon)>\" + fishCount;");

									code("tradeCount = trPlayerUnitCountSpecific(" + getPlayer(j) + ", \"Caravan Egyptian\");");
									code("trade = \"<icon=(20)(icons/trade e caravan icon)>\" + tradeCount;");
								} else if(cultureCompact == cCultureNorse) {
									code("villSum = trPlayerUnitCountSpecific(" + getPlayer(j) + ", \"Villager Norse\") + trPlayerUnitCountSpecific(" + getPlayer(j) + ", \"Dwarf\");");
									code("vills = \"<icon=(20)(icons/villager n male icon)>\" + villSum;");

									code("fishCount = trPlayerUnitCountSpecific(" + getPlayer(j) + ", \"Fishing Ship Norse\");");
									code("fishing = \"<icon=(20)(icons/boat n fishing boat icon)>\" + fishCount;");

									code("tradeCount = trPlayerUnitCountSpecific(" + getPlayer(j) + ", \"Caravan Norse\");");
									code("trade = \"<icon=(20)(icons/trade n caravan icon)>\" + tradeCount;");
								} else if(cultureCompact == cCultureAtlanteanID) {
									code("villSum = trPlayerUnitCountSpecific(" + getPlayer(j) + ", \"Villager Atlantean\") + trPlayerUnitCountSpecific(" + getPlayer(j) + ", \"Villager Atlantean Hero\");");
									code("vills = \"<icon=(20)(icons/villager x male icons 32)>\" + villSum;");

									code("fishCount = trPlayerUnitCountSpecific(" + getPlayer(j) + ", \"Fishing Ship Atlantean\");");
									code("fishing = attyIconFish + fishCount;");

									code("tradeCount = trPlayerUnitCountSpecific(" + getPlayer(j) + ", \"Caravan Atlantean\");");
									code("trade = \"<icon=(20)(icons/trade x caravan icons 32)>\" + tradeCount;");
								}

								// Villagers, trade and fish. These don't fit onto a single line.
								code("if(tradeCount > 0 && fishCount > 0 && techCount" + getPlayer(i) + " < 6)");
								code("{");
									// Only show everything if 5 or less techs are being researched so we don't exceed the max chat lines (2 * 4 + 5 = 13).
									code("trChatSendSpoofedToPlayer(" + getPlayer(j) + ", " + getPlayer(i) + ", vills + trade);");
									code("trChatSendSpoofedToPlayer(" + getPlayer(j) + ", " + getPlayer(i) + ", fishing);");
								code("} else if(techCount" + getPlayer(i) + " < 8) {");
									// Otherwise we can show one line of vill/trade/fish stats if 7 or less techs are being researched (2 * 3 + 7 = 13).
									code("if(tradeCount > 0) {");
										code("trChatSendSpoofedToPlayer(" + getPlayer(j) + ", " + getPlayer(i) + ", vills + trade);");
									code("} else if(fishCount > 0) {");
										code("trChatSendSpoofedToPlayer(" + getPlayer(j) + ", " + getPlayer(i) + ", vills + fishing);");
									code("} else {");
										code("trChatSendSpoofedToPlayer(" + getPlayer(j) + ", " + getPlayer(i) + ", vills);");
									code("}");
								code("}");
							}
						code("}");

						code("if(playerTechState" + getPlayer(j) + "X" + getPlayer(i) + " != cToggleOff || techState" + getPlayer(i) + " == cToggleRunOnce)");
						code("{");
							// Print info message once.
							code("if(runOnce && techState" + getPlayer(i) + " == cToggleRunOnce)");
							code("{");
								code("trChatSendSpoofedToPlayer(" + getPlayer(i) + ", " + getPlayer(i) + ", \"Techs currently being researched:\");");
								code("runOnce = false;");
							code("}");

							// Obtain techs.
							code("p = " + getPlayer(j) + ";");

							code("xsSetContextPlayer(p);");
							code("playerArray = arrayGetInt(dataArray, " + j + ");");
							code("arrSize = arrayGetSize(playerArray);");

							code("for(techIter = 0; < arrSize)");
							code("{");
								// Get tech and current status.
								code("tech = arrayGetInt(playerArray, techIter);");
								code("status = arrayGetInt(playerArray, techIter, true);");

								code("if(status == cTechStatusResearching)");
								code("{");
									// Calculate percentage.
									code("pt = 100 * kbGetTechPercentComplete(tech);");
									code("s = getTechIcon(tech) + \" \" + kbGetTechName(tech) + \" (\" + pt + \" pct)\";");
									code("trChatSendSpoofedToPlayer(" + getPlayer(j) + ", " + getPlayer(i) + ", s);");
									code("currTechCount++;");
								code("}");
							code("}");
						code("}");
					}

					code("if(resState" + getPlayer(i) + " == cToggleRunOnce)");
					code("{");
						// Decrement if called only once.
						code("resState" + getPlayer(i) + " = cToggleOff;");
					code("}");

					code("if(techState" + getPlayer(i) + " == cToggleRunOnce)");
					code("{");
						// Decrement if called only once.
						code("techState" + getPlayer(i) + " = cToggleOff;");
					code("}");

					// Update tech count.
					code("techCount" + getPlayer(i) + " = currTechCount;");

					code("xsSetContextPlayer(oldContext);");
				code("}");
			code("}");

			code("xsDisableSelf();");
			code("trDelayedRuleActivation(\"_update_live_stats_" + getPlayer(i) + "\");");
		code("}");
	}
}

/*
** Stats for !i and !li.
*/
void injectCmdUpdateSingle() {
	// Player update. Used for !i and !li.
	for(i = cPlayersMerged; < cPlayersObs) {
		code("rule _get_player_info_" + getPlayer(i));
		code("active");
		code("{");
			injectRuleInterval();

			code("if(trCurrentPlayer() == " + getPlayer(i) + ")");
			code("{");
				code("if(detailPlayerState" + getPlayer(i) + " != cToggleOff)");
				code("{");
					code("int oldContext = xsGetContextPlayer();");

					// Clean chat for next messages.
					code("xsSetContextPlayer(" + getPlayer(i) + ");");
					code("trChatHistoryClear();");

					// Variables to store values in.
					code("string vills = \"\";");
					code("string dwarfs = \"\";"); // Remains empty for Greek/Egyptian, used by Atlantean hero citizens.
					code("string oxcart = \"\";"); // Only used by Norse.
					code("string trade = \"\";");
					code("string fishing = \"\";");

					code("int tradeCount = 0;");
					code("int fishCount = 0;");

					code("string f = \"\";");
					code("string w = \"\";");
					code("string g = \"\";");
					code("string favor = \"\";");
					code("string pop = \"\";");

					code("string time = \"\";");

					code("int playerArray = 0;");
					code("int pt = 0;");
					code("int arrSize = 0;");
					code("int tech = 0;");
					code("int status = 0;");
					code("string s = \"\";");

					for(j = 1; < cPlayers) {
						code("if(detailPlayer" + getPlayer(i) + " == " + getPlayer(j) + ")");
						code("{");
							code("xsSetContextPlayer(" + getPlayer(j) + ");");

							code("favor = \"<icon=(20)(icons/icon resource favor)>\" + trPlayerResourceCount(" + getPlayer(j) + ", \"favor\");");
							code("pop = \"<icon=(20)(icons/icon resource population)>\" + kbGetPop() + \"/\" + kbGetPopCap();");
							code("f = \"<icon=(20)(icons/icon resource food)>\" + trPlayerResourceCount(" + getPlayer(j) + ", \"food\");");
							code("w = \"<icon=(20)(icons/icon resource wood)>\" + trPlayerResourceCount(" + getPlayer(j) + ", \"wood\");");
							code("g = \"<icon=(20)(icons/icon resource gold)>\" + trPlayerResourceCount(" + getPlayer(j) + ", \"gold\");");

							// Different order etc. compared to !r.
							code("time = timeStamp(trTime());");
							code("trChatSendSpoofedToPlayer(" + getPlayer(j) + ", " + getPlayer(i) + ", \"" + rmGetPlayerName(getPlayer(j)) + " (" + getGodName(j) + ") (\" + time + \"): \");");
							code("trChatSendSpoofedToPlayer(" + getPlayer(j) + ", " + getPlayer(i) + ", f + \"\" + w + \"\" + g);");
							code("trChatSendSpoofedToPlayer(" + getPlayer(j) + ", " + getPlayer(i) + ", pop + \" \" + favor);");

							// Depending on culture, obtain villager/fishing/caravan stats.
							int cultureDetailed = rmGetPlayerCulture(getPlayer(j));

							if(cultureDetailed == cCultureGreek) {
								code("vills = \"<icon=(20)(icons/villager g male icon)>\" + trPlayerUnitCountSpecific(" + getPlayer(j) + ", \"Villager Greek\");");

								code("tradeCount = trPlayerUnitCountSpecific(" + getPlayer(j) + ", \"Caravan Greek\");");
								code("fishCount = trPlayerUnitCountSpecific(" + getPlayer(j) + ", \"Fishing Ship Greek\");");

								code("trade = \"<icon=(20)(icons/trade g caravan icon)>\" + tradeCount;");
								code("fishing = \"<icon=(20)(icons/boat g fishing boat icon)>\" + fishCount;");
							} else if(cultureDetailed == cCultureEgyptian) {
								code("vills = \"<icon=(20)(icons/villager e male icon)>\" + trPlayerUnitCountSpecific(" + getPlayer(j) + ", \"Villager Egyptian\");");

								code("tradeCount = trPlayerUnitCountSpecific(" + getPlayer(j) + ", \"Caravan Egyptian\");");
								code("fishCount = trPlayerUnitCountSpecific(" + getPlayer(j) + ", \"Fishing Ship Egyptian\");");

								code("trade = \"<icon=(20)(icons/trade e caravan icon)>\" + tradeCount;");
								code("fishing = \"<icon=(20)(icons/boat e fishing boat icon)>\" + fishCount;");
							} else if(cultureDetailed == cCultureNorse) {
								code("vills = \"<icon=(20)(icons/villager n male icon)>\" + trPlayerUnitCountSpecific(" + getPlayer(j) + ", \"Villager Norse\");");
								code("dwarfs = \"<icon=(20)(icons/villager n dwarf icon)>\" + trPlayerUnitCountSpecific(" + getPlayer(j) + ", \"Dwarf\");");
								code("oxcart = \"<icon=(20)(icons/villager n oxcart icon)>\" + trPlayerUnitCountSpecific(" + getPlayer(j) + ", \"Ox Cart\");");

								code("tradeCount = trPlayerUnitCountSpecific(" + getPlayer(j) + ", \"Caravan Norse\");");
								code("fishCount = trPlayerUnitCountSpecific(" + getPlayer(j) + ", \"Fishing Ship Norse\");");

								code("trade = \"<icon=(20)(icons/trade n caravan icon)>\"  + tradeCount;");
								code("fishing = \"<icon=(20)(icons/boat n fishing boat icon)>\" + fishCount;");
							} else if(cultureDetailed == cCultureAtlanteanID) {
								code("vills = \"<icon=(20)(icons/villager x male icons 32)>\" + trPlayerUnitCountSpecific(" + getPlayer(j) + ", \"Villager Atlantean\");");
								code("dwarfs = \"<icon=(20)(icons/villager x male hero icons 32)>\" + trPlayerUnitCountSpecific(" + getPlayer(j) + ", \"Villager Atlantean Hero\");");

								code("tradeCount = trPlayerUnitCountSpecific(" + getPlayer(j) + ", \"Caravan Atlantean\");");
								code("fishCount = trPlayerUnitCountSpecific(" + getPlayer(j) + ", \"Fishing Ship Atlantean\");");

								code("trade = \"<icon=(20)(icons/trade x caravan icons 32)>\" + tradeCount;");
								code("fishing = attyIconFish + fishCount;");
							}

							// Villagers and dwarfs, always show.
							code("trChatSendSpoofedToPlayer(" + getPlayer(j) + ", " + getPlayer(i) + ", vills + dwarfs);");

							// Ox carts for norse, always show.
							if(cultureDetailed == cCultureNorse) {
								code("trChatSendSpoofedToPlayer(" + getPlayer(j) + ", " + getPlayer(i) + ", oxcart);");
							}

							// Trade and fishing - only show if > 0 exist.
							code("if(tradeCount > 0 && fishCount > 0)");
							code("{");
								code("trChatSendSpoofedToPlayer(" + getPlayer(j) + ", " + getPlayer(i) + ", trade + fishing);");
							code("} else if (tradeCount > 0) {");
								code("trChatSendSpoofedToPlayer(" + getPlayer(j) + ", " + getPlayer(i) + ", trade);");
							code("} else if(fishCount > 0) {");
								code("trChatSendSpoofedToPlayer(" + getPlayer(j) + ", " + getPlayer(i) + ", fishing);");
							code("}");

							// Techs.
							code("playerArray = arrayGetInt(dataArray, " + j + ");");
							code("arrSize = arrayGetSize(playerArray);");

							code("for(techIter = 0; < arrSize)");
							code("{");
								// Get tech and current status.
								code("tech = arrayGetInt(playerArray, techIter);");
								code("status = arrayGetInt(playerArray, techIter, true);");

								code("if(status == cTechStatusResearching)");
								code("{");
									code("pt = 100 * kbGetTechPercentComplete(tech);");
									code("s = getTechIcon(tech) + \" \" + kbGetTechName(tech) + \" (\" + pt + \" pct)\";");
									code("trChatSendSpoofedToPlayer(" + getPlayer(j) + ", " + getPlayer(i) + ", s);");
								code("}");
							code("}");
						code("}");
					}

					code("xsSetContextPlayer(oldContext);");

					code("if(detailPlayerState" + getPlayer(i) + " == cToggleRunOnce)");
					code("{");
						// Decrement if called only once.
						code("detailPlayerState" + getPlayer(i) + " = cToggleOff;");
					code("}");
				code("}");
			code("}");

			code("xsDisableSelf();");
			code("trDelayedRuleActivation(\"_get_player_info_" + getPlayer(i) + "\");");
		code("}");
	}
}

/*
** Injects all the previously defined observer commands.
** Requires player constants and game constants to be injected as well.
**
** Do NOT change the order unless you know what you're doing.
**
** @param injectConstants: whether to also inject player and game constants (defaults to false)
*/
void injectObsRules(bool injectConstants = false) {
	// Inject constants if necessary.
	if(injectConstants) {
		injectPlayerConstants();
		injectGameConstants();
	}

	// Util.
	injectMiscUtil();
	injectArrayUtil();
	injectTechUtil();
	injectTechArrayUtil();

	// Commands.
	injectToggleVars();
	injectTechUpdateCore();
	injectCmdToggleClear();
	injectCmdHelp();
	injectCmdMapReveal();
	injectCmdListener();
	injectCmdUpdateGlobal();
	injectCmdUpdateSingle();
}

/****************
* VICTORY RULES *
****************/

/*
** Injects rules to handle VC with additional observers.
*/
void injectVC() {
	// Disables the basic victory condition rule.
	code("rule _disable_basic_vc");
	code("active");
	code("{");
		code("xsDisableRule(\"BasicVC1\");");
		code("xsDisableSelf();");
	code("}");

	// Called to defeat players associated with another player when merged.
	code("void defeatMergedPlayers(int playerID = -1)");
	code("{");
		// Inject defeat triggers for all necessary merges.
		for(i = 1; <= cPlayersMerged) {
			if(isMergedPlayer(i) == false) {
				code("if(playerID == " + i + ")");
				code("{");
				for(j = i + 1; <= cPlayersMerged) {
					if(rmGetPlayerName(j) == rmGetPlayerName(i) && rmGetPlayerTeam(j) == rmGetPlayerTeam(i)) {
						code("trSetPlayerDefeated(" + j + ");");
					}
				}
				code("}");
			}
		}
	code("}");

	// Called when a player resigned or got defeated, defeats observers if the game is over.
	code("void runGameOverCheck()");
	code("{");
		code("int numTeamsAlive = cTeams;");
		code("bool teamAlive = false;");

		// Check if at least one player of a team is alive, otherwise decrement.
		int playerCount = 1;

		for(i = 0; < cTeams) {
			int teamPlayers = playerCount + getNumberPlayersOnTeam(i);

			code("for(j = " + playerCount + "; < " + teamPlayers + ")");
			code("{");
				code("if(kbHasPlayerLost(getPlayer(j)) == false && kbIsPlayerResigned(getPlayer(j)) == false)");
				code("{");
					code("teamAlive = true;");
					code("break;");
				code("}");
			code("}");

			code("if(teamAlive == false)");
			code("{");
				code("numTeamsAlive--;");
			code("} else {");
				// Team was alive, set to false for next iteration.
				code("teamAlive = false;");
			code("}");

			playerCount = teamPlayers;
		}

		// If only 1 team remains, defeat obs.
		code("if(numTeamsAlive <= 1)");
		code("{");
			code("for(j = cPlayersMerged; < cNumberPlayers)");
			code("{");
				code("trSetPlayerDefeated(getPlayer(j));");
			code("}");
		code("}");
	code("}");

	// Rule for handling defeat.
	code("rule _check_defeat_vc");
	code("active");
	code("{");
		// Check once every 3 seconds.
		injectRuleInterval(3000);

		code("int oldContext = xsGetContextPlayer();");
		code("int count = 0;");

		// Consider only the players that were actually placed on the map.
		for(i = 1; < cPlayers) {
			code("xsSetContextPlayer(" + getPlayer(i) + ");");

			// Player hasn't lost yet; count all units that prevent from being defeated.
			code("if(kbHasPlayerLost(" + getPlayer(i) + ") == false)");
			code("{");
				code("count = kbUnitCount(" + getPlayer(i) + ", cUnitTypeLogicalTypeNeededForVictory, cUnitStateAlive);");

				// If the count is <= 0, the player has lost; defeat them and all players that are in the same team.
				code("if(count <= 0)");
				code("{");
					// Defeat player.
					code("trSetPlayerDefeated(" + getPlayer(i) + ");");
					code("defeatMergedPlayers(" + getPlayer(i) + ");");

					// Update vc for obs.
					code("runGameOverCheck();");
				code("}");
			code("}");
		}

		code("xsSetContextPlayer(oldContext);");

		code("xsDisableSelf();");
		code("trDelayedRuleActivation(\"_check_defeat_vc\");");
	code("}");

	// Rule for handling resign, 1 per player that is turned off after running once.
	for(i = 1; < cPlayers) {
		code("rule _check_resign_vc_" + getPlayer(i));
		code("active");
		code("{");
			// Check once per second.
			injectRuleInterval(1000);

			code("int oldContext = xsGetContextPlayer();");
			code("xsSetContextPlayer(" + getPlayer(i) + ");");

			// Player hasn't lost yet; count all units that prevent from being defeated.
			code("if(kbIsPlayerResigned(" + getPlayer(i) + "))");
			code("{");
				code("defeatMergedPlayers(" + getPlayer(i) + ");");

				// Update vc for obs.
				code("runGameOverCheck();");
				code("xsSetContextPlayer(oldContext);");

				code("xsDisableSelf();");

				// Don't reactivate after running once.
				code("return;");
			code("}");

			code("xsSetContextPlayer(oldContext);");

			code("xsDisableSelf();");
			code("trDelayedRuleActivation(\"_check_resign_vc_" + getPlayer(i) + "\");");
		code("}");
	}
}

/**************
* MERGE RULES *
**************/

/*
** Injects a rule to pause the game immediately after launch.
*/
void injectMergePause() {
	code("rule _merge_pause");
	code("highFrequency");
	code("active");
	// code("runImmediately"); // Don't run immediately to give time for other triggers to fire before (e.g. checks).
	code("{");
		injectRuleInterval(0, 500); // Run after 0.5 seconds to give time for other initialization.

		if(cVersion != cVersionVanilla) {
			code("trChatHistoryClear();");
		}

		sendChatWhite("");
		sendChatWhite("");
		sendChatWhite(cInfoLine);
		sendChatWhite("");
		sendChatWhite("Merge detected.");
		sendChatWhite("");
		sendChatWhite("Save and restore the game to enable merge mode.");
		sendChatWhite("");
		sendChatWhite("The game has been paused for saving.");
		sendChatWhite("");
		sendChatWhite(cInfoLine);
		sendChatWhite("");
		sendChatWhite("");

		pauseGame();

		code("xsDisableSelf();");
	code("}");
}

/*
** Injects a rule to start recording the game for merge mode.
** For some reason trGamePause() from injectMergePause() takes too much time to activate so we can't invoke this from injectMergePause() in a clean way.
*/
void injectMergeRecGame() {
	code("rule _merge_rec_game");
	code("highFrequency");
	code("active");
	code("{");
		// 1.0 sec delay before initializing recorded game (may have to change this depending on rec desync results).
		injectRuleInterval(0, 1000);

		if(cVersion != cVersionVanilla) {
			code("trChatHistoryClear();");
		}

		sendChatWhite("");
		sendChatWhite("");
		sendChatWhite(cInfoLine);
		sendChatWhite("");
		sendChatWhite("Merge mode enabled.");

		if(cVersion != cVersionEE) {
			sendChatWhite("");
			sendChatWhite("Initializing recorded game.");
			sendChatWhite("");
			sendChatRed("The game will freeze for some seconds.");
		}

		sendChatWhite("");
		sendChatWhite(cInfoLine);
		sendChatWhite("");
		sendChatWhite("");

		if(cVersion != cVersionEE) {
			code("trStartGameRecord();");
		}

		code("xsDisableSelf();");
	code("}");
}

/****************
* BALANCE RULES *
****************/

/*
** Injects the rain fix that addresses the 50% enhanced wood gather rate for the caster (hardcoded).
** Requires game constants to be injected (techs/tech status).
*/
void injectRainFix() {
	// Inject as much as possible here to gain maximum performance.
	for(i = 1; < cPlayers) {
		int p = getPlayer(i);

		if(rmGetPlayerCiv(p) == cCivRa) {
			// Global tech status variables.
			code("int handAxeStatus" + p + " = cTechStatusUnobtainable;");
			code("int bowSawStatus" + p + " = cTechStatusUnobtainable;");
			code("int carpentersStatus" + p + " = cTechStatusUnobtainable;");
			code("int adzeStatus" + p + " = cTechStatusUnobtainable;");

			code("rule _rain_update_check_" + p);
			code("inactive");
			code("highFrequency");
			code("{");
	            // injectRuleInterval(); // No interval, check as often as possible.

				code("if(trCheckGPActive(\"Rain\", " + p + ") == false)");
				code("{");
					// Rain ended.
					// code("trChatSend(" + p + ", \"rain ended\");");

					// Remove penalty tech.
					code("trTechSetStatus(" + p + ", cTechRainFix, cTechStatusUnobtainable);");

					// Done.
					code("xsDisableSelf();");
					code("return;");
				code("}");

				code("int oldContext = xsGetContextPlayer();");
				code("xsSetContextPlayer(" + p + ");");

				code("int tempHandAxeStatus = kbGetTechStatus(cTechHandAxe);");
				code("int tempBowSawStatus = kbGetTechStatus(cTechBowSaw);");
				code("int tempCarpentersStatus = kbGetTechStatus(cTechCarpenters);");
				code("int tempAdzeStatus = kbGetTechStatus(cTechAdzeOfWepwawet);");

				// This is extremely ugly due to the possibility of completing research of Adze at the same time as one of the 3 other upgrades.
				code("bool adzeNew = adzeStatus" + p + " != tempAdzeStatus && tempAdzeStatus == cTechStatusActive;");

				code("if(adzeNew)");
				code("{");
					code("trTechSetStatus(" + p + ", cTechAdzeOfWepwawet, cTechStatusUnobtainable);");
				code("}");

				code("if(handAxeStatus" + p + " != tempHandAxeStatus && tempHandAxeStatus == cTechStatusActive)");
				code("{");
					code("trTechSetStatus(" + p + ", cTechHandAxe, cTechStatusUnobtainable);");
					code("trTechSetStatus(" + p + ", cTechRainFix, cTechStatusUnobtainable);");
					code("trTechSetStatus(" + p + ", cTechHandAxe, cTechStatusActive);");
					code("trTechSetStatus(" + p + ", cTechRainFix, cTechStatusActive);");
				code("}");
				code("if(bowSawStatus" + p + " != tempBowSawStatus && tempBowSawStatus == cTechStatusActive)");
				code("{");
					code("trTechSetStatus(" + p + ", cTechBowSaw, cTechStatusUnobtainable);");
					code("trTechSetStatus(" + p + ", cTechRainFix, cTechStatusUnobtainable);");
					code("trTechSetStatus(" + p + ", cTechBowSaw, cTechStatusActive);");
					code("trTechSetStatus(" + p + ", cTechRainFix, cTechStatusActive);");
				code("}");
				code("if(carpentersStatus" + p + " != tempCarpentersStatus && tempCarpentersStatus == cTechStatusActive)");
				code("{");
					code("trTechSetStatus(" + p + ", cTechCarpenters, cTechStatusUnobtainable);");
					code("trTechSetStatus(" + p + ", cTechRainFix, cTechStatusUnobtainable);");
					code("trTechSetStatus(" + p + ", cTechCarpenters, cTechStatusActive);");
					code("trTechSetStatus(" + p + ", cTechRainFix, cTechStatusActive);");
				code("}");
				code("if(adzeNew)");
				code("{");
					// code("trTechSetStatus(" + p + ", cTechAdzeOfWepwawet, cTechStatusUnobtainable);");
					code("trTechSetStatus(" + p + ", cTechRainFix, cTechStatusUnobtainable);");
					code("trTechSetStatus(" + p + ", cTechAdzeOfWepwawet, cTechStatusActive);");
					code("trTechSetStatus(" + p + ", cTechRainFix, cTechStatusActive);");
				code("}");

				code("handAxeStatus" + p + " = kbGetTechStatus(cTechHandAxe);");
				code("bowSawStatus" + p + " = kbGetTechStatus(cTechBowSaw);");
				code("carpentersStatus" + p + " = kbGetTechStatus(cTechCarpenters);");
				code("adzeStatus" + p + " = kbGetTechStatus(cTechAdzeOfWepwawet);");

				code("xsSetContextPlayer(oldContext);");
	        code("}");

			code("rule _rain_enable_check_" + p);
	        code("active");
			code("highFrequency");
	        code("{");
	            // injectRuleInterval(); // No interval, check as often as possible.

				code("if(trCheckGPActive(\"Rain\", " + p + "))");
				code("{");
					// Rain active.
					// code("trChatSend(" + p + ", \"rain active\");");

					// Set context.
					code("int oldContext = xsGetContextPlayer();");
					code("xsSetContextPlayer(" + p + ");");

					// Store current tech status.
					code("handAxeStatus" + p + " = kbGetTechStatus(cTechHandAxe);");
					code("bowSawStatus" + p + " = kbGetTechStatus(cTechBowSaw);");
					code("carpentersStatus" + p + " = kbGetTechStatus(cTechCarpenters);");
					code("adzeStatus" + p + " = kbGetTechStatus(cTechAdzeOfWepwawet);");

					code("xsSetContextPlayer(oldContext);");

					// Grant penalty tech.
					code("trTechSetStatus(" + p + ", cTechRainFix, cTechStatusActive);");

					// Toggle update to compensate for new wood upgrades researched during rain.
					code("trDelayedRuleActivation(\"_rain_update_check_" + p + "\");");

					code("xsDisableSelf();");
				code("}");

	        code("}");
		}
	}
}
