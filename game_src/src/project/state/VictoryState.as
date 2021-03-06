package project.state
{
	import org.flixel.FlxG;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import project.constant.GameRegistry
	/**
	 * ...
	 * @author akirilov
	 */
	public class VictoryState extends FlxState
	{
		[Embed(source = "../../../assets/fonts/Kontrapunkt-Bold.otf", fontFamily = "Kontrapunkt", embedAsCFF="false")] private var _font:String;
		[Embed(source = "../../../assets/win.png")] protected var Win:Class;

		private var message:FlxSprite;
		private var score:FlxText;
		
		public function VictoryState() 
		{	
			message = new FlxSprite(50, 385, Win);
			message.scrollFactor = new FlxPoint(0, 0)
			add(message);
			score = new FlxText(48, 530, 200, "Score: " + GameRegistry.score);
			score.setFormat("Kontrapunkt", 18);
			add(score);
		}
		
		override public function update():void 
		{
			super.update();
			if (FlxG.keys.ENTER || FlxG.keys.SPACE || FlxG.keys.ESCAPE || FlxG.mouse.pressed())
			{
				FlxG.switchState(new MenuState());
			}
		}
		
	}

}