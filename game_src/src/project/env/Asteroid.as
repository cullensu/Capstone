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
		
		public function Asteroid(x:int, y:int) 
		{
			super(x, y);
			loadGraphic(_asteroidFull);
		}
		
	}

}