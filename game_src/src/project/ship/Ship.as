package project.ship 
{
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	import project.bullet.Bullet;
	import project.objects.AffiliatedObject;
	import project.upgrade.GunUpgrade;
	import project.util.ICollidable;
	/**
	 * ...
	 * @author Cullen
	 */
	public class Ship extends AffiliatedObject implements ICollidable, IShip
	{
		[Embed(source = "../../../assets/sfx/Explode.mp3")] protected var _explodemp3:Class;
		
		protected var _guns:Vector.<GunUpgrade>;
		protected var _collisionDamage:Number;
		
		protected var _gunXOffset:Number;
		protected var _gunYOffset:Number;
		
		protected var _maxHealth:Number;
		protected var _speed:Number;
		
		public function Ship(X:Number=0,Y:Number=0,SimpleGraphic:Class=null) 
		{
			super(X, Y, SimpleGraphic);
			_collisionDamage = 10;
			_maxHealth = 200;
			health = _maxHealth;
			_guns = new Vector.<GunUpgrade>();
			gunXOffset = 0;
			gunYOffset = 0;
		}
		
		public function get gunXOffset():Number 
		{
			return _gunXOffset;
		}
		
		public function set gunXOffset(value:Number):void 
		{
			_gunXOffset = value;
		}
		
		public function get gunYOffset():Number 
		{
			return _gunYOffset;
		}
		
		public function set gunYOffset(value:Number):void 
		{
			_gunYOffset = value;
		}
		
		public function get collisionDamage():Number 
		{
			return _collisionDamage;
		}
		
		public function set collisionDamage(value:Number):void 
		{
			_collisionDamage = value;
		}
		
		public function get maxHealth():Number 
		{
			return _maxHealth;
		}
		
		public function set maxHealth(value:Number):void 
		{
			_maxHealth = value;
		}
		
		public function get speed():Number 
		{
			return _speed;
		}
		
		public function set speed(value:Number):void 
		{
			_speed = value;
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
			if (!canCollide(other)) return;
			this.health = this.health - other.collisionDamage;
		}
		
		public function addGunUpgrade(gunUpgrade:GunUpgrade):void
		{
			gunXOffset = width / 2;
			gunYOffset = height / 2;
			if (_guns.indexOf(gunUpgrade) < 0)
			{
				_guns.push(gunUpgrade);
				gunUpgrade.registerOwner(this);
				gunUpgrade.xOffset = gunXOffset;
				gunUpgrade.yOffset = gunYOffset;
				
			}
		}
		
		public function removeAllGunUpgrades():void
		{
			while (_guns.length > 0)
			{
				_guns.pop();
			}
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
			if (health <= 0)
			{
				this.kill();
			}
		}
		
		public function fire(targetX:Number, targetY:Number, addVelocity:FlxPoint = null):void
		{
			for each (var gun:GunUpgrade in _guns)
			{
				gun.fire(targetX, targetY, addVelocity);
			}
		}
		
		override public function kill():void
		{
			if(this.onScreen()) FlxG.play(_explodemp3);
			super.kill();
		}
		
	}

}