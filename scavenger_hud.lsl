//Global Constants
integer SCAVENGER_HUD_CHANNEL = -498; 
integer SCAVENGER_OBJECT_CHANNEL = 498;
string XOR_KEY = "husky498uw!";
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
    tokenList = [];
}

RefreshHUD()
{
    integer index = 0;
    integer count = llGetListLength(tokenList);
    
    if(count != 0)
    {
        for(index = 0; index < count; index++)
        {
            
        }
        
        llSetText("Current Token:\n" + llDumpList2String(tokenList, "\n"), <1.0,1.0,1.0>, 1.0);
    }
    else
    {
        llSetText("No Token Obtained", <1.0,1.0,1.0>, 1.0);        
    }
}

AddToken(string name)
{
    integer vsdIndex = llListFindList(VSD_LIST, [name]);
    integer itemIndex = llListFindList(tokenList, [name]);    
    
    if(vsdIndex != -1)
    {
        if(itemIndex == -1)
        {
            tokenList += name; 
            llOwnerSay("You obtained " + name + " token.");
            llSay(DEBUG_CHANNEL, llGetDisplayName(llGetOwner()) + " obtained " + name + " token.");
        }
        else
        {
            llOwnerSay("You already have" + name + " token.");            
        }
    }
    
    RefreshHUD();
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

default
{
    state_entry()
    {
        RefreshHUD();
        llListenRemove(listenHandle);
        listenHandle = llListen(SCAVENGER_HUD_CHANNEL, "", "", "");
    }
    
    listen(integer channel, string name, key id, string message)
    {
        list parameterList = llParseString2List(Dexor(message), [","], [""]);
        
        llSay(0, message);
        llOwnerSay(Dexor(message));
        
        if(llGetListLength(parameterList) == 4)
        {
            llOwnerSay("Correct Parameter.");
            string timeStamp = llList2Key(parameterList, TIME_STAMP);        
            key avatarKey = llList2Key(parameterList, AVATAR_KEY);
            string command = llList2String(parameterList, COMMAND);
            string parameter = llList2String(parameterList, PARAMETER);
            
            if(avatarKey == llGetOwner())
            {
                if(command == "ADD_TOKEN")
                {
                    AddToken(parameter);
                }
                else if(command == "REMOVE_TOKEN")
                {
                    RemoveToken(parameter);
                }
                else if(command == "REQUEST_SCORE")
                {
                    GetTokenList();
                }
            }
        }
    }
}

