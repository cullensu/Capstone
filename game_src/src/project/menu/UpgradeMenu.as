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
	import project.upgrade.guns.OffsetGun;
	/**
	 * ...
	 * @author akirilov
	 */
	public class UpgradeMenu extends Menu
	{
		private var X_OFFSET:int = 60;
		private var Y_OFFSET:int = 100;
		
		private var _background:FlxSprite;
		private var _weaponUpgrade:FlxButton;
		private var _activeUpgrade:FlxButton;
		private var _passiveUpgrade:FlxButton;
		private var _title:FlxText;
		
		private var _ship:PlayerShip;
		
		public function UpgradeMenu() 
		{			
			_background = new FlxSprite(0, 0);
			_background.makeGraphic(680, 400, 0xdd111111);
			
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
			
			//This chunk should be moved eventually
			var gun1:OffsetGun = new OffsetGun();
			gun1.angleOffset = 0;
			gun1.bulletType = BulletType.BIG_CIRCLE;
			var gun2:OffsetGun = new OffsetGun();
			gun2.angleOffset = Math.PI / 18;
			gun2.bulletType = BulletType.BIG_CIRCLE;
			var gun3:OffsetGun = new OffsetGun();
			gun3.angleOffset = -1 * Math.PI / 18;
			gun3.bulletType = BulletType.BIG_CIRCLE;
			
			ship.removeAllGunUpgrades();
			ship.addGunUpgrade(gun1);
			ship.addGunUpgrade(gun2);
			ship.addGunUpgrade(gun3);
			
			trace("Weapon upgraded!");
			hide();
		}
		
		private function upgradeActive():void
		{
			var ship:PlayerShip = GameRegistry.gameState.playerManager.playerShip;
			ship.activeUpgrade = new ShieldUpgrade(ship);
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