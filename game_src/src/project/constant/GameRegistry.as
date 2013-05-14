package project.constant 
{
	import project.hud.HUD;
	import project.state.GameState;
	import project.state.MenuState;
	/**
	 * ...
	 * @author Cullen
	 */
	public class GameRegistry 
	{
		protected static var _gameState:GameState = null;
		protected static var _recording:Boolean = false;
		protected static var _replaying:Boolean = false;
		protected static var _doReplay:Boolean = false;
		protected static var _loadedReplay:String = null;
		protected static var _hud:HUD = null;
		
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
		
		static public function get loadedReplay():String 
		{
			return _loadedReplay;
		}
		
		static public function set loadedReplay(value:String):void 
		{
			_loadedReplay = value;
		}
		
		static public function get doReplay():Boolean 
		{
			return _doReplay;
		}
		
		static public function set doReplay(value:Boolean):void 
		{
			_doReplay = value;
		}
		
		static public function get hud():HUD 
		{
			return _hud;
		}
		
		static public function set hud(value:HUD):void 
		{
			_hud = value;
		}
		
	}

}