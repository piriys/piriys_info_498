//Settings
/*Coming Soon*/

//Global Constants
integer SCAVENGER_HUD_CHANNEL = -498; 
integer SCAVENGER_OBJECT_CHANNEL = 498;
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

integer LAST_VSD_LINK_NUMBER = 17;
integer RESET_BUTTON_LINK_NUMBER = 18;
integer LATEST_TOKEN_DISPLAY_LINK_NUMBER = 19;
integer VSD_GROUP_BACKGROUND_LINK_NUMBER = 20;
integer BGM_CONTROL_LINK_NUMBER = 21;
integer VISIBILITY_CONTROL_LINK_NUMBER = 22;

//Texture and UI Sound UUIDs
key SOUND_OBTAIN = "93c7acbd-8201-85c4-e50d-2567507297c1";
key SOUND_DEACTIVATED = "a692d9f3-e328-7877-6c2e-18a55c87994e";
key VSD_TEXTURE = "cd582a07-ce99-6282-3de0-8678d7d732b6";

//BGM UUIDs
list BGM_LIST = [
"AMBLER",
"MOVE_FORWARD",
"HAROLD_VAR3",
"GUITON_SKETCH"
];

list BGM_DISPLAY = [
"\"Ambler\"\nComposer: Kevin MacLeod",
"\"Move Forward\"\nComposer: Kevin MacLeod",
"\"Theme of Harold (var. 3)\"\nComposer: Kevin MacLeod",
"\"Guiton Sketch\"\nComposer: Kevin MacLeod"
];

list BGM_LENGTH = [
46.0, 69.0, 76.0, 34.0
];

list BGM_CLIP_START_INDEX = [
0, 5, 12, 20
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
"92e1cd1e-0958-e5ff-bbaf-49d0a5dffb2c" //23
];

//Index Constants for Incoming Parameters
integer TIME_STAMP = 0;
integer AVATAR_KEY = 1;
integer COMMAND = 2;
integer PARAMETER = 3;

//Global Variables
integer listenHandle = 0;
list tokenList = [];
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
//Visibility
integer hideHUD = FALSE;

//Encode & Decode Functions (for security)
string Xor(string data)
{
    return llXorBase64(llStringToBase64(data), llStringToBase64(XOR_KEY + (string)llGetOwner()));
}
 
string Dexor(string data) 
{
    return llBase64ToString(llXorBase64(data, llStringToBase64(XOR_KEY + (string)llGetOwner())));
}

//HUD Functions
PlayBGM()
{
	if(currentBGM != "")
	{
		playBGM = TRUE;
		ChangeBGM(currentBGM);
	}
}

ChangeBGM(string bgm)
{
    integer bgmIndex = llListFindList(BGM_LIST, [bgm]);
    
    if(bgmIndex != -1)
    {  
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
                llOwnerSay("BGM: on"); 
                
                string bgmCC = llList2String(BGM_CC, bgmIndex);    
                llOwnerSay("Current BGM: " + bgmCC);
                
                currentBGMclipIndex = 0;            
                llSetSoundQueueing(FALSE);
                llPlaySound(firstBGMclipKey, 1.0);
                llSetTimerEvent(10.0);    
            }
                     
            RefreshBGMcontrol();
        }
    }
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
    tokenList = [];
    RefreshHUD();
}

RefreshBGMcontrol()
{
	if(!hideHUD)
	{
		string bgmPrompt = "[Turn Off BGM]";
		
		if(!playBGM)
		{
			bgmPrompt = "[Turn On BGM]";      
		}     

		string bgmDisplay = "No BGM Currently Playing";
		
		if(currentBGM != "")
		{
			bgmDisplay = currentBGMdisplay;
		}
		
		llSetLinkPrimitiveParamsFast(BGM_CONTROL_LINK_NUMBER, [
			PRIM_TEXT, bgmDisplay + "\n" + bgmPrompt, <1.0, 1.0, 1.0>, 1.0]);          
	}		
}

RefreshHUD()
{   
    llSetLinkPrimitiveParamsFast(LINK_SET, [
        PRIM_COLOR, HUD_FRONT_FACE, <1.0, 1.0, 1.0>, (float)(!hideHUD),
        PRIM_TEXTURE, HUD_FRONT_FACE, TEXTURE_BLANK, <0.0, 0.0, 0.0>, <0.0, 0.0, 0.0>, 0,
        PRIM_TEXT, "", <1.0, 1.0, 1.0>, 0.0]); 

	integer count = llGetListLength(tokenList);		
	string rootText = "No Token Obtained";
	string latestTokenText = "No Latest Token";
	string visibilityText = "[Show HUD]";
	
	if(count != 0)
	{
		string latestTokenName = llList2String(tokenList, count - 1);
		integer latestVsdIndex = llListFindList(VSD_LIST, [latestTokenName]);
		rootText = "Current Token" + " (" + (string)llGetListLength(tokenList) + "/16):\n" + llDumpList2String(tokenList, "\n");
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
		}			
	}
	
	if(hideHUD)
	{
		visibilityText = "[Hide HUD]";
	}
	
	llSetLinkPrimitiveParamsFast(LATEST_TOKEN_DISPLAY_LINK_NUMBER, [
		PRIM_TEXT, latestTokenText, <1.0, 1.0, 1.0>, (float)(!hideHUD)]);	
	
	llSetLinkPrimitiveParamsFast(RESET_BUTTON_LINK_NUMBER, [
		PRIM_TEXT, "[Reset HUD]", <1.0, 1.0, 1.0>, (float)(!hideHUD)]);

	llSetLinkPrimitiveParamsFast(VISIBILITY_CONTROL_LINK_NUMBER, [
		PRIM_COLOR, HUD_FRONT_FACE, <1.0, 1.0, 1.0>, 1.0,
		PRIM_TEXT, visibilityText, <1.0, 1.0, 1.0>, 1.0]);	'

	llSetLinkPrimitiveParamsFast(LINK_ROOT, [
		PRIM_COLOR, HUD_FRONT_FACE, <1.0, 1.0, 1.0>, 1.0,
		PRIM_TEXT, rootText, <1.0,1.0,1.0>, 1.0]);		

	llSetLinkPrimitiveParamsFast(VSD_GROUP_BACKGROUND_LINK_NUMBER, [
		PRIM_TEXT, "[Teleport to VSD Hubs]", <1.0, 1.0, 1.0>, (float)(!hideHUD)]);		
	
	RefreshBGMcontrol();
}

ChangeVsdTexture(integer vsdIndex, integer linkNumber)
{
    integer column = (vsdIndex %  4);
    integer row = (vsdIndex / 4);
    float xOffset = (-3 + (column * 2))/8.0;
    float yOffset = (3 - (row * 2))/8.0;      
    
    llSetLinkPrimitiveParamsFast(linkNumber, [
    PRIM_TEXTURE, HUD_FRONT_FACE, VSD_TEXTURE, <1/4.0, 1/4.0, 1/4.0>, <xOffset, yOffset, 0.0>, 0]);
}

integer AddToken(string name)
{
    integer vsdIndex = llListFindList(VSD_LIST, [name]);
    integer itemIndex = llListFindList(tokenList, [name]);    
    
    if(vsdIndex != -1)
    {
        if(itemIndex == -1)
        {
            tokenList += name; 
            llOwnerSay("You obtained " + name + " token.");
            llTriggerSound(SOUND_OBTAIN, 1.0);
            //llSay(DEBUG_CHANNEL, llGetDisplayName(llGetOwner()) + " obtained " + name + " token.");
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

ReturnTokenList()
{
    string timeStamp = llGetTimestamp();
    key avatarKey = llGetOwner();
    string command = "RETURN_TOKEN_LIST";
    string parameter = llDumpList2String(tokenList, "##");
    
    string xorParameterList = Xor(timeStamp + "," + (string)avatarKey + "," + command + "," + parameter);
    
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
        
        string xorParameterList = Xor(timeStamp + "," + (string)avatarKey + "," + command + "," + (string)parameter);    
        llSay(SCAVENGER_OBJECT_CHANNEL, xorParameterList);         
        llOwnerSay("Token found!");          
    }
}

default
{    
    timer()
    {
        currentBGMclipIndex++;
        
        //llOwnerSay("Current: " + (string)currentBGMclipIndex);
        if(currentBGMclipIndex == currentBGMclipCount - 1)
        {
            currentBGMclipIndex = 0;
        }
        
        //llOwnerSay((string)(currentBGMclipIndex + 1) +
        //"/" + (string)currentBGMclipCount +
        //"\nPlaying: " + llList2String(currentBGMclipList, currentBGMclipIndex));
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
        RefreshHUD();
        PlayBGM();
        llListenRemove(listenHandle);          
        listenHandle = llListen(SCAVENGER_HUD_CHANNEL, "", "", "");
    }
    state_exit()
    {
        llListenRemove(listenHandle);   
    }
    
    touch_end(integer num_detected)
    {
        integer linkNumber = llDetectedLinkNumber(0);
        
        if(linkNumber > 1 & linkNumber < LAST_VSD_LINK_NUMBER & !hideHUD)
        {
            integer vsdNumber = linkNumber - 1;
            vector vsdDestination = llList2Vector(VSD_LOCATION, vsdNumber);
            
            if(vsdDestination == ZERO_VECTOR)
            {
                vsdDestination = VSD_DEFAULT_LOCATION;           
            }

            llMapDestination(VSD_SIM_NAME, vsdDestination, ZERO_VECTOR);                
        }
        else if(linkNumber == RESET_BUTTON_LINK_NUMBER & !hideHUD)
        {
            llResetScript();
        }
        else if(linkNumber == BGM_CONTROL_LINK_NUMBER & !hideHUD)
        {    
            if(playBGM)
            {
                StopBGM();
            }
            else
            {
                PlayBGM();   
            }
        }
		else if(linkNumber == VISIBILITY_CONTROL_LINK_NUMBER)
		{
			if(hideHUD)
			{
				hideHUD = FALSE;
			}
			else
			{
				hideHUD = TRUE;
			}
			
			RefreshHUD();
		}
    }
    
    listen(integer channel, string name, key id, string message)
    {
        list parameterList = llParseString2List(Dexor(message), [","], [""]);
        
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
            }
        }
    }
}

state deactivated
{
    state_entry()
    {
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
            llSetTimerEvent(0.0);  
            timerCounter = 1;
            state default;            
        }
    }
}