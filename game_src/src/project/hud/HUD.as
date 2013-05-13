package project.hud 
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.plugin.photonstorm.FlxBar;
	import org.flixel.FlxG;
	import project.constant.GameRegistry;
	import project.env.Station;
	import project.ship.PlayerShip;
	import project.state.GameState;
	import project.constant.Constants;
	/**
	 * ...
	 * @author Cullen
	 */
	public class HUD extends FlxGroup
	{
		protected var _playerHealthBar:FlxBar;
		protected var _miniMap:FlxSprite;
		protected var _blip:FlxSprite;
		protected var _playerShip:PlayerShip;
		[Embed(source = "../../../assets/map.png")] private var _map:Class;
		public function HUD(state:GameState) 
		{
			super();
			
			_playerShip = state.playerManager.playerShip;
			
			//Health bar
			_playerHealthBar = new FlxBar(350, 0, FlxBar.FILL_LEFT_TO_RIGHT, 100, 10, _playerShip, "health", 0, _playerShip.health, false);
			add(_playerHealthBar);
			_playerHealthBar.scrollFactor = new FlxPoint(0, 0);
			
			//Minimap
			_miniMap = (new FlxSprite(699, 499)).loadGraphic(_map);
			_miniMap.scrollFactor = new FlxPoint(0, 0);
			add(_miniMap);
			
			if (FlxG.debug) {
				var arr:Array = state.stations.members;
				for (var i:int = 0; i < Constants.NUM_STATIONS; i++) {
					var station:Station = arr[i] as Station;
					var newSprite:FlxSprite = (new FlxSprite(station.x / Constants.TILESIZE, station.y / Constants.TILESIZE)).makeGraphic(1, 1, 0xff0000ff);
					newSprite.x += 700;
					newSprite.y += 500;
					newSprite.scrollFactor = new FlxPoint(0, 0);
					add(newSprite);
				}
			}
			
			//Player blip
			_blip = (new FlxSprite(750, 550)).makeGraphic(1, 1);
			_blip.scrollFactor = new FlxPoint(0, 0);
			add(_blip);
		}
		
		
		override public function update():void
		{
			super.update();
			_blip.x = (_playerShip.x / Constants.TILESIZE) * (100 / Constants.WORLDTILES) + 700;
			_blip.y = (_playerShip.y / Constants.TILESIZE) * (100 / Constants.WORLDTILES) + 500;
		}
	}

}