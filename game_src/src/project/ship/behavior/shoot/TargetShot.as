package project.ship.behavior.shoot 
{
	import project.constant.GameRegistry;
	import project.ship.AIShip;
	import project.ship.PlayerShip;
	import project.util.CartesianPoint;
	import project.util.PolarPoint;
	import project.util.Utility;
	/**
	 * ...
	 * @author Cullen
	 */
	public class TargetShot implements IShipShoot
	{
		protected var _playerLastX:Number;
		protected var _playerLastY:Number;
		
		public function TargetShot() 
		{
			
		}
		
		public function shoot(ship:AIShip):void
		{
			var playerShip:PlayerShip = GameRegistry.gameState.playerManager.playerShip;
			if (!playerShip.activeCloak) {
				_playerLastX = playerShip.x;
				_playerLastY = playerShip.y;
			}
			ship.fire(_playerLastX + playerShip.width / 2, _playerLastY + playerShip.height / 2);
		}
		
	}

}