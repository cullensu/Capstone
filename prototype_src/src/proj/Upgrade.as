package proj 
{
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Cullen
	 */
	public class Upgrade extends FlxSprite
	{
		public static const NUM_TYPES:int = 4;
		public static const TYPE_OXYGEN:String = "Oxygen";
		public static const TYPE_COOLDOWN:String = "Cooldown";
		public static const TYPE_MOVEMENT:String = "Movement";
		public static const TYPE_DAMAGE:String = "Damage";
		
		[Embed(source = "../../assets/upgrade.png")] private var upgradePng:Class;
		
		protected var m_type:String;
		
		public function Upgrade() 
		{
			super(0, 0, upgradePng);
			color = 0xFF2080FF;
			exists = false;
		}
		
		public function createUpgrade(type:String, xLoc:int, yLoc:int):void
		{
			x = xLoc;
			y = yLoc;
			m_type = type;
			
			if (m_type == TYPE_OXYGEN)
			{
				color = 0xFF80FF20;//green
			}
			else if (m_type == TYPE_COOLDOWN)
			{
				color = 0xFF2080FF;//blue
			}
			else if (m_type == TYPE_MOVEMENT)
			{
				color = 0xFFFFFFFF;//white
			}
			else if (m_type == TYPE_DAMAGE)
			{
				color = 0xFFFF8020;//red
			}
			
			exists = true;
		}
		
		public function pickup(applyTo:Ship):void
		{
			if (m_type == TYPE_OXYGEN)
			{
				applyTo.health += 50;
			}
			else if (m_type == TYPE_COOLDOWN)
			{
				applyTo.cooldown -= 10;
				if (applyTo.cooldown < 5)
				{
					applyTo.cooldown = 5;
				}
			}
			else if (m_type == TYPE_MOVEMENT)
			{
				applyTo.speed += 30;
			}
			else if (m_type == TYPE_DAMAGE)
			{
				applyTo.damage += 10;
			}
			
			exists = false;
		}
		
		
		
	}

}