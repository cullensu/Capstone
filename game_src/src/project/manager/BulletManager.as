package project.manager 
{
	import org.flixel.FlxGroup;
	import project.bullet.Bullet;
	import project.constant.Constants;
	import project.objects.AffiliatedObject;
	import project.ship.Ship;
	/**
	 * ...
	 * @author Cullen
	 */
	public class BulletManager extends FlxGroup
	{
		public function BulletManager() 
		{
			super();
			
			for (var i:int = 0; i < Constants.MAX_BULLETS; i++)
			{
				add(new Bullet());
			}
		}
		
		public function fire(owner:AffiliatedObject, targetX:Number, targetY:Number):void
		{
			if (this.getFirstAvailable() != null)
			{
				(getFirstAvailable() as Bullet).fire(owner, targetX, targetY)
			}
			
		}
		
	}

}