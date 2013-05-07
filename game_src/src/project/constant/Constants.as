package project.constant 
{
	/**
	 * ...
	 * @author Cullen
	 */
	public class Constants 
	{
		
		public static const WORLDTILES:int = 16;
		public static const TILESIZE:int = 800;
		public static const MAX_COORD:int = WORLDTILES * TILESIZE;
		
		public static const MAX_BULLETS:int = 100;
		
		public static const MAX_AI_SHIPS:int = 30;
		
		private static const TICK:Number = 5;
		private static const MULT2:Number = 2;
		private static const MULT3:Number = 6;
		public static const THRESHOLD_L1:Number = 5;
		public static const THRESHOLD_H1:Number = THRESHOLD_L1 + TICK;
		public static const TICK1:Number = 1;
		public static const THRESHOLD_L2:Number = THRESHOLD_L1 * MULT2;
		public static const THRESHOLD_H2:Number = THRESHOLD_H1 * MULT2;
		public static const TICK2:Number = TICK1 * MULT2;
		public static const THRESHOLD_L3:Number = THRESHOLD_L1 * MULT3;
		public static const THRESHOLD_H3:Number = THRESHOLD_H1 * MULT3;
		public static const TICK3:Number = TICK1 * MULT3;
		
		public function Constants() 
		{
			
		}
		
	}

}