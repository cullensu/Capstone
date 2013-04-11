package proj
{
	import proj.Ship;
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author akirilov
	 */
	public class PlayerShip extends Ship
	{
		
		public function PlayerShip() 
		{
			super();
		}
		
		override public function kill():void
		{
			super.kill();
			FlxG.switchState(new MainMenuState());
		}
	}

}