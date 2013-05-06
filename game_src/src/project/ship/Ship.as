package project.ship 
{
	import org.flixel.FlxSprite;
	import project.objects.AffiliatedObject;
	import project.upgrade.GunUpgrade;
	/**
	 * ...
	 * @author Cullen
	 */
	public class Ship extends AffiliatedObject implements IShip
	{
		protected var _guns:Vector.<GunUpgrade>;
		
		protected var _gunXOffset:Number;
		protected var _gunYOffset:Number;
		
		public function Ship(X:Number=0,Y:Number=0,SimpleGraphic:Class=null) 
		{
			super(X, Y, SimpleGraphic);
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
		}
		
		public function fire(targetX:Number, targetY:Number):void
		{
			for each (var gun:GunUpgrade in _guns)
			{
				gun.fire(targetX, targetY);
			}
		}
		
	}

}