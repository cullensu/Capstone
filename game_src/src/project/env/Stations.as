package project.env 
{
	import org.flixel.FlxGroup;
	import project.constant.Constants;
	import project.util.Utility;
	/**
	 * ...
	 * @author jmlee337
	 */
	public class Stations extends FlxGroup
	{
		
		public function Stations(worldSize:int) 
		{
			super();
			for (var i:int = 0; i < Constants.NUM_STATIONS; i++) {
				var newStation:Station = new Station(Utility.randomInt(worldSize) * Constants.TILESIZE,
												 Utility.randomInt(worldSize) * Constants.TILESIZE);
				add(newStation);
			}
			this.active = false;
		}
		
	}

}