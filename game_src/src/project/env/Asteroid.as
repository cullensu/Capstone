package project.env 
{
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import project.objects.AffiliatedObject;
	import project.util.Affiliation;
	import project.util.CartesianPoint;
	import project.util.ICollidable;
	import project.util.Utility;
	import project.constant.GameRegistry;
	import project.util.PolarPoint;
	/**
	 * ...
	 * @author Cullen
	 */
	public class Asteroid extends AffiliatedObject implements ICollidable
	{
		[Embed(source = "../../../assets/asteroidfull.png")] private var _asteroidFull:Class;
		[Embed(source = "../../../assets/asteroidhalf.png")] private var _asteroidHalf:Class;
		[Embed(source = "../../../assets/asteroidquarter.png")] private var _asteroidQuarter:Class;
		
		public static const FULL_HEALTH:Number = 20;
		public static const HALF_HEALTH:Number = FULL_HEALTH / 2;
		public static const QUARTER_HEALTH:Number = FULL_HEALTH / 4;
		
		protected var _level:int;
		protected var _aTile:AsteroidTile;
		
		public function Asteroid(pTile:AsteroidTile, x:int, y:int, level:int, velX:Number = 0, velY:Number = 0) 
		{
			super(x, y);
			_affiliation = Affiliation.ENV;
			_level = level;
			_aTile = pTile;
			velocity = new FlxPoint(velX, velY);
			switch(level) {
				case 1:
					loadGraphic(_asteroidFull);
					health = FULL_HEALTH;
					break;
				case 2:
					loadGraphic(_asteroidHalf);
					health = HALF_HEALTH;
					break;
				case 3:
					loadGraphic(_asteroidQuarter);
					health = QUARTER_HEALTH;
					break;
			}
		}
		
		public function canCollide(other:ICollidable):Boolean
		{
			if (other is AffiliatedObject)
			{
				var affobj:AffiliatedObject = other as AffiliatedObject;
				return affobj.affiliation != this.affiliation;
			}
			return false;
		}
		
		public function collide(other:ICollidable):void
		{
			health -= other.collisionDamage;
			if (health <= 0) {
				//There will be provisioning here for having asteroids break
				//up into smaller ones when destroyed later.
				kill();
				if (_level < 3) {
					var pPoint:PolarPoint = new PolarPoint(_level * 25, Utility.randomAngle());
					var cPoint:CartesianPoint = pPoint.convertToCartesianPoint();
					_aTile.add(new Asteroid(_aTile, x + width / 2, y + height / 2, _level + 1, cPoint.x, cPoint.y));
					pPoint.rotate(Math.PI);
					cPoint = pPoint.convertToCartesianPoint();
					_aTile.add(new Asteroid(_aTile, x + width / 2, y + height / 2, _level + 1, cPoint.x, cPoint.y));
				}
			}
		}
		
		public function get collisionDamage():Number
		{
			switch(_level) {
				case 1:
					return FULL_HEALTH;
				case 2:
					return HALF_HEALTH;
				default:
					return QUARTER_HEALTH;
			}
		}		
	}
}