
string TOKEN_NAME = "Freedom from Bias"; //VSD Value (Pick valid value from VSD_LIST below if this is not a decoy)
string NPC_NAME = "Lavender";

/*Global Constants*/
string SEPERATOR = "|||";
integer FFB_GAME_CHANNEL = 49811;
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
list itemAcollectors = []; //Solar
list itemBcollectors = []; //Hydro
list itemCcollectors = []; //Wind 
list itemDcollectors = []; //Thermal

/*Encode & Decode Functions (for security)*/
string Xor(string data, string xorKey)
{
     return llXorBase64(llStringToBase64(data), llStringToBase64(xorKey));
}
 
string Dexor(string data, string xorKey) 
{
     return llBase64ToString(llXorBase64(data, llStringToBase64(xorKey)));
}

list ListItemDelete(list li,key element) {
    integer placeinlist = llListFindList(li, [element]);
    if (placeinlist != -1)
        return llDeleteSubList(li, placeinlist, placeinlist);
    return li;
}

default
{
    state_entry()
    {
        llSetText(NPC_NAME, <1,1,1>, 1.0);
        llListenRemove(listenHandle);
        listenHandle = llListen(FFB_GAME_CHANNEL, "", "", "");        
    }
    
    touch_end(integer num_detected)
    {
 
    }
    
    listen(integer channel, string name, key id, string message)
    {
        list parameters = llParseString2List(message, [SEPERATOR], [""]);
        key avatarKey = (key)llList2String(parameters, 0);
        string command = llList2String(parameters, 1);
        string commandParameter = llList2String(parameters, 2);
        
        if(command == "GIVE_TOKEN")
        {
			string timeStamp = llGetTimestamp();
			key avatarKey = llDetectedKey(0);
			string command = "ADD_TOKEN";
			string parameter = TOKEN_NAME;
			
			string xorParameterList = Xor(timeStamp + SEPERATOR + (string)avatarKey + SEPERATOR + command + SEPERATOR + parameter, XOR_KEY + (string)avatarKey);
			
			llSay(SCAVENGER_HUD_CHANNEL, xorParameterList);			
        }
    }    
}