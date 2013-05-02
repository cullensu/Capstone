package project.ship 
{
	/**
	 * ...
	 * @author Cullen
	 */
	public class EnemyShip 
	{
		[Embed(source = "../../../assets/enemynormal.png")] private var _shipPng:Class;
		
		
		public function EnemyShip(X:Number=0,Y:Number=0,SimpleGraphic:Class=null) 
		{
			super(X, Y, SimpleGraphic);
		}
		
	}

}