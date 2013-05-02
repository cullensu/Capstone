package project.ship.behavior 
{
	import project.ship.behavior.move.IShipMovement;
	import project.ship.behavior.shoot.IShipShoot;
	/**
	 * ...
	 * @author Cullen
	 */
	public class ShipBehavior 
	{
		protected var _movement:IShipMovement;
		protected var _shooting:IShipShoot;
		
		public function ShipBehavior() 
		{
			
		}
		
		public function get movement():IShipMovement 
		{
			return _movement;
		}
		
		public function set movement(value:IShipMovement):void 
		{
			_movement = value;
		}
		
		public function get shooting():IShipShoot 
		{
			return _shooting;
		}
		
		public function set shooting(value:IShipShoot):void 
		{
			_shooting = value;
		}
		
	}

}