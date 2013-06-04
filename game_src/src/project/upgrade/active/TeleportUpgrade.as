package project.upgrade.active
{
	import org.flixel.FlxG;
	import project.ship.Ship;
	import project.upgrade.ActiveUpgrade;
	import project.constant.Constants;
	
	/**
	 * ...
	 * @author akirilov
	 */
	public class TeleportUpgrade extends ActiveUpgrade 
	{
		public function TeleportUpgrade(ship:Ship):void 
		{
			super(ship);
			_MAX_CHARGE = Constants.MAXIMUM_CHARGE;
			charge = MAX_CHARGE;
			_chargeRate = Constants.BLINK_CHARGE_RATE;
			_useRate = Constants.BLINK_USE_RATE;
		}
		
		override public function activate():void
		{
			// Can only use shield when fully charged
			if (charge == _MAX_CHARGE)
			{
				super.activate();

				var nx:Number = FlxG.mouse.x;
				var ny:Number = FlxG.mouse.y;
				
				trace("Teleported to (" + nx + ", " + ny + ")");
				_ship.x = nx;
				_ship.y = ny;
				charge = 0;
				super.deactivate();
			}
		}
		
	}

}