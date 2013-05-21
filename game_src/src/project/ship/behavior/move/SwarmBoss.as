package project.ship.behavior.move 
{
	import flash.geom.Point;
	import flash.globalization.NumberFormatter;
	import org.flixel.FlxG;
	import project.constant.GameRegistry;
	import project.ship.AIShip;
	import project.ship.behavior.ShipBehaviorType;
	import project.util.CartesianPoint;
	import project.util.PolarPoint;
	import project.util.Utility;
	/**
	 * ...
	 * @author Cullen
	 */
	public class SwarmBoss extends CircleAround
	{
		protected static const SPAWN_DELAY:Number = 2.5;
		protected static const SPAWN_DELAY_VARIANCE:Number = 1.0;
		
		protected var _currentCooldown:Number;
		
		public function SwarmBoss(targetRadius:Number) 
		{
			super(targetRadius);
			_currentCooldown = SPAWN_DELAY;
		}
		
		override public function move(ship:AIShip):void
		{
			super.move(ship);
			_currentCooldown = _currentCooldown - FlxG.elapsed;
			if (_currentCooldown <= 0)
			{
				GameRegistry.gameState.aiManager.createShip(ShipBehaviorType.ENEMY_NORMAL, ship.x, ship.y, ship.affiliation);
				_currentCooldown = SPAWN_DELAY + Utility.random() * 2 * SPAWN_DELAY_VARIANCE - SPAWN_DELAY_VARIANCE;
			}
		}
		
	}

}