package proj 
{
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Cullen
	 */
	public class Bullet extends FlxSprite
	{
		[Embed(source = "../../assets/Bullet.png")] private var bulletPNG:Class
		
		public var damage:int = 1;
		public var speed:int = 300;
		
		public function Bullet() 
		{
			super(0, 0, bulletPNG);
			exists = false;
		}
		
		public function fire(xLoc:int, yLoc:int, targetx:int, targety:int):void 
		{
			x = xLoc;
			y = yLoc;
			
			var dx:int = targetx - xLoc;
			var dy:int = targety - yLoc;
			var magnitude:Number = Math.sqrt(dx * dx + dy * dy);
			
			velocity.x = dx / magnitude * speed;
			velocity.y = dy / magnitude * speed;
			
			exists = true;
		}
		
		override public function update():void
		{
			super.update();
			
			if (exists && offscreen())
			{
				exists = false;
			}
		}
		
		public function offscreen():Boolean
		{
			return !onScreen();
			//var result:Boolean = y < 0 || y > height || x > width || x < 0;
			//trace("BulletOffscreen:" + result);
			//trace("x:" + x + " y:" + y);
			//return result;
		}
		
	}

}