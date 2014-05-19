//Global Constants
integer SCAVENGER_HUD_CHANNEL = -498; 
integer SCAVENGER_OBJECT_CHANNEL = 498;
string XOR_KEY = "husky498uw!";
integer HUD_FRONT_FACE = 3;
string VSD_SIM_NAME = "UW iSchool";
list VSD_LIST = 
    ["Accountability", "Autonomy", "Calmness", "Courtesy",
    "Educational", "Empirical", "Environmental Stability", "Freedom from Bias",
    "Human Welfare", "Identity", "Informed Consent", "Ownership/Property",
    "Trust", "Universal Usability", "Exceptional", "Privacy"];
list VSD_LOCATION = 
    [];
vector VSD_DEFAULT_LOCATION = <224, 230, 21>; 

//Texture and Sound UUIDs
key SOUND_OBTAIN = "93c7acbd-8201-85c4-e50d-2567507297c1";
key SOUND_DEACTIVATED = "a692d9f3-e328-7877-6c2e-18a55c87994e";
key VSD_TEXTURE = "cd582a07-ce99-6282-3de0-8678d7d732b6";

//Index Constants for Incoming Parameters
integer TIME_STAMP = 0;
integer AVATAR_KEY = 1;
integer COMMAND = 2;
integer PARAMETER = 3;

//Global Variables
integer listenHandle = 0;
list tokenList = [];
integer timerCounter = 1;

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
ResetHUD()
{
    llOwnerSay("Resetting HUD...");    
    tokenList = [];
    RefreshHUD();
}

RefreshHUD()
{
    integer index = 0;
    integer count = llGetListLength(tokenList);
    
    llSetLinkPrimitiveParamsFast(LINK_ALL_CHILDREN, [
        PRIM_COLOR, HUD_FRONT_FACE, <1.0,1.0,1.0>, 1.0,
        PRIM_TEXTURE, HUD_FRONT_FACE, TEXTURE_BLANK, <0.0, 0.0, 0.0>, <0.0, 0.0, 0.0>, 0]);    

    if(count != 0)
    {
        for(index = 0; index < count; index++)
        {
            string tokenName = llList2String(tokenList, index);
            integer vsdIndex = llListFindList(VSD_LIST, [tokenName]);
            
            if(vsdIndex != -1)
            {
                integer column = (vsdIndex %  4);
                integer row = (vsdIndex / 4);
                float xOffset = (-3 + (column * 2))/8.0;
                float yOffset = (3 - (row * 2))/8.0;                
                
                llSetLinkPrimitiveParamsFast(vsdIndex + 2, [
                PRIM_TEXTURE, HUD_FRONT_FACE, VSD_TEXTURE, <1/4.0, 1/4.0, 1/4.0>, <xOffset, yOffset, 0.0>, 0]);
            }
        }
        
        llSetText("Current Token" + " (" + (string)llGetListLength(tokenList) + "/16):\n" + llDumpList2String(tokenList, "\n"), <1.0,1.0,1.0>, 1.0);
    }
    else
    {
        llSetText("No Token Obtained", <1.0,1.0,1.0>, 1.0);        
    }
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
            llPlaySound(SOUND_OBTAIN, 1.0);
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
    state_entry()
    {
        RefreshHUD();
        listenHandle = llListen(SCAVENGER_HUD_CHANNEL, "", "", "");
    }
    state_exit()
    {
        llListenRemove(listenHandle);   
    }
    
    touch_end(integer num_detected)
    {
        integer linkNumber = llDetectedLinkNumber(0);
        
        if(linkNumber > 1)
        {
            integer vsdNumber = linkNumber - 1;
            vector vsdDestination = llList2Vector(VSD_LOCATION, vsdNumber);
            
            if(vsdDestination == ZERO_VECTOR)
            {
                vsdDestination = VSD_DEFAULT_LOCATION;           
            }

            llMapDestination(VSD_SIM_NAME, vsdDestination, ZERO_VECTOR);                
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
        llPlaySound(SOUND_DEACTIVATED, 1.0);
        llSetTimerEvent(1.0);   
    }
    
    timer()
    {
        if(timerCounter != 5)
        {
            llSetText("HUD Deactivated\nPlease Wait for\n" + (string)(5 - timerCounter) + " seconds.", <1.0,0.0,0.0>, 1.0); 
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