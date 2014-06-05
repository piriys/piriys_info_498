string ENERGY_NAME = "Solar"; /*<-- Change this*/

integer FFB_GAME_CHANNEL = 49811;

default
{
	touch_end(integer num_detected)
	{
		key avatarKey = llDetectedKey(0);
		llShout(FFB_GAME_CHANNEL, (string)avatarKey + "," + ENERGY_NAME));
	}
}