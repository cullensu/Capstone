package project.upgrade 
{
	import project.bullet.BulletType;
	import project.constant.GameRegistry;
	import project.objects.AffiliatedObject;
	/**
	 * ...
	 * @author Cullen
	 */
	public class GunUpgrade extends AffiliatedObject
	{
		protected var _gunCooldown:uint;
		protected var _currentCooldown:uint;
		
		protected var _xOffset:Number;
		protected var _yOffset:Number;
		
		protected var _owner:AffiliatedObject;
		protected var _bulletType:BulletType;
		
		public function GunUpgrade(X:Number=0,Y:Number=0,SimpleGraphic:Class=null) 
		{
			super(X, Y, SimpleGraphic);
			_gunCooldown = 20;
			_xOffset = 0;
			_yOffset = 0;
			_bulletType = BulletType.CIRCLE;
		}
		
		public function get xOffset():Number 
		{
			return _xOffset;
		}
		
		public function set xOffset(value:Number):void 
		{
			_xOffset = value;
		}
		
		public function get yOffset():Number 
		{
			return _yOffset;
		}
		
		public function set yOffset(value:Number):void 
		{
			_yOffset = value;
		}
		
		public function get bulletType():BulletType 
		{
			return _bulletType;
		}
		
		public function set bulletType(value:BulletType):void 
		{
			_bulletType = value;
		}
		
		protected function copyAttributesTo(other:GunUpgrade):void
		{
			other._owner = this._owner;
			other._bulletType = this._bulletType;
			other._affiliation = this._affiliation;
			other._gunCooldown = this._gunCooldown;
			other._xOffset = this._xOffset;
			other._yOffset = this._yOffset;
		}
		
		public function getClone():GunUpgrade
		{
			var clone:GunUpgrade = new GunUpgrade();
			copyAttributesTo(clone);
			return clone;
		}
		
		/**
		 * Registers an owner for this GunUpgrade, copies the affiliation of the owner and sets position
		 * @param	owner
		 */
		public function registerOwner(owner:AffiliatedObject):void
		{
			_owner = owner;
			this.affiliation = _owner.affiliation;
			this.x = _owner.x + _xOffset;
			this.y = _owner.y + _yOffset;
		}
		
		public function fire(targetX:Number, targetY:Number):void
		{
			if (_currentCooldown == 0)
			{
				GameRegistry.gameState.bulletManager.fire(this, targetX, targetY, _bulletType);
				_currentCooldown = _gunCooldown;
			}
		}
		
		override public function preUpdate():void
		{
			super.preUpdate();
			if (_currentCooldown > 0)
			{
				_currentCooldown--;
			}
		}
		
		override public function update():void
		{
			super.update();
			this.x = _owner.x + _xOffset;
			this.y = _owner.y + _yOffset;
		}
	}

}