package project.state
{
	import mx.core.FlexSprite;
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
	import project.env.Station;
	import project.env.Stations;
	import project.hud.HUD;
	import project.manager.AIShipManager;
	import project.manager.BulletManager;
	import project.manager.EnvironmentManager;
	import project.manager.MusicManager;
	import project.manager.PlayerManager;
	import project.manager.UpgradeManager;
	import project.menu.PauseMenu;
	import project.objects.AffiliatedObject;
	import project.ship.AIShip;
	import project.ship.behavior.ShipBehaviorFactory;
	import project.ship.PlayerShip;
	import project.ship.Ship;
	import project.util.ICollidable;
	import project.upgrade.drops.DropUpgrade;
	import project.util.Utility;
	import project.replay.ReplayHandler;
	/**
	 * Manages the the actual game and all entities it contains.
	 * @author Cullen
	 */
	public class GameState extends FlxState
	{
		protected var _stations:Stations;
		
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
		protected var _shipBehaviorFactory:ShipBehaviorFactory;
		
		protected var _level:Number;
		protected var _thresholdH:Number;
		protected var _thresholdL:Number;
		protected var _tickSize:Number;
		protected var _canSpawn:Boolean;
		
		protected var _recording:Boolean;
		protected var _replaying:Boolean;

		public function init():void
		{
			_stations = new Stations(Constants.WORLDTILES);
			
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
			_shipBehaviorFactory = new ShipBehaviorFactory();
			
			_level = 0;
			_tickSize = Constants.TICK1;
			_thresholdH = Constants.THRESHOLD_H1;
			_thresholdL = Constants.THRESHOLD_L1;
			_canSpawn = true;
			
			add(_starField);
			add(_starField2);
			add(_starField3);
			
			add(_stations);
			
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
		
		public function get shipBehaviorFactory():ShipBehaviorFactory 
		{
			return _shipBehaviorFactory;
		}

		override public function create():void
		{
			if (GameRegistry.doReplay)
			{
				GameRegistry.doReplay = false;
				startReplaying(GameRegistry.loadedReplay);
			}
			else if (!GameRegistry.recording && !GameRegistry.replaying)
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
				_playerManager.playerShip.fire(FlxG.mouse.x, FlxG.mouse.y/*, _playerManager.playerShip.velocity*/);
			}

			// Other controls
			if (FlxG.keys.justPressed("P"))
			{
				pauseGame();
			}
			if (FlxG.keys.justPressed("J")) {
				trace(_playerManager.playerShip.x, _playerManager.playerShip.y);
			}
			if (FlxG.keys.justPressed("M")) {
				FlxG.mute = !FlxG.mute;
			}
			if (FlxG.keys.justPressed("H")) {
				_playerManager.playerShip.health = _playerManager.playerShip.maxHealth;
			}
		}
		
		protected function processCollision():void
		{
			var aiShips:Array = _aiManager.members;
			var playerShip:Array = _playerManager.members;
			var bullets:Array = _bulletManager.members;
			var aTiles:Array = _asteroidField.extantTiles;
			var upgrades:Array = _upgradeManager.members;
			
			collideAffilitedObjects(bullets, playerShip);
			collideAffilitedObjects(bullets, aiShips);
			collideAffilitedObjects(aiShips, playerShip);
			collideAffilitedObjects(upgrades, playerShip);
			
			var shipsAndBullets:Array = bullets.concat(aiShips, playerShip);
			for (var i:int = 0; i < aTiles.length; i++)
			{
				var aTile:AsteroidTile = aTiles[i] as AsteroidTile;
				if (aTile == null) continue;
				var asteroids:Array = aTile.members;
				collideAffilitedObjects(shipsAndBullets, asteroids);
			}
		}
		
		/**
		 * Members in the array should be ICollidable and FlxSprites
		 * @param	group1
		 * @param	group2
		 */
		protected function collideAffilitedObjects(group1:Array, group2:Array):void
		{
			for (var i:int = 0; i < group1.length; i++) 
			{
				var obj1:FlxSprite = group1[i] as FlxSprite;
				if (obj1 == null || !obj1.exists || !(obj1 is ICollidable)) continue;
				var coll1:ICollidable = obj1 as ICollidable;
				for (var j:int = 0; j < group2.length; j++) 
				{
					var obj2:FlxSprite = group2[j] as FlxSprite;
					if (obj2 == null || !obj2.exists || !(obj2 is ICollidable)) continue;
					var coll2:ICollidable = obj2 as ICollidable;
					if (coll1.canCollide(coll2)) 
					{
						if (FlxCollision.pixelPerfectCheck(obj1, obj2)) {
							coll1.collide(coll2);
							coll2.collide(coll1);
						}
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
				ReplayHandler.uploadRecording(save, Constants.LOGGING_SERVER);
				trace("Replay logged!");
			}
			catch (e:Error)
			{
				trace("Logging server could not be contacted.");
			}
			
			return save;
		}
		
		public function startReplaying(save:String):void
		{
			GameRegistry.replaying = true;
			FlxG.loadReplay(save, new GameState(), ["ANY"], 0, doneReplaying);
		}
		
		private function doneReplaying():void 
		{
			GameRegistry.replaying = false;
			GameRegistry.loadedReplay = null;
			FlxG.switchState(new MenuState());
		}
	}
}