package project.constant 
{
	import project.state.GameState;
	import project.state.MenuState;
	/**
	 * ...
	 * @author Cullen
	 */
	public class GameRegistry 
	{
		protected static var _gameState:GameState = new GameState();
		protected static var _menuState:MenuState = new MenuState();
		
		public function GameRegistry() 
		{
			
		}
		
		static public function get gameState():GameState 
		{
			return _gameState;
		}
		
		static public function get menuState():MenuState 
		{
			return _menuState;
		}
		
	}

}