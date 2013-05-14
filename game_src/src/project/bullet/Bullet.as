package project.bullet 
{
	import flash.geom.Point;
	import org.flixel.FlxPoint;
	import org.flixel.FlxG;
	import project.objects.AffiliatedObject;
	import project.ship.Ship;
	import project.util.Affiliation;
	import project.util.ICollidable;
	import project.util.Utility;
	/**
	 * ...
	 * @author Cullen
	 */
	public class Bullet extends AffiliatedObject implements ICollidable
	{
		[Embed(source = "../../../assets/playerbullet.png")] private var playerBulletSpr:Class;
		[Embed(source = "../../../assets/enemybullet.png")] private var enemyBulletSpr:Class;
		[Embed(source = "../../../assets/neutralbullet.png")] private var neutralBulletSpr:Class;
		[Embed(source = "../../../assets/playerbulletbig.png")] private var playerBigBulletSpr:Class;
		[Embed(source = "../../../assets/neutralbulletbig.png")] private var neutralBigBulletSpr:Class;
		[Embed(source = "../../../assets/enemybulletbig.png")] private var enemyBigBulletSpr:Class;
		
		[Embed(source = "../../../assets/sfx/EnemyShoot.mp3")] private var _enemyShootmp3:Class;
		[Embed(source = "../../../assets/sfx/PlayerShoot.mp3")] private var _playerShootmp3:Class;
		
		private static const PLAYER_BULLET_DIMENSIONS:Point = new Point(5, 5);
		private static const ENEMY_BULLET_DIMENSION:Point = new Point(5, 4);
		private static const NEUTRAL_BULLET_DIMENSIONS:Point = new Point(5, 5);
		private static const PLAYER_BIG_BULLET_DIMENSIONS:Point = new Point(10, 10);
		private static const ENEMY_BIG_BULLET_DIMENSIONS:Point = new Point(10, 9);
		private static const NEUTRAL_BIG_BULLET_DIMENSIONS:Point = new Point(10, 10);
		
		protected static const WIDTH:Number = 5;
		protected static const HEIGHT:Number = 5;
		
		protected var _speed:Number = 600;
		protected var _collisionDamage:Number = 10;
		
		protected var _bonusDamage:Number = 0;
		
		/**
		 * Type for the bullet
		 */
		protected var _type:BulletType;
		
		/**
		 * The type of bullet currently drawn, this keeps track of which graphic is loaded to avoid unneeded reloading of graphics
		 */
		private var _graphicType:BulletType;
		
		public function Bullet(X:Number=0,Y:Number=0,SimpleGraphic:Class=null) 
		{
			super(X, Y, SimpleGraphic);
			_type = BulletType.CIRCLE;
			reloadGraphicAndDamage();
			exists = false;
		}
		
		/**
		 * Reloads the graphic for this bullet if needed
		 */
		protected function reloadGraphicAndDamage():void
		{
			if (_type != _graphicType)
			{
				if (_type == BulletType.CIRCLE)
				{
					loadGraphic(playerBulletSpr, false, false, PLAYER_BULLET_DIMENSIONS.x, PLAYER_BULLET_DIMENSIONS.y);
					_collisionDamage = 10;
					_speed = 600;
				}
				else if (_type == BulletType.SQUARE)
				{
					loadGraphic(neutralBulletSpr, false, false, NEUTRAL_BULLET_DIMENSIONS.x, NEUTRAL_BULLET_DIMENSIONS.y);
					_collisionDamage = 10;
					_speed = 600;
				}
				else if (_type == BulletType.TRIANGLE)
				{
					loadGraphic(enemyBulletSpr, false, false, ENEMY_BULLET_DIMENSION.x, ENEMY_BULLET_DIMENSION.y);
					_collisionDamage = 10;
					_speed = 600;
				}
				else if (_type == BulletType.BIG_CIRCLE)
				{
					loadGraphic(playerBigBulletSpr, false, false, PLAYER_BIG_BULLET_DIMENSIONS.x, PLAYER_BIG_BULLET_DIMENSIONS.y);
					_collisionDamage = 20;
					_speed = 500;
				}
				else if (_type == BulletType.BIG_SQUARE)
				{
					loadGraphic(neutralBigBulletSpr, false, false, NEUTRAL_BIG_BULLET_DIMENSIONS.x, NEUTRAL_BIG_BULLET_DIMENSIONS.y);
					_collisionDamage = 20;
					_speed = 500;
				}
				else if (_type == BulletType.BIG_TRIANGLE)
				{
					loadGraphic(enemyBigBulletSpr, false, false, ENEMY_BIG_BULLET_DIMENSIONS.x, ENEMY_BIG_BULLET_DIMENSIONS.y);
					_collisionDamage = 20;
					_speed = 500;
				}
				else 
				{
					throw new Error("Unknown Bullet Type provided to Bullet.as");
				}
				_graphicType = _type;
			}
		}
		
		public function canCollide(other:ICollidable):Boolean
		{
			if (other is AffiliatedObject)
			{
				var affobj:AffiliatedObject = other as AffiliatedObject;
				return affobj.affiliation != this.affiliation;
			}
			return false;
		}
		
		public function collide(other:ICollidable):void
		{
			if (!canCollide(other))
				return;
			this.kill();
		}
		
		/**
		 * Fires this bullet from the owner's x and y coordinates to the target
		 * Also copies the owner's affiliation to this bullet
		 * @param	owner
		 * @param	targetX
		 * @param	targetY
		 */
		public function fire(owner:AffiliatedObject, targetX:Number, targetY:Number, addVelocity:FlxPoint = null, bonusAttack:Number = 0):void
		{
			_affiliation = owner.affiliation;
			_bonusDamage = bonusAttack;
			
			this.x = owner.x + width / 2;
			this.y = owner.y + height / 2;
			
			if(this.onScreen()) {
				if (_affiliation == Affiliation.PLAYER) {
					FlxG.play(_playerShootmp3);
				} else {
					FlxG.play(_enemyShootmp3);
				}
			}
			
			var vel:Point = new Point(targetX - owner.x, targetY - owner.y);
			vel.normalize(_speed);
			
			if (addVelocity != null)
			{
				vel.x = vel.x + addVelocity.x;
				vel.y = vel.y + addVelocity.y;
			}
			
			this.velocity.copyFromFlash(vel);
			exists = true;
		}
		
		override public function postUpdate():void
		{
			super.postUpdate();
			if (exists && !onScreen())
			{
				exists = false;
			}
		}
		
		public function get type():BulletType 
		{
			return _type;
		}
		
		/**
		 * Sets the bullet type for this bullet, also reloads the bullet graphic if needed
		 */
		public function set type(value:BulletType):void 
		{
			_type = value;
			reloadGraphicAndDamage();
		}
		
		public function get collisionDamage():Number 
		{
			return _collisionDamage + _bonusDamage;
		}
		
		public function set collisionDamage(value:Number):void 
		{
			_collisionDamage = value;
		}
		
	}

}