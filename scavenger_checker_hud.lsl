/*
Piriya Saengsuwarn
This work is licensed under a Creative Commons Attribution-NonCommercial 4.0 International License.
http://creativecommons.org/licenses/by-nc/4.0/
*/

/*Global Constants*/
string SEPERATOR = "|||";
integer SCAVENGER_HUD_CHANNEL = -498; 
integer SCAVENGER_OBJECT_CHANNEL = 498;
string XOR_KEY = "husky498uw!";
    
/*Index Constants for Incoming Parameters*/
integer TIME_STAMP = 0;
integer ID = 1;
integer COMMAND = 2;
integer PARAMETER = 3;

/*Global Variables*/
integer listenHandle = 0;

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
        llVolumeDetect(TRUE);
        llListenRemove(listenHandle);          
        listenHandle = llListen(SCAVENGER_OBJECT_CHANNEL, "", "", "");
    }
    
    collision_start(integer num_detected)
    {
        string timeStamp = llGetTimestamp();
        string avatarKey = llDetectedKey(0);
        string command = "CHECK_HUD";
        string parameter = llDetectedKey(0);
        
        string xorParameterList = Xor(timeStamp + SEPERATOR + avatarKey + SEPERATOR + command + SEPERATOR + parameter, XOR_KEY + avatarKey);
        
        llSay(SCAVENGER_HUD_CHANNEL, xorParameterList);    
    }
}