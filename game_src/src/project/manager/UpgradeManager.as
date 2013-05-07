package project.manager 
{
	import org.flixel.FlxGroup;
	import project.constant.Constants;
	import project.upgrade.drops.DropType;
	import project.upgrade.drops.DropUpgrade;
	/**
	 * ...
	 * @author Cullen
	 */
	public class UpgradeManager extends FlxGroup
	{
		
		public function UpgradeManager() 
		{
			for (var i:int = 0; i < Constants.MAX_UPGRADES_ON_SCREEN; i++)
			{
				var dropUpgrade:DropUpgrade = new DropUpgrade();
				dropUpgrade.exists = false;
				add(dropUpgrade);
			}
		}
		
		public function createDrop(type:DropType, xLoc:Number, yLoc:Number):void
		{
			if (this.getFirstAvailable() != null)
			{
				var dropUpgrade:DropUpgrade = this.getFirstAvailable() as DropUpgrade;
				dropUpgrade.type = type;
				dropUpgrade.x = xLoc;
				dropUpgrade.y = yLoc;
				dropUpgrade.exists = true;
			}
		}
	}

}