package project.util 
{
	import org.flixel.FlxPoint;
	/**
	 * ...
	 * @author Cullen
	 */
	public class Direction 
	{
		public static const NORTH:String = "North";
		public static const NORTHEAST:String = "NorthEast";
		public static const EAST:String = "East";
		public static const SOUTHEAST:String = "SouthEast";
		public static const SOUTH:String = "South";
		public static const SOUTHWEST:String = "SouthWest";
		public static const WEST:String = "West";
		public static const NORTHWEST:String = "NorthWest";
		public static const NULL:String = "NoDirection";
		
		public function Direction() 
		{
			
		}
		
		/**
		 * Returns a string corresponding to the direction of the x and y components
		 * It only considers the cases >0, =0, and <0 for figuring out the direction
		 * @param	xDir
		 * @param	yDir
		 * @return
		 */
		public static function getDirection(xDir:int, yDir:int):String
		{
			if (xDir > 0)
			{
				if (yDir > 0)
				{
					return SOUTHEAST;
				}
				if (yDir == 0)
				{
					return EAST;
				}
				if (yDir < 0)
				{
					return NORTHEAST;
				}
			}
			else if (xDir == 0)
			{
				if (yDir > 0)
				{
					return SOUTH;
				}
				if (yDir == 0)
				{
					return NULL;
				}
				if (yDir < 0)
				{
					return NORTH;
				}
			}
			else if (xDir < 0)
			{
				if (yDir > 0)
				{
					return SOUTHWEST;
				}
				if (yDir == 0)
				{
					return WEST;
				}
				if (yDir < 0)
				{
					return NORTHWEST;
				}
			}
			return NULL;
		}
		
		/**
		 * Returns a FlxPoint representing the (x,y) velocity of the direction/magnitude
		 * The velocity will be normalized to the magnitude given
		 * @param	dir
		 * @param	magnitude
		 * @return
		 */
		public static function getVelocityVector(dir:String, magnitude:Number):FlxPoint
		{
			var diag:Number = magnitude / Math.SQRT2;
			
			switch(dir)
			{
				case EAST:
					return new FlxPoint(magnitude, 0);
					break;
				case NORTH:
					return new FlxPoint(0, -1*magnitude);
					break;
				case SOUTH:
					return new FlxPoint(0, magnitude);
					break;
				case WEST:
					return new FlxPoint(-1*magnitude, 0);
					break;
				case NORTHEAST:
					return new FlxPoint(diag, -1*diag);
					break;
				case SOUTHEAST:
					return new FlxPoint(diag, diag);
					break;
				case NORTHWEST:
					return new FlxPoint(-1*diag, -1*diag);
					break;
				case SOUTHWEST:
					return new FlxPoint(-1*diag, diag);
					break;
				default:
					return new FlxPoint(0, 0);
					break;
			}
		}
		
	}

}