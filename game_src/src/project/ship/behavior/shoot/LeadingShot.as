package project.ship.behavior.shoot 
{
	import org.flixel.FlxPoint;
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
		protected static const NO_VELOCITY:FlxPoint = new FlxPoint(0, 0);
		protected var _playerLastX:Number;
		protected var _playerLastY:Number;
		protected var _playerLastV:FlxPoint;
		
		public function LeadingShot() 
		{
			
		}
		
		public function shoot(ship:AIShip):void
		{
			var playerShip:PlayerShip = GameRegistry.gameState.playerManager.playerShip;
			if (!playerShip.activeCloak) {
				_playerLastX = playerShip.x;
				_playerLastY = playerShip.y;
				_playerLastV = playerShip.velocity;
			} else {
				_playerLastV = NO_VELOCITY;
			}
			//This is a crude estimate of where to aim the shot, takes the player's location .5 second in the future as the target
			var playerFutureLoc:CartesianPoint = new CartesianPoint(_playerLastX + _playerLastV.x / 2, 
				_playerLastY + _playerLastV.y / 2);
			ship.fire(playerFutureLoc.x, playerFutureLoc.y);
		}
		
	}

}