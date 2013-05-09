package project.ship 
{
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
	import project.util.ICollidable;
	/**
	 * ...
	 * @author Cullen
	 */
	public class AIShip extends Ship
	{
		[Embed(source = "../../../assets/enemynormal.png")] private var _shipPng:Class
		
		//Should remain invisible to outside classes
		private var _behavior:ShipBehavior;
		
		//This is what outside classes should interact with
		protected var _behaviorType:ShipBehaviorType;
		
		public function AIShip(X:Number=0,Y:Number=0,SimpleGraphic:Class=null) 
		{
			super(X, Y, SimpleGraphic);
			
			loadGraphic(_shipPng, false, false, 30, 28);
			
			_collisionDamage = 75;
			
			exists = false;
		}
		
		override public function collide(other:ICollidable):void
		{
			super.collide(other);
			if (health <= 0)
			{
				kill();
				GameRegistry.gameState.upgradeManager.createDrop(DropType.OXYGEN, this.x, this.y);
			}
			
			if (other is Ship)
			{
				this.kill();
			}
		}
		
		override public function preUpdate():void
		{
			super.preUpdate();
			_behavior.movement.move(this);
			_behavior.shooting.shoot(this);
		}
		
		override public function kill():void
		{
			super.kill();
		}
		
		override public function update():void
		{
			super.update();
			if (Math.abs(x - GameRegistry.gameState.playerManager.playerShip.x) > Constants.TILESIZE ||
				Math.abs(y - GameRegistry.gameState.playerManager.playerShip.y) > Constants.TILESIZE)
			{
				exists = false;
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
			
			loadGraphic(_behavior.shipGraphic, false, false, _behavior.shipGraphicDimensions.x, _behavior.shipGraphicDimensions.y);
			
			_maxHealth = _behavior.maxHealth;
			health = _maxHealth;
			_speed = _behavior.speed;
			
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