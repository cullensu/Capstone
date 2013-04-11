package proj
{
	import org.flixel.*;
 
	public class StarField extends FlxGroup
	{
				
		/**
		 * @param	ang This is the angle that the starField will be rotating (in degrees)
		 * @param	speedMultiplier
		 */
		public function StarField(numStars:Number, scrollFactor:Number):void
		{
			super();
 
			for (var i:int = 0; i < numStars; i++)
			{
				var str:FlxSprite = new FlxSprite(Utility.random() * 10000 - 5000, Utility.random() * 10000 - 5000);
				str.makeGraphic(1, 1, 0xffffffff);
				str.solid = false;
				str.scrollFactor = new FlxPoint(scrollFactor, scrollFactor);
				add(str);
			}
		}
	}
}