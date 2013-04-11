package proj 
{
	import org.flixel.FlxGroup;
	/**
	 * ...
	 * @author Cullen
	 */
	public class BulletManager extends FlxGroup
	{
		
		public function BulletManager() 
		{
			super();
			
			for (var i:int = 0; i < 80; i++)
			{
				add(new Bullet);
			}
		}
		
		public function fire(xLoc:int, yLoc:int, targetx:int, targety:int):void
		{
			if (getFirstAvailable())
			{
				Bullet(getFirstAvailable()).fire(xLoc + 15, yLoc + 15, targetx, targety);
			}
		}
		
		override public function update():void
		{
			super.update();
		}
	}

}