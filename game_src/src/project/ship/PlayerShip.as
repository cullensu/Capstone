package project.ship
{
	import org.flixel.FlxSprite;
	import project.constant.Constants;
	import project.constant.GameRegistry;
	import project.util.Affiliation;
	import project.util.Direction;
	/**
	 * ...
	 * @author Cullen
	 */
	public class PlayerShip extends Ship
	{
		[Embed(source = "../../../assets/playershipsheet.png")] private var _shipPng:Class
		protected var _gunCooldown:uint;
		protected var _direction:String;
		protected var _xDir:Number;
		protected var _yDir:Number;
		
		protected var _currentCooldown:uint;

		protected var _speed:Number;

		public function PlayerShip(X:Number=0,Y:Number=0,SimpleGraphic:Class=null)
		{
			super(X, Y, null);
			loadGraphic(_shipPng, true, false, 30, 30);
			_gunXOffset = 15;
			_gunYOffset = 15;
			_gunCooldown = 20;
			_speed = 400;
			_affiliation = Affiliation.PLAYER;
			//TODO: addAnimation x24
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
		
		public function fire(targetX:Number, targetY:Number):void
		{
			if (_currentCooldown == 0)
			{
				GameRegistry.gameState.bulletManager.fire(this, targetX, targetY);
				_currentCooldown = _gunCooldown;
			}
		}

		override public function preUpdate():void
		{
			super.preUpdate();
			_direction = Direction.getDirection(_xDir, _yDir);
			velocity = Direction.getVelocityVector(_direction, _speed);
			if (_currentCooldown > 0)
			{
				_currentCooldown--;
			}
		}

		override public function postUpdate():void
		{
			stopMovement();
			super.postUpdate();
		}

	}

}