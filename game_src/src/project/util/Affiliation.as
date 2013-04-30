package project.util 
{
	import project.enum.Enum;
	/**
	 * ...
	 * @author Cullen
	 */
	public final class Affiliation extends Enum
	{
		{initEnum(Affiliation); } // static ctor
		
		public static const PLAYER:Affiliation = new Affiliation();
		public static const ENEMY:Affiliation = new Affiliation();
		public static const NEUTRAL:Affiliation = new Affiliation();
		
		protected static var _friendly:Vector.<Affiliation>;
		
		public static function addAlly(ally:Affiliation):void
		{
			if (isAlly(ally))
			{
				_friendly.push(ally);
			}
		}
		
		public static function removeAlly(ally:Affiliation):void
		{
			if (isAlly(ally))
			{
				_friendly.splice(_friendly.indexOf(ally), 1);
			}
		}
		
		public static function isAlly(aff:Affiliation):Boolean
		{
			return _friendly.indexOf(aff) >= 0;
		}
		
		
	}

}