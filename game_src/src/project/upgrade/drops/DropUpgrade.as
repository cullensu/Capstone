package project.upgrade.drops 
{
	import org.flixel.FlxSprite;
	import project.ship.PlayerShip;
	import project.util.ICollidable;
	import project.constant.Constants;
	/**
	 * ...
	 * @author Cullen
	 */
	public class DropUpgrade extends FlxSprite implements ICollidable
	{
		[Embed(source = "../../../../assets/neutralnormal.png")] private var _upgradePng:Class;
		protected var _type:DropType;
		
		public function DropUpgrade() 
		{
			_type = DropType.OXYGEN;
			
			loadGraphic(_upgradePng, false, false, 30, 30);
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
		
		public function get collisionDamage():Number
		{
			return -Constants.OXYGEN_ADD;
		}
		
		public function get type():DropType 
		{
			return _type;
		}
		
		public function set type(value:DropType):void 
		{
			_type = value;
		}
	}

}