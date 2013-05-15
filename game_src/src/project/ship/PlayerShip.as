package project.ship
{
	import flash.media.Video;
	import org.flixel.FlxG;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import project.bullet.BulletType;
	import project.constant.Constants;
	import project.constant.GameRegistry;
	import project.state.MenuState;
	import project.upgrade.active.NullActive;
	import project.upgrade.drops.DropType;
	import project.upgrade.drops.DropUpgrade;
	import project.upgrade.guns.OffsetGun;
	import project.upgrade.GunUpgrade;
	import project.util.Affiliation;
	import project.util.Direction;
	import project.util.ICollidable;
	/**
	 * ...
	 * @author Cullen
	 */
	public class PlayerShip extends Ship
	{
		[Embed(source = "../../../assets/playershipsheet.png")] private var _shipPng:Class
		[Embed(source="../../../assets/sfx/PlayerHurt.mp3")] private var _hurtmp3:Class
		protected var _xDir:Number;
		protected var _yDir:Number;
		
		protected var _direction:String;
		protected var _maxCoord:int;
		
		protected var _healthDrainRate:Number;
		
		protected var _bonusDamage:Number;
		protected var _bonusCooldown:Number;
		protected var _bonusMoveSpeed:Number;

		public function PlayerShip(X:Number=0,Y:Number=0,SimpleGraphic:Class=null)
		{
			super(X, Y, null);
			FlxG.watch(this, "x", "x");
			FlxG.watch(this, "y", "y");
			loadGraphic(_shipPng, true, false, 30, 30);
			_maxCoord = Constants.WORLDTILES * Constants.TILESIZE;
			_gunXOffset = 15;
			_gunYOffset = 15;
			_speed = Constants.STARTING_MOVE_SPEED;
			_bonusDamage = Constants.STARTING_BONUS_DAMAGE;
			_bonusCooldown = Constants.STARTING_BONUS_COOLDOWN;
			_bonusMoveSpeed = Constants.STARTING_BONUS_MOVE_SPEED;
			_affiliation = Affiliation.PLAYER;
			
			_maxHealth = Constants.OXYGEN_MAX;
			health = _maxHealth;
			_healthDrainRate = Constants.STARTING_HEALTH_DRAIN_RATE;
			
			//This chunk should be moved eventually
			var gun1:OffsetGun = new OffsetGun();
			gun1.angleOffset = 0;
			gun1.gunCooldown = Constants.STARTING_PLAYER_GUN_COOLDOWN;
			gun1.bulletType = BulletType.BIG_CIRCLE;
			addGunUpgrade(gun1);
			
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
			velocity = Direction.getVelocityVector(_direction, speed);
		}
		
		override public function update():void
		{
			super.update();
			activeUpgrade.update();
			
			//Check world bounds
			if (x < 0) {
				x = 0;
			} else if (x > _maxCoord) {
				x = _maxCoord;
			}
			if (y < 0) {
				y = 0;
			} else if (y > _maxCoord) {
				y = _maxCoord;
			}
			
			//Drain Health
			health = health - FlxG.elapsed * _healthDrainRate;
			
			//update graphic
			var healthDisplay:int = 24 - health / maxHealth * 24;
			this.play(healthDisplay.toString());
		}

		override public function postUpdate():void
		{
			stopMovement();
			super.postUpdate();
		}
		
		public function get baseSpeed():Number
		{
			return _speed;
		}
		
		/**
		 * Returns the speed with bonus move speed added
		 */
		override public function get speed():Number
		{
			return super.speed + _bonusMoveSpeed;
		}
		
		public function get healthDrainRate():Number 
		{
			return _healthDrainRate;
		}
		
		public function set healthDrainRate(value:Number):void 
		{
			_healthDrainRate = value;
		}
		
		public function get bonusCooldown():Number 
		{
			return _bonusCooldown;
		}
		
		public function set bonusCooldown(value:Number):void 
		{
			_bonusCooldown = value;
		}
		
		public function get bonusCooldownDisplayTracker():Number
		{
			return 100 * (_bonusCooldown - Constants.STARTING_BONUS_COOLDOWN) / (Constants.MAX_BONUS_COOLDOWN - Constants.STARTING_BONUS_COOLDOWN)
		}
		
		public function get bonusDamage():Number 
		{
			return _bonusDamage;
		}
		
		public function set bonusDamage(value:Number):void 
		{
			_bonusDamage = value;
		}
		
		public function get bonusMoveSpeed():Number 
		{
			return _bonusMoveSpeed;
		}
		
		public function set bonusMoveSpeed(value:Number):void 
		{
			_bonusMoveSpeed = value;
		}
		
		override public function kill():void
		{
			super.kill();
			
			//TODO: Put more end game stuff in here
			trace("GAME OVER");
			
			if (GameRegistry.recording)
			{
				GameRegistry.gameState.stopRecording();
			}
			FlxG.switchState(new MenuState());
		}
		
		override public function canCollide(other:ICollidable):Boolean
		{
			var result:Boolean = super.canCollide(other);
			result ||= (other is DropUpgrade);
			return result;
		}
		
		override public function collide(other:ICollidable):void
		{
			FlxG.play(_hurtmp3);
			if (super.canCollide(other))
			{
				super.collide(other);
			}
			else if (other is DropUpgrade)
			{
				var dropUpgrade:DropUpgrade = other as DropUpgrade;
				dropUpgrade.applyUpgradeToShip(this);
			}
			if (health > maxHealth) 
			{
				health = maxHealth;
			}
		}
		
		override public function fire(targetX:Number, targetY:Number, addVelocity:FlxPoint = null):void
		{
			for each (var gun:GunUpgrade in _guns)
			{
				gun.fire(targetX, targetY, addVelocity, _bonusDamage, _bonusCooldown);
			}
		}

	}
}