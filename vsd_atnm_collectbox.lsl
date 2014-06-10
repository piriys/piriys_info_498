
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

list ListItemDelete(list li,string element) {
    integer placeinlist = llListFindList(li, [element]);
    if (placeinlist != -1)
        return llDeleteSubList(li, placeinlist, placeinlist);
    return li;
}

default
{
    state_entry()
    {
        llListenRemove(listenHandle);
        listenHandle = llListen(ATNM_GAME_CHANNEL, "", "", "");        
    }
    
    touch_end(integer num_detected)
    {
        key avatarKey = llDetectedKey(0);
        
        llSay(0, "Overloading barrier...");
        
        if(llListFindList(itemAcollectors, [avatarKey]) != -1 &
        llListFindList(itemBcollectors, [avatarKey]) != -1 &
        llListFindList(itemCcollectors, [avatarKey]) != -1 &
        llListFindList(itemDcollectors, [avatarKey]) != -1 &
        llListFindList(itemEcollectors, [avatarKey]) != -1)
        {  
            llSay(ATNM_GAME_CHANNEL, "BARRIER_OFF");
            
            itemAcollectors = ListItemDelete(itemAcollectors, (string)avatarKey);
            itemBcollectors = ListItemDelete(itemBcollectors, (string)avatarKey);    
            itemCcollectors = ListItemDelete(itemCcollectors, (string)avatarKey);
            itemDcollectors = ListItemDelete(itemDcollectors, (string)avatarKey);    
            itemEcollectors = ListItemDelete(itemEcollectors, (string)avatarKey);                
        } 
		else
		{
			llSay(0, "Not enough energy to overload barrier, collect more forks!");
		}
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
            

        }
    }    
}