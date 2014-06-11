//Settings
integer PING_TIME = 10;
float MINIMUM_PING_INTERVAL = 0.5;

integer SHOW_TEXT_TOKEN_DISPLAY = FALSE;
integer SHOW_TEXT_BGM = FALSE;
integer SHOW_TEXT_VISIBILITY_TOGGLE = FALSE;
integer SHOW_TEXT_HINT_TOGGLE = FALSE;
integer SHOW_LATEST_TOKEN = FALSE;
integer SHOW_RESET = FALSE;

float REZ_TIMEOUT = 30.0;

//Global Constants
string GAME_VERSION = "Beta 0.7.5";
string SEPERATOR = "|||";
integer SCAVENGER_HUD_CHANNEL = -498; 
integer SCAVENGER_OBJECT_CHANNEL = 498;
integer INTERNAL_CHANNEL = -4981;
string XOR_KEY = "husky498uw!";
integer HUD_FRONT_FACE = 1;
string VSD_SIM_NAME = "UW iSchool";
vector VSD_DEFAULT_LOCATION = <224, 230, 21>; 
list VSD_LIST = 
    ["Accountability", "Autonomy", "Calmness", "Courtesy",
    "Educational", "Empirical", "Environmental Stability", "Freedom from Bias",
    "Human Welfare", "Identity", "Informed Consent", "Ownership/Property",
    "Trust", "Universal Usability", "Exceptional", "Privacy"];
list VSD_LOCATION = 
    [<74,239,21>, <18,242,22>, <128,16,22>, <78,150,21>,
    VSD_DEFAULT_LOCATION, VSD_DEFAULT_LOCATION, <100,71,22>, <224,132,21>,
    <192,172,21>, <248,18,21>, <201,21,21>, <95,158,22>,
    <149,103,21>, VSD_DEFAULT_LOCATION, VSD_DEFAULT_LOCATION, <246,77,22>
    ];
    
//NPC Child Prim Script Commands
integer SET_NPC = 0;
integer SET_NPC_TEXTURE = 1;
integer SET_DIALOGUE = 2;
integer SET_TIMEOUT = 3;
integer TALK = 4;
integer RESET_NPC = 5;
integer CHOOSE_DIALOGUE = 6;
integer REFRESH_NPC = 7;
//Leaderboard Child Prim Script Commands
integer SUBMIT_SCORE = 0;
integer RESET_SCORE = 1;

//Link Numbers    
integer LAST_VSD_LINK_NUMBER = 17;
integer RESET_BUTTON_LINK_NUMBER = 18;
integer LATEST_TOKEN_DISPLAY_LINK_NUMBER = 19;
integer VSD_GROUP_BACKGROUND_LINK_NUMBER = 20;
integer BGM_CONTROL_LINK_NUMBER = 21;
integer VISIBILITY_CONTROL_LINK_NUMBER = 22;
integer PING_LINK_NUMBER = 23;
integer NPC_LINK_NUMBER = 24;
integer CHOICE_A_LINK_NUMBER = 25;
integer CHOICE_B_LINK_NUMBER = 26;
integer CHOICE_C_LINK_NUMBER = 27;
integer CHOICE_D_LINK_NUMBER = 28;

//Texture and UI Sound UUIDs
key SOUND_OBTAIN = "93c7acbd-8201-85c4-e50d-2567507297c1";
key SOUND_DEACTIVATED = "a692d9f3-e328-7877-6c2e-18a55c87994e";
key SOUND_PING = "c74e854f-7ab8-e27b-359b-2052be1c2dfb";
key VSD_TEXTURE = "cd582a07-ce99-6282-3de0-8678d7d732b6";
key BACKGROUND_TEXTURE = "b9905cf4-81a0-936c-4c31-e8e24ffcd9fc";
key PANEL_TEXTURE = "a807d28a-c7a4-d03a-f618-75a15a78a7b2";
//Menu Texture
key OFF_TEXTURE = "e68f1b5e-c3eb-7e06-15be-f2910fa294b2";
key ON_TEXTURE = "5e50e558-7901-1127-5c53-5a1d8f8eadfd";
key RESET_TEXTURE = "d987a326-e4bd-53e6-3702-8ed3a3b5e7af";
key HIDE_TEXTURE = "421f8847-454d-a382-a221-6e7d8b701a9c";
key SHOW_TEXTURE = "fe02251c-789b-2383-c474-5f42c5b56f45";
key HINT_TEXTURE = "e4ef99b1-ad54-3869-3ab1-a23580120dda";

//BGM UUIDs
list BGM_LIST = [
"AMBLER",
"MOVE_FORWARD",
"HAROLD_VAR3",
"GUITON_SKETCH",
"KICK_SHOCK"
];

list BGM_DISPLAY = [
"\"Ambler\"\nComposer: Kevin MacLeod",
"\"Move Forward\"\nComposer: Kevin MacLeod",
"\"Theme of Harold (var. 3)\"\nComposer: Kevin MacLeod",
"\"Guiton Sketch\"\nComposer: Kevin MacLeod",
"\"Kick Shock\"\nComposer: Kevin MacLeod"
];

list BGM_LENGTH = [
46.0, 69.0, 76.0, 34.0, 63.0
];

list BGM_CLIP_START_INDEX = [
0, 5, 12, 20, 24
];

list BGM_CC = [
"\"Ambler\" Kevin MacLeod (incompetech.com) 
Licensed under Creative Commons: By Attribution 3.0
http://creativecommons.org/licenses/by/3.0/",
"\"Move Forward\" Kevin MacLeod (incompetech.com) 
Licensed under Creative Commons: By Attribution 3.0
http://creativecommons.org/licenses/by/3.0/",
"\"Theme for Harold (var. 3)\" Kevin MacLeod (incompetech.com) 
Licensed under Creative Commons: By Attribution 3.0
http://creativecommons.org/licenses/by/3.0/",
"\"Guiton Sketch\" Kevin MacLeod (incompetech.com) 
Licensed under Creative Commons: By Attribution 3.0
http://creativecommons.org/licenses/by/3.0/",
"\"Kick Shock\" Kevin MacLeod (incompetech.com) 
Licensed under Creative Commons: By Attribution 3.0
http://creativecommons.org/licenses/by/3.0/"
];

list BGM_CLIP_KEYS = [
//AMBLER
"e5a5d584-3687-2beb-c0e6-954e07639261", //0
"7b338157-17b0-798c-88f9-233fd54b6149", 
"8265bff1-6f56-a349-b944-9b12c9e4b201",
"3ea4f119-38da-7092-f3ef-f297ef45e8ba",
"8166eddc-d864-d90a-9a38-98f6e97989ae", //4
//MOVE_FORWARD
"114ca2ff-ab30-b885-d256-679b92072b90", //5
"2dbca65f-962b-b490-c236-509abcb4cc67",
"4f99d526-67ef-9fb0-9075-766c6ab8e129",
"29c9f9b5-6561-1be1-e768-3a2927196730",
"d45d4979-7956-aa0a-65f9-dcfb419f8539",
"f438d032-9742-460e-36fe-6ee659a5a758",
"ce00c41b-86b3-bbd3-a8ac-0130ccf5c634", //11
//THEME FOR HAROLD V3
"5a52d162-a364-7ea9-2463-81e79c41f724", //12
"e9511a0e-f195-9439-0ffa-772022304470",
"b1962d0d-0dc0-e8b3-8033-97a449abf56f",
"19e6e627-b6ef-8abe-8405-317111343145",
"9396cfe6-1378-5fed-630f-c10fd1363b59",
"634ff332-9b97-e366-dd4b-6d084b199728",
"2fe11edd-c98c-b017-7b65-7187f658a690",
"bc1d20f8-f907-f7a0-7fb6-b6d67e38608d", //19
//GUITON SKETCH
"42207803-e487-d764-ff43-582a92ee6520", //20
"1c477f96-6456-d57f-9bc0-1f9fc2f00d2b",
"be8013fc-ea8b-102a-97cb-e08bc92dbaca",
"92e1cd1e-0958-e5ff-bbaf-49d0a5dffb2c", //23
//KICK SHOCK
"685657af-ef14-0a77-0666-a26b143641a0",    //24
"63fed441-a1fa-48ab-0cf9-cfaff7149201",
"a5e9c561-b60f-14f8-ef2f-de789dd7617c",
"6715b916-a245-25f5-751d-9e53c930e981",
"82ac3355-459f-7d6d-a9e0-b393b10a802a",
"fe5372cd-aa12-a631-fe64-26aace5410cd",
"aab2316d-a474-fc8e-b70b-98dc9138e862"    //30
];

//Index Constants for Incoming Parameters
integer TIME_STAMP = 0;
integer AVATAR_KEY = 1;
integer COMMAND = 2;
integer PARAMETER = 3;
integer TRIGGER_ID = 0;
integer NPC_TEXTURE = 1;
integer DIALOGUE_OPTIONS = 2;

//Global Variables
integer externalListenHandle = 0;
integer internalListenHandle = 0;
list tokenList = [];
integer startTime = 0;
integer endTime = 0;
integer decoyCount = 0;
//Deactivate State Variables
integer timerCounter = 1;
//BGM Variables
string currentBGM = "";
string currentBGMdisplay = "";
list currentBGMclipList = [];
float currentBGMlength = 0.0;
integer currentBGMclipIndex = 0;
integer currentBGMclipCount = 0;
integer playBGM = TRUE;
//Ping Variables
float distanceFromObject = 25.0;
integer pingCount = PING_TIME;
//Visibility Variables
integer hideHUD = FALSE;
//NPC Variables
string currentNPC = "";
key currentNPCtexture = TEXTURE_BLANK;
list currentDialogueOptions = [];
key currentVSDbuttonTexture = VSD_TEXTURE;

//Encode & Decode Functions (for security)
string Xor(string data)
{
    return llXorBase64(llStringToBase64(data), llStringToBase64(XOR_KEY + (string)llGetOwner()));
}
 
string Dexor(string data) 
{
    return llBase64ToString(llXorBase64(data, llStringToBase64(XOR_KEY + (string)llGetOwner())));
}

//Time Difference - Modded from Ugleh Ulrik's Script
string ConvertUnixTime(integer timeDifference)
{
    list periods = ["second",
        "minute",
        "hour",
        "day",
        "week",
        "month",
        "year",
        "decade"];
 
    list lenghts = [1,
        60,
        3600,
        86400,
        604800,
        2630880,
        31570560,
        315705600];
 
    integer v = llGetListLength(lenghts) - 1;
    integer no;
 
    while((0 <= v) && (no = timeDifference/llList2Integer(lenghts, v) <= 1))
        --v;
 
    string output = llList2String(periods, v);
    
    integer ntime = timeDifference / llList2Integer(lenghts, llListFindList(periods, [output]));
 
    if(no != 1)
        output += "s";
 
    output = (string)ntime + " "+ output;
    return output;
}

//HUD Functions
PlayBGM()
{
    llOwnerSay("BGM: on"); 
    
    //llOwnerSay("Starting BGM...");        
    currentBGMclipIndex = -1;    
    playBGM = TRUE;
    ChangeBGM(currentBGM);
}

ChangeBGM(string bgm)
{
    integer bgmIndex = llListFindList(BGM_LIST, [bgm]);
    
    if(bgmIndex != -1)
    { 
        //llOwnerSay("Current BGM: " + bgm);
        if(currentBGM != bgm | currentBGMclipIndex == -1)
        {
            llStopSound();
            llSetTimerEvent(0.0);
                       
            currentBGM = bgm;
            currentBGMdisplay = llList2String(BGM_DISPLAY, bgmIndex);
            currentBGMlength = llList2Float(BGM_LENGTH, bgmIndex);
            
            integer clipCount = llCeil(currentBGMlength/10.0);
            integer bgmStartIndex = llList2Integer(BGM_CLIP_START_INDEX, bgmIndex);   
         
            currentBGMclipList = llList2List(BGM_CLIP_KEYS, bgmStartIndex, bgmStartIndex + clipCount - 1);
            currentBGMclipCount = llGetListLength(currentBGMclipList);
            key firstBGMclipKey = llList2Key(currentBGMclipList, 0);

            //llOwnerSay("Final Index: " + (string)(bgmStartIndex + clipCount - 1) + "\nCount: " + (string)llGetListLength(currentBGMclipList));     
            //llOwnerSay(llDumpList2String(currentBGMclipList, "\n"));
            
            if(playBGM)
            {   
                string bgmCC = llList2String(BGM_CC, bgmIndex);    
                llOwnerSay("Current Track: " + bgmCC);
                
                currentBGMclipIndex = 0;            
                llSetSoundQueueing(FALSE);
                llPlaySound(firstBGMclipKey, 1.0);
                llSetTimerEvent(10.0);    
            }
        }    
    }
    
    RefreshBGMcontrol();    
}

StopBGM()
{
    playBGM = FALSE;
    llOwnerSay("BGM: off");          
    currentBGMclipIndex = -1;            
    RefreshBGMcontrol();            
    llSetTimerEvent(0.0);  
    llStopSound();
}

ResetHUD()
{
    llOwnerSay("Resetting HUD...");  
	SHOW_RESET = FALSE;
    //Global Variables
    externalListenHandle = 0;
    internalListenHandle = 0;
    tokenList = [];
    startTime = 0;
    endTime = 0;
    decoyCount = 0;
    //Deactivate State Variables
    timerCounter = 1;
    //BGM Variables
    currentBGM = "";
    currentBGMdisplay = "";
    currentBGMclipList = [];
    currentBGMlength = 0.0;
    currentBGMclipIndex = 0;
    currentBGMclipCount = 0;
    playBGM = TRUE;
    //Ping Variables
    distanceFromObject = 25.0;
    pingCount = PING_TIME;
    //Visibility Variables
    hideHUD = FALSE;
    //NPC Variables
    currentNPC = "";
    currentNPCtexture = TEXTURE_BLANK;
    currentDialogueOptions = [];
    currentVSDbuttonTexture = VSD_TEXTURE;
    
    RefreshHUD();
    ResetNPC();
    ResetScore();
}

RefreshBGMcontrol()
{
    string bgmPrompt = "[Turn Off Music]";
    string bgmTexture = OFF_TEXTURE;
    
    if(!playBGM)
    {
        bgmPrompt = "[Turn On Music]";    
        bgmTexture = ON_TEXTURE;
    }     

    string bgmDisplay = "No Music Currently Playing";
    
    if(currentBGM != "")
    {
        bgmDisplay = currentBGMdisplay;
    }
    
    rotation bgmControlRotation = llEuler2Rot(<0.0, 0.0, 90.0 * (float)(hideHUD)> * DEG_TO_RAD);
    
    llSetLinkPrimitiveParamsFast(BGM_CONTROL_LINK_NUMBER, [
        PRIM_TEXTURE, HUD_FRONT_FACE, bgmTexture, <1.0, 1.0, 0.0>, <0.0, 0.0, 0.0>, 0.0,    
        PRIM_TEXT, bgmDisplay + "\n" + bgmPrompt, <1.0, 1.0, 1.0>, (float)(SHOW_TEXT_BGM * !hideHUD),
        PRIM_ROT_LOCAL, bgmControlRotation]);                 
}

RefreshHUD()
{   
    rotation linkRotation = llEuler2Rot(<0.0, 0.0, 90.0 * (float)(!hideHUD)> * DEG_TO_RAD);

    llSetLinkPrimitiveParamsFast(LINK_SET, [
        PRIM_COLOR, HUD_FRONT_FACE, <1.0, 1.0, 1.0>, (float)(!hideHUD),
        PRIM_TEXTURE, HUD_FRONT_FACE, PANEL_TEXTURE, <1.0, 1.0, 0.0>, <0.0, 0.0, 0.0>, 0.0, 
        PRIM_TEXT, "", <1.0, 1.0, 1.0>, 0.0]); 
    
    llSetLinkPrimitiveParamsFast(VSD_GROUP_BACKGROUND_LINK_NUMBER, [
        PRIM_COLOR, HUD_FRONT_FACE, <1.0, 1.0, 1.0>, (float)(!hideHUD),
        PRIM_TEXTURE, HUD_FRONT_FACE, BACKGROUND_TEXTURE, <1.0, 1.0, 0.0>, <0.0, 0.0, 0.0>, 0.0]); 

            
    integer count = llGetListLength(tokenList);        
    string rootText = "No Token Obtained";
    string latestTokenText = "No Latest Token";
    string visibilityText = "[Show HUD]";
    key visibilityTexture = SHOW_TEXTURE;
    
    if(count != 0)
    {
        string latestTokenName = llList2String(tokenList, count - 1);
        integer latestVsdIndex = llListFindList(VSD_LIST, [latestTokenName]);
        rootText = "Current Token" + " (" + (string)llGetListLength(tokenList) + "/16):";
        latestTokenText = "Latest Token:\n" + latestTokenName;
        
        ChangeVsdTexture(latestVsdIndex, LATEST_TOKEN_DISPLAY_LINK_NUMBER);
            
        integer index = 0;    
        for(index = 0; index < count; index++)
        {
            string tokenName = llList2String(tokenList, index);
            integer vsdIndex = llListFindList(VSD_LIST, [tokenName]);
            
            if(vsdIndex != -1)
            {
                ChangeVsdTexture(vsdIndex, vsdIndex + 2);
            }
            
            if(index < 5)
            {
                rootText = rootText + "\n[" + tokenName + "]";
            }
        }   
        
        if(count > 5)
        {
            rootText = rootText + "\n...And " + (string)(count - 5) + " more!"; 
        }
    }
    
    if(!hideHUD)
    {
        visibilityText = "[Hide HUD]";
        visibilityTexture = HIDE_TEXTURE;        
    }
    
    rotation latestTokenRotation = llEuler2Rot(<0.0, 0.0, 90.0 * (float)(!(!hideHUD && SHOW_LATEST_TOKEN))> * DEG_TO_RAD);
    rotation resetRotation = llEuler2Rot(<0.0, 0.0, 90.0 * (float)(!(!hideHUD && SHOW_RESET))> * DEG_TO_RAD);
    
    llSetLinkPrimitiveParamsFast(LATEST_TOKEN_DISPLAY_LINK_NUMBER, [
        PRIM_COLOR, HUD_FRONT_FACE, <1.0, 1.0, 1.0>, (float)(!hideHUD && SHOW_LATEST_TOKEN),
        PRIM_TEXT, latestTokenText, <1.0, 1.0, 1.0>, (float)(!hideHUD && SHOW_LATEST_TOKEN),
        PRIM_ROT_LOCAL, latestTokenRotation]);  
    llSetLinkPrimitiveParamsFast(RESET_BUTTON_LINK_NUMBER, [
        PRIM_COLOR, HUD_FRONT_FACE, <1.0, 1.0, 1.0>, (float)(!hideHUD && SHOW_RESET),  
        PRIM_TEXTURE, HUD_FRONT_FACE, RESET_TEXTURE, <1.0, 1.0, 0.0>, <0.0, 0.0, 0.0>, 0.0,            
        PRIM_TEXT, "[Reset HUD]", <1.0, 1.0, 1.0>, (float)(!hideHUD && SHOW_RESET),
        PRIM_ROT_LOCAL, resetRotation]);
    llSetLinkPrimitiveParamsFast(VISIBILITY_CONTROL_LINK_NUMBER, [
        PRIM_COLOR, HUD_FRONT_FACE, <1.0, 1.0, 1.0>, 1.0,
        PRIM_TEXTURE, HUD_FRONT_FACE, visibilityTexture, <1.0, 1.0, 0.0>, <0.0, 0.0, 0.0>, 0.0,
        PRIM_TEXT, visibilityText, <1.0, 1.0, 1.0>, (float)(SHOW_TEXT_VISIBILITY_TOGGLE)]);
    llSetLinkPrimitiveParamsFast(LINK_ROOT, [
        PRIM_COLOR, HUD_FRONT_FACE, <1.0, 1.0, 1.0>, SHOW_TEXT_TOKEN_DISPLAY,
        PRIM_TEXT, rootText, <1.0,1.0,1.0>, (float)(SHOW_TEXT_TOKEN_DISPLAY)]);        
    llSetLinkPrimitiveParamsFast(VSD_GROUP_BACKGROUND_LINK_NUMBER, [
        PRIM_TEXT, rootText, <1.0, 1.0, 1.0>, (float)(!hideHUD)]);     
    llSetLinkPrimitiveParamsFast(PING_LINK_NUMBER, [
        PRIM_COLOR, HUD_FRONT_FACE, <1.0, 1.0, 1.0>, 1.0,  
        PRIM_TEXTURE, HUD_FRONT_FACE, HINT_TEXTURE, <1.0, 1.0, 0.0>, <0.0, 0.0, 0.0>, 0.0,        
        PRIM_TEXT, "[Activate Hint]", <1.0, 1.0, 1.0>, (float)(SHOW_TEXT_HINT_TOGGLE)]);            
    
    RefreshBGMcontrol();
    RefreshNPC();
}

ChangeVsdTexture(integer vsdIndex, integer linkNumber)
{
    integer column = (vsdIndex %  4);
    integer row = (vsdIndex / 4);
    float xOffset = (-3 + (column * 2))/8.0;
    float yOffset = (3 - (row * 2))/8.0;      
    
    llSetLinkPrimitiveParamsFast(linkNumber, [
    PRIM_TEXTURE, HUD_FRONT_FACE, currentVSDbuttonTexture, <1/4.0, 1/4.0, 1/4.0>, <xOffset, yOffset, 0.0>, 0]);
}

integer AddToken(string name)
{
    integer vsdIndex = llListFindList(VSD_LIST, [name]);
    integer itemIndex = llListFindList(tokenList, [name]);    
    
    if(vsdIndex != -1)
    {
        if(itemIndex == -1)
        {
            integer count = llGetListLength(tokenList);
            
            if(count == 0)
            {
                startTime = llGetUnixTime();
            }
            
            tokenList += name; 
            llOwnerSay("You obtained " + name + " token.");
            llTriggerSound(SOUND_OBTAIN, 1.0);
            
            count = llGetListLength(tokenList);

            if(count == llGetListLength(VSD_LIST))
            {
                SHOW_RESET = TRUE;
                endTime = llGetUnixTime();  
                llOwnerSay("Congratulations! You finished the game in " + ConvertUnixTime(endTime - startTime) + ".");
                          
                currentVSDbuttonTexture = TEXTURE_TRANSPARENT;

                llListenRemove(INTERNAL_CHANNEL);
                internalListenHandle = llListen(INTERNAL_CHANNEL, "", "", "");                
                llDialog(llGetOwner(), "Submit score to web?", ["Yes", "No"], INTERNAL_CHANNEL);
            }
            
            RefreshHUD();
        }
        else
        {
            llOwnerSay("You already have " + name + " token.");            
        }
        return TRUE;
    }
    else
    {
        decoyCount++;
        llOwnerSay("Invalid token obtained.");     
        return FALSE;     
    }
}

RemoveToken(string name)
{
    integer itemIndex = llListFindList(tokenList, [name]);    
    
    if(itemIndex != -1)
    {
        tokenList = llDeleteSubList(tokenList, itemIndex, itemIndex);
        llSay(DEBUG_CHANNEL, llGetDisplayName(llGetOwner()) + " deleted " + name + " token.");        
    }
    
    RefreshHUD();
}

RequestPing()
{
    string timeStamp = llGetTimestamp();
    key avatarKey = llGetOwner();
    string command = "REQUEST_PING";
    string parameter = llGetOwner();
    
    string xorParameterList = Xor(timeStamp + SEPERATOR + (string)avatarKey + SEPERATOR + command + SEPERATOR + parameter);
    
    llSay(SCAVENGER_OBJECT_CHANNEL, xorParameterList);
}

ReturnTokenList()
{
    string timeStamp = llGetTimestamp();
    key avatarKey = llGetOwner();
    string command = "RETURN_TOKEN_LIST";
    string parameter = llDumpList2String(tokenList, "##");
    
    string xorParameterList = Xor(timeStamp + SEPERATOR + (string)avatarKey + SEPERATOR + command + SEPERATOR + parameter);
    
    llSay(SCAVENGER_OBJECT_CHANNEL, xorParameterList);
}

ReturnTokenCheck(string name)
{
    integer index = llListFindList(tokenList, [name]);
    
    if(index == -1)
    {
        llOwnerSay("Token not found.");          
    }
    else
    {
        string timeStamp = llGetTimestamp();
        key avatarKey = llGetOwner();
        string command = "RETURN_TOKEN_CHECK";
        string parameter = name;
        
        string xorParameterList = Xor(timeStamp + SEPERATOR + (string)avatarKey + SEPERATOR + command + SEPERATOR + (string)parameter);    
        llSay(SCAVENGER_OBJECT_CHANNEL, xorParameterList);         
        llOwnerSay("Token found!");          
    }
}

RefreshNPC()
{
    llMessageLinked(NPC_LINK_NUMBER, REFRESH_NPC, "", "");    
}

ResetNPC()
{
    llMessageLinked(NPC_LINK_NUMBER, RESET_NPC, "", "");    
}

SubmitScore(integer time)
{
    llMessageLinked(VSD_GROUP_BACKGROUND_LINK_NUMBER, SUBMIT_SCORE, GAME_VERSION + SEPERATOR + (string)time + SEPERATOR + (string)decoyCount, "");    
}

ResetScore()
{
    llMessageLinked(VSD_GROUP_BACKGROUND_LINK_NUMBER, RESET_SCORE, "", "");  
}

default
{
    attach(key id)
    {
        if(id)
        {    
            state ready;
        }
    }
    
    state_entry()
    {        
        llListenRemove(internalListenHandle);              
        llSetTimerEvent(REZ_TIMEOUT);  
        internalListenHandle = llListen(INTERNAL_CHANNEL, "", "", "");          
    }
    
    state_exit()
    {
        llListenRemove(internalListenHandle);       
        llSetTimerEvent(0.0);
    }
    
    listen(integer channel, string name, key id, string message)
    { 
        key avatarKey = (key)message;
        llSay(PUBLIC_CHANNEL, "Requesting attach permission from " + (string)avatarKey);
        
        if(llKey2Name(avatarKey) != "")
        {  
            llRequestPermissions(avatarKey, PERMISSION_ATTACH);   
            llListenRemove(internalListenHandle);     
            llSetTimerEvent(REZ_TIMEOUT); 
        }
    }
    
    timer()
    {
        llSay(PUBLIC_CHANNEL, "Permission to auto-attach not granted, deleting object...");
        llSetTimerEvent(0.0);        
        llDie();
    }
    
    run_time_permissions(integer perm)
    {
        if(perm & PERMISSION_ATTACH)
        {
            integer perm = llGetPermissions();
            llSay(PUBLIC_CHANNEL, "Permission Granted: " + llKey2Name(llGetPermissionsKey()));        
            llAttachToAvatarTemp(ATTACH_HUD_BOTTOM_LEFT);
            state ready;
        }
    }    
}

state ready
{     
	on_rez(integer start_param)
	{
		state default;
	}
	
    timer()
    {
        currentBGMclipIndex++;
        
        //llOwnerSay("Current: " + (string)currentBGMclipIndex);
        if(currentBGMclipIndex == currentBGMclipCount - 1)
        {
            currentBGMclipIndex = 0;
        }
        
        //llOwnerSay((string)(currentBGMclipIndex + 1) + "/" + (string)currentBGMclipCount  + "\nPlaying: " + llList2String(currentBGMclipList, currentBGMclipIndex));
        llPlaySound(llList2Key(currentBGMclipList, currentBGMclipIndex), 1.0);
        
        if(currentBGMclipIndex == currentBGMclipCount - 2)
        {
            //llOwnerSay((string)(currentBGMlength - (llFloor(currentBGMlength/10.0)*10)));
            llSetTimerEvent(currentBGMlength - (llFloor(currentBGMlength/10.0)*10));  
        }
        else
        {
            llSetTimerEvent(10.0);           
        }           
    }
    
    state_entry()
    {    
        llSetTimerEvent(0.0);          
        RefreshHUD();
        ChangeBGM(currentBGM);
        llListenRemove(externalListenHandle);        
        llListenRemove(internalListenHandle);            
        externalListenHandle = llListen(SCAVENGER_HUD_CHANNEL, "", "", "");
		llSay(PUBLIC_CHANNEL, "HUD Ready");
    }
    
    state_exit()
    {
        if(playBGM)
        {
            currentBGMclipIndex = -1;
        }
        
        llListenRemove(externalListenHandle);   
        llListenRemove(internalListenHandle);         
    }
    
    touch_end(integer num_detected)
    {
        integer linkNumber = llDetectedLinkNumber(0);
        
        if(linkNumber > 1 & linkNumber < LAST_VSD_LINK_NUMBER & !hideHUD)
        {
            integer vsdNumber = linkNumber - 2;
            vector vsdDestination = llList2Vector(VSD_LOCATION, vsdNumber);
            
            if(vsdDestination == ZERO_VECTOR)
            {
                vsdDestination = VSD_DEFAULT_LOCATION;           
            }

            llMapDestination(VSD_SIM_NAME, vsdDestination, ZERO_VECTOR);                
        }
        else if(linkNumber == RESET_BUTTON_LINK_NUMBER & !hideHUD & SHOW_RESET)
        {
            ResetHUD();
            state ready;
        }
        else if(linkNumber == BGM_CONTROL_LINK_NUMBER & !hideHUD)
        {    
            if(playBGM)
            {
                playBGM = FALSE;
                StopBGM();
            }
            else
            {
                playBGM = TRUE;
                PlayBGM();   
            }
        }
        else if(linkNumber == VISIBILITY_CONTROL_LINK_NUMBER)
        {
            hideHUD = !hideHUD;
            
            RefreshHUD();
        }
        else if(linkNumber == PING_LINK_NUMBER)
        {
            state initialize_ping;
        }
        else if(linkNumber == CHOICE_A_LINK_NUMBER)
        {        
            llMessageLinked(NPC_LINK_NUMBER, CHOOSE_DIALOGUE, "A", "");            
        }
        else if(linkNumber == CHOICE_B_LINK_NUMBER)
        {
            llMessageLinked(NPC_LINK_NUMBER, CHOOSE_DIALOGUE, "B", "");                
        }        
        else if(linkNumber == CHOICE_C_LINK_NUMBER)
        {
            llMessageLinked(NPC_LINK_NUMBER, CHOOSE_DIALOGUE, "C", "");                
        }     
        else if(linkNumber == CHOICE_D_LINK_NUMBER)
        {
            llMessageLinked(NPC_LINK_NUMBER, RESET_NPC, "", "");                
        }            
    }
    
    listen(integer channel, string name, key id, string message)
    {
        if(channel == INTERNAL_CHANNEL)
        {
            if(message == "Yes" & llGetListLength(tokenList) == llGetListLength(VSD_LIST))
            {
                llListenRemove(INTERNAL_CHANNEL);                
                SubmitScore(endTime - startTime);                
            }
        }
        else
        {
            list parameterList = llParseString2List(Dexor(message), [SEPERATOR], [""]);
            
            //For Debugging
            //llOwnerSay(Dexor(message));
            
            if(llGetListLength(parameterList) == 4)
            {
                //For Debugging
                //llOwnerSay("Correct Parameter.");
                
                string timeStamp = llList2Key(parameterList, TIME_STAMP);        
                key avatarKey = llList2Key(parameterList, AVATAR_KEY);
                string command = llList2String(parameterList, COMMAND);
                string parameter = llList2String(parameterList, PARAMETER);
                
                if(avatarKey == llGetOwner())
                {
                    if(command == "ADD_TOKEN")
                    {
                        if(!AddToken(parameter))
                        {
                            state deactivated;   
                        }
                    }
                    else if(command == "REMOVE_TOKEN")
                    {
                        RemoveToken(parameter);
                    }
                    else if(command == "REQUEST_TOKEN_LIST")
                    {
                        ReturnTokenList();
                    }
                    else if(command == "REQUEST_TOKEN_CHECK")
                    {
                        llOwnerSay("Checking for " + parameter + " token...");
                        ReturnTokenCheck(parameter);    
                    }
                    else if(command == "HUD_SAY")
                    {
						
                    }
                    else if(command == "RESET")
                    {
                        ResetHUD();   
                    }
                    else if(command == "DEACTIVATE")
                    {
                        state deactivated;   
                    }
                    else if(command == "CHANGE_BGM")
                    {
                        integer tempCurrentBGMclipIndex = currentBGMclipIndex;  
                        
                        ChangeBGM(parameter);
                        
                        if(tempCurrentBGMclipIndex == -1)
                        {
                            currentBGMclipIndex = tempCurrentBGMclipIndex;
                        }
                    }
                    else if (command == "RETURN_DIALOGUE_OPTION")
                    {
                        list npcParameterList = llParseString2List(parameter, ["***"], [""]);
                        
                        llMessageLinked(NPC_LINK_NUMBER, SET_NPC, 
                            llList2String(npcParameterList, TRIGGER_ID), "");
                        llMessageLinked(NPC_LINK_NUMBER, SET_NPC_TEXTURE, 
                            llList2String(npcParameterList, NPC_TEXTURE), "");
                        llMessageLinked(NPC_LINK_NUMBER, SET_DIALOGUE, 
                            llList2String(npcParameterList, DIALOGUE_OPTIONS), "");    
                        llMessageLinked(NPC_LINK_NUMBER, SET_TIMEOUT, "", "");
                    }
                    else if (command == "NPC_TALK")
                    {
                        list npcParameterList = llParseString2List(parameter, ["***"], [""]);                
                        llMessageLinked(NPC_LINK_NUMBER, TALK, 
                            llList2String(npcParameterList, 1), "");
                        llMessageLinked(NPC_LINK_NUMBER, SET_TIMEOUT, "", "");
                    }
                }
            }
        }
    }
}

state deactivated
{
    on_rez(integer start_param)
    {
        state default;
    }
    
    state_entry()
    {
        llSetTimerEvent(0.0);         
        //llOwnerSay("Play BGM Toggle: " + (string)playBGM + "\nCurrent Index: " + (string)currentBGMclipIndex);    
        llStopSound();
        timerCounter = 1;
        llSetText("HUD Deactivated\nPlease Wait for\n5 seconds.", <1.0,0.0,0.0>, 1.0);
        llTriggerSound(SOUND_DEACTIVATED, 1.0);
        llSetTimerEvent(1.0);   
    }
    
    timer()
    {
        if(timerCounter != 5)
        {
            llSetLinkPrimitiveParamsFast(LINK_ROOT, [PRIM_TEXT, "HUD Deactivated\nPlease Wait for\n" + (string)(5 - timerCounter) + " seconds.", <1.0,0.0,0.0>, 1.0]); 
            timerCounter++;            
        }    
        else
        {
            timerCounter = 1;
            state ready;            
        }
    }
}

state initialize_ping
{
    on_rez(integer start_param)
    {
        state ready;
    }
    
    state_entry()
    {
        llSetLinkPrimitiveParamsFast(PING_LINK_NUMBER, [
            PRIM_TEXT, "[Searching for Hint...]", <1.0, 1.0, 0.0>, 1.0]);      
          
        llListenRemove(externalListenHandle);          
        externalListenHandle = llListen(SCAVENGER_HUD_CHANNEL, "", "", "");    
        
        RequestPing();
        llSetTimerEvent(2.0); 
    }
    
    state_exit()
    {
        llListenRemove(externalListenHandle);        
    }
    
    listen(integer channel, string name, key id, string message)
    {
        list parameterList = llParseString2List(Dexor(message), [SEPERATOR], [""]);
        
        if(llGetListLength(parameterList) == 4)
        {
            string timeStamp = llList2Key(parameterList, TIME_STAMP);        
            key avatarKey = llList2Key(parameterList, AVATAR_KEY);
            string command = llList2String(parameterList, COMMAND);
            string parameter = llList2String(parameterList, PARAMETER);
            
            if(avatarKey == llGetOwner())
            {        
                if(command == "RETURN_PING")
                {
                    if(distanceFromObject > (float)parameter)
                    {
                        distanceFromObject = (float)parameter;
                    }
                }
            }
        }
    }
    
    timer()
    {
        state play_ping;
    }
}

state play_ping
{
    on_rez(integer start_param)
    {
        state ready;
    }
    
    state_entry()
    {
        llSetTimerEvent(0.0);         
        llStopSound();
        llSetLinkPrimitiveParamsFast(PING_LINK_NUMBER, [
            PRIM_TEXT, "[Getting Hint Feedback...]", <0.0, 1.0, 0.0>, 1.0]);            
        llPlaySound(SOUND_PING, 1.0);
        
        if(distanceFromObject < 20.0)
        {
            float pingInterval = distanceFromObject / 10.0;
            
            if(pingInterval < MINIMUM_PING_INTERVAL)
            {
                pingInterval = MINIMUM_PING_INTERVAL;
            }
            
            pingCount = llCeil((float)PING_TIME / pingInterval);
            timerCounter = 1;  
            llOwnerSay("Object found! Distance to closest object: " + (string)llCeil(distanceFromObject) + " m");    

            llSetTimerEvent(pingInterval);
        }
        else
        {
            llOwnerSay("No nearby object");
            state ready;
        }
    }
    
    state_exit()
    {
        distanceFromObject = 20.0;
    }
    
    timer()
    {        
        if(timerCounter < pingCount)
        {
            llPlaySound(SOUND_PING, 1.0);            
        }
        else
        {
            state ready;
        }
        
        timerCounter++;
    }
    
    touch_end(integer num_detected)
    {
        integer linkNumber = llDetectedLinkNumber(0);
        
        if(linkNumber == PING_LINK_NUMBER)
        {
            state ready;
        }        
    }        
}