package project.util 
{
	import flash.geom.Point;
	/**
	 * ...
	 * @author Cullen
	 */
	public class CartesianPoint extends Point
	{
		public function CartesianPoint(xVal:Number, yVal:Number) 
		{
			super(xVal, yVal);
		}
		
		/**
		 * Converts this to a polar coordinate (radians)
		 * @return
		 */
		public function convertToPolar():PolarPoint
		{
			var r:Number = Math.sqrt(x * x + y * y);
			var theta:Number = Math.atan2(y, x);
			return new PolarPoint(r, theta);
		}
		
	}

}