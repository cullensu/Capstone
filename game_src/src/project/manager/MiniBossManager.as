package project.manager 
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	import org.flixel.FlxState;
	import org.flixel.FlxBasic;
	import project.constant.Constants;
	import project.env.Station;
	import project.env.Stations;
	import project.ship.AIShip;
	import project.ship.MiniBossShip;
	import project.constant.GameRegistry;
	import project.util.Affiliation;
	import project.ship.behavior.ShipBehaviorType;
	import project.util.CartesianPoint;
	import project.util.PolarPoint;
	import project.util.Utility;
	
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author jmlee337
	 */
	public class MiniBossManager extends FlxGroup
	{
		
		private var stata:FlxPoint;
		private var statb:FlxPoint;
		private var statc:FlxPoint;
		
		private var _finalBossSpawned:Boolean;
		
		public function MiniBossManager(stations:Stations) 
		{
			super();
			_finalBossSpawned = false;
			var arr:Array = stations.members;
			for (var i:int = 0; i < Constants.NUM_STATIONS; i++) {
				var point:Station = arr[i] as Station;
				var ship:MiniBossShip = new MiniBossShip(point.x, point.y, point);
				ship.affiliation = Affiliation.ENEMY;
				add(ship);
			}
		}
		
		override public function update():void
		{
			/* 
			 * Begin copypaste from FlxGroup.update()
			 */
			var basic:FlxBasic;
			var i:uint = 0;
			while(i < length)
			{
				basic = members[i++] as FlxBasic;
				if((basic != null) && basic.exists && basic.active && basic.alive)
				{
					basic.preUpdate();
					basic.update();
					basic.postUpdate();
				}
			}
			/*
			 * End copypaste
			 */
			
			var bossesDead:int = 0;
			for (var j:int = 0; j < this.length; j++) {
				var ship:MiniBossShip = members[j] as MiniBossShip;
				if (!ship.alive) 
				{
					bossesDead++;
					continue;
				}
				var cPoint:CartesianPoint = new CartesianPoint(ship.x - GameRegistry.gameState.playerManager.playerShip.x + 400,
															   ship.y - GameRegistry.gameState.playerManager.playerShip.y + 400);
				var pPoint:PolarPoint = cPoint.convertToPolar();
				if (pPoint.r < Constants.TILESIZE * 2) {
					if (!ship.activated) {
						spawn(ship);
						ship.exists = true;
					}
					//ship.exists = true;
				}
			}
			
			if (!_finalBossSpawned && bossesDead == this.length)
			{
				//spawn final boss
				var finalBoss:MiniBossShip = new MiniBossShip(Constants.TILESIZE * Constants.WORLDTILES / 2, Constants.TILESIZE * Constants.WORLDTILES / 2, null);
				finalBoss.affiliation = Affiliation.ENEMY;
				add(finalBoss);
				finalBoss.registerBehaviorType(ShipBehaviorType.BOSS_FINAL);
				finalBoss.isFinalBoss = true;
				//finalBoss.exists = true;
			}
		}
		
		private function spawn(ship:MiniBossShip):void
		{
			//TODO: Randomize miniboss behavior
			var rand:int = Utility.randomInt(4);
			//rand = 1;
			if (!ship.hasAlreadySpawned)
			{
				switch(rand)
				{
					case 0:
						ship.registerBehaviorType(ShipBehaviorType.BOSS_MINE);
						break;
					case 1:
						ship.registerBehaviorType(ShipBehaviorType.BOSS_BLINK);
						//ship.registerBehaviorType(ShipBehaviorType.BOSS_FINAL);
						break;
					case 2:
						ship.registerBehaviorType(ShipBehaviorType.BOSS_FAST);
						break;
					case 3:
						ship.registerBehaviorType(ShipBehaviorType.BOSS_SWARM);
						break;
					default:
						ship.registerBehaviorType(ShipBehaviorType.BOSS_FAST);
						break;
				}
			}
			ship.activated = true;
		}	
	}

}