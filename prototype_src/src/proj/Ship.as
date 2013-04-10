package proj 
{
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import org.flixel.FlxSound;
	/**
	 * ...
	 * @author Cullen
	 */
	public class Ship extends FlxSprite
	{
		[Embed(source="../../assets/ship.png")] private var shipPNG:Class
		[Embed(source = "../../assets/sfx/Explode.mp3")] private var sfxExplode:Class;
		private var soundExplode:FlxSound;
		
		public function Ship() 
		{
			super(0, 0);
			loadShipGraphic();
			soundExplode = (new FlxSound()).loadEmbedded(sfxExplode, false, false);
			
			addAnimation("N", [0]);
			addAnimation("NE", [1]);
			addAnimation("E", [2]);
			addAnimation("SE", [3]);
			addAnimation("S", [4]);
			addAnimation("SW", [5]);
			addAnimation("W", [6]);
			addAnimation("NW", [7]);
			exists = true;
			
		}
		
		protected function loadShipGraphic():void
		{
			loadRotatedGraphic(shipPNG, 8, -1, true, true);
		}
		
		override public function update():void
		{
			super.update();
		}
		
		override public function kill():void {
			soundExplode.play();
		}
		
	}

}