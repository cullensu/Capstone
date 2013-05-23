package project.ship.behavior.move 
{
	import flash.geom.Point;
	import project.constant.GameRegistry;
	import project.ship.AIShip;
	import project.ship.PlayerShip;
	import project.ship.Ship;
	import project.util.CartesianPoint;
	import project.util.PolarPoint;
	import project.util.Utility;
	/**
	 * ...
	 * @author Cullen
	 */
	public class CircleAround implements IShipMovement 
	{
		private static const EPSILON:Number = 5;
		private static const REVERSE_DELAY:Number = 3.0;
		private static const REVERSE_DELAY_VARIANCE:Number = 2.5;
		
		protected var _clockwise:Boolean;
		protected var _randomlyReverse:Boolean;
		protected var _targetRadius:Number;
		
		public function CircleAround(targetRadius:Number) 
		{
			_targetRadius = targetRadius;
			_randomlyReverse = false;
			_clockwise = true;
		}
		
		public function move(ship:AIShip):void
		{
			var player:PlayerShip = GameRegistry.gameState.playerManager.playerShip;
			var delta:CartesianPoint = new CartesianPoint(player.x - ship.x - ship.width / 2, player.y - ship.y - ship.height / 2);
			var deltaPolar:PolarPoint = delta.convertToPolar();
			
			var dist:Number = delta.length;
			
			if (_randomlyReverse)
			{
				var rand:int = Utility.randomInt(100);
				if (rand == 0)
				{
					_clockwise = !_clockwise;
				}
			}
			
			if (_clockwise)
			{
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
			}
			else
			{
				if (dist < _targetRadius - EPSILON)
				{
					//rotate -100 degreees
					deltaPolar.rotate(-(Math.PI / 2 + Math.PI / 4));
				}
				else if (dist > _targetRadius + EPSILON)
				{
					//rotate -80 degrees
					deltaPolar.rotate(-(Math.PI / 2 - Math.PI / 4));
				}
				else
				{
					//rotate -90 degress
					deltaPolar.rotate(-Math.PI / 2);
				}
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
		
		public function get randomlyReverse():Boolean 
		{
			return _randomlyReverse;
		}
		
		public function set randomlyReverse(value:Boolean):void 
		{
			_randomlyReverse = value;
		}
		
	}

}