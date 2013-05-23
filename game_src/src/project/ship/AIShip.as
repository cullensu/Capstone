package project.ship 
{
	import org.flixel.FlxG;
	import project.bullet.BulletType;
	import project.constant.GameRegistry;
	import project.ship.behavior.move.Suicide;
	import project.ship.behavior.ShipBehavior;
	import project.ship.behavior.ShipBehaviorType;
	import project.ship.behavior.shoot.RandomShot;
	import project.upgrade.drops.DropType;
	import project.upgrade.guns.OffsetGun;
	import project.constant.GameRegistry;
	import project.constant.Constants;
	import project.upgrade.GunUpgrade;
	import project.util.CartesianPoint;
	import project.util.ICollidable;
	import project.util.PolarPoint;
	/**
	 * ...
	 * @author Cullen
	 */
	public class AIShip extends Ship
	{
		[Embed(source = "../../../assets/enemynormal.png")] protected var _shipPng:Class
		[Embed(source = "../../../assets/sfx/EnemyHurt.mp3")] protected var _hurtmp3:Class
		
		//Should remain invisible to outside classes
		protected var _behavior:ShipBehavior;
		
		//This is what outside classes should interact with
		protected var _behaviorType:ShipBehaviorType;
		
		protected var _hasLifetime:Boolean;
		protected var _lifetime:Number;
		
		public function AIShip(X:Number=0,Y:Number=0,SimpleGraphic:Class=null) 
		{
			super(X, Y, SimpleGraphic);
			
			loadGraphic(_shipPng, false, false, 30, 28);
			_hasLifetime = false;
			_lifetime = 10;
			
			exists = false;
		}
		
		override public function collide(other:ICollidable):void
		{
			FlxG.play(_hurtmp3);
			super.collide(other);
			if (health <= 0)
			{
				kill();
				GameRegistry.gameState.upgradeManager.createRandomDrop(this.x, this.y);
			}
			
			if (other is Ship)
			{
				this.kill();
			}
		}
		
		override public function preUpdate():void
		{
			super.preUpdate();
		}
		
		override public function kill():void
		{
			removeAllGunUpgrades();
			super.kill();
		}
		
		override public function update():void
		{
			_behavior.movement.move(this);
			_behavior.shooting.shoot(this);
			super.update();
			checkDespawn();
			if (_hasLifetime)
			{
				_lifetime = _lifetime - FlxG.elapsed;
				if (_lifetime < 0)
				{
					kill();
				}
			}
		}
		
		protected function checkDespawn():void
		{
			var cPoint:CartesianPoint = new CartesianPoint(x - GameRegistry.gameState.playerManager.playerShip.x,
														   y - GameRegistry.gameState.playerManager.playerShip.y);
			var pPoint:PolarPoint = cPoint.convertToPolar();
			if (pPoint.r > Constants.TILESIZE + 80)
			{
				kill();
			}
		}
		
		
		/**
		 * Uses this ShipBehavior for this ship, clones all guns, and treats all other properties
		 * of the ShipBehavior as Read-Only, loads the appropriate graphic as well
		 * @param	value
		 */
		public function registerBehaviorType(value:ShipBehaviorType):void 
		{
			_behaviorType = value;
			_behavior = GameRegistry.gameState.shipBehaviorFactory.getShipBehavior(_behaviorType);
			
			_affiliation = _behavior.affiliation;
			loadGraphic(_behavior.shipGraphic, false, false, _behavior.shipGraphicDimensions.x, _behavior.shipGraphicDimensions.y);
			
			_maxHealth = _behavior.maxHealth;
			health = _maxHealth;
			_speed = _behavior.speed;
			_collisionDamage = _behavior.collisionDamage;
			
			_hasLifetime = _behavior.hasLifeTime;
			_lifetime = _behavior.lifetime;
			
			removeAllGunUpgrades();
			for each(var gun:GunUpgrade in _behavior.guns)
			{
				var clone:GunUpgrade = gun.getClone();
				addGunUpgrade(clone);
			}
		}
		
		public function get behaviorType():ShipBehaviorType 
		{
			return _behaviorType;
		}
		
	}

}