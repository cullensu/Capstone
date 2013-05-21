package project.hud 
{
	import flash.accessibility.Accessibility;
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxText;
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
		protected var _playerBonusDamageBar:FlxBar;
		protected var _playerBonusCooldownBar:FlxBar;
		protected var _playerBonusMovespeedBar:FlxBar;
		
		protected var _healthBarLabel:FlxText;
		protected var _bonusDamageLabel:FlxText;
		protected var _bonusCooldownLabel:FlxText;
		protected var _bonusMoveSpeedLabel:FlxText;
		
		protected var _playerActiveBar:FlxBar;
		protected var _playerActiveLabel:FlxText;
		
		protected var _miniMap:FlxSprite;
		protected var _blip:FlxSprite;
		protected var _playerShip:PlayerShip;
		[Embed(source = "../../../assets/map.png")] private var _map:Class;
		public function HUD(state:GameState) 
		{
			super();
			GameRegistry.hud = this;
			
			_playerShip = state.playerManager.playerShip;
			
			var fillType:uint = FlxBar.FILL_LEFT_TO_RIGHT;
			
			_healthBarLabel = new FlxText(50, 0, 100, "OXYGEN");
			add(_healthBarLabel);
			_healthBarLabel.scrollFactor = new FlxPoint(0, 0);
			
			_bonusDamageLabel = new FlxText(200, 0, 100, "BONUS DAMAGE");
			add(_bonusDamageLabel);
			_bonusDamageLabel.scrollFactor = new FlxPoint(0, 0);
			
			_bonusCooldownLabel = new FlxText(500, 0, 100, "COOLDOWN REDUCTION");
			add(_bonusCooldownLabel);
			_bonusCooldownLabel.scrollFactor = new FlxPoint(0, 0);
			
			_bonusMoveSpeedLabel = new FlxText(650, 0, 100, "MOVE SPEED");
			add(_bonusMoveSpeedLabel);
			_bonusMoveSpeedLabel.scrollFactor = new FlxPoint(0, 0);
			
			//Health bar
			_playerHealthBar = new FlxBar(50, 20, fillType, 100, 10, _playerShip, "health", 0, _playerShip.health);
			_playerHealthBar.update();
			add(_playerHealthBar);
			_playerHealthBar.scrollFactor = new FlxPoint(0, 0);
			
			_playerBonusDamageBar = new FlxBar(200, 20, fillType, 100, 10, _playerShip, "bonusDamage", -0.1, Constants.MAX_BONUS_DAMAGE);
			_playerBonusDamageBar.createFilledBar(0xff510000, 0xffF40000);
			add(_playerBonusDamageBar);
			_playerBonusDamageBar.scrollFactor = new FlxPoint(0, 0);
			
			_playerBonusCooldownBar = new FlxBar(500, 20, fillType, 100, 10, _playerShip, "bonusCooldownDisplayTracker", -0.1, 100);
			_playerBonusCooldownBar.createFilledBar(0xff515100, 0xffF4F400);
			_playerBonusCooldownBar.update();
			add(_playerBonusCooldownBar);
			_playerBonusCooldownBar.scrollFactor = new FlxPoint(0, 0);
			
			_playerBonusMovespeedBar = new FlxBar(650, 20, fillType, 100, 10, _playerShip, "bonusMoveSpeed", -0.1, Constants.MAX_BONUS_MOVE_SPEED);
			_playerBonusMovespeedBar.createFilledBar(0xff000051, 0xff0000F4);
			_playerBonusMovespeedBar.update();
			add(_playerBonusMovespeedBar);
			_playerBonusMovespeedBar.scrollFactor = new FlxPoint(0, 0);
			
			//Minimap
			_miniMap = (new FlxSprite(699, 499)).loadGraphic(_map);
			_miniMap.scrollFactor = new FlxPoint(0, 0);
			add(_miniMap);
			
			if (FlxG.debug) {
				var arr:Array = state.stations.members;
				for (var i:int = 0; i < Constants.NUM_STATIONS; i++) {
					var station:Station = arr[i] as Station;
					var newSprite:FlxSprite = (new FlxSprite(station.x / Constants.TILESIZE - 1, station.y / Constants.TILESIZE - 1)).makeGraphic(3, 3, 0xff0000ff);
					newSprite.x += 700;
					newSprite.y += 500;
					newSprite.scrollFactor = new FlxPoint(0, 0);
					add(newSprite);
				}
			}
			
			//Player blip
			_blip = (new FlxSprite(750, 550)).makeGraphic(3, 3);
			_blip.scrollFactor = new FlxPoint(0, 0);
			add(_blip);
		}
		
		public function updateActiveBar():void 
		{
			_playerActiveBar = new FlxBar(350, 20, FlxBar.FILL_LEFT_TO_RIGHT, 100, 10, _playerShip.activeUpgrade, "charge", 0, _playerShip.activeUpgrade.MAX_CHARGE, false);
			_playerActiveBar.color = 0xff37FDFC;
			add(_playerActiveBar);
			_playerActiveBar.scrollFactor = new FlxPoint(0, 0);
			
			_playerActiveLabel = new FlxText(350, 0, 100, "ACTIVE ABILITY");
			add(_playerActiveLabel);
			_playerActiveLabel.scrollFactor = new FlxPoint(0, 0);
		}
		
		
		override public function update():void
		{
			super.update();
			_blip.x = (_playerShip.x / Constants.TILESIZE) * (100 / Constants.WORLDTILES) + 700 - 1;
			_blip.y = (_playerShip.y / Constants.TILESIZE) * (100 / Constants.WORLDTILES) + 500 - 1;
		}
	}

}