package project.util 
{
	
	/**
	 * ...
	 * @author Cullen
	 */
	public interface ICollidable 
	{
		/**
		 * Returns true if this object can collide with the other object.  
		 * This should be bi-directional, so obj1.canCollide(obj2)==TRUE iff obj2.canCollide(obj1)==TRUE
		 * @param	other
		 * @return
		 */
		function canCollide(other:ICollidable):Boolean;
		
		/**
		 * This collides the other object with this object.  This function should only modify variables for this object.
		 * @param	other
		 */
		function collide(other:ICollidable):void;
		
		/**
		 * Returns the amount of collision damage when colliding.
		 */
		function get collisionDamage():Number;
	}
	
}