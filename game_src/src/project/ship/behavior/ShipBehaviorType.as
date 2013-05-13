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
		public static const ENEMY_FAST:ShipBehaviorType = new ShipBehaviorType();
		public static const ENEMY_BIG:ShipBehaviorType = new ShipBehaviorType();
		
		public static const BOSS_BLINK:ShipBehaviorType = new ShipBehaviorType();
	}

}