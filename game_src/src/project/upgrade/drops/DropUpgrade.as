package project.upgrade.drops 
{
	import flash.net.drm.DRMVoucherDownloadContext;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import project.ship.PlayerShip;
	import project.ship.Ship;
	import project.util.ICollidable;
	import project.constant.Constants;
	/**
	 * ...
	 * @author Cullen
	 */
	public class DropUpgrade extends FlxSprite implements ICollidable
	{
		[Embed(source = "../../../../assets/upgradeoxygen.png")] private var _oxygenPng:Class;
		[Embed(source = "../../../../assets/upgradead.png")] private var _damagePng:Class;
		[Embed(source = "../../../../assets/upgradeas.png")] private var _cooldownPng:Class;
		[Embed(source = "../../../../assets/upgradems.png")] private var _movementPng:Class;
		
		protected var _type:DropType;
		protected var _lifetime:Number;
		
		public function DropUpgrade() 
		{
			_type = DropType.OXYGEN;
			_lifetime = Constants.DROP_UPGRADE_LIFETIME;
			reloadGraphic();
		}
		
		protected function reloadGraphic():void
		{
			if (_type == DropType.OXYGEN)
			{
				loadGraphic(_oxygenPng, false, false, 15, 15);
			}
			else if (_type == DropType.ATTACK)
			{
				loadGraphic(_damagePng, false, false, 15, 15);
			}
			else if (_type == DropType.MOVE_SPEED)
			{
				loadGraphic(_movementPng, false, false, 15, 15);
			}
			else if (_type == DropType.ATTACK_SPEED)
			{
				loadGraphic(_cooldownPng, false, false, 15, 15);
			}
		}
		
		public function applyUpgradeToShip(ship:PlayerShip):void
		{
			if (_type == DropType.OXYGEN)
			{
				ship.health = ship.health + Constants.OXYGEN_ADD;
				ship.health = Math.min(ship.health, ship.maxHealth);
			}
			else if (_type == DropType.ATTACK)
			{
				ship.bonusDamage = ship.bonusDamage + Constants.BONUS_DAMAGE_PER_UPGRADE;
				ship.bonusDamage = Math.min(ship.bonusDamage, Constants.MAX_BONUS_DAMAGE);
			}
			else if (_type == DropType.ATTACK_SPEED)
			{
				ship.bonusCooldown = ship.bonusCooldown + Constants.BONUS_COOLDOWN_PER_UPGRADE;
				ship.bonusCooldown = Math.min(ship.bonusCooldown, Constants.MAX_BONUS_COOLDOWN);
			}
			else if (_type == DropType.MOVE_SPEED)
			{
				ship.bonusMoveSpeed = ship.bonusMoveSpeed + Constants.BONUS_MOVE_SPEED_PER_UPGRADE;
				ship.bonusMoveSpeed = Math.min(ship.bonusMoveSpeed, Constants.MAX_BONUS_MOVE_SPEED);
			}
		}
		
		public function canCollide(other:ICollidable):Boolean
		{
			return other is PlayerShip;
		}
		
		public function collide(other:ICollidable):void
		{
			if (!canCollide(other))
			{
				return;
			}
			kill();
		}
		
		override public function update():void
		{
			super.update();
			_lifetime = _lifetime - FlxG.elapsed;
			if (_lifetime <= 0)
			{
				kill();
			}
		}
		
		public function get collisionDamage():Number
		{
			return 0;
		}
		
		public function get type():DropType 
		{
			return _type;
		}
		
		public function set type(value:DropType):void 
		{
			_type = value;
			reloadGraphic();
		}
		
		public function get lifetime():Number 
		{
			return _lifetime;
		}
		
		public function set lifetime(value:Number):void 
		{
			_lifetime = value;
		}
	}

}