package project.env 
{
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Cullen
	 */
	public class Asteroid extends FlxSprite
	{
		[Embed(source = "../../../assets/asteroidfull.png")] private var _asteroidFull:Class;
		[Embed(source = "../../../assets/asteroidhalf.png")] private var _asteroidHalf:Class;
		[Embed(source = "../../../assets/asteroidquarter.png")] private var _asteroidQuarter:Class;
		
		public static const FULL_HEALTH:Number = 20;
		public static const HALF_HEALTH:Number = FULL_HEALTH / 2;
		public static const QUARTER_HEALTH:Number = FULL_HEALTH / 4;
		
		public function Asteroid(x:int, y:int, level:int, velX:Number = 0, velY:Number = 0) 
		{
			super(x, y);
			switch(level) {
				case 1:
					loadGraphic(_asteroidFull);
					health = FULL_HEALTH;
					break;
				case 2:
					loadGraphic(_asteroidHalf);
					health = HALF_HEALTH;
					break;
				case 3:
					loadGraphic(_asteroidQuarter);
					health = QUARTER_HEALTH;
					break;
			}
		}
		
	}

}