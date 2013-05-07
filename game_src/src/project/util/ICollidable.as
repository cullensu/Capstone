package project.util 
{
	
	/**
	 * ...
	 * @author Cullen
	 */
	public interface ICollidable 
	{
		function canCollide(other:ICollidable):Boolean;
		
		function collide(other:ICollidable):void;
		
		function get collisionDamage():Number;
	}
	
}