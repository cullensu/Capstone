package project.bullet 
{
	import flash.geom.Point;
	import org.flixel.FlxPoint;
	import project.objects.AffiliatedObject;
	import project.ship.Ship;
	import project.util.Affiliation;
	import project.util.Utility;
	/**
	 * ...
	 * @author Cullen
	 */
	public class Bullet extends AffiliatedObject
	{
		[Embed(source="../../../assets/playerbullet.png")] private var bulletSpr:Class;
		protected static const WIDTH:Number = 5;
		protected static const HEIGHT:Number = 5;
		
		protected var _speed:Number = 600;
		
		
		public function Bullet(X:Number=0,Y:Number=0,SimpleGraphic:Class=null) 
		{
			super(X, Y, SimpleGraphic);
			loadGraphic(bulletSpr, false, false, WIDTH, HEIGHT);
			exists = false;
		}
		
		public function fire(owner:AffiliatedObject, targetX:Number, targetY:Number):void
		{
			_affiliation = owner.affiliation;
			this.x = owner.x + width / 2;
			this.y = owner.y + height / 2;
			
			var vel:Point = new Point(targetX - this.x, targetY - this.y);
			vel.normalize(_speed);
			
			this.velocity.copyFromFlash(vel);
			exists = true;
		}
		
		override public function postUpdate():void
		{
			super.postUpdate();
			if (exists && !onScreen())
			{
				exists = false;
			}
		}
		
	}

}