package project.ship 
{
	import org.flixel.FlxSprite;
	import project.constant.Constants;
	import project.util.Direction;
	/**
	 * ...
	 * @author Cullen
	 */
	public class PlayerShip extends Ship
	{
		[Embed(source = "../../../assets/playership.png")] private var _shipPng:Class
		
		protected var _direction:String;
		protected var _xDir:Number;
		protected var _yDir:Number;
		
		protected var _speed:Number;
		
		public function PlayerShip(X:Number=0,Y:Number=0,SimpleGraphic:Class=null) 
		{
			super(X, Y, SimpleGraphic == null ? _shipPng : SimpleGraphic);
			
			_speed = 300;
		}
		
		/**
		 * Sets the x direction of the player ship
		 * @param	xDir
		 */
		public function setXDirection(xDir:int):void
		{
			_xDir = xDir;
		}
		
		/**
		 * Sets the y direction of the player ship
		 * @param	yDir
		 */
		public function setYDirection(yDir:int):void
		{
			_yDir = yDir;
		}
		
		/**
		 * Stops the movement of the player ship
		 */
		public function stopMovement():void
		{
			_xDir = 0;
			_yDir = 0;
		}
		
		override public function preUpdate():void
		{
			super.preUpdate();
			_direction = Direction.getDirection(_xDir, _yDir);
			
			velocity = Direction.getVelocityVector(_direction, _speed);
		}
		
		override public function postUpdate():void
		{
			stopMovement();
			super.postUpdate();
		}
		
	}

}