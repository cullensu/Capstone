package 
{
	import org.flixel.system.FlxPreloader;
	
	/**
	 * ...
	 * @author Cullen
	 */
	public class Preloader extends FlxPreloader 
	{
		
		public function Preloader() 
		{
			trace("here");
			className = "Game";
			super();
		}
	}
	
}