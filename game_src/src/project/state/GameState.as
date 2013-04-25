package project.state 
{
	import org.flixel.FlxG;
	import org.flixel.FlxState;
	import project.manager.EnemyManager;
	import project.manager.EnvironmentManager;
	import project.manager.NeutralManager;
	import project.manager.PlayerManager;
	/**
	 * ...
	 * @author Cullen
	 */
	public class GameState extends FlxState
	{
		protected var _enemyManager:EnemyManager;
		protected var _playerManager:PlayerManager;
		protected var _neutralManager:NeutralManager;
		protected var _envManager:EnvironmentManager;
		
		public function GameState() 
		{
			super();
			
			_enemyManager = new EnemyManager();
			_playerManager = new PlayerManager();
			_neutralManager = new NeutralManager();
			_envManager = new EnvironmentManager();
			
			add(_enemyManager);
			add(_playerManager);
			add(_neutralManager);
			add(_envManager);
		}
		
		override public function update():void
		{
			processKeyboardInput();
			super.update();
			
		}
		
		protected function processKeyboardInput():void
		{
			if (FlxG.keys.justPressed("W"))
			{
				
			}
			if (FlxG.keys.justPressed("A"))
			{
				
			}
			if (FlxG.keys.justPressed("S"))
			{
				
			}
			if (FlxG.keys.justPressed("D"))
			{
				
			}
		}
		
	}

}