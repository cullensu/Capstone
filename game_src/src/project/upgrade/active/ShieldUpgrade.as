package project.upgrade.active
{
	import org.flixel.FlxSprite;
	import project.ship.PlayerShip;
	import project.ship.Ship;
	import project.upgrade.ActiveUpgrade;
	
	/**
	 * ...
	 * @author akirilov
	 */
	public class ShieldUpgrade extends ActiveUpgrade 
	{
		private var _shieldSprite:FlxSprite;
		
		public function ShieldUpgrade(ship:Ship):void
		{
			super(ship);
			charge = 1000;
			_MAX_CHARGE = 1000;
			_chargeRate = 1;
			_useRate = 2;
		}
		
		override public function activate():void
		{
			// Can only use shield when fully charged
			if (charge == _MAX_CHARGE)
			{
				trace("Shield Activated");
				_ship.activeShield = true;
				super.activate();
			}
		}
		
		override public function update():void
		{
			if (_isCharging)
			{
				if (charge < _MAX_CHARGE)
				{
					charge += _chargeRate;
				}
				else
				{
					_isCharging = false;
				}
			}
			else if (_isUsing)
			{
				if (charge > 0)
				{
					charge -= _useRate;
				}
				else
				{
					_isUsing = false;
					_isCharging = true;
					_ship.activeShield = false;
					trace("Shield down");
				}
			}
		}
	}

}