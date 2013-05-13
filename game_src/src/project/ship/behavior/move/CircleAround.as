package project.ship.behavior.move 
{
	import flash.geom.Point;
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
	public class CircleAround implements IShipMovement 
	{
		private static const EPSILON:Number = 5;
		protected var _targetRadius:Number;
		
		public function CircleAround(targetRadius:Number) 
		{
			_targetRadius = targetRadius;
		}
		
		public function move(ship:AIShip):void
		{
			var player:PlayerShip = GameRegistry.gameState.playerManager.playerShip;
			var delta:CartesianPoint = new CartesianPoint(player.x - ship.x, player.y - ship.y);
			var deltaPolar:PolarPoint = delta.convertToPolar();
			
			var dist:Number = delta.length;
			if (dist < _targetRadius - EPSILON)
			{
				//rotate 100 degreees
				deltaPolar.rotate(Math.PI / 2 + Math.PI / 4);
			}
			else if (dist > _targetRadius + EPSILON)
			{
				//rotate 80 degrees
				deltaPolar.rotate(Math.PI / 2 - Math.PI / 4);
			}
			else
			{
				//rotate 90 degress
				deltaPolar.rotate(Math.PI / 2);
			}
			
			var vel:CartesianPoint = deltaPolar.convertToCartesianPoint();
			vel.normalize(ship.speed);
			ship.velocity.copyFromFlash(vel);
		}
		
		public function get targetRadius():Number 
		{
			return _targetRadius;
		}
		
		public function set targetRadius(value:Number):void 
		{
			_targetRadius = value;
		}
		
	}

}