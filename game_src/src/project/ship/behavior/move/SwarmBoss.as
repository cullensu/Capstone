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
		
		protected var _spawnDelay:Number;
		protected var _spawnDelayVariance:Number;
		protected var _currentCooldown:Number;
		protected var _spawnType:ShipBehaviorType;
		
		public function SwarmBoss(targetRadius:Number) 
		{
			super(targetRadius);
			_currentCooldown = SPAWN_DELAY;
			_spawnType = ShipBehaviorType.ENEMY_NORMAL_NO_UPGRADES;
			_spawnDelay = SPAWN_DELAY;
			_spawnDelayVariance = SPAWN_DELAY_VARIANCE;
		}
		
		override public function move(ship:AIShip):void
		{
			super.move(ship);
			_currentCooldown = _currentCooldown - FlxG.elapsed;
			if (_currentCooldown <= 0)
			{
				GameRegistry.gameState.aiManager.createShip(_spawnType, ship.x + ship.width / 2, ship.y + ship.height / 2, ship.affiliation);
				_currentCooldown = _spawnDelay + Utility.random() * 2 * _spawnDelayVariance - _spawnDelayVariance;
			}
		}
		
		public function get spawnType():ShipBehaviorType 
		{
			return _spawnType;
		}
		
		public function set spawnType(value:ShipBehaviorType):void 
		{
			_spawnType = value;
		}
		
		public function get spawnDelay():Number 
		{
			return _spawnDelay;
		}
		
		public function set spawnDelay(value:Number):void 
		{
			_spawnDelay = value;
		}
		
		public function get spawnDelayVariance():Number 
		{
			return _spawnDelayVariance;
		}
		
		public function set spawnDelayVariance(value:Number):void 
		{
			_spawnDelayVariance = value;
		}
		
	}

}