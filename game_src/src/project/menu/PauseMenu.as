package project.menu
{
	import org.flixel.FlxButton;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	import org.flixel.FlxRect;
	import org.flixel.FlxSprite;
	import org.flixel.FlxText;
	import project.constant.GameRegistry;
	/**
	 * ...
	 * @author akirilov
	 */
	public class PauseMenu extends Menu
	{
		private var _resumeButton:FlxButton
		private var _background:FlxSprite
		private var _title:FlxText
		
		public function PauseMenu() 
		{
			_background = new FlxSprite(0, 0);
			_background.makeGraphic(800, 600, 0xff000000);
			
			_resumeButton = new FlxButton(100, 130, "Resume", hide);
			
			_title = new FlxText(100, 100, 200, "PAUSED");
			_title.color = 0xffffffff;
			
			_background.scrollFactor = new FlxPoint(0, 0);
			_resumeButton.scrollFactor = new FlxPoint(0, 0);
			_title.scrollFactor = new FlxPoint(0, 0);
			
			add(_background);
			add(_resumeButton);
			add(_title);
			
			this.exists = false;
		}
	}

}