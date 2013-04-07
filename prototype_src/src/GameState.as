package  
{
	import org.flixel.FlxG;
	import org.flixel.FlxObject;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.plugin.photonstorm.FlxBar;
	import proj.BulletManager;
	import proj.EnemyManager;
	import proj.EnemyShip;
	import proj.Ship;
	/**
	 * ...
	 * @author Cullen
	 */
	public class GameState extends FlxState
	{
		public var shipSpeed:int = 3;
		protected var ship:Ship;
		protected var bulletManager:BulletManager;
		protected var enemyManager:EnemyManager;
		
		public function GameState() 
		{
			super();
			ship = new Ship();
			add(ship);
			
			enemyManager = new EnemyManager();
			add(enemyManager);
			
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
			
			if (FlxG.mouse.justPressed())
			{
				bulletManager.fire(ship.x, ship.y, FlxG.mouse.getWorldPosition().x, FlxG.mouse.getWorldPosition().y);
			}
			
			enemyManager.registerTarget(ship.x, ship.y);
			enemyManager.update();
			bulletManager.update();
			
			FlxG.overlap(bulletManager, enemyManager, bulletHit);
		}
		
		protected function bulletHit(obj1:FlxObject, obj2:FlxObject):void
		{
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
	}

}