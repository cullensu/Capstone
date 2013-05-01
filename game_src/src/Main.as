package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import org.flixel.FlxG;
	import org.flixel.FlxGame;
	import project.constant.GameRegistry;
	import project.state.LoadState;

	/**
	 * ...
	 * @author Cullen
	 */
	[Frame(factoryClass="Preloader")]
	public class Main extends FlxGame 
	{

		[SWF(width="800", height="600", backgroundColor="#000000")]
		[Frame(factoryClass = "Preloader")]
		
		public function Main() 
		{
			FlxG.debug = true;
			super(800, 600, LoadState);
		}

	}

}