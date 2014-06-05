/*v### Scavenger Checker Settings - Make Changes Below ###v*/
string PROMPT_TEXT = "Courtesy Token Award"; //Hover text
string TOKEN_NAME = "Courtesy"; //VSD Value (Pick valid value from VSD_LIST below)
string AWARD_NAME = "Courtesy Award"; //Award name in this object inventory
/*^### Scavenger Checker Settings - Make Changes Above ###^*/

/*Global Constants*/
string SEPERATOR = "|||";
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
        llSetText(PROMPT_TEXT, <1.0, 1.0, 1.0>, 1.0);        
        llListenRemove(listenHandle);
        listenHandle = llListen(SCAVENGER_OBJECT_CHANNEL, "", "", "");      
    }
    
    touch_end(integer num_detected)
    {
        string timeStamp = llGetTimestamp();
        key avatarKey = llDetectedKey(0);
        string command = "REQUEST_TOKEN_CHECK";
        string parameter = TOKEN_NAME;
        
        string xorParameterList = Xor(timeStamp + SEPERATOR + (string)avatarKey + SEPERATOR + command + SEPERATOR + parameter, XOR_KEY + (string)avatarKey);
        
        llSay(SCAVENGER_HUD_CHANNEL, xorParameterList);
    }
    
    listen(integer channel, string name, key id, string message)
    {
        list parameterList = llParseString2List(Dexor(message, XOR_KEY + (string)llGetOwnerKey(id)), [SEPERATOR], [""]);
        
        //For Debugging
        //llOwnerSay(Dexor(message, XOR_KEY + (string)llGetOwnerKey(id)));
        
        if(llGetListLength(parameterList) == 4)
        {
            //For Debugging
            //llOwnerSay("Correct Parameter.");
            
            string timeStamp = llList2Key(parameterList, TIME_STAMP);        
            string avatarKey = llList2String(parameterList, ID);
            string command = llList2String(parameterList, COMMAND);
            string parameter = llList2String(parameterList, PARAMETER);
            
            if(command == "RETURN_TOKEN_CHECK" & parameter == TOKEN_NAME)
            {
                llGiveInventory(avatarKey, AWARD_NAME);
                llSay(PUBLIC_CHANNEL, "Congratulations! You claimed your award with your " + TOKEN_NAME + " token.");
            }
        }
    }    
}
