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
	import project.ship.behavior.ShipBehavior;
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
		public var bossesDefeated:int;
		public var boss:MiniBossShip;
		
		protected var _bosses:Vector.<ShipBehaviorType>;
		
		public function MiniBossManager(stations:Stations) 
		{
			super();
			_finalBossSpawned = false;
			bossesDefeated = 0;
			_bosses = new Vector.<ShipBehaviorType>();
			_bosses.push(ShipBehaviorType.BOSS_BLINK);
			_bosses.push(ShipBehaviorType.BOSS_FAST);
			_bosses.push(ShipBehaviorType.BOSS_MINE);
			_bosses.push(ShipBehaviorType.BOSS_SWARM);
			var arr:Array = stations.members;
			for (var ii:int = 0; ii < Constants.NUM_STATIONS; ii++) {
				var point:Station = arr[ii] as Station;
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
			
			for (var j:int = 0; j < this.length; j++) {
				var ship:MiniBossShip = members[j] as MiniBossShip;
				if (!ship.alive) continue;
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
			
			if (!_finalBossSpawned && bossesDefeated == 3)
			{
				//spawn final boss
				var finalBoss:MiniBossShip = new MiniBossShip(Constants.TILESIZE * Constants.WORLDTILES / 2, Constants.TILESIZE * Constants.WORLDTILES / 2, new Station(0, 0));
				finalBoss.affiliation = Affiliation.ENEMY;
				add(finalBoss);
				finalBoss.registerBehaviorType(ShipBehaviorType.BOSS_FINAL);
				finalBoss.isFinalBoss = true;
				_finalBossSpawned = true;
				boss = finalBoss;
				//finalBoss.exists = true;
			}
		}
		
		private function spawn(ship:MiniBossShip):void
		{
			// Randomly choose a boss and splice it out of the available bosses.
			if (!ship.hasAlreadySpawned)
			{	
				var index:int = Utility.randomInt(_bosses.length);
				var behavior:ShipBehaviorType = _bosses[index];
				_bosses.splice(index, 1);
				trace(behavior);
				trace(_bosses);
				ship.registerBehaviorType(behavior);
			}
			ship.activated = true;
		}	
	}

}