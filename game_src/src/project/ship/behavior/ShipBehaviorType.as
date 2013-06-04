package project.ship.behavior 
{
	import project.enum.Enum;
	/**
	 * ...
	 * @author Cullen
	 */
	public class ShipBehaviorType extends Enum
	{
		{initEnum(ShipBehaviorType); }
		
		public static const ENEMY_NORMAL:ShipBehaviorType = new ShipBehaviorType();
		public static const ENEMY_NORMAL_NO_UPGRADES:ShipBehaviorType = new ShipBehaviorType();
		public static const ENEMY_FAST:ShipBehaviorType = new ShipBehaviorType();
		public static const ENEMY_BIG:ShipBehaviorType = new ShipBehaviorType();
		public static const ENEMY_MINE:ShipBehaviorType = new ShipBehaviorType();
		public static const ENEMY_TURRET:ShipBehaviorType = new ShipBehaviorType();
		
		public static const BOSS_BLINK:ShipBehaviorType = new ShipBehaviorType();
		public static const BOSS_FAST:ShipBehaviorType = new ShipBehaviorType();
		//public static const BOSS_HOMING:ShipBehaviorType = new ShipBehaviorType();
		public static const BOSS_SWARM:ShipBehaviorType = new ShipBehaviorType();
		public static const BOSS_MINE:ShipBehaviorType = new ShipBehaviorType();
		
		public static const BOSS_FINAL:ShipBehaviorType = new ShipBehaviorType();
	}

}