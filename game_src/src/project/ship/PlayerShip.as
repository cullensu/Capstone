package project.ship
{
	import flash.media.Video;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import project.bullet.BulletType;
	import project.constant.Constants;
	import project.constant.GameRegistry;
	import project.upgrade.guns.OffsetGun;
	import project.upgrade.GunUpgrade;
	import project.util.Affiliation;
	import project.util.Direction;
	/**
	 * ...
	 * @author Cullen
	 */
	public class PlayerShip extends Ship
	{
		[Embed(source = "../../../assets/playershipsheet.png")] private var _shipPng:Class
		protected var _xDir:Number;
		protected var _yDir:Number;
		
		protected var _direction:String;

		protected var _speed:Number;

		public function PlayerShip(X:Number=0,Y:Number=0,SimpleGraphic:Class=null)
		{
			super(X, Y, null);
			FlxG.watch(this, "x", "x");
			FlxG.watch(this, "y", "y");
			loadGraphic(_shipPng, true, false, 30, 30);
			_gunXOffset = 15;
			_gunYOffset = 15;
			_speed = 400;
			_affiliation = Affiliation.PLAYER;
			
			var gun1:OffsetGun = new OffsetGun();
			gun1.angleOffset = 0;
			gun1.bulletType = BulletType.CIRCLE;
			var gun2:OffsetGun = new OffsetGun();
			gun2.angleOffset = Math.PI / 6;
			gun2.bulletType = BulletType.SQUARE;
			var gun3:OffsetGun = new OffsetGun();
			gun3.angleOffset = -1 * Math.PI / 6;
			gun3.bulletType = BulletType.TRIANGLE;
			addGunUpgrade(gun1);
			addGunUpgrade(gun2);
			addGunUpgrade(gun3);
			
			addAnimation("0", [0], 0, false);
			addAnimation("1", [1], 0, false);
			addAnimation("2", [2], 0, false);
			addAnimation("3", [3], 0, false);
			addAnimation("4", [4], 0, false);
			addAnimation("5", [5], 0, false);
			addAnimation("6", [6], 0, false);
			addAnimation("7", [7], 0, false);
			addAnimation("8", [8], 0, false);
			addAnimation("9", [9], 0, false);
			addAnimation("10", [10], 0, false);
			addAnimation("11", [11], 0, false);
			addAnimation("12", [12], 0, false);
			addAnimation("13", [13], 0, false);
			addAnimation("14", [14], 0, false);
			addAnimation("15", [15], 0, false);
			addAnimation("16", [16], 0, false);
			addAnimation("17", [17], 0, false);
			addAnimation("18", [18], 0, false);
			addAnimation("19", [19], 0, false);
			addAnimation("20", [20], 0, false);
			addAnimation("21", [21], 0, false);
			addAnimation("22", [22], 0, false);
			addAnimation("23", [23], 0, false);
			addAnimation("24", [24], 0, false);
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
		
		override public function update():void
		{
			super.update();
			for each (var gun:GunUpgrade in _guns)
			{
				gun.preUpdate();
				gun.update();
				gun.postUpdate();
			}
		}

		override public function postUpdate():void
		{
			stopMovement();
			super.postUpdate();
		}

	}

}