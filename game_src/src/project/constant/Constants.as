package project.constant 
{
	import org.flixel.FlxCamera;
	/**
	 * ...
	 * @author Cullen
	 */
	public class Constants 
	{
		public static const LOGGING_SERVER:String = "http://www.cs.washington.edu/education/courses/cse481d/13sp/c481d-d/www/logging/logger.php"

		public static const GAME_FRAME_RATE:int = 60;
		public static const FLASH_FRAME_RATE:int = 60;
		
		public static const CAMERA_STYLE:uint = FlxCamera.STYLE_LOCKON;
		
		//Scoring Constants
		public static const SCORE_PER_SECOND:int = 10;
		public static const SCORE_PER_HIT:int = 10;
		public static const SCORE_PER_PICKUP:int = 50;
		public static const SCORE_PER_ENEMY_DESTROYED:int = 50;
		public static const SCORE_PER_MINIBOSS_DESTROYED:int = 500;
		public static const SCORE_FOR_FINAL_BOSS:int = 5000;

		//Worldsize constants
		public static const WORLDTILES:int = 40;
		public static const TILESIZE:int = 800;
		public static const MAX_COORD:int = WORLDTILES * TILESIZE;
		
		//Manager constants
		public static const MAX_BULLETS:int = 100;
		
		public static const MAX_AI_SHIPS:int = 30;
		
		//Bullet constants
		public static const BULLET_PLAYER_SMALL_SPEED:Number = 1000;
		public static const BULLET_PLAYER_BIG_SPEED:Number = 1000;
		public static const BULLET_SMALL_SPEED:Number = 750;
		public static const BULLET_BIG_SPEED:Number = 550;
		
		//Player Starting Values
		public static const STARTING_HEALTH_DRAIN_RATE:Number = 1;
		public static const OXYGEN_MAX:Number = 60;
		public static const STARTING_MOVE_SPEED:Number = 350;
		public static const STARTING_PLAYER_GUN_COOLDOWN:Number = 0.35;
		
		//Player Ship Drop Upgrade Constants
		public static const MAX_UPGRADES_ON_SCREEN:int = 10;
		public static const DROP_UPGRADE_LIFETIME:Number = 15;
		public static const STARTING_BONUS_COOLDOWN:Number = 100;
		public static const MAX_BONUS_COOLDOWN:Number = 150;
		public static const BONUS_COOLDOWN_PER_UPGRADE:Number = 5;
		public static const STARTING_BONUS_DAMAGE:Number = 0;
		public static const MAX_BONUS_DAMAGE:Number = 20;
		public static const BONUS_DAMAGE_PER_UPGRADE:Number = 2;
		public static const STARTING_BONUS_MOVE_SPEED:Number = 0;
		public static const MAX_BONUS_MOVE_SPEED:Number = 100;
		public static const BONUS_MOVE_SPEED_PER_UPGRADE:Number = 10;
		public static const OXYGEN_ADD:Number = 12;
		
		//Enemy spawning constants
		private static const TICK:Number = 10;
		private static const MULT2:Number = 2;
		private static const MULT3:Number = 6;
		public static const THRESHOLD_L1:Number = 5;
		public static const THRESHOLD_H1:Number = THRESHOLD_L1 + TICK;
		public static const TICK1:Number = .65;
		public static const THRESHOLD_L2:Number = THRESHOLD_L1 * MULT2;
		public static const THRESHOLD_H2:Number = THRESHOLD_H1 * MULT2;
		public static const TICK2:Number = TICK1 * MULT2;
		public static const THRESHOLD_L3:Number = THRESHOLD_L1 * MULT3;
		public static const THRESHOLD_H3:Number = THRESHOLD_H1 * MULT3;
		public static const TICK3:Number = TICK1 * MULT3;
		
		//Station constants
		public static const NUM_STATIONS:Number = 3;
		
		//HUD constants
		public static const TICK_TIME:int = 10;
		public static const STATION_DIST:Number = TILESIZE * 10;
		
		// Upgrade Constants
		public static const MAXIMUM_CHARGE:int = 10000;
		public static const CLOAK_CHARGE_RATE:int = 10;
		public static const CLOAK_USE_RATE:int = 20;
		public static const SHIELD_CHARGE_RATE:int = 10;
		public static const SHIELD_USE_RATE:int = 20;
		public static const BLINK_CHARGE_RATE:int = 10;
		public static const BLINK_USE_RATE:int = 0;
		
		public function Constants() 
		{
			
		}
		
	}

}