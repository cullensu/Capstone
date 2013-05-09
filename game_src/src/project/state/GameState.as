package project.state
{
	import org.flixel.FlxCamera;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.plugin.photonstorm.FlxCollision;
	import project.bullet.Bullet;
	import project.constant.GameRegistry;
	import project.constant.Constants;
	import project.env.Asteroid;
	import project.env.AsteroidTile;
	import project.env.StarField;
	import project.env.AsteroidField;
	import project.hud.HUD;
	import project.manager.AIShipManager;
	import project.manager.BulletManager;
	import project.manager.EnvironmentManager;
	import project.manager.MusicManager;
	import project.manager.PlayerManager;
	import project.manager.UpgradeManager;
	import project.menu.PauseMenu;
	import project.ship.AIShip;
	import project.ship.PlayerShip;
	import project.ship.Ship;
	import project.util.ICollidable;
	import project.upgrade.drops.DropUpgrade;
	import project.util.Utility;
	/**
	 * Manages the the actual game and all entities it contains.
	 * @author Cullen
	 */
	public class GameState extends FlxState
	{		
		protected var _aiManager:AIShipManager;
		protected var _playerManager:PlayerManager;
		protected var _envManager:EnvironmentManager;
		protected var _bulletManager:BulletManager;
		protected var _musicManager:MusicManager;
		protected var _upgradeManager:UpgradeManager;
		
		protected var _starField:StarField;
		protected var _starField2:StarField;
		protected var _starField3:StarField;
		protected var _asteroidField:AsteroidField;
		
		protected var _hud:HUD;
		
		protected var _pauseMenu:PauseMenu;
		
		protected var _level:Number;
		protected var _thresholdH:Number;
		protected var _thresholdL:Number;
		protected var _tickSize:Number;
		protected var _canSpawn:Boolean;
		
		protected var _recording:Boolean;
		protected var _replaying:Boolean;

		public function init():void
		{			
			_aiManager = new AIShipManager();
			_playerManager = new PlayerManager();
			_envManager = new EnvironmentManager();
			_bulletManager = new BulletManager();
			_musicManager = new MusicManager();
			_upgradeManager = new UpgradeManager();
			_starField = new StarField(0.5, Constants.WORLDTILES);
			_starField2 = new StarField(0.25, Constants.WORLDTILES);
			_starField3 = new StarField(1, Constants.WORLDTILES);
			_asteroidField = new AsteroidField(Constants.WORLDTILES);
			_pauseMenu = new PauseMenu();
			
			_hud = new HUD(this);
			
			_level = 0;
			_tickSize = Constants.TICK1;
			_thresholdH = Constants.THRESHOLD_H1;
			_thresholdL = Constants.THRESHOLD_L1;
			_canSpawn = true;
			
			add(_starField);
			add(_starField2);
			add(_starField3);
			add(_asteroidField);
			
			add(_aiManager);
			add(_musicManager);
			add(_playerManager);
			add(_bulletManager);
			add(_envManager);
			add(_upgradeManager);
			
			add(_hud);
			
			add (_pauseMenu);
			
			_musicManager.setLevel(1);
			
			_recording = false;
			_replaying = false;
		}
		
		public function get canSpawn():Boolean
		{
			return _canSpawn;
		}
		
		public function get level():Number
		{
			return _level;
		}
		
		public function addLevel(n:Number):void
		{
			_level += n;
		}
		
		public function get playerManager():PlayerManager 
		{
			return _playerManager;
		}
		
		public function get bulletManager():BulletManager 
		{
			return _bulletManager;
		}
		
		public function get musicManager():MusicManager 
		{
			return _musicManager;
		}
		
		public function get envManager():EnvironmentManager 
		{
			return _envManager;
		}
		
		public function get aiManager():AIShipManager 
		{
			return _aiManager;
		}
		
		public function get upgradeManager():UpgradeManager 
		{
			return _upgradeManager;
		}

		override public function create():void
		{
			if (!GameRegistry.recording && !GameRegistry.replaying)
			{
				startRecording();
			}
			init();
			FlxG.mouse.show()
			FlxG.camera.follow(_playerManager.playerShip, FlxCamera.STYLE_LOCKON);
			GameRegistry.gameState = this;
		}

		/**
		 * Prepares the GameState and all entities it contains for update
		 */
		override public function preUpdate():void 
		{
			if (!FlxG.paused)
			{
				//super.preUpdate();
			}
			else
			{
				_pauseMenu.preUpdate();
			}
		}
		
		/**
		 * Updates the GameState and all entities it contains.
		 */
		override public function update():void
		{	
			if (!FlxG.paused)
			{
				processUserInput();
				processCollision();
				super.update();
				/*
				if (_aiManager.canTick()) {
					tick();
				}
				*/
				tick();
				if (_level > _thresholdH) {
					_canSpawn = false;
				} else if (_level < _thresholdL) {
					_canSpawn = true;
				}
				if (_level > 0) {
					_musicManager.setLevel(2);
				} else {
					_musicManager.setLevel(1);
				}
			}
			else
			{
				_pauseMenu.update();
			}
			if (FlxG.keys.justPressed("R") && !GameRegistry.replaying)
			{
				var save:String = stopRecording();
				startReplaying(save);
			}
		}
		
		/**
		 * Performs post-updating upkeep in the GameState and all its entities.
		 */
		override public function postUpdate():void 
		{
			if (!FlxG.paused)
			{
				super.postUpdate();
			}
			else
			{
				_pauseMenu.postUpdate();
			}
		}
		
		protected function tick():void
		{
			_level -= FlxG.elapsed * _tickSize;
		}

		/**
		 * Captures key presses and performs the appropriate actions
		 */
		protected function processUserInput():void
		{
			// Movement Keys
			var xVel:int = 0;
			var yVel:int = 0;
			if (FlxG.keys.W)
			{
				yVel -= 1;
			}
			if (FlxG.keys.A)
			{
				xVel -= 1;
			}
			if (FlxG.keys.S)
			{
				yVel += 1;
			}
			if (FlxG.keys.D)
			{
				xVel += 1;
			}
			
			playerManager.playerShip.setXDirection(xVel);
			playerManager.playerShip.setYDirection(yVel);
			
			//Mouse Clicks
			if (FlxG.mouse.pressed())
			{
				_playerManager.playerShip.fire(FlxG.mouse.x, FlxG.mouse.y);
			}

			// Other controls
			if (FlxG.keys.justPressed("P"))
			{
				pauseGame();
			}
			if (FlxG.keys.justPressed("J")) {
				trace(_playerManager.playerShip.x, _playerManager.playerShip.y);
			}
		}
		
		protected function processCollision():void
		{
			var aiShips:Array = _aiManager.members;
			var playerShip:PlayerShip = _playerManager.playerShip;
			var bullets:Array = _bulletManager.members;
			var aTiles:Array = _asteroidField.extantTiles;
			var upgrades:Array = _upgradeManager.members;
			
			var i:int;
			for (i = 0; i < _bulletManager.length; i++) {
				var bullet:Bullet = bullets[i] as Bullet;
				if (bullet == null || !bullet.exists) continue;
				if (bullet.canCollide(playerShip)) {
					if (FlxCollision.pixelPerfectCheck(playerShip, bullet)) {
						playerShip.collide(bullet);
						bullet.collide(playerShip);
					}
				}
				var j:int;
				for (j = 0; j < _aiManager.length; j++) {
					var aiShip:AIShip = aiShips[j] as AIShip;
					if (aiShip == null || !aiShip.exists) continue;
					if (bullet.canCollide(aiShip)) {
						if (FlxCollision.pixelPerfectCheck(aiShip, bullet)) {
							aiShip.collide(bullet);
							bullet.collide(aiShip);
						}
					}
				}
				for (j = 0; j < 9; j++) {
					var aTile:AsteroidTile = aTiles[j] as AsteroidTile;
					if (aTile == null) continue;
					var asteroids:Array = aTile.members;
					for (var k:int = 0; k < aTile.length; k++) {
						var asteroid:Asteroid = asteroids[k] as Asteroid;
						if (asteroid == null || !asteroid.exists) continue;
						if (FlxCollision.pixelPerfectCheck(asteroid, bullet)) {
							asteroid.collide(bullet);
							bullet.collide(asteroid);
						}
					}
				}
			}
			for (i = 0; i < _aiManager.length; i++) {
				var aiShip:AIShip = aiShips[i] as AIShip;
				if (aiShip == null || !aiShip.exists) continue;
				if (aiShip.canCollide(playerShip)) {
					if (FlxCollision.pixelPerfectCheck(aiShip, playerShip)) {
						playerShip.collide(aiShip);
						aiShip.collide(playerShip);
					}
				}
				for (var j:int = 0; j < 9; j++) {
					var aTile:AsteroidTile = aTiles[j] as AsteroidTile;
					if (aTile == null) continue;
					var asteroids:Array = aTile.members;
					for (var k:int = 0; k < aTile.length; k++) {
						var asteroid:Asteroid = asteroids[k] as Asteroid;
						if (asteroid == null || !asteroid.exists) continue;
						if (FlxCollision.pixelPerfectCheck(asteroid, aiShip)) {
							asteroid.collide(aiShip);
							aiShip.collide(asteroid);
						}
					}
				}
			}
			for (i = 0; i < 9; i++) {
				var aTile:AsteroidTile = aTiles[i] as AsteroidTile;
				if (aTile == null) continue;
				var asteroids:Array = aTile.members;
				for (var j:int = 0; j < aTile.length; j++) {
					var asteroid:Asteroid = asteroids[j] as Asteroid;
					if (asteroid == null || !asteroid.exists) continue;
					if (FlxCollision.pixelPerfectCheck(asteroid, playerShip)) {
						asteroid.collide(playerShip);
						playerShip.collide(asteroid);
					}
				}
			}
			for (i = 0; i < _upgradeManager.length; i++) {
				var upgrade:DropUpgrade = upgrades[i] as DropUpgrade;
				if (upgrade == null || !upgrade.exists) continue;
				if (upgrade.canCollide(playerShip)) {
					if (FlxCollision.pixelPerfectCheck(upgrade, playerShip)) {
						upgrade.collide(playerShip);
						playerShip.collide(upgrade);
					}
				}
			}
		}
		
		/**
		 * Pauses the game
		 */
		public function pauseGame():void 
		{
			_pauseMenu.show();
		}
		
		public function startRecording():void 
		{
			GameRegistry.recording = true;
			
			FlxG.recordReplay(false);
		}
				
		public function stopRecording():String 
		{
			GameRegistry.recording = false;
			
			var save:String = FlxG.stopRecording();
			
			try {
				// Upload replay
				FlxG.uploadRecording(Constants.LOGGING_SERVER);
				trace("Replay logged!");
			}
			catch (Error)
			{
				trace("Logging server could not be contacted.");
			}
			
			return save;
		}
		
		public function startReplaying(save:String):void
		{
			GameRegistry.replaying = true;
			
			FlxG.loadReplay(save, new GameState(), ["ANY"], 0, startRecording);
		}
	}
}