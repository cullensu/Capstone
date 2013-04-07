package proj 
{
	/**
	 * ...
	 * @author Cullen
	 */
	public class EnemyShip extends Ship
	{
		[Embed(source = "../../assets/redship.png")] private var redShipPNG:Class;
		
		protected var targetx:int;
		protected var targety:int;
		
		protected var speed:int = 2;
		
		public function EnemyShip() 
		{
			super();
		}
		
		override protected function loadShipGraphic():void
		{
			loadRotatedGraphic(redShipPNG, 8, -1, true, true);
		}
		
		public function regenerate():void
		{
			
		}
		
		public function registerTarget(x:int, y:int):void
		{
			targetx = x;
			targety = y;
		}
		
		override public function update():void
		{
			var dx:int = targetx - x;
			var dy:int = targety - y;
			var magnitude:Number = Math.sqrt(dx * dx + dy * dy);
			
			velocity.x = dx / magnitude * speed;
			velocity.y = dy / magnitude * speed;
		}
	}

}