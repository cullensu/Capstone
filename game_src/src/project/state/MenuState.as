package project.state 
{
	import org.flixel.FlxButton;
	import org.flixel.FlxG;
	import org.flixel.FlxState;
	import org.flixel.plugin.photonstorm.FlxButtonPlus;
	import project.constant.Constants;
	import project.constant.GameRegistry;
	import project.replay.InputText;
	import project.replay.ReplayHandler;
	/**
	 * ...
	 * @author Cullen
	 */
	public class MenuState extends FlxState
	{
		
		public function MenuState() 
		{
			var newGame:FlxButton = new FlxButton(100, 100, "New Game", startGame);
			add(newGame);

			if (FlxG.debug)
			{
				var replayEntry:InputText = new InputText(100, 125, "Replay Game", startReplay);
				add(replayEntry);
			}
		}
		
		private function startReplay(id:String):void 
		{
			GameRegistry.doReplay = true;
			ReplayHandler.downloadRecording(id, Constants.LOGGING_SERVER);
		}
		
		override public function create():void
		{
			FlxG.mouse.show();
		}
		
		private function startGame():void
		{
			FlxG.switchState(new GameState());
		}
	}

}