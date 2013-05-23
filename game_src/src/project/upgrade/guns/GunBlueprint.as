package project.upgrade.guns
{
	import project.bullet.BulletType;
	/**
	 * ...
	 * @author akirilov
	 */
	public class GunBlueprint 
	{
		public var angleOffset:Number;
		public var bulletType:BulletType;
		
		public function GunBlueprint(angleOffset:Number = 0, bulletType:BulletType = null)
		{
			this.angleOffset = angleOffset;
			this.bulletType = bulletType;
			if (bulletType == null)
			{
				this.bulletType = BulletType.BIG_CIRCLE;
			}
		}
	}

}