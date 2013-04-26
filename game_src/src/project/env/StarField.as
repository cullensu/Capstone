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
			for(var i:int = x - multiplier; i <= x + multiplier; i++) {
				for(var j:int = y - multiplier; j <= y + multiplier; j++) {
					tiles[i][j].visible = true;
				}
			}

			//Reset the StarTiles that should no longer be visible
			for(var i:int = x - multiplier - 1; i <= x + multiplier + 1; i++) {
				tiles[i][y - multiplier - 1].visible = false;
			}
			for(var i:int = x - multiplier - 1; i <= x + multiplier + 1; i++) {
				tiles[i][y + multiplier + 1].visible = false;
			}
			for(var j:int = y - multiplier; j <= y + multiplier; j++) {
				tiles[x - multiplier - 1][j].visible = false;
			}
			for(var j:int = y - multiplier; j <= y + multiplier; j++) {
				tiles[x + multiplier + 1][j].visible = false;
			}
		}
	}
}