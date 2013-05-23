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
		
		public function TargetShot() 
		{
			
		}
		
		public function shoot(ship:AIShip):void
		{
			var playerShip:PlayerShip = GameRegistry.gameState.playerManager.playerShip;
			ship.fire(playerShip.x + playerShip.width / 2, playerShip.y + playerShip.height / 2);
		}
		
	}

}