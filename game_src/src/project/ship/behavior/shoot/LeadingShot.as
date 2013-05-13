package project.ship.behavior.shoot 
{
	import project.constant.Constants;
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
	public class LeadingShot implements IShipShoot
	{
		
		public function LeadingShot() 
		{
			
		}
		
		public function shoot(ship:AIShip):void
		{
			var playerShip:PlayerShip = GameRegistry.gameState.playerManager.playerShip;
			//This is a crude estimate of where to aim the shot, takes the player's location 1 second in the future as the target
			var playerFutureLoc:CartesianPoint = new CartesianPoint(playerShip.x + playerShip.velocity.x, 
				playerShip.y + playerShip.velocity.y);
			ship.fire(playerFutureLoc.x, playerFutureLoc.y);
		}
		
	}

}