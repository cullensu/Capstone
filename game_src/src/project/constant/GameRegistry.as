package project.constant 
{
	import project.state.GameState;
	import project.state.MenuState;
	import project.state.PauseState;
	import project.state.UpgradeState;
	/**
	 * ...
	 * @author Cullen
	 */
	public class GameRegistry 
	{
		protected static var _gameState:GameState = new GameState();
		protected static var _menuState:MenuState = new MenuState();
		protected static var _pauseState:PauseState = new PauseState();
		protected static var _upgradeState:UpgradeState = new UpgradeState();
		
		public function GameRegistry() 
		{
			
		}
		
		static public function get upgradeState():UpgradeState 
		{
			return _upgradeState;
		}
		
		static public function set upgradeState(value:UpgradeState):void 
		{
			_upgradeState = value;
		}
		
		static public function get gameState():GameState 
		{
			return _gameState;
		}
		
		static public function set gameState(value:GameState):void 
		{
			_gameState = value;
		}
		
		static public function get menuState():MenuState 
		{
			return _menuState;
		}
		
		static public function set menuState(value:MenuState):void 
		{
			_menuState = value;
		}
		
		static public function get pauseState():PauseState 
		{
			return _pauseState;
		}
		
		static public function set pauseState(value:PauseState):void 
		{
			_pauseState = value;
		}
		
	}

}