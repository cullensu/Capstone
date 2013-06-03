package project.ship.behavior 
{
	import flash.events.AccelerometerEvent;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import project.bullet.BulletType;
	import project.constant.Constants;
	import project.ship.behavior.move.CircleAround;
	import project.ship.behavior.move.NoMove;
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
		[Embed(source = "../../../../assets/enemymine.png")] private var _enemyMinePng:Class;
		
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
		protected var _enemyMine:ShipBehavior;
		protected var _enemyTurret:ShipBehavior;
		
		protected var _bossBlink:ShipBehavior;
		protected var _bossFast:ShipBehavior;
		protected var _bossHoming:ShipBehavior;
		protected var _bossSwarm:ShipBehavior;
		protected var _bossMine:ShipBehavior;
		protected var _bossFinal:ShipBehavior;
		
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
			
			_enemyMine = new ShipBehavior();
			_enemyMine.affiliation = Affiliation.ENEMY;
			_enemyMine.guns = new Vector.<GunUpgrade>();
			_enemyMine.hasLifeTime = true;
			_enemyMine.lifetime = 10;
			_enemyMine.maxHealth = 40;
			_enemyMine.speed = 0;
			_enemyMine.collisionDamage = 40;
			_enemyMine.shipGraphic = _enemyMinePng;
			_enemyMine.shipGraphicDimensions = new Point(13, 11);
			_enemyMine.movement = new NoMove();
			_enemyMine.shooting = new RandomShot();
			_typeToBehavior[ShipBehaviorType.ENEMY_MINE] = _enemyMine;
			
			_enemyTurret = new ShipBehavior();
			_enemyTurret.affiliation = Affiliation.ENEMY;
			_enemyTurret.guns = new Vector.<GunUpgrade>();
			var turretGun:OffsetGun = new OffsetGun();
			turretGun.bulletType = BulletType.TRIANGLE;
			turretGun.gunCooldown = 1.0;
			_enemyTurret.guns.push(turretGun);
			//var turretGun2:OffsetGun = new OffsetGun();
			//turretGun2.angleOffset = Math.PI / 18;
			//turretGun2.bulletType = BulletType.TRIANGLE;
			//turretGun2.gunCooldown = 2.0;
			//_enemyTurret.guns.push(turretGun2);
			//var turretGun3:OffsetGun = new OffsetGun();
			//turretGun3.angleOffset = -Math.PI / 18;
			//turretGun3.bulletType = BulletType.TRIANGLE;
			//turretGun3.gunCooldown = 2.0;
			//_enemyTurret.guns.push(turretGun3);
			_enemyTurret.hasLifeTime = true;
			_enemyTurret.lifetime = 6;
			_enemyTurret.maxHealth = 1;
			_enemyTurret.speed = 225;
			_enemyTurret.collisionDamage = 10;
			_enemyTurret.dropsHealthOnly = true;
			_enemyTurret.upgradeDropRate = 0.5;
			_enemyTurret.shipGraphic = _enemyMinePng;
			_enemyTurret.shipGraphicDimensions = new Point(13, 11);
			_enemyTurret.movement = new NoMove();
			_enemyTurret.shooting = new TargetShot();
			_typeToBehavior[ShipBehaviorType.ENEMY_TURRET] = _enemyTurret;
			
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
			_bossBlink.maxHealth = 300;
			_bossBlink.speed = 350;
			_bossBlink.collisionDamage = 400;
			_bossBlink.shipGraphic = _bossBlinkPng;
			_bossBlink.shipGraphicDimensions = new Point(116, 105);
			var bossBlinkMove:TeleportingBoss = new TeleportingBoss(300);
			bossBlinkMove.randomlyReverse = true;
			_bossBlink.movement = bossBlinkMove;
			_bossBlink.shooting = new LeadingShot();
			_bossBlink.animations = 2;
			_bossBlink.animationNames = new Array("out", "in");
			_bossBlink.animationFrames = new Array(new Array(0, 1, 2), new Array(2, 1, 0));
			_bossBlink.animationLoops = new Array(false, false);
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
			_bossFast.maxHealth = 300;
			_bossFast.speed = 850;
			_bossFast.collisionDamage = 400;
			_bossFast.shipGraphic = _bossFastPng;
			_bossFast.shipGraphicDimensions = new Point(129, 80);
			var bossFastMove:CircleAround = new CircleAround(300);
			bossFastMove.randomlyReverse = true;
			_bossFast.movement = bossFastMove;
			_bossFast.shooting = new TargetShot();
			_typeToBehavior[ShipBehaviorType.BOSS_FAST] = _bossFast;
			
			_bossSwarm = new ShipBehavior();
			_bossSwarm.affiliation = Affiliation.ENEMY;
			_bossSwarm.guns = new Vector.<GunUpgrade>();
			_bossSwarm.maxHealth = 500;
			_bossSwarm.speed = 550;
			_bossSwarm.collisionDamage = 400;
			_bossSwarm.shipGraphic = _bossSwarmPng;
			_bossSwarm.shipGraphicDimensions = new Point(150, 140);
			_bossSwarm.movement = new SwarmBoss(450);
			_bossSwarm.shooting = new RandomShot();
			_typeToBehavior[ShipBehaviorType.BOSS_SWARM] = _bossSwarm;
			
			_bossMine = new ShipBehavior();
			_bossMine.affiliation = Affiliation.ENEMY;
			_bossMine.guns = new Vector.<GunUpgrade>();
			_bossMine.maxHealth = 500;
			_bossMine.speed = 550;
			_bossMine.collisionDamage = 400;
			_bossMine.shipGraphic = _bossSwarmPng;
			_bossMine.shipGraphicDimensions = new Point(150, 140);
			var bossMineMove:SwarmBoss = new SwarmBoss(250);
			bossMineMove.randomlyReverse = true;
			bossMineMove.spawnDelay = 1.5;
			bossMineMove.spawnDelayVariance = 0.5;
			bossMineMove.spawnType = ShipBehaviorType.ENEMY_TURRET;
			_bossMine.movement = bossMineMove;
			_bossMine.shooting = new RandomShot();
			_typeToBehavior[ShipBehaviorType.BOSS_MINE] = _bossMine;
			
			_bossFinal = new ShipBehavior();
			_bossFinal.affiliation = Affiliation.ENEMY;
			_bossFinal.guns = new Vector.<GunUpgrade>();
			var bossFinalGun1:OffsetGun = new OffsetGun();
			bossFinalGun1.bulletType = BulletType.BIG_TRIANGLE;
			bossFinalGun1.gunCooldown = 0.6;
			_bossFinal.guns.push(bossFinalGun1);
			var bossFinalGun2:OffsetGun = new OffsetGun();
			bossFinalGun2.bulletType = BulletType.BIG_TRIANGLE;
			bossFinalGun2.gunCooldown = 0.6;
			bossFinalGun2.angleOffset = Math.PI / 18;
			_bossFinal.guns.push(bossFinalGun2);
			var bossFinalGun3:OffsetGun = new OffsetGun();
			bossFinalGun3.bulletType = BulletType.BIG_TRIANGLE;
			bossFinalGun3.gunCooldown = 0.6;
			bossFinalGun3.angleOffset = -Math.PI / 18;
			_bossFinal.guns.push(bossFinalGun3);
			var bossFinalGun4:OffsetGun = new OffsetGun();
			bossFinalGun4.bulletType = BulletType.BIG_TRIANGLE;
			bossFinalGun4.gunCooldown = 0.6;
			bossFinalGun4.angleOffset = Math.PI / 9;
			_bossFinal.guns.push(bossFinalGun4);
			var bossFinalGun5:OffsetGun = new OffsetGun();
			bossFinalGun5.bulletType = BulletType.BIG_TRIANGLE;
			bossFinalGun5.gunCooldown = 0.6;
			bossFinalGun5.angleOffset = -Math.PI / 9;
			_bossFinal.guns.push(bossFinalGun5);
			_bossFinal.maxHealth = 1500;
			_bossFinal.speed = 500;
			_bossFinal.collisionDamage = 400;
			_bossFinal.shipGraphic = _bossSwarmPng;
			_bossFinal.shipGraphicDimensions = new Point(150, 140);
			var bossFinalMove:SwarmBoss = new SwarmBoss(250);
			bossFinalMove.randomlyReverse = true;
			bossFinalMove.spawnDelay = 1.0;
			bossFinalMove.spawnDelayVariance = 0.25;
			bossFinalMove.spawnType = ShipBehaviorType.ENEMY_TURRET;
			_bossFinal.movement = bossFinalMove;
			_bossFinal.shooting = new LeadingShot();
			_typeToBehavior[ShipBehaviorType.BOSS_FINAL] = _bossFinal;
		}
		
		public function getShipBehavior(type:ShipBehaviorType):ShipBehavior
		{
			return _typeToBehavior[type];
		}
		
	}

}