package project.manager 
{
	import org.flixel.FlxGroup;
	import project.ship.PlayerShip;
	/**
	 * ...
	 * @author Cullen
	 */
	public class PlayerManager extends FlxGroup
	{
		protected var _playerShip:PlayerShip;
		
		public function PlayerManager() 
		{
			super();
			_playerShip = new PlayerShip(300, 300, null);
			
			add(_playerShip);
		}
		
		public function get playerShip():PlayerShip 
		{
			return _playerShip;
		}
	}

}