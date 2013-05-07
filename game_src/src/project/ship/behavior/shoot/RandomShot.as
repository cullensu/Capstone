package project.ship.behavior.shoot 
{
	import project.ship.AIShip;
	import project.ship.Ship;
	import project.util.CartesianPoint;
	import project.util.PolarPoint;
	/**
	 * ...
	 * @author Cullen
	 */
	public class RandomShot implements IShipShoot
	{
		
		public function RandomShot() 
		{
			
		}
		
		public function shoot(ship:AIShip):void
		{
			var polar:PolarPoint = new PolarPoint(100, Math.random() * 2 * Math.PI);
			var rect:CartesianPoint = polar.convertToCartesianPoint();
			ship.fire(ship.x + ship.gunXOffset + rect.x, ship.y + ship.gunYOffset + rect.y);
		}
		
	}

}