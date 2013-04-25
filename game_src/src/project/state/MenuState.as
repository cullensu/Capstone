package project.state 
{
	import org.flixel.FlxG;
	import org.flixel.FlxState;
	import org.flixel.plugin.photonstorm.FlxButtonPlus;
	import project.constant.GameRegistry;
	/**
	 * ...
	 * @author Cullen
	 */
	public class MenuState extends FlxState
	{
		
		public function MenuState() 
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
			FlxG.switchState(GameRegistry.gameState);
		}
	}

}