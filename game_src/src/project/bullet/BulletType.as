package project.bullet 
{
	import project.enum.Enum;
	/**
	 * ...
	 * @author Cullen
	 */
	public final class BulletType extends Enum
	{
		{initEnum(BulletType); } // static ctor
		
		public static const CIRCLE:BulletType = new BulletType();
		public static const SQUARE:BulletType = new BulletType();
		public static const TRIANGLE:BulletType = new BulletType();
		
		
	}

}