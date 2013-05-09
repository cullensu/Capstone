package project.manager 
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxSound;
	/**
	 * ...
	 * @author jmlee337
	 */
	public class MusicManager extends FlxGroup
	{
		[Embed(source = "../../../assets/music/Bass.mp3")] private var _bassMp3:Class;
		[Embed(source = "../../../assets/music/Pad.mp3")] private var _padMp3:Class;
		[Embed(source = "../../../assets/music/Rhodes.mp3")] private var _rhodesMp3:Class;
		[Embed(source = "../../../assets/music/Strings.mp3")] private var _stringsMp3:Class;
		[Embed(source = "../../../assets/music/Synth.mp3")] private var _synthMp3:Class;
		
		protected var _bass:FlxSound;
		protected var _rhodes:FlxSound;
		protected var _pad:FlxSound;
		protected var _strings:FlxSound;
		protected var _synth:FlxSound;
		protected var _arr:Array;
		
		public function MusicManager() 
		{
			_bass = (new FlxSound()).loadEmbedded(_bassMp3, true, true);
			_pad = (new FlxSound()).loadEmbedded(_padMp3, true, true);
			_rhodes = (new FlxSound()).loadEmbedded(_rhodesMp3, true, true);
			_strings = (new FlxSound()).loadEmbedded(_stringsMp3, true, true);
			_synth = (new FlxSound()).loadEmbedded(_synthMp3, true, true);
			
			_arr = new Array(_pad, _rhodes, _bass, _synth, _strings);
			
			for each(var sound:FlxSound in _arr) {
				sound.volume = 0.0;
				add(sound);
				sound.play();
			}
		}
		
		public function setLevel(n:int):void
		{
			if (n >= _arr.length) {
				throw Error("Don't do that (Music Manager)");
			}
			
			for (var i:int = 0; i < _arr.length; i++)
			{
				var sound:FlxSound = _arr[i] as FlxSound;
				if (i <= n)
					sound.fadeIn(1);
				else
					sound.fadeOut(1);
			}
		}
	}

}