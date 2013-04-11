package  
{
	import org.flixel.FlxGame;
	/**
	 * ...
	 * @author Cullen
	 */
	public class Game extends FlxGame
	{
		[SWF(width="800", height="600", backgroundColor="#000000")]
		[Frame(factoryClass = "Preloader")]
		
		public function Game() 
		{
			super(800, 600, MainMenuState);
		}
	}

}