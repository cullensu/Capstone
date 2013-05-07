package project.manager 
{
	import org.flixel.FlxGroup;
	import project.bullet.BulletType;
	import project.constant.Constants;
	import project.ship.AIShip;
	import project.ship.behavior.move.Suicide;
	import project.ship.behavior.ShipBehavior;
	import project.ship.behavior.shoot.RandomShot;
	import project.upgrade.guns.OffsetGun;
	import project.upgrade.GunUpgrade;
	import project.constant.GameRegistry;
	import project.util.Utility;
	/**
	 * ...
	 * @author Cullen
	 */
	public class AIShipManager extends FlxGroup
	{
		protected var _behavior:ShipBehavior;
		protected var _guns:Vector.<GunUpgrade>;
		protected var _levelThresholdH:Number;
		protected var _levelThresholdL:Number;
		
		public function AIShipManager() 
		{
			super();
			
			_behavior = new ShipBehavior();
			_behavior.shooting = new RandomShot();
			_behavior.movement = new Suicide();
			
			var gun1:OffsetGun = new OffsetGun();
			gun1.angleOffset = 0;
			gun1.bulletType = BulletType.CIRCLE;
			var gun2:OffsetGun = new OffsetGun();
			gun2.angleOffset = Math.PI / 6;
			gun2.bulletType = BulletType.SQUARE;
			var gun3:OffsetGun = new OffsetGun();
			gun3.angleOffset = -1 * Math.PI / 6;
			gun3.bulletType = BulletType.TRIANGLE;
			
			_guns = new Vector.<GunUpgrade>();
			_guns.push(gun3);
			
			for (var i:int = 0; i < Constants.MAX_AI_SHIPS; i++)
			{
				add(new AIShip());
			}
		}
		
		public function createShip(behavior:ShipBehavior, guns:Vector.<GunUpgrade>, xLoc:Number, yLoc:Number):void
		{
			if (this.getFirstAvailable() != null)
			{
				var s:AIShip = (getFirstAvailable() as AIShip);
				s.behavior = behavior;
				s.removeAllGunUpgrades();
				s.x = xLoc;
				s.y = yLoc;
				for each(var gun:GunUpgrade in guns)
				{
					s.addGunUpgrade(gun);
				}
				s.exists = true;
			}
		}
		
		public function canTick():Boolean
		{
			return getFirstExtant() == null;
		}
		
		private function spawn():void
		{
			createShip(_behavior,
					   _guns,
					   GameRegistry.gameState.playerManager.playerShip.x + Constants.TILESIZE * Utility.randomUnit(),
					   GameRegistry.gameState.playerManager.playerShip.y + Constants.TILESIZE * Utility.randomUnit());
			GameRegistry.gameState.addLevel(3);
		}
		
		override public function update():void
		{
			super.update();
			if (GameRegistry.gameState.canSpawn) {
				spawn();
			}
		}
		
	}

}