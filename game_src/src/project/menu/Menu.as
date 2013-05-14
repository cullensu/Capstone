package project.menu
{
	import org.flixel.FlxBasic;
	import org.flixel.FlxButton;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	/**
	 * ...
	 * @author akirilov
	 */
	public class Menu extends FlxGroup
	{		
		public function show():void
		{
			FlxG.paused = true;
			this.exists = true;
			for (var m:String in members)
			{
				members[m].exists = true;
			}
		}
		
		public function hide():void
		{
			this.exists = false;
			FlxG.paused = false;
			for (var m:String in members)
			{
				members[m].exists = false;
			}
		}
	}

}