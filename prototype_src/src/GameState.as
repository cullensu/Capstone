package  
{
	import org.flixel.FlxBasic;
	import org.flixel.FlxCamera;
	import org.flixel.plugin.photonstorm.FlxCollision;
	import org.flixel.FlxG;
	import org.flixel.FlxObject;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSound;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.plugin.photonstorm.FlxBar;
	import proj.BulletManager;
	import proj.EnemyManager;
	import proj.EnemyShip;
	import proj.Ship;
	import proj.StarField;
	import proj.Upgrade;
	import proj.UpgradeManager;
	/**
	 * ...
	 * @author Cullen
	 */
	public class GameState extends FlxState
	{
		protected var cooldown:int = 0;
		protected var turn:int = 0;
		protected var ship:Ship;
		protected var bulletManager:BulletManager;
		protected var enemyManager:EnemyManager;
		protected var upgradeManager:UpgradeManager;
		protected var oxygenBar:FlxBar;
		protected var starFieldTop:StarField;
		protected var starFieldMid:StarField;
		protected var starFieldBot:StarField;
		
		[Embed(source = "../assets/music/Bass.mp3")] private var wavBass:Class;
		[Embed(source = "../assets/music/Rhodes.mp3")] private var wavKeys:Class;
		[Embed(source = "../assets/music/Pad.mp3")] private var wavPad:Class;
		[Embed(source = "../assets/music/Strings.mp3")] private var wavStrings:Class;
		[Embed(source = "../assets/music/Synth.mp3")] private var wavSynth:Class;
		
		protected var soundBass:FlxSound;
		protected var soundKeys:FlxSound;
		protected var soundPad:FlxSound;
		protected var soundStrings:FlxSound;
		protected var soundSynth:FlxSound;
		
		public function GameState() 
		{
			super();
			
			starFieldTop = new StarField(2000, 1);
			starFieldTop.active = false;
			add(starFieldTop);
			starFieldMid = new StarField(2000, 0.66);
			starFieldMid.active = false;
			add(starFieldMid);
			starFieldBot = new StarField(2000, 0.33);
			starFieldBot.active = false;
			add(starFieldBot);
			
			ship = new Ship();
			add(ship);
			
			enemyManager = new EnemyManager();
			add(enemyManager);
			
			bulletManager = new BulletManager();
			add(bulletManager);
			
			upgradeManager = new UpgradeManager();
			add(upgradeManager);
			enemyManager.registerUpgradeCreationFunction(upgradeManager.generateNewUpgrade);
			
			oxygenBar = new FlxBar(350, 0, FlxBar.FILL_LEFT_TO_RIGHT, 100, 10, ship, "health", 0, ship.health, false);
			add(oxygenBar);
			oxygenBar.scrollFactor = new FlxPoint(0, 0);
			
			soundBass = (new FlxSound()).loadEmbedded(wavBass, true, true);
			soundKeys = (new FlxSound()).loadEmbedded(wavKeys, true, true);
			soundPad = (new FlxSound()).loadEmbedded(wavPad, true, true);
			soundSynth = (new FlxSound()).loadEmbedded(wavSynth, true, true);
			soundStrings = (new FlxSound()).loadEmbedded(wavStrings, true, true);
		}
		
		override public function create():void
		{
			// Make world 1000x wider/higher than screen to fix collisions
			FlxG.worldBounds.x = -400000
			FlxG.worldBounds.y = -300000
			FlxG.worldBounds.width = 800000
			FlxG.worldBounds.height = 600000
			
			super.create();
			ship.x = 0;
			ship.y = 0;
			FlxG.mouse.show();
			FlxG.camera.follow(ship, FlxCamera.STYLE_LOCKON);
			
			soundPad.volume = 0.0;
			soundKeys.volume = 0.0;
			soundBass.volume = 0.0;
			soundSynth.volume = 0.0;
			soundStrings.volume = 0.0;
			
			soundPad.update();
			soundKeys.update();
			soundBass.update();
			soundStrings.update();
			soundSynth.update();
			
			soundBass.play();
			soundKeys.play();
			soundPad.play();
			soundSynth.play();
			soundStrings.play();
		}
		
		override public function update():void
		{
			checkCollisions();
			updateOxygen();
			updateDebug();
			updateShip();
			updateFire();
			updateEnemy();
			updateUpgrades();
		}
		
		protected function bulletHit(bullet:FlxObject, enemy:FlxObject):void
		{
			bullet.kill();
			enemy.hurt(ship.damage);
		}
		
		protected function playerHit(player:FlxObject, enemy:FlxObject):void
		{
			player.hurt((enemy as EnemyShip).damage);
			enemy.kill();
		}
		
		protected function updateShip():void
		{
			var dx:int = 0;
			var dy:int = 0;
			if (FlxG.keys.W)
			{
				dy -= 1;
			}
			if (FlxG.keys.S)
			{
				dy += 1;
			}
			if (FlxG.keys.A)
			{
				dx -= 1;
			}
			if (FlxG.keys.D)
			{
				dx += 1;
			}
			
			var direction:String = getDirection(dx, dy);
			if (direction != "WTF")
			{
				ship.play(direction);
				dx = dx;
				dy = dy;
				ship.x += ship.speed * dx / Math.sqrt(dx*dx + dy*dy);
				ship.y += ship.speed * dy / Math.sqrt(dx*dx + dy*dy);
			}
		}
		
		protected function getDirection(x:int, y:int):String
		{
			if (x == 0 && y == -1)
			{
				return "N";
			}
			if (x == 1 && y == -1)
			{
				return "NE";
			}
			if (x == 1 && y == 0)
			{
				return "E";
			}
			if (x == 1 && y == 1)
			{
				return "SE";
			}
			if (x == 0 && y == 1)
			{
				return "S";
			}
			if (x == -1 && y == 1)
			{
				return "SW";
			}
			if (x == -1 && y == 0)
			{
				return "W";
			}
			if (x == -1 && y == -1)
			{
				return "NW";
			}
			return "WTF";
		}
		
		protected function updateFire():void 
		{
			if (cooldown == 0)
			{
				if (FlxG.mouse.pressed())
				{
					bulletManager.fire(ship.x, ship.y, FlxG.mouse.getWorldPosition().x, FlxG.mouse.getWorldPosition().y);
					cooldown = ship.cooldown;
				}
			} else {
				cooldown--;
			}
			
			bulletManager.update();
		}
		
		protected function updateEnemy():void 
		{
			enemyManager.registerTarget(ship.x, ship.y);
			enemyManager.update();
		}
		
		protected function updateDebug():void 
		{
			if (FlxG.keys.K)
			{
				FlxG.visualDebug = !FlxG.visualDebug;
			}
			if (FlxG.keys.justPressed("ONE")) {
				(soundPad.volume == 1.0) ? soundPad.volume = 0.0 : soundPad.volume = 1.0;
				soundPad.update();
			}
			if (FlxG.keys.justPressed("TWO")) {
				(soundKeys.volume == 1.0) ? soundKeys.volume = 0.0 : soundKeys.volume = 1.0;
				soundKeys.update();
			}
			if (FlxG.keys.justPressed("THREE")) {
				(soundBass.volume == 1.0) ? soundBass.volume = 0.0 : soundBass.volume = 1.0;
				soundBass.update();
			}
			if (FlxG.keys.justPressed("FOUR")) {
				(soundSynth.volume == 1.0) ? soundSynth.volume = 0.0 : soundSynth.volume = 1.0;
				soundSynth.update();
			}
			if (FlxG.keys.justPressed("FIVE")) {
				(soundStrings.volume == 1.0) ? soundStrings.volume = 0.0 : soundStrings.volume = 1.0;
				soundStrings.update();
			}
			if (FlxG.keys.justPressed("P")) {
				trace(ship.x, ship.y);
			}
		}
		
		protected function updateOxygen():void 
		{
			if (++turn % 10 == 0)
			{
				ship.health--;
			}
			oxygenBar.preUpdate();
			oxygenBar.update();
			oxygenBar.postUpdate();
		}
		
		protected function updateUpgrades():void
		{
			upgradeManager.update();
		}
		
		protected function upgradeCollected(ship:Ship, upgrade:Upgrade):void
		{
			upgrade.pickup(ship);
		}
		
		private function checkCollisions():void 
		{
			var enemies:Array = enemyManager.members;
			var bullets:Array = bulletManager.members;
			
			for (var ee:int = 0; ee < enemies.length; ee++)
			{
				var enemy:FlxSprite = enemies[ee] as FlxSprite;
				if (enemy == null || !enemy.exists) continue;
				if (FlxCollision.pixelPerfectCheck(ship, enemy))
					playerHit(ship, enemy);
				for (var bb:int = 0; bb < bullets.length; bb++)
				{
					var bullet:FlxSprite = bullets[bb] as FlxSprite;
					if (bullet == null || !bullet.exists) continue;
					if (FlxCollision.pixelPerfectCheck(bullet, enemy))
						bulletHit(bullet, enemy);
				}
			}
			
			var upgrades:Array = upgradeManager.members;
			for (var uu:int = 0; uu < upgrades.length; uu++)
			{
				var upgrade:Upgrade = upgrades[uu];
				if (upgrade == null || !upgrade.exists) continue;
				if (FlxCollision.pixelPerfectCheck(ship, upgrade))
					upgradeCollected(ship, upgrade);
			}
		}
	}

}