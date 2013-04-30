package project.state 
{
	import org.flixel.FlxCamera;
	import org.flixel.FlxG;
	import org.flixel.FlxState;
	import project.constant.GameRegistry;
	import project.env.StarField;
	import project.manager.EnemyManager;
	import project.manager.EnvironmentManager;
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
		
		protected var _starfield1:StarField;
		protected var _starfield2:StarField;
		protected var _starfield3:StarField;
		
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
			_starfield1 = new StarField(1000, 0.15, 5000); 
			_starfield2 = new StarField(1000, 0.3, 5000); 
			_starfield3 = new StarField(1000, 0.45, 5000); 
			
			add(_enemyManager);
			add(_playerManager);
			add(_neutralManager);
			add(_envManager);
			add(_starfield1);
			add(_starfield2);
			add(_starfield3);
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
			if (FlxG.keys.W)
			{
				_playerManager.playerShip.setYDirection( -1);
			}
			if (FlxG.keys.A)
			{
				_playerManager.playerShip.setXDirection( -1);
			}
			if (FlxG.keys.S)
			{
				_playerManager.playerShip.setYDirection(1);
			}
			if (FlxG.keys.D)
			{
				_playerManager.playerShip.setXDirection(1);
			}
			
			// Other controls
			if (FlxG.keys.justPressed("P"))
			{
				// For now toggles pause state
				// TODO: Add some kind of visual cue
				FlxG.paused = !FlxG.paused;
			}
		}
		
	}

}