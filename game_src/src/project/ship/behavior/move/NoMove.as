package project.ship.behavior.move 
{
	import project.ship.AIShip;
	/**
	 * ...
	 * @author Cullen
	 */
	public class NoMove implements IShipMovement
	{
		
		public function NoMove() 
		{
			
		}
		
		public function move(ship:AIShip):void
		{
			ship.velocity.x = 0;
			ship.velocity.y = 0;
			return;
		}
	}

}