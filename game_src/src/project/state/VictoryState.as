package project.state
{
	import org.flixel.FlxG;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	/**
	 * ...
	 * @author akirilov
	 */
	public class VictoryState extends FlxState
	{
		[Embed(source = "../../../assets/win.png")] protected var Win:Class;

		private var message:FlxSprite;
		
		public function VictoryState() 
		{	
			message = new FlxSprite(200, 200, Win);
			message.scrollFactor = new FlxPoint(0, 0)
			add(message);
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