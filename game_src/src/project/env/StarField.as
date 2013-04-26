package project.env
{

  import org.flixel.*;
  import project.util.Utility;

  public class StarField extends FlxGroup {

  	private var tiles:Array;
  	private var multiplier:int;

		/*
		 *  @param scrollFactor the scroll factor of this starfield, must be a reciprocal of an integer
		 *  @param worldSize the size of the world, in 800x800 px tiles
		 * 	The product of scrollFactor * worldSize must be a whole number
		 */
		public function StarField(scrollFactor:Number, worldSize:int):void
		{
			super();
			multiplier = 1 / scrollFactor;
			tiles = new Array(worldSize * scrollFactor);
			for(var i:int = 0; i < tiles.length; i++) {
				tiles[i] = new Array(worldSize * scrollFactor);
				for(var j:int = 0; j < tiles[i].length; j++) {
					tiles[i][j] = new StarTile(800 * i, 800 * j, scrollFactor);
					add(tiles[i][j]);
				}
			}
		}

		override public function update():void
		{
			PlayerShip player = GameRegistry.gameState.playerManager.playerShip;
			var x:int = player.x / 800;
			var y:int = player.y / 800;

			//Set the visible StarTiles
			var left:int = x - multiplier < 0 ? 0 : x - multiplier;
			var right:int = x + multiplier < tiles.length ? x + multiplier : tiles.length - 1;
			var bot:int = y - multiplier < 0 ? 0 : y - multiplier;
			var top:int = y + multiplier < tiles.length ? y + multiplier : tiles.length - 1;

			for(var i:int = left; i <= right; i++) {
				for(var j:int = bot; j <= top; j++) {
					tiles[i][j].visible = true;
				}
			}

			//Reset the StarTiles that should no longer be visible
			if(left - 1 >= 0) {
				for(var j:int = bot; j <= top; j++) {
					tiles[left - 1][j].visible = false;
				}
				//Corners
				if(bot - 1 >= 0) {
					tiles[left - 1][bot - 1].visible = false;
				}
				if(top + 1 < tiles.length) {
					tiles[left - 1][top + 1].visible = false;
				}
			}
			if(right + 1 < tiles.length) {
				for(var j:int = bot; j <=top; j++) {
					tiles[right + 1][j].visible = false;
				}
				//Corners
				if(bot - 1 >= 0) {
					tiles[right + 1][bot - 1].visible = false;
				}
				if(top + 1 < tiles.length) {
					tiles[right + 1][top + 1].visible = false;
				}
			}
			if(bot - 1 >= 0) {
				for(var i:int = left; i <= right; i++) {
					tiles[i][bot - 1].visible = false;
				}
			}
			if(top + 1 < tiles.length) {
				for(var i:int = left; i <= right; i++) {
					tiles[i][top + 1].visible = false;
				}
			}
		}
	}
}