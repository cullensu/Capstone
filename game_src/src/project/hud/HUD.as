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
	import project.manager.MiniBossManager;
	import project.ship.PlayerShip;
	import project.state.GameState;
	import project.constant.Constants;
	import project.util.CartesianPoint;
	import project.util.PolarPoint;
	/**
	 * ...
	 * @author Cullen
	 */
	public class HUD extends FlxGroup
	{
		private var _ticker:int;
		
		protected var _dist:int;
		protected var _alert:FlxText;
		protected var _congrat:FlxText;
		
		protected var _playerHealthBar:FlxBar;
		protected var _playerBonusDamageBar:FlxBar;
		protected var _playerBonusCooldownBar:FlxBar;
		protected var _playerBonusMovespeedBar:FlxBar;
		
		protected var _healthBarLabel:FlxText;
		protected var _bonusDamageLabel:FlxText;
		protected var _bonusCooldownLabel:FlxText;
		protected var _bonusMoveSpeedLabel:FlxText;
		
		protected var _scoreDisplay:FlxText;
		
		protected var _playerActiveBar:FlxBar;
		protected var _playerActiveLabel:FlxText;
		
		protected var _miniMap:FlxSprite;
		protected var _blip:FlxSprite;
		protected var _playerShip:PlayerShip;
		[Embed(source = "../../../assets/map.png")] private var _map:Class;
		[Embed(source = "../../../assets/fonts/Kontrapunkt-Bold.otf", fontFamily = "Kontrapunkt", embedAsCFF="false")] private var _font:String;
		public function HUD(state:GameState) 
		{
			super();
			GameRegistry.hud = this;
			
			_ticker = Constants.TICK_TIME;
			
			_playerShip = state.playerManager.playerShip;
			
			var fillType:uint = FlxBar.FILL_LEFT_TO_RIGHT;
			
			_alert = new FlxText(280, 60, 240, "Please assist us: ");
			_alert.setFormat("Kontrapunkt", 20);
			_alert.visible = false;
			_alert.scrollFactor = new FlxPoint(0, 0);
			_alert.active = false;
			add(_alert);
			
			_congrat = new FlxText(230, 80, 340, "Thank you, please rest here: ");
			_congrat.setFormat("Kontrapunkt", 20);
			_congrat.visible = false;
			_congrat.scrollFactor = new FlxPoint(0, 0);
			_congrat.active = false;
			add(_congrat);
			
			_bonusDamageLabel = new FlxText(118, 536, 200, "Bonus Damage");
			_bonusDamageLabel.setFormat("Kontrapunkt", 10);
			add(_bonusDamageLabel);
			_bonusDamageLabel.scrollFactor = new FlxPoint(0, 0);
			
			_bonusCooldownLabel = new FlxText(118, 556, 100, "Fire Rate");
			_bonusCooldownLabel.setFormat("Kontrapunkt", 10);
			add(_bonusCooldownLabel);
			_bonusCooldownLabel.scrollFactor = new FlxPoint(0, 0);
			
			_bonusMoveSpeedLabel = new FlxText(118, 576, 100, "Ship Speed");
			_bonusMoveSpeedLabel.setFormat("Kontrapunkt", 10);
			add(_bonusMoveSpeedLabel);
			_bonusMoveSpeedLabel.scrollFactor = new FlxPoint(0, 0);
			
			_scoreDisplay = new FlxText(630, 20, 150, GameRegistry.score.toString());
			_scoreDisplay.setFormat("Kontrapunkt", 16, 0xffffff, "right");
			add(_scoreDisplay);
			_scoreDisplay.scrollFactor = new FlxPoint(0, 0);
			
			//Health bar
			_playerHealthBar = new FlxBar(350, 20, fillType, 100, 10, _playerShip, "health", 0, _playerShip.health);
			_playerHealthBar.update();
			add(_playerHealthBar);
			_playerHealthBar.scrollFactor = new FlxPoint(0, 0);
			
			//This is the number that shows up above the bar
			//_healthBarLabel = new FlxText(350, 2, 100, _playerShip.health.toString());
			//_healthBarLabel.setFormat("Kontrapunkt", 16, 0xffffff, "center");
			//add(_healthBarLabel);
			//_healthBarLabel.scrollFactor = new FlxPoint(0, 0);
			
			//This is the number that shows up on top of the bar
			_healthBarLabel = new FlxText(350, 16, 100, _playerShip.health.toString());
			_healthBarLabel.setFormat("Kontrapunkt", 12, 0xffffff, "center");
			add(_healthBarLabel);
			_healthBarLabel.scrollFactor = new FlxPoint(0, 0);
			
			_playerBonusDamageBar = new FlxBar(10, 540, fillType, 100, 10, _playerShip, "bonusDamage", -0.1, Constants.MAX_BONUS_DAMAGE);
			_playerBonusDamageBar.createFilledBar(0xff510000, 0xffF40000);
			add(_playerBonusDamageBar);
			_playerBonusDamageBar.scrollFactor = new FlxPoint(0, 0);
			
			_playerBonusCooldownBar = new FlxBar(10, 560, fillType, 100, 10, _playerShip, "bonusCooldownDisplayTracker", -0.1, 100);
			_playerBonusCooldownBar.createFilledBar(0xff515100, 0xffF4F400);
			_playerBonusCooldownBar.update();
			add(_playerBonusCooldownBar);
			_playerBonusCooldownBar.scrollFactor = new FlxPoint(0, 0);
			
			_playerBonusMovespeedBar = new FlxBar(10, 580, fillType, 100, 10, _playerShip, "bonusMoveSpeed", -0.1, Constants.MAX_BONUS_MOVE_SPEED);
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
					newSprite.x *= (100 / Constants.WORLDTILES);
					newSprite.y *= (100 / Constants.WORLDTILES);
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
			_playerActiveBar = new FlxBar(350, 40, FlxBar.FILL_LEFT_TO_RIGHT, 100, 10, _playerShip.activeUpgrade, "charge", 0, _playerShip.activeUpgrade.MAX_CHARGE, false);
			add(_playerActiveBar);
			_playerActiveBar.scrollFactor = new FlxPoint(0, 0);
		}
		
		
		override public function update():void
		{
			super.update();
			_healthBarLabel.text = Math.floor(_playerShip.health).toString();
			_scoreDisplay.text = Math.floor(GameRegistry.score).toString();
			_blip.x = (_playerShip.x / Constants.TILESIZE) * (100 / Constants.WORLDTILES) + 700 - 1;
			_blip.y = (_playerShip.y / Constants.TILESIZE) * (100 / Constants.WORLDTILES) + 500 - 1;
			if (_ticker > 0) {
				_ticker--;
			} else {
				var dist:Number = getLeastDist();
				if(GameRegistry.gameState.miniBossManager.bossesDefeated < 3) {
					if (dist < Constants.STATION_DIST && dist != 0) {
						if (dist > 0) {
							_congrat.visible = false;
							_dist = Math.round(dist) as int;
							_alert.text = "Please assist us: " + _dist;
							_alert.visible = true;
						} else {
							_alert.visible = false;
							_dist = Math.round(-dist) as int;
							_congrat.text = "Thank you, please rest here: " + _dist;
							_congrat.visible = true;
						}
					} else {
						_alert.visible = false;
						_congrat.visible = false;
					}
				} else {
					_congrat.visible = false;
					if(GameRegistry.gameState.miniBossManager.boss && !GameRegistry.gameState.miniBossManager.boss.exists) {
						_dist = Math.round(dist) as int;
						_alert.text = "Defeat the boss: " + _dist;
						_alert.visible = true;
					} else {
						_alert.visible = false;
					}
				}
			}
		}
		
		private function getLeastDist():Number
		{
			var mbm:MiniBossManager = GameRegistry.gameState.miniBossManager;
			if (mbm.bossesDefeated == 3 && !mbm.boss.exists) {
				var bossPointC:CartesianPoint = new CartesianPoint(mbm.boss.x - GameRegistry.gameState.playerManager.playerShip.x,
																   mbm.boss.y - GameRegistry.gameState.playerManager.playerShip.y);
				var bossPointP:PolarPoint = bossPointC.convertToPolar();
				return bossPointP.r;
			}
			var min:Number = Number.MAX_VALUE;
			var mem:Array = GameRegistry.gameState.stations.members;
			for (var i:int = 0; i < GameRegistry.gameState.stations.length; i++) {
				var station:Station = mem[i] as Station;
				if (!station.alive) continue;
				var cPoint:CartesianPoint = new CartesianPoint(station.x - GameRegistry.gameState.playerManager.playerShip.x + 400,
															   station.y - GameRegistry.gameState.playerManager.playerShip.y + 400);
				var pPoint:PolarPoint = cPoint.convertToPolar();
				if (station.activated) {
					min = -pPoint.r;
					if (min >= -400) {
						station.alive = false;
						GameRegistry.gameState.upgradeMenu.show();
						GameRegistry.gameState.miniBossManager.bossesDefeated++;
						GameRegistry.gameState.playerManager.playerShip.health = GameRegistry.gameState.playerManager.playerShip.maxHealth;
					}
				} else {
					min = Math.min(min, pPoint.r);
				}
			}
			return min;
		}	
	}

}