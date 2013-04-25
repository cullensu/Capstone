package project.ship 
{
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Cullen
	 */
	public class PlayerShip extends Ship
	{
		[Embed(source = "../../../assets/playership.png")] private var _shipPng:Class
		
		protected var _direction:String;
		
		
		public function PlayerShip(X:Number=0,Y:Number=0,SimpleGraphic:Class=null) 
		{
			super(X, Y, SimpleGraphic == null ? _shipPng : SimpleGraphic);
		}
		
		public function setDirection(xDir:int, yDir:int):void
		{
			
		}
		
		public function stopMovement():void
		{
			
		}
		
	}

}