package project.ship.behavior.shoot 
{
	import project.ship.AIShip;
	import project.ship.Ship;
	import project.util.CartesianPoint;
	import project.util.PolarPoint;
	import project.util.Utility;
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
			var randpolar:PolarPoint = new PolarPoint(100, Utility.random() * 2 * Math.PI);
			var randrect:CartesianPoint = randpolar.convertToCartesianPoint();
			ship.fire(ship.x + ship.gunXOffset + randrect.x, ship.y + ship.gunYOffset + randrect.y);
		}
		
	}

}