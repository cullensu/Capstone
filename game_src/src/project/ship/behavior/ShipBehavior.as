package project.ship.behavior 
{
	import flash.geom.Point;
	import project.ship.behavior.move.IShipMovement;
	import project.ship.behavior.shoot.IShipShoot;
	import project.upgrade.GunUpgrade;
	import project.util.Affiliation;
	/**
	 * ...
	 * @author Cullen
	 */
	public class ShipBehavior 
	{
		protected var _affiliation:Affiliation;
		protected var _movement:IShipMovement;
		protected var _shooting:IShipShoot;
		
		protected var _shipGraphic:Class;
		protected var _shipGraphicDimensions:Point;
		
		protected var _guns:Vector.<GunUpgrade>;
		protected var _maxHealth:Number;
		protected var _speed:Number;
		protected var _collisionDamage:Number;
		
		protected var _animations:int;
		protected var _animationNames:Array;
		protected var _animationFrames:Array;
		protected var _animationLoops:Array;
		
		public function ShipBehavior() 
		{
			
		}
		
		public function get animations():int
		{
			return _animations;
		}
		
		public function set animations(num:int):void
		{
			_animations = num;
		}
		
		public function get animationNames():Array
		{
			return _animationNames;
		}
		
		public function set animationNames(names:Array):void
		{
			_animationNames = names;
		}
		
		public function get animationFrames():Array
		{
			return _animationFrames;
		}
		
		public function set animationFrames(frames:Array):void
		{
			_animationFrames = frames;
		}
		
		public function get animationLoops():Array
		{
			return _animationLoops;
		}
		
		public function set animationLoops(loops:Array):void
		{
			_animationLoops = loops;
		}
		
		public function get movement():IShipMovement 
		{
			return _movement;
		}
		
		public function set movement(value:IShipMovement):void 
		{
			_movement = value;
		}
		
		public function get shooting():IShipShoot 
		{
			return _shooting;
		}
		
		public function set shooting(value:IShipShoot):void 
		{
			_shooting = value;
		}
		
		public function get shipGraphic():Class 
		{
			return _shipGraphic;
		}
		
		public function set shipGraphic(value:Class):void 
		{
			_shipGraphic = value;
		}
		
		public function get guns():Vector.<GunUpgrade> 
		{
			return _guns;
		}
		
		public function set guns(value:Vector.<GunUpgrade>):void 
		{
			_guns = value;
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
		
		public function get shipGraphicDimensions():Point 
		{
			return _shipGraphicDimensions;
		}
		
		public function set shipGraphicDimensions(value:Point):void 
		{
			_shipGraphicDimensions = value;
		}
		
		public function get affiliation():Affiliation 
		{
			return _affiliation;
		}
		
		public function set affiliation(value:Affiliation):void 
		{
			_affiliation = value;
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