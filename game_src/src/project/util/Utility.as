package project.util 
{
	import flash.geom.Point;
	import org.flixel.FlxU;
	import org.flixel.FlxG;
	
	/**
	 * ...
	 * @author jmlee337
	 */
	public class Utility 
	{
		public function Utility() { }
				
		public static function random():Number 
		{
			return FlxG.random();
		}
		
		public static function randomInt(n:int):int
		{
			return Math.floor(random() * n);
		}
		
		public static function randomUnit():int
		{
			return random() < 0.5 ? -1 : 1;
		}
		
		public static function randomAngle():Number
		{
			return random() * 2 * Math.PI;
		}
		
	}

}