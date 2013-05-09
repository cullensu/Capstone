package project.manager 
{
	import org.flixel.FlxGroup;
	import project.bullet.BulletType;
	import project.constant.Constants;
	import project.ship.AIShip;
	import project.ship.behavior.move.Suicide;
	import project.ship.behavior.ShipBehavior;
	import project.ship.behavior.ShipBehaviorType;
	import project.ship.behavior.shoot.RandomShot;
	import project.upgrade.guns.OffsetGun;
	import project.upgrade.GunUpgrade;
	import project.constant.GameRegistry;
	import project.util.Utility;
	import project.util.Affiliation;
	/**
	 * ...
	 * @author Cullen
	 */
	public class AIShipManager extends FlxGroup
	{
		protected var _guns:Vector.<GunUpgrade>;
		protected var _levelThresholdH:Number;
		protected var _levelThresholdL:Number;
		
		public function AIShipManager() 
		{
			super();
			for (var i:int = 0; i < Constants.MAX_AI_SHIPS; i++)
			{
				add(new AIShip());
			}
		}
		
		public function createShip(behaviorType:ShipBehaviorType, xLoc:Number, yLoc:Number, aff:Affiliation):void
		{
			if (this.getFirstAvailable() != null)
			{
				var s:AIShip = (getFirstAvailable() as AIShip);
				s.registerBehaviorType(behaviorType);
				
				s.x = xLoc;
				s.y = yLoc;
				s.affiliation = aff;
				
				s.exists = true;
			}
		}
		
		public function canTick():Boolean
		{
			return getFirstExtant() == null;
		}
		
		private function spawn():void
		{
			var rand:int = Utility.randomInt(2);
			var behaviorType:ShipBehaviorType = rand == 0 ? ShipBehaviorType.ENEMY_NORMAL : ShipBehaviorType.ENEMY_FAST;
			createShip(behaviorType,
					   GameRegistry.gameState.playerManager.playerShip.x + Constants.TILESIZE * Utility.randomUnit(),
					   GameRegistry.gameState.playerManager.playerShip.y + Constants.TILESIZE * Utility.randomUnit(),
					   Affiliation.ENEMY);
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