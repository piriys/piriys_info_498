float RAISE_HEIGHT = 5.5;
float DELAY_TIME = 5.0; //Inactive time in seconds
/*^Make Changes to above numbers^*/

vector startPosition = ZERO_VECTOR;
integer up = FALSE;

default
{
    state_entry()
    {
        llSetStatus(STATUS_ROTATE_X|STATUS_ROTATE_Y|STATUS_ROTATE_Z, FALSE);
        startPosition = llGetPos();
        llSetTimerEvent(0.0);   
    }

    touch(integer total_number)
    {   
        llSetStatus(STATUS_PHYSICS, TRUE);            
        if(!up & startPosition != ZERO_VECTOR)
        {
            llMoveToTarget(startPosition + <0,0, RAISE_HEIGHT>, 1.5); 
            up = TRUE;  
            llSleep(DELAY_TIME);                 
        }
        else
        {                 
            llMoveToTarget(startPosition, 1.5);
            up = FALSE;  
            llSleep(DELAY_TIME);                                
        }
    }
}
