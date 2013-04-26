package project.manager 
{
	import org.flixel.FlxGroup;
	import project.ship.PlayerShip;
	import project.constant.Constants;
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
			_playerShip = new PlayerShip(Constants.TILESIZE * Constants.WORLDTILES / 2, Constants.TILESIZE * Constants.WORLDTILES / 2, null);
			
			add(_playerShip);
		}
		
		public function get playerShip():PlayerShip 
		{
			return _playerShip;
		}
	}

}