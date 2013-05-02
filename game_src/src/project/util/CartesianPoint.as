package project.util 
{
	/**
	 * ...
	 * @author Cullen
	 */
	public class CartesianPoint 
	{
		protected var _x:Number;
		protected var _y:Number;
		
		public function CartesianPoint(xVal:Number, yVal:Number) 
		{
			_x = xVal;
			_y = yVal;
		}
		
		public function get x():Number 
		{
			return _x;
		}
		
		public function set x(value:Number):void 
		{
			_x = value;
		}
		
		public function get y():Number 
		{
			return _y;
		}
		
		public function set y(value:Number):void 
		{
			_y = value;
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