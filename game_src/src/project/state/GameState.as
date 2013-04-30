package project.state
{
	import org.flixel.FlxCamera;
	import org.flixel.FlxG;
	import org.flixel.FlxState;
	import project.constant.GameRegistry;
	import project.constant.Constants;
	import project.env.StarField;
	import project.manager.BulletManager;
	import project.manager.EnemyManager;
	import project.manager.EnvironmentManager;
	import project.manager.MusicManager;
	import project.manager.NeutralManager;
	import project.manager.PlayerManager;
	/**
	 * Manages the the actual game and all entities it contains.
	 * @author Cullen
	 */
	public class GameState extends FlxState
	{
		protected var _enemyManager:EnemyManager;
		protected var _playerManager:PlayerManager;
		protected var _neutralManager:NeutralManager;
		protected var _envManager:EnvironmentManager;
		protected var _bulletManager:BulletManager;
		protected var _musicManager:MusicManager;
		
		protected var _starField:StarField;
		protected var _starField2:StarField;
		protected var _starField3:StarField;
		

		/**
		 * Creates a new instance of the GameState
		 */
		public function GameState()
		{
			super();

			_enemyManager = new EnemyManager();
			_playerManager = new PlayerManager();
			_neutralManager = new NeutralManager();
			_envManager = new EnvironmentManager();
			_bulletManager = new BulletManager();
			_musicManager = new MusicManager();
			_starField = new StarField(0.5, Constants.WORLDTILES);
			_starField2 = new StarField(0.25, Constants.WORLDTILES);
			_starField3 = new StarField(1, Constants.WORLDTILES);

			add(_starField);
			add(_starField2);
			add(_starField3);
			
			add(_musicManager);
			add(_enemyManager);
			add(_playerManager);
			add(_neutralManager);
			add(_bulletManager);
			add(_envManager);
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

		override public function create():void
		{
			super.create();
			FlxG.mouse.show()
			FlxG.camera.follow(_playerManager.playerShip, FlxCamera.STYLE_LOCKON);
		}

		/**
		 * Updates the GameState and all entities it contains.
		 */
		override public function update():void
		{
			processKeyboardInput();
			super.update();
		}

		/**
		 * Captures key presses and performs the appropriate actions
		 */
		protected function processKeyboardInput():void
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
			if (FlxG.keys.P)
			{
				// For now toggles pause state
				// TODO: Add some kind of visual cue
				FlxG.paused = !FlxG.paused;
			}
			if (FlxG.keys.justPressed("J")) {
				trace(_playerManager.playerShip.x, _playerManager.playerShip.y);
			}
		}

		

	}

}