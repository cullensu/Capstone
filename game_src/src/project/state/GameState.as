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
	import project.ship.behavior.ShipBehaviorFactory;
	import project.ship.PlayerShip;
	import project.ship.Ship;
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
		protected var _shipBehaviorFactory:ShipBehaviorFactory;
		
		protected var _level:Number;
		protected var _thresholdH:Number;
		protected var _thresholdL:Number;
		protected var _tickSize:Number;
		protected var _canSpawn:Boolean;
		

		/**
		 * Creates a new instance of the GameState
		 */
		public function GameState()
		{
			super();
			init();
		}
		
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
			_shipBehaviorFactory = new ShipBehaviorFactory();
			
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
			super.create();
			FlxG.mouse.show()
			FlxG.camera.follow(_playerManager.playerShip, FlxCamera.STYLE_LOCKON);
		}

		/**
		 * Prepares the GameState and all entities it contains for update
		 */
		override public function preUpdate():void 
		{
			if (!FlxG.paused)
			{
				super.preUpdate();
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
			var upgrades:Array = _upgradeManager.members;
			
			for (var u:int = 0; u < upgrades.length; u++)
			{
				var upgrade:DropUpgrade = upgrades[u];
				if (upgrade == null || !upgrade.exists) continue;
				
				if (upgrade.canCollide(playerShip))
				{
					if (FlxCollision.pixelPerfectCheck(playerShip, upgrade))
					{
						playerShip.collide(upgrade);
						upgrade.collide(playerShip);
					}
				}
			}
			
			for (var b:int = 0; b < bullets.length; b++)
			{
				var bullet:Bullet = bullets[b] as Bullet;
				if (bullet == null || !bullet.exists) continue;
				
				if (bullet.canCollide(playerShip))
				{
					if (FlxCollision.pixelPerfectCheck(playerShip, bullet))
					{
						playerShip.collide(bullet);
						bullet.collide(playerShip);
					}
				}
				
				for (var s:int = 0; s < aiShips.length; s++)
				{
					var aiship:AIShip = aiShips[s] as AIShip;
					if (aiship == null || !aiship.exists) continue;
					if (aiship.canCollide(playerShip))
					{
						if (FlxCollision.pixelPerfectCheck(aiship, playerShip))
						{
							aiship.collide(playerShip);
							playerShip.collide(aiship);
						}
					}
					if (aiship.canCollide(bullet))
					{
						if (FlxCollision.pixelPerfectCheck(aiship, bullet))
						{
							aiship.collide(bullet);
							bullet.collide(aiship);
						}
					}
				}
			}
		}
		
		/**
		 * Pauses the game
		 */
		private function pauseGame():void 
		{
			_pauseMenu.show();
		}

		

	}

}