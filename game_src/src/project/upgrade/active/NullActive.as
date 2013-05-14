package project.upgrade.active
{
	import project.ship.Ship;
	import project.upgrade.ActiveUpgrade;
	/**
	 * ...
	 * @author akirilov
	 */
	public class NullActive extends ActiveUpgrade
	{
		public function NullActive(ship:Ship)
		{
			super(ship);
			charge = 0;
			_MAX_CHARGE = 1;
			_chargeRate = 1;
			_useRate = 1;
		}
		
		override public function activate():void 
		{
			// Do nothing
		}
		
		public override function update():void
		{
			// Do nothing
		}
	}

}