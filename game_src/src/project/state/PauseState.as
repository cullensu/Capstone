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
	public class PauseState extends FlxState
	{
		
		public function PauseState() 
		{
			var resumeButton:FlxButtonPlus = new FlxButtonPlus(100, 100, resumeGame, null, "Resume Game");
			add(resumeButton);
		}
		
		override public function create():void
		{
			FlxG.mouse.show();
		}
		
		private function resumeGame():void
		{
			FlxG.switchState(GameRegistry.gameState);
		}
		
	}

}