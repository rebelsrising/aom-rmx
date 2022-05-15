/*
** Spawn checking for non-mirrored object IDs and proto names.
** RebelsRising
** Last edit: 20/03/2022
**
** You have two options to verify placement:
**
** 1. By adding a check via trigger for a specific proto name.
**    To do so, you have call addProtoPlacementCheck() (see the proto check section below).
**
** 2. Checking immediately when placing the object whether placement succeeded.
**    There are several things you have to do for correct tracking:
**    1. Use createObjectDefVerify() to create the object definition (it returns an integer so you can replace rmCreateObjectDef() 1:1).
**    2. Use addObjectDefItemVerify() instead of rmAddObjectDefItem(), can also be replaced 1:1.
**    3. DO NOT use the regular rm placement functions for placing that object. Use anything from the RM X library
**       (e.g. the default placeObjectAtPlayerLocs that replaces rmPlaceObjectDefPerPlayer()).
**       The usage of the standard placement functions for anything except embellishment objects is strongly discouraged in this framework.
*/

include "rmx_locations.xs";

/**************
* PROTO CHECK *
**************/

int protoCheckCount = 0;

// Contains the proto name of the object.
string protoName0   = "?"; string protoName1   = "?"; string protoName2   = "?"; string protoName3   = "?";
string protoName4   = "?"; string protoName5   = "?"; string protoName6   = "?"; string protoName7   = "?";
string protoName8   = "?"; string protoName9   = "?"; string protoName10  = "?"; string protoName11  = "?";
string protoName12  = "?"; string protoName13  = "?"; string protoName14  = "?"; string protoName15  = "?";
string protoName16  = "?"; string protoName17  = "?"; string protoName18  = "?"; string protoName19  = "?";
string protoName20  = "?"; string protoName21  = "?"; string protoName22  = "?"; string protoName23  = "?";
string protoName24  = "?"; string protoName25  = "?"; string protoName26  = "?"; string protoName27  = "?";
string protoName28  = "?"; string protoName29  = "?"; string protoName30  = "?"; string protoName31  = "?";
string protoName32  = "?"; string protoName33  = "?"; string protoName34  = "?"; string protoName35  = "?";
string protoName36  = "?"; string protoName37  = "?"; string protoName38  = "?"; string protoName39  = "?";
string protoName40  = "?"; string protoName41  = "?"; string protoName42  = "?"; string protoName43  = "?";
string protoName44  = "?"; string protoName45  = "?"; string protoName46  = "?"; string protoName47  = "?";
string protoName48  = "?"; string protoName49  = "?"; string protoName50  = "?"; string protoName51  = "?";
string protoName52  = "?"; string protoName53  = "?"; string protoName54  = "?"; string protoName55  = "?";
string protoName56  = "?"; string protoName57  = "?"; string protoName58  = "?"; string protoName59  = "?";
string protoName60  = "?"; string protoName61  = "?"; string protoName62  = "?"; string protoName63  = "?";
string protoName64  = "?"; string protoName65  = "?"; string protoName66  = "?"; string protoName67  = "?";
string protoName68  = "?"; string protoName69  = "?"; string protoName70  = "?"; string protoName71  = "?";
string protoName72  = "?"; string protoName73  = "?"; string protoName74  = "?"; string protoName75  = "?";
string protoName76  = "?"; string protoName77  = "?"; string protoName78  = "?"; string protoName79  = "?";
string protoName80  = "?"; string protoName81  = "?"; string protoName82  = "?"; string protoName83  = "?";
string protoName84  = "?"; string protoName85  = "?"; string protoName86  = "?"; string protoName87  = "?";
string protoName88  = "?"; string protoName89  = "?"; string protoName90  = "?"; string protoName91  = "?";
string protoName92  = "?"; string protoName93  = "?"; string protoName94  = "?"; string protoName95  = "?";
string protoName96  = "?"; string protoName97  = "?"; string protoName98  = "?"; string protoName99  = "?";
string protoName100 = "?"; string protoName101 = "?"; string protoName102 = "?"; string protoName103 = "?";
string protoName104 = "?"; string protoName105 = "?"; string protoName106 = "?"; string protoName107 = "?";
string protoName108 = "?"; string protoName109 = "?"; string protoName110 = "?"; string protoName111 = "?";
string protoName112 = "?"; string protoName113 = "?"; string protoName114 = "?"; string protoName115 = "?";
string protoName116 = "?"; string protoName117 = "?"; string protoName118 = "?"; string protoName119 = "?";
string protoName120 = "?"; string protoName121 = "?"; string protoName122 = "?"; string protoName123 = "?";
string protoName124 = "?"; string protoName125 = "?"; string protoName126 = "?"; string protoName127 = "?";
string protoName128 = "?"; string protoName129 = "?"; string protoName130 = "?"; string protoName131 = "?";
string protoName132 = "?"; string protoName133 = "?"; string protoName134 = "?"; string protoName135 = "?";
string protoName136 = "?"; string protoName137 = "?"; string protoName138 = "?"; string protoName139 = "?";
string protoName140 = "?"; string protoName141 = "?"; string protoName142 = "?"; string protoName143 = "?";
string protoName144 = "?"; string protoName145 = "?"; string protoName146 = "?"; string protoName147 = "?";
string protoName148 = "?"; string protoName149 = "?"; string protoName150 = "?"; string protoName151 = "?";
string protoName152 = "?"; string protoName153 = "?"; string protoName154 = "?"; string protoName155 = "?";
string protoName156 = "?"; string protoName157 = "?"; string protoName158 = "?"; string protoName159 = "?";
string protoName160 = "?"; string protoName161 = "?"; string protoName162 = "?"; string protoName163 = "?";
string protoName164 = "?"; string protoName165 = "?"; string protoName166 = "?"; string protoName167 = "?";
string protoName168 = "?"; string protoName169 = "?"; string protoName170 = "?"; string protoName171 = "?";
string protoName172 = "?"; string protoName173 = "?"; string protoName174 = "?"; string protoName175 = "?";
string protoName176 = "?"; string protoName177 = "?"; string protoName178 = "?"; string protoName179 = "?";
string protoName180 = "?"; string protoName181 = "?"; string protoName182 = "?"; string protoName183 = "?";
string protoName184 = "?"; string protoName185 = "?"; string protoName186 = "?"; string protoName187 = "?";
string protoName188 = "?"; string protoName189 = "?"; string protoName190 = "?"; string protoName191 = "?";
string protoName192 = "?"; string protoName193 = "?"; string protoName194 = "?"; string protoName195 = "?";
string protoName196 = "?"; string protoName197 = "?"; string protoName198 = "?"; string protoName199 = "?";
string protoName200 = "?"; string protoName201 = "?"; string protoName202 = "?"; string protoName203 = "?";
string protoName204 = "?"; string protoName205 = "?"; string protoName206 = "?"; string protoName207 = "?";
string protoName208 = "?"; string protoName209 = "?"; string protoName210 = "?"; string protoName211 = "?";
string protoName212 = "?"; string protoName213 = "?"; string protoName214 = "?"; string protoName215 = "?";
string protoName216 = "?"; string protoName217 = "?"; string protoName218 = "?"; string protoName219 = "?";
string protoName220 = "?"; string protoName221 = "?"; string protoName222 = "?"; string protoName223 = "?";
string protoName224 = "?"; string protoName225 = "?"; string protoName226 = "?"; string protoName227 = "?";
string protoName228 = "?"; string protoName229 = "?"; string protoName230 = "?"; string protoName231 = "?";
string protoName232 = "?"; string protoName233 = "?"; string protoName234 = "?"; string protoName235 = "?";
string protoName236 = "?"; string protoName237 = "?"; string protoName238 = "?"; string protoName239 = "?";

string getProtoName(int i = -1) {
	if(i == 0)   return(protoName0);   if(i == 1)   return(protoName1);   if(i == 2)   return(protoName2);   if(i == 3)   return(protoName3);
	if(i == 4)   return(protoName4);   if(i == 5)   return(protoName5);   if(i == 6)   return(protoName6);   if(i == 7)   return(protoName7);
	if(i == 8)   return(protoName8);   if(i == 9)   return(protoName9);   if(i == 10)  return(protoName10);  if(i == 11)  return(protoName11);
	if(i == 12)  return(protoName12);  if(i == 13)  return(protoName13);  if(i == 14)  return(protoName14);  if(i == 15)  return(protoName15);
	if(i == 16)  return(protoName16);  if(i == 17)  return(protoName17);  if(i == 18)  return(protoName18);  if(i == 19)  return(protoName19);
	if(i == 20)  return(protoName20);  if(i == 21)  return(protoName21);  if(i == 22)  return(protoName22);  if(i == 23)  return(protoName23);
	if(i == 24)  return(protoName24);  if(i == 25)  return(protoName25);  if(i == 26)  return(protoName26);  if(i == 27)  return(protoName27);
	if(i == 28)  return(protoName28);  if(i == 29)  return(protoName29);  if(i == 30)  return(protoName30);  if(i == 31)  return(protoName31);
	if(i == 32)  return(protoName32);  if(i == 33)  return(protoName33);  if(i == 34)  return(protoName34);  if(i == 35)  return(protoName35);
	if(i == 36)  return(protoName36);  if(i == 37)  return(protoName37);  if(i == 38)  return(protoName38);  if(i == 39)  return(protoName39);
	if(i == 40)  return(protoName40);  if(i == 41)  return(protoName41);  if(i == 42)  return(protoName42);  if(i == 43)  return(protoName43);
	if(i == 44)  return(protoName44);  if(i == 45)  return(protoName45);  if(i == 46)  return(protoName46);  if(i == 47)  return(protoName47);
	if(i == 48)  return(protoName48);  if(i == 49)  return(protoName49);  if(i == 50)  return(protoName50);  if(i == 51)  return(protoName51);
	if(i == 52)  return(protoName52);  if(i == 53)  return(protoName53);  if(i == 54)  return(protoName54);  if(i == 55)  return(protoName55);
	if(i == 56)  return(protoName56);  if(i == 57)  return(protoName57);  if(i == 58)  return(protoName58);  if(i == 59)  return(protoName59);
	if(i == 60)  return(protoName60);  if(i == 61)  return(protoName61);  if(i == 62)  return(protoName62);  if(i == 63)  return(protoName63);
	if(i == 64)  return(protoName64);  if(i == 65)  return(protoName65);  if(i == 66)  return(protoName66);  if(i == 67)  return(protoName67);
	if(i == 68)  return(protoName68);  if(i == 69)  return(protoName69);  if(i == 70)  return(protoName70);  if(i == 71)  return(protoName71);
	if(i == 72)  return(protoName72);  if(i == 73)  return(protoName73);  if(i == 74)  return(protoName74);  if(i == 75)  return(protoName75);
	if(i == 76)  return(protoName76);  if(i == 77)  return(protoName77);  if(i == 78)  return(protoName78);  if(i == 79)  return(protoName79);
	if(i == 80)  return(protoName80);  if(i == 81)  return(protoName81);  if(i == 82)  return(protoName82);  if(i == 83)  return(protoName83);
	if(i == 84)  return(protoName84);  if(i == 85)  return(protoName85);  if(i == 86)  return(protoName86);  if(i == 87)  return(protoName87);
	if(i == 88)  return(protoName88);  if(i == 89)  return(protoName89);  if(i == 90)  return(protoName90);  if(i == 91)  return(protoName91);
	if(i == 92)  return(protoName92);  if(i == 93)  return(protoName93);  if(i == 94)  return(protoName94);  if(i == 95)  return(protoName95);
	if(i == 96)  return(protoName96);  if(i == 97)  return(protoName97);  if(i == 98)  return(protoName98);  if(i == 99)  return(protoName99);
	if(i == 100) return(protoName100); if(i == 101) return(protoName101); if(i == 102) return(protoName102); if(i == 103) return(protoName103);
	if(i == 104) return(protoName104); if(i == 105) return(protoName105); if(i == 106) return(protoName106); if(i == 107) return(protoName107);
	if(i == 108) return(protoName108); if(i == 109) return(protoName109); if(i == 110) return(protoName110); if(i == 111) return(protoName111);
	if(i == 112) return(protoName112); if(i == 113) return(protoName113); if(i == 114) return(protoName114); if(i == 115) return(protoName115);
	if(i == 116) return(protoName116); if(i == 117) return(protoName117); if(i == 118) return(protoName118); if(i == 119) return(protoName119);
	if(i == 120) return(protoName120); if(i == 121) return(protoName121); if(i == 122) return(protoName122); if(i == 123) return(protoName123);
	if(i == 124) return(protoName124); if(i == 125) return(protoName125); if(i == 126) return(protoName126); if(i == 127) return(protoName127);
	if(i == 128) return(protoName128); if(i == 129) return(protoName129); if(i == 130) return(protoName130); if(i == 131) return(protoName131);
	if(i == 132) return(protoName132); if(i == 133) return(protoName133); if(i == 134) return(protoName134); if(i == 135) return(protoName135);
	if(i == 136) return(protoName136); if(i == 137) return(protoName137); if(i == 138) return(protoName138); if(i == 139) return(protoName139);
	if(i == 140) return(protoName140); if(i == 141) return(protoName141); if(i == 142) return(protoName142); if(i == 143) return(protoName143);
	if(i == 144) return(protoName144); if(i == 145) return(protoName145); if(i == 146) return(protoName146); if(i == 147) return(protoName147);
	if(i == 148) return(protoName148); if(i == 149) return(protoName149); if(i == 150) return(protoName150); if(i == 151) return(protoName151);
	if(i == 152) return(protoName152); if(i == 153) return(protoName153); if(i == 154) return(protoName154); if(i == 155) return(protoName155);
	if(i == 156) return(protoName156); if(i == 157) return(protoName157); if(i == 158) return(protoName158); if(i == 159) return(protoName159);
	if(i == 160) return(protoName160); if(i == 161) return(protoName161); if(i == 162) return(protoName162); if(i == 163) return(protoName163);
	if(i == 164) return(protoName164); if(i == 165) return(protoName165); if(i == 166) return(protoName166); if(i == 167) return(protoName167);
	if(i == 168) return(protoName168); if(i == 169) return(protoName169); if(i == 170) return(protoName170); if(i == 171) return(protoName171);
	if(i == 172) return(protoName172); if(i == 173) return(protoName173); if(i == 174) return(protoName174); if(i == 175) return(protoName175);
	if(i == 176) return(protoName176); if(i == 177) return(protoName177); if(i == 178) return(protoName178); if(i == 179) return(protoName179);
	if(i == 180) return(protoName180); if(i == 181) return(protoName181); if(i == 182) return(protoName182); if(i == 183) return(protoName183);
	if(i == 184) return(protoName184); if(i == 185) return(protoName185); if(i == 186) return(protoName186); if(i == 187) return(protoName187);
	if(i == 188) return(protoName188); if(i == 189) return(protoName189); if(i == 190) return(protoName190); if(i == 191) return(protoName191);
	if(i == 192) return(protoName192); if(i == 193) return(protoName193); if(i == 194) return(protoName194); if(i == 195) return(protoName195);
	if(i == 196) return(protoName196); if(i == 197) return(protoName197); if(i == 198) return(protoName198); if(i == 199) return(protoName199);
	if(i == 200) return(protoName200); if(i == 201) return(protoName201); if(i == 202) return(protoName202); if(i == 203) return(protoName203);
	if(i == 204) return(protoName204); if(i == 205) return(protoName205); if(i == 206) return(protoName206); if(i == 207) return(protoName207);
	if(i == 208) return(protoName208); if(i == 209) return(protoName209); if(i == 210) return(protoName210); if(i == 211) return(protoName211);
	if(i == 212) return(protoName212); if(i == 213) return(protoName213); if(i == 214) return(protoName214); if(i == 215) return(protoName215);
	if(i == 216) return(protoName216); if(i == 217) return(protoName217); if(i == 218) return(protoName218); if(i == 219) return(protoName219);
	if(i == 220) return(protoName220); if(i == 221) return(protoName221); if(i == 222) return(protoName222); if(i == 223) return(protoName223);
	if(i == 224) return(protoName224); if(i == 225) return(protoName225); if(i == 226) return(protoName226); if(i == 227) return(protoName227);
	if(i == 228) return(protoName228); if(i == 229) return(protoName229); if(i == 230) return(protoName230); if(i == 231) return(protoName231);
	if(i == 232) return(protoName232); if(i == 233) return(protoName233); if(i == 234) return(protoName234); if(i == 235) return(protoName235);
	if(i == 236) return(protoName236); if(i == 237) return(protoName237); if(i == 238) return(protoName238); if(i == 239) return(protoName239);
	return("?");
}

void setProtoName(int i = -1, string lab = "") {
	if(i == 0)   protoName0   = lab; if(i == 1)   protoName1   = lab; if(i == 2)   protoName2   = lab; if(i == 3)   protoName3   = lab;
	if(i == 4)   protoName4   = lab; if(i == 5)   protoName5   = lab; if(i == 6)   protoName6   = lab; if(i == 7)   protoName7   = lab;
	if(i == 8)   protoName8   = lab; if(i == 9)   protoName9   = lab; if(i == 10)  protoName10  = lab; if(i == 11)  protoName11  = lab;
	if(i == 12)  protoName12  = lab; if(i == 13)  protoName13  = lab; if(i == 14)  protoName14  = lab; if(i == 15)  protoName15  = lab;
	if(i == 16)  protoName16  = lab; if(i == 17)  protoName17  = lab; if(i == 18)  protoName18  = lab; if(i == 19)  protoName19  = lab;
	if(i == 20)  protoName20  = lab; if(i == 21)  protoName21  = lab; if(i == 22)  protoName22  = lab; if(i == 23)  protoName23  = lab;
	if(i == 24)  protoName24  = lab; if(i == 25)  protoName25  = lab; if(i == 26)  protoName26  = lab; if(i == 27)  protoName27  = lab;
	if(i == 28)  protoName28  = lab; if(i == 29)  protoName29  = lab; if(i == 30)  protoName30  = lab; if(i == 31)  protoName31  = lab;
	if(i == 32)  protoName32  = lab; if(i == 33)  protoName33  = lab; if(i == 34)  protoName34  = lab; if(i == 35)  protoName35  = lab;
	if(i == 36)  protoName36  = lab; if(i == 37)  protoName37  = lab; if(i == 38)  protoName38  = lab; if(i == 39)  protoName39  = lab;
	if(i == 40)  protoName40  = lab; if(i == 41)  protoName41  = lab; if(i == 42)  protoName42  = lab; if(i == 43)  protoName43  = lab;
	if(i == 44)  protoName44  = lab; if(i == 45)  protoName45  = lab; if(i == 46)  protoName46  = lab; if(i == 47)  protoName47  = lab;
	if(i == 48)  protoName48  = lab; if(i == 49)  protoName49  = lab; if(i == 50)  protoName50  = lab; if(i == 51)  protoName51  = lab;
	if(i == 52)  protoName52  = lab; if(i == 53)  protoName53  = lab; if(i == 54)  protoName54  = lab; if(i == 55)  protoName55  = lab;
	if(i == 56)  protoName56  = lab; if(i == 57)  protoName57  = lab; if(i == 58)  protoName58  = lab; if(i == 59)  protoName59  = lab;
	if(i == 60)  protoName60  = lab; if(i == 61)  protoName61  = lab; if(i == 62)  protoName62  = lab; if(i == 63)  protoName63  = lab;
	if(i == 64)  protoName64  = lab; if(i == 65)  protoName65  = lab; if(i == 66)  protoName66  = lab; if(i == 67)  protoName67  = lab;
	if(i == 68)  protoName68  = lab; if(i == 69)  protoName69  = lab; if(i == 70)  protoName70  = lab; if(i == 71)  protoName71  = lab;
	if(i == 72)  protoName72  = lab; if(i == 73)  protoName73  = lab; if(i == 74)  protoName74  = lab; if(i == 75)  protoName75  = lab;
	if(i == 76)  protoName76  = lab; if(i == 77)  protoName77  = lab; if(i == 78)  protoName78  = lab; if(i == 79)  protoName79  = lab;
	if(i == 80)  protoName80  = lab; if(i == 81)  protoName81  = lab; if(i == 82)  protoName82  = lab; if(i == 83)  protoName83  = lab;
	if(i == 84)  protoName84  = lab; if(i == 85)  protoName85  = lab; if(i == 86)  protoName86  = lab; if(i == 87)  protoName87  = lab;
	if(i == 88)  protoName88  = lab; if(i == 89)  protoName89  = lab; if(i == 90)  protoName90  = lab; if(i == 91)  protoName91  = lab;
	if(i == 92)  protoName92  = lab; if(i == 93)  protoName93  = lab; if(i == 94)  protoName94  = lab; if(i == 95)  protoName95  = lab;
	if(i == 96)  protoName96  = lab; if(i == 97)  protoName97  = lab; if(i == 98)  protoName98  = lab; if(i == 99)  protoName99  = lab;
	if(i == 100) protoName100 = lab; if(i == 101) protoName101 = lab; if(i == 102) protoName102 = lab; if(i == 103) protoName103 = lab;
	if(i == 104) protoName104 = lab; if(i == 105) protoName105 = lab; if(i == 106) protoName106 = lab; if(i == 107) protoName107 = lab;
	if(i == 108) protoName108 = lab; if(i == 109) protoName109 = lab; if(i == 110) protoName110 = lab; if(i == 111) protoName111 = lab;
	if(i == 112) protoName112 = lab; if(i == 113) protoName113 = lab; if(i == 114) protoName114 = lab; if(i == 115) protoName115 = lab;
	if(i == 116) protoName116 = lab; if(i == 117) protoName117 = lab; if(i == 118) protoName118 = lab; if(i == 119) protoName119 = lab;
	if(i == 120) protoName120 = lab; if(i == 121) protoName121 = lab; if(i == 122) protoName122 = lab; if(i == 123) protoName123 = lab;
	if(i == 124) protoName124 = lab; if(i == 125) protoName125 = lab; if(i == 126) protoName126 = lab; if(i == 127) protoName127 = lab;
	if(i == 128) protoName128 = lab; if(i == 129) protoName129 = lab; if(i == 130) protoName130 = lab; if(i == 131) protoName131 = lab;
	if(i == 132) protoName132 = lab; if(i == 133) protoName133 = lab; if(i == 134) protoName134 = lab; if(i == 135) protoName135 = lab;
	if(i == 136) protoName136 = lab; if(i == 137) protoName137 = lab; if(i == 138) protoName138 = lab; if(i == 139) protoName139 = lab;
	if(i == 140) protoName140 = lab; if(i == 141) protoName141 = lab; if(i == 142) protoName142 = lab; if(i == 143) protoName143 = lab;
	if(i == 144) protoName144 = lab; if(i == 145) protoName145 = lab; if(i == 146) protoName146 = lab; if(i == 147) protoName147 = lab;
	if(i == 148) protoName148 = lab; if(i == 149) protoName149 = lab; if(i == 150) protoName150 = lab; if(i == 151) protoName151 = lab;
	if(i == 152) protoName152 = lab; if(i == 153) protoName153 = lab; if(i == 154) protoName154 = lab; if(i == 155) protoName155 = lab;
	if(i == 156) protoName156 = lab; if(i == 157) protoName157 = lab; if(i == 158) protoName158 = lab; if(i == 159) protoName159 = lab;
	if(i == 160) protoName160 = lab; if(i == 161) protoName161 = lab; if(i == 162) protoName162 = lab; if(i == 163) protoName163 = lab;
	if(i == 164) protoName164 = lab; if(i == 165) protoName165 = lab; if(i == 166) protoName166 = lab; if(i == 167) protoName167 = lab;
	if(i == 168) protoName168 = lab; if(i == 169) protoName169 = lab; if(i == 170) protoName170 = lab; if(i == 171) protoName171 = lab;
	if(i == 172) protoName172 = lab; if(i == 173) protoName173 = lab; if(i == 174) protoName174 = lab; if(i == 175) protoName175 = lab;
	if(i == 176) protoName176 = lab; if(i == 177) protoName177 = lab; if(i == 178) protoName178 = lab; if(i == 179) protoName179 = lab;
	if(i == 180) protoName180 = lab; if(i == 181) protoName181 = lab; if(i == 182) protoName182 = lab; if(i == 183) protoName183 = lab;
	if(i == 184) protoName184 = lab; if(i == 185) protoName185 = lab; if(i == 186) protoName186 = lab; if(i == 187) protoName187 = lab;
	if(i == 188) protoName188 = lab; if(i == 189) protoName189 = lab; if(i == 190) protoName190 = lab; if(i == 191) protoName191 = lab;
	if(i == 192) protoName192 = lab; if(i == 193) protoName193 = lab; if(i == 194) protoName194 = lab; if(i == 195) protoName195 = lab;
	if(i == 196) protoName196 = lab; if(i == 197) protoName197 = lab; if(i == 198) protoName198 = lab; if(i == 199) protoName199 = lab;
	if(i == 200) protoName200 = lab; if(i == 201) protoName201 = lab; if(i == 202) protoName202 = lab; if(i == 203) protoName203 = lab;
	if(i == 204) protoName204 = lab; if(i == 205) protoName205 = lab; if(i == 206) protoName206 = lab; if(i == 207) protoName207 = lab;
	if(i == 208) protoName208 = lab; if(i == 209) protoName209 = lab; if(i == 210) protoName210 = lab; if(i == 211) protoName211 = lab;
	if(i == 212) protoName212 = lab; if(i == 213) protoName213 = lab; if(i == 214) protoName214 = lab; if(i == 215) protoName215 = lab;
	if(i == 216) protoName216 = lab; if(i == 217) protoName217 = lab; if(i == 218) protoName218 = lab; if(i == 219) protoName219 = lab;
	if(i == 220) protoName220 = lab; if(i == 221) protoName221 = lab; if(i == 222) protoName222 = lab; if(i == 223) protoName223 = lab;
	if(i == 224) protoName224 = lab; if(i == 225) protoName225 = lab; if(i == 226) protoName226 = lab; if(i == 227) protoName227 = lab;
	if(i == 228) protoName228 = lab; if(i == 229) protoName229 = lab; if(i == 230) protoName230 = lab; if(i == 231) protoName231 = lab;
	if(i == 232) protoName232 = lab; if(i == 233) protoName233 = lab; if(i == 234) protoName234 = lab; if(i == 235) protoName235 = lab;
	if(i == 236) protoName236 = lab; if(i == 237) protoName237 = lab; if(i == 238) protoName238 = lab; if(i == 239) protoName239 = lab;
}

// Contains the counts for the objects.
int protoTargetCount0   = 0; int protoTargetCount1   = 0; int protoTargetCount2   = 0; int protoTargetCount3   = 0;
int protoTargetCount4   = 0; int protoTargetCount5   = 0; int protoTargetCount6   = 0; int protoTargetCount7   = 0;
int protoTargetCount8   = 0; int protoTargetCount9   = 0; int protoTargetCount10  = 0; int protoTargetCount11  = 0;
int protoTargetCount12  = 0; int protoTargetCount13  = 0; int protoTargetCount14  = 0; int protoTargetCount15  = 0;
int protoTargetCount16  = 0; int protoTargetCount17  = 0; int protoTargetCount18  = 0; int protoTargetCount19  = 0;
int protoTargetCount20  = 0; int protoTargetCount21  = 0; int protoTargetCount22  = 0; int protoTargetCount23  = 0;
int protoTargetCount24  = 0; int protoTargetCount25  = 0; int protoTargetCount26  = 0; int protoTargetCount27  = 0;
int protoTargetCount28  = 0; int protoTargetCount29  = 0; int protoTargetCount30  = 0; int protoTargetCount31  = 0;
int protoTargetCount32  = 0; int protoTargetCount33  = 0; int protoTargetCount34  = 0; int protoTargetCount35  = 0;
int protoTargetCount36  = 0; int protoTargetCount37  = 0; int protoTargetCount38  = 0; int protoTargetCount39  = 0;
int protoTargetCount40  = 0; int protoTargetCount41  = 0; int protoTargetCount42  = 0; int protoTargetCount43  = 0;
int protoTargetCount44  = 0; int protoTargetCount45  = 0; int protoTargetCount46  = 0; int protoTargetCount47  = 0;
int protoTargetCount48  = 0; int protoTargetCount49  = 0; int protoTargetCount50  = 0; int protoTargetCount51  = 0;
int protoTargetCount52  = 0; int protoTargetCount53  = 0; int protoTargetCount54  = 0; int protoTargetCount55  = 0;
int protoTargetCount56  = 0; int protoTargetCount57  = 0; int protoTargetCount58  = 0; int protoTargetCount59  = 0;
int protoTargetCount60  = 0; int protoTargetCount61  = 0; int protoTargetCount62  = 0; int protoTargetCount63  = 0;
int protoTargetCount64  = 0; int protoTargetCount65  = 0; int protoTargetCount66  = 0; int protoTargetCount67  = 0;
int protoTargetCount68  = 0; int protoTargetCount69  = 0; int protoTargetCount70  = 0; int protoTargetCount71  = 0;
int protoTargetCount72  = 0; int protoTargetCount73  = 0; int protoTargetCount74  = 0; int protoTargetCount75  = 0;
int protoTargetCount76  = 0; int protoTargetCount77  = 0; int protoTargetCount78  = 0; int protoTargetCount79  = 0;
int protoTargetCount80  = 0; int protoTargetCount81  = 0; int protoTargetCount82  = 0; int protoTargetCount83  = 0;
int protoTargetCount84  = 0; int protoTargetCount85  = 0; int protoTargetCount86  = 0; int protoTargetCount87  = 0;
int protoTargetCount88  = 0; int protoTargetCount89  = 0; int protoTargetCount90  = 0; int protoTargetCount91  = 0;
int protoTargetCount92  = 0; int protoTargetCount93  = 0; int protoTargetCount94  = 0; int protoTargetCount95  = 0;
int protoTargetCount96  = 0; int protoTargetCount97  = 0; int protoTargetCount98  = 0; int protoTargetCount99  = 0;
int protoTargetCount100 = 0; int protoTargetCount101 = 0; int protoTargetCount102 = 0; int protoTargetCount103 = 0;
int protoTargetCount104 = 0; int protoTargetCount105 = 0; int protoTargetCount106 = 0; int protoTargetCount107 = 0;
int protoTargetCount108 = 0; int protoTargetCount109 = 0; int protoTargetCount110 = 0; int protoTargetCount111 = 0;
int protoTargetCount112 = 0; int protoTargetCount113 = 0; int protoTargetCount114 = 0; int protoTargetCount115 = 0;
int protoTargetCount116 = 0; int protoTargetCount117 = 0; int protoTargetCount118 = 0; int protoTargetCount119 = 0;
int protoTargetCount120 = 0; int protoTargetCount121 = 0; int protoTargetCount122 = 0; int protoTargetCount123 = 0;
int protoTargetCount124 = 0; int protoTargetCount125 = 0; int protoTargetCount126 = 0; int protoTargetCount127 = 0;
int protoTargetCount128 = 0; int protoTargetCount129 = 0; int protoTargetCount130 = 0; int protoTargetCount131 = 0;
int protoTargetCount132 = 0; int protoTargetCount133 = 0; int protoTargetCount134 = 0; int protoTargetCount135 = 0;
int protoTargetCount136 = 0; int protoTargetCount137 = 0; int protoTargetCount138 = 0; int protoTargetCount139 = 0;
int protoTargetCount140 = 0; int protoTargetCount141 = 0; int protoTargetCount142 = 0; int protoTargetCount143 = 0;
int protoTargetCount144 = 0; int protoTargetCount145 = 0; int protoTargetCount146 = 0; int protoTargetCount147 = 0;
int protoTargetCount148 = 0; int protoTargetCount149 = 0; int protoTargetCount150 = 0; int protoTargetCount151 = 0;
int protoTargetCount152 = 0; int protoTargetCount153 = 0; int protoTargetCount154 = 0; int protoTargetCount155 = 0;
int protoTargetCount156 = 0; int protoTargetCount157 = 0; int protoTargetCount158 = 0; int protoTargetCount159 = 0;
int protoTargetCount160 = 0; int protoTargetCount161 = 0; int protoTargetCount162 = 0; int protoTargetCount163 = 0;
int protoTargetCount164 = 0; int protoTargetCount165 = 0; int protoTargetCount166 = 0; int protoTargetCount167 = 0;
int protoTargetCount168 = 0; int protoTargetCount169 = 0; int protoTargetCount170 = 0; int protoTargetCount171 = 0;
int protoTargetCount172 = 0; int protoTargetCount173 = 0; int protoTargetCount174 = 0; int protoTargetCount175 = 0;
int protoTargetCount176 = 0; int protoTargetCount177 = 0; int protoTargetCount178 = 0; int protoTargetCount179 = 0;
int protoTargetCount180 = 0; int protoTargetCount181 = 0; int protoTargetCount182 = 0; int protoTargetCount183 = 0;
int protoTargetCount184 = 0; int protoTargetCount185 = 0; int protoTargetCount186 = 0; int protoTargetCount187 = 0;
int protoTargetCount188 = 0; int protoTargetCount189 = 0; int protoTargetCount190 = 0; int protoTargetCount191 = 0;
int protoTargetCount192 = 0; int protoTargetCount193 = 0; int protoTargetCount194 = 0; int protoTargetCount195 = 0;
int protoTargetCount196 = 0; int protoTargetCount197 = 0; int protoTargetCount198 = 0; int protoTargetCount199 = 0;
int protoTargetCount200 = 0; int protoTargetCount201 = 0; int protoTargetCount202 = 0; int protoTargetCount203 = 0;
int protoTargetCount204 = 0; int protoTargetCount205 = 0; int protoTargetCount206 = 0; int protoTargetCount207 = 0;
int protoTargetCount208 = 0; int protoTargetCount209 = 0; int protoTargetCount210 = 0; int protoTargetCount211 = 0;
int protoTargetCount212 = 0; int protoTargetCount213 = 0; int protoTargetCount214 = 0; int protoTargetCount215 = 0;
int protoTargetCount216 = 0; int protoTargetCount217 = 0; int protoTargetCount218 = 0; int protoTargetCount219 = 0;
int protoTargetCount220 = 0; int protoTargetCount221 = 0; int protoTargetCount222 = 0; int protoTargetCount223 = 0;
int protoTargetCount224 = 0; int protoTargetCount225 = 0; int protoTargetCount226 = 0; int protoTargetCount227 = 0;
int protoTargetCount228 = 0; int protoTargetCount229 = 0; int protoTargetCount230 = 0; int protoTargetCount231 = 0;
int protoTargetCount232 = 0; int protoTargetCount233 = 0; int protoTargetCount234 = 0; int protoTargetCount235 = 0;
int protoTargetCount236 = 0; int protoTargetCount237 = 0; int protoTargetCount238 = 0; int protoTargetCount239 = 0;

int getProtoTargetCount(int i = -1) {
	if(i == 0)   return(protoTargetCount0);   if(i == 1)   return(protoTargetCount1);   if(i == 2)   return(protoTargetCount2);   if(i == 3)   return(protoTargetCount3);
	if(i == 4)   return(protoTargetCount4);   if(i == 5)   return(protoTargetCount5);   if(i == 6)   return(protoTargetCount6);   if(i == 7)   return(protoTargetCount7);
	if(i == 8)   return(protoTargetCount8);   if(i == 9)   return(protoTargetCount9);   if(i == 10)  return(protoTargetCount10);  if(i == 11)  return(protoTargetCount11);
	if(i == 12)  return(protoTargetCount12);  if(i == 13)  return(protoTargetCount13);  if(i == 14)  return(protoTargetCount14);  if(i == 15)  return(protoTargetCount15);
	if(i == 16)  return(protoTargetCount16);  if(i == 17)  return(protoTargetCount17);  if(i == 18)  return(protoTargetCount18);  if(i == 19)  return(protoTargetCount19);
	if(i == 20)  return(protoTargetCount20);  if(i == 21)  return(protoTargetCount21);  if(i == 22)  return(protoTargetCount22);  if(i == 23)  return(protoTargetCount23);
	if(i == 24)  return(protoTargetCount24);  if(i == 25)  return(protoTargetCount25);  if(i == 26)  return(protoTargetCount26);  if(i == 27)  return(protoTargetCount27);
	if(i == 28)  return(protoTargetCount28);  if(i == 29)  return(protoTargetCount29);  if(i == 30)  return(protoTargetCount30);  if(i == 31)  return(protoTargetCount31);
	if(i == 32)  return(protoTargetCount32);  if(i == 33)  return(protoTargetCount33);  if(i == 34)  return(protoTargetCount34);  if(i == 35)  return(protoTargetCount35);
	if(i == 36)  return(protoTargetCount36);  if(i == 37)  return(protoTargetCount37);  if(i == 38)  return(protoTargetCount38);  if(i == 39)  return(protoTargetCount39);
	if(i == 40)  return(protoTargetCount40);  if(i == 41)  return(protoTargetCount41);  if(i == 42)  return(protoTargetCount42);  if(i == 43)  return(protoTargetCount43);
	if(i == 44)  return(protoTargetCount44);  if(i == 45)  return(protoTargetCount45);  if(i == 46)  return(protoTargetCount46);  if(i == 47)  return(protoTargetCount47);
	if(i == 48)  return(protoTargetCount48);  if(i == 49)  return(protoTargetCount49);  if(i == 50)  return(protoTargetCount50);  if(i == 51)  return(protoTargetCount51);
	if(i == 52)  return(protoTargetCount52);  if(i == 53)  return(protoTargetCount53);  if(i == 54)  return(protoTargetCount54);  if(i == 55)  return(protoTargetCount55);
	if(i == 56)  return(protoTargetCount56);  if(i == 57)  return(protoTargetCount57);  if(i == 58)  return(protoTargetCount58);  if(i == 59)  return(protoTargetCount59);
	if(i == 60)  return(protoTargetCount60);  if(i == 61)  return(protoTargetCount61);  if(i == 62)  return(protoTargetCount62);  if(i == 63)  return(protoTargetCount63);
	if(i == 64)  return(protoTargetCount64);  if(i == 65)  return(protoTargetCount65);  if(i == 66)  return(protoTargetCount66);  if(i == 67)  return(protoTargetCount67);
	if(i == 68)  return(protoTargetCount68);  if(i == 69)  return(protoTargetCount69);  if(i == 70)  return(protoTargetCount70);  if(i == 71)  return(protoTargetCount71);
	if(i == 72)  return(protoTargetCount72);  if(i == 73)  return(protoTargetCount73);  if(i == 74)  return(protoTargetCount74);  if(i == 75)  return(protoTargetCount75);
	if(i == 76)  return(protoTargetCount76);  if(i == 77)  return(protoTargetCount77);  if(i == 78)  return(protoTargetCount78);  if(i == 79)  return(protoTargetCount79);
	if(i == 80)  return(protoTargetCount80);  if(i == 81)  return(protoTargetCount81);  if(i == 82)  return(protoTargetCount82);  if(i == 83)  return(protoTargetCount83);
	if(i == 84)  return(protoTargetCount84);  if(i == 85)  return(protoTargetCount85);  if(i == 86)  return(protoTargetCount86);  if(i == 87)  return(protoTargetCount87);
	if(i == 88)  return(protoTargetCount88);  if(i == 89)  return(protoTargetCount89);  if(i == 90)  return(protoTargetCount90);  if(i == 91)  return(protoTargetCount91);
	if(i == 92)  return(protoTargetCount92);  if(i == 93)  return(protoTargetCount93);  if(i == 94)  return(protoTargetCount94);  if(i == 95)  return(protoTargetCount95);
	if(i == 96)  return(protoTargetCount96);  if(i == 97)  return(protoTargetCount97);  if(i == 98)  return(protoTargetCount98);  if(i == 99)  return(protoTargetCount99);
	if(i == 100) return(protoTargetCount100); if(i == 101) return(protoTargetCount101); if(i == 102) return(protoTargetCount102); if(i == 103) return(protoTargetCount103);
	if(i == 104) return(protoTargetCount104); if(i == 105) return(protoTargetCount105); if(i == 106) return(protoTargetCount106); if(i == 107) return(protoTargetCount107);
	if(i == 108) return(protoTargetCount108); if(i == 109) return(protoTargetCount109); if(i == 110) return(protoTargetCount110); if(i == 111) return(protoTargetCount111);
	if(i == 112) return(protoTargetCount112); if(i == 113) return(protoTargetCount113); if(i == 114) return(protoTargetCount114); if(i == 115) return(protoTargetCount115);
	if(i == 116) return(protoTargetCount116); if(i == 117) return(protoTargetCount117); if(i == 118) return(protoTargetCount118); if(i == 119) return(protoTargetCount119);
	if(i == 120) return(protoTargetCount120); if(i == 121) return(protoTargetCount121); if(i == 122) return(protoTargetCount122); if(i == 123) return(protoTargetCount123);
	if(i == 124) return(protoTargetCount124); if(i == 125) return(protoTargetCount125); if(i == 126) return(protoTargetCount126); if(i == 127) return(protoTargetCount127);
	if(i == 128) return(protoTargetCount128); if(i == 129) return(protoTargetCount129); if(i == 130) return(protoTargetCount130); if(i == 131) return(protoTargetCount131);
	if(i == 132) return(protoTargetCount132); if(i == 133) return(protoTargetCount133); if(i == 134) return(protoTargetCount134); if(i == 135) return(protoTargetCount135);
	if(i == 136) return(protoTargetCount136); if(i == 137) return(protoTargetCount137); if(i == 138) return(protoTargetCount138); if(i == 139) return(protoTargetCount139);
	if(i == 140) return(protoTargetCount140); if(i == 141) return(protoTargetCount141); if(i == 142) return(protoTargetCount142); if(i == 143) return(protoTargetCount143);
	if(i == 144) return(protoTargetCount144); if(i == 145) return(protoTargetCount145); if(i == 146) return(protoTargetCount146); if(i == 147) return(protoTargetCount147);
	if(i == 148) return(protoTargetCount148); if(i == 149) return(protoTargetCount149); if(i == 150) return(protoTargetCount150); if(i == 151) return(protoTargetCount151);
	if(i == 152) return(protoTargetCount152); if(i == 153) return(protoTargetCount153); if(i == 154) return(protoTargetCount154); if(i == 155) return(protoTargetCount155);
	if(i == 156) return(protoTargetCount156); if(i == 157) return(protoTargetCount157); if(i == 158) return(protoTargetCount158); if(i == 159) return(protoTargetCount159);
	if(i == 160) return(protoTargetCount160); if(i == 161) return(protoTargetCount161); if(i == 162) return(protoTargetCount162); if(i == 163) return(protoTargetCount163);
	if(i == 164) return(protoTargetCount164); if(i == 165) return(protoTargetCount165); if(i == 166) return(protoTargetCount166); if(i == 167) return(protoTargetCount167);
	if(i == 168) return(protoTargetCount168); if(i == 169) return(protoTargetCount169); if(i == 170) return(protoTargetCount170); if(i == 171) return(protoTargetCount171);
	if(i == 172) return(protoTargetCount172); if(i == 173) return(protoTargetCount173); if(i == 174) return(protoTargetCount174); if(i == 175) return(protoTargetCount175);
	if(i == 176) return(protoTargetCount176); if(i == 177) return(protoTargetCount177); if(i == 178) return(protoTargetCount178); if(i == 179) return(protoTargetCount179);
	if(i == 180) return(protoTargetCount180); if(i == 181) return(protoTargetCount181); if(i == 182) return(protoTargetCount182); if(i == 183) return(protoTargetCount183);
	if(i == 184) return(protoTargetCount184); if(i == 185) return(protoTargetCount185); if(i == 186) return(protoTargetCount186); if(i == 187) return(protoTargetCount187);
	if(i == 188) return(protoTargetCount188); if(i == 189) return(protoTargetCount189); if(i == 190) return(protoTargetCount190); if(i == 191) return(protoTargetCount191);
	if(i == 192) return(protoTargetCount192); if(i == 193) return(protoTargetCount193); if(i == 194) return(protoTargetCount194); if(i == 195) return(protoTargetCount195);
	if(i == 196) return(protoTargetCount196); if(i == 197) return(protoTargetCount197); if(i == 198) return(protoTargetCount198); if(i == 199) return(protoTargetCount199);
	if(i == 200) return(protoTargetCount200); if(i == 201) return(protoTargetCount201); if(i == 202) return(protoTargetCount202); if(i == 203) return(protoTargetCount203);
	if(i == 204) return(protoTargetCount204); if(i == 205) return(protoTargetCount205); if(i == 206) return(protoTargetCount206); if(i == 207) return(protoTargetCount207);
	if(i == 208) return(protoTargetCount208); if(i == 209) return(protoTargetCount209); if(i == 210) return(protoTargetCount210); if(i == 211) return(protoTargetCount211);
	if(i == 212) return(protoTargetCount212); if(i == 213) return(protoTargetCount213); if(i == 214) return(protoTargetCount214); if(i == 215) return(protoTargetCount215);
	if(i == 216) return(protoTargetCount216); if(i == 217) return(protoTargetCount217); if(i == 218) return(protoTargetCount218); if(i == 219) return(protoTargetCount219);
	if(i == 220) return(protoTargetCount220); if(i == 221) return(protoTargetCount221); if(i == 222) return(protoTargetCount222); if(i == 223) return(protoTargetCount223);
	if(i == 224) return(protoTargetCount224); if(i == 225) return(protoTargetCount225); if(i == 226) return(protoTargetCount226); if(i == 227) return(protoTargetCount227);
	if(i == 228) return(protoTargetCount228); if(i == 229) return(protoTargetCount229); if(i == 230) return(protoTargetCount230); if(i == 231) return(protoTargetCount231);
	if(i == 232) return(protoTargetCount232); if(i == 233) return(protoTargetCount233); if(i == 234) return(protoTargetCount234); if(i == 235) return(protoTargetCount235);
	if(i == 236) return(protoTargetCount236); if(i == 237) return(protoTargetCount237); if(i == 238) return(protoTargetCount238); if(i == 239) return(protoTargetCount239);
	return(0);
}

void setProtoTargetCount(int i = -1, int n = 0) {
	if(i == 0)   protoTargetCount0   = n; if(i == 1)   protoTargetCount1   = n; if(i == 2)   protoTargetCount2   = n; if(i == 3)   protoTargetCount3   = n;
	if(i == 4)   protoTargetCount4   = n; if(i == 5)   protoTargetCount5   = n; if(i == 6)   protoTargetCount6   = n; if(i == 7)   protoTargetCount7   = n;
	if(i == 8)   protoTargetCount8   = n; if(i == 9)   protoTargetCount9   = n; if(i == 10)  protoTargetCount10  = n; if(i == 11)  protoTargetCount11  = n;
	if(i == 12)  protoTargetCount12  = n; if(i == 13)  protoTargetCount13  = n; if(i == 14)  protoTargetCount14  = n; if(i == 15)  protoTargetCount15  = n;
	if(i == 16)  protoTargetCount16  = n; if(i == 17)  protoTargetCount17  = n; if(i == 18)  protoTargetCount18  = n; if(i == 19)  protoTargetCount19  = n;
	if(i == 20)  protoTargetCount20  = n; if(i == 21)  protoTargetCount21  = n; if(i == 22)  protoTargetCount22  = n; if(i == 23)  protoTargetCount23  = n;
	if(i == 24)  protoTargetCount24  = n; if(i == 25)  protoTargetCount25  = n; if(i == 26)  protoTargetCount26  = n; if(i == 27)  protoTargetCount27  = n;
	if(i == 28)  protoTargetCount28  = n; if(i == 29)  protoTargetCount29  = n; if(i == 30)  protoTargetCount30  = n; if(i == 31)  protoTargetCount31  = n;
	if(i == 32)  protoTargetCount32  = n; if(i == 33)  protoTargetCount33  = n; if(i == 34)  protoTargetCount34  = n; if(i == 35)  protoTargetCount35  = n;
	if(i == 36)  protoTargetCount36  = n; if(i == 37)  protoTargetCount37  = n; if(i == 38)  protoTargetCount38  = n; if(i == 39)  protoTargetCount39  = n;
	if(i == 40)  protoTargetCount40  = n; if(i == 41)  protoTargetCount41  = n; if(i == 42)  protoTargetCount42  = n; if(i == 43)  protoTargetCount43  = n;
	if(i == 44)  protoTargetCount44  = n; if(i == 45)  protoTargetCount45  = n; if(i == 46)  protoTargetCount46  = n; if(i == 47)  protoTargetCount47  = n;
	if(i == 48)  protoTargetCount48  = n; if(i == 49)  protoTargetCount49  = n; if(i == 50)  protoTargetCount50  = n; if(i == 51)  protoTargetCount51  = n;
	if(i == 52)  protoTargetCount52  = n; if(i == 53)  protoTargetCount53  = n; if(i == 54)  protoTargetCount54  = n; if(i == 55)  protoTargetCount55  = n;
	if(i == 56)  protoTargetCount56  = n; if(i == 57)  protoTargetCount57  = n; if(i == 58)  protoTargetCount58  = n; if(i == 59)  protoTargetCount59  = n;
	if(i == 60)  protoTargetCount60  = n; if(i == 61)  protoTargetCount61  = n; if(i == 62)  protoTargetCount62  = n; if(i == 63)  protoTargetCount63  = n;
	if(i == 64)  protoTargetCount64  = n; if(i == 65)  protoTargetCount65  = n; if(i == 66)  protoTargetCount66  = n; if(i == 67)  protoTargetCount67  = n;
	if(i == 68)  protoTargetCount68  = n; if(i == 69)  protoTargetCount69  = n; if(i == 70)  protoTargetCount70  = n; if(i == 71)  protoTargetCount71  = n;
	if(i == 72)  protoTargetCount72  = n; if(i == 73)  protoTargetCount73  = n; if(i == 74)  protoTargetCount74  = n; if(i == 75)  protoTargetCount75  = n;
	if(i == 76)  protoTargetCount76  = n; if(i == 77)  protoTargetCount77  = n; if(i == 78)  protoTargetCount78  = n; if(i == 79)  protoTargetCount79  = n;
	if(i == 80)  protoTargetCount80  = n; if(i == 81)  protoTargetCount81  = n; if(i == 82)  protoTargetCount82  = n; if(i == 83)  protoTargetCount83  = n;
	if(i == 84)  protoTargetCount84  = n; if(i == 85)  protoTargetCount85  = n; if(i == 86)  protoTargetCount86  = n; if(i == 87)  protoTargetCount87  = n;
	if(i == 88)  protoTargetCount88  = n; if(i == 89)  protoTargetCount89  = n; if(i == 90)  protoTargetCount90  = n; if(i == 91)  protoTargetCount91  = n;
	if(i == 92)  protoTargetCount92  = n; if(i == 93)  protoTargetCount93  = n; if(i == 94)  protoTargetCount94  = n; if(i == 95)  protoTargetCount95  = n;
	if(i == 96)  protoTargetCount96  = n; if(i == 97)  protoTargetCount97  = n; if(i == 98)  protoTargetCount98  = n; if(i == 99)  protoTargetCount99  = n;
	if(i == 100) protoTargetCount100 = n; if(i == 101) protoTargetCount101 = n; if(i == 102) protoTargetCount102 = n; if(i == 103) protoTargetCount103 = n;
	if(i == 104) protoTargetCount104 = n; if(i == 105) protoTargetCount105 = n; if(i == 106) protoTargetCount106 = n; if(i == 107) protoTargetCount107 = n;
	if(i == 108) protoTargetCount108 = n; if(i == 109) protoTargetCount109 = n; if(i == 110) protoTargetCount110 = n; if(i == 111) protoTargetCount111 = n;
	if(i == 112) protoTargetCount112 = n; if(i == 113) protoTargetCount113 = n; if(i == 114) protoTargetCount114 = n; if(i == 115) protoTargetCount115 = n;
	if(i == 116) protoTargetCount116 = n; if(i == 117) protoTargetCount117 = n; if(i == 118) protoTargetCount118 = n; if(i == 119) protoTargetCount119 = n;
	if(i == 120) protoTargetCount120 = n; if(i == 121) protoTargetCount121 = n; if(i == 122) protoTargetCount122 = n; if(i == 123) protoTargetCount123 = n;
	if(i == 124) protoTargetCount124 = n; if(i == 125) protoTargetCount125 = n; if(i == 126) protoTargetCount126 = n; if(i == 127) protoTargetCount127 = n;
	if(i == 128) protoTargetCount128 = n; if(i == 129) protoTargetCount129 = n; if(i == 130) protoTargetCount130 = n; if(i == 131) protoTargetCount131 = n;
	if(i == 132) protoTargetCount132 = n; if(i == 133) protoTargetCount133 = n; if(i == 134) protoTargetCount134 = n; if(i == 135) protoTargetCount135 = n;
	if(i == 136) protoTargetCount136 = n; if(i == 137) protoTargetCount137 = n; if(i == 138) protoTargetCount138 = n; if(i == 139) protoTargetCount139 = n;
	if(i == 140) protoTargetCount140 = n; if(i == 141) protoTargetCount141 = n; if(i == 142) protoTargetCount142 = n; if(i == 143) protoTargetCount143 = n;
	if(i == 144) protoTargetCount144 = n; if(i == 145) protoTargetCount145 = n; if(i == 146) protoTargetCount146 = n; if(i == 147) protoTargetCount147 = n;
	if(i == 148) protoTargetCount148 = n; if(i == 149) protoTargetCount149 = n; if(i == 150) protoTargetCount150 = n; if(i == 151) protoTargetCount151 = n;
	if(i == 152) protoTargetCount152 = n; if(i == 153) protoTargetCount153 = n; if(i == 154) protoTargetCount154 = n; if(i == 155) protoTargetCount155 = n;
	if(i == 156) protoTargetCount156 = n; if(i == 157) protoTargetCount157 = n; if(i == 158) protoTargetCount158 = n; if(i == 159) protoTargetCount159 = n;
	if(i == 160) protoTargetCount160 = n; if(i == 161) protoTargetCount161 = n; if(i == 162) protoTargetCount162 = n; if(i == 163) protoTargetCount163 = n;
	if(i == 164) protoTargetCount164 = n; if(i == 165) protoTargetCount165 = n; if(i == 166) protoTargetCount166 = n; if(i == 167) protoTargetCount167 = n;
	if(i == 168) protoTargetCount168 = n; if(i == 169) protoTargetCount169 = n; if(i == 170) protoTargetCount170 = n; if(i == 171) protoTargetCount171 = n;
	if(i == 172) protoTargetCount172 = n; if(i == 173) protoTargetCount173 = n; if(i == 174) protoTargetCount174 = n; if(i == 175) protoTargetCount175 = n;
	if(i == 176) protoTargetCount176 = n; if(i == 177) protoTargetCount177 = n; if(i == 178) protoTargetCount178 = n; if(i == 179) protoTargetCount179 = n;
	if(i == 180) protoTargetCount180 = n; if(i == 181) protoTargetCount181 = n; if(i == 182) protoTargetCount182 = n; if(i == 183) protoTargetCount183 = n;
	if(i == 184) protoTargetCount184 = n; if(i == 185) protoTargetCount185 = n; if(i == 186) protoTargetCount186 = n; if(i == 187) protoTargetCount187 = n;
	if(i == 188) protoTargetCount188 = n; if(i == 189) protoTargetCount189 = n; if(i == 190) protoTargetCount190 = n; if(i == 191) protoTargetCount191 = n;
	if(i == 192) protoTargetCount192 = n; if(i == 193) protoTargetCount193 = n; if(i == 194) protoTargetCount194 = n; if(i == 195) protoTargetCount195 = n;
	if(i == 196) protoTargetCount196 = n; if(i == 197) protoTargetCount197 = n; if(i == 198) protoTargetCount198 = n; if(i == 199) protoTargetCount199 = n;
	if(i == 200) protoTargetCount200 = n; if(i == 201) protoTargetCount201 = n; if(i == 202) protoTargetCount202 = n; if(i == 203) protoTargetCount203 = n;
	if(i == 204) protoTargetCount204 = n; if(i == 205) protoTargetCount205 = n; if(i == 206) protoTargetCount206 = n; if(i == 207) protoTargetCount207 = n;
	if(i == 208) protoTargetCount208 = n; if(i == 209) protoTargetCount209 = n; if(i == 210) protoTargetCount210 = n; if(i == 211) protoTargetCount211 = n;
	if(i == 212) protoTargetCount212 = n; if(i == 213) protoTargetCount213 = n; if(i == 214) protoTargetCount214 = n; if(i == 215) protoTargetCount215 = n;
	if(i == 216) protoTargetCount216 = n; if(i == 217) protoTargetCount217 = n; if(i == 218) protoTargetCount218 = n; if(i == 219) protoTargetCount219 = n;
	if(i == 220) protoTargetCount220 = n; if(i == 221) protoTargetCount221 = n; if(i == 222) protoTargetCount222 = n; if(i == 223) protoTargetCount223 = n;
	if(i == 224) protoTargetCount224 = n; if(i == 225) protoTargetCount225 = n; if(i == 226) protoTargetCount226 = n; if(i == 227) protoTargetCount227 = n;
	if(i == 228) protoTargetCount228 = n; if(i == 229) protoTargetCount229 = n; if(i == 230) protoTargetCount230 = n; if(i == 231) protoTargetCount231 = n;
	if(i == 232) protoTargetCount232 = n; if(i == 233) protoTargetCount233 = n; if(i == 234) protoTargetCount234 = n; if(i == 235) protoTargetCount235 = n;
	if(i == 236) protoTargetCount236 = n; if(i == 237) protoTargetCount237 = n; if(i == 238) protoTargetCount238 = n; if(i == 239) protoTargetCount239 = n;
}

// Contains the owner of the objects (defaults to Mother Nature).
int protoOwner0   = 0; int protoOwner1   = 0; int protoOwner2   = 0; int protoOwner3   = 0;
int protoOwner4   = 0; int protoOwner5   = 0; int protoOwner6   = 0; int protoOwner7   = 0;
int protoOwner8   = 0; int protoOwner9   = 0; int protoOwner10  = 0; int protoOwner11  = 0;
int protoOwner12  = 0; int protoOwner13  = 0; int protoOwner14  = 0; int protoOwner15  = 0;
int protoOwner16  = 0; int protoOwner17  = 0; int protoOwner18  = 0; int protoOwner19  = 0;
int protoOwner20  = 0; int protoOwner21  = 0; int protoOwner22  = 0; int protoOwner23  = 0;
int protoOwner24  = 0; int protoOwner25  = 0; int protoOwner26  = 0; int protoOwner27  = 0;
int protoOwner28  = 0; int protoOwner29  = 0; int protoOwner30  = 0; int protoOwner31  = 0;
int protoOwner32  = 0; int protoOwner33  = 0; int protoOwner34  = 0; int protoOwner35  = 0;
int protoOwner36  = 0; int protoOwner37  = 0; int protoOwner38  = 0; int protoOwner39  = 0;
int protoOwner40  = 0; int protoOwner41  = 0; int protoOwner42  = 0; int protoOwner43  = 0;
int protoOwner44  = 0; int protoOwner45  = 0; int protoOwner46  = 0; int protoOwner47  = 0;
int protoOwner48  = 0; int protoOwner49  = 0; int protoOwner50  = 0; int protoOwner51  = 0;
int protoOwner52  = 0; int protoOwner53  = 0; int protoOwner54  = 0; int protoOwner55  = 0;
int protoOwner56  = 0; int protoOwner57  = 0; int protoOwner58  = 0; int protoOwner59  = 0;
int protoOwner60  = 0; int protoOwner61  = 0; int protoOwner62  = 0; int protoOwner63  = 0;
int protoOwner64  = 0; int protoOwner65  = 0; int protoOwner66  = 0; int protoOwner67  = 0;
int protoOwner68  = 0; int protoOwner69  = 0; int protoOwner70  = 0; int protoOwner71  = 0;
int protoOwner72  = 0; int protoOwner73  = 0; int protoOwner74  = 0; int protoOwner75  = 0;
int protoOwner76  = 0; int protoOwner77  = 0; int protoOwner78  = 0; int protoOwner79  = 0;
int protoOwner80  = 0; int protoOwner81  = 0; int protoOwner82  = 0; int protoOwner83  = 0;
int protoOwner84  = 0; int protoOwner85  = 0; int protoOwner86  = 0; int protoOwner87  = 0;
int protoOwner88  = 0; int protoOwner89  = 0; int protoOwner90  = 0; int protoOwner91  = 0;
int protoOwner92  = 0; int protoOwner93  = 0; int protoOwner94  = 0; int protoOwner95  = 0;
int protoOwner96  = 0; int protoOwner97  = 0; int protoOwner98  = 0; int protoOwner99  = 0;
int protoOwner100 = 0; int protoOwner101 = 0; int protoOwner102 = 0; int protoOwner103 = 0;
int protoOwner104 = 0; int protoOwner105 = 0; int protoOwner106 = 0; int protoOwner107 = 0;
int protoOwner108 = 0; int protoOwner109 = 0; int protoOwner110 = 0; int protoOwner111 = 0;
int protoOwner112 = 0; int protoOwner113 = 0; int protoOwner114 = 0; int protoOwner115 = 0;
int protoOwner116 = 0; int protoOwner117 = 0; int protoOwner118 = 0; int protoOwner119 = 0;
int protoOwner120 = 0; int protoOwner121 = 0; int protoOwner122 = 0; int protoOwner123 = 0;
int protoOwner124 = 0; int protoOwner125 = 0; int protoOwner126 = 0; int protoOwner127 = 0;
int protoOwner128 = 0; int protoOwner129 = 0; int protoOwner130 = 0; int protoOwner131 = 0;
int protoOwner132 = 0; int protoOwner133 = 0; int protoOwner134 = 0; int protoOwner135 = 0;
int protoOwner136 = 0; int protoOwner137 = 0; int protoOwner138 = 0; int protoOwner139 = 0;
int protoOwner140 = 0; int protoOwner141 = 0; int protoOwner142 = 0; int protoOwner143 = 0;
int protoOwner144 = 0; int protoOwner145 = 0; int protoOwner146 = 0; int protoOwner147 = 0;
int protoOwner148 = 0; int protoOwner149 = 0; int protoOwner150 = 0; int protoOwner151 = 0;
int protoOwner152 = 0; int protoOwner153 = 0; int protoOwner154 = 0; int protoOwner155 = 0;
int protoOwner156 = 0; int protoOwner157 = 0; int protoOwner158 = 0; int protoOwner159 = 0;
int protoOwner160 = 0; int protoOwner161 = 0; int protoOwner162 = 0; int protoOwner163 = 0;
int protoOwner164 = 0; int protoOwner165 = 0; int protoOwner166 = 0; int protoOwner167 = 0;
int protoOwner168 = 0; int protoOwner169 = 0; int protoOwner170 = 0; int protoOwner171 = 0;
int protoOwner172 = 0; int protoOwner173 = 0; int protoOwner174 = 0; int protoOwner175 = 0;
int protoOwner176 = 0; int protoOwner177 = 0; int protoOwner178 = 0; int protoOwner179 = 0;
int protoOwner180 = 0; int protoOwner181 = 0; int protoOwner182 = 0; int protoOwner183 = 0;
int protoOwner184 = 0; int protoOwner185 = 0; int protoOwner186 = 0; int protoOwner187 = 0;
int protoOwner188 = 0; int protoOwner189 = 0; int protoOwner190 = 0; int protoOwner191 = 0;
int protoOwner192 = 0; int protoOwner193 = 0; int protoOwner194 = 0; int protoOwner195 = 0;
int protoOwner196 = 0; int protoOwner197 = 0; int protoOwner198 = 0; int protoOwner199 = 0;
int protoOwner200 = 0; int protoOwner201 = 0; int protoOwner202 = 0; int protoOwner203 = 0;
int protoOwner204 = 0; int protoOwner205 = 0; int protoOwner206 = 0; int protoOwner207 = 0;
int protoOwner208 = 0; int protoOwner209 = 0; int protoOwner210 = 0; int protoOwner211 = 0;
int protoOwner212 = 0; int protoOwner213 = 0; int protoOwner214 = 0; int protoOwner215 = 0;
int protoOwner216 = 0; int protoOwner217 = 0; int protoOwner218 = 0; int protoOwner219 = 0;
int protoOwner220 = 0; int protoOwner221 = 0; int protoOwner222 = 0; int protoOwner223 = 0;
int protoOwner224 = 0; int protoOwner225 = 0; int protoOwner226 = 0; int protoOwner227 = 0;
int protoOwner228 = 0; int protoOwner229 = 0; int protoOwner230 = 0; int protoOwner231 = 0;
int protoOwner232 = 0; int protoOwner233 = 0; int protoOwner234 = 0; int protoOwner235 = 0;
int protoOwner236 = 0; int protoOwner237 = 0; int protoOwner238 = 0; int protoOwner239 = 0;

int getProtoOwner(int i = -1) {
	if(i == 0)   return(protoOwner0);   if(i == 1)   return(protoOwner1);   if(i == 2)   return(protoOwner2);   if(i == 3)   return(protoOwner3);
	if(i == 4)   return(protoOwner4);   if(i == 5)   return(protoOwner5);   if(i == 6)   return(protoOwner6);   if(i == 7)   return(protoOwner7);
	if(i == 8)   return(protoOwner8);   if(i == 9)   return(protoOwner9);   if(i == 10)  return(protoOwner10);  if(i == 11)  return(protoOwner11);
	if(i == 12)  return(protoOwner12);  if(i == 13)  return(protoOwner13);  if(i == 14)  return(protoOwner14);  if(i == 15)  return(protoOwner15);
	if(i == 16)  return(protoOwner16);  if(i == 17)  return(protoOwner17);  if(i == 18)  return(protoOwner18);  if(i == 19)  return(protoOwner19);
	if(i == 20)  return(protoOwner20);  if(i == 21)  return(protoOwner21);  if(i == 22)  return(protoOwner22);  if(i == 23)  return(protoOwner23);
	if(i == 24)  return(protoOwner24);  if(i == 25)  return(protoOwner25);  if(i == 26)  return(protoOwner26);  if(i == 27)  return(protoOwner27);
	if(i == 28)  return(protoOwner28);  if(i == 29)  return(protoOwner29);  if(i == 30)  return(protoOwner30);  if(i == 31)  return(protoOwner31);
	if(i == 32)  return(protoOwner32);  if(i == 33)  return(protoOwner33);  if(i == 34)  return(protoOwner34);  if(i == 35)  return(protoOwner35);
	if(i == 36)  return(protoOwner36);  if(i == 37)  return(protoOwner37);  if(i == 38)  return(protoOwner38);  if(i == 39)  return(protoOwner39);
	if(i == 40)  return(protoOwner40);  if(i == 41)  return(protoOwner41);  if(i == 42)  return(protoOwner42);  if(i == 43)  return(protoOwner43);
	if(i == 44)  return(protoOwner44);  if(i == 45)  return(protoOwner45);  if(i == 46)  return(protoOwner46);  if(i == 47)  return(protoOwner47);
	if(i == 48)  return(protoOwner48);  if(i == 49)  return(protoOwner49);  if(i == 50)  return(protoOwner50);  if(i == 51)  return(protoOwner51);
	if(i == 52)  return(protoOwner52);  if(i == 53)  return(protoOwner53);  if(i == 54)  return(protoOwner54);  if(i == 55)  return(protoOwner55);
	if(i == 56)  return(protoOwner56);  if(i == 57)  return(protoOwner57);  if(i == 58)  return(protoOwner58);  if(i == 59)  return(protoOwner59);
	if(i == 60)  return(protoOwner60);  if(i == 61)  return(protoOwner61);  if(i == 62)  return(protoOwner62);  if(i == 63)  return(protoOwner63);
	if(i == 64)  return(protoOwner64);  if(i == 65)  return(protoOwner65);  if(i == 66)  return(protoOwner66);  if(i == 67)  return(protoOwner67);
	if(i == 68)  return(protoOwner68);  if(i == 69)  return(protoOwner69);  if(i == 70)  return(protoOwner70);  if(i == 71)  return(protoOwner71);
	if(i == 72)  return(protoOwner72);  if(i == 73)  return(protoOwner73);  if(i == 74)  return(protoOwner74);  if(i == 75)  return(protoOwner75);
	if(i == 76)  return(protoOwner76);  if(i == 77)  return(protoOwner77);  if(i == 78)  return(protoOwner78);  if(i == 79)  return(protoOwner79);
	if(i == 80)  return(protoOwner80);  if(i == 81)  return(protoOwner81);  if(i == 82)  return(protoOwner82);  if(i == 83)  return(protoOwner83);
	if(i == 84)  return(protoOwner84);  if(i == 85)  return(protoOwner85);  if(i == 86)  return(protoOwner86);  if(i == 87)  return(protoOwner87);
	if(i == 88)  return(protoOwner88);  if(i == 89)  return(protoOwner89);  if(i == 90)  return(protoOwner90);  if(i == 91)  return(protoOwner91);
	if(i == 92)  return(protoOwner92);  if(i == 93)  return(protoOwner93);  if(i == 94)  return(protoOwner94);  if(i == 95)  return(protoOwner95);
	if(i == 96)  return(protoOwner96);  if(i == 97)  return(protoOwner97);  if(i == 98)  return(protoOwner98);  if(i == 99)  return(protoOwner99);
	if(i == 100) return(protoOwner100); if(i == 101) return(protoOwner101); if(i == 102) return(protoOwner102); if(i == 103) return(protoOwner103);
	if(i == 104) return(protoOwner104); if(i == 105) return(protoOwner105); if(i == 106) return(protoOwner106); if(i == 107) return(protoOwner107);
	if(i == 108) return(protoOwner108); if(i == 109) return(protoOwner109); if(i == 110) return(protoOwner110); if(i == 111) return(protoOwner111);
	if(i == 112) return(protoOwner112); if(i == 113) return(protoOwner113); if(i == 114) return(protoOwner114); if(i == 115) return(protoOwner115);
	if(i == 116) return(protoOwner116); if(i == 117) return(protoOwner117); if(i == 118) return(protoOwner118); if(i == 119) return(protoOwner119);
	if(i == 120) return(protoOwner120); if(i == 121) return(protoOwner121); if(i == 122) return(protoOwner122); if(i == 123) return(protoOwner123);
	if(i == 124) return(protoOwner124); if(i == 125) return(protoOwner125); if(i == 126) return(protoOwner126); if(i == 127) return(protoOwner127);
	if(i == 128) return(protoOwner128); if(i == 129) return(protoOwner129); if(i == 130) return(protoOwner130); if(i == 131) return(protoOwner131);
	if(i == 132) return(protoOwner132); if(i == 133) return(protoOwner133); if(i == 134) return(protoOwner134); if(i == 135) return(protoOwner135);
	if(i == 136) return(protoOwner136); if(i == 137) return(protoOwner137); if(i == 138) return(protoOwner138); if(i == 139) return(protoOwner139);
	if(i == 140) return(protoOwner140); if(i == 141) return(protoOwner141); if(i == 142) return(protoOwner142); if(i == 143) return(protoOwner143);
	if(i == 144) return(protoOwner144); if(i == 145) return(protoOwner145); if(i == 146) return(protoOwner146); if(i == 147) return(protoOwner147);
	if(i == 148) return(protoOwner148); if(i == 149) return(protoOwner149); if(i == 150) return(protoOwner150); if(i == 151) return(protoOwner151);
	if(i == 152) return(protoOwner152); if(i == 153) return(protoOwner153); if(i == 154) return(protoOwner154); if(i == 155) return(protoOwner155);
	if(i == 156) return(protoOwner156); if(i == 157) return(protoOwner157); if(i == 158) return(protoOwner158); if(i == 159) return(protoOwner159);
	if(i == 160) return(protoOwner160); if(i == 161) return(protoOwner161); if(i == 162) return(protoOwner162); if(i == 163) return(protoOwner163);
	if(i == 164) return(protoOwner164); if(i == 165) return(protoOwner165); if(i == 166) return(protoOwner166); if(i == 167) return(protoOwner167);
	if(i == 168) return(protoOwner168); if(i == 169) return(protoOwner169); if(i == 170) return(protoOwner170); if(i == 171) return(protoOwner171);
	if(i == 172) return(protoOwner172); if(i == 173) return(protoOwner173); if(i == 174) return(protoOwner174); if(i == 175) return(protoOwner175);
	if(i == 176) return(protoOwner176); if(i == 177) return(protoOwner177); if(i == 178) return(protoOwner178); if(i == 179) return(protoOwner179);
	if(i == 180) return(protoOwner180); if(i == 181) return(protoOwner181); if(i == 182) return(protoOwner182); if(i == 183) return(protoOwner183);
	if(i == 184) return(protoOwner184); if(i == 185) return(protoOwner185); if(i == 186) return(protoOwner186); if(i == 187) return(protoOwner187);
	if(i == 188) return(protoOwner188); if(i == 189) return(protoOwner189); if(i == 190) return(protoOwner190); if(i == 191) return(protoOwner191);
	if(i == 192) return(protoOwner192); if(i == 193) return(protoOwner193); if(i == 194) return(protoOwner194); if(i == 195) return(protoOwner195);
	if(i == 196) return(protoOwner196); if(i == 197) return(protoOwner197); if(i == 198) return(protoOwner198); if(i == 199) return(protoOwner199);
	if(i == 200) return(protoOwner200); if(i == 201) return(protoOwner201); if(i == 202) return(protoOwner202); if(i == 203) return(protoOwner203);
	if(i == 204) return(protoOwner204); if(i == 205) return(protoOwner205); if(i == 206) return(protoOwner206); if(i == 207) return(protoOwner207);
	if(i == 208) return(protoOwner208); if(i == 209) return(protoOwner209); if(i == 210) return(protoOwner210); if(i == 211) return(protoOwner211);
	if(i == 212) return(protoOwner212); if(i == 213) return(protoOwner213); if(i == 214) return(protoOwner214); if(i == 215) return(protoOwner215);
	if(i == 216) return(protoOwner216); if(i == 217) return(protoOwner217); if(i == 218) return(protoOwner218); if(i == 219) return(protoOwner219);
	if(i == 220) return(protoOwner220); if(i == 221) return(protoOwner221); if(i == 222) return(protoOwner222); if(i == 223) return(protoOwner223);
	if(i == 224) return(protoOwner224); if(i == 225) return(protoOwner225); if(i == 226) return(protoOwner226); if(i == 227) return(protoOwner227);
	if(i == 228) return(protoOwner228); if(i == 229) return(protoOwner229); if(i == 230) return(protoOwner230); if(i == 231) return(protoOwner231);
	if(i == 232) return(protoOwner232); if(i == 233) return(protoOwner233); if(i == 234) return(protoOwner234); if(i == 235) return(protoOwner235);
	if(i == 236) return(protoOwner236); if(i == 237) return(protoOwner237); if(i == 238) return(protoOwner238); if(i == 239) return(protoOwner239);
	return(0);
}

void setProtoOwner(int i = -1, int n = 0) {
	if(i == 0)   protoOwner0   = n; if(i == 1)   protoOwner1   = n; if(i == 2)   protoOwner2   = n; if(i == 3)   protoOwner3   = n;
	if(i == 4)   protoOwner4   = n; if(i == 5)   protoOwner5   = n; if(i == 6)   protoOwner6   = n; if(i == 7)   protoOwner7   = n;
	if(i == 8)   protoOwner8   = n; if(i == 9)   protoOwner9   = n; if(i == 10)  protoOwner10  = n; if(i == 11)  protoOwner11  = n;
	if(i == 12)  protoOwner12  = n; if(i == 13)  protoOwner13  = n; if(i == 14)  protoOwner14  = n; if(i == 15)  protoOwner15  = n;
	if(i == 16)  protoOwner16  = n; if(i == 17)  protoOwner17  = n; if(i == 18)  protoOwner18  = n; if(i == 19)  protoOwner19  = n;
	if(i == 20)  protoOwner20  = n; if(i == 21)  protoOwner21  = n; if(i == 22)  protoOwner22  = n; if(i == 23)  protoOwner23  = n;
	if(i == 24)  protoOwner24  = n; if(i == 25)  protoOwner25  = n; if(i == 26)  protoOwner26  = n; if(i == 27)  protoOwner27  = n;
	if(i == 28)  protoOwner28  = n; if(i == 29)  protoOwner29  = n; if(i == 30)  protoOwner30  = n; if(i == 31)  protoOwner31  = n;
	if(i == 32)  protoOwner32  = n; if(i == 33)  protoOwner33  = n; if(i == 34)  protoOwner34  = n; if(i == 35)  protoOwner35  = n;
	if(i == 36)  protoOwner36  = n; if(i == 37)  protoOwner37  = n; if(i == 38)  protoOwner38  = n; if(i == 39)  protoOwner39  = n;
	if(i == 40)  protoOwner40  = n; if(i == 41)  protoOwner41  = n; if(i == 42)  protoOwner42  = n; if(i == 43)  protoOwner43  = n;
	if(i == 44)  protoOwner44  = n; if(i == 45)  protoOwner45  = n; if(i == 46)  protoOwner46  = n; if(i == 47)  protoOwner47  = n;
	if(i == 48)  protoOwner48  = n; if(i == 49)  protoOwner49  = n; if(i == 50)  protoOwner50  = n; if(i == 51)  protoOwner51  = n;
	if(i == 52)  protoOwner52  = n; if(i == 53)  protoOwner53  = n; if(i == 54)  protoOwner54  = n; if(i == 55)  protoOwner55  = n;
	if(i == 56)  protoOwner56  = n; if(i == 57)  protoOwner57  = n; if(i == 58)  protoOwner58  = n; if(i == 59)  protoOwner59  = n;
	if(i == 60)  protoOwner60  = n; if(i == 61)  protoOwner61  = n; if(i == 62)  protoOwner62  = n; if(i == 63)  protoOwner63  = n;
	if(i == 64)  protoOwner64  = n; if(i == 65)  protoOwner65  = n; if(i == 66)  protoOwner66  = n; if(i == 67)  protoOwner67  = n;
	if(i == 68)  protoOwner68  = n; if(i == 69)  protoOwner69  = n; if(i == 70)  protoOwner70  = n; if(i == 71)  protoOwner71  = n;
	if(i == 72)  protoOwner72  = n; if(i == 73)  protoOwner73  = n; if(i == 74)  protoOwner74  = n; if(i == 75)  protoOwner75  = n;
	if(i == 76)  protoOwner76  = n; if(i == 77)  protoOwner77  = n; if(i == 78)  protoOwner78  = n; if(i == 79)  protoOwner79  = n;
	if(i == 80)  protoOwner80  = n; if(i == 81)  protoOwner81  = n; if(i == 82)  protoOwner82  = n; if(i == 83)  protoOwner83  = n;
	if(i == 84)  protoOwner84  = n; if(i == 85)  protoOwner85  = n; if(i == 86)  protoOwner86  = n; if(i == 87)  protoOwner87  = n;
	if(i == 88)  protoOwner88  = n; if(i == 89)  protoOwner89  = n; if(i == 90)  protoOwner90  = n; if(i == 91)  protoOwner91  = n;
	if(i == 92)  protoOwner92  = n; if(i == 93)  protoOwner93  = n; if(i == 94)  protoOwner94  = n; if(i == 95)  protoOwner95  = n;
	if(i == 96)  protoOwner96  = n; if(i == 97)  protoOwner97  = n; if(i == 98)  protoOwner98  = n; if(i == 99)  protoOwner99  = n;
	if(i == 100) protoOwner100 = n; if(i == 101) protoOwner101 = n; if(i == 102) protoOwner102 = n; if(i == 103) protoOwner103 = n;
	if(i == 104) protoOwner104 = n; if(i == 105) protoOwner105 = n; if(i == 106) protoOwner106 = n; if(i == 107) protoOwner107 = n;
	if(i == 108) protoOwner108 = n; if(i == 109) protoOwner109 = n; if(i == 110) protoOwner110 = n; if(i == 111) protoOwner111 = n;
	if(i == 112) protoOwner112 = n; if(i == 113) protoOwner113 = n; if(i == 114) protoOwner114 = n; if(i == 115) protoOwner115 = n;
	if(i == 116) protoOwner116 = n; if(i == 117) protoOwner117 = n; if(i == 118) protoOwner118 = n; if(i == 119) protoOwner119 = n;
	if(i == 120) protoOwner120 = n; if(i == 121) protoOwner121 = n; if(i == 122) protoOwner122 = n; if(i == 123) protoOwner123 = n;
	if(i == 124) protoOwner124 = n; if(i == 125) protoOwner125 = n; if(i == 126) protoOwner126 = n; if(i == 127) protoOwner127 = n;
	if(i == 128) protoOwner128 = n; if(i == 129) protoOwner129 = n; if(i == 130) protoOwner130 = n; if(i == 131) protoOwner131 = n;
	if(i == 132) protoOwner132 = n; if(i == 133) protoOwner133 = n; if(i == 134) protoOwner134 = n; if(i == 135) protoOwner135 = n;
	if(i == 136) protoOwner136 = n; if(i == 137) protoOwner137 = n; if(i == 138) protoOwner138 = n; if(i == 139) protoOwner139 = n;
	if(i == 140) protoOwner140 = n; if(i == 141) protoOwner141 = n; if(i == 142) protoOwner142 = n; if(i == 143) protoOwner143 = n;
	if(i == 144) protoOwner144 = n; if(i == 145) protoOwner145 = n; if(i == 146) protoOwner146 = n; if(i == 147) protoOwner147 = n;
	if(i == 148) protoOwner148 = n; if(i == 149) protoOwner149 = n; if(i == 150) protoOwner150 = n; if(i == 151) protoOwner151 = n;
	if(i == 152) protoOwner152 = n; if(i == 153) protoOwner153 = n; if(i == 154) protoOwner154 = n; if(i == 155) protoOwner155 = n;
	if(i == 156) protoOwner156 = n; if(i == 157) protoOwner157 = n; if(i == 158) protoOwner158 = n; if(i == 159) protoOwner159 = n;
	if(i == 160) protoOwner160 = n; if(i == 161) protoOwner161 = n; if(i == 162) protoOwner162 = n; if(i == 163) protoOwner163 = n;
	if(i == 164) protoOwner164 = n; if(i == 165) protoOwner165 = n; if(i == 166) protoOwner166 = n; if(i == 167) protoOwner167 = n;
	if(i == 168) protoOwner168 = n; if(i == 169) protoOwner169 = n; if(i == 170) protoOwner170 = n; if(i == 171) protoOwner171 = n;
	if(i == 172) protoOwner172 = n; if(i == 173) protoOwner173 = n; if(i == 174) protoOwner174 = n; if(i == 175) protoOwner175 = n;
	if(i == 176) protoOwner176 = n; if(i == 177) protoOwner177 = n; if(i == 178) protoOwner178 = n; if(i == 179) protoOwner179 = n;
	if(i == 180) protoOwner180 = n; if(i == 181) protoOwner181 = n; if(i == 182) protoOwner182 = n; if(i == 183) protoOwner183 = n;
	if(i == 184) protoOwner184 = n; if(i == 185) protoOwner185 = n; if(i == 186) protoOwner186 = n; if(i == 187) protoOwner187 = n;
	if(i == 188) protoOwner188 = n; if(i == 189) protoOwner189 = n; if(i == 190) protoOwner190 = n; if(i == 191) protoOwner191 = n;
	if(i == 192) protoOwner192 = n; if(i == 193) protoOwner193 = n; if(i == 194) protoOwner194 = n; if(i == 195) protoOwner195 = n;
	if(i == 196) protoOwner196 = n; if(i == 197) protoOwner197 = n; if(i == 198) protoOwner198 = n; if(i == 199) protoOwner199 = n;
	if(i == 200) protoOwner200 = n; if(i == 201) protoOwner201 = n; if(i == 202) protoOwner202 = n; if(i == 203) protoOwner203 = n;
	if(i == 204) protoOwner204 = n; if(i == 205) protoOwner205 = n; if(i == 206) protoOwner206 = n; if(i == 207) protoOwner207 = n;
	if(i == 208) protoOwner208 = n; if(i == 209) protoOwner209 = n; if(i == 210) protoOwner210 = n; if(i == 211) protoOwner211 = n;
	if(i == 212) protoOwner212 = n; if(i == 213) protoOwner213 = n; if(i == 214) protoOwner214 = n; if(i == 215) protoOwner215 = n;
	if(i == 216) protoOwner216 = n; if(i == 217) protoOwner217 = n; if(i == 218) protoOwner218 = n; if(i == 219) protoOwner219 = n;
	if(i == 220) protoOwner220 = n; if(i == 221) protoOwner221 = n; if(i == 222) protoOwner222 = n; if(i == 223) protoOwner223 = n;
	if(i == 224) protoOwner224 = n; if(i == 225) protoOwner225 = n; if(i == 226) protoOwner226 = n; if(i == 227) protoOwner227 = n;
	if(i == 228) protoOwner228 = n; if(i == 229) protoOwner229 = n; if(i == 230) protoOwner230 = n; if(i == 231) protoOwner231 = n;
	if(i == 232) protoOwner232 = n; if(i == 233) protoOwner233 = n; if(i == 234) protoOwner234 = n; if(i == 235) protoOwner235 = n;
	if(i == 236) protoOwner236 = n; if(i == 237) protoOwner237 = n; if(i == 238) protoOwner238 = n; if(i == 239) protoOwner239 = n;
}

/*
** Adds a new proto to the check along with the desired count.
**
** @param protoName: the proto name of the object to check
** @param totalCount: the total amount of times the object has to be present on the map
** @param protoOwner: the player number of the owner (unmapped!)
**/
void addProtoPlacementCheck(string protoName = "", int totalCount = 0, int protoOwner = 0) {
	setProtoName(protoCheckCount, protoName);
	setProtoTargetCount(protoCheckCount, totalCount);
	setProtoOwner(protoCheckCount, getPlayer(protoOwner));

	protoCheckCount++;
}

/******************
* PLACEMENT CHECK *
******************/

int objectCheckCount = 0;

// Contains object IDs for objects to check when placed.
int objectID0  = 0; int objectID1  = 0; int objectID2  = 0; int objectID3  = 0;
int objectID4  = 0; int objectID5  = 0; int objectID6  = 0; int objectID7  = 0;
int objectID8  = 0; int objectID9  = 0; int objectID10 = 0; int objectID11 = 0;
int objectID12 = 0; int objectID13 = 0; int objectID14 = 0; int objectID15 = 0;
int objectID16 = 0; int objectID17 = 0; int objectID18 = 0; int objectID19 = 0;
int objectID20 = 0; int objectID21 = 0; int objectID22 = 0; int objectID23 = 0;
int objectID24 = 0; int objectID25 = 0; int objectID26 = 0; int objectID27 = 0;
int objectID28 = 0; int objectID29 = 0; int objectID30 = 0; int objectID31 = 0;
int objectID32 = 0; int objectID33 = 0; int objectID34 = 0; int objectID35 = 0;
int objectID36 = 0; int objectID37 = 0; int objectID38 = 0; int objectID39 = 0;
int objectID40 = 0; int objectID41 = 0; int objectID42 = 0; int objectID43 = 0;
int objectID44 = 0; int objectID45 = 0; int objectID46 = 0; int objectID47 = 0;
int objectID48 = 0; int objectID49 = 0; int objectID50 = 0; int objectID51 = 0;
int objectID52 = 0; int objectID53 = 0; int objectID54 = 0; int objectID55 = 0;
int objectID56 = 0; int objectID57 = 0; int objectID58 = 0; int objectID59 = 0;
int objectID60 = 0; int objectID61 = 0; int objectID62 = 0; int objectID63 = 0;

int getObjectID(int i = -1) {
	if(i == 0)  return(objectID0);  if(i == 1)  return(objectID1);  if(i == 2)  return(objectID2);  if(i == 3)  return(objectID3);
	if(i == 4)  return(objectID4);  if(i == 5)  return(objectID5);  if(i == 6)  return(objectID6);  if(i == 7)  return(objectID7);
	if(i == 8)  return(objectID8);  if(i == 9)  return(objectID9);  if(i == 10) return(objectID10); if(i == 11) return(objectID11);
	if(i == 12) return(objectID12); if(i == 13) return(objectID13); if(i == 14) return(objectID14); if(i == 15) return(objectID15);
	if(i == 16) return(objectID16); if(i == 17) return(objectID17); if(i == 18) return(objectID18); if(i == 19) return(objectID19);
	if(i == 20) return(objectID20); if(i == 21) return(objectID21); if(i == 22) return(objectID22); if(i == 23) return(objectID23);
	if(i == 24) return(objectID24); if(i == 25) return(objectID25); if(i == 26) return(objectID26); if(i == 27) return(objectID27);
	if(i == 28) return(objectID28); if(i == 29) return(objectID29); if(i == 30) return(objectID30); if(i == 31) return(objectID31);
	if(i == 32) return(objectID32); if(i == 33) return(objectID33); if(i == 34) return(objectID34); if(i == 35) return(objectID35);
	if(i == 36) return(objectID36); if(i == 37) return(objectID37); if(i == 38) return(objectID38); if(i == 39) return(objectID39);
	if(i == 40) return(objectID40); if(i == 41) return(objectID41); if(i == 42) return(objectID42); if(i == 43) return(objectID43);
	if(i == 44) return(objectID44); if(i == 45) return(objectID45); if(i == 46) return(objectID46); if(i == 47) return(objectID47);
	if(i == 48) return(objectID48); if(i == 49) return(objectID49); if(i == 50) return(objectID50); if(i == 51) return(objectID51);
	if(i == 52) return(objectID52); if(i == 53) return(objectID53); if(i == 54) return(objectID54); if(i == 55) return(objectID55);
	if(i == 56) return(objectID56); if(i == 57) return(objectID57); if(i == 58) return(objectID58); if(i == 59) return(objectID59);
	if(i == 60) return(objectID60); if(i == 61) return(objectID61); if(i == 62) return(objectID62); if(i == 63) return(objectID63);
	return(-1);
}

void setObjectID(int i = -1, int id = 0) {
	if(i == 0)  objectID0  = id; if(i == 1)  objectID1  = id; if(i == 2)  objectID2  = id; if(i == 3)  objectID3  = id;
	if(i == 4)  objectID4  = id; if(i == 5)  objectID5  = id; if(i == 6)  objectID6  = id; if(i == 7)  objectID7  = id;
	if(i == 8)  objectID8  = id; if(i == 9)  objectID9  = id; if(i == 10) objectID10 = id; if(i == 11) objectID11 = id;
	if(i == 12) objectID12 = id; if(i == 13) objectID13 = id; if(i == 14) objectID14 = id; if(i == 15) objectID15 = id;
	if(i == 16) objectID16 = id; if(i == 17) objectID17 = id; if(i == 18) objectID18 = id; if(i == 19) objectID19 = id;
	if(i == 20) objectID20 = id; if(i == 21) objectID21 = id; if(i == 22) objectID22 = id; if(i == 23) objectID23 = id;
	if(i == 24) objectID24 = id; if(i == 25) objectID25 = id; if(i == 26) objectID26 = id; if(i == 27) objectID27 = id;
	if(i == 28) objectID28 = id; if(i == 29) objectID29 = id; if(i == 30) objectID30 = id; if(i == 31) objectID31 = id;
	if(i == 32) objectID32 = id; if(i == 33) objectID33 = id; if(i == 34) objectID34 = id; if(i == 35) objectID35 = id;
	if(i == 36) objectID36 = id; if(i == 37) objectID37 = id; if(i == 38) objectID38 = id; if(i == 39) objectID39 = id;
	if(i == 40) objectID40 = id; if(i == 41) objectID41 = id; if(i == 42) objectID42 = id; if(i == 43) objectID43 = id;
	if(i == 44) objectID44 = id; if(i == 45) objectID45 = id; if(i == 46) objectID46 = id; if(i == 47) objectID47 = id;
	if(i == 48) objectID48 = id; if(i == 49) objectID49 = id; if(i == 50) objectID50 = id; if(i == 51) objectID51 = id;
	if(i == 52) objectID52 = id; if(i == 53) objectID53 = id; if(i == 54) objectID54 = id; if(i == 55) objectID55 = id;
	if(i == 56) objectID56 = id; if(i == 57) objectID57 = id; if(i == 58) objectID58 = id; if(i == 59) objectID59 = id;
	if(i == 60) objectID60 = id; if(i == 61) objectID61 = id; if(i == 62) objectID62 = id; if(i == 63) objectID63 = id;
}

// Contains the label (given into rmCreateObjectDef()) of the objects.
string objectLabel0  = "?"; string objectLabel1  = "?"; string objectLabel2  = "?"; string objectLabel3  = "?";
string objectLabel4  = "?"; string objectLabel5  = "?"; string objectLabel6  = "?"; string objectLabel7  = "?";
string objectLabel8  = "?"; string objectLabel9  = "?"; string objectLabel10 = "?"; string objectLabel11 = "?";
string objectLabel12 = "?"; string objectLabel13 = "?"; string objectLabel14 = "?"; string objectLabel15 = "?";
string objectLabel16 = "?"; string objectLabel17 = "?"; string objectLabel18 = "?"; string objectLabel19 = "?";
string objectLabel20 = "?"; string objectLabel21 = "?"; string objectLabel22 = "?"; string objectLabel23 = "?";
string objectLabel24 = "?"; string objectLabel25 = "?"; string objectLabel26 = "?"; string objectLabel27 = "?";
string objectLabel28 = "?"; string objectLabel29 = "?"; string objectLabel30 = "?"; string objectLabel31 = "?";
string objectLabel32 = "?"; string objectLabel33 = "?"; string objectLabel34 = "?"; string objectLabel35 = "?";
string objectLabel36 = "?"; string objectLabel37 = "?"; string objectLabel38 = "?"; string objectLabel39 = "?";
string objectLabel40 = "?"; string objectLabel41 = "?"; string objectLabel42 = "?"; string objectLabel43 = "?";
string objectLabel44 = "?"; string objectLabel45 = "?"; string objectLabel46 = "?"; string objectLabel47 = "?";
string objectLabel48 = "?"; string objectLabel49 = "?"; string objectLabel50 = "?"; string objectLabel51 = "?";
string objectLabel52 = "?"; string objectLabel53 = "?"; string objectLabel54 = "?"; string objectLabel55 = "?";
string objectLabel56 = "?"; string objectLabel57 = "?"; string objectLabel58 = "?"; string objectLabel59 = "?";
string objectLabel60 = "?"; string objectLabel61 = "?"; string objectLabel62 = "?"; string objectLabel63 = "?";

string getObjectLabel(int i = -1) {
	if(i == 0)  return(objectLabel0);  if(i == 1)  return(objectLabel1);  if(i == 2)  return(objectLabel2);  if(i == 3)  return(objectLabel3);
	if(i == 4)  return(objectLabel4);  if(i == 5)  return(objectLabel5);  if(i == 6)  return(objectLabel6);  if(i == 7)  return(objectLabel7);
	if(i == 8)  return(objectLabel8);  if(i == 9)  return(objectLabel9);  if(i == 10) return(objectLabel10); if(i == 11) return(objectLabel11);
	if(i == 12) return(objectLabel12); if(i == 13) return(objectLabel13); if(i == 14) return(objectLabel14); if(i == 15) return(objectLabel15);
	if(i == 16) return(objectLabel16); if(i == 17) return(objectLabel17); if(i == 18) return(objectLabel18); if(i == 19) return(objectLabel19);
	if(i == 20) return(objectLabel20); if(i == 21) return(objectLabel21); if(i == 22) return(objectLabel22); if(i == 23) return(objectLabel23);
	if(i == 24) return(objectLabel24); if(i == 25) return(objectLabel25); if(i == 26) return(objectLabel26); if(i == 27) return(objectLabel27);
	if(i == 28) return(objectLabel28); if(i == 29) return(objectLabel29); if(i == 30) return(objectLabel30); if(i == 31) return(objectLabel31);
	if(i == 32) return(objectLabel32); if(i == 33) return(objectLabel33); if(i == 34) return(objectLabel34); if(i == 35) return(objectLabel35);
	if(i == 36) return(objectLabel36); if(i == 37) return(objectLabel37); if(i == 38) return(objectLabel38); if(i == 39) return(objectLabel39);
	if(i == 40) return(objectLabel40); if(i == 41) return(objectLabel41); if(i == 42) return(objectLabel42); if(i == 43) return(objectLabel43);
	if(i == 44) return(objectLabel44); if(i == 45) return(objectLabel45); if(i == 46) return(objectLabel46); if(i == 47) return(objectLabel47);
	if(i == 48) return(objectLabel48); if(i == 49) return(objectLabel49); if(i == 50) return(objectLabel50); if(i == 51) return(objectLabel51);
	if(i == 52) return(objectLabel52); if(i == 53) return(objectLabel53); if(i == 54) return(objectLabel54); if(i == 55) return(objectLabel55);
	if(i == 56) return(objectLabel56); if(i == 57) return(objectLabel57); if(i == 58) return(objectLabel58); if(i == 59) return(objectLabel59);
	if(i == 60) return(objectLabel60); if(i == 61) return(objectLabel61); if(i == 62) return(objectLabel62); if(i == 63) return(objectLabel63);
	return("?");
}

void setObjectLabel(int i = -1, string lab = "") {
	if(i == 0)  objectLabel0  = lab; if(i == 1)  objectLabel1  = lab; if(i == 2)  objectLabel2  = lab; if(i == 3)  objectLabel3  = lab;
	if(i == 4)  objectLabel4  = lab; if(i == 5)  objectLabel5  = lab; if(i == 6)  objectLabel6  = lab; if(i == 7)  objectLabel7  = lab;
	if(i == 8)  objectLabel8  = lab; if(i == 9)  objectLabel9  = lab; if(i == 10) objectLabel10 = lab; if(i == 11) objectLabel11 = lab;
	if(i == 12) objectLabel12 = lab; if(i == 13) objectLabel13 = lab; if(i == 14) objectLabel14 = lab; if(i == 15) objectLabel15 = lab;
	if(i == 16) objectLabel16 = lab; if(i == 17) objectLabel17 = lab; if(i == 18) objectLabel18 = lab; if(i == 19) objectLabel19 = lab;
	if(i == 20) objectLabel20 = lab; if(i == 21) objectLabel21 = lab; if(i == 22) objectLabel22 = lab; if(i == 23) objectLabel23 = lab;
	if(i == 24) objectLabel24 = lab; if(i == 25) objectLabel25 = lab; if(i == 26) objectLabel26 = lab; if(i == 27) objectLabel27 = lab;
	if(i == 28) objectLabel28 = lab; if(i == 29) objectLabel29 = lab; if(i == 30) objectLabel30 = lab; if(i == 31) objectLabel31 = lab;
	if(i == 32) objectLabel32 = lab; if(i == 33) objectLabel33 = lab; if(i == 34) objectLabel34 = lab; if(i == 35) objectLabel35 = lab;
	if(i == 36) objectLabel36 = lab; if(i == 37) objectLabel37 = lab; if(i == 38) objectLabel38 = lab; if(i == 39) objectLabel39 = lab;
	if(i == 40) objectLabel40 = lab; if(i == 41) objectLabel41 = lab; if(i == 42) objectLabel42 = lab; if(i == 43) objectLabel43 = lab;
	if(i == 44) objectLabel44 = lab; if(i == 45) objectLabel45 = lab; if(i == 46) objectLabel46 = lab; if(i == 47) objectLabel47 = lab;
	if(i == 48) objectLabel48 = lab; if(i == 49) objectLabel49 = lab; if(i == 50) objectLabel50 = lab; if(i == 51) objectLabel51 = lab;
	if(i == 52) objectLabel52 = lab; if(i == 53) objectLabel53 = lab; if(i == 54) objectLabel54 = lab; if(i == 55) objectLabel55 = lab;
	if(i == 56) objectLabel56 = lab; if(i == 57) objectLabel57 = lab; if(i == 58) objectLabel58 = lab; if(i == 59) objectLabel59 = lab;
	if(i == 60) objectLabel60 = lab; if(i == 61) objectLabel61 = lab; if(i == 62) objectLabel62 = lab; if(i == 63) objectLabel63 = lab;
}

// Contains the total number of elements in an object (e.g., 6 Gazelles and 2 Deer = 8).
int objectItemCount0  = 0; int objectItemCount1  = 0; int objectItemCount2  = 0; int objectItemCount3  = 0;
int objectItemCount4  = 0; int objectItemCount5  = 0; int objectItemCount6  = 0; int objectItemCount7  = 0;
int objectItemCount8  = 0; int objectItemCount9  = 0; int objectItemCount10 = 0; int objectItemCount11 = 0;
int objectItemCount12 = 0; int objectItemCount13 = 0; int objectItemCount14 = 0; int objectItemCount15 = 0;
int objectItemCount16 = 0; int objectItemCount17 = 0; int objectItemCount18 = 0; int objectItemCount19 = 0;
int objectItemCount20 = 0; int objectItemCount21 = 0; int objectItemCount22 = 0; int objectItemCount23 = 0;
int objectItemCount24 = 0; int objectItemCount25 = 0; int objectItemCount26 = 0; int objectItemCount27 = 0;
int objectItemCount28 = 0; int objectItemCount29 = 0; int objectItemCount30 = 0; int objectItemCount31 = 0;
int objectItemCount32 = 0; int objectItemCount33 = 0; int objectItemCount34 = 0; int objectItemCount35 = 0;
int objectItemCount36 = 0; int objectItemCount37 = 0; int objectItemCount38 = 0; int objectItemCount39 = 0;
int objectItemCount40 = 0; int objectItemCount41 = 0; int objectItemCount42 = 0; int objectItemCount43 = 0;
int objectItemCount44 = 0; int objectItemCount45 = 0; int objectItemCount46 = 0; int objectItemCount47 = 0;
int objectItemCount48 = 0; int objectItemCount49 = 0; int objectItemCount50 = 0; int objectItemCount51 = 0;
int objectItemCount52 = 0; int objectItemCount53 = 0; int objectItemCount54 = 0; int objectItemCount55 = 0;
int objectItemCount56 = 0; int objectItemCount57 = 0; int objectItemCount58 = 0; int objectItemCount59 = 0;
int objectItemCount60 = 0; int objectItemCount61 = 0; int objectItemCount62 = 0; int objectItemCount63 = 0;

int getObjectItemCount(int i = -1) {
	if(i == 0)  return(objectItemCount0);  if(i == 1)  return(objectItemCount1);  if(i == 2)  return(objectItemCount2);  if(i == 3)  return(objectItemCount3);
	if(i == 4)  return(objectItemCount4);  if(i == 5)  return(objectItemCount5);  if(i == 6)  return(objectItemCount6);  if(i == 7)  return(objectItemCount7);
	if(i == 8)  return(objectItemCount8);  if(i == 9)  return(objectItemCount9);  if(i == 10) return(objectItemCount10); if(i == 11) return(objectItemCount11);
	if(i == 12) return(objectItemCount12); if(i == 13) return(objectItemCount13); if(i == 14) return(objectItemCount14); if(i == 15) return(objectItemCount15);
	if(i == 16) return(objectItemCount16); if(i == 17) return(objectItemCount17); if(i == 18) return(objectItemCount18); if(i == 19) return(objectItemCount19);
	if(i == 20) return(objectItemCount20); if(i == 21) return(objectItemCount21); if(i == 22) return(objectItemCount22); if(i == 23) return(objectItemCount23);
	if(i == 24) return(objectItemCount24); if(i == 25) return(objectItemCount25); if(i == 26) return(objectItemCount26); if(i == 27) return(objectItemCount27);
	if(i == 28) return(objectItemCount28); if(i == 29) return(objectItemCount29); if(i == 30) return(objectItemCount30); if(i == 31) return(objectItemCount31);
	if(i == 32) return(objectItemCount32); if(i == 33) return(objectItemCount33); if(i == 34) return(objectItemCount34); if(i == 35) return(objectItemCount35);
	if(i == 36) return(objectItemCount36); if(i == 37) return(objectItemCount37); if(i == 38) return(objectItemCount38); if(i == 39) return(objectItemCount39);
	if(i == 40) return(objectItemCount40); if(i == 41) return(objectItemCount41); if(i == 42) return(objectItemCount42); if(i == 43) return(objectItemCount43);
	if(i == 44) return(objectItemCount44); if(i == 45) return(objectItemCount45); if(i == 46) return(objectItemCount46); if(i == 47) return(objectItemCount47);
	if(i == 48) return(objectItemCount48); if(i == 49) return(objectItemCount49); if(i == 50) return(objectItemCount50); if(i == 51) return(objectItemCount51);
	if(i == 52) return(objectItemCount52); if(i == 53) return(objectItemCount53); if(i == 54) return(objectItemCount54); if(i == 55) return(objectItemCount55);
	if(i == 56) return(objectItemCount56); if(i == 57) return(objectItemCount57); if(i == 58) return(objectItemCount58); if(i == 59) return(objectItemCount59);
	if(i == 60) return(objectItemCount60); if(i == 61) return(objectItemCount61); if(i == 62) return(objectItemCount62); if(i == 63) return(objectItemCount63);
	return(0);
}

void setObjectItemCount(int i = -1, int count = 0) {
	if(i == 0)  objectItemCount0  = count; if(i == 1)  objectItemCount1  = count; if(i == 2)  objectItemCount2  = count; if(i == 3)  objectItemCount3  = count;
	if(i == 4)  objectItemCount4  = count; if(i == 5)  objectItemCount5  = count; if(i == 6)  objectItemCount6  = count; if(i == 7)  objectItemCount7  = count;
	if(i == 8)  objectItemCount8  = count; if(i == 9)  objectItemCount9  = count; if(i == 10) objectItemCount10 = count; if(i == 11) objectItemCount11 = count;
	if(i == 12) objectItemCount12 = count; if(i == 13) objectItemCount13 = count; if(i == 14) objectItemCount14 = count; if(i == 15) objectItemCount15 = count;
	if(i == 16) objectItemCount16 = count; if(i == 17) objectItemCount17 = count; if(i == 18) objectItemCount18 = count; if(i == 19) objectItemCount19 = count;
	if(i == 20) objectItemCount20 = count; if(i == 21) objectItemCount21 = count; if(i == 22) objectItemCount22 = count; if(i == 23) objectItemCount23 = count;
	if(i == 24) objectItemCount24 = count; if(i == 25) objectItemCount25 = count; if(i == 26) objectItemCount26 = count; if(i == 27) objectItemCount27 = count;
	if(i == 28) objectItemCount28 = count; if(i == 29) objectItemCount29 = count; if(i == 30) objectItemCount30 = count; if(i == 31) objectItemCount31 = count;
	if(i == 32) objectItemCount32 = count; if(i == 33) objectItemCount33 = count; if(i == 34) objectItemCount34 = count; if(i == 35) objectItemCount35 = count;
	if(i == 36) objectItemCount36 = count; if(i == 37) objectItemCount37 = count; if(i == 38) objectItemCount38 = count; if(i == 39) objectItemCount39 = count;
	if(i == 40) objectItemCount40 = count; if(i == 41) objectItemCount41 = count; if(i == 42) objectItemCount42 = count; if(i == 43) objectItemCount43 = count;
	if(i == 44) objectItemCount44 = count; if(i == 45) objectItemCount45 = count; if(i == 46) objectItemCount46 = count; if(i == 47) objectItemCount47 = count;
	if(i == 48) objectItemCount48 = count; if(i == 49) objectItemCount49 = count; if(i == 50) objectItemCount50 = count; if(i == 51) objectItemCount51 = count;
	if(i == 52) objectItemCount52 = count; if(i == 53) objectItemCount53 = count; if(i == 54) objectItemCount54 = count; if(i == 55) objectItemCount55 = count;
	if(i == 56) objectItemCount56 = count; if(i == 57) objectItemCount57 = count; if(i == 58) objectItemCount58 = count; if(i == 59) objectItemCount59 = count;
	if(i == 60) objectItemCount60 = count; if(i == 61) objectItemCount61 = count; if(i == 62) objectItemCount62 = count; if(i == 63) objectItemCount63 = count;
}

// Counts how many times the object should have been placed (targeted).
int objectTargetPlaced0  = 0; int objectTargetPlaced1  = 0; int objectTargetPlaced2  = 0; int objectTargetPlaced3  = 0;
int objectTargetPlaced4  = 0; int objectTargetPlaced5  = 0; int objectTargetPlaced6  = 0; int objectTargetPlaced7  = 0;
int objectTargetPlaced8  = 0; int objectTargetPlaced9  = 0; int objectTargetPlaced10 = 0; int objectTargetPlaced11 = 0;
int objectTargetPlaced12 = 0; int objectTargetPlaced13 = 0; int objectTargetPlaced14 = 0; int objectTargetPlaced15 = 0;
int objectTargetPlaced16 = 0; int objectTargetPlaced17 = 0; int objectTargetPlaced18 = 0; int objectTargetPlaced19 = 0;
int objectTargetPlaced20 = 0; int objectTargetPlaced21 = 0; int objectTargetPlaced22 = 0; int objectTargetPlaced23 = 0;
int objectTargetPlaced24 = 0; int objectTargetPlaced25 = 0; int objectTargetPlaced26 = 0; int objectTargetPlaced27 = 0;
int objectTargetPlaced28 = 0; int objectTargetPlaced29 = 0; int objectTargetPlaced30 = 0; int objectTargetPlaced31 = 0;
int objectTargetPlaced32 = 0; int objectTargetPlaced33 = 0; int objectTargetPlaced34 = 0; int objectTargetPlaced35 = 0;
int objectTargetPlaced36 = 0; int objectTargetPlaced37 = 0; int objectTargetPlaced38 = 0; int objectTargetPlaced39 = 0;
int objectTargetPlaced40 = 0; int objectTargetPlaced41 = 0; int objectTargetPlaced42 = 0; int objectTargetPlaced43 = 0;
int objectTargetPlaced44 = 0; int objectTargetPlaced45 = 0; int objectTargetPlaced46 = 0; int objectTargetPlaced47 = 0;
int objectTargetPlaced48 = 0; int objectTargetPlaced49 = 0; int objectTargetPlaced50 = 0; int objectTargetPlaced51 = 0;
int objectTargetPlaced52 = 0; int objectTargetPlaced53 = 0; int objectTargetPlaced54 = 0; int objectTargetPlaced55 = 0;
int objectTargetPlaced56 = 0; int objectTargetPlaced57 = 0; int objectTargetPlaced58 = 0; int objectTargetPlaced59 = 0;
int objectTargetPlaced60 = 0; int objectTargetPlaced61 = 0; int objectTargetPlaced62 = 0; int objectTargetPlaced63 = 0;

int getObjectTargetPlaced(int i = -1) {
	if(i == 0)  return(objectTargetPlaced0);  if(i == 1)  return(objectTargetPlaced1);  if(i == 2)  return(objectTargetPlaced2);  if(i == 3)  return(objectTargetPlaced3);
	if(i == 4)  return(objectTargetPlaced4);  if(i == 5)  return(objectTargetPlaced5);  if(i == 6)  return(objectTargetPlaced6);  if(i == 7)  return(objectTargetPlaced7);
	if(i == 8)  return(objectTargetPlaced8);  if(i == 9)  return(objectTargetPlaced9);  if(i == 10) return(objectTargetPlaced10); if(i == 11) return(objectTargetPlaced11);
	if(i == 12) return(objectTargetPlaced12); if(i == 13) return(objectTargetPlaced13); if(i == 14) return(objectTargetPlaced14); if(i == 15) return(objectTargetPlaced15);
	if(i == 16) return(objectTargetPlaced16); if(i == 17) return(objectTargetPlaced17); if(i == 18) return(objectTargetPlaced18); if(i == 19) return(objectTargetPlaced19);
	if(i == 20) return(objectTargetPlaced20); if(i == 21) return(objectTargetPlaced21); if(i == 22) return(objectTargetPlaced22); if(i == 23) return(objectTargetPlaced23);
	if(i == 24) return(objectTargetPlaced24); if(i == 25) return(objectTargetPlaced25); if(i == 26) return(objectTargetPlaced26); if(i == 27) return(objectTargetPlaced27);
	if(i == 28) return(objectTargetPlaced28); if(i == 29) return(objectTargetPlaced29); if(i == 30) return(objectTargetPlaced30); if(i == 31) return(objectTargetPlaced31);
	if(i == 32) return(objectTargetPlaced32); if(i == 33) return(objectTargetPlaced33); if(i == 34) return(objectTargetPlaced34); if(i == 35) return(objectTargetPlaced35);
	if(i == 36) return(objectTargetPlaced36); if(i == 37) return(objectTargetPlaced37); if(i == 38) return(objectTargetPlaced38); if(i == 39) return(objectTargetPlaced39);
	if(i == 40) return(objectTargetPlaced40); if(i == 41) return(objectTargetPlaced41); if(i == 42) return(objectTargetPlaced42); if(i == 43) return(objectTargetPlaced43);
	if(i == 44) return(objectTargetPlaced44); if(i == 45) return(objectTargetPlaced45); if(i == 46) return(objectTargetPlaced46); if(i == 47) return(objectTargetPlaced47);
	if(i == 48) return(objectTargetPlaced48); if(i == 49) return(objectTargetPlaced49); if(i == 50) return(objectTargetPlaced50); if(i == 51) return(objectTargetPlaced51);
	if(i == 52) return(objectTargetPlaced52); if(i == 53) return(objectTargetPlaced53); if(i == 54) return(objectTargetPlaced54); if(i == 55) return(objectTargetPlaced55);
	if(i == 56) return(objectTargetPlaced56); if(i == 57) return(objectTargetPlaced57); if(i == 58) return(objectTargetPlaced58); if(i == 59) return(objectTargetPlaced59);
	if(i == 60) return(objectTargetPlaced60); if(i == 61) return(objectTargetPlaced61); if(i == 62) return(objectTargetPlaced62); if(i == 63) return(objectTargetPlaced63);
	return(0);
}

void setObjectTargetPlaced(int i = -1, int num = 0) {
	if(i == 0)  objectTargetPlaced0  = num; if(i == 1)  objectTargetPlaced1  = num; if(i == 2)  objectTargetPlaced2  = num; if(i == 3)  objectTargetPlaced3  = num;
	if(i == 4)  objectTargetPlaced4  = num; if(i == 5)  objectTargetPlaced5  = num; if(i == 6)  objectTargetPlaced6  = num; if(i == 7)  objectTargetPlaced7  = num;
	if(i == 8)  objectTargetPlaced8  = num; if(i == 9)  objectTargetPlaced9  = num; if(i == 10) objectTargetPlaced10 = num; if(i == 11) objectTargetPlaced11 = num;
	if(i == 12) objectTargetPlaced12 = num; if(i == 13) objectTargetPlaced13 = num; if(i == 14) objectTargetPlaced14 = num; if(i == 15) objectTargetPlaced15 = num;
	if(i == 16) objectTargetPlaced16 = num; if(i == 17) objectTargetPlaced17 = num; if(i == 18) objectTargetPlaced18 = num; if(i == 19) objectTargetPlaced19 = num;
	if(i == 20) objectTargetPlaced20 = num; if(i == 21) objectTargetPlaced21 = num; if(i == 22) objectTargetPlaced22 = num; if(i == 23) objectTargetPlaced23 = num;
	if(i == 24) objectTargetPlaced24 = num; if(i == 25) objectTargetPlaced25 = num; if(i == 26) objectTargetPlaced26 = num; if(i == 27) objectTargetPlaced27 = num;
	if(i == 28) objectTargetPlaced28 = num; if(i == 29) objectTargetPlaced29 = num; if(i == 30) objectTargetPlaced30 = num; if(i == 31) objectTargetPlaced31 = num;
	if(i == 32) objectTargetPlaced32 = num; if(i == 33) objectTargetPlaced33 = num; if(i == 34) objectTargetPlaced34 = num; if(i == 35) objectTargetPlaced35 = num;
	if(i == 36) objectTargetPlaced36 = num; if(i == 37) objectTargetPlaced37 = num; if(i == 38) objectTargetPlaced38 = num; if(i == 39) objectTargetPlaced39 = num;
	if(i == 40) objectTargetPlaced40 = num; if(i == 41) objectTargetPlaced41 = num; if(i == 42) objectTargetPlaced42 = num; if(i == 43) objectTargetPlaced43 = num;
	if(i == 44) objectTargetPlaced44 = num; if(i == 45) objectTargetPlaced45 = num; if(i == 46) objectTargetPlaced46 = num; if(i == 47) objectTargetPlaced47 = num;
	if(i == 48) objectTargetPlaced48 = num; if(i == 49) objectTargetPlaced49 = num; if(i == 50) objectTargetPlaced50 = num; if(i == 51) objectTargetPlaced51 = num;
	if(i == 52) objectTargetPlaced52 = num; if(i == 53) objectTargetPlaced53 = num; if(i == 54) objectTargetPlaced54 = num; if(i == 55) objectTargetPlaced55 = num;
	if(i == 56) objectTargetPlaced56 = num; if(i == 57) objectTargetPlaced57 = num; if(i == 58) objectTargetPlaced58 = num; if(i == 59) objectTargetPlaced59 = num;
	if(i == 60) objectTargetPlaced60 = num; if(i == 61) objectTargetPlaced61 = num; if(i == 62) objectTargetPlaced62 = num; if(i == 63) objectTargetPlaced63 = num;
}

/*
** Looks up the index of a given object ID in the object array.
**
** @param objID: the ID of the object to look up in the array
**
** @returns: the index of the object ID
*/
int getIndexForObjectID(int objID = -1) {
	for(i = 0; < objectCheckCount) {
		if(getObjectID(i) == objID) {
			return(i);
		}
	}

	return(-1);
}

/*
** Adds a value to the item count of an object.
** The reason we do this is because rmGetNumberUnitsPlaced() returns the total number of "elements" of an object.
** For instance, an object consisting of 2 Gazelles and 3 Zebras has a count of 5.
**
** @param objID: the ID of the object
** @param count: the number to add to the element count of an object
*/
void addToObjectItemCount(int objID = -1, int count = 0) {
	int id = getIndexForObjectID(objID);

	if(id > -1) {
		// Entry found, increment existing.
		setObjectItemCount(id, getObjectItemCount(id) + count);
	}
}

/*
** Creates a new check from a previously created/existing ID.
**
** @param objLabel: the label of the object; should be meaningful
** @param objID: the ID of the object
*/
void registerObjectDefVerifyFromID(string objLabel = "", int objID = -1) {
	setObjectID(objectCheckCount, objID);
	setObjectLabel(objectCheckCount, objLabel);

	objectCheckCount++;
}

/*
** Creates a new object definiton and adds it to the objects array.
**
** @param objLabel: the label of the object; should be meaningful
** @param playerCheck: convenience parameter to disable this function under certain circumstances
**
** @returns: the ID of the definition created.
*/
int createObjectDefVerify(string objLabel = "", bool playerCheck = true) {
	int objID = rmCreateObjectDef(objLabel);

	// If the check was false, return directly.
	if(playerCheck == false) {
		return(objID);
	}

	registerObjectDefVerifyFromID(objLabel, objID);

	return(objID);
}

/*
** Adds an object definition and records it for tracking to later on determine if the object was successfully placed.
**
** @param objID: the ID of the object
** @param proto: the proto name of the object to be placed (e.g., "Gazelle")
** @param num: the number of times the proto item should be placed
** @param dist: the distance the objects can be apart from each other
*/
void addObjectDefItemVerify(int objID = -1, string proto = "", int num = 0, float dist = 0.0) {
	addToObjectItemCount(objID, num);

	rmAddObjectDefItem(objID, proto, num, dist);
}

/*
** Updates the placement count of an object. This adds to the number of times and object SHOULD have been placed.
** Used to later calculate whether all objects were successfully placed.
**
** @param objID: the ID of the object to be updated
** @param num: the number of times the object should have been placed (will be added, not overwritten)
*/
void updateObjectTargetPlaced(int objID = -1, int num = 0) {
	int idx = getIndexForObjectID(objID);

	if(idx == -1) {
		return;
	}

	setObjectTargetPlaced(idx, getObjectTargetPlaced(idx) + num);
}

/*
** Checks if all items of an object with a given ID were placed (at the time of the call).
**
** @param objID: the ID of the object
*/
void adjustPlaced(int objID = -1) {
	int i = getIndexForObjectID(objID);

	// Adjust goal.
	setObjectTargetPlaced(i, rmGetNumberUnitsPlaced(getObjectID(i)) / getObjectItemCount(i));
}

/*
** Checks if all items of an object with a given ID were placed (at the time of the call).
**
** @param objID: the ID of the object
**
** @returns: true if all placements for object objID were successful, false otherwise
*/
bool allObjectsPlaced(int objID = -1) {
	int i = getIndexForObjectID(objID);

	return(getObjectTargetPlaced(i) <= rmGetNumberUnitsPlaced(getObjectID(i)) / getObjectItemCount(i));
}

/***************
* CUSTOM CHECK *
***************/

// Remember to iterate from 0 < customCheckCount because indices start with 0 here.
int customCheckCount = 0;

// Allows the user to add manual checks that failed with any label.
string checkLabel0  = "?"; string checkLabel1  = "?"; string checkLabel2  = "?"; string checkLabel3  = "?";
string checkLabel4  = "?"; string checkLabel5  = "?"; string checkLabel6  = "?"; string checkLabel7  = "?";
string checkLabel8  = "?"; string checkLabel9  = "?"; string checkLabel10 = "?"; string checkLabel11 = "?";
string checkLabel12 = "?"; string checkLabel13 = "?"; string checkLabel14 = "?"; string checkLabel15 = "?";
string checkLabel16 = "?"; string checkLabel17 = "?"; string checkLabel18 = "?"; string checkLabel19 = "?";
string checkLabel20 = "?"; string checkLabel21 = "?"; string checkLabel22 = "?"; string checkLabel23 = "?";
string checkLabel24 = "?"; string checkLabel25 = "?"; string checkLabel26 = "?"; string checkLabel27 = "?";
string checkLabel28 = "?"; string checkLabel29 = "?"; string checkLabel30 = "?"; string checkLabel31 = "?";

string getCheckLabel(int i = -1) {
	if(i == 0)  return(checkLabel0);  if(i == 1)  return(checkLabel1);  if(i == 2)  return(checkLabel2);  if(i == 3)  return(checkLabel3);
	if(i == 4)  return(checkLabel4);  if(i == 5)  return(checkLabel5);  if(i == 6)  return(checkLabel6);  if(i == 7)  return(checkLabel7);
	if(i == 8)  return(checkLabel8);  if(i == 9)  return(checkLabel9);  if(i == 10) return(checkLabel10); if(i == 11) return(checkLabel11);
	if(i == 12) return(checkLabel12); if(i == 13) return(checkLabel13); if(i == 14) return(checkLabel14); if(i == 15) return(checkLabel15);
	if(i == 16) return(checkLabel16); if(i == 17) return(checkLabel17); if(i == 18) return(checkLabel18); if(i == 19) return(checkLabel19);
	if(i == 20) return(checkLabel20); if(i == 21) return(checkLabel21); if(i == 22) return(checkLabel22); if(i == 23) return(checkLabel23);
	if(i == 24) return(checkLabel24); if(i == 25) return(checkLabel25); if(i == 26) return(checkLabel26); if(i == 27) return(checkLabel27);
	if(i == 28) return(checkLabel28); if(i == 29) return(checkLabel29); if(i == 30) return(checkLabel30); if(i == 31) return(checkLabel31);
	return("?");
}

void setCheckLabel(int i = -1, string lab = "") {
	if(i == 0)  checkLabel0  = lab; if(i == 1)  checkLabel1  = lab; if(i == 2)  checkLabel2  = lab; if(i == 3)  checkLabel3  = lab;
	if(i == 4)  checkLabel4  = lab; if(i == 5)  checkLabel5  = lab; if(i == 6)  checkLabel6  = lab; if(i == 7)  checkLabel7  = lab;
	if(i == 8)  checkLabel8  = lab; if(i == 9)  checkLabel9  = lab; if(i == 10) checkLabel10 = lab; if(i == 11) checkLabel11 = lab;
	if(i == 12) checkLabel12 = lab; if(i == 13) checkLabel13 = lab; if(i == 14) checkLabel14 = lab; if(i == 15) checkLabel15 = lab;
	if(i == 16) checkLabel16 = lab; if(i == 17) checkLabel17 = lab; if(i == 18) checkLabel18 = lab; if(i == 19) checkLabel19 = lab;
	if(i == 20) checkLabel20 = lab; if(i == 21) checkLabel21 = lab; if(i == 22) checkLabel22 = lab; if(i == 23) checkLabel23 = lab;
	if(i == 24) checkLabel24 = lab; if(i == 25) checkLabel25 = lab; if(i == 26) checkLabel26 = lab; if(i == 27) checkLabel27 = lab;
	if(i == 28) checkLabel28 = lab; if(i == 29) checkLabel29 = lab; if(i == 30) checkLabel30 = lab; if(i == 31) checkLabel31 = lab;
}

bool checkCrucial0  = false; bool checkCrucial1  = false; bool checkCrucial2  = false; bool checkCrucial3  = false;
bool checkCrucial4  = false; bool checkCrucial5  = false; bool checkCrucial6  = false; bool checkCrucial7  = false;
bool checkCrucial8  = false; bool checkCrucial9  = false; bool checkCrucial10 = false; bool checkCrucial11 = false;
bool checkCrucial12 = false; bool checkCrucial13 = false; bool checkCrucial14 = false; bool checkCrucial15 = false;
bool checkCrucial16 = false; bool checkCrucial17 = false; bool checkCrucial18 = false; bool checkCrucial19 = false;
bool checkCrucial20 = false; bool checkCrucial21 = false; bool checkCrucial22 = false; bool checkCrucial23 = false;
bool checkCrucial24 = false; bool checkCrucial25 = false; bool checkCrucial26 = false; bool checkCrucial27 = false;
bool checkCrucial28 = false; bool checkCrucial29 = false; bool checkCrucial30 = false; bool checkCrucial31 = false;

bool getCheckCrucial(int i = -1) {
	if(i == 0)  return(checkCrucial0);  if(i == 1)  return(checkCrucial1);  if(i == 2)  return(checkCrucial2);  if(i == 3)  return(checkCrucial3);
	if(i == 4)  return(checkCrucial4);  if(i == 5)  return(checkCrucial5);  if(i == 6)  return(checkCrucial6);  if(i == 7)  return(checkCrucial7);
	if(i == 8)  return(checkCrucial8);  if(i == 9)  return(checkCrucial9);  if(i == 10) return(checkCrucial10); if(i == 11) return(checkCrucial11);
	if(i == 12) return(checkCrucial12); if(i == 13) return(checkCrucial13); if(i == 14) return(checkCrucial14); if(i == 15) return(checkCrucial15);
	if(i == 16) return(checkCrucial16); if(i == 17) return(checkCrucial17); if(i == 18) return(checkCrucial18); if(i == 19) return(checkCrucial19);
	if(i == 20) return(checkCrucial20); if(i == 21) return(checkCrucial21); if(i == 22) return(checkCrucial22); if(i == 23) return(checkCrucial23);
	if(i == 24) return(checkCrucial24); if(i == 25) return(checkCrucial25); if(i == 26) return(checkCrucial26); if(i == 27) return(checkCrucial27);
	if(i == 28) return(checkCrucial28); if(i == 29) return(checkCrucial29); if(i == 30) return(checkCrucial30); if(i == 31) return(checkCrucial31);
	return(false);
}

void setCheckCrucial(int i = -1, bool crucial = false) {
	if(i == 0)  checkCrucial0  = crucial; if(i == 1)  checkCrucial1  = crucial; if(i == 2)  checkCrucial2  = crucial; if(i == 3)  checkCrucial3  = crucial;
	if(i == 4)  checkCrucial4  = crucial; if(i == 5)  checkCrucial5  = crucial; if(i == 6)  checkCrucial6  = crucial; if(i == 7)  checkCrucial7  = crucial;
	if(i == 8)  checkCrucial8  = crucial; if(i == 9)  checkCrucial9  = crucial; if(i == 10) checkCrucial10 = crucial; if(i == 11) checkCrucial11 = crucial;
	if(i == 12) checkCrucial12 = crucial; if(i == 13) checkCrucial13 = crucial; if(i == 14) checkCrucial14 = crucial; if(i == 15) checkCrucial15 = crucial;
	if(i == 16) checkCrucial16 = crucial; if(i == 17) checkCrucial17 = crucial; if(i == 18) checkCrucial18 = crucial; if(i == 19) checkCrucial19 = crucial;
	if(i == 20) checkCrucial20 = crucial; if(i == 21) checkCrucial21 = crucial; if(i == 22) checkCrucial22 = crucial; if(i == 23) checkCrucial23 = crucial;
	if(i == 24) checkCrucial24 = crucial; if(i == 25) checkCrucial25 = crucial; if(i == 26) checkCrucial26 = crucial; if(i == 27) checkCrucial27 = crucial;
	if(i == 28) checkCrucial28 = crucial; if(i == 29) checkCrucial29 = crucial; if(i == 30) checkCrucial30 = crucial; if(i == 31) checkCrucial31 = crucial;
}

// Actually a bool despite the name, consider refactoring if it turns out to be too confusing.
bool checkState0  = true; bool checkState1  = true; bool checkState2  = true; bool checkState3  = true;
bool checkState4  = true; bool checkState5  = true; bool checkState6  = true; bool checkState7  = true;
bool checkState8  = true; bool checkState9  = true; bool checkState10 = true; bool checkState11 = true;
bool checkState12 = true; bool checkState13 = true; bool checkState14 = true; bool checkState15 = true;
bool checkState16 = true; bool checkState17 = true; bool checkState18 = true; bool checkState19 = true;
bool checkState20 = true; bool checkState21 = true; bool checkState22 = true; bool checkState23 = true;
bool checkState24 = true; bool checkState25 = true; bool checkState26 = true; bool checkState27 = true;
bool checkState28 = true; bool checkState29 = true; bool checkState30 = true; bool checkState31 = true;

bool getCheckState(int i = -1) {
	if(i == 0)  return(checkState0);  if(i == 1)  return(checkState1);  if(i == 2)  return(checkState2);  if(i == 3)  return(checkState3);
	if(i == 4)  return(checkState4);  if(i == 5)  return(checkState5);  if(i == 6)  return(checkState6);  if(i == 7)  return(checkState7);
	if(i == 8)  return(checkState8);  if(i == 9)  return(checkState9);  if(i == 10) return(checkState10); if(i == 11) return(checkState11);
	if(i == 12) return(checkState12); if(i == 13) return(checkState13); if(i == 14) return(checkState14); if(i == 15) return(checkState15);
	if(i == 16) return(checkState16); if(i == 17) return(checkState17); if(i == 18) return(checkState18); if(i == 19) return(checkState19);
	if(i == 20) return(checkState20); if(i == 21) return(checkState21); if(i == 22) return(checkState22); if(i == 23) return(checkState23);
	if(i == 24) return(checkState24); if(i == 25) return(checkState25); if(i == 26) return(checkState26); if(i == 27) return(checkState27);
	if(i == 28) return(checkState28); if(i == 29) return(checkState29); if(i == 30) return(checkState30); if(i == 31) return(checkState31);
	return(true);
}

void setCheckState(int i = -1, bool state = true) {
	if(i == 0)  checkState0  = state; if(i == 1)  checkState1  = state; if(i == 2)  checkState2  = state; if(i == 3)  checkState3  = state;
	if(i == 4)  checkState4  = state; if(i == 5)  checkState5  = state; if(i == 6)  checkState6  = state; if(i == 7)  checkState7  = state;
	if(i == 8)  checkState8  = state; if(i == 9)  checkState9  = state; if(i == 10) checkState10 = state; if(i == 11) checkState11 = state;
	if(i == 12) checkState12 = state; if(i == 13) checkState13 = state; if(i == 14) checkState14 = state; if(i == 15) checkState15 = state;
	if(i == 16) checkState16 = state; if(i == 17) checkState17 = state; if(i == 18) checkState18 = state; if(i == 19) checkState19 = state;
	if(i == 20) checkState20 = state; if(i == 21) checkState21 = state; if(i == 22) checkState22 = state; if(i == 23) checkState23 = state;
	if(i == 24) checkState24 = state; if(i == 25) checkState25 = state; if(i == 26) checkState26 = state; if(i == 27) checkState27 = state;
	if(i == 28) checkState28 = state; if(i == 29) checkState29 = state; if(i == 30) checkState30 = state; if(i == 31) checkState31 = state;
}

/*
** Adds a custom check and its state to the array.
**
** @param checkLabel: the name of the check (to be shown in the debug message if triggered)
** @param isCrucial: whether the check is crucial or not (if set to true, a failed check will be shown in the debug message)
** @param hasSucceeded: true if the check for label succeded, false otherwise
*/
void addCustomCheck(string checkLabel = "?", bool isCrucial = false, bool hasSucceeded = true) {
	setCheckLabel(customCheckCount, checkLabel);
	setCheckCrucial(customCheckCount, isCrucial);
	setCheckState(customCheckCount, hasSucceeded);

	customCheckCount++;
}

/******************
* PLACEMENT CHECK *
******************/

/*
** Verifies the placement of the objects and proto stuff previously specified.
** Since we don't want two independent error messages (one for object and one for proto check), we combine them here.
** This rule is not in rmx_triggers.xs because it is heavily tied to everything in this file.
**
** @param requireEqualTeams: set to true if the check should only be executed if the game has two equally sized teams playing
** @param maxNumberOfPlayers: if more players than the specified number are present, skip the check
*/
void injectObjectCheck(bool requireEqualTeams = true, int maxNumberOfPlayers = 12) {
	// Check if equal teams are required for the check.
	if(requireEqualTeams && gameHasTwoEqualTeams() == false) {
		return;
	}

	// Check if we have more players than the maximum to perform the check.
	if(cNonGaiaPlayers > maxNumberOfPlayers) {
		return;
	}

	/*
	 * The major "problem" here is that we have to check once via array
	 * and once through triggers if the message header/footer has to be printed at all.
	*/
	bool objectFailed = false;
	bool customFailed = false;

	// Step 1: Check if any of the object placements failed.
	for(i = 0; < objectCheckCount) {
		if(getObjectTargetPlaced(i) > rmGetNumberUnitsPlaced(getObjectID(i)) / getObjectItemCount(i)) {
			objectFailed = true;
			break;
		}
	}

	// Step 2: Check if any of the custom placements failed.
	for(i = 0; < customCheckCount) {
		// Print if the check failed and is crucial.
		if(getCheckState(i) == false && getCheckCrucial(i)) {
			customFailed = true;
			break;
		}
	}

	code("rule _print_error_msg");
	code("highFrequency");
	code("active");
	code("{");
		injectRuleInterval(0, 500); // Run after 0.5 seconds to give time for other initialization.

		code("bool failed = ((1 == " + objectFailed + ") || (1 == " + customFailed + "))");
		// Step 3: Check if any of the proto checks fail.
		for(i = 0; < protoCheckCount) {
			code(" || (trPlayerUnitCountSpecific(" + getProtoOwner(i) + ", \"" + getProtoName(i) + "\") < " + getProtoTargetCount(i) + ")");

		}
		code(";");

		// Step 4: Print the error if something failed.
		code("if(failed)");
		code("{");
			// At least one failed.
			sendChatRed(cInfoLine);
			sendChatRed("");
			sendChatRed("Warning: Object placement failed!");
			sendChatRed("");
			sendChatRed("Error(s):");

			// Print custom entries like simLoc/fairLocs.
			for(i = 0; < customCheckCount) {
				if(getCheckState(i) == false && getCheckCrucial(i)) {
					sendChatRed(getCheckLabel(i) + ": failed");
				}
			}

			// Divide rmGetNumberUnitsPlaced() by getObjectItemCount() to get the actual number placed.
			for(i = 0; < objectCheckCount) {
				if(getObjectTargetPlaced(i) > rmGetNumberUnitsPlaced(getObjectID(i)) / getObjectItemCount(i)) {
					sendChatRed(getObjectLabel(i) + ": " + rmGetNumberUnitsPlaced(getObjectID(i)) / getObjectItemCount(i) + "/" + getObjectTargetPlaced(i));
				}
			}

			// Print proto check errors.
			for(i = 0; < protoCheckCount) {
				code("int count" + i + " = trPlayerUnitCountSpecific(" + getProtoOwner(i) + ", \"" + getProtoName(i) + "\");");
				code("if(count" + i + " < " + getProtoTargetCount(i) + ")");
				code("{");
					sendChatRed(getProtoName(i) + ": \" + count" + i + " + \"/\" + " + getProtoTargetCount(i) + " + \"");
				code("}");
			}

			sendChatRed("");
			sendChatRed("Consider saving this seed.");
			sendChatRed("");
			sendChatRed(cInfoLine);

			pauseGame();
		code("}");

		code("xsDisableSelf();");
	code("}");
}
