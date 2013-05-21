package project.ship.behavior 
{
	import flash.events.AccelerometerEvent;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import project.bullet.BulletType;
	import project.constant.Constants;
	import project.ship.behavior.move.CircleAround;
	import project.ship.behavior.move.Suicide;
	import project.ship.behavior.move.SuicideWithTurnRadius;
	import project.ship.behavior.move.SwarmBoss;
	import project.ship.behavior.move.TeleportingBoss;
	import project.ship.behavior.shoot.LeadingShot;
	import project.ship.behavior.shoot.RandomShot;
	import project.ship.behavior.shoot.TargetShot;
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
		
		[Embed(source = "../../../../assets/minibossblink.png")] private var _bossBlinkPng:Class;
		[Embed(source = "../../../../assets/minibossfast.png")] private var _bossFastPng:Class;
		[Embed(source = "../../../../assets/minibosshoming.png")] private var _bossHomingPng:Class;
		[Embed(source = "../../../../assets/minibossswarm.png")] private var _bossSwarmPng:Class;
		
		[Embed(source = "../../../../assets/minibosspartleft.png")] private var _bossPartLeftPng:Class;
		[Embed(source = "../../../../assets/minibosspartright.png")] private var _bossPartRightPng:Class;
		[Embed(source = "../../../../assets/minibossparttop.png")] private var _bossPartTopPng:Class;
		
		
		protected var _enemyNormal:ShipBehavior;
		protected var _enemyFast:ShipBehavior;
		protected var _enemyBig:ShipBehavior;
		
		protected var _bossBlink:ShipBehavior;
		protected var _bossFast:ShipBehavior;
		protected var _bossHoming:ShipBehavior;
		protected var _bossSwarm:ShipBehavior;
		
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
			normalGun.gunCooldown = 1.2;
			_enemyNormal.guns.push(normalGun);
			_enemyNormal.maxHealth = 40;
			_enemyNormal.speed = 225;
			_enemyNormal.collisionDamage = 10;
			_enemyNormal.shipGraphic = _enemyNormalPng;
			_enemyNormal.shipGraphicDimensions = new Point(30, 28);
			_enemyNormal.movement = new CircleAround(175);
			_enemyNormal.shooting = new RandomShot();
			_typeToBehavior[ShipBehaviorType.ENEMY_NORMAL] = _enemyNormal;
			
			_enemyFast = new ShipBehavior();
			_enemyFast.affiliation = Affiliation.ENEMY;
			_enemyFast.guns = new Vector.<GunUpgrade>();
			_enemyFast.maxHealth = 20;
			_enemyFast.speed = 375;
			_enemyFast.collisionDamage = 10;
			_enemyFast.shipGraphic = _enemyFastPng;
			_enemyFast.shipGraphicDimensions = new Point(26, 16);
			_enemyFast.movement = new SuicideWithTurnRadius(Math.PI / 3);
			_enemyFast.shooting = new RandomShot(); //Needs this even though it doesn't have a gun to shoot
			_typeToBehavior[ShipBehaviorType.ENEMY_FAST] = _enemyFast;
			
			_enemyBig = new ShipBehavior();
			_enemyBig.affiliation = Affiliation.ENEMY;
			_enemyBig.guns = new Vector.<GunUpgrade>();
			var bigGun:OffsetGun = new OffsetGun();
			bigGun.bulletType = BulletType.BIG_TRIANGLE;
			bigGun.gunCooldown = 2.0;
			_enemyBig.guns.push(bigGun);
			_enemyBig.maxHealth = 100;
			_enemyBig.speed = 200;
			_enemyBig.collisionDamage = 40;
			_enemyBig.shipGraphic = _enemyBigPng;
			_enemyBig.shipGraphicDimensions = new Point(46, 17);
			_enemyBig.movement = new CircleAround(250);
			_enemyBig.shooting = new LeadingShot();
			_typeToBehavior[ShipBehaviorType.ENEMY_BIG] = _enemyBig;
			
			_bossBlink = new ShipBehavior();
			_bossBlink.affiliation = Affiliation.ENEMY;
			_bossBlink.guns = new Vector.<GunUpgrade>();
			var bossBlinkGun:OffsetGun = new OffsetGun();
			bossBlinkGun.bulletType = BulletType.BIG_TRIANGLE;
			bossBlinkGun.gunCooldown = 3;
			_bossBlink.guns.push(bossBlinkGun);
			_bossBlink.maxHealth = 600;
			_bossBlink.speed = 350;
			_bossBlink.collisionDamage = 400;
			_bossBlink.shipGraphic = _bossBlinkPng;
			_bossBlink.shipGraphicDimensions = new Point(116, 105);
			_bossBlink.movement = new TeleportingBoss(350);
			_bossBlink.shooting = new LeadingShot();
			_typeToBehavior[ShipBehaviorType.BOSS_BLINK] = _bossBlink;
			
			_bossFast = new ShipBehavior();
			_bossFast.affiliation = Affiliation.ENEMY;
			_bossFast.guns = new Vector.<GunUpgrade>();
			var bossFastGun:OffsetGun = new OffsetGun();
			bossFastGun.bulletType = BulletType.BIG_TRIANGLE;
			bossFastGun.gunCooldown = 0.6;
			_bossFast.guns.push(bossFastGun);
			var bossFastGun2:OffsetGun = new OffsetGun();
			bossFastGun2.bulletType = BulletType.BIG_TRIANGLE;
			bossFastGun2.gunCooldown = 0.6;
			bossFastGun2.angleOffset = Math.PI / 18;
			_bossFast.guns.push(bossFastGun2);
			var bossFastGun3:OffsetGun = new OffsetGun();
			bossFastGun3.bulletType = BulletType.BIG_TRIANGLE;
			bossFastGun3.gunCooldown = 0.6;
			bossFastGun3.angleOffset = -Math.PI / 18;
			_bossFast.guns.push(bossFastGun3);
			_bossFast.maxHealth = 600;
			_bossFast.speed = 850;
			_bossFast.collisionDamage = 400;
			_bossFast.shipGraphic = _bossFastPng;
			_bossFast.shipGraphicDimensions = new Point(129, 80);
			_bossFast.movement = new CircleAround(300);
			_bossFast.shooting = new TargetShot();
			_typeToBehavior[ShipBehaviorType.BOSS_FAST] = _bossFast;
			
			_bossSwarm = new ShipBehavior();
			_bossSwarm.affiliation = Affiliation.ENEMY;
			_bossSwarm.guns = new Vector.<GunUpgrade>();
			_bossSwarm.maxHealth = 1000;
			_bossSwarm.speed = 550;
			_bossSwarm.collisionDamage = 400;
			_bossSwarm.shipGraphic = _bossSwarmPng;
			_bossSwarm.shipGraphicDimensions = new Point(150, 140);
			_bossSwarm.movement = new SwarmBoss(450);
			_bossSwarm.shooting = new RandomShot();
			_typeToBehavior[ShipBehaviorType.BOSS_SWARM] = _bossSwarm;
		}
		
		public function getShipBehavior(type:ShipBehaviorType):ShipBehavior
		{
			return _typeToBehavior[type];
		}
		
	}

}