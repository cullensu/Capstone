package project.constant 
{
	/**
	 * ...
	 * @author Cullen
	 */
	public class Constants 
	{
		
		public static const DIR_NORTH:String = "North";
		public static const DIR_NORTHEAST:String = "NorthEast";
		public static const DIR_EAST:String = "East";
		public static const DIR_SOUTHEAST:String = "SouthEast";
		public static const DIR_SOUTH:String = "South";
		public static const DIR_SOUTHWEST:String = "SouthWest";
		public static const DIR_WEST:String = "West";
		public static const DIR_NORTHWEST:String = "NorthWest";
		public static const DIR_NULL:String = "NoDirection";
		
		
		public function Constants() 
		{
			
		}
		
		public static function getDirection(xDir:int, yDir:int):String
		{
			if (xDir > 0)
			{
				if (yDir > 0)
				{
					return DIR_SOUTHEAST;
				}
				if (yDir == 0)
				{
					return DIR_EAST;
				}
				if (yDir < 0)
				{
					return DIR_NORTHEAST;
				}
			}
			if (xDir == 0)
			{
				if (yDir > 0)
				{
					return DIR_SOUTH;
				}
				if (yDir == 0)
				{
					return DIR_NULL;
				}
				if (yDir < 0)
				{
					return DIR_NORTH;
				}
			}
			if (xDir < 0)
			{
				if (yDir > 0)
				{
					return DIR_NORTHWEST;
				}
				if (yDir == 0)
				{
					return DIR_WEST;
				}
				if (yDir < 0)
				{
					return DIR_SOUTHWEST;
				}
			}
		}
		
	}

}