package project.upgrade 
{
	import project.ship.Ship;
	/**
	 * ...
	 * @author Cullen
	 */
	public class ActiveUpgrade 
	{	
		protected var _MAX_CHARGE:int;
		public var charge:int;
		protected var _isCharging:Boolean = false;
		protected var _isUsing:Boolean = false;
		protected var _chargeRate:int = 1;
		protected var _useRate:int = 1;
		protected var _ship:Ship;
		
		public function ActiveUpgrade(ship:Ship)
		{
			_ship = ship;
		}
		
		public function activate():void
		{
			if (!_isCharging && !_isUsing)
			{
				_isUsing = true;
			}
		}
		
		public function update():void
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
				}
			}
				
		}
		
		public function get MAX_CHARGE():int 
		{
			return _MAX_CHARGE;
		}
	}

}