package project.upgrade.guns 
{
	import org.flixel.FlxPoint;
	import project.constant.GameRegistry;
	import project.upgrade.GunUpgrade;
	import project.util.CartesianPoint;
	import project.util.PolarPoint;
	/**
	 * ...
	 * @author Cullen
	 */
	public class OffsetGun extends GunUpgrade
	{
		protected var _angleOffset:Number;
		
		public function OffsetGun(X:Number=0,Y:Number=0,SimpleGraphic:Class=null) 
		{
			super(X, Y, SimpleGraphic);
			_angleOffset = 0;
		}
		
		public function get angleOffset():Number 
		{
			return _angleOffset;
		}
		
		public function set angleOffset(value:Number):void 
		{
			_angleOffset = value;
		}
		
		override public function fire(targetX:Number, targetY:Number, addVelocity:FlxPoint = null, bonusAttack:Number = 0, bonusCooldown:Number = 100):void
		{
			if (_currentCooldown <= 0)
			{
				var target:CartesianPoint = new CartesianPoint(targetX - this.x, targetY - this.y);
				var polar:PolarPoint = target.convertToPolar();
				polar.rotate(_angleOffset);
				target = polar.convertToCartesianPoint();
				GameRegistry.gameState.bulletManager.fire(this, this.x + target.x, this.y + target.y, _bulletType, addVelocity, bonusAttack);
				_currentCooldown = _gunCooldown / (bonusCooldown / 100);
			}
		}
		
		override protected function copyAttributesTo(other:GunUpgrade):void
		{
			super.copyAttributesTo(other);
			if (other is OffsetGun)
			{
				var offset:OffsetGun = (other as OffsetGun);
				offset._angleOffset = this._angleOffset;
			}
		}
		
		override public function getClone():GunUpgrade
		{
			var clone:OffsetGun = new OffsetGun();
			copyAttributesTo(clone);
			return clone;
		}
		
	}

}