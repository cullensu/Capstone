package project.upgrade.drops 
{
	import project.enum.Enum;
	/**
	 * ...
	 * @author Cullen
	 */
	public class DropType extends Enum
	{
		{initEnum(DropType); }
		
		public static const OXYGEN:DropType = new DropType();
		public static const ATTACK:DropType = new DropType();
		public static const MOVE_SPEED:DropType = new DropType();
		public static const ATTACK_SPEED:DropType = new DropType();
	}

}