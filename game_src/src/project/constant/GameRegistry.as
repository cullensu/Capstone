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
		protected static var _recording:Boolean = false;
		protected static var _replaying:Boolean = false;
		
		public function GameRegistry() 
		{
			
		}
		
		static public function get gameState():GameState 
		{
			return _gameState;
		}
		
		static public function set gameState(value:GameState):void 
		{
			_gameState = value;
		}
		
		static public function get recording():Boolean 
		{
			return _recording;
		}
		
		static public function set recording(value:Boolean):void 
		{
			_recording = value;
		}
		
		static public function get replaying():Boolean 
		{
			return _replaying;
		}
		
		static public function set replaying(value:Boolean):void 
		{
			_replaying = value;
		}
		
	}

}