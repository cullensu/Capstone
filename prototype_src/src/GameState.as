package  
{
	import org.flixel.FlxCamera;
	import org.flixel.plugin.photonstorm.FlxCollision;
	import org.flixel.FlxG;
	import org.flixel.FlxObject;
	import org.flixel.FlxSound;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.plugin.photonstorm.FlxBar;
	import proj.BulletManager;
	import proj.EnemyManager;
	import proj.EnemyShip;
	import proj.Ship;
	import proj.StarField;
	/**
	 * ...
	 * @author Cullen
	 */
	public class GameState extends FlxState
	{
		public var shipSpeed:int = 3;
		protected var cooldown:int = 0;
		protected var ship:Ship;
		protected var bulletManager:BulletManager;
		protected var enemyManager:EnemyManager;
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
			
			starFieldTop = new StarField(1000, 1);
			add(starFieldTop);
			starFieldMid = new StarField(1000, 0.66);
			add(starFieldMid);
			starFieldBot = new StarField(1000, 0.33);
			add(starFieldBot);
			
			ship = new Ship();
			add(ship);
			
			enemyManager = new EnemyManager();
			add(enemyManager);
			
			bulletManager = new BulletManager();
			add(bulletManager);
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
			
			soundBass = (new FlxSound()).loadEmbedded(wavBass, true, true);
			soundKeys = (new FlxSound()).loadEmbedded(wavKeys, true, true);
			soundPad = (new FlxSound()).loadEmbedded(wavPad, true, true);
			soundSynth = (new FlxSound()).loadEmbedded(wavSynth, true, true);
			soundStrings = (new FlxSound()).loadEmbedded(wavStrings, true, true);
			
			soundBass.volume = 0.0;
			soundBass.update();
			soundSynth.volume = 0.0;
			soundSynth.update();
			soundStrings.volume = 0.0;
			soundStrings.update();
			
			soundBass.play();
			soundKeys.play();
			soundPad.play();
			soundSynth.play();
			soundStrings.play();
		}
		
		override public function update():void
		{
			updateDebug();
			updateShip();
			updateFire();
			updateEnemy();
		}
		
		protected function bulletHit(obj1:FlxObject, obj2:FlxObject):void
		{
			trace ("hit");
			obj1.kill();
			obj2.hurt(1);
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
				ship.x += shipSpeed * dx / Math.sqrt(dx*dx + dy*dy);
				ship.y += shipSpeed * dy / Math.sqrt(dx*dx + dy*dy);
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
					cooldown = 10;
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
			
			FlxG.overlap(bulletManager, enemyManager, bulletHit);
		}
		
		protected function updateDebug():void 
		{
			if (FlxG.keys.K)
			{
				FlxG.visualDebug = !FlxG.visualDebug;
			}
			if (FlxG.keys.justPressed("NUMPADONE")) {
				(soundPad.volume == 1.0) ? soundPad.volume = 0.0 : soundPad.volume = 1.0;
				soundPad.update();
			}
			if (FlxG.keys.justPressed("NUMPADTWO")) {
				(soundKeys.volume == 1.0) ? soundKeys.volume = 0.0 : soundKeys.volume = 1.0;
				soundKeys.update();
			}
			if (FlxG.keys.justPressed("NUMPADTHREE")) {
				(soundBass.volume == 1.0) ? soundBass.volume = 0.0 : soundBass.volume = 1.0;
				soundBass.update();
			}
			if (FlxG.keys.justPressed("NUMPADFOUR")) {
				(soundSynth.volume == 1.0) ? soundSynth.volume = 0.0 : soundSynth.volume = 1.0;
				soundSynth.update();
			}
			if (FlxG.keys.justPressed("NUMPADFIVE")) {
				(soundStrings.volume == 1.0) ? soundStrings.volume = 0.0 : soundStrings.volume = 1.0;
				soundStrings.update();
			}
			if (FlxG.keys.justPressed("P")) {
				trace(ship.x, ship.y);
			}
		}
	}

}