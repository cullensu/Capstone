package proj 
{
	import org.flixel.plugin.photonstorm.FlxBar;
	/**
	 * ...
	 * @author Cullen
	 */
	public class EnemyShip extends Ship
	{
		[Embed(source = "../../assets/redship.png")] private var redShipPNG:Class;
		
		protected var targetx:int;
		protected var targety:int;
		
		protected var speed:int = 50;
		
		public function EnemyShip() 
		{
			super();
			create();
			
		}
		
		public function create():void
		{
			health = 3;
			x = 400;
			y = 400;
			velocity.x = 50;
			velocity.y = 0;
		}
		
		override protected function loadShipGraphic():void
		{
			loadRotatedGraphic(redShipPNG, 8, -1, true, true);
		}
		
		public function regenerate():void
		{
			health = 3;
			x = Math.random() * 800;
			y = Math.random() * 600;
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