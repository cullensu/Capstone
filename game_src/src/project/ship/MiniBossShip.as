package project.ship 
{
	import project.util.ICollidable;
	import org.flixel.FlxG
	import project.constant.Constants;
	import project.util.CartesianPoint;
	import project.util.PolarPoint;
	import project.constant.GameRegistry;
	/**
	 * ...
	 * @author jmlee337
	 */
	public class MiniBossShip extends AIShip
	{
		
		public var activated:Boolean;
		
		public function MiniBossShip(x:Number, y:Number) 
		{
			super(x, y);
			activated = false;
		}
		
		override public function collide(other:ICollidable):void
		{
			FlxG.play(_hurtmp3);
			if (!canCollide(other)) return;
			this.health = this.health - other.collisionDamage;
			if (this.health <= 0) {
				kill();
				//TODO: STUFF
				trace("Boss Killed");
			}
			trace(health);
		}
		
		override protected function checkDespawn():void
		{
			var cPoint:CartesianPoint = new CartesianPoint(x - GameRegistry.gameState.playerManager.playerShip.x,
														   y - GameRegistry.gameState.playerManager.playerShip.y);
			var pPoint:PolarPoint = cPoint.convertToPolar();
			if (pPoint.r > Constants.TILESIZE * 2.5) {
				this.exists = false;
				this.health = _maxHealth;
			}
		}
		
	}

}