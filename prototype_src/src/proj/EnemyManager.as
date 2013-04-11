package proj 
{
	import org.flixel.FlxGroup;
	/**
	 * ...
	 * @author Cullen
	 */
	public class EnemyManager extends FlxGroup
	{
		public function EnemyManager() 
		{
			super();
			
			for (var i:int = 0; i < 5; i++)
			{
				add(new EnemyShip);
			}
		}
		
		public function registerUpgradeCreationFunction(f:Function):void
		{
			var enemies:Array = this.members;
			for (var i:int = 0; i < 5; i++)
			{
				if (enemies[i] != null)
				{
					(enemies[i] as EnemyShip).registerUpgradeCreationFunction(f);
				}
			}
		}
		
		public function registerTarget(targetx:int, targety:int):void
		{
			var enemies:Array = this.members;
			for (var i:int = 0; i < 5; i++)
			{
				if (enemies[i] != null)
				{
					(enemies[i] as EnemyShip).registerTarget(targetx, targety);
				}
			}
		}
		
		override public function update():void
		{
			super.update();
		}
	}

}