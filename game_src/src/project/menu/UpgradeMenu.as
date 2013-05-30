package project.menu
{
	import org.flixel.FlxButton;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxText;
	import org.flixel.plugin.photonstorm.FlxButtonPlus;
	import project.bullet.BulletType;
	import project.constant.GameRegistry;
	import project.ship.PlayerShip;
	import project.upgrade.active.ShieldUpgrade;
	import project.upgrade.active.TeleportUpgrade;
	import project.upgrade.guns.GunUpgradeFactory;
	import project.upgrade.guns.OffsetGun;
	import project.upgrade.GunUpgrade;
	/**
	 * ...
	 * @author akirilov
	 */
	public class UpgradeMenu extends Menu
	{
		private var X_OFFSET:int = 50;
		private var Y_OFFSET:int = 80;
		
		private var _background:FlxSprite;
		private var _weaponUpgrade:FlxButton;
		private var _activeUpgrade:FlxButton;
		private var _passiveUpgrade:FlxButton;
		private var _title:FlxText;
		
		private var _gunFactory:GunUpgradeFactory;
		private var _tier:int = 1;
		
		private var _ship:PlayerShip;
		
		public function UpgradeMenu() 
		{			
			_background = new FlxSprite(0, 0);
			_background.makeGraphic(700, 400, 0xdd333333);
			
			_weaponUpgrade = new FlxButton(20, 180, "Weapon Upgrade", upgradeWeapon);
			_activeUpgrade = new FlxButton(140, 180, "Active Upgrade", upgradeActive);
			_passiveUpgrade = new FlxButton(260, 180,"Passive Upgrade", upgradePassive);
			
			_title = new FlxText(100, 100, 200, "PLEASE SELECT ONE UPGRADE BELOW:");
			_title.color = 0xffffffff;
			
			// Set positions
			_background.x += X_OFFSET;
			_background.y += Y_OFFSET;
			_background.scrollFactor = new FlxPoint(0, 0);
			_weaponUpgrade.x += X_OFFSET;
			_weaponUpgrade.y += Y_OFFSET;
			_weaponUpgrade.scrollFactor = new FlxPoint(0, 0);
			_activeUpgrade.x += X_OFFSET;
			_activeUpgrade.y += Y_OFFSET;
			_activeUpgrade.scrollFactor = new FlxPoint(0, 0);
			_passiveUpgrade.x += X_OFFSET;
			_passiveUpgrade.y += Y_OFFSET;
			_passiveUpgrade.scrollFactor = new FlxPoint(0, 0);
			_title.x += X_OFFSET
			_title.y += X_OFFSET
			_title.scrollFactor = new FlxPoint(0, 0);
			
			// Init factor
			_gunFactory = new GunUpgradeFactory();
			
			add(_background);
			add(_weaponUpgrade);
			add(_activeUpgrade);
			add(_passiveUpgrade);
			add(_title);
			
			this.exists = false;
		}
		
		private function upgradeWeapon():void
		{
			var ship:PlayerShip = GameRegistry.gameState.playerManager.playerShip;	
			var guns:Vector.<GunUpgrade> = _gunFactory.getGunUpgrade(_tier);
			_tier = Math.min(_tier + 1, 4);
			
			ship.removeAllGunUpgrades();
			for each (var gun:GunUpgrade in guns)
			{
				ship.addGunUpgrade(gun);
			}
			
			trace("Weapon upgraded!");
			hide();
		}
		
		private function upgradeActive():void
		{
			var ship:PlayerShip = GameRegistry.gameState.playerManager.playerShip;
			ship.activeUpgrade = new TeleportUpgrade(ship);
			GameRegistry.hud.updateActiveBar();
			
			trace("Active upgraded!");
			hide();
		}
		
		private function upgradePassive():void
		{
			var ship:PlayerShip = GameRegistry.gameState.playerManager.playerShip;
			ship.maxHealth = 150;
			ship.health = ship.maxHealth;
			trace("Passive upgraded!")
			hide();
		}
	}

}