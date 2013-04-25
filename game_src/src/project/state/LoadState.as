package project.state 
{
	import org.flixel.FlxG;
	import org.flixel.FlxState;
	import project.constant.GameRegistry;
	/**
	 * ...
	 * @author Cullen
	 */
	public class LoadState extends FlxState
	{
		
		public function LoadState() 
		{
			
		}
		
		override public function update():void
		{
			super.update();
			FlxG.switchState(GameRegistry.menuState);
		}
		
	}

}