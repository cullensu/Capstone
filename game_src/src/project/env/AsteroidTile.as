package project.env 
{
	import org.flixel.FlxGroup;
	import project.util.Utility;
	import project.constant.Constants;
	/**
	 * ...
	 * @author jmlee337
	 */
	public class AsteroidTile extends FlxGroup
	{
		private var numAsteroids:int;
		
		public function AsteroidTile(x:int, y:int) 
		{
			super();
			
			//Decide number of Asteroids in this tile
			var rand:int = Math.floor(Utility.random() * 11);
			if (rand < 1) {
				numAsteroids = 0;
			} else if (rand < 5) {
				numAsteroids = 1;
			} else if (rand < 10) {
				numAsteroids = 2;
			} else {
				numAsteroids = 3;
			}
			
			//Generate Asteroids for this tile. (They can overlap lol)
			for (var i:int = 0; i < numAsteroids; i++) {
				var newA:Asteroid = new Asteroid(Utility.random() * Constants.TILESIZE + x, Utility.random() * Constants.TILESIZE + y, 1);
				add(newA);
			}
			this.visible = false;
			this.active = false;
		}
		
	}

}