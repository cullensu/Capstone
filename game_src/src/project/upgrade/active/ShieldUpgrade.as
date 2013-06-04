package project.upgrade.active
{
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import project.constant.GameRegistry;
	import project.ship.PlayerShip;
	import project.ship.Ship;
	import project.upgrade.ActiveUpgrade;
	import project.constant.Constants;
	
	/**
	 * ...
	 * @author akirilov
	 */
	public class ShieldUpgrade extends ActiveUpgrade 
	{	
		[Embed(source = "../../../../assets/shield.png")] protected var Shield:Class;

		private var _shieldSprite:FlxSprite;
		public function ShieldUpgrade(ship:Ship):void
		{
			super(ship);
			_MAX_CHARGE = Constants.MAXIMUM_CHARGE;
			charge = _MAX_CHARGE;
			_chargeRate = Constants.SHIELD_CHARGE_RATE;
			_useRate = Constants.SHIELD_USE_RATE;
			
			_shieldSprite = new FlxSprite(399 - ship.width / 2, 299 - ship.height / 2, Shield);
			_shieldSprite.scrollFactor = new FlxPoint(0, 0);
			_shieldSprite.exists = false;
			_shieldSprite.alpha = 1;
			GameRegistry.gameState.playerManager.add(_shieldSprite);
		}
		
		override public function activate():void
		{
			// Can only use shield when fully charged
			if (charge == _MAX_CHARGE)
			{
				super.activate();
				trace("Shield Activated");
				_shieldSprite.exists = true;
				_ship.activeShield = true;
			}
		}
		
		override public function deactivate():void
		{
			trace("Shield down");
			_shieldSprite.exists = false;
			_ship.activeShield = false;
			super.deactivate();
		}
	}

}