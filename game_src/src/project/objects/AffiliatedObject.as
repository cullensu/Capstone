package project.objects 
{
	import org.flixel.FlxSprite;
	import project.util.Affiliation;
	/**
	 * This object has an affiliation associated with it, see Affiliation.as
	 * @author Cullen
	 */
	public class AffiliatedObject extends FlxSprite
	{
		protected var _affiliation:Affiliation;
		
		public function AffiliatedObject(X:Number=0,Y:Number=0,SimpleGraphic:Class=null) 
		{
			super(X, Y, SimpleGraphic);
			_affiliation = Affiliation.NEUTRAL;
		}
		
		public function get affiliation():Affiliation 
		{
			return _affiliation;
		}
		
		public function set affiliation(value:Affiliation):void 
		{
			_affiliation = value;
		}
		
		
	}

}