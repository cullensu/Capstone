package project.ship.behavior 
{
	import flash.events.AccelerometerEvent;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import project.bullet.BulletType;
	import project.constant.Constants;
	import project.constant.GameRegistry;
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
		[Embed(source = "../../../../assets/enemyfinalboss.png")] private var _bossFinalPng:Class;
		
		[Embed(source = "../../../../assets/minibosspartleft.png")] private var _bossPartLeftPng:Class;
		[Embed(source = "../../../../assets/minibosspartright.png")] private var _bossPartRightPng:Class;
		[Embed(source = "../../../../assets/minibossparttop.png")] private var _bossPartTopPng:Class;
		
		
		protected var _enemyNormal:ShipBehavior;
		protected var _enemyNormal2:ShipBehavior;
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
			reinitTypes();
		}
		
		public function reinitTypes():void
		{
			_enemyNormal = new ShipBehavior();
			_enemyNormal.affiliation = Affiliation.ENEMY;
			_enemyNormal.guns = new Vector.<GunUpgrade>();
			var normalGun:OffsetGun = new OffsetGun();
			normalGun.bulletType = BulletType.TRIANGLE;
			normalGun.gunCooldown = 1.2 - 0.3 * GameRegistry.gameState.miniBossManager.bossesDefeated;
			_enemyNormal.guns.push(normalGun);
			_enemyNormal.maxHealth = 40 + 15 * GameRegistry.gameState.miniBossManager.bossesDefeated;
			_enemyNormal.speed = 225 + 60 * GameRegistry.gameState.miniBossManager.bossesDefeated;
			_enemyNormal.collisionDamage = 10 + 4 * GameRegistry.gameState.miniBossManager.bossesDefeated;
			_enemyNormal.shipGraphic = _enemyNormalPng;
			_enemyNormal.shipGraphicDimensions = new Point(30, 28);
			_enemyNormal.movement = new CircleAround(175 - 10 * GameRegistry.gameState.miniBossManager.bossesDefeated);
			_enemyNormal.shooting = new RandomShot();
			_typeToBehavior[ShipBehaviorType.ENEMY_NORMAL] = _enemyNormal;
			
			_enemyNormal2 = new ShipBehavior();
			_enemyNormal2.affiliation = Affiliation.ENEMY;
			_enemyNormal2.guns = new Vector.<GunUpgrade>();
			_enemyNormal2.dropsHealthOnly = true;
			var normalGun2:OffsetGun = new OffsetGun();
			normalGun2.bulletType = BulletType.TRIANGLE;
			normalGun2.gunCooldown = 1.2 - 0.3 * GameRegistry.gameState.miniBossManager.bossesDefeated;
			_enemyNormal2.guns.push(normalGun2);
			_enemyNormal2.maxHealth = 40 + 15 * GameRegistry.gameState.miniBossManager.bossesDefeated;
			_enemyNormal2.speed = 225 + 60 * GameRegistry.gameState.miniBossManager.bossesDefeated;
			_enemyNormal2.collisionDamage = 10 + 4 * GameRegistry.gameState.miniBossManager.bossesDefeated;
			_enemyNormal2.shipGraphic = _enemyNormalPng;
			_enemyNormal2.shipGraphicDimensions = new Point(30, 28);
			_enemyNormal2.movement = new CircleAround(175 - 10 * GameRegistry.gameState.miniBossManager.bossesDefeated);
			_enemyNormal2.shooting = new RandomShot();
			_typeToBehavior[ShipBehaviorType.ENEMY_NORMAL_NO_UPGRADES] = _enemyNormal;
			
			_enemyMine = new ShipBehavior();
			_enemyMine.affiliation = Affiliation.ENEMY;
			_enemyMine.guns = new Vector.<GunUpgrade>();
			_enemyMine.hasLifeTime = true;
			_enemyMine.lifetime = 10;
			_enemyMine.maxHealth = 40 +15 * GameRegistry.gameState.miniBossManager.bossesDefeated;
			_enemyMine.speed = 0;
			_enemyMine.collisionDamage = 40 + 4 * GameRegistry.gameState.miniBossManager.bossesDefeated;
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
			turretGun.gunCooldown = 1.0 - 0.25 * GameRegistry.gameState.miniBossManager.bossesDefeated;
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
			_enemyTurret.speed = 225 + 80 * GameRegistry.gameState.miniBossManager.bossesDefeated;
			_enemyTurret.collisionDamage = 10 + 4 * GameRegistry.gameState.miniBossManager.bossesDefeated;
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
			_enemyFast.maxHealth = 20 + 20 * GameRegistry.gameState.miniBossManager.bossesDefeated;
			_enemyFast.speed = 375 + 75 * GameRegistry.gameState.miniBossManager.bossesDefeated;
			_enemyFast.collisionDamage = 10 + 4 * GameRegistry.gameState.miniBossManager.bossesDefeated;
			_enemyFast.shipGraphic = _enemyFastPng;
			_enemyFast.shipGraphicDimensions = new Point(26, 16);
			_enemyFast.movement = new SuicideWithTurnRadius(Math.PI / (6 + GameRegistry.gameState.miniBossManager.bossesDefeated));
			_enemyFast.shooting = new RandomShot(); //Needs this even though it doesn't have a gun to shoot
			_typeToBehavior[ShipBehaviorType.ENEMY_FAST] = _enemyFast;
			
			_enemyBig = new ShipBehavior();
			_enemyBig.affiliation = Affiliation.ENEMY;
			_enemyBig.guns = new Vector.<GunUpgrade>();
			var bigGun:OffsetGun = new OffsetGun();
			bigGun.bulletType = BulletType.BIG_TRIANGLE;
			bigGun.gunCooldown = 2.0 - 0.4 * GameRegistry.gameState.miniBossManager.bossesDefeated;
			_enemyBig.guns.push(bigGun);
			_enemyBig.maxHealth = 100 + 40 * GameRegistry.gameState.miniBossManager.bossesDefeated;
			_enemyBig.speed = 200 + 50 * GameRegistry.gameState.miniBossManager.bossesDefeated;
			_enemyBig.collisionDamage = 40 + 5 * GameRegistry.gameState.miniBossManager.bossesDefeated;
			_enemyBig.shipGraphic = _enemyBigPng;
			_enemyBig.shipGraphicDimensions = new Point(46, 17);
			_enemyBig.movement = new CircleAround(250);
			if (GameRegistry.gameState.miniBossManager.bossesDefeated > 0) {
				(_enemyBig.movement as CircleAround).randomlyReverse = true;
			}
			_enemyBig.shooting = new LeadingShot();
			_typeToBehavior[ShipBehaviorType.ENEMY_BIG] = _enemyBig;
			
			_bossBlink = new ShipBehavior();
			_bossBlink.affiliation = Affiliation.ENEMY;
			_bossBlink.guns = new Vector.<GunUpgrade>();
			var bossBlinkGun:OffsetGun = new OffsetGun();
			bossBlinkGun.bulletType = BulletType.BIG_TRIANGLE;
			bossBlinkGun.gunCooldown = 2.4 - 1 * GameRegistry.gameState.miniBossManager.bossesDefeated;
			_bossBlink.guns.push(bossBlinkGun);
			_bossBlink.maxHealth = 400 + 200 * GameRegistry.gameState.miniBossManager.bossesDefeated;
			_bossBlink.speed = 350 + 200 * GameRegistry.gameState.miniBossManager.bossesDefeated;
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
			bossFastGun.gunCooldown = 1.0 - 0.4 * GameRegistry.gameState.miniBossManager.bossesDefeated;
			_bossFast.guns.push(bossFastGun);
			var bossFastGun2:OffsetGun = new OffsetGun();
			bossFastGun2.bulletType = BulletType.BIG_TRIANGLE;
			bossFastGun2.gunCooldown = 1.0 - 0.4 * GameRegistry.gameState.miniBossManager.bossesDefeated;
			bossFastGun2.angleOffset = Math.PI / 18;
			_bossFast.guns.push(bossFastGun2);
			var bossFastGun3:OffsetGun = new OffsetGun();
			bossFastGun3.bulletType = BulletType.BIG_TRIANGLE;
			bossFastGun3.gunCooldown = 1.0 - 0.4 * GameRegistry.gameState.miniBossManager.bossesDefeated;
			bossFastGun3.angleOffset = -Math.PI / 18;
			_bossFast.guns.push(bossFastGun3);
			_bossFast.maxHealth = 300 + 150 * GameRegistry.gameState.miniBossManager.bossesDefeated;
			_bossFast.speed = 600 + 200 * GameRegistry.gameState.miniBossManager.bossesDefeated;
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
			_bossSwarm.maxHealth = 500 + 250 * GameRegistry.gameState.miniBossManager.bossesDefeated;
			_bossSwarm.speed = 550 + 200 * GameRegistry.gameState.miniBossManager.bossesDefeated;
			_bossSwarm.collisionDamage = 400;
			_bossSwarm.shipGraphic = _bossSwarmPng;
			_bossSwarm.shipGraphicDimensions = new Point(150, 140);
			_bossSwarm.movement = new SwarmBoss(450);
			if (GameRegistry.gameState.miniBossManager.bossesDefeated > 0) {
				(_bossSwarm.movement as SwarmBoss).randomlyReverse = true;
			}
			_bossSwarm.shooting = new RandomShot();
			_typeToBehavior[ShipBehaviorType.BOSS_SWARM] = _bossSwarm;
			
			_bossMine = new ShipBehavior();
			_bossMine.affiliation = Affiliation.ENEMY;
			_bossMine.guns = new Vector.<GunUpgrade>();
			_bossMine.maxHealth = 500 + 250 * GameRegistry.gameState.miniBossManager.bossesDefeated;
			_bossMine.speed = 450 + 200 * GameRegistry.gameState.miniBossManager.bossesDefeated;
			_bossMine.collisionDamage = 400;
			_bossMine.shipGraphic = _bossSwarmPng;
			_bossMine.shipGraphicDimensions = new Point(150, 140);
			var bossMineMove:SwarmBoss = new SwarmBoss(250);
			bossMineMove.randomlyReverse = true;
			bossMineMove.spawnDelay = 1.5 - 0.5 * GameRegistry.gameState.miniBossManager.bossesDefeated;
			bossMineMove.spawnDelayVariance = 0.5 - 0.2 * GameRegistry.gameState.miniBossManager.bossesDefeated;
			bossMineMove.spawnType = ShipBehaviorType.ENEMY_TURRET;
			_bossMine.movement = bossMineMove;
			_bossMine.shooting = new RandomShot();
			_typeToBehavior[ShipBehaviorType.BOSS_MINE] = _bossMine;
			
			_bossFinal = new ShipBehavior();
			_bossFinal.affiliation = Affiliation.ENEMY;
			_bossFinal.guns = new Vector.<GunUpgrade>();
			var bossFinalGun1:OffsetGun = new OffsetGun();
			bossFinalGun1.bulletType = BulletType.BIG_TRIANGLE;
			bossFinalGun1.gunCooldown = 0.3;
			_bossFinal.guns.push(bossFinalGun1);
			var bossFinalGun2:OffsetGun = new OffsetGun();
			bossFinalGun2.bulletType = BulletType.BIG_TRIANGLE;
			bossFinalGun2.gunCooldown = 0.3;
			bossFinalGun2.angleOffset = Math.PI / 18;
			_bossFinal.guns.push(bossFinalGun2);
			var bossFinalGun3:OffsetGun = new OffsetGun();
			bossFinalGun3.bulletType = BulletType.BIG_TRIANGLE;
			bossFinalGun3.gunCooldown = 0.3;
			bossFinalGun3.angleOffset = -Math.PI / 18;
			_bossFinal.guns.push(bossFinalGun3);
			var bossFinalGun4:OffsetGun = new OffsetGun();
			bossFinalGun4.bulletType = BulletType.BIG_TRIANGLE;
			bossFinalGun4.gunCooldown = 0.3;
			bossFinalGun4.angleOffset = Math.PI / 9;
			_bossFinal.guns.push(bossFinalGun4);
			var bossFinalGun5:OffsetGun = new OffsetGun();
			bossFinalGun5.bulletType = BulletType.BIG_TRIANGLE;
			bossFinalGun5.gunCooldown = 0.3;
			bossFinalGun5.angleOffset = -Math.PI / 9;
			_bossFinal.guns.push(bossFinalGun5);
			_bossFinal.maxHealth = 2000;
			_bossFinal.speed = 600;
			_bossFinal.collisionDamage = 400;
			_bossFinal.shipGraphic = _bossFinalPng;
			_bossFinal.shipGraphicDimensions = new Point(450, 419);
			var bossFinalMove:SwarmBoss = new SwarmBoss(400);
			bossFinalMove.randomlyReverse = true;
			bossFinalMove.spawnDelay = 0.5;
			bossFinalMove.spawnDelayVariance = 0.1;
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