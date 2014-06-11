
string TOKEN_NAME = "Freedom from Bias"; //VSD Value (Pick valid value from VSD_LIST below if this is not a decoy)
string ENERGY_NAME = "Solar";
string NPC_NAME = "Red";
string  RIGHT_CHOICE_DIALOGUE = "Great choice! Solar energy is the best in my opinion. How did you read my mind?";

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
        /*llSay(0, 
        "Solar: " + llDumpList2String(itemAcollectors, ",") + 
        "\nHydro: " + llDumpList2String(itemBcollectors, ",") + 
        "\nWind: " + llDumpList2String(itemCcollectors, ",") + 
        "\nThermal: " + llDumpList2String(itemDcollectors, ","));
        */

        key avatarKey = llDetectedKey(0);
        integer indexA = llListFindList(itemAcollectors, [avatarKey]); //Solar
        integer indexB = llListFindList(itemBcollectors, [avatarKey]); //Hydro
        integer indexC = llListFindList(itemCcollectors, [avatarKey]); //Wind
        integer indexD = llListFindList(itemDcollectors, [avatarKey]); //Thermal
        string energy = ENERGY_NAME;
        
        if(indexA != -1) //Change here
        {
            llSay(0, RIGHT_CHOICE_DIALOGUE);     
            llShout(FFB_GAME_CHANNEL, (string)avatarKey + SEPERATOR + "FEEDBACK" + SEPERATOR + energy);  
            llShout(FFB_GAME_CHANNEL, (string)avatarKey + SEPERATOR + "GIVE_TOKEN" + SEPERATOR + (string)avatarKey);                 
        }
        else 
        {
            if(indexB != -1 | indexC != -1 | indexD != -1) //Change here
            {
                if(indexB != -1) //Change here
                {  
                    energy = "Solar";
                }
                else if(indexC != -1) //Change here
                {
                    energy = "Wind"; 
                }
                else if(indexD != -1) //Change here
                {
                    energy = "Thermal";
                }
                
                 llSay(0, "Why did you give me " + energy + " energy, " + llGetDisplayName(avatarKey)+ "? I would prefer " + ENERGY_NAME + " energy, which is much better.");     
                llShout(FFB_GAME_CHANNEL, (string)avatarKey + SEPERATOR + "FEEDBACK" + SEPERATOR + energy);   
                llShout(FFB_GAME_CHANNEL, (string)avatarKey + SEPERATOR + "GIVE_TOKEN" + SEPERATOR + (string)avatarKey);                  
            }
            else //No energy collected
            {
                llSay(0, "Please find and collect the energy that you believe to be best before talking to me. " +  llGetDisplayName(avatarKey));      
            }
        } 
    }
    
    listen(integer channel, string name, key id, string message)
    {
        list parameters = llParseString2List(message, [SEPERATOR], [""]);
        key avatarKey = (key)llList2String(parameters, 0);
        string command = llList2String(parameters, 1);
        string commandParameter = llList2String(parameters, 2);
        
        //llSay(0, message);
        
        if(command == "ADD_ENERGY")
        {
            itemAcollectors = ListItemDelete(itemAcollectors, avatarKey);
            itemBcollectors = ListItemDelete(itemBcollectors, avatarKey);
            itemCcollectors = ListItemDelete(itemCcollectors, avatarKey);
            itemDcollectors = ListItemDelete(itemDcollectors, avatarKey);
            
            if(commandParameter == "Solar")
            { 
                itemAcollectors = itemAcollectors + avatarKey;
            }
            else if(commandParameter == "Hydro")
            {
                itemBcollectors = itemBcollectors + avatarKey;           
            }
            else if(commandParameter == "Wind")
            {
                itemCcollectors = itemCcollectors + avatarKey;           
            }    
            else if(commandParameter == "Thermal")
            {
                itemDcollectors = itemDcollectors + avatarKey;         
            }                
        }
        else if(command == "FEEDBACK")
        {
            if(commandParameter == ENERGY_NAME)
            {
                llWhisper(0, "Nice choice! " + llGetDisplayName(avatarKey) + ", " + ENERGY_NAME + " energy is the best in my opinion.");
            }
            else
            {
                llWhisper(0, "Why did you pick that " + llGetDisplayName(avatarKey) + "? I would prefer " + ENERGY_NAME + " energy, which is much better.");
            }
        }
    }    
}