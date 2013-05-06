package project.ship 
{
	import project.bullet.BulletType;
	import project.ship.behavior.move.Suicide;
	import project.ship.behavior.ShipBehavior;
	import project.ship.behavior.shoot.RandomShot;
	import project.upgrade.guns.OffsetGun;
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
			
			_behavior = new ShipBehavior();
			_behavior.shooting = new RandomShot();
			_behavior.movement = new Suicide();
			
			exists = false;
		}
		
		override public function preUpdate():void
		{
			super.preUpdate();
			_behavior.movement.move(this);
			_behavior.shooting.shoot(this);
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