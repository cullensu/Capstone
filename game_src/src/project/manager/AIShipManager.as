package project.manager 
{
	import org.flixel.FlxBasic;
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
	import project.util.CartesianPoint;
	import project.util.PolarPoint;
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
				
				s.x = xLoc;
				s.y = yLoc;
				s.affiliation = aff;
				
				s.registerBehaviorType(behaviorType);
				
				s.alive = true;
				s.exists = true;
			}
		}
		
		private function spawn():void
		{
			var rand:int = Utility.randomInt(1);
			var behaviorType:ShipBehaviorType;
			if (rand == 0) {
				behaviorType = ShipBehaviorType.ENEMY_FAST;
				GameRegistry.gameState.addLevel(4);
			} else if (rand == 1) {
				behaviorType = ShipBehaviorType.ENEMY_BIG;
				GameRegistry.gameState.addLevel(5);
			} else {
				behaviorType = ShipBehaviorType.ENEMY_NORMAL;
				GameRegistry.gameState.addLevel(3);
			}
			var pPoint:PolarPoint = new PolarPoint(Constants.TILESIZE, Utility.randomAngle());
			var cPoint:CartesianPoint = pPoint.convertToCartesianPoint();
			createShip(behaviorType,
					   GameRegistry.gameState.playerManager.playerShip.x + cPoint.x,
					   GameRegistry.gameState.playerManager.playerShip.y + cPoint.y,
					   Affiliation.ENEMY);
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