//Object Settings
string TOKEN_NAME = "Privacy";    
//Global Constants
integer SCAVENGER_HUD_CHANNEL = -498; 
integer SCAVENGER_OBJECT_CHANNEL = 498;
string XOR_KEY = "husky498uw!";
    
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
        listenHandle = llListen(SCAVENGER_OBJECT_CHANNEL, "", "", "");
    }
    
    touch_end(integer num_detected)
    {
        string timeStamp = llGetTimestamp();
        key avatarKey = llDetectedKey(0);
        string command = "ADD_TOKEN";
        string parameter = TOKEN_NAME;
        
        string xorParameterList = Xor(timeStamp + "," + (string)avatarKey + "," + command + "," + parameter, XOR_KEY + (string)avatarKey);
        
        llSay(SCAVENGER_HUD_CHANNEL, xorParameterList);
    }
}
    