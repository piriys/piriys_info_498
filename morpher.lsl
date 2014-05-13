string XOR_KEY = "somekey";

list sculptMapList =
[
"c6ac112e-8260-720a-3912-19b1a95284df", //Firewood
"321a08f0-66b3-fa42-5509-877f3ff10ceb", //Lamp Inside
"8abbb63c-7563-2259-1ce3-97097183cdea", //Lamp Outside
"af36f339-39da-9a8b-f5b2-7a1941c4ba24", //Bushes
TEXTURE_BLANK
];

list sculptTextureList =
[
"999b147d-5872-d2ef-4978-8a32c3261963", //Firewood
"584dd354-d888-5df2-8930-139389dc36e5", //Lamp Inside
"dffc6345-0b6d-6edc-c6b8-0dfb4fee5822", //Lamp Outside
"49e0a312-b412-1958-6647-fa30048fafb8", //Bushes
TEXTURE_BLANK
];

list sculptNameList =
[
"Firewood",
"Lamp #1",
"Lamp #2",
"Bushes", 
"Blank"
];

integer currentSculptIndex =
0;
 
string Xor(string data)
{
     return llXorBase64(llStringToBase64(data), llStringToBase64(XOR_KEY));
}
 
string Dexor(string data) {
     return llBase64ToString(llXorBase64(data, llStringToBase64(XOR_KEY)));
}

integer RandomInt(integer min, integer max)
{
    return min + (integer)(llFrand(max - min + 1));
}

Morph()
{
    integer count = llGetListLength(sculptMapList);  

    if(currentSculptIndex == count)
    {
        currentSculptIndex = 0;
    }
    
    key map = llList2Key(sculptMapList, currentSculptIndex);
    key texture = llList2Key(sculptTextureList, currentSculptIndex);
    string name = llList2String(sculptNameList, currentSculptIndex);
    string objectName = llMD5String(Xor((string)map + (string)llGetTime()), RandomInt(0,25));
    
    llSetObjectName(objectName);
    
    llSetPrimitiveParams([
        PRIM_TYPE, PRIM_TYPE_SCULPT, map, PRIM_SCULPT_TYPE_SPHERE,
        PRIM_TEXTURE, ALL_SIDES, texture, <1.0,1.0,0.0>, <0.0,0.0,0.0>, 0.0,
        PRIM_TEXT, llGetObjectName() + "\n" + name, <1.0,1.0,1.0>, 1.0
    ]);
    
    currentSculptIndex++;      
}

default
{
    state_entry()
    {
        llSetTimerEvent(1.5);  
    }

    touch_start(integer total_number)
    {
     
    }
    
    timer()
    {
        Morph();
    }
}
