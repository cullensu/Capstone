package project.upgrade.active
{
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import project.constant.GameRegistry;
	import project.ship.PlayerShip;
	import project.ship.Ship;
	import project.upgrade.ActiveUpgrade;
	
	/**
	 * ...
	 * @author akirilov
	 */
	public class ShieldUpgrade extends ActiveUpgrade 
	{		
		public function ShieldUpgrade(ship:Ship):void
		{
			super(ship);
			_MAX_CHARGE = 1000;
			charge = _MAX_CHARGE;
			_chargeRate = 1;
			_useRate = 3;
		}
		
		override public function activate():void
		{
			// Can only use shield when fully charged
			if (charge == _MAX_CHARGE)
			{
				super.activate();
				trace("Shield Activated");
				_ship.activeShield = true;
			}
		}
		
		override public function deactivate():void
		{
			trace("Shield down");
			_ship.activeShield = false;
			super.deactivate();
		}
	}

}