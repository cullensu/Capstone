package project.env 
{
	import org.flixel.FlxGroup;
	import project.ship.PlayerShip;
	import project.constant.GameRegistry;
	import project.constant.Constants;
	/**
	 * ...
	 * @author jmlee337
	 */
	public class AsteroidField extends FlxGroup
	{
		public var extantTiles:Array;
		private var tiles:Array;
		
		public function AsteroidField(worldSize:int) 
		{
			super();
			extantTiles = new Array(9);
			tiles = new Array(worldSize);
			for (var i:int = 0; i < tiles.length; i++) {
				tiles[i] = new Array(worldSize);
				/*
				for (var j:int = 0; j < tiles.length; j++) {
					tiles[i][j] = new AsteroidTile(Constants.TILESIZE * i, Constants.TILESIZE * j);
					add(tiles[i][j]);
				}
				*/
			}
		}
		
		override public function update():void
		{
			super.update();
			var player:PlayerShip = GameRegistry.gameState.playerManager.playerShip;
			var x:int = player.x / Constants.TILESIZE;
			var y:int = player.y / Constants.TILESIZE;
			
			var left:int = x - 1 < 0 ? 0 : x - 1;
			var right:int = x + 1 < tiles.length ? x + 1 : tiles.length - 1;
			var bot:int = y - 1 < 0 ? 0 : y - 1;
			var top:int = y + 1 < tiles.length ? y + 1 : tiles.length - 1;
			
			var index:int = 0;
			var newArray:Array = new Array(9);
			for(var i:int = left; i <= right; i++) {
				for (var j:int = bot; j <= top; j++) {
					if (!tiles[i][j]) {
						tiles[i][j] = new AsteroidTile(Constants.TILESIZE * i, Constants.TILESIZE * j);
						add(tiles[i][j]);
					}
					tiles[i][j].exists = true;
					newArray[index] = tiles[i][j];
					index++;
				}
			}
			extantTiles = newArray;
			
			//Reset the AsteroidTiles that should no longer be visible
			if(left - 1 >= 0) {
				for (j = bot; j <= top; j++) {
					if (!tiles[left - 1][j]) {
						tiles[left - 1][j] = new AsteroidTile(Constants.TILESIZE * (left - 1), Constants.TILESIZE * j);
						add(tiles[left - 1][j]);
					}
					tiles[left - 1][j].exists = false;
				}
				//Corners
				if (bot - 1 >= 0) {
					if (!tiles[left - 1][bot - 1]) {
						tiles[left - 1][bot - 1] = new AsteroidTile(Constants.TILESIZE * (left - 1), Constants.TILESIZE * (bot - 1));
						add(tiles[left - 1][bot - 1]);
					}
					tiles[left - 1][bot - 1].exists = false;
				}
				if (top + 1 < tiles.length) {
					if (!tiles[left - 1][top + 1]) {
						tiles[left - 1][top + 1] = new AsteroidTile(Constants.TILESIZE * (left - 1), Constants.TILESIZE * (top + 1));
						add(tiles[left - 1][top + 1]);
					}
					tiles[left - 1][top + 1].exists = false;
				}
			}
			if(right + 1 < tiles.length) {
				for (j = bot; j <= top; j++) {
					if (!tiles[right + 1][j]) {
						tiles[right + 1][j] = new AsteroidTile(Constants.TILESIZE * (right + 1), Constants.TILESIZE * j);
						add(tiles[right + 1][j]);
					}
					tiles[right + 1][j].exists = false;
				}
				//Corners
				if (bot - 1 >= 0) {
					if (!tiles[right + 1][bot - 1]) {
						tiles[right + 1][bot - 1] = new AsteroidTile(Constants.TILESIZE * (right + 1), Constants.TILESIZE * (bot - 1));
						add(tiles[right + 1][bot - 1]);
					}
					tiles[right + 1][bot - 1].exists = false;
				}
				if (top + 1 < tiles.length) {
					if (!tiles[right + 1][top + 1]) {
						tiles[right + 1][top + 1] = new AsteroidTile(Constants.TILESIZE * (right + 1), Constants.TILESIZE * (top + 1));
						add(tiles[right + 1][top + 1]);
					}
					tiles[right + 1][top + 1].exists = false;
				}
			}
			if(bot - 1 >= 0) {
				for (i = left; i <= right; i++) {
					if (!tiles[i][bot - 1]) {
						tiles[i][bot - 1] = new AsteroidTile(Constants.TILESIZE * i, Constants.TILESIZE * (bot - 1));
						add(tiles[i][bot - 1]);
					}
					tiles[i][bot - 1].exists = false;
				}
			}
			if(top + 1 < tiles.length) {
				for (i = left; i <= right; i++) {
					if (!tiles[i][top + 1]) {
						tiles[i][top + 1] = new AsteroidTile(Constants.TILESIZE * i, Constants.TILESIZE * (top + 1));
						add(tiles[i][top + 1]);
					}
					tiles[i][top + 1].exists = false;
				}
			}
		}
		
	}

}