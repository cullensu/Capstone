package proj 
{
	import org.flixel.FlxGroup;
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
				Upgrade(getFirstAvailable()).createUpgrade(Upgrade.TYPE_OXYGEN, xLoc, yLoc);
			}
		}
		
		override public function update():void
		{
			super.update();
		}
		
	}

}