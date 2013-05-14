package project.manager 
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	import project.bullet.Bullet;
	import project.bullet.BulletType;
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
		
		/**
		 * Fires a bullet from the owner's location to the target with the type of bullet specified
		 * The bullet will start from the owner's (x,y) and be the same affiliation as the owner
		 * @param	owner
		 * @param	targetX
		 * @param	targetY
		 * @param	bulletType
		 */
		public function fire(owner:AffiliatedObject, targetX:Number, targetY:Number, bulletType:BulletType, addVelocity:FlxPoint = null, bonusAttack:Number = 0):void
		{
			if (this.getFirstAvailable() != null)
			{
				var b:Bullet = (getFirstAvailable() as Bullet);
				b.type = bulletType;
				b.fire(owner, targetX, targetY, addVelocity, bonusAttack)
			}
			
		}
		
	}

}