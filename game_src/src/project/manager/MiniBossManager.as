package project.manager 
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	import org.flixel.FlxState;
	import org.flixel.FlxBasic;
	import project.constant.Constants;
	import project.env.Station;
	import project.env.Stations;
	import project.ship.MiniBossShip;
	import project.constant.GameRegistry;
	import project.util.Affiliation;
	import project.ship.behavior.ShipBehaviorType;
	import project.util.CartesianPoint;
	import project.util.PolarPoint;
	
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
		
		public function MiniBossManager(stations:Stations) 
		{
			super();
			var arr:Array = stations.members;
			for (var i:int = 0; i < Constants.NUM_STATIONS; i++) {
				var point:Station = arr[i] as Station;
				var ship:MiniBossShip = new MiniBossShip(point.x, point.y);
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
				var cPoint:CartesianPoint = new CartesianPoint(ship.x - GameRegistry.gameState.playerManager.playerShip.x,
															   ship.y - GameRegistry.gameState.playerManager.playerShip.y);
				var pPoint:PolarPoint = cPoint.convertToPolar();
				if (pPoint.r < Constants.TILESIZE * 2) {
					if (!ship.activated) {
						spawn(ship);
					}
					ship.exists = true;
				}
			}
		}
		
		private function spawn(ship:MiniBossShip):void
		{
			//TODO: Randomize miniboss behavior
			ship.registerBehaviorType(ShipBehaviorType.BOSS_BLINK);
			
			ship.activated = true;
		}
		
	}

}