// Doc: touch on, touch off
float TIMEOUT = 90.0;
integer isOn = FALSE;
 
// update the appearence of the prim
update() {
    if (isOn) {
        llSetColor(<1,1,1>, ALL_SIDES);
    } else {
        llSetColor(<0,0,0>, ALL_SIDES);
    }
}
 
default {
    on_rez(integer p) {
        llResetScript();
    }
 
    state_entry() {
		llSetTimerEvent(0.0);	
        isOn = FALSE;
        update();
    }
 
    touch_end(integer p) {
        isOn = ! isOn;
 
        string s;
        if (isOn) { 
			s = "on";
			llSetTimerEvent(TIMEOUT);
		} else { 
			s = "off"; 
			llSetTimerEvent(0.0);
		}
        llSay(0, llDetectedName(0)+" turned the light " + s);
 
        update();
    }
	
	timer() {
		if(isOn) {
			isOn = FALSE;
			update();
			llSetTimerEvent(0.0);
		}
	}
}