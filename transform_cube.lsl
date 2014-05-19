integer INTERNAL_DIALOG_CHANNEL = 9999;
integer INTERNAL_TEXTBOX_CHANNEL = -9999;
integer SYNC_CHANNEL = 9998;
integer TOTAL_PRIM_COUNT = 28;
float DEFAULT_DISTANCE = 0.5;
float DEFAULT_EXPAND = 2.0;
list DIALOG_OPTIONS = ["Save", "Load", "Reset", "Expand", "SyncID"];

list savedPositionX = [];
list savedPositionY = [];
list savedPositionZ = [];

string syncID = "PUBLIC";
integer isDefaultDistance = TRUE;
integer hasPositionSaved = FALSE;
integer isLooping = FALSE;
integer syncHandle;
integer internalDialogHandle;
integer internalTextboxHandle;
integer loopNumber = 0; 

float randomFloat(float min, float max)
{
    return llFrand(max - min) + min;
}

RandomCubeColor()
{
    float colorR = randomFloat(0.0,1.0);
    float colorG = randomFloat(0.0,1.0);  
    float colorB = randomFloat(0.0,1.0);                                   
    vector color = <colorR,colorG,colorB>;  
        
    llSetLinkPrimitiveParamsFast(LINK_ALL_CHILDREN, [
    PRIM_COLOR, 0, color, 1.0,
    PRIM_COLOR, 1, color, 1.0,
    PRIM_COLOR, 3, color, 1.0]);
}

ResetCubeColor()
{     
    llSetLinkPrimitiveParamsFast(LINK_ALL_CHILDREN, [
    PRIM_COLOR, 0, <1,1,1>, 1.0,
    PRIM_COLOR, 1, <1,1,1>, 1.0,
    PRIM_COLOR, 3, <1,1,1>, 1.0]);
}

SaveCube()
{
    integer totalCount = llGetNumberOfPrims();
    integer index = 2; //Skip Root 
    savedPositionX = [];
    savedPositionY = [];
    savedPositionZ = [];
                
    for(index = 2; index <= totalCount; index++)
    {
        vector localPos = llList2Vector(llGetLinkPrimitiveParams(index, [PRIM_POS_LOCAL]), 0);
        
        savedPositionX = savedPositionX + localPos.x;
        savedPositionY = savedPositionY + localPos.y;
        savedPositionZ = savedPositionZ + localPos.z;            
    }  
    
    hasPositionSaved = TRUE;     
}

LoadCube()
{
    integer totalCount = llGetNumberOfPrims();
    integer index = 2; //Skip Root
                
    if(hasPositionSaved)
    {
        integer index = 2;
        for(index = 2; index <= totalCount; index++)
        {
            float posX = llList2Float(savedPositionX, index - 2);
            float posY = llList2Float(savedPositionY, index - 2);   
            float posZ = llList2Float(savedPositionZ, index - 2);   
            
            vector localPos = <posX,posY,posZ>;
            
            llSetLinkPrimitiveParamsFast(index, [PRIM_POS_LOCAL, localPos]);   
        }  
    }
    else
    {
        llOwnerSay("No Position Saved.");    
    }       
}

ResetCube()
{
    integer totalCount = llGetNumberOfPrims();
    integer index = 2; //Skip Root
    isDefaultDistance = TRUE;
    
    for(index = 2; index <= totalCount; index++)
    {
        integer x = ((index - 2) % 3) + 1;   
        integer y = (((index - 2) % 9) / 3) + 1 ;              
        integer z = ((index - 2) / 9) + 1;
        
        float posX = (DEFAULT_DISTANCE * (x - 1)) - DEFAULT_DISTANCE;
        float posY = (DEFAULT_DISTANCE * (y - 1)) - DEFAULT_DISTANCE;
        float posZ = (DEFAULT_DISTANCE * (z - 1)) - DEFAULT_DISTANCE;
        
        vector localPos = <posX, posY, posZ>;
        
        llSetLinkPrimitiveParamsFast(index, [PRIM_POS_LOCAL, localPos]);
        
        //llOwnerSay("index = " + (string)index + " ,x = " + (string)x + " ,y = " + (string)y + " ,z = " + (string)z);       
    }
    
    ResetCubeColor();
}

ExpandCube(float distance)
{
    integer totalCount = llGetNumberOfPrims();
    integer index = 2; //Skip Root
    isDefaultDistance = FALSE;
        
    for(index = 2; index <= totalCount; index++)
    {
        integer x = ((index - 2) % 3) + 1;   
        integer y = (((index - 2) % 9) / 3) + 1 ;              
        integer z = ((index - 2) / 9) + 1;
    
        float posX = (distance * (x - 1)) - distance;
        float posY = (distance * (y - 1)) - distance;
        float posZ = (distance * (z - 1)) - distance;
        
        vector localPos = <posX, posY, posZ>;
        
        llSetLinkPrimitiveParamsFast(index, [PRIM_POS_LOCAL, localPos]);          
    }
}

default
{
    state_entry()
    {
        //ResetCube();
        llTargetOmega(llRot2Up(llGetLocalRot()), 0 * PI/16, 1.0);
        llSetTimerEvent(0.0);
        syncID = "PUBLIC"; 
        
        llListenRemove(internalDialogHandle);
        llListenRemove(internalTextboxHandle);  
        llListenRemove(syncHandle);           
        
        syncHandle = llListen(SYNC_CHANNEL, "", "", "");   
    }

    touch_start(integer total_number)
    {
        integer linkNumber = llDetectedLinkNumber(0);
        //llOwnerSay((string)linkNumber + "/" + (string)llGetNumberOfPrims());
        
        vector localPosition = llList2Vector(llGetLinkPrimitiveParams(linkNumber, [PRIM_POS_LOCAL]), 0);

        //llOwnerSay((string)localPosition);
        if(!isLooping)
        {
            llDialog(llGetOwner(), "Select Command:", DIALOG_OPTIONS + "Start Looping", INTERNAL_DIALOG_CHANNEL);
        }
        else
        {
            llDialog(llGetOwner(), "Select Command:", DIALOG_OPTIONS + "Stop Looping", INTERNAL_DIALOG_CHANNEL);            
        }
        
        internalDialogHandle = llListen(INTERNAL_DIALOG_CHANNEL, "", llGetOwner(), "");
    }
    
    timer()
    {
        if(loopNumber == 1)
        {
            loopNumber++;            
            ExpandCube(DEFAULT_EXPAND);
        }
        else if(loopNumber == 0)
        {
            loopNumber++;            
            ResetCube();   
        }
        else if(loopNumber == 2)
        {
            loopNumber = 0;
            LoadCube();            
        }
    }
    
    listen( integer channel, string name, key id, string message )
    {   
		//llOwnerSay("SyncID: " + syncID + "\nChannel " + (string)channel + ": " + message);
		
        if(channel == INTERNAL_DIALOG_CHANNEL)
        {
            if(message == "Save")
            {
				SaveCube();
                llSay(SYNC_CHANNEL, syncID + ",Save");
            }
            else if(message == "Load")
            {
				LoadCube();
                llSay(SYNC_CHANNEL, syncID + ",Load");  
            }                
            else if(message == "Reset")
            {
				ResetCube();
                llSay(SYNC_CHANNEL, syncID + ",Reset");  
            }
            else if(message == "Expand")
            {
                ExpandCube(DEFAULT_EXPAND);  
                llSay(SYNC_CHANNEL, syncID + ",Expand");    
            }
            else if(message == "Start Looping")
            {
				isLooping = TRUE;
				llSetTimerEvent(1.5); 			
                llSay(SYNC_CHANNEL, syncID + ",Start Looping");   
            }
            else if(message == "Stop Looping")
            {
				isLooping = FALSE;   
				loopNumber = 0;         
				llSetTimerEvent(0.0);
				ResetCube();     			
                llSay(SYNC_CHANNEL, syncID + ",Stop Looping");   
            }        
            else if(message == "SyncID")
            {
                llTextBox(llGetOwner(), "SyncID: " + syncID, INTERNAL_TEXTBOX_CHANNEL);
                internalTextboxHandle = llListen(INTERNAL_TEXTBOX_CHANNEL, "", "", "");                  
            }
			llListenRemove(internalDialogHandle);			
        }
        else if(channel == INTERNAL_TEXTBOX_CHANNEL)
        {
			if(syncID != "")
			{
				syncID = message;
				llListenRemove(internalTextboxHandle);
			}
        }
        else if(channel == SYNC_CHANNEL)
        {
            list parameters = llParseString2List(message, [","], []);
            
            if(llList2String(parameters, 0) == syncID)
            {
                string command = llList2String(parameters, 1);
                
                if(command == "Save")
                {
                    SaveCube();                
                }            
                else if(command == "Load")
                {
                    LoadCube();                
                }
                else if(command == "Reset")
                {
                    ResetCube();   
                }                
                else if(command == "Expand")
                {
                    ExpandCube(DEFAULT_EXPAND);   
                }                                
                else if(command == "Start Looping")
                {
                    isLooping = TRUE;
                    llSetTimerEvent(1.5);                
                }    
                else if(command == "Stop Looping")
                {
                    isLooping = FALSE;   
                    loopNumber = 0;         
                    llSetTimerEvent(0.0);
                    ResetCube();                
                }
            }            
        }
    }    
}
