package project.hud 
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	import org.flixel.plugin.photonstorm.FlxBar;
	import project.constant.GameRegistry;
	import project.ship.PlayerShip;
	import project.state.GameState;
	/**
	 * ...
	 * @author Cullen
	 */
	public class HUD extends FlxGroup
	{
		protected var _playerHealthBar:FlxBar;
		
		public function HUD(state:GameState) 
		{
			super();
			
			var ship:PlayerShip = state.playerManager.playerShip;
			_playerHealthBar = new FlxBar(350, 0, FlxBar.FILL_LEFT_TO_RIGHT, 100, 10, ship, "health", 0, ship.health, false);
			add(_playerHealthBar);
			_playerHealthBar.scrollFactor = new FlxPoint(0, 0);
		}
		
		
		override public function update():void
		{
			super.update();
		}
	}

}