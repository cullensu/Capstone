package project.replay
{
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import org.flixel.FlxG;
	import project.constant.GameRegistry;
	import project.state.GameState;
	/**
	 * ...
	 * @author akirilov
	 */
	public class ReplayHandler 
	{
		static public function uploadRecording(data:String, url:String):void
		{
			var vars:URLVariables = new URLVariables();
			var date:Date = new Date();
			var date_string:String = date.getTime().toString();
			vars.id = date_string;
			vars.replay = data; // This returns the current replay in string format!
			
			var request:URLRequest = new URLRequest(url);
			request.method = URLRequestMethod.POST;
			request.data = vars;
		 
			var loader:URLLoader = new URLLoader();
			loader.load(request);
		}
		
		static public function downloadRecording(id:String, url:String):void
		{
			var vars:URLVariables = new URLVariables();
			vars.id = id;
			
			var request:URLRequest = new URLRequest(url);
			request.method = URLRequestMethod.GET;
			request.data = vars;
		 
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, storeReplay);
			loader.load(request);
		}
		
		static private function storeReplay(e:Event):void 
		{
			GameRegistry.loadedReplay = e.target.data;
			trace(GameRegistry.loadedReplay);
			FlxG.switchState(new GameState());
		}
		
	}

}