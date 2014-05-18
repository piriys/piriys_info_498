//Global Constants
integer SCAVENGER_HUD_CHANNEL = -498; 
integer SCAVENGER_OBJECT_CHANNEL = 498;
string XOR_KEY = "husky498uw!";
integer HUD_FRONT_FACE = 3;
list VSD_LIST = 
    ["Accountability", "Autonomy", "Calmness", "Courtesy",
    "Educational", "Empirical", "Environmental Stability", "Freedom from Bias",
    "Human Welfare", "Identity", "Informed Consent", "Ownership/Property",
    "Trust", "Universal Usability", "Exceptional", "Privacy"];

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
    
    llSetLinkPrimitiveParamsFast(LINK_SET, [PRIM_COLOR, HUD_FRONT_FACE, <1.0,1.0,1.0>, 1.0]);    

    if(count != 0)
    {
        for(index = 0; index < count; index++)
        {
            string tokenName = llList2String(tokenList, index);
            integer vsdIndex = llListFindList(VSD_LIST, [tokenName]);
            
            if(vsdIndex != -1)
            {
                llSetLinkPrimitiveParamsFast(vsdIndex + 1, [PRIM_COLOR, HUD_FRONT_FACE, <1.000, 0.502, 0.000>, 1.0]);
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

GetTokenList()
{
    string timeStamp = llGetTimestamp();
    key avatarKey = llGetOwner();
    string command = "RETURN_TOKEN_LIST";
    string parameter = llDumpList2String(tokenList, "##");
    
    string xorParameterList = Xor(timeStamp + "," + (string)avatarKey + "," + command + "," + parameter);
    
    llSay(SCAVENGER_OBJECT_CHANNEL, xorParameterList);
}

GetTokenCheck(string name)
{
    string timeStamp = llGetTimestamp();
    key avatarKey = llGetOwner();
    string command = "RETURN_TOKEN_CHECK";
    string parameter = (string)llListFindList(tokenList, [name]);
    
    string xorParameterList = Xor(timeStamp + "," + (string)avatarKey + "," + command + "," + parameter);
    
    llSay(SCAVENGER_OBJECT_CHANNEL, xorParameterList);    
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
                    GetTokenList();
                }
                else if(command == "REQUEST_TOKEN_CHECK")
                {
                    GetTokenCheck(parameter);    
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