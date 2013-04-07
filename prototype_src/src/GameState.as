package  
{
	import org.flixel.FlxG;
	import org.flixel.FlxState;
	import proj.BulletManager;
	import proj.EnemyShip;
	import proj.Ship;
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
		protected var enemyShip:EnemyShip;
		
		public function GameState() 
		{
			super();
			ship = new Ship();
			add(ship);
			
			enemyShip = new EnemyShip();
			add(enemyShip);
			
			bulletManager = new BulletManager();
			add(bulletManager);
		}
		
		override public function create():void
		{
			FlxG.mouse.show();
		}
		
		override public function update():void
		{
			
			updateShip();
			
			updateFire();
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
			
			if (!enemyShip.exists)
			{
				enemyShip.regenerate();
			}
			enemyShip.registerTarget(ship.x, ship.y);
			enemyShip.update();
			
			bulletManager.update();
		}
	}

}