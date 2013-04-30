package project.ship 
{
	import org.flixel.FlxSprite;
	import project.objects.AffiliatedObject;
	/**
	 * ...
	 * @author Cullen
	 */
	public class Ship extends AffiliatedObject implements IShip
	{
		protected var _gunXOffset:Number;
		protected var _gunYOffset:Number;
		
		public function Ship(X:Number=0,Y:Number=0,SimpleGraphic:Class=null) 
		{
			super(X, Y, SimpleGraphic);
			gunXOffset = 0;
			gunYOffset = 0;
		}
		
		public function get gunXOffset():Number 
		{
			return _gunXOffset;
		}
		
		public function set gunXOffset(value:Number):void 
		{
			_gunXOffset = value;
		}
		
		public function get gunYOffset():Number 
		{
			return _gunYOffset;
		}
		
		public function set gunYOffset(value:Number):void 
		{
			_gunYOffset = value;
		}
		
	}

}