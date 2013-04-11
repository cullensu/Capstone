package proj 
{
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Cullen
	 */
	public class Upgrade extends FlxSprite
	{
		public static const TYPE_OXYGEN:String = "Oxygen";
		
		[Embed(source = "../../assets/upgrade.png")] private var upgradePng:Class;
		
		protected var m_type:String;
		
		public function Upgrade() 
		{
			super(0, 0, upgradePng);
			color = 0xFF4444FF;
			exists = false;
		}
		
		public function createUpgrade(type:String, xLoc:int, yLoc:int):void
		{
			x = xLoc;
			y = yLoc;
			m_type = type;
			exists = true;
		}
		
		public function pickup(applyTo:Ship):void
		{
			if (m_type == TYPE_OXYGEN)
			{
				applyTo.health += 30;
			}
			
			exists = false;
		}
		
		
		
	}

}