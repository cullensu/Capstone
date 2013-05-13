package project.env 
{
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author jmlee337
	 */
	public class Station extends FlxSprite
	{
		[Embed(source = "../../../assets/station.png")] private var _stationpng:Class;
		
		public function Station(x:Number, y:Number) 
		{
			super(x, y);
			loadGraphic(_stationpng);
		}
		
	}

}