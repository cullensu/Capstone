package project.ship.behavior.move 
{
	import flash.geom.Point;
	import flash.globalization.NumberFormatter;
	import project.ship.AIShip;
	import project.util.CartesianPoint;
	import project.util.PolarPoint;
	import project.util.Utility;
	/**
	 * ...
	 * @author Cullen
	 */
	public class TeleportingBoss extends CircleAround
	{
		protected static const TELEPORT_DISTANCE:Number = 100;
		protected static const DISTANCE_VARIANCE:Number = 25;
		protected static const TELEPORT_COOLDOWN:Number = 60;
		protected static const COOLDOWN_VARIANCE:Number = 15;
		
		protected static const TELEPORT_ANGLE_VARIANCE:Number = Math.PI / 6;
		
		protected var _currentCooldown:Number;
		
		public function TeleportingBoss(targetRadius:Number) 
		{
			super(targetRadius);
			_currentCooldown = TELEPORT_COOLDOWN;
		}
		
		override public function move(ship:AIShip):void
		{
			super.move(ship);
			_currentCooldown = _currentCooldown - 1;
			if (_currentCooldown <= 0)
			{
				var variance:Number = Utility.randomInt(COOLDOWN_VARIANCE * 2) - COOLDOWN_VARIANCE;
				_currentCooldown = TELEPORT_COOLDOWN + variance;
				
				var distanceVariance:Number = Utility.randomInt(DISTANCE_VARIANCE * 2) - DISTANCE_VARIANCE;
				var distance:Number = TELEPORT_DISTANCE - distanceVariance;
				
				var vel:CartesianPoint = new CartesianPoint(0, 0);
				ship.velocity.copyToFlash(vel);
				
				var polarVel:PolarPoint = vel.convertToPolar();
				var rotation:Number = Utility.randomInt(TELEPORT_ANGLE_VARIANCE * 2) - TELEPORT_ANGLE_VARIANCE;
				polarVel.rotate(rotation);
				
				var teleportVel:CartesianPoint = polarVel.convertToCartesianPoint();
				
				teleportVel.normalize(distance);
				
				ship.x = ship.x + teleportVel.x;
				ship.y = ship.y + teleportVel.y;
			}
		}
		
	}

}