package project.ship.behavior.move 
{
	import flash.geom.Point;
	import project.constant.GameRegistry;
	import project.ship.AIShip;
	import project.ship.PlayerShip;
	import project.ship.Ship;
	import project.util.CartesianPoint;
	/**
	 * ...
	 * @author Cullen
	 */
	public class Suicide implements IShipMovement
	{
		protected var _playerLastX:Number;
		protected var _playerLastY:Number;
		public function Suicide() 
		{
			
		}
		
		public function move(ship:AIShip):void
		{
			// Update target location only if player is visible
			if (!player.activeCloak) {
				_playerLastX = player.x;
				_playerLastY = player.y;
			}
			var player:PlayerShip = GameRegistry.gameState.playerManager.playerShip;
			var vel:CartesianPoint = new CartesianPoint(_playerLastX - ship.x, _playerLastY - ship.y);
			vel.normalize(ship.speed);
			ship.velocity.copyFromFlash(vel);
		}
		
	}

}