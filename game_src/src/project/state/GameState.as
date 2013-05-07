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
	import project.manager.EnemyManager;
	import project.manager.EnvironmentManager;
	import project.manager.MusicManager;
	import project.manager.NeutralManager;
	import project.manager.PlayerManager;
	import project.menu.PauseMenu;
	import project.ship.AIShip;
	import project.ship.PlayerShip;
	import project.ship.Ship;
	import project.util.Utility;
	/**
	 * Manages the the actual game and all entities it contains.
	 * @author Cullen
	 */
	public class GameState extends FlxState
	{		
		protected var _aiManager:AIShipManager;
		protected var _enemyManager:EnemyManager;
		protected var _playerManager:PlayerManager;
		protected var _neutralManager:NeutralManager;
		protected var _envManager:EnvironmentManager;
		protected var _bulletManager:BulletManager;
		protected var _musicManager:MusicManager;
		
		protected var _starField:StarField;
		protected var _starField2:StarField;
		protected var _starField3:StarField;
		protected var _asteroidField:AsteroidField;
		
		protected var _hud:HUD;
		
		protected var _pauseMenu:PauseMenu;
		

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
			//Set random seed. We will also need to set this for replays
			var rand:Number = Math.random();
			Utility.setSeed(rand);
			
			_aiManager = new AIShipManager();
			_enemyManager = new EnemyManager();
			_playerManager = new PlayerManager();
			_neutralManager = new NeutralManager();
			_envManager = new EnvironmentManager();
			_bulletManager = new BulletManager();
			_musicManager = new MusicManager();
			_starField = new StarField(0.5, Constants.WORLDTILES);
			_starField2 = new StarField(0.25, Constants.WORLDTILES);
			_starField3 = new StarField(1, Constants.WORLDTILES);
			_asteroidField = new AsteroidField(Constants.WORLDTILES);
			_pauseMenu = new PauseMenu();
			
			_hud = new HUD(this);
			
			add(_starField);
			add(_starField2);
			add(_starField3);
			add(_asteroidField);
			
			add(_aiManager);
			add(_musicManager);
			add(_enemyManager);
			add(_playerManager);
			add(_neutralManager);
			add(_bulletManager);
			add(_envManager);
			
			add(_hud);
			
			add (_pauseMenu);
		}
		
		public function get playerManager():PlayerManager 
		{
			return _playerManager;
		}
		
		public function get bulletManager():BulletManager 
		{
			return _bulletManager;
		}
		
		public function get enemyManager():EnemyManager 
		{
			return _enemyManager;
		}
		
		public function get neutralManager():NeutralManager 
		{
			return _neutralManager;
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