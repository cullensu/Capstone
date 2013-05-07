package project.ship 
{
	import project.bullet.BulletType;
	import project.ship.behavior.move.Suicide;
	import project.ship.behavior.ShipBehavior;
	import project.ship.behavior.shoot.RandomShot;
	import project.upgrade.guns.OffsetGun;
	import project.constant.GameRegistry;
	import project.constant.Constants;
	import project.util.ICollidable;
	/**
	 * ...
	 * @author Cullen
	 */
	public class AIShip extends Ship
	{
		[Embed(source = "../../../assets/enemynormal.png")] private var _shipPng:Class
		protected var _behavior:ShipBehavior;
		
		public function AIShip(X:Number=0,Y:Number=0,SimpleGraphic:Class=null) 
		{
			super(X, Y, SimpleGraphic);
			
			loadGraphic(_shipPng, false, false, 30, 28);
			
			_collisionDamage = 75;
			_maxHealth = 30;
			_behavior = new ShipBehavior();
			_behavior.shooting = new RandomShot();
			_behavior.movement = new Suicide();
			
			exists = false;
		}
		
		override public function collide(other:ICollidable):void
		{
			super.collide(other);
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
		
		override public function update():void
		{
			super.update();
			if (Math.abs(x - GameRegistry.gameState.playerManager.playerShip.x) > Constants.TILESIZE ||
				Math.abs(y - GameRegistry.gameState.playerManager.playerShip.y) > Constants.TILESIZE)
			{
				exists = false;
			}
		}
		
		public function get behavior():ShipBehavior 
		{
			return _behavior;
		}
		
		public function set behavior(value:ShipBehavior):void 
		{
			_behavior = value;
		}
		
	}

}