package project.ship.behavior.move 
{
	import flash.geom.Point;
	import project.constant.Constants;
	import project.constant.GameRegistry;
	import project.ship.AIShip;
	import project.ship.PlayerShip;
	import project.ship.Ship;
	import project.util.CartesianPoint;
	import project.util.PolarPoint;
	/**
	 * ...
	 * @author Cullen
	 */
	public class SuicideWithTurnRadius implements IShipMovement
	{
		protected var _maxTurnRadius:Number;
		
		protected var _updateDelay:Number;
		protected var _currDelay:Number;
		
		public function SuicideWithTurnRadius(maxTurnRadius:Number) 
		{
			_maxTurnRadius = maxTurnRadius;
			_updateDelay = Constants.GAME_FRAME_RATE / 3;
			_currDelay = 0;
		}
		
		public function move(ship:AIShip):void
		{
			var player:PlayerShip = GameRegistry.gameState.playerManager.playerShip;
			var delta:CartesianPoint = new CartesianPoint(player.x - ship.x, player.y - ship.y);
			var deltaPolar:PolarPoint = delta.convertToPolar();
			
			var currVel:CartesianPoint = new CartesianPoint(ship.velocity.x, ship.velocity.y);
			var polarVel:PolarPoint = currVel.convertToPolar();
			//Prevents the ship from being stuck with 0 speed and not moving
			polarVel.r = polarVel.r + 0.1;
			var dist:Number = delta.length;
			if (_currDelay <= 0)
			{
				_currDelay = _updateDelay;
				if (polarVel.theta < deltaPolar.theta)
				{
					if (deltaPolar.theta - polarVel.theta > Math.PI)
					{
						if (polarVel.theta - deltaPolar.theta - 2 * Math.PI < _maxTurnRadius)
						{
							polarVel.theta = deltaPolar.theta;
						}
						else
						{
							polarVel.rotate( -1 * _maxTurnRadius);
						}
					}
					else
					{
						if (deltaPolar.theta - polarVel.theta < _maxTurnRadius)
						{
							polarVel.theta = deltaPolar.theta;
						}
						else
						{
							polarVel.rotate(_maxTurnRadius);
						}
					}
				}
				else if (polarVel.theta > deltaPolar.theta)
				{
					if (polarVel.theta - deltaPolar.theta > Math.PI)
					{
						if (deltaPolar.theta - polarVel.theta + 2 * Math.PI < _maxTurnRadius)
						{
							polarVel.theta = deltaPolar.theta;
						}
						else
						{
							polarVel.rotate(_maxTurnRadius);
						}
					}
					else
					{
						if (polarVel.theta - deltaPolar.theta < _maxTurnRadius)
						{
							polarVel.theta = deltaPolar.theta;
						}
						else
						{
							polarVel.rotate( -1 * _maxTurnRadius);
						}
					}
				}
			}
			
			_currDelay = _currDelay - 1;
			
			var vel:CartesianPoint = polarVel.convertToCartesianPoint();
			vel.normalize(ship.speed);
			ship.velocity.copyFromFlash(vel);
		}
		
	}

}