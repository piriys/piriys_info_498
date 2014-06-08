
string TOKEN_NAME = "Autonomy"; //VSD Value (Pick valid value from VSD_LIST below if this is not a decoy)

/*Global Constants*/
string SEPERATOR = "|||";
integer ATNM_GAME_CHANNEL = 49822;
integer SCAVENGER_HUD_CHANNEL = -498; 
integer SCAVENGER_OBJECT_CHANNEL = 498;
string XOR_KEY = "husky498uw!";
list VSD_LIST = 
    ["Accountability", "Autonomy", "Calmness", "Courtesy",
    "Educational", "Empirical", "Environmental Stability", "Freedom from Bias",
    "Human Welfare", "Identity", "Informed Consent", "Ownership/Property",
    "Trust", "Universal Usability", "Exceptional", "Privacy"];
    
/*Index Constants for Incoming Parameters*/
integer TIME_STAMP = 0;
integer ID = 1;
integer COMMAND = 2;
integer PARAMETER = 3;

/*Global Variables*/
integer listenHandle = 0;
integer timerCounter = 1;
list itemAcollectors = [];
list itemBcollectors = [];
list itemCcollectors = [];
list itemDcollectors = [];
list itemEcollectors = [];

/*Encode & Decode Functions (for security)*/
string Xor(string data, string xorKey)
{
     return llXorBase64(llStringToBase64(data), llStringToBase64(xorKey));
}
 
string Dexor(string data, string xorKey) 
{
     return llBase64ToString(llXorBase64(data, llStringToBase64(xorKey)));
}

default
{
    state_entry()
    {
        llListenRemove(listenHandle);
        listenHandle = llListen(ATNM_GAME_CHANNEL, "", "", "");        
    }
    
    listen(integer channel, string name, key id, string message)
    {
        list parameters = llParseString2List(message, [SEPERATOR], [""]);
        key avatarKey = (key)llList2String(parameters, 0);
        string command = llList2String(parameters, 1);
        string commandParameter = llList2String(parameters, 2);
        
        if(command == "ADD_FORK")
        {
            llSay(0, llKey2Name(avatarKey) + " collected fork " + commandParameter + ".");
            if(commandParameter == "A")
            {
                integer index = llListFindList(itemAcollectors, [avatarKey]);
                
                if(index == -1)
                {
                    itemAcollectors = itemAcollectors + avatarKey;
                }
            }
            else if(commandParameter == "B")
            {
                integer index = llListFindList(itemBcollectors, [avatarKey]);
                
                if(index == -1)
                {
                    itemBcollectors = itemBcollectors + avatarKey;
                }            
            }
            else if(commandParameter == "C")
            {
                integer index = llListFindList(itemCcollectors, [avatarKey]);
                
                if(index == -1)
                {
                    itemCcollectors = itemCcollectors + avatarKey;
                }                
            }        
            else if(commandParameter == "D")
            {
                integer index = llListFindList(itemDcollectors, [avatarKey]);
                
                if(index == -1)
                {
                    itemDcollectors = itemDcollectors + avatarKey;
                }            
            }
            else if(commandParameter == "E")
            {
                integer index = llListFindList(itemEcollectors, [avatarKey]);
                
                if(index == -1)
                {
                    itemEcollectors = itemEcollectors + avatarKey;
                }                
            }    
            
            if(llListFindList(itemAcollectors, [avatarKey]) != -1 &
            llListFindList(itemBcollectors, [avatarKey]) != -1 &
            llListFindList(itemCcollectors, [avatarKey]) != -1 &
            llListFindList(itemDcollectors, [avatarKey]) != -1 &
            llListFindList(itemEcollectors, [avatarKey]) != -1)
            {
                llSay(0, llKey2Name(avatarKey) + " collects all the forks and obtained Autonomy token!");
                string timeStamp = llGetTimestamp();
                key avatarKey = avatarKey;
                string command = "ADD_TOKEN";
                string parameter = TOKEN_NAME;
                
                string xorParameterList = Xor(timeStamp + SEPERATOR + (string)avatarKey + SEPERATOR + command + SEPERATOR + parameter, XOR_KEY + (string)avatarKey);
                
                llShout(SCAVENGER_HUD_CHANNEL, xorParameterList);    
            }
        }
    }    
}