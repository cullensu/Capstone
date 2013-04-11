package  
{
	import org.flixel.FlxG;
	import org.flixel.FlxState;
	import org.flixel.FlxButton;
	import org.flixel.plugin.photonstorm.FlxButtonPlus;
	/**
	 * ...
	 * @author akirilov
	 */
	public class MainMenuState extends FlxState
	{
		private var game:GameState = new GameState();
		
		public function MainMenuState() 
		{
			var newGame:FlxButtonPlus = new FlxButtonPlus(100, 100, startGame, null, "New Game");
			add(newGame);
		}
		
		override public function create():void
		{
			FlxG.mouse.show();
		}
		
		private function startGame():void
		{
			FlxG.switchState(game);
		}
	}
}