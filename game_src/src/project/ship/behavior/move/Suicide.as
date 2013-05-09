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
		public function Suicide() 
		{
			
		}
		
		public function move(ship:AIShip):void
		{
			var player:PlayerShip = GameRegistry.gameState.playerManager.playerShip;
			var vel:CartesianPoint = new CartesianPoint(player.x - ship.x, player.y - ship.y);
			vel.normalize(ship.speed);
			ship.velocity.copyFromFlash(vel);
		}
		
	}

}