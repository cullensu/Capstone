package project.util 
{
	/**
	 * ...
	 * @author Cullen
	 */
	public class PolarPoint 
	{
		protected var _r:Number;
		protected var _theta:Number; //This is in radians
		
		/**
		 * Creates a new Polar Point with the values given
		 * @param	rVal radius
		 * @param	thetaVal angle in radians
		 */
		public function PolarPoint(rVal:Number, thetaVal:Number) 
		{
			_r = rVal;
			_theta = thetaVal;
		}
		
		public function get r():Number 
		{
			return _r;
		}
		
		public function set r(value:Number):void 
		{
			_r = value;
		}
		
		
		public function get theta():Number 
		{
			return _theta;
		}
		
		public function set theta(value:Number):void 
		{
			_theta = value;
		}
		
		/**
		 * Rotates by the number of radians
		 * @param	rads
		 */
		public function rotate(rads:Number):void
		{
			theta += rads;
		}
		
		/**
		 * Converts this to a cartesian point
		 * @return
		 */
		public function convertToCartesianPoint():CartesianPoint
		{
			var x:Number = r * Math.cos(theta);
			var y:Number = r * Math.sin(theta);
			return new CartesianPoint(x, y);
		}
		
	}

}