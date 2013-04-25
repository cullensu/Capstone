package project.util 
{
	import org.flixel.FlxU;
	
	/**
	 * ...
	 * @author jmlee337
	 */
	public class Utility 
	{
		private static var seed:Number = 0.4;
		public function Utility() { }
		
		public static function random():Number {
			seed = FlxU.srand(seed);
			return seed;
		}
		
	}

}