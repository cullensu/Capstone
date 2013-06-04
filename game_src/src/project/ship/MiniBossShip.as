package project.ship 
{
	import project.env.Station;
	import project.ship.behavior.ShipBehaviorType;
	import project.util.ICollidable;
	import org.flixel.FlxG
	import project.constant.Constants;
	import project.util.CartesianPoint;
	import project.util.PolarPoint;
	import project.constant.GameRegistry;
	/**
	 * ...
	 * @author jmlee337
	 */
	public class MiniBossShip extends AIShip
	{
		
		public var activated:Boolean;
		private var _station:Station;
		
		protected var _hasAlreadySpawned:Boolean;
		protected var _isFinalBoss:Boolean;
		
		public function MiniBossShip(x:Number, y:Number, station:Station) 
		{
			super(x, y);
			_station = station;
			activated = false;
		}
		
		override public function registerBehaviorType(value:ShipBehaviorType):void
		{
			super.registerBehaviorType(value);
			_hasAlreadySpawned = true;
		}
		
		override public function collide(other:ICollidable):void
		{
			FlxG.play(_hurtmp3);
			if (!canCollide(other)) return;
			this.health = this.health - other.collisionDamage;
			if (this.health <= 0) {
				kill();
				if (!isFinalBoss)
				{
					_station.activated = true;
					GameRegistry.score = GameRegistry.score + Constants.SCORE_PER_MINIBOSS_DESTROYED;
				}
				else
				{
					GameRegistry.score = GameRegistry.score + Constants.SCORE_FOR_FINAL_BOSS;
				}
			}
		}
		
		override protected function checkDespawn():void
		{
			if (!isFinalBoss)
			{
				var cPoint:CartesianPoint = new CartesianPoint(x - GameRegistry.gameState.playerManager.playerShip.x,
															   y - GameRegistry.gameState.playerManager.playerShip.y);
				var pPoint:PolarPoint = cPoint.convertToPolar();
				if (pPoint.r > Constants.TILESIZE * 2.5) {
					this.exists = false;
					this.health = _maxHealth;
					this.x = _station.x;
					this.y = _station.y;
					this.activated = false;
				}
				
				cPoint = new CartesianPoint(x - _station.x, y - _station.y);
				pPoint = cPoint.convertToPolar();
				if (pPoint.r > Constants.TILESIZE * 5) {
					this.exists = false;
					this.health = _maxHealth;
					this.x = _station.x;
					this.y = _station.y;
					this.activated = false;
				}
			}
		}
		
		public function get hasAlreadySpawned():Boolean 
		{
			return _hasAlreadySpawned;
		}
		
		public function get isFinalBoss():Boolean 
		{
			return _isFinalBoss;
		}
		
		public function set isFinalBoss(value:Boolean):void 
		{
			_isFinalBoss = value;
		}
		
	}

}