package project.menu
{
	import org.flixel.FlxButton;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	import org.flixel.FlxRect;
	import org.flixel.FlxSprite;
	import project.constant.GameRegistry;
	/**
	 * ...
	 * @author akirilov
	 */
	public class PauseMenu extends FlxGroup
	{
		private var _resumeButton:FlxButton
		private var _background:FlxSprite
		
		public function PauseMenu() 
		{
			_background = new FlxSprite(0, 0);
			_background.makeGraphic(800, 600, 0xff000000);
			_resumeButton = new FlxButton(100, 100, "Resume", hide);
			
			_background.scrollFactor = new FlxPoint(0, 0);
			_resumeButton.scrollFactor = new FlxPoint(0, 0);
			
			add(_background);
			add(_resumeButton);
			
			this.exists = false;
		}
		
		public function show():void
		{
			FlxG.paused = true;
			this.exists = true;
		}
		
		public function hide():void
		{
			this.exists = false;
			FlxG.paused = false;
		}
	}

}