package proj
{
	import org.flixel.FlxSound;
	import org.flixel.plugin.photonstorm.FlxBar;
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author Cullen
	 */
	public class EnemyShip extends Ship
	{
		[Embed(source = "../../assets/redship.png")] private var redShipPNG:Class;
		[Embed(source = "../../assets/sfx/EnemyHurt.mp3")] private var sfxHurt:Class;
		
		protected static const UPGRADE_DROP_CHANCE:Number = 1;
		
		protected var targetx:int;
		protected var targety:int;
		
		protected var upgradeCreationFunction:Function;
		
		public function EnemyShip() 
		{
			super();
			create();
			soundHurt = (new FlxSound()).loadEmbedded(sfxHurt, false, false);
			speed = 50;
			damage = 20;
		}
		
		public function create():void
		{
			velocity.x = 0;
			velocity.y = 0;
			targetx = 0;
			targety = 0;
			regenerate();
		}
		
		public function registerUpgradeCreationFunction(f:Function):void
		{
			upgradeCreationFunction = f;
		}
		
		override protected function loadShipGraphic():void
		{
			loadRotatedGraphic(redShipPNG, 8, -1, true, true);
		}
		
		public function regenerate():void
		{
			health = 100;
			
			var angle:Number = Math.random() * 2 * Math.PI;
			var radius:int = 550;
			
			x = targetx + Math.cos(angle) * radius;
			y = targety + Math.sin(angle) * radius;
			
			exists = true;
		}
		
		public function registerTarget(x:int, y:int):void
		{
			targetx = x;
			targety = y;
		}
		
		override public function kill():void
		{
			super.kill();
			var rand:Number = Math.random();
			if (rand < UPGRADE_DROP_CHANCE)
			{
				upgradeCreationFunction(x, y);
			}
			regenerate();
		}
		
		override public function update():void
		{
			super.preUpdate();
			super.update();
			super.postUpdate();
			var dx:int = targetx - x;
			var dy:int = targety - y;
			var magnitude:Number = Math.sqrt(dx * dx + dy * dy);
			
			if (magnitude != 0)
			{
				velocity.x = dx / magnitude * speed;
				velocity.y = dy / magnitude * speed;
			}	
		}
	}

}