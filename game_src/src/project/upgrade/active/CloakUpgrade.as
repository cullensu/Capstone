package project.upgrade.active
{
	import project.constant.Constants;
	import project.ship.Ship;
	import project.upgrade.ActiveUpgrade;
	
	/**
	 * ...
	 * @author akirilov
	 */
	public class CloakUpgrade extends ActiveUpgrade 
	{		
		public function CloakUpgrade(ship:Ship) 
		{
			super(ship);
			
			_MAX_CHARGE = Constants.MAXIMUM_CHARGE;
			charge = _MAX_CHARGE;
			_chargeRate = Constants.CLOAK_CHARGE_RATE;
			_useRate = Constants.CLOAK_USE_RATE;
		}
		
		override public function activate():void
		{
			// Can only use cloak when fully charged
			if (charge == _MAX_CHARGE)
			{
				super.activate();
				trace("Cloak Activated");
				_ship.activeCloak = true;
				_ship.alpha = 0.25;
			}
		}
		
		override public function deactivate():void
		{
			trace("Cloak down");
			_ship.activeCloak = false;
			_ship.alpha = 1;
			super.deactivate();
		}
	}

}