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
		private var tiles:Array;
		
		public function AsteroidField(worldSize:int) 
		{
			super();
			tiles = new Array(worldSize);
			for (var i:int = 0; i < tiles.length; i++) {
				tiles[i] = new Array(worldSize);
				for (var j:int = 0; j < tiles.length; j++) {
					tiles[i][j] = new AsteroidTile(Constants.TILESIZE * i, Constants.TILESIZE * j);
					add(tiles[i][j]);
				}
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
			
			for(var i:int = left; i <= right; i++) {
				for(var j:int = bot; j <= top; j++) {
					tiles[i][j].visible = true;
					tiles[i][j].active = true;
				}
			}
			
			//Reset the AsteroidTiles that should no longer be visible
			if(left - 1 >= 0) {
				for(j = bot; j <= top; j++) {
					tiles[left - 1][j].visible = false;
					tiles[left - 1][j].active = false;
				}
				//Corners
				if(bot - 1 >= 0) {
					tiles[left - 1][bot - 1].visible = false;
					tiles[left - 1][bot - 1].active = false;
				}
				if(top + 1 < tiles.length) {
					tiles[left - 1][top + 1].visible = false;
					tiles[left - 1][top + 1].active = false;
				}
			}
			if(right + 1 < tiles.length) {
				for(j = bot; j <=top; j++) {
					tiles[right + 1][j].visible = false;
					tiles[right + 1][j].active = false;
				}
				//Corners
				if(bot - 1 >= 0) {
					tiles[right + 1][bot - 1].visible = false;
					tiles[right + 1][bot - 1].active = false;
				}
				if(top + 1 < tiles.length) {
					tiles[right + 1][top + 1].visible = false;
					tiles[right + 1][top + 1].active = false;
				}
			}
			if(bot - 1 >= 0) {
				for(i = left; i <= right; i++) {
					tiles[i][bot - 1].visible = false;
					tiles[i][bot - 1].active = false;
				}
			}
			if(top + 1 < tiles.length) {
				for(i = left; i <= right; i++) {
					tiles[i][top + 1].visible = false;
					tiles[i][top + 1].active = false;
				}
			}
		}
		
	}

}