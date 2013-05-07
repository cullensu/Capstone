package project.util 
{
	import flash.geom.Point;
	import org.flixel.FlxU;
	
	/**
	 * ...
	 * @author jmlee337
	 */
	public class Utility 
	{
		private static var seed:Number;
		private static var seedSet:Boolean = false;
		public function Utility() { }
		
		public static function setSeed(n:Number):void
		{
			if (seedSet) {
				throw new Error("Random seed already set");
			}
			seedSet = true;
			seed = n;
		}
		
		public static function random():Number 
		{
			if (!seedSet) {
				throw new Error("Random seed has not been set");
			}
			seed = FlxU.srand(seed);
			return seed;
		}
		
		public static function randomInt(n:int):int
		{
			return Math.floor(random() * n);
		}
		
	}

}