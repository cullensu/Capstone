package project.manager 
{
	import flash.globalization.LocaleID;
	import org.flixel.FlxGroup;
	import project.constant.Constants;
	import project.constant.GameRegistry;
	import project.upgrade.drops.DropType;
	import project.upgrade.drops.DropUpgrade;
	import project.util.Utility;
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
		
		public function createRandomDrop(xLoc:Number, yLoc:Number):void
		{
			var rand:Number = Utility.randomInt(10);
			var type:DropType = DropType.OXYGEN;
			if (rand == 0)
			{
				type = DropType.ATTACK;
			}
			else if (rand == 1)
			{
				type = DropType.ATTACK_SPEED;
			}
			else if (rand == 2)
			{
				type = DropType.MOVE_SPEED;
			}
			else
			{
				type = DropType.OXYGEN;
			}
			
			if (GameRegistry.gameState.playerManager.playerShip.health < 15)
			{
				type = DropType.OXYGEN;
			}
			createDrop(type, xLoc, yLoc);
		}
		
		public function createDrop(type:DropType, xLoc:Number, yLoc:Number):void
		{
			if (this.getFirstAvailable() != null)
			{
				var dropUpgrade:DropUpgrade = this.getFirstAvailable() as DropUpgrade;
				dropUpgrade.type = type;
				dropUpgrade.x = xLoc;
				dropUpgrade.y = yLoc;
				dropUpgrade.lifetime = Constants.DROP_UPGRADE_LIFETIME;
				dropUpgrade.exists = true;
			}
		}
	}

}