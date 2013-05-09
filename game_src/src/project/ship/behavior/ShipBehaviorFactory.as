package project.ship.behavior 
{
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import project.bullet.BulletType;
	import project.constant.Constants;
	import project.ship.behavior.move.Suicide;
	import project.ship.behavior.shoot.RandomShot;
	import project.upgrade.guns.OffsetGun;
	import project.upgrade.GunUpgrade;
	import project.util.Affiliation;
	/**
	 * ...
	 * @author Cullen
	 */
	public class ShipBehaviorFactory 
	{
		[Embed(source = "../../../../assets/enemybig.png")] private var _enemyBigPng:Class;
		[Embed(source = "../../../../assets/enemyfast.png")] private var _enemyFastPng:Class;
		[Embed(source = "../../../../assets/enemynormal.png")] private var _enemyNormalPng:Class;
		
		protected var _enemyNormal:ShipBehavior;
		protected var _enemyFast:ShipBehavior;
		protected var _enemyBig:ShipBehavior;
		
		protected var _typeToBehavior:Dictionary;
		
		public function ShipBehaviorFactory() 
		{
			_typeToBehavior = new Dictionary();
			initTypes();
		}
		
		protected function initTypes():void
		{
			_enemyNormal = new ShipBehavior();
			_enemyNormal.affiliation = Affiliation.ENEMY;
			_enemyNormal.guns = new Vector.<GunUpgrade>();
			var normalGun:OffsetGun = new OffsetGun();
			normalGun.bulletType = BulletType.TRIANGLE;
			_enemyNormal.guns.push(normalGun);
			_enemyNormal.maxHealth = 40;
			_enemyNormal.speed = 250;
			_enemyNormal.collisionDamage = 10;
			_enemyNormal.shipGraphic = _enemyNormalPng;
			_enemyNormal.shipGraphicDimensions = new Point(30, 28);
			_enemyNormal.movement = new Suicide();
			_enemyNormal.shooting = new RandomShot();
			_typeToBehavior[ShipBehaviorType.ENEMY_NORMAL] = _enemyNormal;
			
			_enemyFast = new ShipBehavior();
			_enemyFast.affiliation = Affiliation.ENEMY;
			_enemyFast.guns = new Vector.<GunUpgrade>();
			_enemyFast.maxHealth = 20;
			_enemyFast.speed = 300;
			_enemyFast.collisionDamage = 10;
			_enemyFast.shipGraphic = _enemyFastPng;
			_enemyFast.shipGraphicDimensions = new Point(26, 16);
			_enemyFast.movement = new Suicide();
			_enemyFast.shooting = new RandomShot();
			_typeToBehavior[ShipBehaviorType.ENEMY_FAST] = _enemyFast;
			
			_enemyBig = new ShipBehavior();
			_enemyBig.affiliation = Affiliation.ENEMY;
			_enemyBig.guns = new Vector.<GunUpgrade>();
			var bigGun:OffsetGun = new OffsetGun();
			bigGun.bulletType = BulletType.BIG_TRIANGLE;
			_enemyBig.guns.push(bigGun);
			_enemyBig.maxHealth = 100;
			_enemyBig.speed = 200;
			_enemyBig.collisionDamage = 40;
			_enemyBig.shipGraphic = _enemyBigPng;
			_enemyBig.shipGraphicDimensions = new Point(46, 17);
			_enemyBig.movement = new Suicide();
			_enemyBig.shooting = new RandomShot();
			_typeToBehavior[ShipBehaviorType.ENEMY_BIG] = _enemyBig;
		}
		
		public function getShipBehavior(type:ShipBehaviorType):ShipBehavior
		{
			return _typeToBehavior[type];
		}
		
	}

}