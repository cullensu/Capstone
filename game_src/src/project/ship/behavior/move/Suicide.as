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
		protected var _speed:Number;
		
		public function Suicide() 
		{
			_speed = 300;
		}
		
		public function move(ship:AIShip):void
		{
			var player:PlayerShip = GameRegistry.gameState.playerManager.playerShip;
			var vel:CartesianPoint = new CartesianPoint(player.x - ship.x, player.y - ship.y);
			vel.normalize(_speed);
			ship.velocity.copyFromFlash(vel);
		}
		
	}

}