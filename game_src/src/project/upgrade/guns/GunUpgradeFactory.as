package project.upgrade.guns
{
	import project.bullet.BulletType;
	import project.upgrade.GunUpgrade;
	import project.util.Utility;
	/**
	 * ...
	 * @author akirilov
	 */
	public class GunUpgradeFactory 
	{
		private var tier1:Vector.<Vector.<GunBlueprint>>;
		private var tier2:Vector.<Vector.<GunBlueprint>>;
		private var tier3:Vector.<Vector.<GunBlueprint>>;
		private var tier4:Vector.<Vector.<GunBlueprint>>;
		
		private var tiers:Array;
		
		public function GunUpgradeFactory() 
		{
			tier1 = new Vector.<Vector.<GunBlueprint>>();
			tier2 = new Vector.<Vector.<GunBlueprint>>();
			tier3 = new Vector.<Vector.<GunBlueprint>>();
			tier4 = new Vector.<Vector.<GunBlueprint>>();
			
			tiers = [null, tier1, tier2, tier3, tier4];
			// ### TIER 1 ###
			var twoSpread:Vector.<GunBlueprint> = new Vector.<GunBlueprint>();
			twoSpread.push(new GunBlueprint(Math.PI / 36, BulletType.BIG_CIRCLE));
			twoSpread.push(new GunBlueprint( -1 * Math.PI / 36, BulletType.BIG_CIRCLE));
			
			tier1.push(twoSpread);
			
			// ### TIER 2 ###
			var threeSpread:Vector.<GunBlueprint> = new Vector.<GunBlueprint>();
			threeSpread.push(new GunBlueprint(0, BulletType.BIG_CIRCLE));
			threeSpread.push(new GunBlueprint(Math.PI / 18, BulletType.BIG_CIRCLE));
			threeSpread.push(new GunBlueprint( -1 * Math.PI / 18, BulletType.BIG_CIRCLE));
			
			tier2.push(threeSpread);
			
			// ### TIER 3 ###
			var fourSpread:Vector.<GunBlueprint> = new Vector.<GunBlueprint>();
			fourSpread.push(new GunBlueprint(Math.PI / 36, BulletType.BIG_CIRCLE));
			fourSpread.push(new GunBlueprint(Math.PI / 12, BulletType.BIG_CIRCLE));
			fourSpread.push(new GunBlueprint( -1 * Math.PI / 36, BulletType.BIG_CIRCLE));
			fourSpread.push(new GunBlueprint( -1 * Math.PI / 12, BulletType.BIG_CIRCLE));
			
			tier3.push(fourSpread);
			
			// ### TIER 4 ###
			var fiveSpread:Vector.<GunBlueprint> = new Vector.<GunBlueprint>();
			fiveSpread.push(new GunBlueprint(0, BulletType.BIG_CIRCLE));
			fiveSpread.push(new GunBlueprint(Math.PI / 18, BulletType.BIG_CIRCLE));
			fiveSpread.push(new GunBlueprint(Math.PI / 9, BulletType.BIG_CIRCLE));
			fiveSpread.push(new GunBlueprint( -1 * Math.PI / 18, BulletType.BIG_CIRCLE));
			fiveSpread.push(new GunBlueprint( -1 * Math.PI / 9, BulletType.BIG_CIRCLE));
			
			tier4.push(fiveSpread);
		}
		
		public function getGunUpgrade(tier:int):Vector.<GunUpgrade>
		{
			var tierList:Vector.<Vector.<GunBlueprint>> = tiers[tier];
			
			var index:int = Utility.randomInt(tierList.length);
			var blueprints:Vector.<GunBlueprint> = tierList[index];
			return makeGunVector(blueprints);
		}
		
		private function makeGunVector(blueprints:Vector.<GunBlueprint>):Vector.<GunUpgrade>
		{
			var guns:Vector.<GunUpgrade> = new Vector.<GunUpgrade>();
			for each (var bp:GunBlueprint in blueprints)
			{
				guns.push(makeGun(bp));
			}
			return guns;
		}
		
		private function makeGun(blueprint:GunBlueprint):GunUpgrade
		{
			var gun:OffsetGun = new OffsetGun();
			gun.angleOffset = blueprint.angleOffset;
			gun.bulletType = blueprint.bulletType;
			return gun;
		}
	}
}