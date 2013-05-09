package project.bullet 
{
	import flash.geom.Point;
	import org.flixel.FlxPoint;
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
		
		
		protected static const WIDTH:Number = 5;
		protected static const HEIGHT:Number = 5;
		
		protected var _speed:Number = 600;
		protected var _collisionDamage:Number = 10;
		
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
			reloadGraphic();
			exists = false;
		}
		
		/**
		 * Reloads the graphic for this bullet if needed
		 */
		protected function reloadGraphic():void
		{
			if (_type != _graphicType)
			{
				if (_type == BulletType.CIRCLE)
				{
					loadGraphic(playerBulletSpr, false, false, WIDTH, HEIGHT);
				}
				else if (_type == BulletType.SQUARE)
				{
					loadGraphic(neutralBulletSpr, false, false, WIDTH, HEIGHT);
				}
				else if (_type == BulletType.TRIANGLE)
				{
					loadGraphic(enemyBulletSpr, false, false, WIDTH, HEIGHT);
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
		public function fire(owner:AffiliatedObject, targetX:Number, targetY:Number):void
		{
			_affiliation = owner.affiliation;
			this.x = owner.x + width / 2;
			this.y = owner.y + height / 2;
			
			var vel:Point = new Point(targetX - owner.x, targetY - owner.y);
			vel.normalize(_speed);
			
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
			reloadGraphic();
		}
		
		public function get collisionDamage():Number 
		{
			return _collisionDamage;
		}
		
		public function set collisionDamage(value:Number):void 
		{
			_collisionDamage = value;
		}
		
	}

}