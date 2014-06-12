/*v### NPC Settings - Make Changes Below ###v*/
string TRIGGER_ID = "Patrol Guard"; //NPC Name
/*^### NPC Settings - Make Changes Above ###^*/

/*Global Constants*/
string SEPERATOR = "|||";
integer SCAVENGER_HUD_CHANNEL = -498; 
integer SCAVENGER_OBJECT_CHANNEL = 498;
string XOR_KEY = "husky498uw!";

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
    
    }
    
    link_message(integer source, integer num, string str, key id)
    {
        if(str == "A")
        {
        
        }
        else if(str == "B")
        {
        
        }
        else if(str == "C")
        {
            string timeStamp = llGetTimestamp();
            string avatarKey = (string)id;
            string command = "NPC_TALK";
            string parameter = TRIGGER_ID + "***" + "Wrong authorization, you may not pass.";        
            
            string xorParameterList = Xor(timeStamp + SEPERATOR + avatarKey + SEPERATOR + command + SEPERATOR + parameter, XOR_KEY + avatarKey);        
    
            llSay(SCAVENGER_HUD_CHANNEL, xorParameterList);  
        }
    }    
}