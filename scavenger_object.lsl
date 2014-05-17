//Object Settings
string TOKEN_NAME = "Courtesy";    
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

//Encode & Decode Functions (for security)
string Xor(string data, string xorKey)
{
     return llXorBase64(llStringToBase64(data), xorKey);
}
 
string Dexor(string data, string xorKey) 
{
     return llBase64ToString(llXorBase64(data,  xorKey));
}

default
{
    state_entry()
    {
        llListenRemove(listenHandle);
        listenHandle = llListen(SCAVENGER_OBJECT_CHANNEL, "", "", "");
    }
    
    touch_end(integer num_detected)
    {
        string timeStamp = llGetTimestamp();
        key avatarKey = llDetectedKey(0);
        string command = "ADD_TOKEN";
        string parameter = TOKEN_NAME;
        
        string xorParameterList = Xor(timeStamp + "," + (string)avatarKey + "," + command + "," + parameter, (string)avatarKey + XOR_KEY);
        
        llSay(SCAVENGER_HUD_CHANNEL, xorParameterList);
    }
}
    