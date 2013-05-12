package project.env
{

  import org.flixel.*;
  import project.ship.PlayerShip;
  import project.constant.GameRegistry;
  import project.constant.Constants;

  public class StarField extends FlxGroup {

  	private var tiles:Array;
  	private var multiplier:int;
	private var scroll:Number;

		/*
		 *  @param scrollFactor the scroll factor of this starfield, must be a reciprocal of an integer
		 *  @param worldSize the size of the world, in Constants.TILESIZExConstants.TILESIZE px tiles
		 * 	The product of scrollFactor * worldSize must be a whole number
		 */
		public function StarField(scrollFactor:Number, worldSize:int)
		{
			super();
			scroll = scrollFactor;
			multiplier = 1 / scrollFactor;
			tiles = new Array(worldSize * scrollFactor);
			for(var i:int = 0; i < tiles.length; i++) {
				tiles[i] = new Array(worldSize * scrollFactor);
				/*
				for(var j:int = 0; j < tiles[i].length; j++) {
					tiles[i][j] = new StarTile(Constants.TILESIZE * i, Constants.TILESIZE * j, scrollFactor);
					add(tiles[i][j]);
				}
				*/
			}
		}

		override public function update():void
		{
			var player:PlayerShip = GameRegistry.gameState.playerManager.playerShip;
			var x:int = player.x / Constants.TILESIZE / multiplier;
			var y:int = player.y / Constants.TILESIZE / multiplier;

			//Set the visible StarTiles
			var left:int = x - multiplier < 0 ? 0 : x - multiplier;
			var right:int = x + multiplier < tiles.length ? x + multiplier : tiles.length - 1;
			var bot:int = y - multiplier < 0 ? 0 : y - multiplier;
			var top:int = y + multiplier < tiles.length ? y + multiplier : tiles.length - 1;

			for(var i:int = left; i <= right; i++) {
				for (var j:int = bot; j <= top; j++) {
					if (!tiles[i][j]) {
						tiles[i][j] = new StarTile(Constants.TILESIZE * i, Constants.TILESIZE * j, scroll);
						add(tiles[i][j]);
					}
					tiles[i][j].visible = true;
				}
			}

			//Reset the StarTiles that should no longer be visible
			if(left - 1 >= 0) {
				for (j = bot; j <= top; j++) {
					if (!tiles[left - 1][j]) {
						tiles[left - 1][j] = new StarTile(Constants.TILESIZE * (left - 1), Constants.TILESIZE * j, scroll);
						add(tiles[left - 1][j]);
					}
					tiles[left - 1][j].visible = false;
				}
				//Corners
				if (bot - 1 >= 0) {
					if (!tiles[left - 1][bot - 1]) {
						tiles[left - 1][bot - 1] = new StarTile(Constants.TILESIZE * (left - 1), Constants.TILESIZE * (bot - 1), scroll);
						add(tiles[left - 1][bot - 1]);
					}
					tiles[left - 1][bot - 1].visible = false;
				}
				if (top + 1 < tiles.length) {
					if (!tiles[left - 1][top + 1]) {
						tiles[left - 1][top + 1] = new StarTile(Constants.TILESIZE * (left - 1), Constants.TILESIZE * (top + 1), scroll);
						add(tiles[left - 1][top + 1]);
					}
					tiles[left - 1][top + 1].visible = false;
				}
			}
			if(right + 1 < tiles.length) {
				for (j = bot; j <= top; j++) {
					if (!tiles[right + 1][j]) {
						tiles[right + 1][j] = new StarTile(Constants.TILESIZE * (right + 1), Constants.TILESIZE * j, scroll);
						add(tiles[right + 1][j]);
					}
					tiles[right + 1][j].visible = false;
				}
				//Corners
				if (bot - 1 >= 0) {
					if (!tiles[right + 1][bot - 1]) {
						tiles[right + 1][bot - 1] = new StarTile(Constants.TILESIZE * (right + 1), Constants.TILESIZE * (bot - 1), scroll);
						add(tiles[right + 1][bot - 1]);
					}
					tiles[right + 1][bot - 1].visible = false;
				}
				if (top + 1 < tiles.length) {
					if (!tiles[right + 1][top + 1]) {
						tiles[right + 1][top + 1] = new StarTile(Constants.TILESIZE * (right + 1), Constants.TILESIZE * (top + 1), scroll);
						add(tiles[right + 1][top + 1]);
					}
					tiles[right + 1][top + 1].visible = false;
				}
			}
			if(bot - 1 >= 0) {
				for (i = left; i <= right; i++) {
					if (!tiles[i][bot - 1]) {
						tiles[i][bot - 1] = new StarTile(Constants.TILESIZE * i, Constants.TILESIZE * (bot - 1), scroll);
						add(tiles[i][right + 1]);
					}
					tiles[i][bot - 1].visible = false;
				}
			}
			if(top + 1 < tiles.length) {
				for (i = left; i <= right; i++) {
					if (!tiles[i][top + 1]) {
						tiles[i][top + 1] = new StarTile(Constants.TILESIZE * i, Constants.TILESIZE * (top + 1), scroll);
						add(tiles[i][top + 1]);
					}
					tiles[i][top + 1].visible = false;
				}
			}
		}
	}
}