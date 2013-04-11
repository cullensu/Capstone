package proj 
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxU;
	/**
	 * ...
	 * @author Cullen
	 */
	public class UpgradeManager extends FlxGroup
	{
		
		public function UpgradeManager() 
		{
			super();
			
			for (var i:int = 0; i < 10; i++)
			{
				add(new Upgrade());
			}
		}
		
		public function generateNewUpgrade(xLoc:int, yLoc:int):void
		{
			if (getFirstAvailable())
			{
				var type:String;
				
				var rand:int = Math.floor(Math.random() * Upgrade.NUM_TYPES) as int;
				
				if (rand == 0)
				{
					type = Upgrade.TYPE_OXYGEN;
				}
				else if (rand == 1)
				{
					type = Upgrade.TYPE_COOLDOWN;
				}
				else if (rand == 2)
				{
					type = Upgrade.TYPE_COOLDOWN;
				}
				else if (rand == 3)
				{
					type = Upgrade.TYPE_DAMAGE;
				}
				
				Upgrade(getFirstAvailable()).createUpgrade(type, xLoc, yLoc);
			}
		}
		
		override public function update():void
		{
			super.update();
		}
		
	}

}