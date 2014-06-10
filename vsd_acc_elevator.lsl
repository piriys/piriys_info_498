integer ACC_GAME_CHANNEL = 49805;
string SEPERATOR = "|||";
float RAISE_HEIGHT = 5.5;
float RAISE_TIME = 5.0;
float DELAY_TIME = 5.0; //Inactive time in seconds
/*^Make Changes to above numbers^*/

vector startPosition = ZERO_VECTOR;
integer up = FALSE;

list itemAcollectors = [];
list itemBcollectors = [];
list itemCcollectors = [];

integer listenHandle = 0;

MoveElevator()
{
    if(up)
    {
        llMoveToTarget(startPosition + <0,0, RAISE_HEIGHT>, 1.5);          
    }
    else
    {
        llMoveToTarget(startPosition, 1.5);    
    }
}

default
{
    state_entry()
    {
        llListenRemove(listenHandle);
        listenHandle = llListen(ACC_GAME_CHANNEL, "", "", "");      
        llSetStatus(STATUS_ROTATE_X|STATUS_ROTATE_Y|STATUS_ROTATE_Z, FALSE);
        startPosition = llGetPos();
        llSetTimerEvent(0.0);   
    }

    touch_end(integer total_number)
    {   
        key avatarKey = llDetectedKey(0);
        if(llListFindList(itemAcollectors, [avatarKey]) != -1 &
        llListFindList(itemBcollectors, [avatarKey]) != -1 &
        llListFindList(itemCcollectors, [avatarKey]) != -1)
        {  
            llSetStatus(STATUS_PHYSICS, TRUE);            
            if(!up & startPosition != ZERO_VECTOR)
            {
                up = TRUE; 
                MoveElevator();
                llSetTimerEvent(RAISE_TIME);
            }
            else
            {                 
                up = FALSE;  
                MoveElevator();
                llSetTimerEvent(0.0);            
            }     
        } 
        else
        {
            llSay(0, "Please learn more about this value by stepping on all 3 plates before proceeding upstairs!");
        }    
    }
    
    timer()
    {
        up = FALSE;  
        MoveElevator();        
    }
    
    listen(integer channel, string name, key id, string message)
    {
        list parameters = llParseString2List(message, [SEPERATOR], [""]);
        key avatarKey = (key)llList2String(parameters, 0);
        string command = llList2String(parameters, 1);
        string commandParameter = llList2String(parameters, 2);
        
        if(command == "ADD_STEPPER")
        {
            llSay(0, llKey2Name(avatarKey) + " activated switch " + commandParameter + ".");
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
            
            /*llSay(0, "A: " + llDumpList2String(itemAcollectors, ",") +
            "\nB: " + llDumpList2String(itemBcollectors, ",") + 
            "\nC: " + llDumpList2String(itemCcollectors, ","));*/                              
        }
    }  
}

