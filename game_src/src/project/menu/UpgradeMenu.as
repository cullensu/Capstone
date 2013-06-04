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
	import project.upgrade.active.CloakUpgrade;
	import project.upgrade.active.ShieldUpgrade;
	import project.upgrade.active.TeleportUpgrade;
	import project.upgrade.guns.GunUpgradeFactory;
	import project.upgrade.guns.OffsetGun;
	import project.upgrade.GunUpgrade;
	import project.util.Utility;
	/**
	 * ...
	 * @author akirilov
	 */
	
	public class UpgradeMenu extends Menu
	{
		[Embed(source = "../../../assets/upgradetitle.png")] protected var UpgradeTitle:Class;
		[Embed(source = "../../../assets/upgradegun.png")] protected var UpgradeGun:Class;
		[Embed(source = "../../../assets/upgradeactive.png")] protected var UpgradeActive:Class;
		[Embed(source = "../../../assets/upgradedouble.png")] protected var UpgradeDouble:Class;
		[Embed(source = "../../../assets/upgradetriple.png")] protected var UpgradeTriple:Class;
		[Embed(source = "../../../assets/upgradequadruple.png")] protected var UpgradeQuadruple:Class;
		[Embed(source = "../../../assets/upgradeshield.png")] protected var UpgradeShield:Class;
		[Embed(source = "../../../assets/upgradeblink.png")] protected var UpgradeBlink:Class;
		[Embed(source = "../../../assets/upgradecloak.png")] protected var UpgradeCloak:Class;
		
		// Backgrounf
		private var _background:FlxSprite;
		
		// Labels
		private var upgradeTitleLbl:FlxSprite;
		private var upgradeGunLbl:FlxSprite;
		private var upgradeActiveLbl:FlxSprite;
		
		// Gun Upgrades
		private var upgradeDouble:FlxButton;
		private var upgradeTriple:FlxButton;
		private var upgradeQuadruple:FlxButton;
		
		// Active Upgrades
		private var upgradeShield:FlxButton;
		private var upgradeBlink:FlxButton;
		private var upgradeCloak:FlxButton;

		// Consts
		private static const X_OFFSET:int = 50;
		private static const Y_OFFSET:int = 80;
		
		// State
		private var _gunFactory:GunUpgradeFactory;
		private var _tier:int = 1;
		
		private var _ship:PlayerShip;
		
		public function UpgradeMenu() 
		{	
			// ##############
			// # BACKGROUND #
			// ##############
			
			_background = new FlxSprite(X_OFFSET, Y_OFFSET);
			_background.makeGraphic(700, 400, 0xee111111);
			_background.scrollFactor = new FlxPoint(0, 0);
			add(_background);
			
			// ##########
			// # LABELS #
			// ##########
			upgradeTitleLbl = new FlxSprite(X_OFFSET + 203, Y_OFFSET + 34, UpgradeTitle);
			upgradeTitleLbl.scrollFactor = new FlxPoint(0, 0);
			add(upgradeTitleLbl);
			
			upgradeGunLbl = new FlxSprite(X_OFFSET + 127, Y_OFFSET + 109, UpgradeGun);
			upgradeGunLbl.scrollFactor = new FlxPoint(0, 0);
			add(upgradeGunLbl);
			
			upgradeActiveLbl = new FlxSprite(X_OFFSET + 313, Y_OFFSET + 109, UpgradeActive);
			upgradeActiveLbl.scrollFactor = new FlxPoint(0, 0);
			add(upgradeActiveLbl);
			
			// ###########
			// # BUTTONS #
			// ###########
			upgradeDouble = new FlxButton(X_OFFSET + 100, Y_OFFSET +  200, null, upgradeWeapon);
			upgradeDouble.loadGraphic(UpgradeDouble);
			upgradeDouble.scrollFactor = new FlxPoint(0, 0);
			upgradeDouble.exists = false;
			add(upgradeDouble);
			
			upgradeTriple = new FlxButton(X_OFFSET + 100, Y_OFFSET +  200, null, upgradeWeapon);
			upgradeTriple.loadGraphic(UpgradeTriple);
			upgradeTriple.scrollFactor = new FlxPoint(0, 0);
			upgradeTriple.exists = false;
			add(upgradeTriple);
			
			upgradeQuadruple = new FlxButton(X_OFFSET + 100, Y_OFFSET +  200, null, upgradeWeapon);
			upgradeQuadruple.loadGraphic(UpgradeQuadruple);
			upgradeQuadruple.scrollFactor = new FlxPoint(0, 0);
			upgradeQuadruple.exists = false;
			add(upgradeQuadruple);
			
			upgradeShield = new FlxButton(X_OFFSET + 300, Y_OFFSET +  200, null, getShield);
			upgradeShield.loadGraphic(UpgradeShield);
			upgradeShield.scrollFactor = new FlxPoint(0, 0);
			upgradeShield.exists = false;
			add(upgradeShield);
			
			upgradeBlink = new FlxButton(X_OFFSET + 300, Y_OFFSET +  200, null, getBlink);
			upgradeBlink.loadGraphic(UpgradeBlink);
			upgradeBlink.scrollFactor = new FlxPoint(0, 0);
			upgradeBlink.exists = false;
			add(upgradeBlink);
			
			upgradeCloak = new FlxButton(X_OFFSET + 300, Y_OFFSET +  200, null, getCloak);
			upgradeCloak.loadGraphic(UpgradeCloak);
			upgradeCloak.scrollFactor = new FlxPoint(0, 0);
			upgradeCloak.exists = false;
			add(upgradeCloak);
			
			// Init factory
			_gunFactory = new GunUpgradeFactory();
			
			this.exists = false;
		}
		
		override public function show():void 
		{
			super.show();

			upgradeDouble.exists = false;
			upgradeTriple.exists = false;
			upgradeQuadruple.exists = false;
				
			if (_tier == 1) {
				upgradeDouble.exists = true;
			} else if (_tier == 2) {
				upgradeTriple.exists = true;
			} else  if (_tier == 3) {
				upgradeQuadruple.exists = true;
			}
			
			upgradeShield.exists = false;
			upgradeBlink.exists = false;
			upgradeCloak.exists = false;
			var activeRoll:int = Utility.randomInt(3);
			
			if (activeRoll == 0) {
				upgradeShield.exists = true;
			} else if (activeRoll == 1) {
				upgradeBlink.exists = true;
			} else {
				upgradeCloak.exists = true;
			}
		}
		
		private function upgradeWeapon():void
		{
			var ship:PlayerShip = GameRegistry.gameState.playerManager.playerShip;	
			var guns:Vector.<GunUpgrade> = _gunFactory.getGunUpgrade(_tier);
			
			ship.removeAllGunUpgrades();
			for each (var gun:GunUpgrade in guns)
			{
				ship.addGunUpgrade(gun);
			}
			
			_tier = Math.min(_tier + 1, 4);
			trace("Weapon upgraded!");
			hide();
		}
		
		private function getShield():void
		{
			var ship:PlayerShip = GameRegistry.gameState.playerManager.playerShip;
			ship.activeUpgrade.deactivate();
			ship.activeUpgrade = new ShieldUpgrade(ship);
			GameRegistry.hud.updateActiveBar();
			
			trace("Shield acquired!");
			hide();
		}
		
		private function getBlink():void
		{
			var ship:PlayerShip = GameRegistry.gameState.playerManager.playerShip;
			ship.activeUpgrade.deactivate();
			ship.activeUpgrade = new TeleportUpgrade(ship);
			GameRegistry.hud.updateActiveBar();
			
			trace("Blink acquired!");
			hide();
		}
		
		private function getCloak():void
		{
			var ship:PlayerShip = GameRegistry.gameState.playerManager.playerShip;
			ship.activeUpgrade.deactivate();
			ship.activeUpgrade = new CloakUpgrade(ship);
			GameRegistry.hud.updateActiveBar();
			
			trace("Cloak acquired!");
			hide();
		}
	}

}